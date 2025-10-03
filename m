Return-Path: <linux-fsdevel+bounces-63385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C53E6BB7B15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 19:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56DD1B20279
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0E2D9EE0;
	Fri,  3 Oct 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKrsYLYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3B2D9EE2
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511972; cv=none; b=bCRRuybMon3JsfH+DwoJNTwnF/r4gwNnArdwNffgOxZHgqrqYRyWkEQhu+86xEp2S/tCS219GsGsVyW1G+906wuIdMXy8dbdj2H98FYQQjf4HvdpWzEF0XqSrSy6sFFayt5yTp2qOErdJnFgX8RF4Ye+nL6K7JWKDiJi0iP+LDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511972; c=relaxed/simple;
	bh=d+hNHPCdcctqhqMwwfSI7ZqHOsINPXlQJG9fVF5g2zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIUZLNRZIpJMJbOCXO8wt9QZ9R2TGodMmAsDl43zQvj6pdTQ8Dkp0lWRXJ7C9/sjnnfnGRxIR7lJ8Bkl3kI2MHyzAFwbEjlF6a88L2U7Oz0Bjlzg4HQYTNjg0UucB8srtihbW6W2y7U71T5NlpZ3Um/+QZMFtr6CoBgX183LdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKrsYLYd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-796fe71deecso23876426d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759511969; x=1760116769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQeO7BRufyPD4hH+AuC8eieZK6LtCH///3sKMgHWdcs=;
        b=PKrsYLYd9YvkY0uaPodUcAjWc7wd/cRHC61t0Ne7dRTX3JeOJo+LXU0lI2Y5ETKvmT
         vdb4mxi11ZtLYsF8HsFLyK+Q+QZlzBXhQ9MzCEFlcOOJgpR/v2S1Gm+SJvv5GrL4F9BG
         pCDCb0CpTH8q2BCtavM9iAzCpUdnhIfqFxBNsf0clt5MwPho7qOgHOILXUvM6o/+m2TX
         e/XtcPxzMy+lFxJfSxPxH5SuwBzKhd1zqEG3eZIkCbgsjFb9+hCeptzW7EfgTbLCWbu2
         GBsY6iTJbAhEEiYpf68j8vvfw2ZFBPMvkSTmsbqThhbuu6crAhABko93J/XAGlC3Mzxk
         RCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511969; x=1760116769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQeO7BRufyPD4hH+AuC8eieZK6LtCH///3sKMgHWdcs=;
        b=ltDsRyUQWHKnzyUfyB3Kko67lGaJ7of9+UgmZq3luyiKL1+IkexkBIFxof5DcOEtB6
         vjbACseYSIwUPdnca3KyxH/XfBUmK3HqoQ+eVEG2AlsjNmbnbDJRr0TpnNw8Z3hQoXWP
         3MmYCp+BAERbgQffxlJadS/U1XQhl17RvUkkE5jmYo6tUV4gBhFyUl6uGHouJx9/8Qbi
         jC8g5VOrrdLSNZzEwI/ZYknSQEhS6/wI0gYYHCA2C9Bxr14O8IEdiSlWoBfkYdOIesxa
         3y8pCjqeWhLUamaLFl5WGuj4koLM+fttky5KLtu0aLsMZwcgCWsYc5Z/ERYp3Ap3Gxpt
         lOZw==
X-Forwarded-Encrypted: i=1; AJvYcCXSRqJu0+FFvVa5QU3ahzmL+aaUxO5RtPjTN2B9IsAY1c2E2DojD30lD8lrVQ+u/FP8/vPG4ngxB/A9z6E6@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXNm+iCjfC2kAPdHwWG+eZnRKYaq9ks9ECLuqyNd0macF9V4+
	TiuTfCeDiokCKhjg+q9m/4zQx6ZLiM3gz8hBQiIF8z81YsbSwokp5uBnmCkl4KAslurpqF/pJku
	UD2dpizZJN9zFNZ4UOqRJU7WM/DlhXDo=
X-Gm-Gg: ASbGncvCpyGhcsRR5pWxhtI2h9skDQHtbmEnIRlvKomxvE0uHvrHRoFE66aoB2UKDRN
	SXHNtParuxd7uOESuMCTMbxtDCRw+x4pPVgmflysQjgMkhBJnCwEcuU0WBICUwA9LvxM5hyCsNj
	zWSmCAT3jp97NUhVOQh1u/jOFW/lW/bfhaJVigHQvTGh3oZxpnET98c/fcBt15cH9/PTdu42HDf
	l0eoxGjJ2gTQ5KcXDhQqfRcj2kzm0qXUno8Ee8JZuzWW9hCDBCTTR/VNh2Ftb7ky+MpNK5pld3/
	8kquOWvJ9leMix5z7GH0/vOR0rUh25Ey91vQLfTnla9aSPG2iV9wFrsRD/DMk666JAVvRgZxEFb
	e6b1J/VIVZPCiDc0yfciw
