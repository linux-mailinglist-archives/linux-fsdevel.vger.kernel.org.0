Return-Path: <linux-fsdevel+bounces-68941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B98C697F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 13:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA6368496
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79307257AEC;
	Tue, 18 Nov 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUxC5c5K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+TtFDs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26D23F413
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470560; cv=none; b=XHFJ6Lcip5pDgNYaETHV5u1nV2UdKkPtyFPqgo+2gRxSXiSfVR+q2wZx2bYbDz0b139VGThFfjrkUANrcKL3J6FvEE68Ng6GddvgCX/luMLD2m/r8J2lruaVSFT9v2dI01Vozgn4FmIEMKhkFoHBdQ3+9PHQWWb+DykTTXNo6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470560; c=relaxed/simple;
	bh=lmIU4dJ8YNpHWVTMmfiND8CwlczZGnQ+nZ73SDmDCpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmGyRGcF/U2LpU+ZWR5sU5BO6Ou+iSj2Awb/BObyQ6EryGisxIaLlMPvFff3zFE35o2T6jJrvjLfvpsF6ndNLgBBH+FYezHFU0w11uLz+c4lsmQqktmT86ylvkUdNPBrQiCnI7tI49ZFoETvYzQmr/TibOYmIVWGhrKui7/Tp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUxC5c5K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+TtFDs9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763470558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Fc9QzHwqwCPN8psk/oOw+0uctePk68TJ3HFsDWmmro=;
	b=XUxC5c5K7lFUeraNBdaC4xmleZon2BODNkaOHuoO+MB/Ydv3EUEvzkT/f7Kc5ylPtpnXzO
	XfHEwwj6vq7PoVzzqJwRqSjWwLil9zneh+iLYB63fPtpZ5THsvTagKtlRoLVOS502CPgcF
	FadGolyQO99Iuoti/bjhU4Tj4/Y3cZY=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-yEhxDwYiP--Gjon3uWtfWw-1; Tue, 18 Nov 2025 07:55:57 -0500
X-MC-Unique: yEhxDwYiP--Gjon3uWtfWw-1
X-Mimecast-MFC-AGG-ID: yEhxDwYiP--Gjon3uWtfWw_1763470556
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9371a5de3f0so11878909241.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 04:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763470556; x=1764075356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fc9QzHwqwCPN8psk/oOw+0uctePk68TJ3HFsDWmmro=;
        b=e+TtFDs9JCYVRaC6LmN6X9VHdwDwBTRuyDG3JrcM532+qI/ni8wew10K271EWpfR4J
         cDeNTaCqyfoGRshkzdyrKEuPlRC5NZ6ye/a5hkmkxFU3dNsrYuxySce7IQyC28QW+mtT
         JcpT4rha1n8usBpne69lwfC6keSs6/W9RcxpzSJ4vAtwUfLlwyL1WHBSLUSICIdVU0gb
         qi4JAPEErLxnSrRwixKAlhY97ep5B3od4Xn9FMMuRNZ7S9WnlULEC5Ztj269lNxb0o9+
         MYC9HqzxyUeEVwxuSWIBkfxKheU50AaL/UN361TlIiOCG3sfBgjFyCMudkyXwDpNoAW0
         dHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763470556; x=1764075356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Fc9QzHwqwCPN8psk/oOw+0uctePk68TJ3HFsDWmmro=;
        b=OJsuYafVB5UGPtsDNLAITUto2IFdWdbcraHW7Qi49rMsixT5XLdAgb+mgv2XXuH13D
         NYJYbpIFmZxT4qAcI1OWu445NZPxVEUSXP8Qv3kYe0eoPd+fJW34FQX+v/aUsswEjmng
         WljLwwatdcyK8x3w3h0cpfHCMNGoFiTXeWNmdro0cuaqhuZ0tHmwm+AJe0a5Jf2QdtlK
         jWdAwDrKYi0AM4f0DUpS0LhZzBZkVY1n3zPmj7AarM86C9J1vqazFXnvbbR8QrlG8USc
         iZ+fc1lZSuCoO7m4Ik2/kF1ICoQ+yWWN1EEhIhfg2Czhmkd6XR92fYbp6kbKhyHYGJ20
         gqIw==
