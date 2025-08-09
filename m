Return-Path: <linux-fsdevel+bounces-57167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C3B1F3DB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 11:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4953A549D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001025394B;
	Sat,  9 Aug 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiCieD5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52E205E3B;
	Sat,  9 Aug 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733114; cv=none; b=I3dYaYsxPMjmZRBU0DKeqMuBsDxtQ38RsOLx2VObqTvSLS9ZDhGWaEuC7uBYcssewN7s8psZF+yclPQW+yErNDuxcV2i6MXcX16PuTKcK3VMUQofkrTkGQNnTOWR8Ii1f60CZfUeFI1R+P819tzfzVaw81ql/uU5I2lnp+vBHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733114; c=relaxed/simple;
	bh=uXpdtMrDl10Xu0lOg739r8X1r9k29hinmkFHnf1aYaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mm+NxrdoyesMKsW3pZ2b4GYspSJBwV7S9+oKuhcNsYrhn3WXuh9BJbM/nJIfx+wcvuIpKr32Wwz0mMs6KLDqc6ZtcSrYTfo5MUZ58PsaV+r/n9mBCxwKFm/1QAh30W7I0zf/rzm7vZFqJ6jj8OAeGdSPc7LDPcI8AOC96lrUmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiCieD5D; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so553390266b.3;
        Sat, 09 Aug 2025 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754733111; x=1755337911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T81Dy9FZ68xbhAottQwbnujNGEE3uUeGZPKXRu5Lpcs=;
        b=EiCieD5DdeCf3r9zOdD7tkp69WUnUbzXvLMvZJ6lnxMKpcGIE/fHwSNkLkJ6iIiqyS
         gfUs4kNjSDuQCcFQVgcJjxJ11Y6T0AjpT/XYgaxYZCKXVxkOTIh1bz5b/PPr4YagttGz
         a5b5hP8nyamcBdPKEcnf4u01w6mFBhuBCVC84186FruxVcsprw9hzxOPTwMDuHf0Bt2T
         onZc5HRqiqzOcN00D9Tx4BMknj/8QQ9yg5FY+NpzmTWEM3sFf0mbrXu2+11pJ/mzOA6d
         3WHqklozhhNj8sIwsAOOLiay7UsrbJwBnv+MeU3s4U77HjiN8aCi+zGiDRy3IvkmpjzT
         5mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754733111; x=1755337911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T81Dy9FZ68xbhAottQwbnujNGEE3uUeGZPKXRu5Lpcs=;
        b=Z/nDPhLAM2PDl93mxymlp7OzyqSTS6lTRNpEoS5RSR4/g38sujVwtdZly/ZQ/djg8b
         OTs8tpW00M28sjzjiczW5LphD+CvXMGsn8ZcJkrqOEWHSYjteSCvi+fvi1cVSb9w3bbk
         4lrWGVZ9JJibG0xGEpVA/NYY9GH+g7/Q2GRJFnvkHnhqxLEBxz/qSCrUjb8WL8gzLoV5
         Wz/+x8LK8jGfMxtTqxFSTxuRXZuiF6VTo3gRlJVSgEhFJYu9A6kU55SdbWD9BIFPKJzI
         nyLw1nkINI/nns6S+/TRbGGB1UcTo8/jBB9S5C/N6dPnV9edszxWysAuhjpMrNSg1SjV
         q/3w==
X-Forwarded-Encrypted: i=1; AJvYcCV/yT9OaVjbPE0t3L68t5PxsPa4RKVcuj4Yrrxj/7gUgupqleTeRNcVXKDmLa3ZxU7iMEop1L2/sn3487X0@vger.kernel.org, AJvYcCVEHZEP4+G8fHLpZY8tuPRv91ELe3RckAs3SfW36d4tZl5FfJHBtBGhKH6UumZ5xyviK3oqwhpoXgYRHIae@vger.kernel.org, AJvYcCVH7WBfQNGrx2zB/K+ldjtXYhTNbmWhyNYtY7cU0/JVozd+A9/yJO4AeT74DbltWC3hAdwgih4odeIXRh9Tsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7tsKM2GVdH9x1A/PF6RhptzQ/HSESwphTPlSCJLcaGxVU0PGC
	0NaxAE9iRVshAmvQGLd1IQySogNOgLSLtIjXKdGvcyiL+6zrgr83CGNTOA8r/9tXMguL/OrGqEH
	TA+OSnc8zYSD92t642v/PEjtpYnhez0c=
X-Gm-Gg: ASbGncuiYQWODDv/N3v6VOmevTasqjc4sthpwscAIZLKwAb/Lc+StEBTRlKkq9K3KVN
	+2jtAabizdoaoYDxHGjlTuXrs1CuSifiTWmHC6QPQQx5TJkTw08dY2gocooGMOQEdnj27TCM6BC
	jdDzBRl8PapXsxOx9ntqDN/f53+ZsvsoEg8rpFmzayCoMYJIaDL7Odj3fwii1rOLkaGkd1s2qXK
	v7GgwA=
