Return-Path: <linux-fsdevel+bounces-36205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D79DF5D9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 14:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46047163036
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A78F1D0F74;
	Sun,  1 Dec 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRMQrjie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A51D0E2B;
	Sun,  1 Dec 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733060663; cv=none; b=Hjt07GSbqXxrH0MeNzKi3H9T+Of68cyimGFgeTigc8zfFWsgUWnBHW4CfP4P00/92TCxaurOLokZEg3B3RpBVdz7tmVrCXCb9/1bfx9OjzhS+wG0c+tJJ26nTD9mB93VIoTfmXv31cPHt18X83MDDYhsv0ZzLe6y50R1MZM22Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733060663; c=relaxed/simple;
	bh=vPMEjaOctQnPG6RL8vjQSFsU33qjZlSYzJQKX0q719Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qk7w4410RtU1wuYTCXbDi8vjZ9Lw2CaF/lePe+UcSLVjNGByGbrm4cI2VCvHXr/G/ytOn6WbSAlxkN8pntD91/8qN/g0mQ5KFRNtbVYoqx/VXxofwmlGnkgpjpUoDyfI+2pu/gNuHLMMIgIFDVx60UOUJy4wW/Y+kF970A52VGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRMQrjie; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso555739366b.1;
        Sun, 01 Dec 2024 05:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733060660; x=1733665460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK82PSi9b3zJhoNnZ2LKOpkNpkqy8TuGIq2jAQF7E0c=;
        b=aRMQrjiehpEvDb0vBrFQMnh/5GO709q5JaPK1wsyBNLbDHcosk3R/DyoceoRH2ig0k
         aRFul7GrZtO0Gvc+sqcAxakmGejLmRonotj2ygQjBeTfBdp/UdH4C3fOWWYJ+Plm3mi9
         ayZIaBOmGhqH94/LtXaE+9UgaJk03qpJnYe2cxD+i4hVdWtweCwiB4JVyC6W4hZdqUcd
         qt/NL9iInZSMV6lfGTYvXhUWnVNNHkhz+qRDzsyAsawNCEh7QokBM1VVVp6tErbrSmlc
         bccvCiCt7IUCEYDCJb+ecGwryU9gayfQFV6m6uNQhcLSq90m3QALrU1BP6ft4+G8rakN
         Pw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733060660; x=1733665460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK82PSi9b3zJhoNnZ2LKOpkNpkqy8TuGIq2jAQF7E0c=;
        b=vRARmNellHOLfOjRuwWEW2vMAQWddl2HtIu2prXlcMTEdFMupb3InPogB8YIS6psbU
         UhLkCMryYf0oYzEusxcAuJjuCKcIFwAl1BG5bVfA20KxVpa32sJFEpGsAlR9s8tWFwew
         TBvIsciHhT8ip4BoWvi12bFDgyTi8cEanQaD6zDzL7oCoz+T+K37wkbAotcCzBw5B7gk
         4QoxdDXehIQUwTwEl4L9qlvNS3vzqLJXjlmemL5LhKc/RJ9dKQdw0+UiBQIovSlZrJiD
         0D1ATieKNEjdOZ/r5rtnFH7xTwGtmRnBJqYPvFmk0+zl7julixAsdZwcYWLS2LKglTZ7
         j3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX/0CwZpXGmtbK7WoS3jnWhpOzjeUgqU9r9GWrhBbmbDIPQw6SLTI5Z/+CiT6WuBa1szMHIFT7+uwxjuTi@vger.kernel.org, AJvYcCWNjiGzvlW+k5dGlz96Ifc8kex7UlhPX/gHuVIFmSEc10B19GqD2rqJdMaqG1ABJTciB4nGLCPoE4Nm@vger.kernel.org, AJvYcCXddj7SdOM3CGxA+Mi9JOtdCONxtNtZHM9hNT5Wh28ltY6CRv3Wmin3pQphrM5/nw0ClS3XTvQLNbPXZwpa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qzsPaMOZc2JJAsVqWq1esYtS9XMo57uhEfIUl32WXFxh81Tg
	zDd+J2ZMvELshgCQQbNpRxTCLZI+4F6Sh1kRDtN2UbF1wkTA0xq3gOE7D6Je9jP/rsBze8sTsWh
	OHNkVfYLl6OW5bWsBgTdPChDutGVc6lz3CEI=
