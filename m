Return-Path: <linux-fsdevel+bounces-41506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB98A307DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 11:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D43F3A3ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBEE1F2B9C;
	Tue, 11 Feb 2025 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsdXNvrd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85C1F2391;
	Tue, 11 Feb 2025 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268094; cv=none; b=liFtXIDlnFd0HwqxF+nh/5EMYHwLcuyo2C88PZIqMBoq+jS2k3U2KU9kDkaCDVjsZlm4NFZwZ+1bIw1+pZ0oLP/l2wOXnibXNtfzAS3HKqPAXOZCznsmzoHl2JNqURP97BS45MRrsXKtDW5KurnZRPNYV6oVcWS49AO2L8jvKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268094; c=relaxed/simple;
	bh=HASz2SIXkZk7wVz66HBZBa0aLQg22tcnuQpb+8/n5Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/bKc7F9skSLz/FESRVovTwhLtUrU7COLJXmmuyhaMqM2y7X6VQfFDNAvYo8QeLEOfyQ4/aDzIxrUIu2V9IGIp7090hYcPI8kpBn3EEFv7hLTurDC2U6ofAJHMnYDu2rYsD5Rib/uOppHHOHJo4T/59PeuWLODGQjo+rI55YYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsdXNvrd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab78e6edb48so568760866b.2;
        Tue, 11 Feb 2025 02:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739268091; x=1739872891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drxTkmiH59O7gmAzQISbFw15AbvxlUD3UzcmVMUxQaQ=;
        b=JsdXNvrdZE5/Tg0wxFhxOU3UW2ZnI89ZgB8FN+H1LmxefDhcXPsVZr+OTfC1JXOsZq
         jpVPQABDpWUMO1qaJ+UDFzvVgaOsNrgtpvzC6DN6STpYnlHpDNcBKfGyLkj7WNof51tF
         z9ciSBnrrDa99Mf48VQTQbI4wBxqCdJUw5Z72erXTIF4U4yzCAMKkXA7TovgMMoJViNJ
         mg7U8l3AhfaM3m7ey9QwdOaaGNiYp80Gu/uxLf1+LkgvdcqC2xBnvttpNlF8+kCJ/Un5
         HqXp4KrABvClrlgFsVakQ8ED2DwcmFElWRhbihkNNEVdCd/okb0NAJY+kxsIl8jxZhky
         Pgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739268091; x=1739872891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drxTkmiH59O7gmAzQISbFw15AbvxlUD3UzcmVMUxQaQ=;
        b=iJM1eh8oiosgtJ+gBqRgEOH1xcT75+cIsP2cHJWcVfmFkeLvfMfB5/s2uDE2uZeygr
         Z1qC3FPhtqGrr0i+WceqOUwMvjv6lgaEdZlS8RzSDmXRtECVSA2cUdUvNlsYuVIP24Fg
         f12T87kFafgu+6zmC/dB8Ftm90355bH6WEnuKkiNfAu3IQPD48rL2ewH7C/q9xaN9oX4
         1aERSNy5xqpw528gB0RdfOLO1EuA5Yc6gnnUHyhiejBXqF/8qryVI/XVte3gRySnSUVM
         hZ2wUs/8Ow0HXCNAWsg5Ni9Bci4Leb+6cUtuWdT3vRI7TiamGZYLlEH84CvdHOXMEiuC
         +bvA==
X-Forwarded-Encrypted: i=1; AJvYcCWYxvN2XIcFkV/c7594uoyvUPgXwNxAEwGo4pnfAIACl2xtIh6IqUUHEWU6GNarnyQrn7E3Ym9mX1gFbTcd@vger.kernel.org, AJvYcCXp5GMzlMBqIecZ1DR3Sn9UOpNVu7lcJjRjPjSxLFV+NgWuBedjIFPM/ynLCc/9Yy0lLvDOqCvF@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+EMbXfWy/ESy5SEFYAE2zAy9qgf48u8gLE/e+PTbFJsDyXTe
	rcfZP7OCBUFljMbr4q48+5dGdI3GlvBXV1L+E3tiJpffrkLXhdKvsl3rL1DAOcRJIJH/3LxWDet
	cKF3qP8vNQRW1hnRlqNKhsS8xESEgN35s5T4=
X-Gm-Gg: ASbGncsl0LZP1U431gZTp2R2kAKSUt2kH8djKdMDzL+t8cjy5026S99iGuUI5hJ65sd
	MhmtoW0NkFLdXXxrkAWgcuxBnTvvEDLzXiHP/Fwa1hw1lbrqRafqu3KPh/13QoF47/5LbUe5y
X-Google-Smtp-Source: AGHT+IF8HxNs85ro7G3Qf6KaAWvjjbB7hSGrf1/e/Pv78U588doGeFifTiWPtpSw0fBJ1cifsJ9uNbbXsbVNpG9Qh5g=
X-Received: by 2002:a05:6402:40cb:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5de45070884mr36659596a12.23.1739268090664; Tue, 11 Feb 2025
 02:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com>
In-Reply-To: <20250210194512.417339-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Feb 2025 11:01:18 +0100
X-Gm-Features: AWEUYZlfqkIP2gwVXL5U5NR1NwtgUTHPI9agZ4JF-sQfLty9_RCkMkdkKc2HiQ0
Message-ID: <CAOQ4uxg0RQuNbRx9LBZfb+XztKVOu2Qad7ZHRKHHSQcYFY6AYQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] ovl: don't allow datadir only
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:45=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> In theory overlayfs could support upper layer directly referring to a dat=
a
> layer, but there's no current use case for this.
>
> Originally, when data-only layers were introduced, this wasn't allowed,
> only introduced by the "datadir+" feture, but without actually handling

Spelling s/feture/feature

> this case, resuting in an Oops.

Spelling s/resuting/resulting

>
> Fix by disallowing datadir without lowerdir.
>
> Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Fixes: 24e16e385f22 ("ovl: add support for appending lowerdirs one by one=
")
> Cc: <stable@vger.kernel.org> # v6.7
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 86ae6f6da36b..b11094acdd8f 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1137,6 +1137,11 @@ static struct ovl_entry *ovl_get_lowerstack(struct=
 super_block *sb,
>                 return ERR_PTR(-EINVAL);
>         }
>
> +       if (ctx->nr =3D=3D ctx->nr_data) {
> +               pr_err("at least one non-data lowerdir is required\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
>         err =3D -EINVAL;
>         for (i =3D 0; i < ctx->nr; i++) {
>                 l =3D &ctx->lower[i];
> --
> 2.48.1
>

