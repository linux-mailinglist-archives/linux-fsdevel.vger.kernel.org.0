Return-Path: <linux-fsdevel+bounces-57173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB9B1F470
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 13:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16567AD1A7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43227E1C5;
	Sat,  9 Aug 2025 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmqUxmud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3E1C8612;
	Sat,  9 Aug 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754740265; cv=none; b=mdDXGhJsX2hhCXvIXSi5xzu+44sFlKbIiWABN/Zts8pD3spOeLmSZ25cegkeSg835JmHzfVYWhaeHQpnnYIm9GsxkoXzjpnGnXfnYqGdr3mshkt9PzfiLwmtKlOg2QaGusir/ikWbTVNhuSE1kQ4FqCoxr7W3fudpZCQQP5m4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754740265; c=relaxed/simple;
	bh=umgl5S5iD3CkVkoXfrjuAMTV5SQMCel30y8lHMmkFIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GH9VpHKXHUW+69e0SCCyUfA2DbLzJFSCFm/sdNrMQ1JcMQ/oFWJW0SRltL3ZBG2gZMFIX7VDIwehjnNiqiCkWRe53ZxWv5KNnWNv0qpjSA5pfSiSuHWLdb3nxjItU5PEPGxjZpcWAms8Tnx5AZQZwLfVDiHYvkQ+uaau9eGgZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmqUxmud; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so4732798a12.3;
        Sat, 09 Aug 2025 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754740262; x=1755345062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5akKwpC8IMkTFFts2eo/e1Duj9P6C50jyTgZzoqxgpQ=;
        b=CmqUxmudzzhshFvaSY6IOwUulVduCqnxoMBFTGqBIlUPS5jXpdfPaGGcsdqD2/hmLX
         QnrGfc/6hV/0/wmFLWvf74FxRk1Hqi2jM05j38+TiLNuPw3ZQWuUzmlhmuEOtvILI4jm
         ltuDZXcVTgFBunuPvRwCcllPguIhf7pp3qCe0nVTHoaSM1qT9gtfdchSLPW5f2Rne7xG
         i6Fyq9Oemo0Q+UfZAfbMGJDTQvP4VIRor0BHvYcCoiDyTPetpYoIiTexigO0ho7rfeW8
         k0EuSQ2/EvOH3EqmwixNf3JAOnxdc3BzR44MqpSUk94JQcjJ2QTIgY3WhR4kqEHU63nm
         EvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754740262; x=1755345062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5akKwpC8IMkTFFts2eo/e1Duj9P6C50jyTgZzoqxgpQ=;
        b=QQA4nTKwRLwR3knqWQ3FoRcZbSUtfj4fqFb8cagAcdcicIVC17WayY4JDFF4AZHXNT
         BW3iUcLthMGtjgFDb40NenzMFW07XKFBnlNmGE8c1NkiGTbzinTMq8Pek0RwsJNeANcB
         F2N98FrLV/uTkXfiEWkw5aZzwcmALMl9r+VOldP1pZEDBstBuCG01kn4UOyaAEuXzbWE
         cwIuDZRXlMAnaNkQ6AbQ2I7jkl2UPEJnVz57P7uQiWTpGxHd81qxQUsGlDV+tRKD9/ji
         ycvMOGpTrXBrs+7scwpfMKc8SeBYRcMbN0qSBf0zSAx4Bbq7WXxKm2soqsJQlZ3RnSSP
         lXtg==
X-Forwarded-Encrypted: i=1; AJvYcCWMDFQuMruZ09Tm8x3FRB8psSVkHrRbsbgQoCVM6cERiXFWm/icGtFMcbxoTOMNI28P3Fm/TP2E54jmkVYI@vger.kernel.org, AJvYcCXFqmR3DqcjsvtmAxVGFuZYse7ieqFC9h+iKMG3vnPXnk7F6aLg97VqYgOHl7jggZjABqiq67YZDnIGVerWNg==@vger.kernel.org, AJvYcCXnc+xk5cI1sO45X5hASLr++2CMCsbuxeyUyKnsPvsSoH6Yr8vvrk3i7ZHKByvUuqzfLPP2vmAUa5S/2xde@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1pJ1Pad+OZM1K4LkS/DwmHqYlT01zBHghoz7bWAfmn0Ab+X7U
	VooyE6qyq8M0GnlOhPYtOEz2NSvV+z9eW51ZmFQQR5M2ehpasjDFBKY1hIAUW7QqUJSPbia4mbR
	PDKldkCbij1dEZoSitFfhK1oVqmsz/Eg=
