Return-Path: <linux-fsdevel+bounces-20794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7C8D7D43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EC51C215EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 08:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946796BB4B;
	Mon,  3 Jun 2024 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FU7pnbzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBB5A0FE
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403076; cv=none; b=VXQc0B+vPA1jqNRQLX1IZhwVuvEpnmNWuidPdo9xbkPxM7t3mfIMb2KQYo721jhSvGhy26MELIYPoLQLW/giYt52w9bFdGtbb+1DcJsJQNQoJ1llK5mSfTJYPTNWH5aPCfprYirnu8+0vhu3/CFyqKrSwlweU7mhPA3V6HVbCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403076; c=relaxed/simple;
	bh=xAIZ+DQHyV0udtEfccsYtJWq1o1HPNaWK1OKdflmajQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muWyDocMJ3HU6jCBivub5PsHrKlpAaUi9Os/ckwfSaiIgMnJ+5CWA//TeMPFFnrzSKBAPPS36Me/3gJaquMiVQYaGIes1+AaZ1Wq1MibZzi9QZp4rBm4qdI9mKgtcjKFZtGNthS9nMSFtbgTfpMiKzQTXWjbjqKRd3DRcjmT3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FU7pnbzX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68cd75b97dso150888166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717403072; x=1718007872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry4HWxQegOCl8PWi1xhoGaSFVjTCYGr9F/bsnti1t6Q=;
        b=FU7pnbzXa5lOyBJH/VqfDiNLIHUQRIZBuGGZ8uKQbyCodios/sBPE13sjbnUniQeVz
         cptODCjI+UJB+pvhvwpglt0qSOsQR3LAeq9jOuJYCZAXpDylPYDlKMy0OA2kQyRmCin+
         oOUgkKVfCP1DcReOifKteDqSRNXcHDf143SEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717403072; x=1718007872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ry4HWxQegOCl8PWi1xhoGaSFVjTCYGr9F/bsnti1t6Q=;
        b=tfHnFCnWk/RJJlLxAQLwtNpcLWC+WYTe6m8xeAiCc86OkaavsA2jNb+zwuZm9M5lDN
         7BrR31iexGEB/orEHT4fXjavuoIIKLKX4VANcICuM8rFKuKU60GaWelkOpb7IiTUPl38
         FY7BCRGj6UF1GAevkffrIoNaHo6wlO6RqO5ClI6glSGWhWTInji+tx3TFr9yakQzjhsF
         cw2NojT2aaRBInQTUxlEfmQvOzSa6BrqtOuuxS8vIFGTGcvzdNuY0y5dnvMvCjugNN4D
         twrqW9G5vJACFAoNyuiF4V10iqFDwfW5cO+t6xLEPA1MEA4E8b/onKmo4zTnvcfX12bU
         YhVg==
X-Forwarded-Encrypted: i=1; AJvYcCVjYShO6qjAm42+aIWX0DnmZfvHqMXMwh+k3ia24lmGeBcUXD9shH1deq/MfeW9BuxD597/LCJZvKHyyHYmh0xNMNgcCLUykUICKWaqXw==
X-Gm-Message-State: AOJu0YwT0tgwa76wwbKmwsXa4lnovuTudEsGOvllaaNLo2WgYsFLxwe7
	3alGnMfCz0uYh+7SbAWyjjQ8vo9Pn2el/4HdabXZlxweUOkzJfAu1ylreH41BfVxwqImOMFj3iw
	f5JkTQ9cq28nVappfup2mDt1d3GW5RrpGZ8BvUA==
X-Google-Smtp-Source: AGHT+IH8WE25qqoL5c3i7KXeRvrPO2rSbvHuTxjzKAMI/IseGoBrnlNoUepBXVENGV0IXygqCvgPj2tQzDeBbFisKPg=
X-Received: by 2002:a17:906:a008:b0:a62:2c5f:5a64 with SMTP id
 a640c23a62f3a-a681fc5c68amr576081866b.15.1717403071862; Mon, 03 Jun 2024
 01:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
In-Reply-To: <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 3 Jun 2024 10:24:20 +0200
Message-ID: <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: "mszeredi@redhat.com" <mszeredi@redhat.com>, 
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Idan Zach <izach@nvidia.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, 
	Yoray Zack <yorayz@nvidia.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 10:02, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:

> We would like to make a proposal regarding our idea for solving this
> issue before sending in a patch:
> Use a uint32_t from the unused array in FUSE_INIT to encode an `uint32_t
> arch_indicator` that contains one of the architecture IDs specified in a
> new enum (is there an existing enum like such?):
> enum fuse_arch_indicator {
>     FUSE_ARCH_NONE = 0,
>     FUSE_ARCH_X86 = 1,
>     FUSE_ARCH_ARM64 = 2,
>     ...
> }
> Through this the host tells the FUSE file system which version of
> fcntl.h it will use.
> The FUSE file system should keep a copy of all the possible fcntl
> headers and use the one indicated by the `fuse_init_in.arch_indicator`.

To be clear: you propose that the fuse client (in the VM kernel) sets
the arch indicator and the server (on the host) translates constants?

That sounds like a good plan.

Alternatively the client would optionally translate to a common set of
constants (x86 would be a good choice) and then the server would only
need to know the translation between x86 and native.

What about errno?  Any other arch specific constants?

Thanks,
Miklos

