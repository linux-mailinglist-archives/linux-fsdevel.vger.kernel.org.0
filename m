Return-Path: <linux-fsdevel+bounces-71028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87491CB14AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 23:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9034830FF07B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0585E2EA493;
	Tue,  9 Dec 2025 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJRI0IHh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A25C2E9EC1
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319350; cv=none; b=hIe8BNizJ0BJZuLAkpXm3dNToDxHoi7rUN3ItzCIndcjISs0zvdDNLbI2tOblzAWMmDqu/2ObT/SVuvFohVoZUDF24cgYdeNwPZJ1YVxjfWO8L+RTog/VjwbgwJG73EbxTD/QK1ab2l8DNuVfbJkQY6yJWcROmaLCbjzDe9NftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319350; c=relaxed/simple;
	bh=o91c+6a2q/yielwE2TK8La+n/rzQAcUKJ4GQTa1UROY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+QUIA9HkQfeV1XMQAXdpCtXNF3Pw/8R1KMqVkQQKaj4l/MDfWE2FVNbzAVI0wuliXpj9taSgSdzR6YYKl1YoFxqdqMv8AmVc/BIldabYaZtkQSp/QT/b77w4ul+Jl3EvOnEpItw3jXEji/u86VNYx60pYIA42o2wbeskTXnfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJRI0IHh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37a33b06028so56269321fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 14:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765319347; x=1765924147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyOMhD5Nr+LLEEj2u+rlI4XyERWdrAPIKpRVAUxLoC0=;
        b=GJRI0IHhP3v1rDmq/Y+SE9mCM6bpBPoOToIv9/eRDdFgOlxaNa74xVsDmht6X0NvA/
         C44RvSpQVBTQAGg+P1luNGQh1cyBtKIRprA87iCp4C9GsA20ZmYyCZkaKz1KTGY+28se
         mNH/+vrs3eXEfAfqUQi1MzfIzX7kkGHKE4aZH8a78dEZPdPqcvYQj/UhvC4ailBe9ePp
         vzy/iaLml9diLX8CDHcghBjMXUdZR5VIoIeOTzL71BZb1GYcGWnQMUz+idh8V25fc4U4
         VmJA552g9G57uCP5aZI7S6fib6gvEixoSj1ym+mmpczUrjTf8joGuEOJWbXXg66cfArk
         prag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765319347; x=1765924147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TyOMhD5Nr+LLEEj2u+rlI4XyERWdrAPIKpRVAUxLoC0=;
        b=OC5/lXzTsBFxm3FoByGyrtP1mxtBMEDVp9wlEhNVEJu4XZ95PElWTqkwUu5/qoVXFh
         ofzEfU14iB2ZoFseNof+jjJ4MrfYEGLprJHvlSsK/as7wQs63H8Vx0PqUOhyKX/9t5Oy
         DcEXCZmEBXUE/Pb3IY5JMnu7yieIEPjp2eo7KgznvMUES1x9aImpUPS8D5ftQ1co2UK8
         sSPnQjyAE+pAXS2YNVbYBTp1WksDuObaojbBVzDmDYtiAuakgyY3d0BGVGFj7Zgz2xj0
         jlHqp5EniSK6ywSmzhe8DbPVZLytqMZFuFx+UhXsroPQg97Y2EyCL4LPQVd+7Md72UlY
         C/eg==
X-Forwarded-Encrypted: i=1; AJvYcCU93rhKhOm8BE1AFxmKZcYU32ozM5h+NGJhUuzRzh7e+h/U7gLfyOSENaYa6NC9eBl6oUc6V/xI9U/3GHK5@vger.kernel.org
X-Gm-Message-State: AOJu0YxXD1Zh27YrrfJ0FB8zCksE9bVNNfOdxxFohNMPZ8FM3sOaB8Su
	oRWqFrIghm9B0ZlA050qR1xhUpsNQpw9mx53PqIfJVSxGLfw6cbq3IQa
X-Gm-Gg: ASbGncvaHAPKg6eFSqfqmW2DHxtIYYs5IUqgGR6BOs5OsIOSmnyl93EStUL5yaAN3Pn
	LNmpFSaeBUKZno/VbY0LGsCWFKuivV7f9LHphkaIkdqxthvQHWDkAMP1PmIGTe6yXPdK1cfgz9j
	pBx02kvk+XlzPOtP/gX0Lp0mwpKTcTGwzxITEWufm6QhK+F0b78xsPy2qQ+Nn8gSEv+rJAlVEBU
	1tI/LOUWXKdaL4Pab4UQBetsGJ8Fyj2bQpsyFuLhEGxmFB57I5tPMyFqDubip3Uj1elG/gzB60u
	ON6X+onm50I9MfOIwYxl7y1t/GSzdrSycFHbHc0h6Iawxl4mWLSiXLd9pxtEtG3Yhd5+93QzODN
	rpJJj3XsGWJoCUQ61HOM/v2UULrzBsNGTzvislkj9s7UFehU1R8l3QcoA9/88MrJxBDe0xz6R8w
	rK/BVBuvfO
X-Google-Smtp-Source: AGHT+IEN00QefPL8NG5lBt7cd2OjXvYRO37SYqe46Fgp2ovK1ah9X3lROTHrSbzfsXh8SvY49U2k8Q==
X-Received: by 2002:a2e:be9a:0:b0:37a:45a4:e873 with SMTP id 38308e7fff4ca-37fb20fa962mr1047661fa.30.1765319346326;
        Tue, 09 Dec 2025 14:29:06 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37fa9bec20esm8264721fa.23.2025.12.09.14.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 14:29:05 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: cedric.blancher@gmail.com,
	Martin Steigerwald <martin@lichtvoll.de>
Cc: lwn@lwn.net,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	news@phoronix.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: d_genocide()? What about d_holodomor(), d_massmurder(), d_execute_warcrimes()? Re: [PATCH 15/20] d_genocide(): move the extern into fs/internal.h
Date: Wed, 10 Dec 2025 01:29:00 +0300
Message-ID: <20251209222901.1693280-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALXu0UcCGjyM6hFfdjG1eHJcmeR=9BVSaq7Vj9rtvKxb9szJdQ@mail.gmail.com>
References: <CALXu0UcCGjyM6hFfdjG1eHJcmeR=9BVSaq7Vj9rtvKxb9szJdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cedric Blancher <cedric.blancher@gmail.com>:
> > +extern void d_genocide(struct dentry *);
> 
> Seriously, who came up with THAT name? "Genocide" is not a nice term,
> not even if you ignore political correctness.
> Or what will be next? d_holodomor()? d_massmurder()? d_execute_warcrimes()?

Good news! :) Term "genocide" finally gone from kernel some days ago!

In this patchset: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7cd122b55283d3ceef71a5b723ccaa03a72284b4
( https://lore.kernel.org/all/20251118051604.3868588-1-viro@zeniv.linux.org.uk/ ).

-- 
Askar Safin