X-Gm-Gg: ASbGncs8Fuo8JlD6zpX8PHZwZzDKYQp6Dy8YbYRSg89OffaGWzo8eminEovIrGZ6Zk8
	LeQfWxDcNKqdTRNVSKiI8GN8OqaDjzf255CZfgeF81W4YipGHEEadQPeSUOvIzTdrFyqiUA8/GD
	f+zndGwVQgOd2OhWWaicLJU/9WGeuQxTeRTWcGH+/5azzj0Yor2FQjRdcY/npHYOvYEmd3mYOPJ
	tF4piY=
X-Google-Smtp-Source: AGHT+IHd+FBbW2YkPH15kNn5/vNwhRP3OgDWgNA2KUkXuXEBG1T+ThwFKa4VJOrTkPcVpl3JliNZ0rryShESGcvsHvs=
X-Received: by 2002:a17:907:3da2:b0:af9:5260:9ed3 with SMTP id
 a640c23a62f3a-af9c642fdddmr576516866b.14.1754740261464; Sat, 09 Aug 2025
 04:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com> <20250808-tonyk-overlayfs-v3-5-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-5-30f9be426ba8@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Aug 2025 13:50:50 +0200
X-Gm-Features: Ac12FXymfynjWT6oaNDg2pY7A5wkIJ6yOhqyJGu9_Eu5mvdmvf9djMKbJn-W9EE
Message-ID: <CAOQ4uxj+42O07HxnKrp5A2A-Gk0Z_WLDk=62Y9WZ7RRypdju2w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 5/7] ovl: Set case-insensitive dentry operations
 for ovl sb
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
> For filesystems with encoding (i.e. with case-insensitive support), set
> the dentry operations for the super block as ovl_dentry_ci_operations.
> Also, use the first layer encoding as the ovl super block encoding.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v2:
> - Create ovl_dentry_ci_operations to not override dentry ops set by
>   ovl_dentry_operations
> - Create a new function for this
> - Instead of setting encoding just when there's a upper layer, set it
>   for any first layer (ofs->fs[0].sb), regardless of it being upper or
>   not.
> ---
>  fs/overlayfs/super.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index bcb7f5dbf9a32e4aa09bc41596be443851e21200..68091bf8368a880d62d942555=
2613497d6e90b6b 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -161,6 +161,16 @@ static const struct dentry_operations ovl_dentry_ope=
rations =3D {
>         .d_weak_revalidate =3D ovl_dentry_weak_revalidate,
>  };
>
> +#if IS_ENABLED(CONFIG_UNICODE)
> +static const struct dentry_operations ovl_dentry_ci_operations =3D {
> +       .d_real =3D ovl_d_real,
> +       .d_revalidate =3D ovl_dentry_revalidate,
> +       .d_weak_revalidate =3D ovl_dentry_weak_revalidate,
> +       .d_hash =3D generic_ci_d_hash,
> +       .d_compare =3D generic_ci_d_compare,
> +};
> +#endif
> +
>  static struct kmem_cache *ovl_inode_cachep;
>
>  static struct inode *ovl_alloc_inode(struct super_block *sb)
> @@ -1318,6 +1328,21 @@ static struct dentry *ovl_get_root(struct super_bl=
ock *sb,
>         return root;
>  }
>
> +/*
> + * Set the ovl sb encoding as the same one used by the first layer
> + */
> +static void ovl_set_sb_ci_ops(struct super_block *ovl_sb, struct super_b=
lock *fs_sb)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +       if (sb_has_encoding(fs_sb)) {
> +               ovl_sb->s_encoding =3D fs_sb->s_encoding;
> +               ovl_sb->s_encoding_flags =3D fs_sb->s_encoding_flags;
> +       }
> +
> +       set_default_d_op(ovl_sb, &ovl_dentry_ci_operations);

