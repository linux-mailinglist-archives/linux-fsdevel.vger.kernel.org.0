Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1027276A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 07:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjFHFYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 01:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFHFYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:24:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046E19BB;
        Wed,  7 Jun 2023 22:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TAToDUDNkDv9IczpCmb/lZuUNudXd2337IGGKs29GdU=; b=GLYbEwiWDCkN0dnekXl4I6rAbo
        Bz6rtz+j9PJBAxVFa5vffG5cKmDi66AFTFjrmX+bkiqNdBQWq042B0mmmiKseWgVf9n8w6RVjzADJ
        aVz+FRTsneH9T6Yh78Orry4a+bYOKAwCXr0xrIduraYREJxuQAogGvoAQoVW0OA2I5QOdD2BeIxrA
        gQbFQNyiEzS97S0h6f5Zp1tFFvYxVMXqmCaKFB2Mt+Zhc6QGjc2/3eMZHADRQT8A/zfRDkAvLpAq4
        nGSRSPIj9Wf3IQOJCnANqut7mIGgEcHqvuRZgrI+NU1D181Lrn2v6bBqiIIzuw5KwNTQtUBLZgmvM
        th5uSwtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q788P-0088oB-08;
        Thu, 08 Jun 2023 05:24:33 +0000
Date:   Wed, 7 Jun 2023 22:24:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        sandeen@sandeen.net, song@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        jikos@kernel.org, bvanassche@acm.org, ebiederm@xmission.com,
        mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <ZIFmEGdJ4CCbS1B3@infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522234200.GC11598@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 04:42:00PM -0700, Darrick J. Wong wrote:
> How about this as an alternative patch?  Kernel and userspace freeze
> state are stored in s_writers; each type cannot block the other (though
> you still can't have nested kernel or userspace freezes); and the freeze
> is maintained until /both/ freeze types are dropped.
> 
> AFAICT this should work for the two other usecases (quiescing pagefaults
> for fsdax pmem pre-removal; and freezing fses during suspend) besides
> online fsck for xfs.

I think this is fundamentally the right thing.  Can you send this as
a standalone thread in a separate thread to make it sure it gets
expedited?

> -static int thaw_super_locked(struct super_block *sb);
> +static int thaw_super_locked(struct super_block *sb, unsigned short who);

Is the unsigned short really worth it?  Even if it's just two values
I'd also go for a __bitwise type to get the typechecking as that tends
to help a lot goind down the road.

>  /**
> - * freeze_super - lock the filesystem and force it into a consistent state
> + * __freeze_super - lock the filesystem and force it into a consistent state
>   * @sb: the super to lock
> + * @who: FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs;
> + * FREEZE_HOLDER_KERNEL if the kernel wants to freeze it
>   *
>   * Syncs the super to make sure the filesystem is consistent and calls the fs's
> - * freeze_fs.  Subsequent calls to this without first thawing the fs will return
> + * freeze_fs.  Subsequent calls to this without first thawing the fs may return
>   * -EBUSY.
>   *
> + * The @who argument distinguishes between the kernel and userspace trying to
> + * freeze the filesystem.  Although there cannot be multiple kernel freezes or
> + * multiple userspace freezes in effect at any given time, the kernel and
> + * userspace can both hold a filesystem frozen.  The filesystem remains frozen
> + * until there are no kernel or userspace freezes in effect.
> + *
>   * During this function, sb->s_writers.frozen goes through these values:
>   *
>   * SB_UNFROZEN: File system is normal, all writes progress as usual.
> @@ -1668,12 +1676,61 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
>   *
>   * sb->s_writers.frozen is protected by sb->s_umount.
>   */

There's really no point in having a kerneldoc for a static function.
Either this moves to the actual exported functions, or it should
become a normal non-kerneldoc comment.  But I'm not even sre this split
makes much sense to start with.  I'd just add a the who argument
to freeze_super given that we have only very few callers anyway,
and it is way easier to follow than thse rappers hardoding the argument.

> +static int __freeze_super(struct super_block *sb, unsigned short who)
>  {
> +	struct sb_writers *sbw = &sb->s_writers;
>  	int ret;
>  
>  	atomic_inc(&sb->s_active);
>  	down_write(&sb->s_umount);
> +
> +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> +		switch (who) {

Nit, but maybe split evetything inside this branch into a
freeze_frozen_super helper?

> +static int thaw_super_locked(struct super_block *sb, unsigned short who)
> +{
> +	struct sb_writers *sbw = &sb->s_writers;
>  	int error;
>  
> +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> +		switch (who) {
> +		case FREEZE_HOLDER_KERNEL:
> +			if (!(sbw->freeze_holders & FREEZE_HOLDER_KERNEL)) {
> +				/* Caller doesn't hold a kernel freeze. */
> +				up_write(&sb->s_umount);
> +				return -EINVAL;
> +			}
> +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> +				/*
> +				 * We were sharing the freeze with userspace,
> +				 * so drop the userspace freeze but exit
> +				 * without unfreezing.
> +				 */
> +				sbw->freeze_holders &= ~who;
> +				up_write(&sb->s_umount);
> +				return 0;
> +			}
> +			break;
> +		case FREEZE_HOLDER_USERSPACE:
> +			if (!(sbw->freeze_holders & FREEZE_HOLDER_USERSPACE)) {
> +				/* Caller doesn't hold a userspace freeze. */
> +				up_write(&sb->s_umount);
> +				return -EINVAL;
> +			}
> +			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
> +				/*
> +				 * We were sharing the freeze with the kernel,
> +				 * so drop the kernel freeze but exit without
> +				 * unfreezing.
> +				 */
> +				sbw->freeze_holders &= ~who;
> +				up_write(&sb->s_umount);
> +				return 0;
> +			}
> +			break;
> +		default:
> +			BUG();
> +			up_write(&sb->s_umount);
> +			return -EINVAL;
> +		}

To me this screams for another 'is_partial_thaw' or so helper, whith
which we could doe something like:

	if (sbw->frozen != SB_FREEZE_COMPLETE) {
		ret = -EINVAL;
		goto out_unlock;
	}
	ret = is_partial_thaw(sb, who);
	if (ret) {
		if (ret == 1) {
			sbw->freeze_holders &= ~who;
			ret = 0
		}
		goto out_unlock;
	}

Btw, same comment about the wrappers as on the freeze side.

