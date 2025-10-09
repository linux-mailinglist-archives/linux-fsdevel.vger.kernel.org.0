Return-Path: <linux-fsdevel+bounces-63656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3E2BC8EF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 14:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17875420636
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84D264A86;
	Thu,  9 Oct 2025 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="b+zMQNGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DA34BA39
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760011318; cv=none; b=dmwJDz1ruifuB2vpW6GEApJWcAwmsWekGrtKuvq5/LsD6MDudaFazlbxzwJLYisgy86oqwjwFtDjq4P4oNmcH90Cboc4oHy4G9NweNdgJWo7wFHMoSTj62ExFDw25dH6sY4F/3/FptYSuUe1DuYDhDzzX2uqmXMj86qcZC3XO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760011318; c=relaxed/simple;
	bh=GM7HHu3HbolbVRGEPyllWwUcu2/FcpmuCKiQlqwBpNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qx7g7P8pqFjy+Gu9GE38TrH6KvMgGI2kjuf7SJMwfJx0onLSnlyRUw/fB2vWIeMyb5fP6cOHoX2trY0+XRMmgLE0DaZb9SVJfZBqR2lSQShVjLnRpUfLJgIBG9YTIyhEPrYSN1JYtMsJV8N1Dw041JQfneyWM4Dhju7PwRVZUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=b+zMQNGz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4da7a3d0402so12685991cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760011316; x=1760616116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GM7HHu3HbolbVRGEPyllWwUcu2/FcpmuCKiQlqwBpNU=;
        b=b+zMQNGzBJd1OaeJknxqIgA61IUUVrXkv8oIP3xZ2A0MdE1kUkFPP/N/0/QuUD4AJV
         N2naFEJj3vuVNfiVA9tpl7OH4gGf5eVN5FROd5V9mKU1OWYCFcuFVssSdauYOi6AUD/6
         WnMaklKCI1d7IS+RjHFdIpL6cgsbVVuZYf0mekI2EgeAPnUFh0kuUfSy61tIOE+4pa3i
         MV1oHs6F/pMl5Y8IkkBfyQXR0GRc6waWiZeDGSFpVeE8gLkKgYRBF6vgZfFF8SHims18
         DJzf5+VMrn7FWtL36gms+zIvDJUV4PXpXGcBx+ITMjtadkuovdUz3uFKpgyR33rvFcGv
         fCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760011316; x=1760616116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GM7HHu3HbolbVRGEPyllWwUcu2/FcpmuCKiQlqwBpNU=;
        b=HMAJObrYjRImDTZnydPEK/DwjM9XAh6zZyjrG4vgJm6VmH5XPe9fbGNtynpbJXQ5Ey
         M8Q4wc6V42YJG4YlVDVYzclkKdp6sNZ4R7Sbay92iD4SW9mPF+I/5FPWF9WDOjG5qlJa
         15umj/H0n5Zp1vh5n2dl0xlkunmAtxgZ1wMu1uWizFYlWD+sD2NrxxI8a0OjhbipfAv3
         C26OgJVRqmmChGoMXGkMyzDv1e8BFMPtDhWaXNQqwQgHaqu8e9nAxAXlUKTJlrQMDqj0
         UGrtityaE4EIvEVUj/BM+/L+ZQaZawWXNC6Om45kIJgU2hnMCxopYzzeBfkes9dR2PYY
         Ky3g==
X-Forwarded-Encrypted: i=1; AJvYcCU40Sk/Na48eoEjBCqk9ZnxyB3qxBubO2Z1ZOJt+m9ExFNoLbiygGTvGS4dAb5jYaMn+ql7Jm0Ns1AYv6Q+@vger.kernel.org
X-Gm-Message-State: AOJu0YxiN4sw8XOld4jUH1i8c1Tky5jrWd6PIpAZkaMj8SVGe35UNfNW
	8T1DehMIamaUCQksoBXr2QWYChm4ghjlxKG9Hdng9wBdQjpc5ZrARp0Gq2mmJm7xkw+WrnQ0sZa
	WMK0ZofDCShS9ssESgqtzAVlwK6brZdhx4o2LFxj3ZA==
X-Gm-Gg: ASbGncvV2Gg5E2pl/Zry1/tMB5uABUVI5RxN4R4zhfFRPcTs1hSE7+OzK31rnOzYc5s
	ZfHqf7BUcW09Jx7s3Z8hlLAJdKspwER09vjqwRadWTmZMjgF++gLjDW/12IPGDk23mpcQ3YF53x
	sft8/VOLMjJt8OTuZY8WkynsRIznguThoHnWEEnwBi16Qh7EP/wPub3cwq3eOsQjNR1zxqsrU98
	BMhiAe2FfAyN1u4vTbsov/5PvgM
X-Google-Smtp-Source: AGHT+IE9zb3wwXEpUh5P+ZmZZJCDFFOKUQIOo3/6KsN55Cs1OSGbV39rZ1DIVG9kDY7HFP8FPvwlsRPNuhjvFarm0hU=
X-Received: by 2002:ac8:5d4d:0:b0:4d2:ba6f:28fa with SMTP id
 d75a77b69052e-4e6de8b5d39mr171303161cf.34.1760011310206; Thu, 09 Oct 2025
 05:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com> <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
 <mafs0qzvcmje2.fsf@kernel.org>
In-Reply-To: <mafs0qzvcmje2.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 08:01:13 -0400
X-Gm-Features: AS18NWB0gqbxGnAmt0TyUGPWI9yXOeOjTQwVBIB2xaJy4b4dnuqgnZXYRRh26fc
Message-ID: <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state monitoring
To: Pratyush Yadav <pratyush@kernel.org>
Cc: "yanjun.zhu" <yanjun.zhu@linux.dev>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
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
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > Because the window of kernel live update is short, it is difficult to statistics
> > how many times the kernel is live updated.
> >
> > Is it possible to add a variable to statistics the times that the kernel is live
> > updated?
>
> The kernel doesn't do the live update on its own. The process is driven
> and sequenced by userspace. So if you want to keep statistics, you
> should do it from your userspace (luod maybe?). I don't see any need for
> this in the kernel.
>

One use case I can think of is including information in kdump or the
backtrace warning/panic messages about how many times this machine has
been live-updated. In the past, I've seen bugs (related to memory
corruption) that occurred only after several kexecs, not on the first
one. With live updates, especially while the code is being stabilized,
I imagine we might have a similar situation. For that reason, it could
be useful to have a count in the dmesg logs showing how many times
this machine has been live-updated. While this information is also
available in userspace, it would be simpler for kernel developers
triaging these issues if everything were in one place.

Pasha

