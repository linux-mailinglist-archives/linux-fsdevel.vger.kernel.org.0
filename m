Return-Path: <linux-fsdevel+bounces-57057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A7B1E7B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056C1164EBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F9C275842;
	Fri,  8 Aug 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwuuhoIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30932274B4F;
	Fri,  8 Aug 2025 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653695; cv=none; b=CJOZQjPtEdDRgAhMZTC277QqYRda3MS65pnHGzp7CN/rCnzvbiqX4sj5ZG46BflnbyHfjhiZFCY9Dmz8Kshl7GvKZvdz9lggYm9thMxt7p6Wen36pFfaxGTmn8LXjIt2bAEUOrhj5jyJqs8b7YY1FiBdHNzQ5qis9a6vqvXyHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653695; c=relaxed/simple;
	bh=aUwwLEPyMUejn/6j3TbLyJ9dkoIcB9PsgLXsaIIn2ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8cFrmaLeBsx7Hv59L4WK3su1HLDZxnc8fYIdP0VMI71tMeh6MG6WtxUpGj6MwJqHocd2Sm0Xhl2do2Zl9HSK7RPbJF1pgynMxtcAMxRDgsgl2TB7DcobvKasOl2ba+DC+0QRPoAKNwT/CmmWry2qlpjO7BOx1py2d/6gvQOl/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwuuhoIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E4FC4CEED;
	Fri,  8 Aug 2025 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653694;
	bh=aUwwLEPyMUejn/6j3TbLyJ9dkoIcB9PsgLXsaIIn2ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kwuuhoIsntxmMvjULGKR+fbMO5OmUIAC8z6hh0qq/hfqifRrQZ9ZNp0VHDryFvo3p
	 Qaq986CkXgUCTmb1mavmiVcYwmoccQ/gwYcU1D09Uo6dbHfBeYqfdFknzMyllRlIyG
	 q45GYr0i5+IW5iitggvfthDfgHoTwFBdodG55fDOdLOqkYNY1Gytqv/e9rQF2H1KUC
	 rmMQwedbpyQydNhu7AkKxqo+WmXcl3I1f3h2q1q+jkqE4YewtLwtymcRJbJr541aBA
	 +FNFurbzmb74Oe74otpLpOPjfDt0vgmbUznCo99XBgeVLrDa4og84ZtpljqbzEm/bi
	 66xOz7BE/D+ZA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 03/30] kho: warn if KHO is disabled due to an error
In-Reply-To: <20250807014442.3829950-4-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-4-pasha.tatashin@soleen.com>
Date: Fri, 08 Aug 2025 13:48:04 +0200
Message-ID: <mafs0fre2avbf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025, Pasha Tatashin wrote:

> During boot scratch area is allocated based on command line
> parameters or auto calculated. However, scratch area may fail
> to allocate, and in that case KHO is disabled. Currently,
> no warning is printed that KHO is disabled, which makes it
> confusing for the end user to figure out why KHO is not
> available. Add the missing warning message.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

