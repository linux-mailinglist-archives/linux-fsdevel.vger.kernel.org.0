Return-Path: <linux-fsdevel+bounces-25942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C842F952188
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDED41C216BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D41BC088;
	Wed, 14 Aug 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfRLM9sh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4271BC082
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657832; cv=none; b=sslbS+31bE8MTPHvJdRWPuSTnCigyMDMfIIBgEBEY49jveM3oL1Nrm0+I6RJpkaUPxwRjQuwuB9W2lL89g48YC2NN1MKsOhk/JYJ2j95bo1BjTsK2HgXWNvuxTL7ZPcCcKFg8BYdhV2+k0wL8aAAFjkt137SswmFtWA27E8aU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657832; c=relaxed/simple;
	bh=6PvxAwq/DC/88lgMUolx2vQbvJl6PfDizlJvIMQz6us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJMxRhffPlgX/ozm+jt/Xn+FsGixKn8oSRXdzazQ67fr+rw3LDosMeHmbbXOATGNHZyeC7sduS2JGAz8obckoAjwdcfVJcsh7MgwM84+V+HH0ekk8ZZcKRToVLGvWgafHgxW7+xvqn/aq6TlWJwqsgLxn0nVmV5yyvJpSY58p5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfRLM9sh; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db16129143so54706b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723657829; x=1724262629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS1so7ScFPa2t418LEK/3VTYkPtFWaRmuJpVGVJskCA=;
        b=UfRLM9shw5fiRmmA583AxkANYSQhd0e3Tuld2mwVMTKhTFhIWVoiMhmR4cAAXpB5+T
         NVCkGeJXZZEMCbrpJKJi2qavbH8cSZwzfz6FbQYvZFRsOmSEs8NR4imkK/zp6DECtrk+
         P0ZMLEHYpSBXmYTuQtHpK4mdXf6fKoVpcyC382n/kRDBNG+vZrRpuaf64s0ZwRoMYWSv
         Xh5yvC/UYFuKzscLCn9zvMY489hVKbzAiAP1SuOj55/ZTObOk3AA7ZgOZq0oVC6eag4+
         g7//H5CaFB+B3vFW1PeRai2F0bu83yGev/h+5fXMHrSszxaZlBsY1aKpCz56JFCc9OoS
         jRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657829; x=1724262629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yS1so7ScFPa2t418LEK/3VTYkPtFWaRmuJpVGVJskCA=;
        b=TpFZoQls56zbm7/3Rm76TawOOuOpHYzYuQLSEp6CLo+Q5Hjq2CWnIzCkQYT9DOxhN5
         UQyatxgWKnX8xFTmeiF3VMTB5n6g6EcPxO+VfyXQXdEujtzgoMWGMDoHjAPTFH0b6eAZ
         AF+FxngRBNehE+I0bvcRGL/miwUAkG2UxdeITKucB/G2TotugWluzSsdCDi/1DWPPbmo
         Zzqc3xqSFjH+V6agehj9Zn6z54pXTaIK0OdDqDf3OwsXFr2aPqSlNaI/e7wvYxYfn/sz
         qv13SpMqGcgn05Y1GRcTubXKWpE6X7hjs9Pba8aLGEtXXyxTL2grbKOgCeKblrUwQCyt
         CvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7TW0z+TeV4OO13mQHet2ioByjLO1W2Wa+uBkMUx6ZmY+3KMmuj0uErMNOMxEVnDzrL37bNihaZLnXq32L9wDSE6esHw0Ts1IuTWwHeA==
X-Gm-Message-State: AOJu0Yy8imV+XzGk2y2fMIEwa6GGZorjPhlXTHBYTqR1SUsG50SC/DXk
	g5A8n0wkj+4KJd6MqU3QER3A04qlBYshoadfebQFVnDm0jfXGVkWCH81y567yVHbPffRlXQO1ya
	zVzuYsnPMq+6D9mmCPtwirs5r+4Q=
X-Google-Smtp-Source: AGHT+IF20JBGhjb7iKHIiVv5z7aU2VOpMybEn6f3Ip0OoC3bmXfseH61tbFikoNw8PwFFTsXscbgDg8LWRfIMeju1wI=
X-Received: by 2002:a05:6808:16aa:b0:3d6:2e22:a09b with SMTP id
 5614622812f47-3dd29962915mr3529368b6e.37.1723657828833; Wed, 14 Aug 2024
 10:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813212149.1909627-1-joannelkoong@gmail.com> <6ff03b54-fac8-47d4-bbda-7ebf7f8c9572@linux.alibaba.com>
