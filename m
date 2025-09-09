Return-Path: <linux-fsdevel+bounces-60700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E64EB5028A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D5016CB5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD956352FDD;
	Tue,  9 Sep 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BdLdyYHA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597B10E3
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435185; cv=none; b=ecjLfSPdQZLlx7+yTBhA9rds3mGhhnnngWiWyNpPBB50ZT5abG3gjwOZEb05atpZDpcgkylwd2LK5Zo8MIyGnhPcyXgQ14nZ+t5VdPokexyuK80XMH+3hvxZLO5QCnXfRgQ7G2f5sRjzZnJcGlJOmerbuK3Nv8py+zZVlub+2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435185; c=relaxed/simple;
	bh=h2KtKkiK1ZCeC0eEimsTpCD94S5mFdW9SnYokRVzfec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=symeOgamNeowORFHM24Nbrlpx3OOkXTCNgz5DivQWSkrX0wfb1dbjklofDXf3uhdltNeMQ5S/Nf6YHaGkCPIWodf+/Am85hSZC/bR5hzSCE71U+NThOt+EyyZfH7vQa0KxDZvhLYRTfyQZUFCpN513PhLu69OLWjI6dsYuwE3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BdLdyYHA; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5fbd77f40so45929131cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1757435183; x=1758039983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h2KtKkiK1ZCeC0eEimsTpCD94S5mFdW9SnYokRVzfec=;
        b=BdLdyYHADmRJ2+AK2JUSjb2Yncx+jUlUGLk/7BrWoD84OlSePTFdOprSrm7rFMPKs7
         QiGbjoQYkmeFFKZwuSQLkh/QBUMLX6I8JHop51Ma/Ok+BuzEuNBymtniRbgpvzDnu7Zf
         wPu308SN7o/UoQvs/5lMfjDjphAlQuLrlq7R4M+nC2Z/mGD1XUtuM+pSWQPOQZley0Cq
         UJFf9Au4KQuzM/TX+4SQQ8UklnMsvXByMLq5W+LlKuA293rQwc5crJFFuwZoRt4c78Mi
         4YcdCQWCEZhN3Ocu224USX1CzVyznNI/iBwq6u2sBGNhCf460ANfh8uFV1FfkTyCcUlF
         tqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435183; x=1758039983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2KtKkiK1ZCeC0eEimsTpCD94S5mFdW9SnYokRVzfec=;
        b=UfcwsTToXS8cYncbqP//5/bkub1RucYjc/SAnBd+X4ylGSb2A0Gj7++AWeLkTc/6gh
         HCEU8pmP5C4qsdTRUnyQevmlh6seOYL+Wnpee+VHoC5wwnjLvapgj4spMqFXsAlMx27l
         AJ0QjtkqIbvilIXmzB80NzdEhHOR1XxvMtpW3AEhMjZmtPRaUYy6slld0YZDwBbPS1WX
         AcKCfqamWbTFsj9/GNjoIXo2NAFBPa2Pc+zOpFOGRxGzs8fc08/39F5W3Ug1VuRre47X
         H7WYYT56uT8ImE37HUUCZFtdDQGo5Z+HtnCc9cmYmLggZUdPHKtZN8sQ+BdD40sThQ8g
         j31g==
X-Forwarded-Encrypted: i=1; AJvYcCWkMGdxrtU5VpjmV47ypGaVOzEDAzQw0TjBRR30Fhkvw+81975BVpl9k4yPe3kWpYCuwTXOq+SH78YcvOdD@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDvvjR4znpHxa9+Nx5YSbncoy4ZDfCzsJIw6uc5TOhkWkxiYD
	3B5vXq5bRcMe7Q43L/DPhvQgITpY1MSfCvmi9Gl724fo9kxvD4WJCB8evB3NEF3T07QO3QG1Ku5
	M3heWwIL9kdH8+k1G1ZsVej1w+MlTbSo2cgE5iZfrgQ==
X-Gm-Gg: ASbGnctedVNJaGy1kJoapOYQ2LnNRdcUWRmFh+EEYKKHExaX0DG7yFaGKjU5mgMkF5e
	gqV2yq3mBGyeZwG20lMwSZfrJArootRXQCcGW46Tw0ic6eGVB5VANtgjFAxrOYO96C5hLvSd3Gs
	iK2RrMWEKXmltckXNbbt5FW0nRSp3m8+TqrGXErEVYF0o3Mc8/hl6NqFtwnyOejNh1TmqTJ2yEW
	/vud+Jn30JEJMk=
X-Google-Smtp-Source: AGHT+IFbO0LQXpb4o5AfjDjgaLCI09lbX8MmFHBChHx28mbb47+GctVRETBu/lxFgwTGAONEXXUbu26j2npwF4yJSjI=
X-Received: by 2002:a05:622a:2d3:b0:4b4:8f9f:746c with SMTP id
 d75a77b69052e-4b5f8398f6amr130559411cf.23.1757435182490; Tue, 09 Sep 2025
 09:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <mafs0bjo0yffo.fsf@kernel.org> <20250828124320.GB7333@nvidia.com>
 <mafs0h5xmw12a.fsf@kernel.org> <20250902134846.GN186519@nvidia.com>
 <mafs0v7lzvd7m.fsf@kernel.org> <20250903150157.GH470103@nvidia.com>
 <mafs0a53av0hs.fsf@kernel.org> <20250904144240.GO470103@nvidia.com>
 <mafs0cy7zllsn.fsf@yadavpratyush.com> <CA+CK2bAKL-gyER2abOV-f4M6HOx9=xDE+=jtcDL6YFbQf1-6og@mail.gmail.com>
 <mafs0h5xbk4ap.fsf@yadavpratyush.com>
In-Reply-To: <mafs0h5xbk4ap.fsf@yadavpratyush.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 9 Sep 2025 12:25:44 -0400
X-Gm-Features: Ac12FXx6epo0S67QSojcQ_-q7eHBI3YWc1_bazn-CLdcZQ8RS6cUC5rSpC48xWE
Message-ID: <CA+CK2bD0FGsqKS70bCgiD_1T2S092-UDy3saW9p5KNZCzzYjPA@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Pratyush Yadav <me@yadavpratyush.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> I think it would help with making a wider range of roll back and forward
> options available. For example, if your current kernel can speak version
> A and B, and you are rolling back to a kernel that only speaks A, this
> information can be used to choose the right serialization formats.

At least for upstream, we discussed not to support rolling back (this
can be revised in the future), but for now rollback is something that
would need to be taken care of downstream.

Pasha

