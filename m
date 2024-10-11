Return-Path: <linux-fsdevel+bounces-31719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E1799A584
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AE31C244F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BAD218D9D;
	Fri, 11 Oct 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGIHMHet"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D18F5E
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654895; cv=none; b=QiJRlkGz1QysRMcO+8AwewMY7HlwFSLbxV/9tzCBGCS6IPKw8Xyv21JAvVolQ9TyLHj9nQamsDskgbf8LOeVqhgcMEu28NcVMW9MUQNpYLqtrsUfndCOa8pWnfjIMAH9xW2HoiCSDVl+ijm5by/+mOdcfsrqoNdPZXeOZXoLaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654895; c=relaxed/simple;
	bh=yv1UpZfLEo/Z4h83ZTq4y4lsSZHBysROobPXSNJ9NE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwDl2UAgjFof9geNRF/eT8JcF/2z7vW3r49EUHImzRhw3R88R1IVniUHXgi3Qw6hlA3hMubko7Hrda+jKEoruYwdvS9YZqJoBwHHlEanmyuo/f+xaQPCeOOzZ3qXNZVFfu+tZGyo1eGPq8xO4gL0OhWAeBrgp4ft18+cKEaRWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGIHMHet; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7afcf0625a9so202440885a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728654892; x=1729259692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcCIxy+V6zYrWc3kRSx6rSSqLJulutD6k6HG4gFHpIU=;
        b=PGIHMHetO2bEnAQmBgBgt9wp55DU/LzvATZCk5Doq4CJKtJuaCgEveMClHZyyZjvVZ
         djCF+LyMpdT2YMln0T54cQX3a68ZxMkwVfzZgBy6pMYNMzfLAluhEhRbt92Qd0wF1Z4C
         tcLtzy4rCK1+f7pFrM9gXR8bRMn5kwIRVoC1h2en3GCSS9pNrjeFrV9EeL2zhUxHN3FK
         ZcXrNICBLUW/SF29VvVgE4Blw5/dBh+87Ydy9SNun1p+6HleorEXonGzGFALEgK9tW1o
         UcxFNYuq7PYT19c4D74x3Eji0MlrUOxsfm7+BZNkOc3RkHZfrjx6p8WmP1DvxLbsMyaL
         IS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728654892; x=1729259692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcCIxy+V6zYrWc3kRSx6rSSqLJulutD6k6HG4gFHpIU=;
        b=TVup/AcKgy0biYlJGcrNUX2n7Vb6Qoz9I9aLepjB98t0yIOb4nYUJKmqTKrCRQujcw
         22NYVtc4MJgfd71GeB4NhBjBWWSW53peUbmuRPNS9zWEDaYFMWcDzOyTht9bhnoe1fip
         McKDMwxajxAPRn/a7upnlmIO1dyrxrtLKDXvHcptNh1cqCvzoqpbA3jamOEJx4zUyjAd
         3jwhMy+7XOSH70pMnUgbPLYJqGOuL/FO4fHaOBZL2ohtDg5w88tirTLgV8HOUCOL7b90
         HuqZhPtk8L0t/9M7cYI1Jg3Ihp54RhBMsPnnbdAGMBeMSbnY/npAncENb4JOok7rMU7p
         1ymw==
X-Forwarded-Encrypted: i=1; AJvYcCWZCeoLBXNZ0nuD7CJX6zgQPrtWpEygiHJOy7GNPaBBFOm1oDu6Zrk1gq4wqo6khEcfOaFNqwomvbC/aEEQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMaDfGmno2SOjQZ5UmxJitk38wmMcdxXGDsS+0YzmnSiMx4+f
	wh+dqJ14JEXGu3FFlnDLdVifV8HhHkJdFcW1WOCFCp+zjHzdcZK412pfxD1lYQOM47v8Pux1kfJ
	wxf8XuN4LDS2nZ6BWGQjvDoXwwoG5uMUr
X-Google-Smtp-Source: AGHT+IFsjbPReyDzBDEa+KLvZmMQ/hXUnYFbf6hZwidESSuDSLzhZqiEsHEHGkLxr7OIOK7FcgEPg9FWD4FT8ypybvA=
X-Received: by 2002:a05:620a:29c8:b0:7a9:ab72:7374 with SMTP id
 af79cd13be357-7b11a3a2094mr460464185a.35.1728654892086; Fri, 11 Oct 2024
 06:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011134601.667572-1-amir73il@gmail.com>
In-Reply-To: <20241011134601.667572-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Oct 2024 15:54:40 +0200
Message-ID: <CAOQ4uxg8TaduDnwRWJzZ280sFSH3tajqmaZ8ZeGnL6MaDQRKCQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: update inode size after extending passthrough write
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, yangyun <yangyun50@huawei.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wrong subject line - resending...

On Fri, Oct 11, 2024 at 3:46=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> yangyun reported that libfuse test test_copy_file_range() copies zero
> bytes from a newly written file when fuse passthrough is enabled.
>
> The reason is that extending passthrough write is not updating the fuse
> inode size and when vfs_copy_file_range() observes a zero size inode,
> it returns without calling the filesystem copy_file_range() method.
>
> Extend the fuse inode size to the size of the backing inode after every
> passthrough write if the backing inode size is larger.
>
> This does not yet provide cache coherency of fuse inode attributes and
> backing inode attributes, but it should prevent situations where fuse
> inode size is too small, causing read/copy to be wrongly shortened.
>
> Reported-by: yangyun <yangyun50@huawei.com>
> Closes: https://github.com/libfuse/libfuse/issues/1048
> Fixes: 57e1176e6086 ("fuse: implement read/write passthrough")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/fuse/passthrough.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index ba3207f6c4ce..d3047a4bc40e 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -20,9 +20,18 @@ static void fuse_file_accessed(struct file *file)
>
>  static void fuse_file_modified(struct file *file)
>  {
> +       struct fuse_file *ff =3D file->private_data;
> +       struct file *backing_file =3D fuse_file_passthrough(ff);
>         struct inode *inode =3D file_inode(file);
> -
> -       fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> +       loff_t size =3D i_size_read(file_inode(backing_file));
> +
> +       /*
> +        * Most of the time we will be holding inode_lock(), but even if =
we are
> +        * called from async io completion without inode_lock(), the last=
 write
> +        * will update fuse inode size to the size of the backing inode, =
even if
> +        * the last write was not the extending write.
> +        */
> +       fuse_write_update_attr(inode, size, size);
>  }
>
>  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *=
iter)
> --
> 2.34.1
>

