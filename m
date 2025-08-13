Return-Path: <linux-fsdevel+bounces-57643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59563B241A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608DE3AAB72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3D2D322C;
	Wed, 13 Aug 2025 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dk6QpDs1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476732D2388
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066886; cv=none; b=OQZ7Nd4s7JB0iV+XnZT0TPdZgzq92A4yTyDwcT3c250A66MopDP7RPpdbyA6qDrWu7hVc1LNBvaOiiHJHFpsK/pRgqO5kyL+JpHB7L33MTKM0ShWzFlQQMJZeEku/V8R+oKmKC2rwMWFo0bc3DuAQQyzh2F96xn+drNCCogsVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066886; c=relaxed/simple;
	bh=QnD42qcFxdQmw5Rdxw3IWpBHxe/eMag57tc2qEN9NFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsZv4tjONh159QbYrz76UW9W47x+pKQWSrKipavpKqV4vTsX9UWC6+Z1Kma5vvW4uX/38W57RgBmfcOohHUlnrVxAjLQS1aiQ4xBL/j9G8p3IYwdu+sJSS2O60TxlWVrowzkCIXk+IF1Ht5fG74li7iI/+aSEYkIKLP+8l9PCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dk6QpDs1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-242d3be6484so77525ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755066884; x=1755671684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBz0ZD/446lYgybbXFehAqqU9nULcqKZHue50p4Cg4E=;
        b=Dk6QpDs1CjW6zIuIn5OUCmQAwpvcWVrdkrQIuT7qVN+HZFs99fBaDZGpmVnmDvlNPc
         oIaCBopqrzxKJHcudas9J2T3/QzTLbxDuocoXkat1nLAkyMFdvKjQwMgl36pU6zV5JBs
         Kz/wkYWlwyzKybFgGtDbuW7wyWQ0MdvZh6OU3j2R2JPHZXacE508BPL5NovYYQXgO8/I
         Iff6hGTzypwBzbNAt8l7n9K5kaH6G6uc9TGLKS8NrF6aYLywoaC7GFpRUjmOR3r/aPuM
         6sEsVGDFJmoQ2svBYu+WEsrO35PVdhIcPh0DL3Dpiasm/HgKepBkbGgWCO3xdJ5dGAXY
         WCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755066884; x=1755671684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBz0ZD/446lYgybbXFehAqqU9nULcqKZHue50p4Cg4E=;
        b=vBtDApBgQRQ9oVYV4OAQgwA9L/mMU/cq+bsTPNbHl0JTQxVeTNDsOe0KWvL6r6rx30
         hFA8q73lvDzVdvtG1hblAxiPZLTsfGOqaZfAT1p7FIi9fi8Wd3SrIAXHXXFp6MckEREQ
         5I//NUSd+IBKjo7JqUzAdXWGvLNOj0aZUEsZnZlFZJD/FwbCoTAGJ4z2ZyaOc/IsRZgK
         qPXg9Zztk9SijNZCxtELPw76ZEdTgTwzmsB5/S2MwL0wnQyocCTlifD6nUQyS4ik1KWY
         G1Bd/3+NqaBwmln+k1PlWnigYAYbipFGj7nwHFzr9TXJKxO6Kp5eJl7THpc/XRMJ+rRo
         fHRA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1ZqyThbmb7g64eOKsxiiECccOa7qGjgv4/DTTfIZMnIvzx0cmDLA+poflkvn4IX0JlivMjrxChPljkCD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4kaqPJwjgaEvbfHb2v8PgUHp1CnKIhoBO844bVMc+y3bDPBC
	TI4QtSjliVkT72MsZtyjQP4Hqz5MgVLxIX+x/6NJ4YgCsnE6A0hXpV8euwF7ORheVA==
X-Gm-Gg: ASbGncvgdGiQ6pic1jyNrj8NRS3o2usx3g/ZFVn5UBq5Qla20Mu28o/M9W/EQZTGDWo
	GxFIH8fqif7EJCXGDPvh1W/VlvGfn2lqc5RR2AUsX4gTP2WW+Kf4Hf6DkJSSdQ0g1OpXKs6HQQn
	q/wZeWSOKH+DmQxB7RRuNrlGcQpIjCEgsykKqa/dBSkPTOMrzPLxrocmilRpVlGnxHXV3OtnwHA
	MsQHh76CPqhDLzPodzgGu5s1k0Nqi2QZShedU0Rc1HNXBUEzokDzyfKAaPRQcwKivLvU1PfUCXk
	zfXe9tCM39rOQbjyTfMANdqI0HmhPXARFo5wLGn8tXfHGnmmsE0Y86m9cVdzgn+ujAzrnhFWUVJ
	V5JM+/5lxNPDJ1fXs1JS6PpYKixDLGYLYZrNydxjr0brkPbmIpIRo8WgDBpjtpblswXg=
