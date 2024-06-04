Return-Path: <linux-fsdevel+bounces-20924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A288FADDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 10:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6BD1F2466B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743D1411F7;
	Tue,  4 Jun 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="m5Bq0E4u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77665143724
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490768; cv=none; b=NFahQ/Fn907HiVVMnjsZNhT8zdhH57Ca0F1EAsVWGu0P1vqSL0EEVDJYZGzDZT2yQD6V1hCqBVht2GCmWYx0LuuYPlO2bs+2YvdkN0cqJqCzElRBrH4Xq7cXGKC1ADhN/AYXvjDjLUzLOnlZGqTHFdmkLfyeoaJKtU7Zh9pwlLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490768; c=relaxed/simple;
	bh=6QW77IH+sNPGTE58ARlK23gSVIkIZyd2+iYehxFk6vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDVvYllab4IpuGiwbhBC+tbhjgEI70bGHyn0Wp1J4CNqOlC1yqfcqyt/IMCYkH85YPR6E6GTv+8EUWMqTNhWldnAxKEGXP0GmVQR/KiCnng5i34Z5G3UWAnmklYnr4M59TVaH3c62jCaJgIbSMpKuGuTOgR0b7dBeegjD0gtCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=m5Bq0E4u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a62ef52e837so79835166b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717490765; x=1718095565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5PIQ5OeoyRbjANDaCct5hBuvny+p+kJOWKhnvw9On+U=;
        b=m5Bq0E4uBvd04xMXaw1ZHKbAFduH28nqutMCB1+cVI7tNNo+gqE7cv3La/ffpJMBGZ
         yzbD0dUwTQnV4R9iX2KYY9QP47R4IYLtrw14LCy7PnVag25rzvlr9KKpuSRov10ucPLb
         NMji2Cyc7YGxBFMow5L2RhEfQLA8WsT4FvKsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717490765; x=1718095565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PIQ5OeoyRbjANDaCct5hBuvny+p+kJOWKhnvw9On+U=;
        b=SGy3Q5ovcBjD0HeIviF5owUN3lxjQ9o6BpOxpEycgaSFHuAZkhm1VJVVIRmpdP24si
         Q4TPh0hEhvpCDIvdrpFcXE31Wt4s+E38erdTrBE9fvNTlVJkFmzkizhCTPCIYq7RZHCL
         /uFrwDVh3rN5gq05pXp52o5XKjWAiaekhwrsAff5XMQkK1zS8WK4/U5IMO6FmxkSDOHB
         M4BH5lHEEgny5cxsJrOuOevnN6iiNWrDXzk2vP0j4ERo8l0oXDnpjrGhc9pVpbhtTLbs
         dfOxOcaE7KQy9/ur5LvxgLO9sP5yWUJfiIwA7WAqnsrNrEBk0JAt2RfJmaKozuB1YTmk
         bYSg==
X-Forwarded-Encrypted: i=1; AJvYcCWG+5Df23X0UZzVtnvNyoNb+KKzXZDD9XeqdqcVWZbMCDWFx39U0MSumQPeVxdrwvkNDKGGD0jfaujLPAXVCDIcAWNOnKDg5tupOE+cbA==
X-Gm-Message-State: AOJu0YwbigvT1sDhGzJb7DTtvSzol3vbWs7wr6l565rId3T1fssiJjhO
	h19lEVOYEKQ/pqH3pvGsVsiHfEgiuKQI72uCuw5wf08OLmXytqxuiW3RMu7Kqdi5H+BPOCXbTME
	kRK/9e1GoVsNhYPvVwkhLYCWgGfxeAdmuEGFzCfPNANAxlRoT
X-Google-Smtp-Source: AGHT+IHgkfusvPHhLtLVHVn4AGoB410H7KwiUyCLgrid+xwql/WK63qVPZkq3l+OoMOi82rukzCMJm1RVEGDIu8UIic=
X-Received: by 2002:a17:906:56ca:b0:a68:f43f:6f31 with SMTP id
 a640c23a62f3a-a68f43f708fmr349833566b.64.1717490764724; Tue, 04 Jun 2024
 01:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com> <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
 <20240603152801.GA1688749@fedora.redhat.com> <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
 <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
In-Reply-To: <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 10:45:52 +0200
Message-ID: <CAJfpegshpJ3=hXuxpeq79MuBv_E-MPpPb3GVg3oEP3p5t=VAZQ@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, Idan Zach <izach@nvidia.com>, Oren Duer <oren@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Yoray Zack <yorayz@nvidia.com>, 
	"mszeredi@redhat.com" <mszeredi@redhat.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, "mst@redhat.com" <mst@redhat.com>, 
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 10:28, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:

> Will the FUSE_CANON_ARCH then be default/required in init_in from the
> new minor onwards?

No.  It just indicates that fuse can translate constants for this
particular arch.  Also I'm not sure non-virtiofs should advertise this
(though it shouldn't hurt).

> If so, a server/device that supports the new minor, would only need to
> support the canonical format.
> The fuse_init_in.arch_id is then only really used for the server/device
> to know the format of IOCTL (like Idan brought up).

Yes, for ioctl and also to reset the FUSE_CANON_ARCH in fuse_init_out
if the arches match.

> Who defines what the arch names are?

uname -m

It's already defined by the kernel.

> The last time an arch with its own constants was added was 12 years ago
> with ARM64. So the header wouldn't change often. Or is this something
> that the kernel avoids in general?

I don't care much, it's just that I don't think defining constants for
architectures really belongs in the fuse header.

> If arch_id is only used for IOCTL and the rest of the translation is
> through the canonical format with FUSE_CANON_ARCH, then I like this
> approach.

Yes.

> I think that if we introduce the canonical format, and also require the
> server or client to be ready to do translation from and towards the
> handshaked format specified in arch_id. Then it will be overly
> complicated on both sides without adding any value.

The point is to only translate to and from the canonical arch.

That doesn't mean that the kernel *has* to translate some obsolete
arch, because it's useless.  Only add complexity for things that are
actually useful.  And the proposed protocol supports that.

Thanks.
Miklos

