Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E286F9705
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 07:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjEGFXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 01:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjEGFXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 01:23:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D078D1492D;
        Sat,  6 May 2023 22:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xuzESVVLNb7QkJGI1Thl+QLL/s7Vu/C5GPtuTXotrYg=; b=v7nbqkCiIxkImQ5gjtugRz7ADK
        wrYNytawxQXivWGFDMVaJfk8DO1gPpC6B8KLCDUTQT2l8YKL8npzpdlumhh5uewuuykN7MFqcAr6W
        eyAa4xIn2BA+KTAsqMuw723j+EPcb+J9sPEaIKPclARlWCkHZT79ooNEON4nGXA88xXohH8b6Y/yO
        SngUVgjeBeUd8gzarISVrwMPVIiHJHDLhK1yEvOvEDPIHWLhq51nnaw0wzlGeePtLib7Bk7o0sx36
        LLg5wHEbz9Lm9iLgytLtQhdLkaS+hkP/JafD7E343vjjnf3VhwPvxomnIRPMTHP4I6Fu+5yXTi7gh
        xFM6UONg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvWrZ-00FDtv-2S;
        Sun, 07 May 2023 05:23:13 +0000
Date:   Sat, 6 May 2023 22:23:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org, ruansy.fnst@fujitsu.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] vfs: allow filesystem freeze callers to denote who
 froze the fs
Message-ID: <ZFc1wVFeHsi7rK01@bombadil.infradead.org>
References: <168308293319.734377.10454919162350827812.stgit@frogsfrogsfrogs>
 <168308293892.734377.10931394426623343285.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168308293892.734377.10931394426623343285.stgit@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 08:02:18PM -0700, Darrick J. Wong wrote:
> diff --git a/fs/super.c b/fs/super.c
> index 04bc62ab7dfe..01891f9e6d5e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1736,18 +1747,33 @@ int freeze_super(struct super_block *sb)
>  	up_write(&sb->s_umount);
>  	return 0;
>  }
> +
> +/*
> + * freeze_super - lock the filesystem and force it into a consistent state
> + * @sb: the super to lock
> + *
> + * Syncs the super to make sure the filesystem is consistent and calls the fs's
> + * freeze_fs.  Subsequent calls to this without first thawing the fs will return
> + * -EBUSY.  See the comment for __freeze_super for more information.
> + */
> +int freeze_super(struct super_block *sb)
> +{
> +	return __freeze_super(sb, USERSPACE_FREEZE_COOKIE);
> +}
>  EXPORT_SYMBOL(freeze_super);
>  
> -static int thaw_super_locked(struct super_block *sb)
> +static int thaw_super_locked(struct super_block *sb, unsigned long cookie)
>  {
>  	int error;
>  
> -	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
> +	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE ||
> +	    sb->s_writers.freeze_cookie != cookie) {
>  		up_write(&sb->s_umount);
>  		return -EINVAL;

We get the same by just having drivers use freeze_super(sb, true) in the
patches I have, ie, we treat it a user-initiated.

On freeze() we have:

int freeze_super(struct super_block *sb, bool usercall)                                              
{                                                                                                    
	int ret;                                                                                     
	
	if(!usercall && sb_is_frozen(sb))                                                           
		return 0;                                                                            

	if (!sb_is_unfrozen(sb))
	return -EBUSY;
	...
}

On thaw we end up with:

int thaw_super(struct super_block *sb, bool usercall)
{
	int error;

	if (!usercall) {
		/*
		 * If userspace initiated the freeze don't let the kernel
		 *  thaw it on return from a kernel initiated freeze.
		 */
		 if (sb_is_unfrozen(sb) || sb_is_frozen_by_user(sb))
		 	return 0;
	}

	if (!sb_is_frozen(sb))
		return -EINVAL;
	...
}

As I had it, I had made the drivers and the bdev freeze use the usercall as
true and so there is no change.

In case there is a filesystem already frozen then which was initiated by
the filesystem, for whatever reason, the filesystem the kernel auto-freeze
will chug on happy with the system freeze, it bails out withour error
and moves on to the next filesystem to freeze.

Upon thaw, the kernel auto-thaw will detect that the filesystem was
frozen by user on sb_is_frozen_by_user() and so will just bail and not
thaw it.

If the mechanism you want to introduce is to allow a filesystem to even
prevent kernel auto-freeze with -EBUSY it begs the question if that
shouldn't also prevent suspend. Because it would anyway as you have it
right now with your patch but it would return -EINVAL. I also ask because of
the possible issues with the filesystem not going to suspend but the backing
or other possible related devices going to suspend.

Since I think the goal is to prevent the kernel auto-freeze due to
online fsck to complete, then I think you *do* want to prevent full
system suspend from moving forward. In that case, why not just have
the filesystem check for that and return -EBUSY on its respective
filesystem sb->s_op->freeze_fs(sb) callback?

  Luis
