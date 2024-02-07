Return-Path: <linux-fsdevel+bounces-10538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79C84C11C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 01:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1081C22827
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504911CD32;
	Wed,  7 Feb 2024 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pz4eWQpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4311CD21
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264008; cv=none; b=gW3p0EpTOhPwV0Q/agMFKASCshhLHR+ye/YitwAUoQrOBSscr9x7TSP4dMxO0wyeb3enMeRoy8TjgaVUniG/bb23tzyuGNZWHufT5hRTOU+vdHtg1GtJEiLEMr7TTAAdmE6XSH15vtiFdrKg4zBZ4oVa09wWN7K3u0dFHw5iEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264008; c=relaxed/simple;
	bh=Gst15j5CDQDH1SD6sdDEE5HMNeDd+SN8FMEVVi6YFSU=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=U1NUiAxP1nbPxKHD9v0QVEkhH+BHSR4Vsw+yjakoWR1AqahYpGElWDasHSrhqGxDZaBVngz84rwEWFfhwx0EQnztvaKeGNxPlP6ogdu9+AM7SpM3O47/a0zRpaeU6DYZvsWD/SDh1/69ll2iVp5Fx564udCn/qWAQsTzggzGSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pz4eWQpt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783f1fba0a8so24285a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 16:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707264005; x=1707868805; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8s9xol0MNG8W9mNzwU0hc714OYrLUcLP8SYPzvvLia8=;
        b=Pz4eWQptk7RPt6RZL19XmM3tR9Nlni19HDlINLYd66cylEswRKWwfOVxmu9SNGUgL2
         SbDypeoSWK00hHXbipWZ+RYb+2JCx9rp2SnKmDSonh1ayJ7FCTPyxabfsJiSmIdI7Dua
         wBHarCR/N/c4Da0orhdtO76EPynYfcY84gk+mGtZIxvHI5IZisc+Yd91oQ/pBiJxifEg
         u9xjvtljneWGotM5cvW8lp6aPD1BY2kDkP5pW1uVBfT1hIiNV0p+ofdiGGhxHauYy4iA
         FYU9WDx6fcJzCHOit1O6kkXC1cN8rubYLt7C1kTc6DVcQDqh+BCrXYDlYfbW1ibUNFpQ
         7MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707264005; x=1707868805;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s9xol0MNG8W9mNzwU0hc714OYrLUcLP8SYPzvvLia8=;
        b=DGFHMy5Nq0JhLyi9IKnsBXZSALyZL/h1Y1RpOKdw1Q5REGGuJ/LXmDGDBXmkUM42ir
         57NF4Uixbyztm3eJN4LFmS3g6Rgyb6ep4gJDpJBCSh1blBBkCht3+7MhVS3IBjSp8C3J
         nYQo3wyFw4TbvB37SBn1B28dvrY/yRhN0+CYofgau+kbXut8gs5LGTg8ea2QYtuECt9f
         RgV62bznN1XOHDyjhlaU5S0boEiQhZy/d8G3CN5sjm2ycuKpprlQ/GGyfJ6KU79Nod1n
         TFU8xPwAe16w6vw6EunN68AjAcb+GMq8CMp5jnHdwGFQ6HrJ+OZhxjisk2Xn5kaeN54X
         /oCg==
X-Forwarded-Encrypted: i=1; AJvYcCUmHXlWSBNRAwBSrOEWdk4j1sFIG441aJL4bBmmGvMEoBAsu6zeubGXK2I57LZnqWXS335JWEDqHn3ZFlknMuvlVLeYYsK8Jt7QGiSClA==
X-Gm-Message-State: AOJu0YxUkY5kGaZ66GB0fgk9awjTzyyUzXLJb5aaq2FcOEydoJolcA3F
	IQivhViQVbEyh7b95pX59famg4wqG8rTpWQFTBms1Hr9XfJufLld/lycV9BVlw==
X-Google-Smtp-Source: AGHT+IGQqNODr0E1KTBCjb4aCFwJMBR+grZp49ca0nKI6qnXjUNLlQD002WSmznlS/kqwVHeLZSOVg==
X-Received: by 2002:a05:620a:29d2:b0:784:7b2b:bb88 with SMTP id s18-20020a05620a29d200b007847b2bbb88mr4713869qkp.21.1707264003823;
        Tue, 06 Feb 2024 16:00:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU23+3HR7kGq9Ry9mjAPimkTmuDFZL6yoC+AueDs6KtmhNpKcn4BEBKOuyvDdygaIGohXbVythFFV0kHz6hSI8o8GcFbLAcB4OIkTjPZ+9NZ5UPZdu8CDKCJVnYHz4bkTRsMWsyNaKAcjxq5Vw=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a404700b007840843f3b2sm15678qko.18.2024.02.06.16.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:00:03 -0800 (PST)
