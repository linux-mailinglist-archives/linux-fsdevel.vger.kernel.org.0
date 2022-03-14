Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4294D8099
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 12:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiCNL0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiCNL0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A3C3B029;
        Mon, 14 Mar 2022 04:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD5F60F90;
        Mon, 14 Mar 2022 11:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D21C340E9;
        Mon, 14 Mar 2022 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647257123;
        bh=SiP4Qn2jTFv6RByEUSvXD5ODclyZr9Ye1fB0nauJE9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTq4YS+/kdeLb9sfvgSO+mfansL4Mxq+qR1ZcJBTNqqOqg+mIm1bHTv31a3/t94CY
         GbTde97QOhozBEM2PqvsfbHAnL0Y/IX4h/9uaVj6aEGSjtEwl0orobP2JrP6v5e2RJ
         /WSrO1ISmOkoLMTyWEBHLStmBCXFT1oUk6g7XH3kSANQuqSxEr7AH9w2e0v/ZIEfMg
         yhwmoe4N2oOMMNh/Ez6MDhp3OH7RiliADZemorsRGQRjb/hVEqb47Yc5PsAHF13VN1
         C3hKXhX8pK0/CECnJ3mN4zDbmEtzov5rszzJkgAqAWc0tNel14Ju/PL3LAr567bYWz
         V4QZ2YDqsaUmA==
Date:   Mon, 14 Mar 2022 11:25:20 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH 1/4] btrfs: mark resumed async balance as writing
Message-ID: <Yi8mIFooTUybN+l0@debian9.Home>
References: <cover.1646983176.git.naohiro.aota@wdc.com>
 <65730df62341500bfcbde7d86eeaa3e9b15f1bcb.1646983176.git.naohiro.aota@wdc.com>
 <YitX5fpZcC/P70o6@debian9.Home>
 <20220314022922.e4k5wxob6rqjw3aw@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314022922.e4k5wxob6rqjw3aw@naota-xeon>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 14, 2022 at 02:29:22AM +0000, Naohiro Aota wrote:
> On Fri, Mar 11, 2022 at 02:08:37PM +0000, Filipe Manana wrote:
> > On Fri, Mar 11, 2022 at 04:38:02PM +0900, Naohiro Aota wrote:
> > > When btrfs balance is interrupted with umount, the background balance
> > > resumes on the next mount. There is a potential deadlock with FS freezing
> > > here like as described in commit 26559780b953 ("btrfs: zoned: mark
> > > relocation as writing").
> > > 
> > > Mark the process as sb_writing. To preserve the order of sb_start_write()
> > > (or mnt_want_write_file()) and btrfs_exclop_start(), call sb_start_write()
> > > at btrfs_resume_balance_async() before taking fs_info->super_lock.
> > > 
> > > Fixes: 5accdf82ba25 ("fs: Improve filesystem freezing handling")
> > 
> > This seems odd to me. I read the note you left on the cover letter about
> > this, but honestly I don't think it's fair to blame that commit. I see
> > it more as btrfs specific problem.
> 
> Yeah, I was really not sure how I should write the tag. The issue is
> we missed to add sb_start_write() after this commit.
> 
> > Plus it's a 10 years old commit, so instead of the Fixes tag, adding a
> > minimal kernel version to the CC stable tag below makes more sense.
> 
> So, only with "Cc: stable@vger.kernel.org # 3.6+" ?

Looking at kernel.org the oldest stable kernel is 4.9, so anything older
than that is pointless.

> 
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  fs/btrfs/volumes.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index 1be7cb2f955f..0d27d8d35c7a 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -4443,6 +4443,7 @@ static int balance_kthread(void *data)
> > >  	if (fs_info->balance_ctl)
> > >  		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
> > >  	mutex_unlock(&fs_info->balance_mutex);
> > > +	sb_end_write(fs_info->sb);
> > >  
> > >  	return ret;
> > >  }
> > > @@ -4463,6 +4464,7 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
> > >  		return 0;
> > >  	}
> > >  
> > > +	sb_start_write(fs_info->sb);
> > 
> > I don't understand this.
> > 
> > We are doing the sb_start_write() here, in the task doing the mount, and then
> > we do the sb_end_write() at the kthread that runs balance_kthread().
> 
> Oops, I made a mistake here. It actually printed the lockdep warning
> "lock held when returning to user space!".
> 
> > Why not do the sb_start_write() in the kthread?
> > 
> > This is also buggy in the case the call below to kthread_run() fails, as
> > we end up never calling sb_end_write().
> 
> I was trying to preserve the lock taking order: sb_start_write() ->
> spin_lock(fs_info->super_lock). But, it might not be a big deal as
> long as we don't call sb_start_write() in the super_lock.
> 
> > Thanks.
> > 
> > >  	spin_lock(&fs_info->super_lock);
> > >  	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
> > >  	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
> > > -- 
> > > 2.35.1
> > > 
