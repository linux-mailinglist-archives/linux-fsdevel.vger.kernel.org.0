Return-Path: <linux-fsdevel+bounces-57689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8CCB24983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAFF1A21CC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC871C1F0D;
	Wed, 13 Aug 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHwXqriF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE4A1B4F0A;
	Wed, 13 Aug 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088189; cv=none; b=OIf5C+oo+/Zw7U1InIDn8oVvJHkxjSOSsiYNy44pZWodCTpQUPLjd+DhYxkYaBnlX11CyctPRv1oDVkptrU5WYtDmFKi7G+843a8hdJzOQAsqIAS34NAyTDmjSvu7SX3doxbRIsa6zV2opbtixpdlQoWLwQjtx8wzwm372varYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088189; c=relaxed/simple;
	bh=XNCAicR2gx/LNWLP2/epE+0fq3acPUIP+umvFC2d4yY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hsN4y8CXdbO6UdBV8VDURb06Du47iQlmbv0TvsCMHluuStdd/7FE50zmOa6xetiIUODfDrvdp+TT8GZzWqnM8KgcubNwzBClRYM7zg7HzUGPNIK1tAfdvje+KL2DoKLEbKYQuIyn31bobkpvUawrPoPxXwtBejvBIVVJ9hsjFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHwXqriF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59BEC4CEEB;
	Wed, 13 Aug 2025 12:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755088189;
	bh=XNCAicR2gx/LNWLP2/epE+0fq3acPUIP+umvFC2d4yY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vHwXqriFkxQ7EiVrUgjSioUks8rwkx4eVjDpZCsbSHDq2agW54WOykwGWuSGyuRoe
	 1feSAHqd3zG2GbCkNRD0nXt6zR/peMPDryianeLxZFn3X+1JRT+lCZ9XMNiU8LZe7H
	 s55az31uVyk5DgZCcqhGog+4sszkPWKka4iv7Ybqd51f1SLf1e6hFUK5mPZc0jUgOC
	 6SELeW6WDEpQa5okr1Bd+5wY18v++0zo0FE4Kgh4yXn5Ch2e/Fe5s+G/atCm3fjFOE
	 paqiDNZuuvFPJftHGAbMCc0ygAnNpvaB+ac+v6hUaftfBpTPghFjxU1hRmcKtPANFP
	 pohjVQJiItyag==
From: Pratyush Yadav <pratyush@kernel.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  changyuanl@google.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
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
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <20250813063407.GA3182745.vipinsh@google.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250813063407.GA3182745.vipinsh@google.com>
Date: Wed, 13 Aug 2025 14:29:38 +0200
Message-ID: <mafs0wm77wgjx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Vipin,

Thanks for the review.

On Tue, Aug 12 2025, Vipin Sharma wrote:

