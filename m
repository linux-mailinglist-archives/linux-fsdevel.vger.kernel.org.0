Return-Path: <linux-fsdevel+bounces-45534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C221A79235
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C66116C711
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC84CA64;
	Wed,  2 Apr 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsjZmS3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223C2E3372;
	Wed,  2 Apr 2025 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607975; cv=none; b=GLii4fECrMYo/oW/0n4XZZYX+lK0Zxpfm5EGBCjkzaNzXN/DCq9nWn6joJ89M/wHCPBZ1RjNLoaWAKGlAGHivY+d47TMYlVyQUKy55tuz4gXQHJN7MboP+b65c/jSmzhigzqTi6jLahfSgnBbJ6KkZumATxkVcVQYMGWOJD2zjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607975; c=relaxed/simple;
	bh=CVms+Eo1cvl/ek/0PwFSlyV0gNJLoB6YTEI8vRdZmx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us1k4AUmjXzonTeMi2M4IqdFZDg0cbG7z7LM3Uvo1Ul91zBIINqrJre4ywzZWP0l6NO4QhFcOvhmMr+8Q26bP2xt+5QGtZxRmj644KQdTmF2Ljcfi0YfF8vx8YBhWUeX8v7OJJXezYtJQVaJX/KIDjtW+mSkqrve0XU4ZSunrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsjZmS3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F61EC4CEDD;
	Wed,  2 Apr 2025 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743607975;
	bh=CVms+Eo1cvl/ek/0PwFSlyV0gNJLoB6YTEI8vRdZmx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsjZmS3qZApuYKUw7DxfubpBy7ZRq/vJGaG5nbuA/6jSX53d8e0iWoDOU8rJnHjro
	 0s8JLFOH5pQx7HYDSzBHjGzD/R5zGaJqTezKWchYSscwClZVFT9V4lDSPr4uMtLIDO
	 HVsudLzFfzvr4w/oONOrejnOXIwcae22nV1O1HSiMITWo8JzHC38qINeT/9AKkm+Ib
	 DqLF/GRx2aoRtWCsGEGuZLG27/eJ8nq4AJyltMUWTZfoWWN8TgIHGYmsNXggOTQuio
	 biXY941wSFh65Hvo52SmzcFoe5fzwv4HWEjumTLEhohqU6yB+FSY9s37JU3MOFmBrr
	 4g1ai4KLtE/KQ==
Date: Wed, 2 Apr 2025 17:32:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz, peterz@infradead.org
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] fs: allow all writers to be frozen
Message-ID: <20250402-melden-kindisch-8ea1b8c62bb4@brauner>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250402-work-freeze-v2-2-6719a97b52ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402-work-freeze-v2-2-6719a97b52ac@kernel.org>

On Wed, Apr 02, 2025 at 04:07:32PM +0200, Christian Brauner wrote:
> During freeze/thaw we need to be able to freeze all writers during
> suspend/hibernate. Otherwise tasks such as systemd-journald that mmap a
> file and write to it will not be frozen after we've already frozen the
> filesystem.
> 
> This has some risk of not being able to freeze processes in case a
> process has acquired SB_FREEZE_PAGEFAULT under mmap_sem or
> SB_FREEZE_INTERNAL under some other filesytem specific lock. If the
> filesystem is frozen, a task can block on the frozen filesystem with
> e.g., mmap_sem held. If some other task then blocks on grabbing that
> mmap_sem, hibernation ill fail because it is unable to hibernate a task
> holding mmap_sem. This could be fixed by making a range of filesystem
> related locks use freezable sleeping. That's impractical and not
> warranted just for suspend/hibernate. Assume that this is an infrequent
> problem and we've given userspace a way to skip filesystem freezing
> through a sysfs file.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/fs.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b379a46b5576..1edcba3cd68e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1781,8 +1781,7 @@ static inline void __sb_end_write(struct super_block *sb, int level)
>  
>  static inline void __sb_start_write(struct super_block *sb, int level)
>  {
> -	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
> -				   level == SB_FREEZE_WRITE);
> +	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1, true);
>  }

Jan, one more thought about freezability here. We know that there will
can be at least one process during hibernation that ends up generating
page faults and that's systemd-journald. When systemd-sleep requests
writing a hibernation image via /sys/power/ files it will inevitably end
up freezing systemd-journald and it may be generating a page fault with
->mmap_lock held. systemd-journald is now sleeping with
SB_FREEZE_PAGEFAULT and TASK_FREEZABLE. We know this can cause
hibernation to fail. That part is fine. What isn't is that we will very
likely always trigger:

#ifdef CONFIG_LOCKDEP
        /*
         * It's dangerous to freeze with locks held; there be dragons there.
         */
        if (!(state & __TASK_FREEZABLE_UNSAFE))
                WARN_ON_ONCE(debug_locks && p->lockdep_depth);
#endif

with lockdep enabled.

So we really actually need percpu_rswem_read_freezable_unsafe(), i.e.,
TASK_FREEZABLE_UNSAFE.

