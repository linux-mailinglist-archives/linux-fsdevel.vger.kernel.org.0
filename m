Return-Path: <linux-fsdevel+bounces-49084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A05AAB7B76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 04:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741B03ACDF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 02:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635FE288CBF;
	Thu, 15 May 2025 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ectuF76R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876782868AF;
	Thu, 15 May 2025 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275080; cv=none; b=tHhepTqeXJVL1PD+/EViwAnRAjU3rl9aPXFFYe0si3vk8ZCV/Zb2JePhaePd7NM8Dd79LckAWOslqhi2X6PzjSkDfrQaR7aT7xgvP9Zfl5EnodR4envyGVS02+wbN7kgnhCtpgcCr4eC1oXiQacnLKSp9pdicXCO2EIsvmJnKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275080; c=relaxed/simple;
	bh=lbUTWU/Rx8DK+HquB5uPkC42g9pbUnJh0plpcirTTkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRLU6G+VoEycJUEpP+tEibJDsQiW5QC5EKMADvpl9YJufCTLR/llXY2Eren5Q3FxlGTrNMryARE4pbgYwYlbe3ZCbB8CAo6FWFGm472pkUJOZij4DgE2CnDmiUOHOKRTqrg0L835fjsfn4Owf6jEmx0rTqNUEk7863HiIG0hkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ectuF76R; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747275063;
	bh=rTxQvpMLSNcVOKcn6wbW5lWtaBm1kK406d9NbimSnow=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=ectuF76RpGO5LDePpo+mwYUHKYla7Y2wvm5GQtOHrze7/mxTWxF+d2jKaTCAmw8iS
	 Ta60XBWHT6F83jYuNdOHV12j9azC2qoBcE8BY8wiAxacDsX13yJ4lrnb56YMNiT1Kf
	 mBfRfWhgl0Q4rTKZAyygYg+SxjmXdmez/YLBB3Hg=
X-QQ-mid: zesmtpsz6t1747275061te78de124
X-QQ-Originating-IP: jsoGGoEeb+00xjYT2ctfBF5W8oUBWVMsOMgM9xxAwWU=
Received: from mail-yb1-f176.google.com ( [209.85.219.176])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 May 2025 10:10:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2199364071913084691
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e78fc91f2dfso402330276.2;
        Wed, 14 May 2025 19:11:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRMXdNGMaUtEXz2aViU196+7gQsWiFaMWZi6n9VGhyDxgSphyYv2JremDpPwRxRzZL9Xva3QOg/P3VagUL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27bIhUP78HRKWViB/rGf69K3a6qJsHPrKmQ3kBEssgVOm43m1
	jnKo8SGgmwR0rOPcAclFD70+XFrCvhVeFJ3+1dKO4vV3lgu21U3PKlV2FCIxO7yAr1xjKFm5lVY
	OSpyKgUOasKcWtvJ8MGrkRPENISQ=
X-Google-Smtp-Source: AGHT+IEcTpS6zQJxpxnrY+D3AnzK4qhanDM2P3DsLjQ8F8f5An2lquKca7BheCeTGzpZVR/DUzO2NpmNFg5URIgbogI=
X-Received: by 2002:a05:690c:6907:b0:6fe:b701:6403 with SMTP id
 00721157ae682-70c94554d01mr12460527b3.11.1747275058510; Wed, 14 May 2025
 19:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514213243.3685364-1-rdunlap@infradead.org>