> On 2025-08-07 01:44:35, Pasha Tatashin wrote:
>> From: Pratyush Yadav <ptyadav@amazon.de>
>> +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preserved_folio *pfolios,
>> +					unsigned int nr_folios)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < nr_folios; i++) {
>> +		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
>> +		struct folio *folio;
>> +
>> +		if (!pfolio->foliodesc)
>> +			continue;
>> +
>> +		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
>> +
>> +		kho_unpreserve_folio(folio);
>
> This one is missing WARN_ON_ONCE() similar to the one in
> memfd_luo_preserve_folios().

Right, will add.

>
>> +		unpin_folio(folio);

Looking at this code caught my eye. This can also be called from LUO's
finish callback if no one claimed the memfd after live update. In that
case, unpin_folio() is going to underflow the pincount or refcount on
the folio since after the kexec, the folio is no longer pinned. We
should only be doing folio_put().

I think this function should take a argument to specify which of these
cases it is dealing with.

>> +	}
>> +}
>> +
>> +static void *memfd_luo_create_fdt(unsigned long size)
>> +{
>> +	unsigned int order = get_order(size);
>> +	struct folio *fdt_folio;
>> +	int err = 0;
>> +	void *fdt;
>> +
>> +	if (order > MAX_PAGE_ORDER)
>> +		return NULL;
>> +
>> +	fdt_folio = folio_alloc(GFP_KERNEL, order);
>
> __GFP_ZERO should also be used here. Otherwise this can lead to
> unintentional passing of old kernel memory.

fdt_create() zeroes out the buffer so this should not be a problem.

>
>> +static int memfd_luo_prepare(struct liveupdate_file_handler *handler,
>> +			     struct file *file, u64 *data)
>> +{
>> +	struct memfd_luo_preserved_folio *preserved_folios;
>> +	struct inode *inode = file_inode(file);
>> +	unsigned int max_folios, nr_folios = 0;
>> +	int err = 0, preserved_size;
>> +	struct folio **folios;
>> +	long size, nr_pinned;
>> +	pgoff_t offset;
>> +	void *fdt;
>> +	u64 pos;
>> +
>> +	if (WARN_ON_ONCE(!shmem_file(file)))
>> +		return -EINVAL;
>
> This one is only check for shmem_file, whereas in
> memfd_luo_can_preserve() there is check for inode->i_nlink also. Is that
> not needed here?

Actually, this should never happen since the LUO can_preserve() callback
should make sure of this. I think it would be perfectly fine to just
drop this check. I only added it because I was being extra careful.

>
>> +
>> +	inode_lock(inode);
>> +	shmem_i_mapping_freeze(inode, true);
>> +
>> +	size = i_size_read(inode);
>> +	if ((PAGE_ALIGN(size) / PAGE_SIZE) > UINT_MAX) {
>> +		err = -E2BIG;
>> +		goto err_unlock;
>> +	}
>> +
>> +	/*
>> +	 * Guess the number of folios based on inode size. Real number might end
>> +	 * up being smaller if there are higher order folios.
>> +	 */
>> +	max_folios = PAGE_ALIGN(size) / PAGE_SIZE;
>> +	folios = kvmalloc_array(max_folios, sizeof(*folios), GFP_KERNEL);
>
> __GFP_ZERO?

Why? This is only used in this function and gets freed on return. And
the function only looks at the elements that get initialized by
memfd_pin_folios().

>
>> +static int memfd_luo_freeze(struct liveupdate_file_handler *handler,
>> +			    struct file *file, u64 *data)
>> +{
>> +	u64 pos = file->f_pos;
>> +	void *fdt;
>> +	int err;
>> +
>> +	if (WARN_ON_ONCE(!*data))
>> +		return -EINVAL;
>> +
>> +	fdt = phys_to_virt(*data);
>> +
>> +	/*
>> +	 * The pos or size might have changed since prepare. Everything else
>> +	 * stays the same.
>> +	 */
>> +	err = fdt_setprop(fdt, 0, "pos", &pos, sizeof(pos));
>> +	if (err)
>> +		return err;
>
> Comment is talking about pos and size but code is only updating pos. 

Right. Comment is out of date. size can no longer change since prepare.
So will update the comment.

>
>> +static int memfd_luo_retrieve(struct liveupdate_file_handler *handler, u64 data,
>> +			      struct file **file_p)
>> +{
>> +	const struct memfd_luo_preserved_folio *pfolios;
>> +	int nr_pfolios, len, ret = 0, i = 0;
>> +	struct address_space *mapping;
>> +	struct folio *folio, *fdt_folio;
>> +	const u64 *pos, *size;
>> +	struct inode *inode;
>> +	struct file *file;
>> +	const void *fdt;
>> +
>> +	fdt_folio = memfd_luo_get_fdt(data);
>> +	if (!fdt_folio)
>> +		return -ENOENT;
>> +
>> +	fdt = page_to_virt(folio_page(fdt_folio, 0));
>> +
>> +	pfolios = fdt_getprop(fdt, 0, "folios", &len);
>> +	if (!pfolios || len % sizeof(*pfolios)) {
>> +		pr_err("invalid 'folios' property\n");
>
> Print should clearly state that error is because fields is not found or
> len is not multiple of sizeof(*pfolios).

Eh, there is already too much boilerplate one has to write (and read)
for parsing the FDT. Is there really a need for an extra 3-4 lines of
code for _each_ property that is parsed?

Long term, I think we shouldn't be doing this manually anyway. I think
the maintainable path forward is to define a schema for the serialized
data and have a parser that takes in the schema and gives out a parsed
struct, doing all sorts of checks in the process.

-- 
Regards,
Pratyush Yadav

