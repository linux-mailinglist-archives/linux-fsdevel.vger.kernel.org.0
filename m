Return-Path: <linux-fsdevel+bounces-25193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F88949B7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76BF1C2287C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA69175D33;
	Tue,  6 Aug 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXHpbR52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228E16CD11;
	Tue,  6 Aug 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984191; cv=none; b=SppKYvcMqZagmPOhsABQIQgscOymmUF4VbzFyek9AVtYvyObxWzTq8lsHJCiaCWOfgu0mUNXKVr1fD/fvYgSOv+8HGW2zSUOQMwcRVwsUzTZrA7XusrfH8LQ2ZQVMwgh7dfYz+9r+nCiCyU/rn8juZEY04rOdJEc37c7M/8fU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984191; c=relaxed/simple;
	bh=ADMvC4n0oh3wghfjc0I1QjBweofU8AI28CRx4X1nqCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKB1Qzd3NrxA7yXmKTWagjjsz4iHz7c3MInOV7D4FpuleneE84Vm3f+Qw54SMoyydJ/bnp5nBgjV1n8+1OAPtuvPWlDphvBjm3qLqIvXiodiZ01AOkjQM9nBf68k/F/jSlipQdxI+fZh+oWOOOA3SrOrCgmIQszKyyT8GOkjWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXHpbR52; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so831739a91.2;
        Tue, 06 Aug 2024 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722984189; x=1723588989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNt5M+Kul3w3E9npRSXsBL87xWj9mvSGMN2GbHRNel0=;
        b=hXHpbR52lghJY2g5CGpns138AghAhvCP5ES438H48tYWZNE88oCwNfcYvXIy2wZeHg
         EIO3EMNeMkGdEja2PN4C7GlUq74kk84OXcwCdCi9xXSdRq9IKknUu7GG5JyULBWaLAX5
         jzrch2b8CE98RUSObOsMU8gdIupfD8Ota0W+7CnnuFsCzjq4aAmJWvtoebGBJq6uNEOw
         SZUmNmKfTM0H9OkYp6pT52kTiIwJzZfeYMK/tqZvhRV2KoXrK/UABm9W2uGFRXZqPYmj
         4pZ4SY0XtCi0A57SUI424J5w7Zn2EGR+dQQOL4NwaYKKDCEl+KOC7/b1mcgpBFgPsstH
         clzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984189; x=1723588989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNt5M+Kul3w3E9npRSXsBL87xWj9mvSGMN2GbHRNel0=;
        b=aIXLL1+7u2TzAhbKW7LS/rUlemuBxisQNCn8ZD+Yh4kHUFuDiMqxFNlczqkjWBAnau
         1rxMOVILNr9Ug8NWHMq/5BdYJkC4FVtXcG67fsTxozexczLeknpCiFsqcZVxdqKJTK0w
         CkoZI+MNEF+XZKuQlLgl/1bgEaY0RfEIhsSO4hhlVvxyMr+wyw3qlHST+Q+RnscNB0NR
         LRjYu5JqNLl6mc+zuH9K3qLki0+q+pUz8/f3iCN190kfSedyMywuR0YBjJBiQq5dqMv6
         PhT7lq1xNQo4KnnCRkkwQNEQNdwHNWmRboIv2IgnzjjJglStRAnZslmmYOmq4YEKaM5F
         bNYA==
X-Forwarded-Encrypted: i=1; AJvYcCUk8HzIdmSlJzLWsouceZYlH0onCivrlSJ+3XJzSgrv8duyxu6JMSJlJoV7CbjEXOjSI8PN8+cZsu408DQ27L1d1Te+HGNvKop1RbpTuAIsJmJhOl0Yw/mNEt8mEDflCxCNZV/TNM19JPHA7A7m5VzquSouKs0BsjlZHSDdLuuVs6pJXOTb6etB2w==
X-Gm-Message-State: AOJu0Yw/v5mEeZR11qF2OBJVPPg2jELWxqzuQQEMhIjsddEtWRvmb6MA
	0Jv56CPtFt8LoVRLCYhM8qwlPAwMBcgRjKBQMTl7UsZMLoi9XXdiENAzq6J+a5yzW9WVE+0wkVx
	fMpYJ40qbHS5civVy+FsSaJAGqtM=