In-Reply-To: <20250514213243.3685364-1-rdunlap@infradead.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 15 May 2025 10:10:47 +0800
X-Gmail-Original-Message-ID: <F4B179B4D29930A5+CAC1kPDOOxsruVdFRQW0t53R6Xcn2bbaTm1ZLbuSfVTDADVNEJQ@mail.gmail.com>
X-Gm-Features: AX0GCFteXyHeXptJsq5R4RP1Lk25EnHmW00Q9ThbKv4cOt1-TGbGpFZf38cUvbw
Message-ID: <CAC1kPDOOxsruVdFRQW0t53R6Xcn2bbaTm1ZLbuSfVTDADVNEJQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: dev: avoid a build warning when PROC_FS is not set
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Chen Linxuan <chenlinxuan@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OVXq/nH9fia/5FXvxbgx2eXvYSmaLy6SbTaBLxdVmrc94+bPUKobWcMH
	9cbbpRgZFYhyqNvl19ila2zri12hTvNmdPgApRO0e2327T5EDnL4BgMYIz2RkAD5JidcUW3
	nqBLcoXhlwTuWw7trKbMLacD5+GBU/YDc5UV3TgR1UNLj+mFYbzAUjlpjI0QHl176b49QHh
	XL9v92u7S0aJ7DwebjGP4SrKsFOTbpvv1/M/K3du6jBVdO1l0rtAcbqgBqO8Iwx8oM7rUdy
	Hnj5jV5ZuJdQ+jG+RNkCbA0WgIm2sqrkoJUSeRYK60S45j3ncb8DOr+iXN7cELPNqByA5H3
	NjvDporr34Ecr6MwVJqvRkg+tRWP4ryyd6YdZveomvjaDOm8v5Iof7UpZH4liXjVuEuzYrk
	oYVSyKSXFzuKXZbLpOtTcwQuhzKH6DKZG+/zeFoIZJtxyJIDK8RQne0oA3GZjmPbA+7f1PX
	VCUq23ub91jgUpedfSxKn4NTyhoiprYA86ECe/cjuk1Dvu31D7/XErPHi9ROY0eoxhAqyr1
	GuMcTPxRob6B3qTHKY9mwXokEDU/KWXqfFS7KniYK3av1D8TvIKvt3B3knXgLWYe/1V3ZC5
	N6S4/QntzdfieSmonotnAHLgf/bUZmnsGHBiI1c+VixbnlfYdDr6SM1lJDehJm2iakOL50p
	Fq/t/apZtw/GeWd7yl0v/D+Eqfzl5HhDTMxtGuFF1hrlQkZjYcLZWI7V4ADUY3nFvowXhAA
	dCOXXCdaMrUvqHP+SANZTWBI+Jq/JPleQTQWlSoXnAnUHmmxUS9la4cx3jIs0fp65U7LPAv
	qGC2+R8/K1FROJYvS+3q2s6tqFwtsuS4rDHTo2vlq28fonhLzvEM/E9EKHq8FvfQbvztUPl
	Bu/M3lm59sKKLwnh7r8GLpleM9kZHZpxVWghJYcCa+xa6qnfiowh4HybzCEAlkteIyQczcp
	YxqE3WYePntBPxMiDznNTX0hAU3t0x3lMTTMuI+oCfcyX4g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Reviewed-by: Chen Linxuan <chenlinxuan@uniontech.com>

On Thu, May 15, 2025 at 5:42=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix a build warning when CONFIG_PROC_FS is not set by surrounding the
> function with #ifdef CONFIG_PROC_FS.
>
> fs/fuse/dev.c:2620:13: warning: 'fuse_dev_show_fdinfo' defined but not us=
ed [-Wunused-function]
>  2620 | static void fuse_dev_show_fdinfo(struct seq_file *seq, struct fil=
e *file)
>
> Fixes: 514d9210bf45 ("fs: fuse: add dev id to /dev/fuse fdinfo")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  fs/fuse/dev.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- linux-next-20250514.orig/fs/fuse/dev.c
> +++ linux-next-20250514/fs/fuse/dev.c
> @@ -2617,6 +2617,7 @@ static long fuse_dev_ioctl(struct file *
>         }
>  }
>
> +#ifdef CONFIG_PROC_FS
>  static void fuse_dev_show_fdinfo(struct seq_file *seq, struct file *file=
)
>  {
>         struct fuse_dev *fud =3D fuse_get_dev(file);
> @@ -2625,6 +2626,7 @@ static void fuse_dev_show_fdinfo(struct
>
>         seq_printf(seq, "fuse_connection:\t%u\n", fud->fc->dev);
>  }
> +#endif
>
>  const struct file_operations fuse_dev_operations =3D {
>         .owner          =3D THIS_MODULE,
>
>

