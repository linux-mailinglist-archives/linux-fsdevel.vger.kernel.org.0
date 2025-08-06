Return-Path: <linux-fsdevel+bounces-56882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47105B1CD57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2E418A2E96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67712BEC21;
	Wed,  6 Aug 2025 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BV3X5JA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0821B983F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511298; cv=none; b=NCDhGq2alVu8BarHzg6poH4Y/4pThtu0u4ZlwQ9gCcaRVHkVYZ6IC1Ce3CP1+kfHtWQl8QPFRrGsxGv/H1BmQ860rKVl1ciOwRJnzOG9LuW6B7LpxeOHwAr2GxrRMMIzdvMxyruc6N3cMBL61iY+6T8hEYAV4bvv5uMxpwJGZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511298; c=relaxed/simple;
	bh=ZDHpr0+0p20pkDv2mu3Q9yjs57G8bc2Ou1cKrq4mu+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJieHw+7DrfIpuBPRSIxfzx7Qz5ySLMNaJwWbkAQfE1AyFoQ6p9kzShi3OPZaOMYjdrwCryxeMAi2y/OEcPD2fQ9rmadYUL13bqIJbjU/LB98ls3n1JisoGAlHtpYloC+IqTKKL8/1KKq0bwR5zYvPMmf+IjsBbJPTIdhkZm4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BV3X5JA3; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b088929339so2953271cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754511295; x=1755116095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDHpr0+0p20pkDv2mu3Q9yjs57G8bc2Ou1cKrq4mu+Q=;
        b=BV3X5JA3dDtbNQxiVnQw1uFN7WwqabrDUNcPeXHfZTHPHAKlHLXxGurjs1DLjmkV93
         tqtLsb8ysYSzBROuOkhmBA/pSY9zwqItwnNaokyLJ+vR+7TXgpz+a8MqzJg+L1P3zczN
         iIVU6OLx92d7v4s+AIEkuX+w79g2pZngaOplGIO71IDwwBANVyaRPgsrpqHXvrHJazT0
         vHSjr5bBkdrHp9SAyiv//bzm5cimoAuNFdmKpPOJNbJ2kZJt4gOvIslC63fhB1G7HrXA
         rTlc1MAA4NRLDHaxa5sX48Jjz5Bsf3p9laLIxUB9aUHYxymqFwyFzRGvyuwPWLJIt1iO
         VF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511295; x=1755116095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDHpr0+0p20pkDv2mu3Q9yjs57G8bc2Ou1cKrq4mu+Q=;
        b=fzOrXMj3vIVJBj9ltV0SX/uIhw+2U6fHQ/WJXMHdTilYo0Jfkb3aXah/yek5pMkOmJ
         o84xKcFHAuQ7zEWR8MWbmo5dM9BFH56npYcuodxvU+YQPGCiiPXyiGQqLh7k9UVzfTY2
         XQ/sd8xqA9k8sxExb/rcZOoUkmu1vn2edD0QcHGZsiXnYnf+V3RDNelBzIFpsczvuJqd
         VCEwWYf483LtHcMoJZw7tm/OQdXWYu8SEBuAcCTH/uFIs5Dsi7mg9t2CDptOMdKYhQKE
         ZoReIgCdI5S78SH4Psu32akWeukid9LrPORf1oUdrIPi0QdkIahVBvpJR8mLToMKLyAk
         jaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTKtBdJMPm1phHuTxUgO7HXhz09eAGzhZkOpFiIfWT86r4xUbQOwlt5Cyycmte/F6IJp1gAmS9gw74NjOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHQvkBKs4E8Hc5oHrDbV1JEtZD8Ql6gAXg0WEZYYNglQkgERu
	xUayPXlBrZgO8VMx/TXYJcbG/7hyimmvnMRRcIt5W3Ss+XHahMsCTbBKwKIWV4rb+Od1CYaP4Np
	VpAxCVNkmRz7jBmoO5sNyE1/Um3wkqXUpHxmAtGZcnw==
X-Gm-Gg: ASbGnctnaPJEmJfkLvwVSs7bgZM2F4km/cL6zmcWkDgsNch8IHISqUwDhrrIOzelrQS
	kTLHHmKKh9IeOsG86CDo0nEc549aTu4E9YAZRe2uvBl+vaKH9kFQ8+EUTi4+kOutoC6BjB8/CVH
	coclJs3NezfCaNWag9tpWelFj4vAvuhx8j2i828hGyz8rf3CK6QyNPWX3UWNNJ3lcc1QONcnHTN
	4Qv
X-Google-Smtp-Source: AGHT+IG1pTZIp3NhezI/eRT45NKH+mtzWFGAo+1iZoAphp7Sfj8eCIzIiMWt+Cx51Yqtbvyg1UAKQ14ylzy/wQGMu4A=
X-Received: by 2002:a05:622a:3cb:b0:4b0:7950:8cdb with SMTP id
 d75a77b69052e-4b09267f8cdmr58173331cf.31.1754511295380; Wed, 06 Aug 2025
 13:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-32-pasha.tatashin@soleen.com> <20250729161450.GM36037@nvidia.com>
 <877bzqkc38.ffs@tglx> <20250729222157.GT36037@nvidia.com> <20250729183548.49d6c2dc@gandalf.local.home>
 <mafs07bzqeg3x.fsf@kernel.org> <CA+CK2bA=pmEtNWc5nN2hWcepq_+8HtbH2mTP2UUgabZ8ERaROw@mail.gmail.com>
 <mafs0ectod5eb.fsf@kernel.org>
In-Reply-To: <mafs0ectod5eb.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 6 Aug 2025 20:14:18 +0000
X-Gm-Features: Ac12FXzhqMjLum8cECX_x2Yzk_OzuXfSOe_mHCnoev6H-Zqbf5NvubJCxtWA6gg
Message-ID: <CA+CK2bCwe-9QzEbG60csWAWwKC+XMrv5=3DHOJFkBVLgkzTsEg@mail.gmail.com>
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Thomas Gleixner <tglx@linutronix.de>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> I didn't mean this for the memfd patches, only for libluo.

Makes, sense, memfd patches are going to be submitted together with
the rest of the series as PATCH, sorry for confusion.

Pasha

