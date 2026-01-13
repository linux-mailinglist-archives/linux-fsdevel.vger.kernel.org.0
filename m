Return-Path: <linux-fsdevel+bounces-73434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE8D19533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13F1D3015AD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813DF392B78;
	Tue, 13 Jan 2026 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PGI8b+UB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408418B0A;
	Tue, 13 Jan 2026 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313399; cv=none; b=cbClQ0W/GtJLp5W+SNu6L4YN/TzPvnZxP+O0isNXodU+fZBCrRfXfPCemVEDVpobXLdpZUX0Wngh1320/hzZaB2DrNnMvI0F9hg8qQsDuNkCjf+c0WCw+tgKfQ5ga2hx25SOkHjp3Ezraqm1Q5TWZCJs6x/zQetGGl5tgADAEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313399; c=relaxed/simple;
	bh=XVnPgoMT6BpLWpzpYcNaQb2TTRsjkCf5sw503RN2/1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFUHscrkwK6cohN4pr+VfCxX1BKGaAvcbXg9BNNDvMQrDaYrQ/21n8CetzlYP+q6ZP1VuuNufQtMPnP0NX6U+Yz7mFodKqffF98TSIJYBTswdnWT17LP+nDvH1dmqQz3WtA3bDm0+c8r9gCu0djljo/KY/8u5vyKRiz9aIVpK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PGI8b+UB; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60DCArKX1832210;
	Tue, 13 Jan 2026 06:09:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=JAuKhkCrAHpF94tqXXlAdNjuzgLDHJZz0Y/lLs95e8g=; b=PGI8b+UBtizs
	1dhAPX0qbs4Uc6SNgynZq370y0kqx20f/msyHogB0OatdczXL1xCX6zkdfpl4okV
	X0WhWjrwNaBXNc0mahO6rChgXtLS5sbatRPTTJWaxcByREJvDEi52Cv+x7ajDH50
	/EAowJ7XGdKMoIo3s1mbR125/xh+dPfuhw5ZevoY4CUGCcQ3rPsGJAgaInMEKj9F
	kwNfLF1nsyJfR2FS4l/BPo6u0mfU487v7iGjb3fXh+O+i5YunXMKOXL7RNMsftPn
	5stTVV/lb0MsX8J+XRCZIYzUycOyA0HeWvQxHnWZN355vCCf7qtqlteND00a63OC
	ZUEevcKp2g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4bnagnd7qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Jan 2026 06:09:44 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 13 Jan 2026 14:09:40 +0000
From: Chris Mason <clm@meta.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
CC: Chris Mason <clm@meta.com>, <jasonmiu@google.com>, <graf@amazon.com>,
        <rppt@kernel.org>, <dmatlack@google.com>, <rientjes@google.com>,
        <corbet@lwn.net>, <rdunlap@infradead.org>,
        <ilpo.jarvinen@linux.intel.com>, <kanie@linux.alibaba.com>,
        <ojeda@kernel.org>, <aliceryhl@google.com>, <masahiroy@kernel.org>,
        <akpm@linux-foundation.org>, <tj@kernel.org>, <yoann.congal@smile.fr>,
        <mmaurer@google.com>, <roman.gushchin@linux.dev>,
        <chenridong@huawei.com>, <axboe@kernel.dk>, <mark.rutland@arm.com>,
        <jannh@google.com>, <vincent.guittot@linaro.org>, <hannes@cmpxchg.org>,
        <dan.j.williams@intel.com>, <david@redhat.com>,
        <joel.granados@kernel.org>, <rostedt@goodmis.org>,
        <anna.schumaker@oracle.com>, <song@kernel.org>, <linux@weissschuh.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-mm@kvack.org>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rafael@kernel.org>, <dakr@kernel.org>,
        <bartosz.golaszewski@linaro.org>, <cw00.choi@samsung.com>,
        <myungjoo.ham@samsung.com>, <yesanishhere@gmail.com>,
        <Jonathan.Cameron@huawei.com>, <quic_zijuhu@quicinc.com>,
        <aleksander.lobakin@intel.com>, <ira.weiny@intel.com>,
        <andriy.shevchenko@linux.intel.com>, <leon@kernel.org>,
        <lukas@wunner.de>, <bhelgaas@google.com>, <wagi@kernel.org>,
        <djeffery@redhat.com>, <stuart.w.hayes@gmail.com>, <ptyadav@amazon.de>,
        <lennart@poettering.net>, <brauner@kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <saeedm@nvidia.com>, <ajayachandra@nvidia.com>, <jgg@nvidia.com>,
        <parav@nvidia.com>, <leonro@nvidia.com>, <witu@nvidia.com>,
        <hughd@google.com>, <skhawaja@google.com>, <chrisl@kernel.org>
