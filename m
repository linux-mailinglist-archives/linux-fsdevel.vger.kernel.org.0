Return-Path: <linux-fsdevel+bounces-64228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C2BDE14B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 12:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9967C4E4A3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AF731BC94;
	Wed, 15 Oct 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKPEWvqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2252D1319
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525540; cv=none; b=BcCZGTmBAtkPgO2HtWEz+arcDKMu+ngJZYwZjYZhCnWoZzXSeigG2QU3rUlnRzrYQD7cNfFVgOv8ooqIN7/Gq3jGSM6vzXQtKChDpx2+2eFzFErbWySrinQv7/0lsY8oAF1MMELD1bTNP5J5B21rBZIT/J8MHSmkjP7Uo8QhuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525540; c=relaxed/simple;
	bh=aExdlBsMUAecfDG+mSFT5MA0cBf07Nq0znf+EtSvsu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WD0ED6OWHod/bmYjB0KGojO/x9aDtCMHwsErH7cbQOlXm4yNSzX28d9KJh0Gg6TBPWaXP7SXCqklRCOP1ZeV9C3xHohN+Z03a35RMfDVRaR4Q5spMA/xoOe3jghnPomLjpVzNjgGrumSUbR9bWdbFvpM/wpojKeywIBVZ9SWAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKPEWvqL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4539dddd99so400982366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760525537; x=1761130337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcqlsCbRzqr036D+O+VNh2OgEfDSaoaWSXEdxRHLQzM=;
        b=KKPEWvqLiGJVOg0rnhuD7bCZ6SM7uihlzlHshc1/fKdHTQrpknJ05uJwWcmpWDT/WI
         nzQt+8bOeXhWRinXCQH8f2uRzT+zhYeJCBW16JbNXEcMV6mbAXN+IfelnoUz/y7sOTiX
         4Ylv644uzIk35umRIhq7HX0aiA351iUKfgZTqO078dp18JjrcGjGX6jpQE31FGjPAZuB
         sR12vgGNR9gaWEdja8/FtUhy5nkhif8HXgA5PaZ9Thi6QcFcr6Hs7M7+ahPJCPi8qxhL
         fIWptZnzDQ7pFaYi7Mis0QOt6pQdUdrisUOvOkg1i0fMk0EQk2Q+mUEZv12gNYOA2EEd
         w/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525537; x=1761130337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcqlsCbRzqr036D+O+VNh2OgEfDSaoaWSXEdxRHLQzM=;
        b=jHv3VHyV6d4JnncYCTyrPPY85epluCUaEfFlz3KrvVdYvSeY9RKkdQSm6tCquLjOqH
         MSlFirQNgHSLRPsE6y2zRInKRHAS0yj3KBg/UgYjjRf9PcXLBXHOG9FqaWm56goJPAFC
         SvgSHila0WigD0qsx66ymDDa+KgSYxTFYMoOPbc2JzmcpapOkpynDHsMZstTk4NdkMok
         uaB/tI90ft1sYv5LFV4aggzY9Yyiy/CKRr40VRqrMZ+QXlm9dNLuOReseU1ZtkJ0ABnR
         9v7i1IWkQlvwyI23PvcUP/eMCL4xNkdd0NGDSNAAmDHFOnEJuSd+2MpJ9ZdAgSSrM68o
         6S6g==
X-Forwarded-Encrypted: i=1; AJvYcCXkIAYY6TKJmdkSiOi77I/ghZ32PbaxgXildTQJeumv4S5GLCkfyoJGr2ftUWtFg9PJldZZMmZVKEsLIArC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6KVzFtiGwLvX/dvMRpTKp3DJn2zyDr8uoYn3dP9dhrj+6Vh5O
	Q4XfI1gEmc/qb6MW/6xQ47qIo6UUqItQj0zd1yER2dNMQCvPUm0Db0ZZpMqdwcfveSO1jLQ/2C3
	nCF6c7LiiN6tPh4eNX0mVCAays8wkAH0=
X-Gm-Gg: ASbGncubuL6uW1JE9QrF9pdL++v91LXElKXG/RbRnM6sqaas1O+72xYwQ/x7zRDcD0T
	4RtkkM+Ruf3Bfdu9Xv9Th/fvSyHyp7dAYXzvX4xuy9wk/a1aC7iFiBcFhKJ0ncn1GLUSu+vHxBv
	UvhMsYOtEPJocDZNwhm/t9PX2OQFuEvcnUNwE9m1XoO5QMM4WGPEYVnhMihhm4ZhhhBHCdAib5s
	AEIpFDarf/MwVpQCL3TfRMxovmDxvZUfUm0TlTBaW/W4HGXxVEBXNM+LAtd6/bGW0WYxg==
X-Google-Smtp-Source: AGHT+IGCRMPx4BwdY3lVuIUo/huZx/6YRTxB8GWkV4+i4ksr83vOWJmomDrJfxuexKKgqp9P0KqhYP0+oFuJJd3dueA=
X-Received: by 2002:a17:907:2daa:b0:b46:6718:3f37 with SMTP id
 a640c23a62f3a-b50aa387357mr2750519566b.16.1760525536817; Wed, 15 Oct 2025
 03:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014015707.129013-1-andrealmeid@igalia.com> <20251014015707.129013-2-andrealmeid@igalia.com>
In-Reply-To: <20251014015707.129013-2-andrealmeid@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Oct 2025 12:52:05 +0200
X-Gm-Features: AS18NWBOAnZXy6mzbOzuHQmyA6-7OJdOUSxYiYFk1-sWBbBBxuqeeJAHlfujs90
Message-ID: <CAOQ4uxit1W2SRzMs+yUeUodVxPa-YVKimmzBE=nMxeL5G8j2eA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted origin
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>, 
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 3:57=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Some filesystem have non-persistent UUIDs, that can change between
> mounting, even if the filesystem is not modified. To prevent
> false-positives when mounting overlayfs with index enabled, use the fsid
> reported from statfs that is persistent across mounts.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> This patch is just for illustrative purposes and doesn't work.
> ---
>  fs/overlayfs/copy_up.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index aac7e34f56c1..633d9470a089 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -8,6 +8,7 @@
>  #include <linux/fs.h>
>  #include <linux/slab.h>
>  #include <linux/file.h>
> +#include <linux/statfs.h>
>  #include <linux/fileattr.h>
>  #include <linux/splice.h>
>  #include <linux/xattr.h>
> @@ -421,9 +422,14 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs=
, struct inode *realinode,
>         struct ovl_fh *fh;
>         int fh_type, dwords;
>         int buflen =3D MAX_HANDLE_SZ;
> -       uuid_t *uuid =3D &realinode->i_sb->s_uuid;
> +       uuid_t uuid;
> +       struct kstatfs ks;
>         int err;
>
> +       // RFC: dentry can't be NULL, uuid needs a type cast
> +       realinode->i_sb->s_op->statfs(NULL, &ks);
> +       uuid.b =3D ks.f_fsid;
> +

Just wanted to add that from overlayfs POV, this is completely wrong,
because there are many fs whose fsid is not persistent including the
default fs that are used in many distros and the whole idea of the
origin xattr value is that it needs to be a persistent descriptor of the
lower layer directory.

Thanks,
Amir.

