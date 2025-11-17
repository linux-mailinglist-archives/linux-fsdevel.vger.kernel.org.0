Return-Path: <linux-fsdevel+bounces-68741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BB2C64A40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89D9F34CDC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97C3346BB;
	Mon, 17 Nov 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gH3qohYX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F932E6B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389719; cv=none; b=jcU4uw0SSfXqwyTaurLr8kQ5Xhl++Scdnxv+RIf74eX/LEiM3f3ngq57/U6SKG0uLmbI/75pRtaNQSJpo0HgPK2qLwu2GKl7KVNGxDjuIPyMf78+b8jj+W/GwIOxUp9wC4ZS/EbQ8s2KL0GagkCHOgoqF1yXaI9bDzNPoLF3i1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389719; c=relaxed/simple;
	bh=AMc2ILHILGpbxf7Iwmbtxzu0IeHwgu3vwmxmrbvehR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+5U/D2i70/UTISiRt44k2596KfsFkiJ9uQ0pEc/EhZgxqtF5TLABWsN7fx+xuZYnDGHPV9iv9hKJpBCAUgZVgjpDmrSrz4ZllcGcAuWdPlCikts3gAn0xK82kJFtQB+dAhTWjZP6I0zPTXeYBbcmsJVuwekdulMANzcFkk7lIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gH3qohYX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso8406770a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 06:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763389715; x=1763994515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQVCE/CnnGowlKqCGL6JwWMjWGkEt4E9DF7myhq90M4=;
        b=gH3qohYXE4nIIduaKocyNkDSMBKDGdCkktTQvcw+xHdSUGksf9O7S6XGkyMEf//xAB
         LkPUhK/ky2QYWCafHzVuZLZYaon1B8+4IU1W9seqiT7X7R464Zi4DvgOPG3ecY32FOsi
         w3gRvFA/PckwXM9JpIcfbqczID4xkFKuqcof3B+AhvL+C26n3/7QoyAGES38XpC7v7Kv
         gbGll5xibpqLtE2Zl+AesQ5CvBkeV0O4QYLuopFE5ubp1eB4K4e4Lh6xs1b1v7w52nms
         4PJKoa64UiLvDSBLCYwqLMG6Z0uje3G/3gGLfJv7V4PaexZcTo5WxKmgVreCecrFc1EK
         /Z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763389715; x=1763994515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQVCE/CnnGowlKqCGL6JwWMjWGkEt4E9DF7myhq90M4=;
        b=L4Sf8No2e2Hu7+d7O8/N4l8mQwn8t0px9Ni3WPHqmVeYBS65kgmpLBiiKqrO1Txae0
         Lmx+l6qxDb0gTWq/Ubq2GLC+Ra7+wkjvosW1ltQrui2sg5nqVjhQ2jkCeTldFSkuG+20
         mTdipMT7IeIAod/4iesY26qUNnKSfSbm8OZ3AlBvQ1aDY0aw+mWvjhkiECbecIq2A+T0
         HyGgRMX9wHrsgAIJuGe27ZgtXEfl4rOSzRK1RfVHOf4q8nO6xEbTmj4yb09KnZhoEPRB
         5M7Cyiyhl8beKf6G0mxeQAYjV9VpxIkpqTKmZIrAm/UwxyA0F5hxkngE520s46IbbR/z
         n3cg==
X-Forwarded-Encrypted: i=1; AJvYcCVLNlrxTyTs6RmbMm6cJDlYWtaSYr16D6EZm3llI2RNquZBfzhwZVFvD6NGAcU/Wyy9F+ZhANUH44F0Zqhn@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfpIyn3Inlqulu2/2uVSO//AX8QxeiLRxsk7ObJKFSv8b3Jjr
	yH2MaKvl1b+0j/xgtP5ti8qdZajTTn6ir+lO6o8cNVtA0OXAZqsfCYOZETL3NVy2yAFYuTkNBSR
	UtB3CzTMs/yijlkHqQAqwUZdc8+yWeUyILQhIYkP2xQ==
X-Gm-Gg: ASbGncvzdHMty6WiLKanBu8Eq11ffTT/C1gNXsO93nR7X+3wY4tsmb97N9R3+7jEY8q
	I3/5DPNF4ejUiMUfQvIJ0RKQzReRNlR6FMuWx5cijGycDrYD3SSO7MO2o9uZQEMs6JkFO/fSskI
	cpq3obKAFgTyjDoht/nJuiqzU8jaEEf5PfPLngmu9B0volRzdoeNE+rLWd1csaUtTMRyEE7dkVn
	yzs7UtATRJ3zYfjUreHJakiRBS+Th0RVY1mi6CF5F6lbrSRZICgKD8WjA==
X-Google-Smtp-Source: AGHT+IHFe/sTuuiJ+53/94QiMySpnxf4UN/E970XTSsHg+BmNQprmENpJq+u5KG4abgGaMQyqcrDGuE+yfqH+ShvDHg=
X-Received: by 2002:a17:906:fe4d:b0:b72:7e7c:e848 with SMTP id
 a640c23a62f3a-b7348570745mr849235566b.17.1763389715484; Mon, 17 Nov 2025
 06:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-2-pasha.tatashin@soleen.com> <20251116185406.0fb85a3c52c16c91af1a0c80@linux-foundation.org>
In-Reply-To: <20251116185406.0fb85a3c52c16c91af1a0c80@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 09:27:58 -0500
X-Gm-Features: AWmQ_blpOVxmRUODWBmJWtPPz2QzcGqIJZJTFHJU9AtpYTtzUk5ADMkO-uE2GJ4
Message-ID: <CA+CK2bAKm_Mb0Tp3Q5X=B0ngYrrfiT_pQ5P+c0=YVCXymxkqXw@mail.gmail.com>
Subject: Re: [PATCH v6 01/20] liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
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
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
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
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 9:54=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 15 Nov 2025 18:33:47 -0500 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > Introduce LUO, a mechanism intended to facilitate kernel updates while
> > keeping designated devices operational across the transition (e.g., via
> > kexec).
>
> Thanks, I updated mm.git's mm-unstable branch to this version.  I
> expect at least one more version as a result of feedback for this v6.

Thank you Andrew! I plan to address all comments and send a v7 in
about a week. The comments/changes so far are minor, so I hope to land
this during the next merging window

>
> I wasn't able to reproduce Stephen's build error
> (https://lkml.kernel.org/r/20251117093614.1490d048@canb.auug.org.au)
> with this series.

That build error was fixed with the KHO fix-up patch back on Friday.

>