Subject: Re: [PATCH v8 14/18] mm: memfd_luo: allow preserving memfd
Date: Tue, 13 Jan 2026 06:09:23 -0800
Message-ID: <20260113140927.1074142-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125165850.3389713-15-pasha.tatashin@soleen.com>
References:
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: s1CCR8UZO73_rjnu6xSP054ZxjCtViBV
X-Proofpoint-ORIG-GUID: s1CCR8UZO73_rjnu6xSP054ZxjCtViBV
X-Authority-Analysis: v=2.4 cv=Q7LfIo2a c=1 sm=1 tr=0 ts=69665228 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7ipKWUHlAAAA:8
 a=m6o-FXAq6gqIrf99m5QA:9 a=gpc5p9EgBqZVLdJeV_V1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExOSBTYWx0ZWRfX5CNvvrAwyW4k
 6EJSeAG0c5Q8z/80YV/NCKjAgvqtiRw50RPHu1phI8kbtyoXdGOgv54X5julOdiLcAEzOg5KQS6
 RvxQd20x9ZD0l2C/HYop8b4WFgcvXUck2DzwvWD/phFzvC9L9eNVrPP0q4WNMy9z8xEisOuJ+kN
 hxtk0eQG7jhUVSm/31U9ZAYzwxclEpfPSwCpn5D0v9ehyVT4vTsy95GsohsdPZ17v0emPCFN9td
 TJopv5yHAcfD8mF5H9fn1sHqTOse9mbVi+41BVtWkoV4Wuh/PmVG0gCfi3hkfgrApCvH3lQph6y
 BPD81K3pD1tMd8f+PJrOFBsCCnQ76RtFjQ0tKs5YdGY9YFL0RwiF90/2JAocm6dRdIh6/wR6y/m
 J3MEQTMiRubinot5H/QcGHq0e5VbLOhUxmj04I28+SQr9rkNx5twsKT2dPvA3M5cz6zJj9bDn09
 pAo2hmSM3zMQdfaQwmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01

On Tue, 25 Nov 2025 11:58:44 -0500 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

Hi everyone,

I'm running the v6.19 mm commits through patch review automation, and this
commit was flagged.  I don't know this code well, but it looks like it
might be a real bug.

[AI review output below]

> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> new file mode 100644
> index 0000000000000..4f6ba63b43105
> --- /dev/null
> +++ b/mm/memfd_luo.c

[ ... ]

> +static int memfd_luo_retrieve_folios(struct file *file,
> +				     struct memfd_luo_folio_ser *folios_ser,
> +				     u64 nr_folios)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct address_space *mapping = inode->i_mapping;
> +	struct folio *folio;
> +	int err = -EIO;
> +	long i;
> +
> +	for (i = 0; i < nr_folios; i++) {

[ ... ]

> +		err = shmem_add_to_page_cache(folio, mapping, index, NULL,
> +					      mapping_gfp_mask(mapping));
> +		if (err) {
> +			pr_err("shmem: failed to add to page cache folio index %ld: %d\n",
> +			       i, err);
> +			goto unlock_folio;
> +		}
> +
> +		if (flags & MEMFD_LUO_FOLIO_UPTODATE)
> +			folio_mark_uptodate(folio);
> +		if (flags & MEMFD_LUO_FOLIO_DIRTY)
> +			folio_mark_dirty(folio);
> +
> +		err = shmem_inode_acct_blocks(inode, 1);
> +		if (err) {
> +			pr_err("shmem: failed to account folio index %ld: %d\n",
> +			       i, err);
> +			goto unlock_folio;
> +		}

When shmem_inode_acct_blocks() fails here, the folio has already been
added to the page cache by shmem_add_to_page_cache(). Should the folio be
removed from the page cache before going to unlock_folio?

Looking at shmem_alloc_and_add_folio() in mm/shmem.c, when
shmem_inode_acct_blocks() fails after the folio has been added, it calls
filemap_remove_folio() to remove it:

    error = shmem_inode_acct_blocks(inode, pages);
    if (error) {
        ...
        if (error) {
            filemap_remove_folio(folio);
            goto unlock;
        }
    }

Without this, the folio remains in the page cache (counted in
mapping->nrpages) but info->alloced is not incremented (since
shmem_recalc_inode is not called). This could cause shmem accounting
inconsistency.



