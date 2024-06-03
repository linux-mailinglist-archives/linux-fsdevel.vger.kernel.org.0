Return-Path: <linux-fsdevel+bounces-20796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F18D7E18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815E0B242DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E137E578;
	Mon,  3 Jun 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nrDeBmJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7174297
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405594; cv=none; b=PRkdo4/VZ03WkVjIbOpefPySX0fCS/T/RZ+wBY9JRyQ/bACh46EpPC7m5MjPEpRLZ2pz8MBMnEsRZV4vLIaiIZMcGwXxtqtsA4avg40yyOngAT8IkkvHCQ7g3GU5IvrWJcd8SKS3LHsP5VQULMtoR0jFXpHoZQNmX59vMwZvkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405594; c=relaxed/simple;
	bh=e5KmvQjDUeFpUSn94wFBVcAhTokQWkHDxz5eJgxO6Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STrGBWhoskY2NzDEeRbEPknK9StAeCKUPI/YaT+r+nCuqLeHhulwI8v5ynFAWsz1ouUzJONxe7QvgoUKjdJUaI8nc1sD9nzMRmqTyZARFLIVJ6fr5yt7cW/YOfR0hHP2i8g1BgYVSmdJuFocbAq4GmulgXlAGqfKyfLXxlXT37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nrDeBmJA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a63359aaacaso522087366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717405591; x=1718010391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/KGKFroLHLvccCfGANjHQWcwdrvjUhEDXE1KYheHoQ=;
        b=nrDeBmJAgDPRg1mGHvgd3OR2N942gZby+lQVbtuYR2OEfmURh4gmrsytDtnz0X9T4S
         gNdOB0D9JtXlVP9OkBXPoAcI1xW0c96ufq0F6kgYfm+vBH12zxugOG8B516mAxLvXkUd
         T7Zsg0b9dJ/CnPCjsnaDAXzWnQ/BWARV0VEd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405591; x=1718010391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/KGKFroLHLvccCfGANjHQWcwdrvjUhEDXE1KYheHoQ=;
        b=e+5yMgJ8fN8G1h0WTLGxfa0BkaVAtVvFT5v0TOrMH7hnovaSjxCJ4rQnDK+o/Mri1I
         zXfW8sS6SsYzO8TCok9f1x+t1svwIqpHxky1Gym+Lm1dhzPOQaY6QIj6PlXqZ2P5mSU2
         Ce0e2xPNbDP4dMufdI12qMP+jsBFtvV2bQhsGf4ujyvFQLSXYkTkzdjVjT/thmUtkm2N
         RRdUKGCHISVbDgJ5EOy+ngcoaDJQX3VTWTJVjBe65hksNU3GdBMutnylWf877cbcm1e4
         EcXRtmSwQVpoW9MvPNQE6iRavoyN3Rv++4w2HL42dPxlCgAwwfgeSDrWjGwBc8Rc3zXF
         pfZg==
X-Forwarded-Encrypted: i=1; AJvYcCWA4UVNc45wIdYrN2+pphNecimB12AVzzalgmnJQ27GokQJGCJvy1GNk6UwbkzLi/9ng96JExAVoYt4IYi55rU68pxCqWqio1NXbqEUIQ==
X-Gm-Message-State: AOJu0Yz5YolA+XXwawcYlJMOgXo/iZ+zuURhYiyzrOm1qsz3qZ02QgsX
	4bMXOEeXNTrSC2fPIFxnmeMpbq8Wd5Sia636+CpAaX//IuHvkqC4zZ6ZkTVxTTZuyyroSHzqu9T
	zDpM4JHGlhTRXsF6FGK+lukRCQOhexbBw07EGoA==
X-Google-Smtp-Source: AGHT+IHdK5tYaFMmrN69eVYnH5x/bM/8a2V8+sJbycCBdig0hUz9ZUeujQWgKbqV9aS9ChtAb9eQmFPemjGHAcRcWaI=
X-Received: by 2002:a17:906:b894:b0:a68:e3a0:65eb with SMTP id
 a640c23a62f3a-a68e3a067cemr252378366b.16.1717405591083; Mon, 03 Jun 2024
 02:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com> <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
In-Reply-To: <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 3 Jun 2024 11:06:19 +0200
Message-ID: <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: Idan Zach <izach@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav Pandit <parav@nvidia.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"mszeredi@redhat.com" <mszeredi@redhat.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"mst@redhat.com" <mst@redhat.com>, "lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:

> We also considered this idea, it would kind of be like locking FUSE into
> being x86. However I think this is not backwards compatible. Currently
> an ARM64 client and ARM64 server work just fine. But making such a
> change would break if the client has the new driver version and the
> server is not updated to know that it should interpret x86 specifically.

This would need to be negotiated, of course.

But it's certainly simpler to just indicate the client arch in the
INIT request.   Let's go with that for now.

Thanks,
Miklos

