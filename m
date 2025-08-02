Return-Path: <linux-fsdevel+bounces-56552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88480B190D8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 01:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC297A1107
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 23:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C42917736;
	Sat,  2 Aug 2025 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IzAEYSMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09D1EDA09
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Aug 2025 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754177627; cv=none; b=EdfJrH5R9R9H+bWuD3U2gM7+0L87c4jWghRlzMa4Tpjhab7X8XmGEvM0jLmzpspIkmjqHZHED2ltbF3GNMHG0NBg+tSENH+2Rtdisp79VvgPXig9y57ySstZ1exd7AtaaxvV8MKuwceyy1Q6tzkuYPcloEdY0VZx9dpPcPokR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754177627; c=relaxed/simple;
	bh=kJsgdU92CHKcumA558FjE09dL3p6PDIATBJc8UDK+q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dD3weEPsUNe6iMO329dMRhw0Rcv686zruqRkoWx3YI99m61/1K8zx0FqkW9DSjpaUiEM6Ge3wZQm4upqg8F2eaBjZ8NA4jCs11GKyz0I6t5bz7CRJfpvZE1kHWk9Hm9+DQcW7qWHzYHvkHZzMBagufal1dmKbIsk4kIwN8UgvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=IzAEYSMQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab71ac933eso17452891cf.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Aug 2025 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754177624; x=1754782424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJsgdU92CHKcumA558FjE09dL3p6PDIATBJc8UDK+q4=;
        b=IzAEYSMQQxBOsikic/wv4S2Ak1IkZWDRqiFN9WKskOPCYCKnFySUQlasVHApND+PMR
         OCjjIv3KDQDhiLV7iCbKECJEl0TiLe3LVTmuy6gNIAPlrHpPMvaWeAUew+pYDqxDAdq4
         cRYIk3Pk40uuINjMm25FNjXxHw1561DmTbJKWM4u2DSj995QfnrH1KmOwQGD9nFg6Tzy
         eSGc8sOAfVf6chgTuWPeRCwVLIPcObgRenylCwTmVbeWGXJ7/Ql9GaIrxyl7KD0kBpwd
         JYCDYQADCKMCdpfH8waqilxH0gttD+Wvvd/08ZapWIo6fXD3VG1lnW9cGur68EAGto5p
         gp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754177624; x=1754782424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJsgdU92CHKcumA558FjE09dL3p6PDIATBJc8UDK+q4=;
        b=uUnxzs5WT1efZQHdqmKZQ5pFFFUCh9/CLMDoRj7minP6CGfKAdPZw3tpI0xvAxo+OB
         Nqfr7DzVdpjg5qIo5v6G6YalFY6QdYq/G6A1ag5FYBI3MU1gg9qcFhGH4D+GfUNv6S4h
         yW77q4rGO5Cx/GcCa2Cc9l0bjC1Ha6F+Xd762lMnjbtXjgqYUt8DqaQXK+lr+D5OxZRR
         DHOjjdVUfuAXw32934fYcmD25gY0j8hmgRxwlHgVzVM1HeVU3UTAZC8O2qXzF1jD4DDt
         EMTzPR5pcERKu6qElfjU8JnUnITDgzvDvWs7peQJIxmeG/4PH86TRP4jUXaAiLIHEktP
         SdrA==
X-Forwarded-Encrypted: i=1; AJvYcCUBLsnLBmqZmW3ki/PpIRI80eqSD17Rm8v4wiVkzpKcYsyIR5IJjaIrVEE2SGawnNfoVt+V4lUug8BZzw8p@vger.kernel.org
X-Gm-Message-State: AOJu0Yxia61xJRsq1jfDb0dhb1pM9aOFpHFGQQ/gwNVzK16yrJUAr/f2
	uXjx7iRR9BI0yYGfVDwDpR0/nU4YTdWUOyiLykIKdoB2MttZ2KNgZQmT1oBbmLJhP5h+t8Cm6v+
	bzuU2ZDcXG5xnhen3qeQBwh4ztiOpEjY9QpJmdaUxJQ==
X-Gm-Gg: ASbGnctTV8RKaSZaApUk3Ct9pyz5YuDNbYyPMbYUinsh2tIVBo0AE3LAdHjL8ZdyNCr
	rVzCiGbq+W4pIHF7ilxfxQyeElm88BY+/bYBDobW7lo8B9amEfu1qJ9cOwRqkuOFM/SYf9jVf6/
	mlkWaKijSV2ICCkeatEXpj6UBeIi8lbsc8uDDvygn93XFja4hW+VgKA/y2+8uFwgixY7qbGF1e3
	EXMEGTSTq1tH9M=
X-Google-Smtp-Source: AGHT+IHK7fLZil0+YTWDez+wvKBQ8V6Jt/OxjDZMFuEzIGCH7fVFxrWmUeAnr0aeRkYb+cC5kQOxq3dgtd4ni01q4II=
X-Received: by 2002:a05:622a:8cd:b0:4ab:3ffe:409d with SMTP id
 d75a77b69052e-4af107905acmr85155491cf.0.1754177624500; Sat, 02 Aug 2025
 16:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-2-pasha.tatashin@soleen.com> <aIdNTN1qd0dTvsQm@kernel.org>
In-Reply-To: <aIdNTN1qd0dTvsQm@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 2 Aug 2025 19:33:08 -0400
X-Gm-Features: Ac12FXzhu6LQ65rG6yLekEcwlc9H74rWaGowwnkVgbEc9_PttPli4Tw81uem1BM
Message-ID: <CA+CK2bD2pyWmnzDyRA54nXQwB1ABPKqWP2yH6bVnnE09ogCHXg@mail.gmail.com>
Subject: Re: [PATCH v2 01/32] kho: init new_physxa->phys_bits to fix lockdep
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, dmatlack@google.com, rientjes@google.com, 
	corbet@lwn.net, rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> Just int err should be fine here, otherwise

Done

> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

Pasha

