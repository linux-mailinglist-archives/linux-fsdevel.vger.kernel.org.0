Return-Path: <linux-fsdevel+bounces-57686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB0B2491B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E8C721D14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62852FF163;
	Wed, 13 Aug 2025 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnfY5pRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410882FE567;
	Wed, 13 Aug 2025 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086539; cv=none; b=UtGdqVvohwY9npjBx+LA6g/fef5iYzBaU/4WoquUvTLyVSihtu7JOGa/l2n0Y1JzRGItrtLI0AWCBWjZTWwzAGYJXvzcAWMMU3ptGKs+HCFPVu65LRUB3w+eD36XcUMZDeEBswy+A5EvBS62q3SQ8BGjFkjMnm3tWKZii7gU9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086539; c=relaxed/simple;
	bh=2xrd0/GoUYp9e9PgBchb2nv0RPDgefUTlMhBngu3vas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hMTm3/4KVOH0wXFkxYluO4ML5+xIqSotv7SfLz4fHgL8g8sG24WKQ2Sw+G89vBHM7lzB+EKK3/48wfOSwssl/o29tf+qz+DMbS/ALCT1ZWfuubcIXZkg9xPW0kII+3x09RtMr6finIPHrIV3bx/vYLCUpG2+n8L+ogPrcQnwiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnfY5pRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC76EC4CEF7;
	Wed, 13 Aug 2025 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755086537;
	bh=2xrd0/GoUYp9e9PgBchb2nv0RPDgefUTlMhBngu3vas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dnfY5pRAIGrV1WNGoDYcWXmuVbKeJ+WGHuyKJSOYb0WR11KrcWMswcDa6njQ1BRXL
	 s7/bqbGvvZZRBV1zjeK2PNoR4QLlBDZpWjwMk2TSqqcxt05s82Hge6O51FtWov3Y0i
	 0pIabEjTiX0LpHmntrSA+leDJCveu03POPi2MdkewQIKlTV66P1ftiaNbfRstdbPz1
	 xlOnAwnBw6cy5PMhQryQAJiJ9vbEugKl1sCeF2QckqZRZ6JJF3GgNXvMbr7eP0yND8
	 9G5FstSlZHqd+f/eI6QaOVmB3tcLaRQwBCB1ikBMh5xdbz9ygUZoyZAnA8WulqYY3X
	 NGGCfKkcLxUng==
From: Pratyush Yadav <pratyush@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vipin Sharma <vipinsh@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  pratyush@kernel.org,  jasonmiu@google.com,
  graf@amazon.com,  changyuanl@google.com,  rppt@kernel.org,
  dmatlack@google.com,  rientjes@google.com,  corbet@lwn.net,
  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  tglx@linutronix.de,  mingo@redhat.com,
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
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <2025081310-custodian-ashamed-3104@gregkh>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250813063407.GA3182745.vipinsh@google.com>
	<2025081310-custodian-ashamed-3104@gregkh>
Date: Wed, 13 Aug 2025 14:02:07 +0200
Message-ID: <mafs01ppfxwe8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 13 2025, Greg KH wrote:

> On Tue, Aug 12, 2025 at 11:34:37PM -0700, Vipin Sharma wrote:
>> On 2025-08-07 01:44:35, Pasha Tatashin wrote:
>> > From: Pratyush Yadav <ptyadav@amazon.de>
>> > +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preserved_folio *pfolios,
>> > +					unsigned int nr_folios)
>> > +{
>> > +	unsigned int i;
>> > +
>> > +	for (i = 0; i < nr_folios; i++) {
>> > +		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
>> > +		struct folio *folio;
>> > +
>> > +		if (!pfolio->foliodesc)
>> > +			continue;
>> > +
>> > +		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
>> > +
>> > +		kho_unpreserve_folio(folio);
>> 
>> This one is missing WARN_ON_ONCE() similar to the one in
>> memfd_luo_preserve_folios().
>
> So you really want to cause a machine to reboot and get a CVE issued for
> this, if it could be triggered?  That's bold :)
>
> Please don't.  If that can happen, handle the issue and move on, don't
> crash boxes.

Why would a WARN() crash the machine? That is what BUG() does, not
WARN().

-- 
Regards,
Pratyush Yadav

