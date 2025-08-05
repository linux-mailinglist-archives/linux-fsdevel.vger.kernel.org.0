Return-Path: <linux-fsdevel+bounces-56788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD115B1B9F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 20:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71A7182CC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06E29827C;
	Tue,  5 Aug 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cxi2QUyk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8EB292B25
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418286; cv=none; b=b8Y0+H2BdMO7eUxdzQ6rsbmtVb2PmWfro9Rf4DpmiRSfXK73HM3KVi+z2NfoB8M5Y1swbf8ayGIuCZ54Mw2zfNsW67f/ZfrQuL2UkkQfPa896xssYOZ7G9RLvowLQ9BsSw9T6DLlft6HS59s7HZtL2Zv1P5K7zHXgaaGXEhRZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418286; c=relaxed/simple;
	bh=OKVLqHIWmibana5VQZUJL0qfjT6gFJPBTJLNVk0SJRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2fwFgTx9aYBMbqqm6fBemRaammzWjRBDW07dSz28cUv0TOQLvOSVwsdbKb6Hfyy++59w/IrHBX2arTsCSPIWxN7Daj6x33n608wUGUCX6gT0SUonLciE429rRUejDwqH+M3yX5+ZEszGUol5NC2eyVIr7JpaoCY6MuGfCJvBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cxi2QUyk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b06d162789so25664251cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754418284; x=1755023084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OKVLqHIWmibana5VQZUJL0qfjT6gFJPBTJLNVk0SJRY=;
        b=cxi2QUyki+j6r+AUnCw3RvWjcY8wIMjzkQZNYirvohpuOLbHcTqWGlWYsBGih7XRuF
         tFCgDzdFxy6+hDAK9GBcr0CwCPPSTwy13E2CkyC8rdhql8M8FQqKY38sbvSRrIlWDFTs
         B5P1qDdfnbnVgRUf1c0JV/ymlLzeeThbf8FhGhHQKpXUFUnDRTn1dRmQr1/397jWil1z
         MBOQ/FPyok5CCskwl9J7N9Lpeze7tBJCuK6DhWIjjRE0adMBmv58evpAHzHNds/ZuAbg
         BBlCMsogK6zHRFvWBP6ULOgAGU1WCvIVdFaB0EUTN0AA4I7Hq8BBai8Umt/V/3EVI60R
         GAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418284; x=1755023084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKVLqHIWmibana5VQZUJL0qfjT6gFJPBTJLNVk0SJRY=;
        b=EZySGYSbyVhx0SYKxtLFLVlBK4TNNfSMn76aoEo+Kuv8YIbqhc7ZP9Wh0tkYqPq9OG
         CwiKjW4F9J1b5mVured6w2vLM7E/hZ83hy3x/PJkgfPDNAGGBt52/tYlussrH21vVOCP
         OOcoArmbXqYW5t1+RMGCZ948iNRLjrn4m4go5LRIh+RaeWlzEgd4TWk+e6skkCZLlbhI
         92aGaXURN8FlrhpTTwzJims+k+yXk4fbXMovz69ocYz8ctgilNFX2v/4niY5OyFyIw5q
         CwiTkVz98HJm3bbAkUXTvIVQOntCkoHS98B/6t1OX5ks4sH/71qwcK+zt4jgYS5lIk9v
         ZloQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzKhteIEYiYns0bCL97pKcSjaZUzHJ/199pNhOhBXnpcHcl40+c6v3JxQEmkmcpeJnw+185nX/uh+F5gOz@vger.kernel.org
X-Gm-Message-State: AOJu0YyouDN+qxvFN4q+rat9j67BZaIXhKezWf7O/qdDpIwBs6bC3zT/
	kr5jYUgv8wZ7hYLipsXxyv47vwSaXkJLokLhMW+XHDy8/CAHLikuKPLJhM4u0dtKxp7oVfF6Gm6
	C+806Fe0YtYFI9rSpMqj2OS1vRCeLwSSxnefAMNFXGw==
X-Gm-Gg: ASbGncs9AkCvQd1R7cXe6FEkbOGqrT87YVYkdDJEqVna0YNjYld3nmN9k4ehKVTDwgH
	vvPVTJs1hdH73kv2Ft4wZp+8Ta2cIcjBQ3h7uu9f2s6bLCkfgSSsZSncz8iL8+PjPUP3A5JLOP/
	QFJUFxDJ62fUPLPlt/nSlBlCzCxyKPyBrVNwa+svwxcQnmw0cyPcyAcuEgqHLoxPQzZDXW9tTGl
	WyR
X-Google-Smtp-Source: AGHT+IECP/Qxkxwml/cf3BCEf7Q2B4NHOjK/2NaPxdggrpfuJmAft+1jLFMG+N7JFiUAXv2wscgyaif0s26EEgdezVo=
X-Received: by 2002:a05:622a:191a:b0:4b0:86b4:251a with SMTP id
 d75a77b69052e-4b086b42b17mr42712121cf.25.1754418283817; Tue, 05 Aug 2025
 11:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-32-pasha.tatashin@soleen.com> <20250729161450.GM36037@nvidia.com>
 <877bzqkc38.ffs@tglx> <20250729222157.GT36037@nvidia.com> <20250729183548.49d6c2dc@gandalf.local.home>
 <mafs07bzqeg3x.fsf@kernel.org>
In-Reply-To: <mafs07bzqeg3x.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 5 Aug 2025 18:24:05 +0000
X-Gm-Features: Ac12FXzHvHvpYHaqyT4n7r9UBwaTJ5dSsQkeIlx-mzYjpvX_Sd5MnNPi6FTtCG4
Message-ID: <CA+CK2bA=pmEtNWc5nN2hWcepq_+8HtbH2mTP2UUgabZ8ERaROw@mail.gmail.com>
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

> To add some context: one of the reasons to include it in the series as
> an RFC at the end was to showcase the userspace side of the API and have
> a way for people to see how it can be used. Seeing an API in action
> provides useful context for reviewing patches.
>
> I think Pasha forgot to add the RFC tags when he created v2, since it is
> only meant to be RFC right now and not proper patches.

Correct, I accidently removed RFC from memfd patches in the version. I
will include memfd preservation as RFCv1 in v3 submission.

>
> The point of moving out of tree was also brought up in the live update
> call and I agree with Jason's feedback on it. The plan is to drop it
> from the series in the next revision, and just leave a reference to it
> in the cover letter instead.

 I will drop libluo/luoctl and will add a pointer to an external repo
where they can be accessed from.

Pasha