X-Google-Smtp-Source: AGHT+IGFb0xX7B2Q6MyY6rFw3BXv1hxo5YhlKW11olCnEO5GfmzQ9WNDztxD1sYVpPXUsxAdW3d/ig==
X-Received: by 2002:a17:902:e746:b0:240:6076:20cd with SMTP id d9443c01a7336-2430e55bb17mr2238135ad.15.1755066883155;
        Tue, 12 Aug 2025 23:34:43 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24303d5e705sm30477375ad.14.2025.08.12.23.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:34:42 -0700 (PDT)
Date: Tue, 12 Aug 2025 23:34:37 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <20250813063407.GA3182745.vipinsh@google.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-30-pasha.tatashin@soleen.com>

On 2025-08-07 01:44:35, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preserved_folio *pfolios,
> +					unsigned int nr_folios)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_folios; i++) {
> +		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
> +		struct folio *folio;
> +
> +		if (!pfolio->foliodesc)
> +			continue;
> +
> +		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
> +
> +		kho_unpreserve_folio(folio);

This one is missing WARN_ON_ONCE() similar to the one in
memfd_luo_preserve_folios().

> +		unpin_folio(folio);
> +	}
> +}
> +
> +static void *memfd_luo_create_fdt(unsigned long size)
> +{
> +	unsigned int order = get_order(size);
> +	struct folio *fdt_folio;
> +	int err = 0;
> +	void *fdt;
> +
> +	if (order > MAX_PAGE_ORDER)
> +		return NULL;
> +
> +	fdt_folio = folio_alloc(GFP_KERNEL, order);

__GFP_ZERO should also be used here. Otherwise this can lead to
unintentional passing of old kernel memory.

> +static int memfd_luo_prepare(struct liveupdate_file_handler *handler,
> +			     struct file *file, u64 *data)
> +{
> +	struct memfd_luo_preserved_folio *preserved_folios;
> +	struct inode *inode = file_inode(file);
> +	unsigned int max_folios, nr_folios = 0;
> +	int err = 0, preserved_size;
> +	struct folio **folios;
> +	long size, nr_pinned;
> +	pgoff_t offset;
> +	void *fdt;
> +	u64 pos;
> +
> +	if (WARN_ON_ONCE(!shmem_file(file)))
> +		return -EINVAL;

This one is only check for shmem_file, whereas in
memfd_luo_can_preserve() there is check for inode->i_nlink also. Is that
not needed here?

> +
> +	inode_lock(inode);
> +	shmem_i_mapping_freeze(inode, true);
> +
> +	size = i_size_read(inode);
> +	if ((PAGE_ALIGN(size) / PAGE_SIZE) > UINT_MAX) {
> +		err = -E2BIG;
> +		goto err_unlock;
> +	}
> +
> +	/*
> +	 * Guess the number of folios based on inode size. Real number might end
> +	 * up being smaller if there are higher order folios.
> +	 */
> +	max_folios = PAGE_ALIGN(size) / PAGE_SIZE;
> +	folios = kvmalloc_array(max_folios, sizeof(*folios), GFP_KERNEL);

__GFP_ZERO?

> +static int memfd_luo_freeze(struct liveupdate_file_handler *handler,
> +			    struct file *file, u64 *data)
> +{
> +	u64 pos = file->f_pos;
> +	void *fdt;
> +	int err;
> +
> +	if (WARN_ON_ONCE(!*data))
> +		return -EINVAL;
> +
> +	fdt = phys_to_virt(*data);
> +
> +	/*
> +	 * The pos or size might have changed since prepare. Everything else
> +	 * stays the same.
> +	 */
> +	err = fdt_setprop(fdt, 0, "pos", &pos, sizeof(pos));
> +	if (err)
> +		return err;

Comment is talking about pos and size but code is only updating pos. 

> +static int memfd_luo_retrieve(struct liveupdate_file_handler *handler, u64 data,
> +			      struct file **file_p)
> +{
> +	const struct memfd_luo_preserved_folio *pfolios;
> +	int nr_pfolios, len, ret = 0, i = 0;
> +	struct address_space *mapping;
> +	struct folio *folio, *fdt_folio;
> +	const u64 *pos, *size;
> +	struct inode *inode;
> +	struct file *file;
> +	const void *fdt;
> +
> +	fdt_folio = memfd_luo_get_fdt(data);
> +	if (!fdt_folio)
> +		return -ENOENT;
> +
> +	fdt = page_to_virt(folio_page(fdt_folio, 0));
> +
> +	pfolios = fdt_getprop(fdt, 0, "folios", &len);
> +	if (!pfolios || len % sizeof(*pfolios)) {
> +		pr_err("invalid 'folios' property\n");

Print should clearly state that error is because fields is not found or
len is not multiple of sizeof(*pfolios).


