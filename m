Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6293B365973
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 15:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhDTNDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhDTNDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:03:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C421FC06174A;
        Tue, 20 Apr 2021 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XA8ackuYZkYPd0YCzSUWLtkDmbgSkK7b4qPd/Wb+YNQ=; b=diKXWHLIKs2q20H2gdMgpGEZcg
        6JF64Jta0m4+MF4B0jlaRxVvDxPKP1ZZYFZkxBufK9SNFx3hPTdQutAwZZ0ghpwxpFyPxOsI9VLiF
        gl2//OmCX6w2E3XRWfrpD3z7ydCvibLHqjutozJnj4dyK07vtMFlrb7ykjeYp0oMwZFBlhCIQZjZf
        zdJWUgEOvuiqeYoGqbSDD8h9NknrOi0a072Kym/+xZHueh+BEQC23LrNIaVq6cztYmmQu4J4MGB8I
        s6xaUyadNIbDgqwZHaNSdHm6Q68p0UN13QoCcIpaB18iQlGwyXaWWmmmNp27oDhiniRuCwHaov3w+
        eguwjMdw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYpy3-00FB8t-9J; Tue, 20 Apr 2021 12:59:35 +0000
Date:   Tue, 20 Apr 2021 13:59:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 6/6] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <20210420125903.GC3604224@infradead.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417001026.23858-7-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This also removes all the superflous freezer calls on all filesystems
> as they are no longer needed as the VFS now performs filesystem
> freezing/thaw if the filesystem has support for it. The filesystem
> therefore is in charge of properly dealing with quiescing of the
> filesystem through its callbacks.

Can you split that out from the main logic change?  Maybe even into one
patch per file system?

> +#ifdef CONFIG_PM_SLEEP
> +static bool super_should_freeze(struct super_block *sb)
> +{
> +	if (!sb->s_root)
> +		return false;
> +	if (!(sb->s_flags & MS_BORN))
> +		return false;

This is already done in the iterate_supers_excl and
iterate_supers_reverse_excl helpers that this helper is always called
through.

> +	/*
> +	 * We don't freeze virtual filesystems, we skip those filesystems with
> +	 * no backing device.
> +	 */
> +	if (sb->s_bdi == &noop_backing_dev_info)
> +		return false;

Why?

> +	/* No need to freeze read-only filesystems */
> +	if (sb_rdonly(sb))
> +		return false;

freeze_super/thaw_super already takes care of read-only file systems,
and IMHO in a better way.

> +	int error = 0;
> +
> +	spin_lock(&sb_lock);
> +	if (!super_should_freeze(sb))
> +		goto out;
> +
> +	pr_info("%s (%s): freezing\n", sb->s_type->name, sb->s_id);
> +
> +	spin_unlock(&sb_lock);

I don't see how super_should_freeze needs sb_lock.  But if it does
the lock should be taken in the function.

> +	atomic_inc(&sb->s_active);

Doesn't this need a atomic_inc_not_zero if we're racing with a delayed
unmount?

> +	error = freeze_locked_super(sb, false);
> +	if (error)
> +		atomic_dec(&sb->s_active);

And this really needs something like deactivate_locked_super.

> +	spin_lock(&sb_lock);
> +	if (error && error != -EBUSY)
> +		pr_notice("%s (%s): Unable to freeze, error=%d",
> +			  sb->s_type->name, sb->s_id, error);
> +
> +out:
> +	spin_unlock(&sb_lock);

Huh, what is the point of sb_lock here?

> +int fs_suspend_freeze(void)
> +{
> +	return iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
> +}

I'd just fold this helper into its only caller.

> +	error = __thaw_super_locked(sb, false);
> +	if (!error)
> +		atomic_dec(&sb->s_active);
> +
> +	spin_lock(&sb_lock);
> +	if (error && error != -EBUSY)
> +		pr_notice("%s (%s): Unable to unfreeze, error=%d",
> +			  sb->s_type->name, sb->s_id, error);
> +
> +out:
> +	spin_unlock(&sb_lock);
> +	return error;
> +}
> +
> +int fs_resume_unfreeze(void)
> +{
> +	return iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> +}

Same comments as on the freeze side.
