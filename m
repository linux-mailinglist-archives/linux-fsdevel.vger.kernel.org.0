Return-Path: <linux-fsdevel+bounces-26326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC69578C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 01:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2601C239FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 23:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAE11E211C;
	Mon, 19 Aug 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INSJaFF4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AE159565;
	Mon, 19 Aug 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110920; cv=none; b=knKQ9LR/DgIPrNS0MUeEZn+qps/GXF+9keo9eaTWnYZUgZb18/naPj6T82kVYpaSpH6C5bNVbgDKeIaxsvcNwPOQyGXjbMHR2gXbcVtKuilXdcPPPVkOy8Xdw/oTA5plVf9/DZj+Ic8QPIWH1u0YHNA+Mn9I6Y+AhMMQgW20GqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110920; c=relaxed/simple;
	bh=YfCiVYaRc7+OuAB2A1BJLJyxT0NwqKWRB2yB2ywALKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q79ON/D/etyhWZ8ZhArU8Xwggvn19zAy3HniFncFH75MwrXfWPIlbbf3xIcOKN3sSyW78ZmyzjNrR2AVJotgcjnlY5yQluaXA0bMwF1OMAydBZjwPPz4fk1fG3znGhJ9gYH1rpCJhdK3/0c+hhMxwlhdPy7dIRj1LgIMOCHiX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INSJaFF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E181CC32782;
	Mon, 19 Aug 2024 23:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724110919;
	bh=YfCiVYaRc7+OuAB2A1BJLJyxT0NwqKWRB2yB2ywALKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=INSJaFF4VS/9O+RAS9mX0P+xzUSoz8tcz3AWphtTVPYqU5JCrMH6v1IiMUe1zdeT0
	 Q9W0czHwQOKHNE7BeryTzlreCvuhdzcJ/7AfHERGjKbVJOP2FskzchaCWXhy/DAYpj
	 21HGB4bK83cDAVJ2+3SqK6fbeUUsQIV7cIKu/TkTFMVAuAA/jRFSQ5WjHs/am6zwW1
	 1JNidwaWbFGnp6WBwVm1IW004iaoF6UtBO2nIPK622U10WHezVUAgcf3geFH98/342
	 D+I1Q9cU3m91gs5f6D1RMr/SHEqvyH3ADotv8B4t5KLz75rvcwSxjPpRUckbbq01Tb
	 RodgDo+r5/mvA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f189a2a7f8so49439671fa.2;
        Mon, 19 Aug 2024 16:41:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpKdlLmKog4l9YlxMbouhLOD06P3PdkjvXANXNU9+a7/vZAo+hvppw/K1rxG74FM8A1C4o+Bf42uuEcIOq@vger.kernel.org, AJvYcCVMtY1iVwevoaFVgFBKF9jBBpfBooFTIiUMEf2dzarY9SDalYdiQol6FuQmjCU+PhnZnMlXXNcFW9qo@vger.kernel.org, AJvYcCWbHML8RomO8JidM2g0aSOVowOGFGk8Qw/uYMmCrMxm+N7Tkm8MaI6itlkapqsOekJLcl60d454G2K3F+XE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk5UhV69NMrbawFbFyFX4boONzvK4OzK+C9ZTkGR+UUvlmjfUf
	zDMGGftjzuKT/PtF0FR+6vwn808MngAWbCnkAwXI3DVG9q5IANEX9NDqLuTKTPRzN/1+LGgzd0v
	S8ermAY/wuzEnZOIvzEPSqfEg8xY=
X-Google-Smtp-Source: AGHT+IGvyi/qOE59Q6dbGXuWncHFkfcXlMN5t2rIZiiTBznZm06ezdGOHbgTCPn9UxQ+NwC3SphRcgJRcg1I8gPlWSQ=
X-Received: by 2002:a05:6512:1086:b0:52e:9b2f:c313 with SMTP id
 2adb3069b0e04-5331c6ac976mr8871763e87.22.1724110918161; Mon, 19 Aug 2024
 16:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819121528.70149-1-andrii.polianytsia@globallogic.com>
 <ZsNJNJE/bIWqsXl1@tissot.1015granger.net> <CAKYAXd98C6t2+h7Q8UC-p3fCTYtKCwmWvd4jCn1br_crc48KLw@mail.gmail.com>
 <ZsNZQRajNoZmllBU@tissot.1015granger.net>
In-Reply-To: <ZsNZQRajNoZmllBU@tissot.1015granger.net>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Aug 2024 08:41:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_1SOT7PW1dwt3b8FG=8Bm5E1FREskb8NLS6W60ZqJRyw@mail.gmail.com>
Message-ID: <CAKYAXd_1SOT7PW1dwt3b8FG=8Bm5E1FREskb8NLS6W60ZqJRyw@mail.gmail.com>
Subject: Re: [PATCH] fs/exfat: add NFS export support
To: Chuck Lever <chuck.lever@oracle.com>
Cc: andrii.polianytsia@globallogic.com, sj1557.seo@samsung.com, 
	zach.malinowski@garmin.com, artem.dombrovskyi@globallogic.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:40=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On Mon, Aug 19, 2024 at 11:21:05PM +0900, Namjae Jeon wrote:
> > >
> > > [ ... adding linux-nfs@vger.kernel.org ]
> > >
> > > On Mon, Aug 19, 2024 at 03:15:28PM +0300, andrii.polianytsia@globallo=
gic.com wrote:
> > > > Add NFS export support to the exFAT filesystem by implementing
> > > > the necessary export operations in fs/exfat/super.c. Enable
> > > > exFAT filesystems to be exported and accessed over NFS, enhancing
> > > > their utility in networked environments.
> > > >
> > > > Introduce the exfat_export_ops structure, which includes
> > > > functions to handle file handles and inode lookups necessary for NF=
S
> > > > operations.
> > >
> > > My memory is dim, but I think the reason that exporting exfat isn't
> > > supported already is because it's file handles aren't persistent.
> > Yes, and fat is the same but it supports nfs.
> > They seem to want to support it even considering the -ESTALE result by =
eviction.
> > This patch seems to refer to /fs/fat/nfs.c code which has the same issu=
e.
>
> Fair enough. I don't see a reference to fs/fat/nfs.c, so may I
> request that this added context be included in the patch description
> before this patch is merged?
Sure, I haven't decided yet whether to accept this patch.
I'll look into it more and decide.
>
> Out of curiosity, is any CI testing done on fat exported via NFS? At
> the moment I don't happen to include it in NFSD's CI matrix.
I don't maintain fat-fs, so I'm not sure if it's been verified with
some CI test.
However, if exfat support NFS export, I'll verify it with that test.
>
>
> > > NFS requires that file handles remain the same across server
> > > restarts or umount/mount cycles of the exported file system.
> > >
> > >
> > > > Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic=
.com>
> > > > Signed-off-by: Andrii Polianytsia <andrii.polianytsia@globallogic.c=
om>
> > > > ---
> > > >  fs/exfat/super.c | 65 ++++++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 65 insertions(+)
> > > >
> > > > diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> > > > index 323ecebe6f0e..cb6dcafc3007 100644
> > > > --- a/fs/exfat/super.c
> > > > +++ b/fs/exfat/super.c
> > > > @@ -18,6 +18,7 @@
> > > >  #include <linux/nls.h>
> > > >  #include <linux/buffer_head.h>
> > > >  #include <linux/magic.h>
> > > > +#include <linux/exportfs.h>
> > > >
> > > >  #include "exfat_raw.h"
> > > >  #include "exfat_fs.h"
> > > > @@ -195,6 +196,69 @@ static const struct super_operations exfat_sop=
s =3D {
> > > >       .show_options   =3D exfat_show_options,
> > > >  };
> > > >
> > > > +/**
> > > > + * exfat_export_get_inode - Get inode for export operations
> > > > + * @sb: Superblock pointer
> > > > + * @ino: Inode number
> > > > + * @generation: Generation number
> > > > + *
> > > > + * Returns pointer to inode or error pointer in case of an error.
> > > > + */
> > > > +static struct inode *exfat_export_get_inode(struct super_block *sb=
, u64 ino,
> > > > +     u32 generation)
> > > > +{
> > > > +     struct inode *inode =3D NULL;
> > > > +
> > > > +     if (ino =3D=3D 0)
> > > > +             return ERR_PTR(-ESTALE);
> > > > +
> > > > +     inode =3D ilookup(sb, ino);
> > > > +     if (inode && generation && inode->i_generation !=3D generatio=
n) {
> > > > +             iput(inode);
> > > > +             return ERR_PTR(-ESTALE);
> > > > +     }
> > > > +
> > > > +     return inode;
> > > > +}
> > > > +
> > > > +/**
> > > > + * exfat_fh_to_dentry - Convert file handle to dentry
> > > > + * @sb: Superblock pointer
> > > > + * @fid: File identifier
> > > > + * @fh_len: Length of the file handle
> > > > + * @fh_type: Type of the file handle
> > > > + *
> > > > + * Returns dentry corresponding to the file handle.
> > > > + */
> > > > +static struct dentry *exfat_fh_to_dentry(struct super_block *sb,
> > > > +     struct fid *fid, int fh_len, int fh_type)
> > > > +{
> > > > +     return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
> > > > +             exfat_export_get_inode);
> > > > +}
> > > > +
> > > > +/**
> > > > + * exfat_fh_to_parent - Convert file handle to parent dentry
> > > > + * @sb: Superblock pointer
> > > > + * @fid: File identifier
> > > > + * @fh_len: Length of the file handle
> > > > + * @fh_type: Type of the file handle
> > > > + *
> > > > + * Returns parent dentry corresponding to the file handle.
> > > > + */
> > > > +static struct dentry *exfat_fh_to_parent(struct super_block *sb,
> > > > +     struct fid *fid, int fh_len, int fh_type)
> > > > +{
> > > > +     return generic_fh_to_parent(sb, fid, fh_len, fh_type,
> > > > +             exfat_export_get_inode);
> > > > +}
> > > > +
> > > > +static const struct export_operations exfat_export_ops =3D {
> > > > +     .encode_fh =3D generic_encode_ino32_fh,
> > > > +     .fh_to_dentry =3D exfat_fh_to_dentry,
> > > > +     .fh_to_parent =3D exfat_fh_to_parent,
> > > > +};
> > > > +
> > > >  enum {
> > > >       Opt_uid,
> > > >       Opt_gid,
> > > > @@ -633,6 +697,7 @@ static int exfat_fill_super(struct super_block =
*sb, struct fs_context *fc)
> > > >       sb->s_flags |=3D SB_NODIRATIME;
> > > >       sb->s_magic =3D EXFAT_SUPER_MAGIC;
> > > >       sb->s_op =3D &exfat_sops;
> > > > +     sb->s_export_op =3D &exfat_export_ops;
> > > >
> > > >       sb->s_time_gran =3D 10 * NSEC_PER_MSEC;
> > > >       sb->s_time_min =3D EXFAT_MIN_TIMESTAMP_SECS;
> > > > --
> > > > 2.25.1
> > > >
> > > >
> > >
> > > --
> > > Chuck Lever
>
> --
> Chuck Lever

