Return-Path: <linux-fsdevel+bounces-69372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A78AC7893E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 11:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4D5A345265
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282BA34676F;
	Fri, 21 Nov 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTU7QGtu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A187262F
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722407; cv=none; b=ON4gm7SZcTUTYmMjbeI8qnisbGSDf8yUZ1jHKiwng5gTQrG3mvZuCdA/FaDw+qWqxZAqi19VhJSrd2VpiSpb+YH7T1Sgzg3zvtTDxaqKLIUMoh4S6xtgDfd32UxEVOeRkTBEcqyZjrwUFYdmZwcWwU9lo/aTdiKOy+qh97G1P5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722407; c=relaxed/simple;
	bh=cQXPSn2Ur2ik3WRgxLdh7H438xu/P3EZeeIhjHWIRI0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JDD0JoNyAtFs3oztcjp44fEMbVl9Cwep0hf1/3illVlnoFKJ4myKAAbDTPe5gPIxXD2OaHMRZJth1xztjG2N03K2lAeD/0rbS9OccM8PCmXE0ND1cdV7YVaGS++vSxtOQ17q1UJ9XUa+52jmMdpyuUGRHU+h/RF7vCWbLpUZDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTU7QGtu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso2090504a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 02:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763722404; x=1764327204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6mQTpIz45BgkTHy+yQrQ0oBeD9EtfH1TNIgiRIyiVY=;
        b=hTU7QGtu0997usE6cBJc+bkw/0mzGqUAZOGg8MjBnndtvbxBX2R/IjfjZWuirnCWHe
         C0NIyzK1kwnssTM8+5kWHJqvCj14FQOymeriYN7jm/os8pcTU4IdfCAWes0zZuef0GdV
         YfFtuhKkGe7bwYqk9n3cZSE8rSssvZafEbkKghw+bJ2h62KHj6EG8n1OOrg3Kek2b7A1
         45tUag+nEeC8JhUI7LpJAPPExqPg0L/knYLGVk3sXhUzb6yNgz+UE46oQQI0eGJN8PHM
         XTv71eeZoXkJ+TFGZCpisHUKcwLBxOU6woptL0hbh/OzFkA66WyQhebK1oE0iZoy84CU
         EEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763722404; x=1764327204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6mQTpIz45BgkTHy+yQrQ0oBeD9EtfH1TNIgiRIyiVY=;
        b=NF+LkIuCbwxLyVFt4xHSAWqVRVMq5jblrVd7fuJjku4FISHPahL/yUjIKRgSSbHB8K
         /WagBYcKflJBqoeOu9yhacK1/OW29TylwzQnphkgzt45YcVeokJx3FdGl0dz8mamMglC
         XGm8gz8HrlJKLDNvq4JCX98+0KxWuKneoT3jajp2JLqAyFGjPOaJ/43mQfOZ2EkPioys
         e8k6m6v1IarEtMjJiioCli5YrCcjvFlo7gXdqYCtjB5/M7vXgXWmQaWOzf4Ui++ZT8tQ
         9LioQV5RZ1MyzwsBoZ0SUUvDjh7bUMuDSRWM9Rihkt1/3Lzc4ryrrF69eJ5LpyOq1FmB
         AoUg==
X-Forwarded-Encrypted: i=1; AJvYcCUjoVWnK0CAGShG0fyWEgNjInF2RyH1SYT8BKYIpwjq3j5o7OnLVI/8gRxbQiZTaeNWeCDnV6vlhCvWRd9m@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKoe4m3ULN+zakmR38nZpjOyPLRILP4khyDkS4Ha0DYr9cDwk
	QSk98dNlCp8XkDUYpzWnO83eEsgLck5Os2/5LYD7Ue15tKzBknjvkxtvir7sAevEQCllTLu6BKi
	rYCeZdo0BudOIuA6PfaHXjoDvO0hNqug=
X-Gm-Gg: ASbGnct85+uS3mAZsi/hihE+TNq+SxdcJFM046W+fBcWPDJ7oF+GQuUXyEbeLUTUXS5
	fDN1MIgIgXZwfSLVL8q/98QqxYG9waI43FhUHu3zwpAoNW83zyn95DfGw8TZDyPLeTjBmyMgDVr
	2XRvOm2xPKMNNNI3Ekazoi/oqkXWV6RBRKEs/R/qyQVM6bCW8XfNdieE+FoISpPtf/q/cO3gaMt
	bzfBjrF93v9cJVFTmh94Eo1Z7DlGZ6ng7waYJLzHg3WHh4379K4heyAsWtblsAiD5uJPnHhUpY3
	0cdiLFH7wIBD6AmJYYYuW5zLquJeTA==
