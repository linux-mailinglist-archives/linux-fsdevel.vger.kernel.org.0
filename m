Return-Path: <linux-fsdevel+bounces-36580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC4F9E614C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 00:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B77282BE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 23:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324A1D222B;
	Thu,  5 Dec 2024 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biZ1gMq2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639891CDA05
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441365; cv=none; b=EJOfBPpvFeKnmEO5wygcgTmJTo+OGaUJmHbBRpCZRmh/kXq0hmj9HLcUNpeXiPjdsFY8thiVd9j/3dchwTOCKMFcrCgFxyTpivFlMhaM2wjHyKAtnr2XlzHLFivm5TyeR6pKBMIENwBfgb5o4PT4a9nmw5uy/t6YsxnpzcSOJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441365; c=relaxed/simple;
	bh=sl2fuL2sx9eSsftQek2nhCTfPq8jNOVja0M6C73iMfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vbz2o0MLZx3t9fe1F+tlqFk+6POeRzh/vKT4gupLQOWag8tBrkt3NsUYRQgCY31WczmFq7/QpowlcO/GQFvHSF1CypAMdPzG+tO6Qt5SInY5tFPBCgsqrxZkzs4hWbyGavR0AxWoiOhuaSYVQI9WSjO9Es0iu0S4Z79V6vrUaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biZ1gMq2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b66d5f6ec8so96107485a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 15:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733441363; x=1734046163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol2pWiX3LH1sV9HbLaG5mV0t8uvxj68YVeTko8f0aqM=;
        b=biZ1gMq2/Il20uILStzKatgpG4sZ5OR6ecfeHIu3tKG+60P/i3d1C+c4blJxD8blPH
         W//pqXjXkQlzLVOfAr97X9Am9O839sHaGJu5XjQhff1oCZutSX9zogzBhFwjEqFf1V4N
         Dn4VML4VIrGsWcs+EYbGtL/ZIfgW8s/88tNGrS13PWrqNUEr0ZkvjLqfAgkInyCMjZDD
         XLr/2S5HWpcXmeBrHFBt7TeVuDQ/aNxObZFntc7+b869Rw81eBFjQ6vDg/DSsZMKKr+l
         ppoqZ/oGhWxod3jyVu/IcmQrDmhZtxuB+CJ9OhglwormeEwPBz5k6e4QJs5TPp3VTGCG
         FnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733441363; x=1734046163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ol2pWiX3LH1sV9HbLaG5mV0t8uvxj68YVeTko8f0aqM=;
        b=rjkQDkxdAfYr7yqKlOqJNJgx4UW4ILVTAE2H4TNWAYt+KnLDiHzBx8yN93i9bknWYz
         J2tGSgiKuMEP3rdKf1S5jXK/IT5K+F53sOKE5y/6AdL7/XYR8+5T+pfbstXDagPdfvLC
         Tl7HIRLCzu/YzeDpkNufXFSBxsuuDifv8qTKF9LoS+VGW2IKXl3wPy7iISE76HWCpB9k
         fD0478ea1RZ8iZJMUNJ3vx6sUKgQvo1dLW8+kPWYL2684s6ms53hA86O8hsY6H/ppUqZ
         FX37cGE4ibDy8FNcKG1wklGIuj3kpxZDm3x3h/uFNYzGXjdxZiHj5kerB+MYZMToLrGh
         cm0A==
X-Forwarded-Encrypted: i=1; AJvYcCXWc4jxzJ19PS/h0tiv6ovlQoXV0sOwxnLZVcv41ulehuMnOc5AGENjOJf6lb+h82coK320dH2Ssc6Tu9IE@vger.kernel.org
X-Gm-Message-State: AOJu0YxyS9Nq35DBZAI0qi74qwVdx7AkjcTzV2+jBxv5XnZ5EywhAHXA
	6u6zLqlDMUzkSA3gT/FyU4pHq+xnYd9T1udOqsVruj3LeosWGSRu/tkPa6k9xxGt/2Axlpf5iGI
	2gwM1FOP/qrNfWMP9nf0edcWxVeQ=
X-Gm-Gg: ASbGncsjlY+YyRE5+Dz2MR6o391GEMNyTvQRBwecjGdGyXBsLei/1pKDZiAsxhq4bIY
	TEYCMvGXReRvhtvK8Opu93efTmyGmy62yaNgZcUgX6NHTVlg=
X-Google-Smtp-Source: AGHT+IEr7VjP7FnBhFgN749g9qADuW+LK4489P0hSYh2Ay9KdQfu7DTkWy9g93BzGsEdxSIr1yV5GtqpWcIZGdJpyjc=
X-Received: by 2002:a05:620a:271e:b0:7b6:787c:7dce with SMTP id
 af79cd13be357-7b6bcaedda2mr192247685a.27.1733441363215; Thu, 05 Dec 2024
 15:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com> <20241204134740.GB16709@google.com>
In-Reply-To: <20241204134740.GB16709@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Dec 2024 15:29:12 -0800
Message-ID: <CAJnrk1YwOTdbGp_Fh1te+hg2eQEu-CHO4Aik=6fN-mu12OHQ4A@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>, Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 5:47=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/14 11:13), Joanne Koong wrote:
> >
> > +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req=
)
> > +{
> > +     return jiffies > req->create_time + fc->timeout.req_timeout;
> > +}
>
> With jiffies we need to use time_after() and such, so we'd deal
> with jiffies wrap-around.

Ohh I see, I guess this is because on 32-bit systems unsigned longs
are 4 bytes? Thanks for noting - I'll push out a new version with this
change.

