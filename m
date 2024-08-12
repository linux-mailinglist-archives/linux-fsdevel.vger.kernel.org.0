Return-Path: <linux-fsdevel+bounces-25612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F017A94E485
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 03:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC474281F90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA03A535D8;
	Mon, 12 Aug 2024 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAn7JBeA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58B136A;
	Mon, 12 Aug 2024 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426855; cv=none; b=p/kMs21nlq/PEzXtwfWAOxe749SN7nRzKXiLbJ86u3vIj2ee44+uL2+8v6cETeWLBUpMtgWS1IwuAfVR0yVsDs/I4XnluFR4sV+Yj1To8K8rhhZR3OQzYmD6XXRO6Tl7pfCoTC+LTCsHl7PWiGeHoWs3VtCghWHRADeqR5JNUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426855; c=relaxed/simple;
	bh=fsBFrNLLtzlG49Koe/sc1Hhd8woCXP7D15SVvyauwzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYAfahg9q8QTB6nmleTZ+9OXXmEMH9ljH2gEG/UN/NlNQZkoemzRYq0/TEXax6yEhgCBRLbx2okkOhBumK9eFLK4A04s4lriN9xOX4DFSZZ4eCUU5cU5E0vYyAm2286BrHmtbExy84qE/S0kTxC1Bq4opt9CxRHP/EmBfzSMp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAn7JBeA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1e4c75488so234960285a.0;
        Sun, 11 Aug 2024 18:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723426853; x=1724031653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsBFrNLLtzlG49Koe/sc1Hhd8woCXP7D15SVvyauwzU=;
        b=KAn7JBeAN8OpraPJbo/ZBWIoyNGKAESGvdHiJ5NsKQEeHIOi/7ucGNe0muBvZNlgLR
         W/ggsMQeHddJ7gRwxTUSQupZvvNe+7iW5hBiGvZIGj/c/hbW5rTg/bX3MxgbBSLvZqmt
         eVQ3TJOnxR3QO35fN/BhcBt/BKW7oAz+z+Pkx7BfDgk5kVV7m4Xj1LQj9DaLS8UhYxHv
         sDHe5sG+8syjme7Mi5DDTQzk5ye1yPG1WK1Cka5BGIBMqNkrUgd94NTB9GZHvZM1PHj/
         xR6QCeHWd4VRpLJxks1g/WQq5Le1o83PjmVn+LUtfVXghPweelS5Ankndf/mxHsRLE/g
         AUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723426853; x=1724031653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsBFrNLLtzlG49Koe/sc1Hhd8woCXP7D15SVvyauwzU=;
        b=PuYLKRXqG6yPUokNiajr5iYEEHio9weoFMB+vIZ8mlfnzZRMLfF4tQkXThOGapJMZV
         N4GOax/Yz7aBCJ7ongmQPWOq+sADR+gFrzXepgs/Pkj6QXlbrUgVBy+e5TbU+mpy7AMO
         ctk6M4S7rtY/q9uFo9kCCbcdB4Pdn86pTG9Z7HT31f55O1mhoPeEq0HOhmY10qdjmBrZ
         cIKV90qy11whanihr+BwQgr3jdnBodppFCJihqOPUadyr3O4zfimTMZQD1K3KX1itPLU
         Zs0Dy0XmouHaYIADnPdSXTqebLFiKpZTD8xndNnkC4GMdZQNigsVVlEJpSeALYalalAT
         jNgw==
X-Forwarded-Encrypted: i=1; AJvYcCUSurfAW/6ewSmbHhY0Z/EudYkJ49TC7xn6jGUF0h25MyZHIIui39Y5W6vu7t3dHTIMH0OcA5CAGW+rEwjqmbaeDoX6SqN59e22HVVf/kIztN5D3W1nCCp2w9iFITlaQzJw8iLeJq4jSt08HQ==
X-Gm-Message-State: AOJu0Yw5J2zeJOyd88jLKSsmD97lvy2T7mwnpnEmRWiMP3FrM2IQxpn3
	j1uYwxjyjJlFKvuAB7Uh8dEVgcGbPYf97Ymw1Y9XgJms4TM9r0myXi7zJAWhj3uJLkPeYVIjmvV
	vftgn/XS2/fAz6eWcgUY7lWNvjSs=
X-Google-Smtp-Source: AGHT+IGhruwW8mfWXdXYB6NY1D9uuX+zqq1fu7gnegpSeSaLplC40Y001HBg0OtwsfPG8szz0XRVoPECu9dfBrUoJ0s=
X-Received: by 2002:a05:620a:4486:b0:7a3:524f:7ef7 with SMTP id
 af79cd13be357-7a4c17920f1mr791178585a.12.1723426852473; Sun, 11 Aug 2024
 18:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808063648.255732-1-dongliang.cui@unisoc.com> <CAKYAXd8U1P_+WYfkPnO4JeTA=_V1ScrfkApJxi7F-iyOw9n-cw@mail.gmail.com>
In-Reply-To: <CAKYAXd8U1P_+WYfkPnO4JeTA=_V1ScrfkApJxi7F-iyOw9n-cw@mail.gmail.com>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Mon, 12 Aug 2024 09:40:41 +0800
Message-ID: <CAPqOJe1HUgoyQ_wBy00KYnkya2n0hORs5SjU-tHL5KOiqA72gg@mail.gmail.com>
Subject: Re: [PATCH v4] exfat: check disk status during buffer write
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, sj1557.seo@samsung.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 8:57=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org> =
wrote:
>
> 2024=EB=85=84 8=EC=9B=94 8=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 3:40, =
Dongliang Cui <dongliang.cui@unisoc.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > We found that when writing a large file through buffer write, if the
> > disk is inaccessible, exFAT does not return an error normally, which
> > leads to the writing process not stopping properly.
> >
> > To easily reproduce this issue, you can follow the steps below:
> >
> > 1. format a device to exFAT and then mount (with a full disk erase)
> > 2. dd if=3D/dev/zero of=3D/exfat_mount/test.img bs=3D1M count=3D8192
> > 3. eject the device
> >
> > You may find that the dd process does not stop immediately and may
> > continue for a long time.
> >
> > The root cause of this issue is that during buffer write process,
> > exFAT does not need to access the disk to look up directory entries
> > or the FAT table (whereas FAT would do) every time data is written.
> > Instead, exFAT simply marks the buffer as dirty and returns,
> > delegating the writeback operation to the writeback process.
> >
> > If the disk cannot be accessed at this time, the error will only be
> > returned to the writeback process, and the original process will not
> > receive the error, so it cannot be returned to the user side.
> >
> > When the disk cannot be accessed normally, an error should be returned
> > to stop the writing process.
> >
> > xfstests results:
> >
> > Apart from generic/622, all other shutdown-related cases can pass.
> >
> > generic/622 fails the test after the shutdown ioctl implementation, but
> > when it's not implemented, this case will be skipped.
> >
> > This case designed to test the lazytime mount option, based on the test
> > results, it appears that the atime and ctime of files cannot be
> > synchronized to the disk through interfaces such as sync or fsync.
> > It seems that it has little to do with the implementation of shutdown
> > itself.
> >
> > If you need detailed information about generic/622, I can upload it.
> >
> > Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> You still haven't updated the patch subject and description with
> shutdown support.
> I've directly updated it and applied it to #dev.
> Thanks for your patch:)
Thank you for your help in updating.