In-Reply-To: <6ff03b54-fac8-47d4-bbda-7ebf7f8c9572@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 Aug 2024 10:50:17 -0700
Message-ID: <CAJnrk1Y2TcJB+7gWw7fjomUzfOD1g8=pQB_Eh4PVE3--rF9pwg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	osandov@osandov.com, bernd.schubert@fastmail.fm, sweettea-kernel@dorminy.me, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:46=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> On 8/14/24 5:21 AM, Joanne Koong wrote:
> > Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
> > fetched from the server after an open.
> >
> > For fuse servers that are backed by network filesystems, this is
> > needed to ensure that file attributes are up to date between
> > consecutive open calls.
> >
> > For example, if there is a file that is opened on two fuse mounts,
> > in the following scenario:
> >
> > on mount A, open file.txt w/ O_APPEND, write "hi", close file
> > on mount B, open file.txt w/ O_APPEND, write "world", close file
> > on mount A, open file.txt w/ O_APPEND, write "123", close file
> >
> > when the file is reopened on mount A, the file inode contains the old
> > size and the last append will overwrite the data that was written when
> > the file was opened/written on mount B.
> >
> > (This corruption can be reproduced on the example libfuse passthrough_h=
p
> > server with writeback caching disabled and nopassthrough)
> >
> > Having this flag as an option enables parity with NFS's close-to-open
> > consistency.
>
> It seems a general demand for close-to-open consistency similar to NFS
> when the backend store for FUSE is a NFS-like filesystem.  We have a
> similar private implementation for close-to-open consistency in our
> internal distribution.  Also FYI there was a similar proposal for this:
>
> https://lore.kernel.org/linux-fsdevel/20220608104202.19461-1-zhangjiachen=
.jaycee@bytedance.com/

Thanks for the link. I think that proposal though only invalidates the
attributes on file open, but the use case we have needs the attributes
to be updated on open (so that the subsequent write call uses the
updated file size).

>
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c            | 7 ++++++-
> >  include/uapi/linux/fuse.h | 7 ++++++-
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index f39456c65ed7..437487ce413d 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, struct f=
ile *file)
> >       err =3D fuse_do_open(fm, get_node_id(inode), file, false);
> >       if (!err) {
> >               ff =3D file->private_data;
> > -             err =3D fuse_finish_open(inode, file);
> > +             if (ff->open_flags & FOPEN_FETCH_ATTR) {
> > +                     fuse_invalidate_attr(inode);
> > +                     err =3D fuse_update_attributes(inode, file, STATX=
_BASIC_STATS);
> > +             }
> > +             if (!err)
> > +                     err =3D fuse_finish_open(inode, file);
> >               if (err)
> >                       fuse_sync_release(fi, ff, file->f_flags);
> >               else if (is_truncate)
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index d08b99d60f6f..f5d1af6fe352 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -217,6 +217,9 @@
> >   *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
> >   *  - add FUSE_NO_EXPORT_SUPPORT init flag
> >   *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
> > + *
> > + *  7.41
> > + *  - add FOPEN_FETCH_ATTR
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -252,7 +255,7 @@
> >  #define FUSE_KERNEL_VERSION 7
> >
> >  /** Minor version number of this interface */
> > -#define FUSE_KERNEL_MINOR_VERSION 40
> > +#define FUSE_KERNEL_MINOR_VERSION 41
> >
> >  /** The node ID of the root inode */
> >  #define FUSE_ROOT_ID 1
> > @@ -360,6 +363,7 @@ struct fuse_file_lock {
> >   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBA=
CK_CACHE)
> >   * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the=
 same inode
> >   * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
> > + * FOPEN_FETCH_ATTR: attributes are fetched after file is opened
> >   */
> >  #define FOPEN_DIRECT_IO              (1 << 0)
> >  #define FOPEN_KEEP_CACHE     (1 << 1)
> > @@ -369,6 +373,7 @@ struct fuse_file_lock {
> >  #define FOPEN_NOFLUSH                (1 << 5)
> >  #define FOPEN_PARALLEL_DIRECT_WRITES (1 << 6)
> >  #define FOPEN_PASSTHROUGH    (1 << 7)
> > +#define FOPEN_FETCH_ATTR     (1 << 8)
> >
> >  /**
> >   * INIT request/reply flags
>
> Does this close-to-open consistency support writeback mode? AFAIK, the
> cached ctime/mtime/size at the kernel side are always trusted while
> these attributes from the server are dropped, see:

No, the use case we're running into doesn't have the writeback cache
enabled, so we haven't looked into what would be needed for full CTO
consistency on writeback mode.

>
> ```
> fuse_update_attributes
>     fuse_update_get_attr
>         cache_mask =3D fuse_get_cache_mask(inode)
>             if writeback mode:
>                 return STATX_MTIME | STATX_CTIME | STATX_SIZE
> ```
>
> Also FYI there's a similar proposal for enhancing the close-to-open
> consistency in writeback mode to fix the above issue:
>
> https://lore.kernel.org/linux-fsdevel/20220624055825.29183-1-zhangjiachen=
.jaycee@bytedance.com/
>
> Besides, IIUC this patch only implements the revalidate-on-open semantic
> for metadata.  To fulfill the full close-to-open consistency, do you
> need to disable FOPEN_KEEP_CACHE to fulfill the revalidate-on-open
> semantic for data? (Though the revalidate-on-open semantic for data is
> not needed in your append-only case.)

This patch is aimed at addressing the overwrite/corruption issue we've
been seeing rather than adding full support for close-to-open
consistency. We haven't so far had a need for revalidate-on-open for
data. I should have phrased the last sentence of the commit message as
"enables better parity with NFS's close-to-open consistency" :)


Thanks,
Joanne

>
> --
> Thanks,
> Jingbo

