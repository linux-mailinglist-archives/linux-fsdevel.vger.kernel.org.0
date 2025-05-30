Return-Path: <linux-fsdevel+bounces-50244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A3AC969C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 22:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FE21BC377C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 20:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9F928315A;
	Fri, 30 May 2025 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsXM6Uh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C715990C
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748637176; cv=none; b=UpsMogOQlhjN63SuzdvVxBcbrlU7gSusqBvaVE9AUYZal4LV78F6793h7PSx2LJGXUA6Z0EU2cb5cemnlpqZa89+RnRXLnzwikWsyhsGRsdDF4eAx+4F9UCLl5a0pCJcfPN9DdZAEPAk2OD3FMHQDARPXvcr+uvc0KR20H6/Dk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748637176; c=relaxed/simple;
	bh=BqxGAPtXQ+w0it+7VSaKvqRRRpiyppxfHM2MLYqFpmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eR59Qt8xGZhP3U10eix/VLE3kwQyXTFpuDy35khM+iMF27ndpD4biLAFhLGfAt4kQm0X2XfSBibawtVVBd1XkEJdDM/JDznp+ezjbNFqeNMW2Z2YL+7RDEurtLLDwb9Oouq2/PmxpXL7ZCIbAWrbPPwRhAkmGlgtUws4KSgWjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsXM6Uh0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7398d70abbfso3332222b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748637173; x=1749241973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBxCAqZvCNUWY+LzVlwT/+p8q3HcBUeDP2q6ZT5VtpU=;
        b=KsXM6Uh0oKAVYrDuQw7/q9KHm2vCoay/3/BG4dcXP6qY87gcf5v/rkVFGgUHqy+NlB
         Ih1/lGI2PcNVYFqn2wAFoTAAphqT261RNJm1MedMsqpBhEj22WuNZR5F2bWkb84IeCY4
         9zEesHUmUbn7sDery1B25e8+Ync9rtuFFZrtD0DGvtIAtCQb46h8oJsR+dvUuXRkKmGv
         uWe781DCkfBQcHzvbEF/vmcsfUQi7txOIJ8QTeAbrwZiuEhu2WWqtuQ+zg592jcZja7t
         JvVHcaOjhX7NQFtyD1m18OzEYXTFmL1dQRSwdSrCHDRJEFi9rUnjI3iUdbOpVVIguGv8
         nLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748637173; x=1749241973;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TBxCAqZvCNUWY+LzVlwT/+p8q3HcBUeDP2q6ZT5VtpU=;
        b=iPr5QKaMhbkMxUHKuvtQ5NR9TrWdQqJ90IXbGQIVskF90IvzHEqDpb02tsJ/Cuxrk2
         AprZRclav0PXZNG9r4RWFU7Qn2yMDt2ZqSlnu1nCBk+yvpwaqFaqtSFuAuzkbyfBLoDE
         Zij1KlSHDhNwvmUP8H0mXorEnK42p2U/jV+FPwoyg8kb29BXqx4k53Ict+Frefli9/T5
         +9EkTSkR/p5yaE8ZSjTGpz5GVOp7qzs+aJsFOtql37FHqPo6Gio/NPnevb8wj/umVf9q
         yrYczaWOAa7xNQIimlJQ99KwqlxbmFBT8AMzwnexQr8Jll3qDifKF4V1iNX7AwFLRavX
         e8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVt0jX2nTAReREoxxHsRzDGraegImLvipGCUNauq6xNTfU8QqHnAKcNoISV1tXSBjcfuGgZ65ne6khwcx9Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ue4F8suZCMsKT20OomzmwLTrwH9HkvUZyT105v266/3rRA7G
	HHRIdLMMWLL46/2zJJ4AzzySY31eQd4BS7ilOWFgqyaap6aRbGGC0bIYwDyYzdg+5mHbTM+532K
	wci/J66N1MVo56zPWyk0lX7dLgw==
