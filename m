Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8163B218
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 20:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiK1TUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 14:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiK1TUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:20:09 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3B2BC7;
        Mon, 28 Nov 2022 11:20:08 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ASJJvvC006571
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 14:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669663200; bh=7iGuKVNfYY+dAeexMioZbuIssoUNjOCv35LnADeX+BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HH6W4ulUkWzdY5Q3eBBHT+01I0wvrocYLx8lIsM7id9GwtfpUboSnCne0LRjXzKRm
         4H4H9nLTcCsfTPek6+x2L2THYCcotZ42+2yVhrabGS/xYYo2qqGAEYXtvu9MbCVFUU
         nqUMorWdkhrDVxzGk1gmtjO9tJ8cZVbAVQ20qDQqMwx8vQjNvy8V6KX2YQjxs2agB+
         nXroKS2wGop2xqsTmaW7r6AI/IhQ3jx55eq072IuEeyUs8e2ihnWeFPMgMZnzi5LQE
         LceQMeD+qMesuYogTrpluXGNuZLpiq1SUkdVqwxkEgH0iv4oKAlPNAfy/RH/eIh2nY
         thxzhvBaFtv4Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3085115C3A9A; Mon, 28 Nov 2022 14:19:57 -0500 (EST)
Date:   Mon, 28 Nov 2022 14:19:57 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        Svyatoslav Feldsherov <feldsherov@google.com>,
        syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: do not update freeing inode i_io_list
Message-ID: <Y4UJ3f7FcCTTq7q3@mit.edu>
References: <20221115202001.324188-1-feldsherov@google.com>
 <20221116111539.i7xi7is7rn62prf5@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116111539.i7xi7is7rn62prf5@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:15:39PM +0100, Jan Kara wrote:
> On Tue 15-11-22 20:20:01, Svyatoslav Feldsherov wrote:
> > After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
> > already has I_DIRTY_INODE") writeback_single_inode can push inode with
> > I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
> > I_DIRTY_TIME set this can happen after deletion of inode from i_io_list
> > at evict. Stack trace is following.
> > 
> > evict
> > fat_evict_inode
> > fat_truncate_blocks
> > fat_flush_inodes
> > writeback_inode
> > sync_inode_metadata(inode, sync=0)
> > writeback_single_inode(inode, wbc) <- wbc->sync_mode == WB_SYNC_NONE
> > 
> > This will lead to use after free in flusher thread.
> > 
> > Similar issue can be triggered if writeback_single_inode in the
> > stack trace update inode->i_io_list. Add explicit check to avoid it.
> > 
> > Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
> > Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>
> 
> Ted, I guess you will merge this patch since you've merged the one from
> Lukas this patch is fixing?

Sorry, I forgot to ack this earlier, but this was pushed to Linus and
it's in 6.1-rc7.

					- Ted
