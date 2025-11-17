Return-Path: <linux-fsdevel+bounces-68772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0EDC65C5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA45A35DA76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A08D328625;
	Mon, 17 Nov 2025 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UEYm5eQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC463195EC
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405165; cv=none; b=ClCOMIhvNgY91Jx7X+TD88RELj6xkNMsH0pum0BJ4mf+D/yUZ3m36CmQlt6BQDpCx9V13Q2wSNi9XJajoh+qa5FZ2JHuBpwMNO+m+VMxz3vjRz64uUhmMnio0aWQkuvoNKzzsiFLUvarkhBnK2nILiyjlfwue6ArJBCqvrfk4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405165; c=relaxed/simple;
	bh=9L0PWDNFpIwYA9Tdoy4gSq9mMo+JaoLTYqKodPhceek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkTNpTOYYJuSLAOv7Aa/xyjIqWwt0rjxHkz5SkZo3VBDKQheHvp2vvUnep6u/6FL9U+PUO8LY6jEvAgL1pIwUKLof1HjwVf3guUurhghGjLZJRDoV2VcmgYiB3I6mGtg49fUggmu9Y3cxo8HXYdQ9lcLXp+3ci+fkpU3afAQI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UEYm5eQH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so8181733a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763405162; x=1764009962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9L0PWDNFpIwYA9Tdoy4gSq9mMo+JaoLTYqKodPhceek=;
        b=UEYm5eQH/ZaHFTniJ/bWeAQjEfOaBtxfEXk1TCtKFVN9k23U2kyh+2CZwX8yhe0Qb3
         rFFtXAJw2fNQt37zw/8uOu74ndcqA5jmCtAY3gquwM6NVFjweAQ2fokorELyBSt3RwXo
         Ytoqf6RjHhAJzZmnSVW9rQL2AsDCo0qfJ2h/WHd443/i/I849h+SJZdF+f0S11tw1le3
         uQeNNR+R9MK6J5lEYRiEXYVT/hhSXe855am6ZUvsN+1RL4tOtn3a4X4oDb/NSshwHIb7
         6VwlEyN6+mGDu5CW/HA6Zy4NEhgpHbYrhHZJC0a5EhHGz78svG58AN8PgLwJXyagetgL
         qwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763405162; x=1764009962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L0PWDNFpIwYA9Tdoy4gSq9mMo+JaoLTYqKodPhceek=;
        b=uWWmVa6RZG/Ok9rVG8KSx0NSR6g+P4QFjxchn7q1elOBD1YZ+FIpVS7tWFKBgiI5iP
         K45Pcm7Nv6DRNJg4go4uEFiTHYaXl/8Snb6HWUH+p/QYFmTiFU6OV6INtjs3u+9PYdnZ
         yBYiJevsMNP9g/W/NoUjYYczm8NRAyXymSoO5PiXuqhuXMz6y28d+CK0gL/PVYLW+N+a
         0ejrXfbD6bYbNp9Nxm98iOglD8Um1gbWCuCo/3P7+HkMR+nZSA6mv8mjpqlcCMhy2Xd9
         avVJB6hXcF5daGBX+P1qoS5lcT0zIk9mU4p+YFekzNu7czPN8SLE/l1RAonTmi/3Okwg
         DNTA==
X-Forwarded-Encrypted: i=1; AJvYcCVzPWAP1a8b7eJzFEsa+qhjIZmb4LiKSKcpNl5wAFn8bMyy7oTME7lgYMANrn81xXb4L85jfXu0O36GfeL3@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVGDhV8Y1OXDaaTnUuDDuZOBq+xocB/Q4IUVB13bpEeNTAewO
	W75rpHnpJa35qqe2QkVGu+xrs7BlyB0WqrAh9HAi5MgJEF1be/9omj9M7pWojCXsraPOVbGH040
	0u12BdnGJv4jY54HTRADhG5C6hfYyfI+hB13Fq7YPHw==
X-Gm-Gg: ASbGncuO6OExNqeJus5VuLvIlXLjslhsAForB67qB5ngLsTwMnqi7PvQdUz7eaXPiSp
	2Hh0xXyayCnenms65B4w4zzJJRoshYCcw6DdYAgyLo0uZAPmIWiCD0wdtEjHA3qJM8BvY78CM/D
	P0m2atUs+aeQMUfpvBjwH30n6BH/YoUh31hYqmVxowcVsudR6m72keP63cFRTrzN7MRdJt4AXRh
	tWxCWmiHkLoSvVYx8n09LwSVeIszdjv3/nyU3Rj8EaeU4zSGxqYr0fonRPbqbWT0jHbRlQbpXN6
	okI=
X-Google-Smtp-Source: AGHT+IHTS9jPR539K9D88biPeBpW9OArAzo2mtlZDaqK9aFcfZt0G8LfWzYGUIJ/Wa0xrvoSHRJmq2qQHBOC/QtRtDw=
X-Received: by 2002:a05:6402:50cf:b0:640:c9ff:c06a with SMTP id
 4fb4d7f45d1cf-64350e1e3c6mr13108669a12.15.1763405162259; Mon, 17 Nov 2025
 10:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-15-pasha.tatashin@soleen.com> <aRr13Q1xk9eunilo@kernel.org>
In-Reply-To: <aRr13Q1xk9eunilo@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:45:24 -0500
X-Gm-Features: AWmQ_bmw4ppe8XlI-hroPbUkA515iug7-539nPCKhJSWJUeaHTdUDKi6DO6pH6k
Message-ID: <CA+CK2bC2_r4Nbjh0CuJwcMeGxpctSZMTodG8Cf=zoue6zj-gyw@mail.gmail.com>
Subject: Re: [PATCH v6 14/20] liveupdate: luo_file: add private argument to
 store runtime state
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> > Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you!

Pasha

