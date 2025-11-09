Return-Path: <linux-fsdevel+bounces-67556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09071C43742
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 03:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68D154E047B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 02:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798B01DE8A4;
	Sun,  9 Nov 2025 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="b0I93vTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1F1C6FEC
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762655553; cv=none; b=A8uXeAveTgcZoFqKDNuNPKxNO4VRFMSHenAHGOrNsuBJ4ex/Dh4b7/YIPwivMDnlbkcvBnyKkd7+8oi9KGnh4ElV1gabCR7DpbisNMJ0GSJ26OEymgOkOObvfvvD8EBWFwXuK38jtwDmjpJlQ5XGXsUDp5j9BtFYLFtv5kZNLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762655553; c=relaxed/simple;
	bh=8wnVlEDqMdtcwfKI+Tx4kOKYiIjjZzPcvCAbnijyJz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8JgjfUAcbcpgN7qfq/7/dBjl6s0bX0YwsjeA/UNb8Lk+vEk4GqxMYA6bOJVPDnAxLgRS4Cy7Y9yKg+ByHZy9GHfueWvswh2UiRqnJbNuNxMLOBUimzgCsiWZ7pw1jRXkJEVVwEoyNmmeLRIS1HseRaSAyVV06JaWu3FxvdQKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=b0I93vTv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso2216379a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 18:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762655550; x=1763260350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v3sUd4yemanGWTyJ8Beqz7xtQVHp5hlUsPWyPSJXOUQ=;
        b=b0I93vTv/1CuhJD5S9t5VkO3h82xRN8BBhw5WUK8w76QXPFlkbgft6ZQR0PLu/Aqa5
         5gLIyxnZuICXZU2aJeuALxwBjPKEy7PU7hqcasm1LaJfnudYo9gopK00XDh24b6NC83k
         dcOlrLF25ySQoUknCtiI7fVaw0GDH7vRoYU2pXWw3cezIaAhahKeE5UywCH1aLqT/x1H
         enZuZLBusJR/gHzgxfr+1bnuYD9jk7v4/acUR1WwdBcESAhfc7nu52n+fXSXZXH9THqI
         3CIRn7vQSn59yCRx1e7RYlpwQvGbl20RChs97VbMYvycR78jPeNeP4+S37aI1BEcMcQc
         3eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762655550; x=1763260350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3sUd4yemanGWTyJ8Beqz7xtQVHp5hlUsPWyPSJXOUQ=;
        b=gc4WaT+zynf/WM3gss0Uwxi9NIt1YNxZg7A94exCxSIoI/VCwl1UuDhojI76h0nmm8
         zvdfLRzc1HIwb4neK8r9QjSp1/XsZDVWFOOSwWMrcbU8xQSCkGF8c4Sj2X+QHvER37MK
         PDiIuQpWVZrHjHXAaNQnlCcKuhnv2GHATJiIbOgbSjcm4jx8zoufafEJzaXok9oN1HWA
         Ld8pe+U2y2+dKU0TY8o6K6IGs/CKEmQgqkHIYkJeNDSSAptRSjpv/cdbW8S+OgSHiRSd
         U/+sV8ENMQNHOjmaeE/H/n77P1o/EcFyzxT8zKfKPSrE/FKvHHr5GeR3SODehM6+yeft
         HR8g==
X-Forwarded-Encrypted: i=1; AJvYcCXZlxgOud5AgEbVtZKbO/r89yTlPsEi8RMlJZtnDRHUeLpygIe3mSkMheCYJkcp/dTbcu5GuMpxOxnPSK5I@vger.kernel.org
X-Gm-Message-State: AOJu0YytrBK/9j/RyizEpW0FVrc78gfByaGg0PA+vT2jsc52xsuFXDJZ
	kHvQPYYu8JUVgOSOHs257a+RlkTIkGWkJ2lAnhj7lHHgVJ++JNS7BeZq2LzefMCqdUxku9ijVhH
	HmcXraeuUIIknvLn7PJAOcLwP23925WUyCL/D8e7vBw==
X-Gm-Gg: ASbGncubfNXfFM/eLWX2n+K++A1JsBfMKI5Be6KxhR79JddCYKmicD4MOW9pC0nYMfX
	JHSjt0hgLhx3g4J/AwO+pDiD5d2dab7DQ0EZQqWD+qShxlXmA5Jv9GY8oXairx7skiTZNin8waI
	U+IMAIOg0YujRj/sxglkVQ2UfKIcDCziWbQwbCMHRJDMfOaAnJiVEL6zqqAqvdhZWdmNeZTreg2
	W+BobgelXsabdFfdQhN4DuAaM0dK7tnqP9wNDDJVWxeeLu273AkKoQBOg==
X-Google-Smtp-Source: AGHT+IGkPxaoskiODxv8UFWCdDvkCCatOQpLUt4UqpyBbWyWH0iYYiRs5ogfnHqSYP0nAMnRxIXTeT8EwyG6LMTSdO4=
X-Received: by 2002:a05:6402:270f:b0:640:b7f1:1cc8 with SMTP id
 4fb4d7f45d1cf-6415e822f52mr2906725a12.18.1762655550218; Sat, 08 Nov 2025
 18:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107143310.8b03e72c8f9998ff4c02a0d0@linux-foundation.org>
 <CA+CK2bCakoNEHk-fgjpnHpo5jtBoXvnzdeJHQOOBBFM8yo-4zQ@mail.gmail.com> <20251108103655.1c89f05222ba06e24ddc3cc3@linux-foundation.org>
In-Reply-To: <20251108103655.1c89f05222ba06e24ddc3cc3@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Nov 2025 21:31:54 -0500
X-Gm-Features: AWmQ_bkVcbxT0gV7fpmnxd0SCIbpS_2m6TSXTf-t_TBkr04sjlFMoWl4do6gJ2w
Message-ID: <CA+CK2bAcQZM76dO2pHP0M1wAUeq6m7kKijSxoWDv7fvyreMJ1g@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] Live Update Orchestrator
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, tj@kernel.org, 
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
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> No prob.
>
> It's unfortunate that one has to take unexpected steps (disable
> CONFIG_DEFERRED_STRUCT_PAGE_INIT) just to compile test this.
>
> It's a general thing.  I'm increasingly unhappy about how poor
> allmodconfig coverage is, so I'm starting to maintain a custom .config
> to give improved coverage.

That's an interesting point. The depends on !DEFERRED_STRUCT_PAGE_INIT
reduces build and potentially other automatic test coverage for
LUO/KHO.

We should prioritize relaxing this constraint. There are a few
possible short- and long-term solutions, which I will discuss with
Mike and Pratyush at our next sync.

Thanks,
Pasha

