Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21995A4F9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiH2OuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiH2OuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB114092;
        Mon, 29 Aug 2022 07:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D5D6105C;
        Mon, 29 Aug 2022 14:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59DFC433C1;
        Mon, 29 Aug 2022 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661784596;
        bh=1uMmTJeyaDS2FOf4VxouNCYbBnfhrN1z1KkQuy5uQj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJRk6ZYCgSQvvWk8URrx6RJ6oV82AYJwt+/EXnZk3l9CBPJ1Cc2cedvM8lnX84VDB
         JPlPDOjLBdofy4r6FWjvZLx722neGH/E0/siqa7H3FceqTWWN7D8FI4hRLz4No/Lg7
         l8khPwDyO2GZCZvZIxG0f7Y7IYPhAR+5whqJKxJMS5hDjDCTn2L6pnlpEGNjSBX0ki
         9lJMaYfTbyEf/qfFveknlmINrEGiDzXz79bsGnwcBpEyAqoWMQeAnxu/8QsQKnGeiR
         K0kq4SsC3S6NSrIXu0iUEUkxhRr80OyMR1pJSXmJmXKAtu/w5X4yKHZi3wjw13ANvE
         V5+ip6haOfpfA==
Date:   Mon, 29 Aug 2022 07:49:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: Re: [PATCH v7] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <YwzSE2U8iYLRfyxf@magnolia>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <63093cbd43f67_259e5b2946d@dwillia2-xfh.jf.intel.com.notmuch>
 <72fa9657-741a-e099-baf8-4615145d7bd1@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72fa9657-741a-e099-baf8-4615145d7bd1@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:02:11PM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2022/8/27 5:35, Dan Williams 写道:
> > Shiyang Ruan wrote:
> > > This patch is inspired by Dan's "mm, dax, pmem: Introduce
> > > dev_pagemap_failure()"[1].  With the help of dax_holder and
> > > ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> > > (or mapped device) on it to unmap all files in use and notify processes
> > > who are using those files.
> > > 
> > > Call trace:
> > > trigger unbind
> > >    -> unbind_store()
> > >     -> ... (skip)
> > >      -> devres_release_all()
> > >       -> kill_dax()
> > >        -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
> > >         -> xfs_dax_notify_failure()
> > > 
> > > Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> > > event.  So do not shutdown filesystem directly if something not
> > > supported, or if failure range includes metadata area.  Make sure all
> > > files and processes are handled correctly.
> > > 
> > > ==
> > > Changes since v6:
> > >     1. Rebase on 6.0-rc2 and Darrick's patch[2].
> > > 
> > > Changes since v5:
> > >     1. Renamed MF_MEM_REMOVE to MF_MEM_PRE_REMOVE
> > >     2. hold s_umount before sync_filesystem()
> > >     3. do sync_filesystem() after SB_BORN check
> > >     4. Rebased on next-20220714
> > > 
> > > [1]:
> > > https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > [2]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >    drivers/dax/super.c         |  3 ++-
> > >    fs/xfs/xfs_notify_failure.c | 15 +++++++++++++++
> > >    include/linux/mm.h          |  1 +
> > >    3 files changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > > index 9b5e2a5eb0ae..cf9a64563fbe 100644
> > > --- a/drivers/dax/super.c
> > > +++ b/drivers/dax/super.c
> > > @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
> > >    		return;
> > >     	if (dax_dev->holder_data != NULL)
> > > -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> > > +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
> > > +				MF_MEM_PRE_REMOVE);
> > >     	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> > >    	synchronize_srcu(&dax_srcu);
> > > diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> > > index 65d5eb20878e..a9769f17e998 100644
> > > --- a/fs/xfs/xfs_notify_failure.c
> > > +++ b/fs/xfs/xfs_notify_failure.c
> > > @@ -77,6 +77,9 @@ xfs_dax_failure_fn(
> > >     	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> > >    	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> > > +		/* Do not shutdown so early when device is to be removed */
> > > +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> > > +			return 0;
> > >    		notify->want_shutdown = true;
> > >    		return 0;
> > >    	}
> > > @@ -182,12 +185,22 @@ xfs_dax_notify_failure(
> > >    	struct xfs_mount	*mp = dax_holder(dax_dev);
> > >    	u64			ddev_start;
> > >    	u64			ddev_end;
> > > +	int			error;
> > >     	if (!(mp->m_sb.sb_flags & SB_BORN)) {
> > 
> > How are you testing the SB_BORN interactions? I have a fix for this
> > pending here:
> > 
> > https://lore.kernel.org/nvdimm/166153428094.2758201.7936572520826540019.stgit@dwillia2-xfh.jf.intel.com/
> 
> That was my mistake.  Yes, it should be mp->m_super->s_flags.
> 
> (I remember my testcase did pass in my dev version, but now that seems
> impossible.  I think something was wrong when I did the test.)
> 
> > 
> > >    		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
> > >    		return -EIO;
> > >    	}
> > >    +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> > 
> > It appears this patch is corrupted here. I confirmed that b4 sees the
> > same when trying to apply it.
> 
> Can't this patch be applied?  It is based on 6.0-rc2 + Darrick's patch. It's
> also ok to rebase on 6.0-rc3 + Darrick's patch.
> 
> > 
> > > +		xfs_info(mp, "device is about to be removed!");
> > > +		down_write(&mp->m_super->s_umount);
> > > +		error = sync_filesystem(mp->m_super);
> > 
> > This syncs to make data persistent, but for DAX this also needs to get
> > invalidate all current DAX mappings. I do not see that in these changes.
> 
> I'll add it.

Are you guys going to pick up [1]?

--D

[1] https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/

> 
> --
> Thanks,
> Ruan.
> 
> > 
> > > +		up_write(&mp->m_super->s_umount);
> > > +		if (error)
> > > +			return error;
> > > +	}
> > > +
> > >    	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
> > >    		xfs_warn(mp,
> > >    			 "notify_failure() not supported on realtime device!");
> > > @@ -196,6 +209,8 @@ xfs_dax_notify_failure(
> > >     	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
> > >    	    mp->m_logdev_targp != mp->m_ddev_targp) {
> > > +		if (mf_flags & MF_MEM_PRE_REMOVE)
> > > +			return 0;
> > >    		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
> > >    		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> > >    		return -EFSCORRUPTED;
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 982f2607180b..2c7c132e6512 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -3176,6 +3176,7 @@ enum mf_flags {
> > >    	MF_UNPOISON = 1 << 4,
> > >    	MF_SW_SIMULATED = 1 << 5,
> > >    	MF_NO_RETRY = 1 << 6,
> > > +	MF_MEM_PRE_REMOVE = 1 << 7,
> > >    };
> > >    int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> > >    		      unsigned long count, int mf_flags);
> > > -- 
> > > 2.37.2
> > > 
> > > 
> > 
> > 