X-Forwarded-Encrypted: i=1; AJvYcCVil2s4giuab1tDQuFccM0tTi+jp6m9Gcj3To5kCcUvOIlT/6I/3FRIF0S+lVzoW5BaqNzYNE2F1RjdF9+Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yRO3lI4Vk3/LxCHFFQwrYsm15zdxEabjxpSwHP1ha5Pmvxxy
	4Xdu+rM4CK+cSjPRVeEE+UuDHT2lybXsQ4I+0iuOvvPere3wc3wk5cfUQvqRd1kKSGtFmsmPS4L
	s/wvuTMDgKXAsmy49Y+NLCOpeBvgF/2HlIFMu7aBbf8UnjMUTzKxrZicCN14BNsJaycmhROu8Lt
	F7ADpeHXuIACRjxH5FHomoB7o37WUQQxyikkm9OWld6Q==
X-Gm-Gg: ASbGncuJY+ZkprNN9ON5dwJUQMg4Aq7U77yB5CHnkO99GtgowbVxvO42et2UEIiAqQ0
	7xpGNgkM5lpQ/DMn19nkMsb+xsgegiyNf7WuVGlB7DN4AGtQ/aEPCrjRaV7AJGoP2EYteCB2S1f
	3izbs7pCz0fOJ++9t54NNFj56TqoCI3dIppeQ+NP0Ypzd+m1wCIj2w3+Jb
X-Received: by 2002:a05:6102:f0e:b0:5d5:f6ae:38ee with SMTP id ada2fe7eead31-5dfc5bcd631mr5861779137.37.1763470556399;
        Tue, 18 Nov 2025 04:55:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGggoAwNLD7qoBxaLa9hRuYfYH4dkVq/JJ8RpPcw949GPP/ke6lOGR0gxRJ+LgZCGTJ7HGV2cjSg32NhHTTDTo=
X-Received: by 2002:a05:6102:f0e:b0:5d5:f6ae:38ee with SMTP id
 ada2fe7eead31-5dfc5bcd631mr5861773137.37.1763470555989; Tue, 18 Nov 2025
 04:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015110735.1361261-1-ming.lei@redhat.com>
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 18 Nov 2025 20:55:44 +0800
X-Gm-Features: AWmQ_bkMXSxdfduGkjESg1ynruIWs4HY2ohtTvtSrm3enUkgrPdfO3Ne2r9d0t0
Message-ID: <CAFj5m9+UFxDg9=RwiHd5v2jhHaCcpRd+nLF6S3QhTy4v37W2tw@mail.gmail.com>
Subject: Re: [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 7:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Hello Jens,
>
> This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to=
 queue aio
> command to workqueue context, meantime refactor lo_rw_aio() a bit.
>
> In my test VM, loop disk perf becomes very close to perf of the backing b=
lock
> device(nvme/mq virtio-scsi).
>
> And Mikulas verified that this way can improve 12jobs sequential readwrit=
e io by
> ~5X, and basically solve the reported problem together with loop MQ chang=
e.
>
> https://lore.kernel.org/linux-block/a8e5c76a-231f-07d1-a394-847de930f638@=
redhat.com/
>
> Zhaoyang Huang also mentioned it may fix their performance issue on Andro=
id
> use case.
>
> The loop MQ change will be posted as standalone patch, because it needs
> UAPI change.
>
> V5:
>         - only try nowait in case that backing file supports it (Yu Kuai)
>         - fix one lockdep assert (syzbot)
>         - improve comment log (Christoph)

Hi Jens,

Ping...

thanks,