Date: Tue, 06 Feb 2024 19:00:03 -0500
Message-ID: <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
In-Reply-To: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>

On Feb  6, 2024 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
> A regression caused by commit 978ffcbf00d8 ("execve: open the executable
> file before doing anything else") has been fixed by commit 4759ff71f23e
> ("exec: Check __FMODE_EXEC instead of in_execve for LSMs") and commit
> 3eab830189d9 ("uselib: remove use of __FMODE_EXEC"). While fixing this
> regression, Linus commented that we want to remove current->in_execve flag.
> 
> The current->in_execve flag was introduced by commit f9ce1f1cda8b ("Add
> in_execve flag into task_struct.") when TOMOYO LSM was merged, and the
> reason was explained in commit f7433243770c ("LSM adapter functions.").
> 
> In short, TOMOYO's design is not compatible with COW credential model
> introduced in Linux 2.6.29, and the current->in_execve flag was added for
> emulating security_bprm_free() hook which has been removed by introduction
> of COW credential model.

If you wanted to mention the relevant commit where security_bprm_free()
was removed, it was a6f76f23d297 ("CRED: Make execve() take advantage
of copy-on-write credentials").

> security_task_alloc()/security_task_free() hooks have been removed by
> commit f1752eec6145 ("CRED: Detach the credentials from task_struct"),
> and these hooks have been revived by commit 1a2a4d06e1e9 ("security:
> create task_free security callback") and commit e4e55b47ed9a ("LSM: Revive
> security_task_alloc() hook and per "struct task_struct" security blob.").
> 
> But security_bprm_free() hook did not revive until now. Now that Linus
> wants TOMOYO to stop carrying state across two independent execve() calls,
> and TOMOYO can stop carrying state if a hook for restoring previous state
> upon failed execve() call were provided, this patch revives the hook.
> 
> Since security_bprm_committing_creds() and security_bprm_committed_creds()
> hooks are called when an execve() request succeeded, we don't need to call
> security_bprm_free() hook when an execve() request succeeded. Therefore,
> this patch adds security_execve_abort() hook which is called only when an
> execve() request failed after successful prepare_bprm_creds() call.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Serge E. Hallyn <serge@hallyn.com>
> ---
>  fs/exec.c                     |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 11 +++++++++++
>  4 files changed, 18 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index af4fbb61cd53..d6d35a06fd08 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1521,6 +1521,7 @@ static void free_bprm(struct linux_binprm *bprm)
>  	if (bprm->cred) {
>  		mutex_unlock(&current->signal->cred_guard_mutex);
>  		abort_creds(bprm->cred);
> +		security_execve_abort();
>  	}
>  	do_close_execat(bprm->file);
>  	if (bprm->executable)
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 76458b6d53da..fd100ab71a33 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct f
>  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
>  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
>  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
> +LSM_HOOK(void, LSM_RET_VOID, execve_abort, void)
>  LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
>  LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
>  	 struct fs_context *src_sc)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d0eb20f90b26..31532b30c4f0 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -299,6 +299,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *
>  int security_bprm_check(struct linux_binprm *bprm);
>  void security_bprm_committing_creds(const struct linux_binprm *bprm);
>  void security_bprm_committed_creds(const struct linux_binprm *bprm);
> +void security_execve_abort(void);
>  int security_fs_context_submount(struct fs_context *fc, struct super_block *reference);
>  int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
>  int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
> @@ -648,6 +649,10 @@ static inline void security_bprm_committed_creds(const struct linux_binprm *bprm
>  {
>  }
>  
> +static inline void security_execve_abort(void)
> +{
> +}
> +
>  static inline int security_fs_context_submount(struct fs_context *fc,
>  					   struct super_block *reference)
>  {
> diff --git a/security/security.c b/security/security.c
> index 3aaad75c9ce8..10adc4d3c5e0 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1223,6 +1223,17 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
>  	call_void_hook(bprm_committed_creds, bprm);
>  }
>  
> +/**
> + * security_execve_abort() - Notify that exec() has failed
> + *
> + * This hook is for undoing changes which cannot be discarded by
> + * abort_creds().
> + */
> +void security_execve_abort(void)
> +{
> +	call_void_hook(execve_abort);
> +}

I don't have a problem with reinstating something like
security_bprm_free(), but I don't like the name security_execve_abort(),
especially given that it is being called from alloc_bprm() as well as
all of the execve code.  At the risk of bikeshedding this, I'd be much
happier if this hook were renamed to security_bprm_free() and the
hook's description explained that this hook is called when a linux_bprm
instance is being destroyed, after the bprm creds have been released,
and is intended to cleanup any internal LSM state associated with the
linux_bprm instance.

Are you okay with that?

--
paul-moore.com