X-Google-Smtp-Source: AGHT+IHoT7/WkIDUvJ/wMKgmrIDa1iTV9VBwmoEbPmsm3GH6Yr9nte4u/OHBT1dTPCAftC+n2FcQ3Y7Y69ZT2Y6LUiY=
X-Received: by 2002:a17:907:97d0:b0:af9:7b49:c0 with SMTP id
 a640c23a62f3a-af9c64bee9dmr553820566b.29.1754733110203; Sat, 09 Aug 2025
 02:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com> <20250808-tonyk-overlayfs-v3-6-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-6-30f9be426ba8@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Aug 2025 11:51:37 +0200
X-Gm-Features: Ac12FXwA0b5jCpUpWFRIo2_RbLDL8IDgbQQTfWYPjsI25XrrheBoBY2w13duUI0
Message-ID: <CAOQ4uxiDtq4LF-OVtQ6ufmcAZqLn-jqynM06RgHLgUYOW-uHHA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 6/7] ovl: Add S_CASEFOLD as part of the inode flag
 to be copied
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> To keep ovl's inodes consistent with their real inodes, add the
> S_CASEFOLD flag as part of the flags that need to be copied.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v2:
> - Instead of manually setting the flag if the realpath dentry is
>   casefolded, just add this flag as part of the flags that need to be
>   copied.
> ---
>  fs/overlayfs/overlayfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index bb0d7ded8e763a4a7a6fc506d966ed2f3bdb4f06..8a9a67d2933173c61b0fa0af5=
634d91e092e00b2 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -822,7 +822,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
>  void ovl_copyattr(struct inode *to);
>
>  /* vfs inode flags copied from real to ovl inode */
> -#define OVL_COPY_I_FLAGS_MASK  (S_SYNC | S_NOATIME | S_APPEND | S_IMMUTA=
BLE)
> +#define OVL_COPY_I_FLAGS_MASK  (S_SYNC | S_NOATIME | S_APPEND | S_IMMUTA=
BLE | S_CASEFOLD)
>  /* vfs inode flags read from overlay.protattr xattr to ovl inode */
>  #define OVL_PROT_I_FLAGS_MASK  (S_APPEND | S_IMMUTABLE)
>

Ok, this is simpler, but it's too simple.
OVL_COPY_I_FLAGS_MASK is used in copy up with the assumption that
all copied i_flags are related to fileattr flags, so you need something lik=
e:

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 27396fe63f6d..66bd43a99d2e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -670,7 +670,7 @@ static int ovl_copy_up_metadata(struct
ovl_copy_up_ctx *c, struct dentry *temp)
        if (err)
                return err;

-       if (inode->i_flags & OVL_COPY_I_FLAGS_MASK &&
+       if (inode->i_flags & OVL_FATTR_I_FLAGS_MASK &&
            (S_ISREG(c->stat.mode) || S_ISDIR(c->stat.mode))) {
                /*
                 * Copy the fileattr inode flags that are the source of alr=
eady
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index bb0d7ded8e76..f014802cfe55 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -821,10 +821,14 @@ struct inode *ovl_get_inode(struct super_block *sb,
                            struct ovl_inode_params *oip);
 void ovl_copyattr(struct inode *to);

-/* vfs inode flags copied from real to ovl inode */
-#define OVL_COPY_I_FLAGS_MASK  (S_SYNC | S_NOATIME | S_APPEND | S_IMMUTABL=
E)
-/* vfs inode flags read from overlay.protattr xattr to ovl inode */
+/* vfs fileattr flags read from overlay.protattr xattr to ovl inode */
 #define OVL_PROT_I_FLAGS_MASK  (S_APPEND | S_IMMUTABLE)
+/* vfs fileattr flags copied from real to ovl inode */
+#define OVL_FATTR_I_FLAGS_MASK (OVL_PROT_I_FLAGS_MASK | \
+                                S_SYNC | S_NOATIME)
+/* vfs inode flags copied from real to ovl inode */
+#define OVL_COPY_I_FLAGS_MASK  (OVL_FATTR_I_FLAGS_MASK | \
+                                S_CASEFOLD)

In addition we want a sanity check that S_CASEFOLD is always consistent
with the ovl global casefold state.
I think a WARN_ON assertion is enough even without failing:

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index df85a76597e9..53914b4039c0 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1300,6 +1300,7 @@ static struct dentry *ovl_get_root(struct super_block=
 *sb,
        ovl_dentry_set_flag(OVL_E_CONNECTED, root);
        ovl_set_upperdata(d_inode(root));
        ovl_inode_init(d_inode(root), &oip, ino, fsid);
+       WARN_ON(IS_CASEFOLDED(d_inode(root)) !=3D ofs->casefold);
        ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALID=
ATE);
        /* root keeps a reference of upperdentry */
        dget(upperdentry);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ecb9f2019395..ad97daf6641b 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1277,6 +1277,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
        }
        ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev);
        ovl_inode_init(inode, oip, ino, fsid);
+       WARN_ON_ONCE(IS_CASEFOLDED(inode) !=3D ofs->casefold);

        if (upperdentry && ovl_is_impuredir(sb, upperdentry))
                ovl_set_flag(OVL_IMPURE, inode);

Thanks,
Amir.

