Return-Path: <linux-fsdevel+bounces-44953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73398A6F779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5FD16CE7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4DD2566DE;
	Tue, 25 Mar 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOjKaBgt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC791EFF85;
	Tue, 25 Mar 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903235; cv=none; b=oZobSQyUD5DIYu//jj7XlE6LRNk/+nw8fZOEOats7DzA3GcpdgqsyWXWPva9fxOtMnlqqNoL5aOjy+qRnX8hmWh5ACmFUNNSfP78iKLZEq4jDx1R7+12s9G8wUOY5LQ8M9y4DF3QY7KwVL0+2oLZPaDGdXVJqVsJCmYOJsxk/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903235; c=relaxed/simple;
	bh=b+DQcLwGQvyUvi24Zz6+No4f4nkddsTi6jfrwQUVUEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebnXg9o5hZN5zXFazd1zok77cMKeueP5IyaTmu0yypZTnBAy1CwJzw/yCAtSpgLaWN8+FToS7kIf0HKS1tUv3wQnYYHg7lN7OzMzgBcjZdDQTWsfD8+xtych9KBLHQ1hzKzJwqLWXsAYAIVGPU+x4zqV70F6FBAcMcJgetcjQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOjKaBgt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so10694732a12.2;
        Tue, 25 Mar 2025 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742903232; x=1743508032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4zh20yeb7WVeLMd2P2vt6NV+ovZIxk93u4hoJcH1c0=;
        b=QOjKaBgtSsfVtf8BADGQc25ez2O8bwQuMICE26iHa98vL8nTGXCXjlsnh+/F4BJdTg
         kpjvccB4EYz58/Vry/Ns51msgESvfCL73DtnP/AoMZFliixlKzU50T71sYzHWBa2vYCN
         TpquO8E6pdSkozUM9nSC8Ad0FXZ9kOO5y+LHFYaXLeL9xoSqCR0JldAmhuV3gSh3XVYs
         RSbzI0Psrto1ERPTGk6PvvaRABz0gaL5Nt/9PcrAurraQPDLCNivaNCKz9IZL00OmvnI
         fcJE3JRHDscjb0wc3tmaMfPljEp85+7uA6+yeGm2juN8VR0CYWZZZ0plr1B2/LuCyKRw
         tHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903232; x=1743508032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4zh20yeb7WVeLMd2P2vt6NV+ovZIxk93u4hoJcH1c0=;
        b=kkodkGTXLQA/btFmjJn6qEj0evxkGpK2KeCNfKNUWvwipJX1IAPfBRqZypg38ud6ox
         ZOiyhZwAFVccdjN7e2XTcZmzqNsn2Yi9++bG3prJGUsbF38rliuFzpUoyMDEukzSHCoK
         p9PSS+z58YGTHcpXJRUHTlfq7ApP5z2DZ1PlraUHfGDMvpsQ0L1csbbFZ59oDEqy0Nf1
         XEV/sqWZwuyVVOmYghe38jE6mRMrSbGofa2WimYECHhIv1sl01ZxyMrYK35E40373L15
         3elfoRezp+sXCV8ity+gmwfPSw2uuBwJpwR+DT4hsnmGBNxA4pVrVfMALeQmU4z/d5+h
         zGjg==
X-Forwarded-Encrypted: i=1; AJvYcCXvn3ZAxuSBMCim5jqikIUU4aL3MpPI7hBY9F4Y3/ZEFQxMDhkTDHg9U2vEgQdnZHEe0w4W1qAzGegLPUpj@vger.kernel.org
X-Gm-Message-State: AOJu0YxksDY5z8lDidsz4ugocsPx2kr2VxWNzXy2Lf7u9bIeQUWtUaR4
	6W6pLOd8lnIf8+1E+5RwvLf8e5ZishRDAsifcsUOQqlbW3p5GepvM9b63h2b/7W5tJvdx9ZAi8/
	zPdEjhc2dewRyVNaS8LzvRTLsc6RFnA6PyK0=
X-Gm-Gg: ASbGncv+nK746ot5yjFYIw01raZZ5RYgOkX/EtweKUf+veaCjga9jlIrChRRqedOPnC
	r4Onico5Qzia3+y/fi5m17ZwgWUxGYIYqBumb9Ob5Ls7tN8TJqPV9z/3THIJuKfdQ2hcYvFMpMY
	xdycCNfC6iC094cf2VLl5g7Aq1
X-Google-Smtp-Source: AGHT+IGFga4yZwH9zibaR7pz2j7v2QhcuecgN2l7S/Dl4mQgAc/pyw/kjxgXZ33rynDEoUJvkKgowa+Avymv1xYnQ8U=
X-Received: by 2002:a05:6402:35c4:b0:5e7:8efa:ba13 with SMTP id
 4fb4d7f45d1cf-5ebcd40a6b3mr15898396a12.7.1742903231733; Tue, 25 Mar 2025
 04:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325104634.162496-1-mszeredi@redhat.com> <20250325104634.162496-6-mszeredi@redhat.com>
 <CAOQ4uxgif5FZNqp7NtP+4EqRW1W0xp+zXPFj=DDG3ztxCswv_Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgif5FZNqp7NtP+4EqRW1W0xp+zXPFj=DDG3ztxCswv_Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Mar 2025 12:47:00 +0100
X-Gm-Features: AQ5f1JrFUNNttc7pVUHabB5shkjHAQ1u2N5ZQoXYKntBUP4kjRy9J0-DH_3V4Do
Message-ID: <CAOQ4uxjZOtdMcGpXBYLO4Cxe04_w-GS1Zwy2GY2Yr+jyO+iS-w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ovl: don't require "metacopy=on" for "verity"
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:33=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Tue, Mar 25, 2025 at 11:46=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.=
com> wrote:
> >
> > Allow the "verity" mount option to be used with "userxattr" data-only
> > layer(s).
> >
> > Previous patches made sure that with "userxattr" metacopy only works in=
 the
> > lower -> data scenario.
> >
> > In this scenario the lower (metadata) layer must be secured against
> > tampering, in which case the verity checksums contained in this layer c=
an
> > ensure integrity of data even in the case of an untrusted data layer.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/overlayfs/params.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> > index 54468b2b0fba..8ac0997dca13 100644
> > --- a/fs/overlayfs/params.c
> > +++ b/fs/overlayfs/params.c
> > @@ -846,8 +846,8 @@ int ovl_fs_params_verify(const struct ovl_fs_contex=
t *ctx,
> >                 config->uuid =3D OVL_UUID_NULL;
> >         }
> >
> > -       /* Resolve verity -> metacopy dependency */
> > -       if (config->verity_mode && !config->metacopy) {
> > +       /* Resolve verity -> metacopy dependency (unless used with user=
xattr) */
> > +       if (config->verity_mode && !config->metacopy && !config->userxa=
ttr) {
>
> This is very un-intuitive to me.
>
> Why do we need to keep the dependency verity -> metacopy with trusted xat=
trs?
>
> Anyway, I'd like an ACK from composefs guys on this change.

What do you guys think about disallowing the relaxed
OVL_VERITY_ON mode in case of !metacopy or in case of userxattr?

I am not sure if it makes any sense wrt security, but if user is putting th=
eir
trust on the lower layer's immutable content, it feels like this content
should include the verity digests???

Thanks,
Amir.