X-Gm-Gg: ASbGncsX2NjeU31zyzgbCnkAzHr0v3S9V7RLqYzb673vB/njUo8KogegXmu8WcOEpqC
	k8d8KkWNAEVs+f+K9/A/Syz/65ytUb6I=
X-Google-Smtp-Source: AGHT+IFnUS75Arhsysulu7iRQ0qUZDWUVuP4yitwbUVLydRcwFyTFAKZgObEFLJ3sGz2tV4z9h7oiduJKk66KzqE69Y=
X-Received: by 2002:a17:906:2181:b0:aa5:c20:654 with SMTP id
 a640c23a62f3a-aa581033187mr1508803466b.42.1733060659902; Sun, 01 Dec 2024
 05:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org> <20241201-work-exportfs-v1-1-b850dda4502a@kernel.org>
In-Reply-To: <20241201-work-exportfs-v1-1-b850dda4502a@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Dec 2024 14:44:08 +0100
Message-ID: <CAOQ4uxiy0JbBFGydZBYAhM7qydj7xxwbsrqzwNtn2-X1O5Zi_g@mail.gmail.com>
Subject: Re: [PATCH 1/4] exportfs: add flag to indicate local file handles
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 2:13=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Some filesystems like kernfs and pidfs support file handles as a
> convenience to use name_to_handle_at(2) and open_by_handle_at(2) but
> don't want to and cannot be reliably exported. Add a flag that allows
> them to mark their export operations accordingly.
>
> Fixes: aa8188253474 ("kernfs: add exportfs operations")
> Cc: stable <stable@kernel.org> # >=3D 4.14
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/nfsd/export.c         | 8 +++++++-
>  include/linux/exportfs.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index eacafe46e3b673cb306bd3c7caabd3283a1e54b1..786551595cc1c2043e8c195c0=
0ca72ef93c769d6 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -417,6 +417,7 @@ static struct svc_export *svc_export_lookup(struct sv=
c_export *);
>  static int check_export(struct path *path, int *flags, unsigned char *uu=
id)
>  {
>         struct inode *inode =3D d_inode(path->dentry);
> +       const struct export_operations *nop;
>
>         /*
>          * We currently export only dirs, regular files, and (for v4
> @@ -449,11 +450,16 @@ static int check_export(struct path *path, int *fla=
gs, unsigned char *uuid)
>                 return -EINVAL;
>         }
>
> -       if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> +       if (!exportfs_can_decode_fh(nop)) {
>                 dprintk("exp_export: export of invalid fs type.\n");
>                 return -EINVAL;
>         }
>
> +       if (nop && nop->flags & EXPORT_OP_LOCAL_FILE_HANDLE) {
> +               dprintk("exp_export: filesystem only supports non-exporta=
ble file handles.\n");
> +               return -EINVAL;
> +       }
> +
>         if (is_idmapped_mnt(path->mnt)) {
>                 dprintk("exp_export: export of idmapped mounts not yet su=
pported.\n");
>                 return -EINVAL;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index a087606ace194ccc9d1250f990ce55627aaf8dc5..40f78c8e4f31b97b2101b6663=
4e8d1807c1bcc14 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -280,6 +280,7 @@ struct export_operations {
>                                                 */
>  #define EXPORT_OP_FLUSH_ON_CLOSE       (0x20) /* fs flushes file data on=
 close */
>  #define EXPORT_OP_ASYNC_LOCK           (0x40) /* fs can do async lock re=
quest */
> +#define EXPORT_OP_LOCAL_FILE_HANDLE            (0x80) /* fs only support=
s file handles, no proper export */
>         unsigned long   flags;
>  };

Please update Documentation/filesystems/nfs/exporting.rst.

Thanks,
Amir.