X-Google-Smtp-Source: AGHT+IHJtS/x6vYENYT9s4+gKrjo3t25fmXx0XacnE1QxzxT02WiwpVugpLzABXgwGJPhAYyxaXY2dTT9sFt+ymrUuw=
X-Received: by 2002:a05:6214:f2d:b0:78e:c8a6:e891 with SMTP id
 6a1803df08f44-879dc7c2424mr39720346d6.24.1759511969364; Fri, 03 Oct 2025
 10:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925151140.57548-1-cel@kernel.org> <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be>
In-Reply-To: <87tt0gqa8f.fsf@mailhost.krisman.be>
From: Steve French <smfrench@gmail.com>
Date: Fri, 3 Oct 2025 12:19:17 -0500
X-Gm-Features: AS18NWAoWePf6tujqsrp1caBJcHKR4HE6V90mW4cx36rU4If80AaEbpRTvIDhcU
Message-ID: <CAH2r5mtjkgHSvWDALb6anDrw=skmg_iqZNXCgGv9vEPbci-0XA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Amir Goldstein <amir73il@gmail.com>, Chuck Lever <cel@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Volker Lendecke <Volker.Lendecke@sernet.de>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 10:52=E2=80=AFAM Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Thu, Sep 25, 2025 at 5:21=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Both the NFSv3 and NFSv4 protocols enable NFS clients to query NFS
> >> servers about the case sensitivity and case preservation behaviors
> >> of shared file systems. Today, the Linux NFSD implementation
> >> unconditionally returns "the export is case sensitive and case
> >> preserving".
> >>
> >> However, a few Linux in-tree file system types appear to have some
> >> ability to handle case-folded filenames. Some of our users would
> >> like to exploit that functionality from their non-POSIX NFS clients.
> >>
> >> Enable upper layers such as NFSD to retrieve case sensitivity
> >> information from file systems by adding a statx API for this
> >> purpose. Introduce a sample producer and a sample consumer for this
> >> information.
> >>
> >> If this mechanism seems sensible, a future patch might add a similar
> >> field to the user-space-visible statx structure. User-space file
> >> servers already use a variety of APIs to acquire this information.
> >>
> >> Suggested-by: Jeff Layton <jlayton@kernel.org>
> >> Cc: Volker Lendecke <Volker.Lendecke@sernet.de>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/fat/file.c             |  5 +++++
> >>  fs/nfsd/nfs3proc.c        | 35 +++++++++++++++++++++++++++--------
> >>  include/linux/stat.h      |  1 +
> >>  include/uapi/linux/stat.h | 15 +++++++++++++++
> >>  4 files changed, 48 insertions(+), 8 deletions(-)
> >>
> >> I'm certain this RFC patch has a number of problems, but it should
> >> serve as a discussion point.
> >>
> >>
> >> diff --git a/fs/fat/file.c b/fs/fat/file.c
> >> index 4fc49a614fb8..8572e36d8f27 100644
> >> --- a/fs/fat/file.c
> >> +++ b/fs/fat/file.c
> >> @@ -413,6 +413,11 @@ int fat_getattr(struct mnt_idmap *idmap, const st=
ruct path *path,
> >>                 stat->result_mask |=3D STATX_BTIME;
> >>                 stat->btime =3D MSDOS_I(inode)->i_crtime;
> >>         }
> >> +       if (request_mask & STATX_CASE_INFO) {
> >> +               stat->result_mask |=3D STATX_CASE_INFO;
> >> +               /* STATX_CASE_PRESERVING is cleared */
> >> +               stat->case_info =3D statx_case_ascii;
> >> +       }
> >>
> >>         return 0;
> >>  }
> >> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> >> index b6d03e1ef5f7..b319d1c4385c 100644
> >> --- a/fs/nfsd/nfs3proc.c
> >> +++ b/fs/nfsd/nfs3proc.c
> >> @@ -697,6 +697,31 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
> >>         return rpc_success;
> >>  }
> >>
> >> +static __be32
> >> +nfsd3_proc_case(struct svc_fh *fhp, struct nfsd3_pathconfres *resp)
> >> +{
> >> +       struct path p =3D {
> >> +               .mnt            =3D fhp->fh_export->ex_path.mnt,
> >> +               .dentry         =3D fhp->fh_dentry,
> >> +       };
> >> +       u32 request_mask =3D STATX_CASE_INFO;
> >> +       struct kstat stat;
> >> +       __be32 nfserr;
> >> +
> >> +       nfserr =3D nfserrno(vfs_getattr(&p, &stat, request_mask,
> >> +                                     AT_STATX_SYNC_AS_STAT));
> >> +       if (nfserr !=3D nfs_ok)
> >> +               return nfserr;
> >> +       if (!(stat.result_mask & STATX_CASE_INFO))
> >> +               return nfs_ok;
> >> +
> >> +       resp->p_case_insensitive =3D
> >> +               stat.case_info & STATX_CASE_FOLDING_TYPE ? 0 : 1;
> >> +       resp->p_case_preserving =3D
> >> +               stat.case_info & STATX_CASE_PRESERVING ? 1 : 0;
> >> +       return nfs_ok;
> >> +}
> >> +
> >>  /*
> >>   * Get pathconf info for the specified file
> >>   */
> >> @@ -722,17 +747,11 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
> >>         if (resp->status =3D=3D nfs_ok) {
> >>                 struct super_block *sb =3D argp->fh.fh_dentry->d_sb;
> >>
> >> -               /* Note that we don't care for remote fs's here */
> >> -               switch (sb->s_magic) {
> >> -               case EXT2_SUPER_MAGIC:
> >> +               if (sb->s_magic =3D=3D EXT2_SUPER_MAGIC) {
> >>                         resp->p_link_max =3D EXT2_LINK_MAX;
> >>                         resp->p_name_max =3D EXT2_NAME_LEN;
> >> -                       break;
> >> -               case MSDOS_SUPER_MAGIC:
> >> -                       resp->p_case_insensitive =3D 1;
> >> -                       resp->p_case_preserving  =3D 0;
> >> -                       break;
> >>                 }
> >> +               resp->status =3D nfsd3_proc_case(&argp->fh, resp);
> >>         }
> >>
> >>         fh_put(&argp->fh);
> >> diff --git a/include/linux/stat.h b/include/linux/stat.h
> >> index e3d00e7bb26d..abb47cbb233a 100644
> >> --- a/include/linux/stat.h
> >> +++ b/include/linux/stat.h
> >> @@ -59,6 +59,7 @@ struct kstat {
> >>         u32             atomic_write_unit_max;
> >>         u32             atomic_write_unit_max_opt;
> >>         u32             atomic_write_segments_max;
> >> +       u32             case_info;
> >>  };
> >>
> >>  /* These definitions are internal to the kernel for now. Mainly used =
by nfsd. */
> >> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> >> index 1686861aae20..e929b30d64b6 100644
> >> --- a/include/uapi/linux/stat.h
> >> +++ b/include/uapi/linux/stat.h
> >> @@ -219,6 +219,7 @@ struct statx {
> >>  #define STATX_SUBVOL           0x00008000U     /* Want/got stx_subvol=
 */
> >>  #define STATX_WRITE_ATOMIC     0x00010000U     /* Want/got atomic_wri=
te_* fields */
> >>  #define STATX_DIO_READ_ALIGN   0x00020000U     /* Want/got dio read a=
lignment info */
> >> +#define STATX_CASE_INFO                0x00040000U     /* Want/got ca=
se folding info */
> >>
> >>  #define STATX__RESERVED                0x80000000U     /* Reserved fo=
r future struct statx expansion */
> >>
> >> @@ -257,4 +258,18 @@ struct statx {
> >>  #define STATX_ATTR_WRITE_ATOMIC                0x00400000 /* File sup=
ports atomic write operations */
> >>
> >>
> >> +/*
> >> + * File system support for case folding is available via a bitmap.
> >> + */
> >> +#define STATX_CASE_PRESERVING          0x80000000 /* File name case i=
s preserved */
> >> +
> >> +/* Values stored in the low-order byte of .case_info */
> >> +enum {
> >> +       statx_case_sensitive =3D 0,
> >> +       statx_case_ascii,
> >> +       statx_case_utf8,
> >> +       statx_case_utf16,
> >> +};
> >> +#define STATX_CASE_FOLDING_TYPE                0x000000ff
>
> Does the protocol care about unicode version?  For userspace, it would
> be very relevant to expose it, as well as other details such as
> decomposition type.



The (SMB2/SMB3/SMB3.1.1) protocol specification documentation refers
to https://www.unicode.org/versions/Unicode5.0.0/ and states
"Unless otherwise specified, all textual strings MUST be in Unicode
version 5.0 format, as specified in [UNICODE], using the 16-bit
Unicode Transformation Format (UTF-16) form of the encoding."

--=20
Thanks,

Steve