X-Google-Smtp-Source: AGHT+IG5GDdGneDWD68KbX65aJJ9mPVrJUr5zzecaLiiz7wURJCgwmoj9sd51silonEmlP2l1PB8hfH3NZwbKioii0Y=
X-Received: by 2002:a17:906:6a22:b0:b73:9892:7f46 with SMTP id
 a640c23a62f3a-b7657321324mr581020966b.29.1763722403658; Fri, 21 Nov 2025
 02:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 21 Nov 2025 11:53:12 +0100
X-Gm-Features: AWmQ_bnXdipyw9X2awn0Z7bLsGUlQGsLGXeHZw0WOV3PzdJmqLNsHrOTMUQgHZs
Message-ID: <CAOQ4uxgzThRacOhcwQcU6DAx7MEUc-8-Z6j9fSKzJp+kuc5=-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/3] fuse: implementation of export_operations with FUSE_LOOKUP_HANDLE
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[changing the subject to comment on this part separately]

On Thu, Nov 20, 2025 at 11:55=E2=80=AFAM Luis Henriques <luis@igalia.com> w=
rote:
>
>
> The export_operations were also modified to use this new file handle inst=
ead
> if the lookup_handle operation is implemented for the file system.
>
> Signed-off-by: Luis Henriques <luis@igalia.com>
...
>
> +enum {
> +       HANDLE_TYPE_NODEID      =3D 0,
> +       HANDLE_TYPE_HANDLE      =3D 1,
> +};
> +
>  struct fuse_inode_handle {
> -       u64 nodeid;
> -       u32 generation;
> +       u32 type;

I don't understand the reason for type as it is always categorically
determined by fc->lookup_handle in this code.

> +       union {

Perhaps not a union, see below...

> +               struct {
> +                       u64 nodeid;
> +                       u32 generation;
> +               };
> +               struct fuse_file_handle fh;

Feels like this should be struct fuse_file_handle *fh;

> +       };
>  };
>
>  static struct dentry *fuse_get_dentry(struct super_block *sb,
> @@ -1092,7 +1147,7 @@ static struct dentry *fuse_get_dentry(struct super_=
block *sb,
>                         goto out_err;
>                 }
>
> -               err =3D fuse_lookup_name(sb, handle->nodeid, &name, outar=
g,
> +               err =3D fuse_lookup_name(sb, handle->nodeid, NULL, &name,=
 outarg,
>                                        &inode);

This is a special case of LOOKUP where the parent is unknown.
Current fuse code does lookup for name "." in "parent" nodeid and servers
should know how to treat it specially.

I think that for LOOKUP_HANDLE, we can do one of two things.
Either we always encode the nodeid in NFS exported file handles
in addition to the server file handle,
or we skip the ilookup5() optimization and alway send LOOKUP_HANDLE
to the fuse server with nodeid 0 when the NFS server calls fuse_fh_to_dentr=
y()
so the server knows to lookup only by file handle.

The latter option sounds more robust, OTOH the ilookup5() "optimization"
could be quite useful, so not sure it is worth giving up on.

>                 kfree(outarg);
>                 if (err && err !=3D -ENOENT)
> @@ -1121,13 +1176,42 @@ static struct dentry *fuse_get_dentry(struct supe=
r_block *sb,
>         return ERR_PTR(err);
>  }
>
> +static int fuse_encode_lookup_fh(struct inode *inode, u32 *fh, int *max_=
len,
> +                                struct inode *parent)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       int total_len, len;
> +
> +       total_len =3D len =3D sizeof(struct fuse_file_handle);
> +       if (parent)
> +               total_len *=3D 2;
> +
> +       if (*max_len < total_len)
> +               return FILEID_INVALID;
> +
> +       memcpy(fh, &fi->fh, len);
> +       if (parent) {
> +               fi =3D get_fuse_inode(parent);
> +               memcpy((fh + len), &fi->fh, len);
> +       }
> +
> +       *max_len =3D total_len;
> +
> +       /* XXX define new fid_type */
> +       return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
> +}
> +

This is very odd.
I don't understand what you were trying to do here.
As far as I can see, you are not treating fuse_inode_handle as a variable
length struct that it is in the export operations.

>  static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>                            struct inode *parent)
>  {
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
>         int len =3D parent ? 6 : 3;
>         u64 nodeid;
>         u32 generation;
>
> +       if (fc->lookup_handle)
> +               return fuse_encode_lookup_fh(inode, fh, max_len, parent);
> +
>         if (*max_len < len) {
>                 *max_len =3D len;
>                 return  FILEID_INVALID;
> @@ -1156,30 +1240,51 @@ static int fuse_encode_fh(struct inode *inode, u3=
2 *fh, int *max_len,
>  static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
>                 struct fid *fid, int fh_len, int fh_type)
>  {
> +       struct fuse_conn *fc =3D get_fuse_conn_super(sb);
>         struct fuse_inode_handle handle;
>
>         if ((fh_type !=3D FILEID_INO64_GEN &&
>              fh_type !=3D FILEID_INO64_GEN_PARENT) || fh_len < 3)
>                 return NULL;
>
> -       handle.nodeid =3D (u64) fid->raw[0] << 32;
> -       handle.nodeid |=3D (u64) fid->raw[1];
> -       handle.generation =3D fid->raw[2];
> +       if (fc->lookup_handle) {
> +               if (fh_len < sizeof(struct fuse_file_handle))
> +                       return NULL;
> +               handle.type =3D HANDLE_TYPE_HANDLE;
> +               memcpy(&handle.fh, &fid->raw[0],
> +                      sizeof(struct fuse_file_handle));
> +       } else {
> +               handle.nodeid =3D (u64) fid->raw[0] << 32;
> +               handle.nodeid |=3D (u64) fid->raw[1];
> +               handle.generation =3D fid->raw[2];
> +       }
>         return fuse_get_dentry(sb, &handle);
>  }
>
>  static struct dentry *fuse_fh_to_parent(struct super_block *sb,
>                 struct fid *fid, int fh_len, int fh_type)
>  {
> -       struct fuse_inode_handle parent;
> +       struct fuse_conn *fc =3D get_fuse_conn_super(sb);
> +       struct fuse_inode_handle handle;
>
>         if (fh_type !=3D FILEID_INO64_GEN_PARENT || fh_len < 6)
>                 return NULL;
>
> -       parent.nodeid =3D (u64) fid->raw[3] << 32;
> -       parent.nodeid |=3D (u64) fid->raw[4];
> -       parent.generation =3D fid->raw[5];
> -       return fuse_get_dentry(sb, &parent);
> +       if (fc->lookup_handle) {
> +               struct fuse_file_handle *fh =3D (struct fuse_file_handle =
*)fid->raw;
> +
> +               if (fh_len < sizeof(struct fuse_file_handle) * 2)
> +                       return NULL;
> +               handle.type =3D HANDLE_TYPE_HANDLE;
> +               memcpy(&handle.fh, &fh[1],
> +                      sizeof(struct fuse_file_handle));
> +       } else {
> +               handle.type =3D HANDLE_TYPE_NODEID;
> +               handle.nodeid =3D (u64) fid->raw[3] << 32;
> +               handle.nodeid |=3D (u64) fid->raw[4];
> +               handle.generation =3D fid->raw[5];
> +       }
> +       return fuse_get_dentry(sb, &handle);
>  }
>

You may want to look at ovl_encode_fh() as an example of how overlayfs
encapsulates whatever file handle it got from the real filesystem and packs=
 it
as type OVL_FILEID_V1 to hand out to the NFS server.

If we go that route, then the FILEID_FUSE type may include the legacy
nodeid+gen and the server's variable length file handle following that.

To support "connectable" file handles (see AT_HANDLE_CONNECTABLE
and fstests test generic/777) would need to implement also handle type
FILEID_FUSE_WITH_PARENT, which is a concatenation of two
variable sized FILEID_FUSE handles.

But note that the fact that the server supports LOOKUP_HANDLE does not
mean that all NFS exported handles MUST be FILEID_FUSE handles.

I think we consider allowing the server to reply to LOOKUP_HANDLE without
a file handle argument (only nodeid+gen) for specific inodes (e.g. the
root inode).

If we allow that, then those inodes could still be encoded as FILEID_INO64_=
GEN
when exported to NFS and when fuse_fh_to_dentry() is requested to decide
a file handle of type FILEID_INO64_GEN, it may call LOOKUP_HANDLE
without nodeid and without a file handle and let the fuse server decide if =
this
lookup is acceptable (e.g. with FUSE_ROOT_ID) or stale.

One thing that would be useful with the above is that you will not
have to implement
encode/decode of FILEID_FUSE for the first version of LOOKUP_HANDLE.

First of all you could require FUSE_NO_EXPORT_SUPPORT for first version,
but even without it, a fuse server that supports LOOKUP_HANDLE can fail
LOOKUP_HANDLE requests without a file handle (or FUSE_ROOT_ID) and
even that will behave better than NFS export of fuse today (*).

Hope I was not piling too much and that I was not piling garbage.

Thanks,
Amir.

(*) In current fuse, fuse_fh_to_dentry() after fuse was unmounted and mount=
ed
may return ESTALE if nodeid is not already in inode cache and it may also
decode the wrong object if after fuse restart nodeid (with same gen)
was assigned
to a completely different object (yes that happens).

