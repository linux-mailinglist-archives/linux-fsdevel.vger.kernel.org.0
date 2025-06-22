Return-Path: <linux-fsdevel+bounces-52415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED9AE323E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC823B10DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA21F560B;
	Sun, 22 Jun 2025 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="GsgN5Bx5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01C2EAE5
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626642; cv=none; b=ZFqSzEkmw3lXYufA4WmMT0Rfg80iOdYIcjYhtZFfpuG5sKEZv5VmAjjv6L1JCjT8IYedh8ADtWLN2p19iwvQAU+h7ljXDbfWF4ln2BS6/sZiJ8MO9ptGjxKcJG9uKF+ebAAwqUIJqnrCe4/EhY2f717TpyADTx2KkWa/xTCyxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626642; c=relaxed/simple;
	bh=iv+sexg03BM2KqF1n9ILFePDREmkcLus9u4tRqNJJFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyX7KWLIHubpVybvRfCjp/5cLdaMgpKbzGWncdBjE8rLnKkwgTmBgWnxHsbD9BVvaoDFT1QJGadr2/l3gv84tlHf1AIz6D+BTxMgvy3IOhVh9352OHfy9hoSJqQG3sRhdXyLbZlJbLsOvsfSFelaFmqBrGP5h3sm7NtMtChlcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=GsgN5Bx5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32add56e9ddso30214591fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750626638; x=1751231438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FSQhGI2xRfICaJ7204/KMSu7ZcpWhBVPL0y4UQDOy04=;
        b=GsgN5Bx55JPHAdeVEOTEmrsiFUT+UeR3ufAyTb96Mlf+Fpi9f3dwIL0FWke2HUA0fc
         rdZSuLOLuHFZ4J3mUf9TlZKYmuVi6OpiWQ5jFG8r14YuwwH5Zr545npADiU1bbE1ebTK
         e5z6z5Skde0bepvsG7mfe5hRXFypsoLTb5gfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750626638; x=1751231438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSQhGI2xRfICaJ7204/KMSu7ZcpWhBVPL0y4UQDOy04=;
        b=HYi3oUVY4vyJCucFZo9NtQj+Ylc3SRhyO9CF1Ci7+VUZp9fAmitLPdHIcci26EQaLe
         jVHWGDbNb7vwEK0UFdQiiyYc7t0Fk+HDj2dCObmkh3V9fsCn8V9oVXvFwP/DvCh4dUCg
         o0gr92IvCnkCyV/d1iD2QzsU7fLE7ttV+TI8K6+drVSMgUN5HjREmEGNIAEkBRYNyNPL
         Xp/bD7STF2sBYAzTMqJ+QMhjOxORGunLTnfFZ7sPO6yg0+uk1x+rilgXpozxzuRbRIIB
         1tyHQ+GE23D93+NLCSroE2qU5qJhPmvUCaqhBavX2LfgHiPcQ2NKn+WSohLKGR69yLhA
         ltOg==
X-Gm-Message-State: AOJu0YzGlRBfPvcCsoLmN1FnRaTyHigiFc/SysL1I8qa6nHV9LDQWP0M
	t8efUem78FuhiFBnKXl8EdBarUFUB3UUeUbd5cbFkaJmJ4KAUkAYAPb2tbFIo9d/8BFD4vBJnC5
	iw9Crl/dfy2eEEtnI/pboV0VDUhLImBelEPMgdQ6t1A==
X-Gm-Gg: ASbGncu3P7tQOKue6PLpvLABBpVzIC7vOxl4Et+NtCJEqwxX+/FNzwODofbHbyfRkKp
	Sx4gxioGAAx/Jn7sLpvi0q+48k0CBtqcgXqUuJuLSqLc2Bthhw3LAlifn984YsbhlA5qCviB0NP
	wiIIB2dciFKiUBRjnfLvDJ0g261/xXXlyKnLAhPkxdpK96
X-Google-Smtp-Source: AGHT+IFhbDzKOPtkEvz3j0xYop5ioCqCNZq8jjzMc/8/Cqy4NxssPQLCiS6Pm08OL/dxL41p29Yc3v12ynC4niFzXOs=
X-Received: by 2002:a05:6512:3c88:b0:553:cc61:1724 with SMTP id
 2adb3069b0e04-553e3bb51camr2987368e87.24.1750626638387; Sun, 22 Jun 2025
 14:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-6-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-6-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:10:27 +0200
X-Gm-Features: Ac12FXxI_bLEDxajygCLW33EVfvH19o_5JY0gzjAUkp1xYthwf1R8DbLGP8RJy0
Message-ID: <CAJqdLrrQ7igZdrwoFRuZQy7ARO=5Qr3dGFrXot8SZ5E0nzZ1og@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] pidfs: remove unused members from struct pidfs_inode
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> We've moved persistent information to struct pid.
> So there's no need for these anymore.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 6a907457b1fe..72aac4f7b7d5 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -46,8 +46,6 @@ struct pidfs_attr {
>  };
>
>  struct pidfs_inode {
> -       struct pidfs_exit_info __pei;
> -       struct pidfs_exit_info *exit_info;
>         struct inode vfs_inode;
>  };
>
> @@ -696,9 +694,6 @@ static struct inode *pidfs_alloc_inode(struct super_block *sb)
>         if (!pi)
>                 return NULL;
>
> -       memset(&pi->__pei, 0, sizeof(pi->__pei));
> -       pi->exit_info = NULL;
> -
>         return &pi->vfs_inode;
>  }
>
>
> --
> 2.47.2
>

