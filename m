Return-Path: <linux-fsdevel+bounces-57085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73B1B1E99E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB815A147E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2261482F2;
	Fri,  8 Aug 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jXaZG3tH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C1126C03
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661261; cv=none; b=OxpoVUCpLYd3qzCk9K9yfH0X/ZQhal3AWhGm+pmLjt1lx67+syKzGRAfZVYUCxCR+oRva2XCtULvSYyfCilEORAe4JEZberIC3JRYTVHstetPdqfpTzFMrYRCf/36oJhbaSHhjL8urultRyUaQ25o+q9Atb00YAZPCFTzP9Ou6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661261; c=relaxed/simple;
	bh=jzUwRFYMwe0kkKb7Wpg8iUyhHURaS0YrhVvgitXw+xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn/d0ZVK5+o9ATmaOI49fWhpVjqddeqSxFB9Fsuufl+kCge4SUt53/tzgZcVO+pHuw3RKxkMmCHU6R7CbGSiaCVKThnXYa+bVQV59WrPpHxDV8K4uA1iC6ebaYFSWwnAstnO6s97Ut1tLtEVNXOhizoPF2z2YWfJcygh1ZbvP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jXaZG3tH; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b06d6cb45fso27017881cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754661258; x=1755266058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzUwRFYMwe0kkKb7Wpg8iUyhHURaS0YrhVvgitXw+xk=;
        b=jXaZG3tH1PMRB0OKnWtxvsHd1Rk10dwuOCEgRiZ5YbCBqxQQTw+Jz5KwUYNcNChoWY
         xf4WD9V/Y23gBJQiJEVrIPi03TQslgT5miGCO0uzvGNjvtW1WMcFKZt2vM+ip1npFZHS
         /7IqrN1uq38jyr+pHzz6F7KmXrCR7uYxwubanh4J6jGtp8ZBw4vJyUsbiEMcKnqocg4O
         18KlT40DuLg1Ls3E1ao8KTRLE2eyQAhs2Ug1pzUcsExdnM2/sloRo03ahg2PY6lKrGv1
         kvN898/zDWHpxKrb1Q4s38J4C2/MMk5prFbc22KsrleozyUhtwxKMRqLQEHRQy/mrOab
         uzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661258; x=1755266058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzUwRFYMwe0kkKb7Wpg8iUyhHURaS0YrhVvgitXw+xk=;
        b=tO4abai09qvZ2C7uf0FAJID3xp91ChmsBCWAgGZschyN1mzItsY+ttnNrQgD7Bp7kG
         se5ej7G1sgIvZrSABpoaDgYwqk/VsJOcTOZRaRV9E+Z39qkQidDu+W7/Bf5YNTS8MoIZ
         bCLeDZOQqSOAKJ0cYr5do0gSu5iRXt29IkLBa8W5iAAi/qMCl5T+Ggbd5UfjhKJ8LxJp
         MDJ4GG7iuyC0nJT3tex1Xs4BBzxJLr4mRctOQcQkWpjFMctFZEirz00E1VN/f66Tfg7K
         zCp633VPgA2EM1ZS/qxN/zuWl7lEmOiRBZhbOKFGht5rGohhbIQyOPiaTpiXqTVTEJWI
         vnlA==
X-Forwarded-Encrypted: i=1; AJvYcCUPzH/3YN1h4ZbDVgtYNE0gOAa9JKnkfmskFSSXVkj1DIQc5OwWnKQEOD5zcEGok1UIdkx9zptp1mWckQbe@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnmj86Vp9JELgpf7ogE31UJrvZ45hXASZIMl5K3zbxU2cr18X
	LmfNAtq+yRAeI+ALc29oGFMmCz8pzmPtmu7ciWSS69lv7g7bUb8AlM1CfLV3CDdQX8fyZ2c3rzN
	7cqfSX3ERYlyFG6ATti33oTWxZRXaIOnVuUjhRF8UEg==
X-Gm-Gg: ASbGncvFl+9EJp0vf+n+iQxNxR26yS10upWiaH4E7Rs0g2rDcZEYeR0zyOfqwx2s/dj
	BkKQCtcfnv/WPgzFPi1rWm5p1lDGFlyVxKsJC+EPUn6nB3J5q3y92gyrRjWIaZoWlUc19fKm7ez
	alb5plK3wtlFRV8VPzfWOX7fyuBbKHjb57ET7vTbTh8Ri/zGcP5qhSAQ1bgJ8tpwdLt3ggAr5PG
	now
X-Google-Smtp-Source: AGHT+IEJmYietSH5VpR6RMJMP415b7zyz18sRNUfhN29PGY7yEn2BPdHDpMV3lyr863RZFGEM9NfgFIb4ZTkLRTpI/s=
X-Received: by 2002:a05:622a:1181:b0:4b0:7620:7351 with SMTP id
 d75a77b69052e-4b0aed29dfemr44241331cf.13.1754661258448; Fri, 08 Aug 2025
 06:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <b227482a-31ec-4c92-a856-bd19f72217b7@redhat.com> <mafs07bzeatmf.fsf@kernel.org>
In-Reply-To: <mafs07bzeatmf.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 13:53:41 +0000
X-Gm-Features: Ac12FXzC2ItcrNrnqIm-RSLWTwNqS2AX71-Cg7eUT1NgfRdHm0ajR1sU163K8_s
Message-ID: <CA+CK2bCd9x0KA=cO8EauJ=_GJ-GzO+0Z7HXN5=cObxuGzFDzCA@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, joel.granados@kernel.org, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

>
> And now that I think about it, I suppose patch 29 should also add
> memfd_luo.c under the SHMEM MAINTAINERS entry.

Right, let's update this in the next revision.

Thanks,
Pasha

