Return-Path: <linux-fsdevel+bounces-5579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D97B80DD35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 22:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E171F21C5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 21:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E30C54F9D;
	Mon, 11 Dec 2023 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYnUv+TR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC8D6;
	Mon, 11 Dec 2023 13:33:37 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5906e03a7a4so2661915eaf.1;
        Mon, 11 Dec 2023 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702330416; x=1702935216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKM/X76sUs3s0gGEkUY9mrz+OPg2ZYPbaL3FbG9ujmI=;
        b=JYnUv+TR70APYMOVv8QSPp0ZWRaGLDWKjnWSUiBiNZIIUvZU1tPg5F1h+bDxotvhKl
         uKIRN9nKOdG9tIItVMl4npUGRKOGx2SoMqguANqrnvtW9H1Ym+zlRU+WZzMWJHyEqd7Q
         hzl1lgMUc9ZvwybTObl8Lg/nqioRftgOG08CveOI6IKSJ1jcqMGuXo8xGt+V4D7aj4hN
         0LTf4IP6b7bgvI2e7ARsI7PHvzGt8h06MX64z3lChCgbs6nRIybTRCWKisRanMDi1EPl
         IzFvMg9GfiUlhgH5HUnjVjoc7Y/b6gOQ5PCSUJ3bi7jakM/yTiBuHPBJlS31lj0tqQnc
         3/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330416; x=1702935216;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jKM/X76sUs3s0gGEkUY9mrz+OPg2ZYPbaL3FbG9ujmI=;
        b=Mpf/HRpj/2vFjm/j3+vkPfNZ8yBIuwqB0ob47pLGrBxG1O26IupYz2KsS5wo6WFI0E
         qhTMnlLha/IpiDL19O97f4HkTJaEYbWbq3BJIlU5omGEM5bUKEMDBxPSXoPhqinyWNEk
         uf85x1M/yGNP2PMBDuQvcFelbkNb0qNaUvHatIEnAxgvTnMUqA+f4vAV8IftkHIPcfg9
         GG2RcZ4Oo1sD+Ph1fIqDp2C9XH3O10TP+qTPEgCpwxjPgnG/kXS7UzqeVi1K50ZnXwKn
         L9MOISUV6FZW39ssqb1S2YG8D2Tr5ZwhPFWcGxiSOKVYQaCo1sIoAh7Dww2/Jj7QuEFF
         04sg==
X-Gm-Message-State: AOJu0YxbB3rJvj9APIG54OsXRNsHu5NMiyv32KzPQL6CH+fnedE0jDuj
	GgWBn83+do94B2KDU3QGOaPRxzGl4DOxgA==
X-Google-Smtp-Source: AGHT+IFULeijIew/pOCajz3OFJ27BkgEyQjFEb195ivlpAtXn4Np/awRRKGokZc02T+ECqtfD6ok6Q==
X-Received: by 2002:a05:6358:f0a:b0:170:17eb:14b2 with SMTP id b10-20020a0563580f0a00b0017017eb14b2mr2601871rwj.34.1702330416380;
        Mon, 11 Dec 2023 13:33:36 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b006ce7ed5ba42sm6934868pfo.171.2023.12.11.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:33:35 -0800 (PST)
Date: Mon, 11 Dec 2023 13:33:34 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 paul@paul-moore.com, 
 brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 keescook@chromium.org, 
 kernel-team@meta.com, 
 sargun@sargun.me
Message-ID: <6577802ea99b2_edaa208b7@john.notmuch>
In-Reply-To: <20231207185443.2297160-2-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-2-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 1/8] bpf: fail BPF_TOKEN_CREATE if no delegation
 option was set on BPF FS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> It's quite confusing in practice when it's possible to successfully
> create a BPF token from BPF FS that didn't have any of delegate_xxx
> mount options set up. While it's not wrong, it's actually more
> meaningful to reject BPF_TOKEN_CREATE with specific error code (-ENOENT)
> to let user-space know that no token delegation is setup up.
> 
> So, instead of creating empty BPF token that will be always ignored
> because it doesn't have any of the allow_xxx bits set, reject it with
> -ENOENT. If we ever need empty BPF token to be possible, we can support
> that with extra flag passed into BPF_TOKEN_CREATE.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/token.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index 17212efcde60..a86fccd57e2d 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -152,6 +152,15 @@ int bpf_token_create(union bpf_attr *attr)
>  		goto out_path;
>  	}
>  
> +	mnt_opts = path.dentry->d_sb->s_fs_info;
> +	if (mnt_opts->delegate_cmds == 0 &&
> +	    mnt_opts->delegate_maps == 0 &&
> +	    mnt_opts->delegate_progs == 0 &&
> +	    mnt_opts->delegate_attachs == 0) {
> +		err = -ENOENT; /* no BPF token delegation is set up */
> +		goto out_path;
> +	}
> +
>  	mode = S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
>  	inode = bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
>  	if (IS_ERR(inode)) {
> @@ -181,7 +190,6 @@ int bpf_token_create(union bpf_attr *attr)
>  	/* remember bpffs owning userns for future ns_capable() checks */
>  	token->userns = get_user_ns(userns);
>  
> -	mnt_opts = path.dentry->d_sb->s_fs_info;
>  	token->allowed_cmds = mnt_opts->delegate_cmds;
>  	token->allowed_maps = mnt_opts->delegate_maps;
>  	token->allowed_progs = mnt_opts->delegate_progs;
> -- 
> 2.34.1
> 
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

