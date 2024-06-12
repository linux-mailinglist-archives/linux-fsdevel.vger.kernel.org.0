Return-Path: <linux-fsdevel+bounces-21502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1164D904B03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 07:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374C61C23C26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 05:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C28381AA;
	Wed, 12 Jun 2024 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr+1dpWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF936124;
	Wed, 12 Jun 2024 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718170986; cv=none; b=rSHB9c9idqdYJ/QZfHF4t1Ff9mPpDUrpJ6SEd6CFFUWjEkDudTxL+KfAkDWZEkMtn0YyWAXMRTu1Ba8xAq4NKll11iX5jfZZV/wQa9NMaKgM029iCNDfhHARkQCTFxslcTGXIdbC1OtyMbAe5JgHFIAJHvJIb71w5WKekWqebGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718170986; c=relaxed/simple;
	bh=63I+1dEzVeXn42wBYio/c7Yuzom9/7n5V8ZUh47gjH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRNMzyTLB1eHfPYrx8gK6ZeYbXEjDBjmrvLT8cAOBoZL4DdUWqv7148vfPdmjs1b/G0GZq7ibzTW6ZcpomG1x0f4gQwmAzcyfAunLMuEEw95V8bwgygtlTJIqSpTcNEp/qjQsHOqm+5aA70X07T0gd+84+44CDTZXebwyWxYkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr+1dpWY; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so244796466b.2;
        Tue, 11 Jun 2024 22:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718170983; x=1718775783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63I+1dEzVeXn42wBYio/c7Yuzom9/7n5V8ZUh47gjH4=;
        b=nr+1dpWYf626QmxQ4oR4nohl2KZPeft5wckkivweA7kWdbztSnL3SOla/9ZnmNC4nk
         DwwLyLG4mbLxx1FXJjIwYKWvEGyvC9Kn2NjHH05TH8Iai3VYSrsV0R3nSQbFZkE4uvbU
         36ERylbPDfZQWHNjYuhYsM0N+QIlQebTipRt/7Xs9LkU/+HuP2JRUN88xH/tTjzYjYyz
         i7LFvBwImFRutf9rywzx/FRHeBoz/y76iGiTFz4c7zRUEvGyzloa2dgqh5TPq0xUvPVM
         nPNbThQTfnkEVO3tYbJoGNnlb4aMRzkjSXQXuBosLv6tqbu59sQz2hsKYEQDpemW6j8R
         1xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718170983; x=1718775783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63I+1dEzVeXn42wBYio/c7Yuzom9/7n5V8ZUh47gjH4=;
        b=tEmUg1w/GHFkgCbPcwbDu/xHpEan3XHtwBqyjeqKQ00jtvGN6O1TIbSlf8m9ktMcm1
         hQTEO5T7temaBwoNVecZX45YYeF1+Ezvajo/GJDGRwtja4+Uk6tIKTfN969KyVGL9lt6
         gFmQgwBJmkEamNiaq8qwHEkTziHvDFXQir3UUkKK4kn+vKa0znyZHnzH6grVHMqCb1Ec
         Fbl5ceI0jTy9+awSrmAlwUlQyYTyGjAa4x1khLxul7Udp3xX5Uf++Yv6zdA3ulfbDRAc
         Gv2UncfmWObqtPCGR8HvwIdj1piYFZLEQvCAveND8q6IwqR5/dJ81eS1PsKvOBPcEYhx
         NngA==
X-Forwarded-Encrypted: i=1; AJvYcCX4VcjsG2GIriULeTz4Yvm5XUL9CSVAYMKHRm2nph+GsxtGU8xpg3MqwDKp+nnWo4/p/NKhCN2gHkt5Goiz4i2AoHxAn+uqAQvZSprLjIlCcAkVPqo36HaWTuJ+51tgnJFYUbEXQSP8VGyJ3zFEW7z7//QTHfQOCN1HAEfuNLVlmQ9IYImWWA==
X-Gm-Message-State: AOJu0YywdVec4S4O3mHTXJVXtBTchf3ATvG7w7jhuUfHeaC7hVOrgSw2
	GaoBd03FPkOfQcPas1+qKScy7VEMf1XjZtu9kwxq1ceYAxWEbmLaaILw80VS/O6/hiBXi4B7YEL
	AcD/7PXWkLyKYhsF2cCADSG62eLM=
X-Google-Smtp-Source: AGHT+IHGu/snvNpAD1Yi6gjHr6w3KtlYXskhYkbq4+1i981NUmF9usvoUiSCiFzsd+OnZAP06utH1HgoD4gnq5XsNuQ=
X-Received: by 2002:a17:906:7251:b0:a6e:57ff:7700 with SMTP id
 a640c23a62f3a-a6f47cc20fcmr35560966b.42.1718170983090; Tue, 11 Jun 2024
 22:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214911.1863909-1-bvanassche@acm.org> <20240130214911.1863909-12-bvanassche@acm.org>
 <Zmi6QDymvLY5wMgD@surfacebook.localdomain> <678af54a-2f5d-451d-8a4d-9af4d88bfcbb@heusel.eu>
 <9dae2056-792a-4bd0-ab1d-6c545ec781b9@acm.org> <CAHp75Vd02o_z2swHQ8Tajyvdi25do3ys7+GMES7RAg0NffgAUA@mail.gmail.com>
In-Reply-To: <CAHp75Vd02o_z2swHQ8Tajyvdi25do3ys7+GMES7RAg0NffgAUA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 12 Jun 2024 08:42:27 +0300
Message-ID: <CAHp75VePhicGBK3bP3eDmpdH6JLOBh0m7S_oTGxBOtgfhCtU6A@mail.gmail.com>
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Heusel <christian@heusel.eu>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Damien Le Moal <dlemoal@kernel.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 8:35=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 12, 2024 at 2:08=E2=80=AFAM Bart Van Assche <bvanassche@acm.o=
rg> wrote:
> > On 6/11/24 2:21 PM, Christian Heusel wrote:
> > > On 24/06/11 11:57PM, Andy Shevchenko wrote:
...

> > >> This patch broke very badly my connected Garmin FR35 sport watch. Th=
e boot time
> > >> increased by 1 minute along with broken access to USB mass storage.

...

> > Is the Garmin FR35 Flash device perhaps connected to a USB bus? If so,
>
> Yes. It is written above in my report here.

Hmm... Rereading myself and it seems it was not obvious that it's a
USB mass storage device. Sorry for the confusion.

--=20
With Best Regards,
Andy Shevchenko

