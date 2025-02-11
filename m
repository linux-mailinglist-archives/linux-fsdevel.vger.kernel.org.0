Return-Path: <linux-fsdevel+bounces-41512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FAA30B21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 13:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AE33A2AC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196D1FBCA1;
	Tue, 11 Feb 2025 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNfAsOQQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033591F12FC;
	Tue, 11 Feb 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275704; cv=none; b=dHcbzdJSozjqjcjTT6bMMZDeLcA0syifkpCNwyYUAC0dYEUWZr8nTOSrlOomLnyw0GQP+zaGpCi9TlO/iqSNZ6bwudUSwIgyiOdKmmKStj0BwBf+ItSvo/A9aLRPUgTPYUBPJ0eM7bcvfighXvZmoodoWXQdfha+Oefz/BiF9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275704; c=relaxed/simple;
	bh=qiL+AvC33tgs5duRkyRkM68mAIG4EY3+T/LJip+LboQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjQ9P6uAIWcYdw7iDegtEf3U0lb4NPqgUgWrdKDrmVbeti+lnHXR9Qear3xpIxsn3XAtbO09Kl9rpAY3sWPVun2X3MB1ElxJdIHZrnazVRq0PKQozymWChzBDkfkH+TQnYkRyDIPuS1MlYo76WW/LlDoAS224uOCXor6LW9jvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNfAsOQQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de75004cd9so3081838a12.1;
        Tue, 11 Feb 2025 04:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275701; x=1739880501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CElUsGglWUhHyZuzElvDldvXSDYIDv3Kjg/Iy29cTqw=;
        b=BNfAsOQQzwsNSTc8r9LLKHp8kLvqJ298nSXhKWrRcoqFeh1XuDfybN0bjjPEk0cayN
         JEZEVjigOgMInl6WdveBbkoRb28XFOXM3xLnnug6ef3+sJvV5b4EJmNnqtR/ZhZMmUwr
         vPw9rtv95CilKRaK60UZzF7lspke+h8x2J7m9zUuhi/tYBMvB3tY9Mi63ucYd2MNyVJu
         Hu2ZfQBDdDovZrxKIr+5gWciW9P9pjzGve9kk+BlLIJAcx0AQ7OiwqkeJpVHaQrVNAyq
         HiRQvXSCyVjfl1AT/STewKpmMCyWd6acQ5oi26x3yOzlE8vmTobAStWnBeB74dZeV/Um
         bKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275701; x=1739880501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CElUsGglWUhHyZuzElvDldvXSDYIDv3Kjg/Iy29cTqw=;
        b=m0pIlFPtnJTllNGQWYvK1Uis9QXpN0XOtFt8nXjHZA5ebBMKCJa/kTxbNVCg7hn6Zh
         AvFeg6kn6w39PhCfBT7Dkx9VntOg+f+t2t87JKB5VMurJ7bz3R8EJ+sbYu06apGih/cQ
         hwKxM9JaqdlxRLhPmsmmBovWuyfZpnEgyzcN8p9+yXHDdzHL68EQshUl1/wgOIpzhf0m
         pcXcFfRLEJjkV8nSkEZV1/oK8gpTXbn395IBpVEBYX37Hvp4YQDpk/NE6uleiELqM1d9
         4D0s/PNU2wSYHUxsgGjlxazzxrdQGScXy/6DTPHo2mWATpA/yQ4GLPgliQceNyfSssfw
         kKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzWLMQRFLEze+sRxmhrJmtoP8C+0FIAA6DIJ+jv6M3rwfpAOxyPcfTGO53lL5bzuQTq5wBiW0r1LoDhatP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PxtYPEdTJ2Ph4Q4PJpLuXLtZp/jmqxFBzcv+tupQX21LRR7b
	LF2SnYBypO5D3nSXd2I1UUvuRNeW7MO8LpYGCad+UhE9agrdd95qRCgj+U4YBfrDki3paDVA7Sb
	W75uoQblZVSt4jxrFwLBNrXPVTBPTySLj
X-Gm-Gg: ASbGncvecjPHAiNK4AsgMguwcWyn+GuHNRRjFO/TB4OofEQbv+7TrT5tnejSk1Ty0PA
	k9taukLGxem9GfTRGQIkcEjNDpykNdY5ryjVb3sRTj+bSubJxhUoiGlyWHZetZBn1E9b9H8kz
X-Google-Smtp-Source: AGHT+IFeYxQWOEg9/KSPYBJE718RTYkFRESgQ7bLV4H4uKCxjh5xOrdIvCDbkpLuk+BnSUHhI4NtgWqI2tDkjh5URuE=
X-Received: by 2002:a05:6402:194b:b0:5dc:7374:261d with SMTP id
 4fb4d7f45d1cf-5de44fe941dmr45111628a12.7.1739275700868; Tue, 11 Feb 2025
 04:08:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-4-mszeredi@redhat.com>
