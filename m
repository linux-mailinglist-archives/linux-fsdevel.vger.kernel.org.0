Return-Path: <linux-fsdevel+bounces-73804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDAD20F4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 20:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F1D0300E056
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416D33F398;
	Wed, 14 Jan 2026 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDy3xT6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184333ADB2;
	Wed, 14 Jan 2026 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417367; cv=none; b=gq+3dNgXwUY91jGQ9r4gtDN3PYD2gjHbOHI11QtXV9aVAsNZVHAiKZAceOxPfC4nY54NOsjIc5x72m45DZ9X//WrFZUd2krQ16fnc8Rs9uDjyQKBiaI/eeLrx9sitc39SQcSESNXu6YPa6DpHWwB5imBH3o0m2jTuGbZON0GGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417367; c=relaxed/simple;
	bh=/g7znYFrTNdvW4RKWutiVFghMR5mmCYvmvOEw8ACiRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rJh3IQFprwAAamvaj7L7qYhEnH7Btq1QU/9388CFJY4ikliqptc8O72YbEz36fUtH1bw7P652o2gg67zj8pYwGjMAeSUjHMo6fOb3So/lDPpA449Ud02X3sFcywPAXVHf313bC6tFAdG3L6obdSIn3NJ5X+e1PzlMUGQ0949f4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDy3xT6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC1CC4CEF7;
	Wed, 14 Jan 2026 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768417366;
	bh=/g7znYFrTNdvW4RKWutiVFghMR5mmCYvmvOEw8ACiRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MDy3xT6jPzV3ToLQ0kmCeUKluxH6b6eqZef89YSDaEdyPmUTF25s0ngTuJRsFWG9I
	 926T/0gY2RTddhgU1TCiaRmd4sCjIUiNFcQZzygn8PStwkaslCSJiBbriS+MdR5RTj
	 B/PYWWzg6p+l/Y98krWhmMK6Cvrgw3f+JfcZjWNbQbYOpPZCIpFUDsjnIux2zFOsUM
	 qS7dO+juVkXHGmH+RbP66XAuWNKf+qL0xFihgSLD8kYJp9N3hKv0AHG50sCTOIyUas
	 4CvfudY0fUeQnlrTe8OQZdiqGrDg83Wff11I/f/gUsKjJYUJf9t8TrQqO0WQYrdSdM
	 CP8ErjTmVxEUw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  rppt@kernel.org,
  dmatlack@google.com,  rientjes@google.com,  corbet@lwn.net,
  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  parav@nvidia.com,
  leonro@nvidia.com,  witu@nvidia.com,  hughd@google.com,
  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v8 14/18] mm: memfd_luo: allow preserving memfd
In-Reply-To: <20260107185414.GG293394@nvidia.com> (Jason Gunthorpe's message
	of "Wed, 7 Jan 2026 14:54:14 -0400")
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
	<20251125165850.3389713-15-pasha.tatashin@soleen.com>
	<20260107185414.GG293394@nvidia.com>
Date: Wed, 14 Jan 2026 19:02:34 +0000
Message-ID: <2vxzecnshvat.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 07 2026, Jason Gunthorpe wrote:

> On Tue, Nov 25, 2025 at 11:58:44AM -0500, Pasha Tatashin wrote:
>> From: Pratyush Yadav <ptyadav@amazon.de>
>> 
>> The ability to preserve a memfd allows userspace to use KHO and LUO to
>> transfer its memory contents to the next kernel. This is useful in many
>> ways. For one, it can be used with IOMMUFD as the backing store for
>> IOMMU page tables. Preserving IOMMUFD is essential for performing a
>> hypervisor live update with passthrough devices. memfd support provides
>> the first building block for making that possible.
>
> I would lead with the use of memfd to back the guest memory pages for
> use with KVM :)

I would assume using 1G-page-backed memfd is the more common use case,
and this patch doesn't come with 1G page support.

Anyway, the patch is now already applied so we can't go back and fix
the commit message...

-- 
Regards,
Pratyush Yadav

