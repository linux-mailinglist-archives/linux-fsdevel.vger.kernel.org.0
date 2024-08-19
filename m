Return-Path: <linux-fsdevel+bounces-26272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3F956D11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F071C22205
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064B16D33C;
	Mon, 19 Aug 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg/qa7hY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1DF15E5D6;
	Mon, 19 Aug 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077281; cv=none; b=f6On1BPfqSRPBxjoATO7YAecmPy4TlvkyLGv3OyTUGacHJIgtvzX930+SsgUURNFE30rpX2IUZs6zz5Aqau0lSNV5pvKIPGvYVl1uWGCgSDaG2Ar2UdZnQ3l4TnQRYL6aKVCHTcbyBCKqsx/LSLTUwvkhs4C0Scel8cu0RojdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077281; c=relaxed/simple;
	bh=dx6ZO0BIMTmiWI0sIISsa8iJl0ABOzeFMSuxGJWaaJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gqh5QODsNEKcuH/Wx/6LLtri6F0wMoRjiRLqACk1Y1qsvGPwRT9JXmeu4U0rUmaPqmYXVyQ2p3TO8YEk1avoGYuZDWERVC7/AvlHGNXzmk7unzbVtTClEnHfYSriInWYPmPJw77/ikhNRzc4sdaU4zG3h05KumWo9yBLMVTQQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg/qa7hY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1AFC4AF0F;
	Mon, 19 Aug 2024 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724077281;
	bh=dx6ZO0BIMTmiWI0sIISsa8iJl0ABOzeFMSuxGJWaaJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kg/qa7hYEWURebq39Wa3rcxx6iEtCsH1ZlmSYK99uaqgk2K+UYIoazAnHYjVOaIzZ
	 4q4qir1wbUzv+NybQeC6ak4PpeNijJC5v/nVxEvDJFo1CW6PoB7cwKksofjYhHbKwo
	 hF02LnZzk9bI4THwRHgksgUbtE2+64WeB+TE8JBrHKaqDGojsJwWdhDNLw+qaX7N4C
	 3qB2MF7r55FjrJcp0kmq2L4IMPiRsY6xDKfr/h69f/VhDoCWSjborzoOC8EXfFISv8
	 4ShkhBmCuAmp68CT26RyHjc0xsFdDy2D9yW9ZM9nP7cp6IX0U8L3HfoW8cr+ksQEbA
	 iy2U6Cy+63k3A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso5549608e87.2;
        Mon, 19 Aug 2024 07:21:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWD3f0/zBCkNlLe/nKB2zTrv/Qei0lq6/dQqBOwYCBVWduQmc1Pk6AZxdhvebAMiw6Ud5Q3AjMGDmPn/sStilcKfbS5Usy9F0rDxfG6Oo5lKNqYG2CcVmb6jla9a6Zj2LLzX5U3bcyM1++g+jm9wevrFI8ocIoXRKmBoRmRy3jHIfkAmD9G3w==
X-Gm-Message-State: AOJu0YxHpq9pCOEG/9M4Is+4WuTtdCaMCaPhaJnOMht8O17TXP/Yf7yR
	kt7z9+zjElkOj+8sj2jL6Z1HkmjJXJvPQbHgSv17uX8s+cZ9AKGlguep1Gl8j04oHQOmDeYWijN
	GlseAX8KO05F0U+7w1Q8qWhpq1is=
X-Google-Smtp-Source: AGHT+IGPpo3mZs3w8/MzrTebm4ko/Xsl5MauMqr6t/yCn7nQo94J9JSvvxK1pEgxKu5/6rApm/0cgplv4c3TJ9oDkQI=
X-Received: by 2002:a05:6512:304b:b0:530:dab8:7dde with SMTP id
 2adb3069b0e04-5331c6b9427mr5909920e87.34.1724077279646; Mon, 19 Aug 2024
 07:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819121528.70149-1-andrii.polianytsia@globallogic.com> <ZsNJNJE/bIWqsXl1@tissot.1015granger.net>
In-Reply-To: <ZsNJNJE/bIWqsXl1@tissot.1015granger.net>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 19 Aug 2024 23:21:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd98C6t2+h7Q8UC-p3fCTYtKCwmWvd4jCn1br_crc48KLw@mail.gmail.com>
Message-ID: <CAKYAXd98C6t2+h7Q8UC-p3fCTYtKCwmWvd4jCn1br_crc48KLw@mail.gmail.com>
Subject: Re: [PATCH] fs/exfat: add NFS export support
To: Chuck Lever <chuck.lever@oracle.com>
Cc: andrii.polianytsia@globallogic.com, sj1557.seo@samsung.com, 
	zach.malinowski@garmin.com, artem.dombrovskyi@globallogic.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> [ ... adding linux-nfs@vger.kernel.org ]
