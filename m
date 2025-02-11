Return-Path: <linux-fsdevel+bounces-41542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7448FA316AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA6E3A7736
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BAF2638B9;
	Tue, 11 Feb 2025 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyAIEIKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A726562F;
	Tue, 11 Feb 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305854; cv=none; b=WzrqH1yGZ8HwRpviTjMAPyHkOskijqJG+qJMpX6A45RIOQSHhWD+QFvMLMTuc7E2/UwZHxgygskAxsE02GcTbhsIRADT9UF4KLLzdNVGXrdn8oN1KRNG8wI0CyE5/dxj5D0o7R9kmx/uvckdIF/iuW4b3NJWz0MvsJClmhVPKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305854; c=relaxed/simple;
	bh=D8rlnhGgOeAoSStj3i498DmFHncRDjC2SZuU9y2OCtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTmRHuKuUD8dUKKdTU+xgcnDG+H4m0KVwYLnoxsJGzF8+SxUY9DqapmSfTHsgrJiqGwmnZGPoCAjKo+cKR8vLvjzAxSYQkNnik5SijbPDMcIKM+z2N2jZmcQcZ+SwfSvgDjidxTsFH+ZJe10Fin3hKbiybzKLbLoHQPMRfFNuuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyAIEIKc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de64873d18so6050359a12.2;
        Tue, 11 Feb 2025 12:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739305851; x=1739910651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQGuDxDQUb2uUg1lPaNmdFHJpnrBsC6P0qXJSEPK2EE=;
        b=MyAIEIKcq0ZeVJ5OZMyMVROvHBY0SrLxYyXb4AldOn6tRKC7A9Qij/TnAgmrvaEkhl
         4Z/Ix3P/pXzjKnKvVG5DgAy+EXAu/NBwabiWFN5kSIiQhadkvzSt3HNYqTpJWW5vIG1s
         u66dmMI7TqSJDPtmicQpFd2mntRFp+/QXf7oK2rQWJ4W+vduEAQBGJ/J3kfGkeosq/aH
         0t/eFMV2SRT4BtxNi7WJeCrENxPa0yEiaaVTkHML2mmgPw8IConGP02bkC7SsEB6xEqu
         Nb2LSHYoud07h0w5+xsSRMPTJALO5qPtxPOL+rHL1aYGdHcyfeRUiQAOvxqWz2cC6hz6
         3SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739305851; x=1739910651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQGuDxDQUb2uUg1lPaNmdFHJpnrBsC6P0qXJSEPK2EE=;
        b=qFjaz7m5+w+Y0hqccCfo/FD48eIR6kUEiGsi/L99Jyn+Jhl+6Yqfk3Qn5ZEATke6Im
         Xp3NqIuYl2gqlUc/LDIQdQOLvsDJHL6ZY1K77NS6NaYTGMeZlPmQoPPHGTDSXpIk6AUo
         LqeEEZG4YfLqES3I5KVMeCP3krDiNw924WITVPL1RU5mYCR38h0IUnojPj0fPSAv79vh
         lFI3e3Vdga/66Ddnj2DYWabGYOR+7T70DT+vOlW9xgCpJNq09sLMkyxU9BHaI+RXG8/Z
         RExfOlKoH72n12c6nOKHkTIiZoUHPzyxORMc6yH4paN3xo3xLIwXfRdxjKajN5nDvvrG
         dpuw==
X-Forwarded-Encrypted: i=1; AJvYcCVXRJl2Q2foS/uTfH0SIIDU9QU76qiuyoZtWKozjdVy2VrXGS6rP7AA1oQhW9FkPIbFBQ5oCWU8@vger.kernel.org, AJvYcCWKPwcQwbAdKLNTeJq4kA15vwpEo36gzKjMojDAhdlW0ROdQoj0YBCFZcnCIGFK4/sGUYql/pciBXD4Yl+5@vger.kernel.org, AJvYcCXDCBYktRpob58ldtYTgi0vxpuxGtoTp3eR4A7GW+N99ZM6vGmU45dxL8+yXMhVxFuc20sovqejcfpB6Aft@vger.kernel.org, AJvYcCXjJZFTCD3QNv/FjotqYSSUQlb7o6NLWRyUjuW4584CehLAZMZqLbnLrljzke22azeO9z1zoQW8v/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDz0b0jn+TXIkk7pXomLxAhWzz2oMQMyIHYnxEKeiWcFG7NQWB
	V4DkTlJM6JNPYeoVLh+6QXSmQXmTz7uzt4j8KuUNEImZiwgEoY9emB5a7bvmy+4mYt/taIZkF1y
	vZ0GxgeW2kNS8FATB1v0ExO2s6sE=
X-Gm-Gg: ASbGncskGISvgJrtSy11eDcIlSrwlRH6MgHlOJY6kV1EhKYKGolfb0YNdY4bHq7DJAY
	7jn4HHfD1UBYBdcHRVSXcTVmSL2AjQPVDXr5wR3nKOX0W6qYiKl4x3gImlgICSRe4TflbsdZN
X-Google-Smtp-Source: AGHT+IEEGVBUptOIKr/vGakwvds0RDuYmv16k6LUMOxOXYI/gn2/BUXi9QFHNW2x9uLs0HMV4a21OETB6WtLcxC2t48=
X-Received: by 2002:a05:6402:2085:b0:5dc:cf9b:b034 with SMTP id
 4fb4d7f45d1cf-5deadd92165mr559976a12.14.1739305850702; Tue, 11 Feb 2025
 12:30:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org> <20250211-work-acct-v1-2-1c16aecab8b3@kernel.org>
In-Reply-To: <20250211-work-acct-v1-2-1c16aecab8b3@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Feb 2025 21:30:39 +0100
X-Gm-Features: AWEUYZlThT5fe-k1kkTGf00clBuDf-JG6eqz8Aq4p3RAFE_xeEBujJ-igzEEeoQ
Message-ID: <CAOQ4uxjncBJ=+-2J70m5sPtLiCzdHZ_mNWr4tVgGTODsMuQCvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] acct: block access to kernel internal filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: Zicheng Qu <quzicheng@huawei.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	jlayton@kernel.org, axboe@kernel.dk, joel.granados@kernel.org, 
	tglx@linutronix.de, viro@zeniv.linux.org.uk, hch@lst.de, len.brown@intel.com, 
	pavel@ucw.cz, pengfei.xu@intel.com, rafael@kernel.org, tanghui20@huawei.com, 
	zhangqiao22@huawei.com, judy.chenhui@huawei.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:17=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> There's no point in allowing anything kernel internal nor procfs or
> sysfs.
>
> Reported-by: Zicheng Qu <quzicheng@huawei.com>
> Link: https://lore.kernel.org/r/20250127091811.3183623-1-quzicheng@huawei=
.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  kernel/acct.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/kernel/acct.c b/kernel/acct.c
> index 48283efe8a12..6520baa13669 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -243,6 +243,20 @@ static int acct_on(struct filename *pathname)
>                 return -EACCES;
>         }
>
> +       /* Exclude kernel kernel internal filesystems. */
> +       if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT))=
 {
> +               kfree(acct);
> +               filp_close(file, NULL);
> +               return -EINVAL;
> +       }
> +
> +       /* Exclude procfs and sysfs. */
> +       if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
> +               kfree(acct);
> +               filp_close(file, NULL);
> +               return -EINVAL;
> +       }
> +
>         if (!(file->f_mode & FMODE_CAN_WRITE)) {
>                 kfree(acct);
>                 filp_close(file, NULL);
>
> --
> 2.47.2
>
>