X-Google-Smtp-Source: AGHT+IHn8Apyh2qJk1ZiWPwI4Xf5KbG4kHs1lrIxOZPs3doTW55CGpIuzttZTAM9OFdmVmjXkdwqHEOcQmlogkipOw==
X-Received: from pfcg2.prod.google.com ([2002:a05:6a00:23c2:b0:746:1931:952a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d4e:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-747bd9e6de8mr6429258b3a.18.1748637173027;
 Fri, 30 May 2025 13:32:53 -0700 (PDT)
Date: Fri, 30 May 2025 13:32:51 -0700
In-Reply-To: <21b9b151-6e4f-47b8-9c6b-73eeb0c20165@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <37f60bbd7d408cf6d421d0582462488262c720ab.1747264138.git.ackerleytng@google.com>
 <21b9b151-6e4f-47b8-9c6b-73eeb0c20165@linux.intel.com>
Message-ID: <diqzplfp6dqk.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 05/51] KVM: guest_memfd: Skip LRU for guest_memfd folios
From: Ackerley Tng <ackerleytng@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 5/15/2025 7:41 AM, Ackerley Tng wrote:
>> filemap_add_folio(), called from filemap_grab_folio(), adds the folio
>> onto some LRU list, which is not necessary for guest_memfd since
>> guest_memfd folios don't participate in any swapping.
>>
>> This patch reimplements part of filemap_add_folio() to avoid adding
>> allocated guest_memfd folios to the filemap.
>
> filemap -> LRU list?
>

Yes, thank you. Will fix this in the next revision.

>>
>> With shared to private conversions dependent on refcounts, avoiding
>> usage of LRU ensures that LRU lists no longer take any refcounts on
>> guest_memfd folios and significantly reduces the chance of elevated
>> refcounts during conversion.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Change-Id: Ia2540d9fc132d46219e6e714fd42bc82a62a27fa
>> ---
>>   mm/filemap.c           |  1 +
>>   mm/memcontrol.c        |  2 +
>>   virt/kvm/guest_memfd.c | 91 ++++++++++++++++++++++++++++++++++++++----
>>   3 files changed, 86 insertions(+), 8 deletions(-)
>>
> [...]
>>   /*
>>    * Returns a locked folio on success.  The caller is responsible for
>>    * setting the up-to-date flag before the memory is mapped into the gu=
est.
>> @@ -477,8 +509,46 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, =
struct kvm_memory_slot *slot,
>>    */
>>   static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t i=
ndex)
>>   {
>> +	struct folio *folio;
>> +	gfp_t gfp;
>> +	int ret;
>> +
>> +repeat:
>> +	folio =3D filemap_lock_folio(inode->i_mapping, index);
>> +	if (!IS_ERR(folio))
>> +		return folio;
>> +
>> +	gfp =3D mapping_gfp_mask(inode->i_mapping);
>> +
>>   	/* TODO: Support huge pages. */
>> -	return filemap_grab_folio(inode->i_mapping, index);
>> +	folio =3D filemap_alloc_folio(gfp, 0);
>> +	if (!folio)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret =3D mem_cgroup_charge(folio, NULL, gfp);
>> +	if (ret) {
>> +		folio_put(folio);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	ret =3D kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index);
>> +	if (ret) {
>> +		folio_put(folio);
>> +
>> +		/*
>> +		 * There was a race, two threads tried to get a folio indexing
>> +		 * to the same location in the filemap. The losing thread should
>> +		 * free the allocated folio, then lock the folio added to the
>> +		 * filemap by the winning thread.
>
> How about changing
> =E2=80=9Cthen lock the folio added to the filemap by the winning thread=
=E2=80=9D
> to
> "the winning thread locks the folio added to the filemap"?
>

How about:

There was a race. Threads tried to get a folio indexing to the same
location in the filemap. The winning thread allocated and locked the
folio at the requested index. The losing threads should free the extra
allocated folio, then wait to lock the same folio allocated (and locked)
by the winning thread.

>> +		 */
>> +		if (ret =3D=3D -EEXIST)
>> +			goto repeat;
>> +
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	__folio_set_locked(folio);
>> +	return folio;
>>   }
>>  =20
>>   static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t s=
tart,
>> @@ -956,23 +1026,28 @@ static int kvm_gmem_error_folio(struct address_sp=
ace *mapping, struct folio *fol
>>   }
>>  =20
>>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>> +static void kvm_gmem_invalidate(struct folio *folio)
>> +{
>> +	kvm_pfn_t pfn =3D folio_pfn(folio);
>> +
>> +	kvm_arch_gmem_invalidate(pfn, pfn + folio_nr_pages(folio));
>> +}
>> +#else
>> +static inline void kvm_gmem_invalidate(struct folio *folio) {}
>
> No need to tag a local static function with "inline".
>

Will fix in the next revision.

>> +#endif
>> +
> [...]