In-Reply-To: <20250210194512.417339-4-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Feb 2025 13:08:08 +0100
X-Gm-Features: AWEUYZnP4R_Ecf9ohG_FGGAHquMyjB1yOtMRFmaRwqbTHahwClFFE2TM8Jm6tbg
Message-ID: <CAOQ4uxjstNQS5CmW7uMMu=YeOR0_DfrV1VQx9f5DLFtsuAkQJg@mail.gmail.com>
Subject: Re: [PATCH 4/5] ovl: don't require metacopy=on for lower -> data redirect
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Subject: [PATCH] ovl: don't require metacopy=on for lower -> data redirect

Nit: the change does not require metacopy=on nor redirect_dir=follow
so maybe some short title like:

ovl: relax redirect/metacopy requirements for lower -> data redirect


> Allow the special case of a redirect from a lower layer to a data layer
> without having to turn on metacopy.  This makes the feature work with
> userxattr, which in turn allows data layers to be usable in user
> namespaces.
>
> Minimize the risk by only enabling redirect from a single lower layer to a
> data layer iff a data layer is specified.  The only way to access a data
> layer is to enable this, so there's really no reason no to enable this.
>
> This can be used safely if the lower layer is read-only and the
> user.overlay.redirect xattr cannot be modified.
>

Just need to verify that those assumptions are not broken by
upper index with metacopy/redirect -
I think the safety of redirect still holds, but not the safety
of the verity digest.

Thanks,
Amir.

> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  Documentation/filesystems/overlayfs.rst |  7 ++++++
>  fs/overlayfs/namei.c                    | 32 ++++++++++++++-----------
>  fs/overlayfs/params.c                   |  5 ----
>  3 files changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> index 6245b67ae9e0..5d277d79cf2f 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -429,6 +429,13 @@ Only the data of the files in the "data-only" lower layers may be visible
>  when a "metacopy" file in one of the lower layers above it, has a "redirect"
>  to the absolute path of the "lower data" file in the "data-only" lower layer.
>
> +Instead of explicitly enabling "metacopy=on" it is sufficient to specify at
> +least one data-only layer to enable redirection of data to a data-only layer.
> +In this case other forms of metacopy are rejected.  Note: this way data-only
> +layers may be used toghether with "userxattr", in which case careful attention
> +must be given to privileges needed to change the "user.overlay.redirect" xattr
> +to prevent misuse.
> +
>  Since kernel version v6.8, "data-only" lower layers can also be added using
>  the "datadir+" mount options and the fsconfig syscall from new mount api.
>  For example::
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index da322e9768d1..f9dc71b70beb 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1042,6 +1042,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>         char *upperredirect = NULL;
>         bool nextredirect = false;
>         bool nextmetacopy = false;
> +       bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
>         struct dentry *this;
>         unsigned int i;
>         int err;
> @@ -1053,7 +1054,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>                 .is_dir = false,
>                 .opaque = false,
>                 .stop = false,
> -               .last = ovl_redirect_follow(ofs) ? false : !ovl_numlower(poe),
> +               .last = check_redirect ? false : !ovl_numlower(poe),
>                 .redirect = NULL,
>                 .metacopy = 0,
>         };
> @@ -1141,7 +1142,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>                         goto out_put;
>                 }
>
> -               if (!ovl_redirect_follow(ofs))
> +               if (!check_redirect)
>                         d.last = i == ovl_numlower(poe) - 1;
>                 else if (d.is_dir || !ofs->numdatalayer)
>                         d.last = lower.layer->idx == ovl_numlower(roe);
> @@ -1222,21 +1223,24 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>                 }
>         }
>
> -       /* Defer lookup of lowerdata in data-only layers to first access */
> +       /*
> +        * Defer lookup of lowerdata in data-only layers to first access.
> +        * Don't require redirect=follow and metacopy=on in this case.
> +        */
>         if (d.metacopy && ctr && ofs->numdatalayer && d.absolute_redirect) {
>                 d.metacopy = 0;
>                 ctr++;
> -       }
> -
> -       if (nextmetacopy && !ofs->config.metacopy) {
> -               pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry);
> -               err = -EPERM;
> -               goto out_put;
> -       }
> -       if (nextredirect && !ovl_redirect_follow(ofs)) {
> -               pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n", dentry);
> -               err = -EPERM;
> -               goto out_put;
> +       } else {
> +               if (nextmetacopy && !ofs->config.metacopy) {
> +                       pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry);
> +                       err = -EPERM;
> +                       goto out_put;
> +               }
> +               if (nextredirect && !ovl_redirect_follow(ofs)) {
> +                       pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n", dentry);
> +                       err = -EPERM;
> +                       goto out_put;
> +               }
>         }
>
>         /*
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 1115c22deca0..54468b2b0fba 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -1000,11 +1000,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
>                  */
>         }
>
> -       if (ctx->nr_data > 0 && !config->metacopy) {
> -               pr_err("lower data-only dirs require metacopy support.\n");
> -               return -EINVAL;
> -       }
> -
>         return 0;
>  }
>
> --
> 2.48.1
>