I don't like it that set_default_d_op() is called twice and if anything thi=
s
helper should have been called only for the ofs->casefold enabled case.

what I suggest it to split to two helpers, first set dentry_ops based on
ofs->casefold determined before ovl_fill_super() is called:

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index df85a76597e9..00647440a566 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1307,6 +1307,19 @@ static struct dentry *ovl_get_root(struct
super_block *sb,
        return root;
 }

+static void ovl_set_d_op(struct super_block *sb)
+{
+       struct ovl_fs *ofs =3D sb->s_fs_info;
+
+#if IS_ENABLED(CONFIG_UNICODE)
+       if (ofs->casefold) {
+               set_default_d_op(ovl_sb, &ovl_dentry_ci_operations);
+               return;
+       }
+#endif
+       set_default_d_op(sb, &ovl_dentry_operations);
+}
+
 int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
        struct ovl_fs *ofs =3D sb->s_fs_info;
@@ -1322,7 +1335,7 @@ int ovl_fill_super(struct super_block *sb,
struct fs_context *fc)
        if (WARN_ON(fc->user_ns !=3D current_user_ns()))
                goto out_err;

-       set_default_d_op(sb, &ovl_dentry_operations);
+       ovl_set_d_op(sb);


> +#endif
> +}
> +
>  int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>         struct ovl_fs *ofs =3D sb->s_fs_info;
> @@ -1423,12 +1448,15 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>
>                 sb->s_stack_depth =3D upper_sb->s_stack_depth;
>                 sb->s_time_gran =3D upper_sb->s_time_gran;
> +

stray new line.

>         }
>         oe =3D ovl_get_lowerstack(sb, ctx, ofs, layers);
>         err =3D PTR_ERR(oe);
>         if (IS_ERR(oe))
>                 goto out_err;
>
> +       ovl_set_sb_ci_ops(sb, ofs->fs[0].sb);
> +

This is wrong because ofs->fs[0].sb is NULL on overlay without an upper dir=
.

Please consider doing this as part of patch 4 instead of using the
local sb1 var:

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -991,6 +991,19 @@ static int ovl_get_data_fsid(struct ovl_fs *ofs)
 }

+/*
+ * Set the ovl sb encoding as the same one used by the first layer
+ */
+static void ovl_set_encoding(struct super_block *sb, struct super_block *f=
s_sb)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+      if (sb_has_encoding(fs_sb)) {
+              sb->s_encoding =3D fs_sb->s_encoding;
+              sb->s_encoding_flags =3D fs_sb->s_encoding_flags;
+      }
+#endif
+}
+
 static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
                          struct ovl_fs_context *ctx, struct ovl_layer *lay=
ers)
 {
@@ -1024,6 +1036,8 @@ static int ovl_get_layers(struct super_block
*sb, struct ovl_fs *ofs,
        if (ovl_upper_mnt(ofs)) {
                ofs->fs[0].sb =3D ovl_upper_mnt(ofs)->mnt_sb;
                ofs->fs[0].is_lower =3D false;
+               if (ofs->casefold)
+                       ovl_set_encoding(sb, ofs->fs[0].sb);
        }

        nr_merged_lower =3D ctx->nr - ctx->nr_data;
@@ -1083,6 +1097,17 @@ static int ovl_get_layers(struct super_block
*sb, struct ovl_fs *ofs,
                l->name =3D NULL;
                ofs->numlayer++;
                ofs->fs[fsid].is_lower =3D true;
+
+               if (ofs->casefold) {
+                       if (!ovl_upper_mnt(ofs) && !sb_has_encoding(sb))
+                               ovl_set_encoding(sb, ofs->fs[fsid].sb);
+
+                       if (!sb_has_encoding(sb) ||
+                           !sb_same_encoding(sb, mnt->mnt_sb)) {
+                               pr_err("all layers must have the same
encoding\n");
+                               return -EINVAL;
+                       }
+               }
        }


Thanks,
Amir.

