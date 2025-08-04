Return-Path: <linux-fsdevel+bounces-56642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B11B1A175
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 14:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3245B17C6AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DEA25A344;
	Mon,  4 Aug 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnDWCO2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B524E4C3;
	Mon,  4 Aug 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310797; cv=none; b=qmxvxcLF7r7X15ZvXX2UKWbpPjPR/6DxGZ5y8Sjrt0MASUFePR2r+ziYsmOaunBn0cTX3guNzUMqILUV8Nwp8SH01TBm40Va+Hb87//y8mzolC2B4YrEOU3HYawLlC9SbqrtvZFwo0pDIUjqfWxMke7789iuolkcBfIi4bePk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310797; c=relaxed/simple;
	bh=HFdiepAhYZGaIJYjhN24/8vbIETT0vL1Ber9jx+RMzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx4qbpexvFFI6kM4hgWXFivN6JSScGX/m5dj3Rsdh3sHLR43oeLdf8m0RiQpCgTIzQwOBzb01QaHX1/i7jdjceTKI/SDdvaM/j7xnTvRU3SNZzKkEJdPL+MWaGoaEflh9MLNHeoCb2DxbfNz35jU9eflyPqd4P0h9kzpJJELJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnDWCO2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A8CC4CEE7;
	Mon,  4 Aug 2025 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754310797;
	bh=HFdiepAhYZGaIJYjhN24/8vbIETT0vL1Ber9jx+RMzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnDWCO2gcHKfRelYIeYR7Nm96AaWAPlC5dw7cgMGjH+RLa4/xTlvOWNo8mLHyRGno
	 s+ofiOr4npgG81bd2jQwPxDt3ArlPM9be32/et6DXRtUS9xsDYyjcrJhTZdqFj2ntn
	 S38bMDOhjbvvKnXW5zFrc9zbFLavr9p+EDg6CcZXWnZ+CpbcLKMT6VEkBtVw8TWA7D
	 3QsLtiYKs0ksj7yOHBGua/v78frNKI3D+ridwKUZTl3A92QtQdrUZMhjaYed6OiWua
	 EUFyGu1i7H9m/Dajg/qv4E/4wf18uNXRAknDs4NCQRki9IEnVmJpIDhrOLTkjg1fc+
	 NyxI6cFq03/Xg==
Date: Mon, 4 Aug 2025 14:33:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sargun Dhillon <sargun@sargun.me>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: always return zero on success from replace_fd()
Message-ID: <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
References: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>

On Mon, Aug 04, 2025 at 10:40:17AM +0200, Thomas Weißschuh wrote:
> replace_fd() returns the number of the new file descriptor through the
> return value of do_dup2(). However its callers never care about the
> specific number. In fact the caller in receive_fd_replace() treats any

To be pedantic as stated this isn't true: While they don't care about it
in their error handling they very much care about what specific file
descriptor number is used. Try and assign unexpected fd numbers for
coredumping and see what CVEs you can get out of it...

I'll take the patch but I'll amend it to just use a guard:

diff --git a/fs/file.c b/fs/file.c
index 6d2275c3be9c..858a55dbd5d8 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1318,7 +1318,7 @@ __releases(&files->file_lock)
 int replace_fd(unsigned fd, struct file *file, unsigned flags)
 {
        int err;
-       struct files_struct *files = current->files;
+       struct files_struct *files;

        if (!file)
                return close_fd(fd);
@@ -1326,15 +1326,17 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
        if (fd >= rlimit(RLIMIT_NOFILE))
                return -EBADF;

-       spin_lock(&files->file_lock);
+       files = current->files;
+
+       guard(spinlock)(&files->file_lock);
        err = expand_files(files, fd);
        if (unlikely(err < 0))
-               goto out_unlock;
-       return do_dup2(files, file, fd, flags);
+               return err;
+       err = do_dup2(files, file, fd, flags);
+       if (err < 0)
+               return err;

-out_unlock:
-       spin_unlock(&files->file_lock);
-       return err;
+       return 0;
 }

 /**

scoped_guard() works too but bloats the patch.

> non-zero return value as an error and therefore never calls
> __receive_sock() for most file descriptors, which is a bug.
> 
> To fix the bug in receive_fd_replace() and to avoid the same issue
> happening in future callers, signal success through a plain zero.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/lkml/20250801220215.GS222315@ZenIV/
> Fixes: 173817151b15 ("fs: Expand __receive_fd() to accept existing fd")
> Fixes: 42eb0d54c08a ("fs: split receive_fd_replace from __receive_fd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Move the fix to replace_fd() (Al)
> - Link to v1: https://lore.kernel.org/r/20250801-fix-receive_fd_replace-v1-1-d46d600c74d6@linutronix.de
> ---
> Untested, it stuck out while reading the code.
> ---
>  fs/file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 6d2275c3be9c6967d16c75d1b6521f9b58980926..f8a271265913951d755a5db559938d589219c4f2 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1330,7 +1330,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
>  	err = expand_files(files, fd);
>  	if (unlikely(err < 0))
>  		goto out_unlock;
> -	return do_dup2(files, file, fd, flags);
> +	err = do_dup2(files, file, fd, flags);
> +	if (err < 0)
> +		goto out_unlock;
> +	err = 0;
>  
>  out_unlock:
>  	spin_unlock(&files->file_lock);
> 
> ---
> base-commit: d2eedaa3909be9102d648a4a0a50ccf64f96c54f
> change-id: 20250801-fix-receive_fd_replace-7fdd5ce6532d
> 
> Best regards,
> -- 
> Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 