X-Google-Smtp-Source: AGHT+IEnfhAcfSgoCthpAMSGkKGWhEoY1iGwgvNJm7uNk8jQoZ81xw/lBpbAmrFYQBME1zpJW4lpxRhr78WreNlX4x4=
X-Received: by 2002:a17:90a:a417:b0:2c9:6f8d:7270 with SMTP id
 98e67ed59e1d1-2cff9544dc7mr14391710a91.42.1722984188556; Tue, 06 Aug 2024
 15:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-35-viro@kernel.org>
In-Reply-To: <20240730051625.14349-35-viro@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Aug 2024 15:42:56 -0700
Message-ID: <CAEf4BzasSXFx5edPknxVnmk+o6oAyOU0h_Tg_yHVaJcaJfpPOQ@mail.gmail.com>
Subject: Re: [PATCH 35/39] convert bpf_token_create()
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	brauner@kernel.org, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:27=E2=80=AFPM <viro@kernel.org> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> keep file reference through the entire thing, don't bother with
> grabbing struct path reference (except, for now, around the LSM
> call and that only until it gets constified) and while we are
> at it, don't confuse the hell out of readers by random mix of
> path.dentry->d_sb and path.mnt->mnt_sb uses - these two are equal,
> so just put one of those into a local variable and use that.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  kernel/bpf/token.c | 69 +++++++++++++++++-----------------------------
>  1 file changed, 26 insertions(+), 43 deletions(-)
>

LGTM overall (modulo // comments, but see below)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index 9b92cb886d49..15da405d8302 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -116,67 +116,52 @@ int bpf_token_create(union bpf_attr *attr)

[...]

> -       err =3D security_bpf_token_create(token, attr, &path);
> +       path_get(&path);        // kill it
> +       err =3D security_bpf_token_create(token, attr, &path); // constif=
y
> +       path_put(&path);        // kill it
>         if (err)
>                 goto out_token;
>

By constify you mean something like below?

commit 06a6442ca9cc441805881eea61fd57d7defadaca
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Tue Aug 6 15:38:12 2024 -0700

    security: constify struct path in bpf_token_create() LSM hook

    There is no reason why struct path pointer shouldn't be const-qualified
    when being passed into bpf_token_create() LSM hook. Add that const.

    Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 855db460e08b..462b55378241 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -431,7 +431,7 @@ LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog
*prog, union bpf_attr *attr,
      struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union
bpf_attr *attr,
-     struct path *path)
+     const struct path *path)
 LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
 LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum
bpf_cmd cmd)
 LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap=
)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1390f1efb4f0..31523a2c71c4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2137,7 +2137,7 @@ extern int security_bpf_prog_load(struct
bpf_prog *prog, union bpf_attr *attr,
                   struct bpf_token *token);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
 extern int security_bpf_token_create(struct bpf_token *token, union
bpf_attr *attr,
-                     struct path *path);
+                     const struct path *path);
 extern void security_bpf_token_free(struct bpf_token *token);
 extern int security_bpf_token_cmd(const struct bpf_token *token, enum
bpf_cmd cmd);
 extern int security_bpf_token_capable(const struct bpf_token *token, int c=
ap);
@@ -2177,7 +2177,7 @@ static inline void security_bpf_prog_free(struct
bpf_prog *prog)
 { }

 static inline int security_bpf_token_create(struct bpf_token *token,
union bpf_attr *attr,
-                     struct path *path)
+                        const struct path *path)
 {
     return 0;
 }
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..d8d0b67ced25 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5510,7 +5510,7 @@ int security_bpf_prog_load(struct bpf_prog
*prog, union bpf_attr *attr,
  * Return: Returns 0 on success, error on failure.
  */
 int security_bpf_token_create(struct bpf_token *token, union bpf_attr *att=
r,
-                  struct path *path)
+                  const struct path *path)
 {
     return call_int_hook(bpf_token_create, token, attr, path);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..0eec141a8f37 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6965,7 +6965,7 @@ static void selinux_bpf_prog_free(struct bpf_prog *pr=
og)
 }

 static int selinux_bpf_token_create(struct bpf_token *token, union
bpf_attr *attr,
-                    struct path *path)
+                    const struct path *path)
 {
     struct bpf_security_struct *bpfsec;


[...]