>
> On Mon, Aug 19, 2024 at 03:15:28PM +0300, andrii.polianytsia@globallogic.com wrote:
> > Add NFS export support to the exFAT filesystem by implementing
> > the necessary export operations in fs/exfat/super.c. Enable
> > exFAT filesystems to be exported and accessed over NFS, enhancing
> > their utility in networked environments.
> >
> > Introduce the exfat_export_ops structure, which includes
> > functions to handle file handles and inode lookups necessary for NFS
> > operations.
>
> My memory is dim, but I think the reason that exporting exfat isn't
> supported already is because it's file handles aren't persistent.
Yes, and fat is the same but it supports nfs.
They seem to want to support it even considering the -ESTALE result by eviction.
This patch seems to refer to /fs/fat/nfs.c code which has the same issue.
>
> NFS requires that file handles remain the same across server
> restarts or umount/mount cycles of the exported file system.
>
>
> > Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
> > Signed-off-by: Andrii Polianytsia <andrii.polianytsia@globallogic.com>
> > ---
> >  fs/exfat/super.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> > index 323ecebe6f0e..cb6dcafc3007 100644
> > --- a/fs/exfat/super.c
> > +++ b/fs/exfat/super.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/nls.h>
> >  #include <linux/buffer_head.h>
> >  #include <linux/magic.h>
> > +#include <linux/exportfs.h>
> >
> >  #include "exfat_raw.h"
> >  #include "exfat_fs.h"
> > @@ -195,6 +196,69 @@ static const struct super_operations exfat_sops = {
> >       .show_options   = exfat_show_options,
> >  };
> >
> > +/**
> > + * exfat_export_get_inode - Get inode for export operations
> > + * @sb: Superblock pointer
> > + * @ino: Inode number
> > + * @generation: Generation number
> > + *
> > + * Returns pointer to inode or error pointer in case of an error.
> > + */
> > +static struct inode *exfat_export_get_inode(struct super_block *sb, u64 ino,
> > +     u32 generation)
> > +{
> > +     struct inode *inode = NULL;
> > +
> > +     if (ino == 0)
> > +             return ERR_PTR(-ESTALE);
> > +
> > +     inode = ilookup(sb, ino);
> > +     if (inode && generation && inode->i_generation != generation) {
> > +             iput(inode);
> > +             return ERR_PTR(-ESTALE);
> > +     }
> > +
> > +     return inode;
> > +}
> > +
> > +/**
> > + * exfat_fh_to_dentry - Convert file handle to dentry
> > + * @sb: Superblock pointer
> > + * @fid: File identifier
> > + * @fh_len: Length of the file handle
> > + * @fh_type: Type of the file handle
> > + *
> > + * Returns dentry corresponding to the file handle.
> > + */
> > +static struct dentry *exfat_fh_to_dentry(struct super_block *sb,
> > +     struct fid *fid, int fh_len, int fh_type)
> > +{
> > +     return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
> > +             exfat_export_get_inode);
> > +}
> > +
> > +/**
> > + * exfat_fh_to_parent - Convert file handle to parent dentry
> > + * @sb: Superblock pointer
> > + * @fid: File identifier
> > + * @fh_len: Length of the file handle
> > + * @fh_type: Type of the file handle
> > + *
> > + * Returns parent dentry corresponding to the file handle.
> > + */
> > +static struct dentry *exfat_fh_to_parent(struct super_block *sb,
> > +     struct fid *fid, int fh_len, int fh_type)
> > +{
> > +     return generic_fh_to_parent(sb, fid, fh_len, fh_type,
> > +             exfat_export_get_inode);
> > +}
> > +
> > +static const struct export_operations exfat_export_ops = {
> > +     .encode_fh = generic_encode_ino32_fh,
> > +     .fh_to_dentry = exfat_fh_to_dentry,
> > +     .fh_to_parent = exfat_fh_to_parent,
> > +};
> > +
> >  enum {
> >       Opt_uid,
> >       Opt_gid,
> > @@ -633,6 +697,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
> >       sb->s_flags |= SB_NODIRATIME;
> >       sb->s_magic = EXFAT_SUPER_MAGIC;
> >       sb->s_op = &exfat_sops;
> > +     sb->s_export_op = &exfat_export_ops;
> >
> >       sb->s_time_gran = 10 * NSEC_PER_MSEC;
> >       sb->s_time_min = EXFAT_MIN_TIMESTAMP_SECS;
> > --
> > 2.25.1
> >
> >
>
> --
> Chuck Lever

