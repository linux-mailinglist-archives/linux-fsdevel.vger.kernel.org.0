Return-Path: <linux-fsdevel+bounces-35558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588E29D5DB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14C6B25205
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70931DF258;
	Fri, 22 Nov 2024 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htXriobr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA41DE3C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273402; cv=none; b=V5uZVILo0n2qTQ/NSpRe6ajxCc6Fjk4rSuDHaDP6fVgBWGk0U3EcOqEZ26iRf4cI5NbyW84ZLcI+MFV6S7iM9Obet5gBx8CvwuMeAXozJe2v2gYLWCBRkdCkkMF7CyAdpkfQxgxRnczXyzoQfIig99okPRxYXoGhvIXxYAlgV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273402; c=relaxed/simple;
	bh=NNT2sdRz8gOTo1HjKqBbwsGakTUcvB+cnj7LflAFjQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPRLJ8VPKd+lz4ktH8tuUspJZcXQ90J/LGqQ+l4hUMoacWqf0YgzffOXLOcQfQcuwIj14Kmn/qewbmkhywusWAhbqB8bQfWICHWSkwFu8qlO+6W7o+rLO7S6YQII8S8+pVCuu5m7aDp4ZyFcq15B7Z6jpHMPJDUtqwO1wYTvr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htXriobr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732273399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bESni2/f8mwItX/tTYi25M4TXlCQoc1gL7vsjpaYqxo=;
	b=htXriobrv2v2o+wqoruwbM2sphOD0VSjwCFtWV1JSbA1vlxeNZNJgxQ43Z65KbyjPVuous
	WJum7ttZJsfhH6Oidl7ZBrWWtfQpWK+YNfJhMhu1nMlL2zwPYsu2MwHolHt50GOrWEMm8R
	ue1GuhqIFzagyVVdNI5e3gNTN4GOaQs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-DqNWa_apPKSz2uuVMPOSWQ-1; Fri, 22 Nov 2024 06:03:17 -0500
X-MC-Unique: DqNWa_apPKSz2uuVMPOSWQ-1
X-Mimecast-MFC-AGG-ID: DqNWa_apPKSz2uuVMPOSWQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315afcae6cso11280855e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 03:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732273396; x=1732878196;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bESni2/f8mwItX/tTYi25M4TXlCQoc1gL7vsjpaYqxo=;
        b=I5H4yX9k8lwBiZ3pQslwdvTnEj2gH/f2A3qT6BsGRJSl8z8n4xC3YHBvWyAQZUBHol
         ZmYW3pZRu3KWpoK14PgnjGjqKPrunMvYp17LISoOEf41CJa31XrRvcJGBI1QJEvylEz9
         wWbGxQtYRbMK1c4b9inPfMv64eM+TYWnpCYzj4f4Iis60Ze89T6RnJAy/BfuSoQf3lTW
         pTsITyBMF9oUIAYDJ7v9VDdaW8Fc8MnHHRW5QfLYT0i58VNjNMQgLeW2BsSG9QgMwhl3
         XByLDlJfRt7RP0HihwY30Gdt1wA8VAGXCB3fQrROmE7k0r8BBB+nmCvP/9spo48hp+mR
         0RkA==
X-Forwarded-Encrypted: i=1; AJvYcCU5aeffOkF3C8rP5MAq/0vLVRJi3JqMZgDA7Ib0PlvcqvjnaIYr0AMjxVo8Jjm0PoNxqLZLIJ3CodWCE0/8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs18xaD6H5Atpz5UcOrBVknrARZIHcgSULBEKfITy5LEQ4+pBh
	6n4aZsEf/tTd5MwD5uPjz6Fb3mOm24m/1W+Cg7ya0PvaZHX93+s2Uff65/koaECCDiPUQy3Q3eV
	aRsA0fsDM+tw4T6KAmAsL5uVT+NtYrLSrQXBueJV1lkGlJNPem77Y930g/SLAsqI=
X-Gm-Gg: ASbGncuW8ThgV9c9kvqaBDNx67rHiHDUCQeog2oIwUaqcjwUAUWVOTr4jsU1f8I3sMs
	9qwwSPsQo54l7DUhw5LE2QmLf4jIFqypLy6ucD4O5JBy82/5/sKiE2Bp91AZF02E4JUpehUrJPr
	3VuJo711c2XmKcGH8muMvoQbLWR/3lsrrKbplmjQUlWboNwsC5Avf9kJZFFCQmKul7SvQL0MqE3
	3Mq4Fpe+GzU4cQn1j/w12aiXuLaBlXQmfGhR7Q9+AY43R5ozk8s9Jgpok+7aCRCh2mjOowkRmW+
	3VERz3GFFhCHGDMHvo8ZHzLv/t3jiZ21d1bF+H/+06nvecJSq3VmQeu1rKvPBzWw1Q/jvXo6VQk
	=
X-Received: by 2002:a05:600c:1e1e:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-433cdb0b504mr21328235e9.8.1732273396614;
        Fri, 22 Nov 2024 03:03:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFJxr7crO4glajQJEDgTAZNjVb8uk7YiyJcg7aXRoJivCkE6u6AnPY5u3vjqLC7qU4+MK8iA==
X-Received: by 2002:a05:600c:1e1e:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-433cdb0b504mr21327795e9.8.1732273396194;
        Fri, 22 Nov 2024 03:03:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde114d5sm23620125e9.17.2024.11.22.03.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 03:03:15 -0800 (PST)
Message-ID: <0903abca-42f5-4ca7-8c81-070e7669f996@redhat.com>
Date: Fri, 22 Nov 2024 12:03:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mm: guestmem: Convert address_space operations to
 guestmem library
To: michael.day@amd.com, Elliot Berman <quic_eberman@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Mike Rapoport <rppt@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: James Gowans <jgowans@amazon.com>, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org,
 devel@lists.orangefs.org, linux-arm-kernel@lists.infradead.org
References: <20241120-guestmem-library-v4-0-0c597f733909@quicinc.com>
 <20241120-guestmem-library-v4-2-0c597f733909@quicinc.com>
 <20241120145527130-0800.eberman@hu-eberman-lv.qualcomm.com>
 <3349f838-2c73-4ef0-aa30-a21e41fb39e5@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3349f838-2c73-4ef0-aa30-a21e41fb39e5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.11.24 18:40, Mike Day wrote:
> 
> 
> On 11/21/24 10:43, Elliot Berman wrote:
>> On Wed, Nov 20, 2024 at 10:12:08AM -0800, Elliot Berman wrote:
>>> diff --git a/mm/guestmem.c b/mm/guestmem.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..19dd7e5d498f07577ec5cec5b52055f7435980f4
>>> --- /dev/null
>>> +++ b/mm/guestmem.c
>>> @@ -0,0 +1,196 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * guestmem library
>>> + *
>>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <linux/fs.h>
>>> +#include <linux/guestmem.h>
>>> +#include <linux/mm.h>
>>> +#include <linux/pagemap.h>
>>> +
>>> +struct guestmem {
>>> +	const struct guestmem_ops *ops;
>>> +};
>>> +
>>> +static inline struct guestmem *folio_to_guestmem(struct folio *folio)
>>> +{
>>> +	struct address_space *mapping = folio->mapping;
>>> +
>>> +	return mapping->i_private_data;
>>> +}
>>> +
>>> +static inline bool __guestmem_release_folio(struct address_space *mapping,
>>> +					    struct folio *folio)
>>> +{
>>> +	struct guestmem *gmem = mapping->i_private_data;
>>> +	struct list_head *entry;
>>> +
>>> +	if (gmem->ops->release_folio) {
>>> +		list_for_each(entry, &mapping->i_private_list) {
>>> +			if (!gmem->ops->release_folio(entry, folio))
>>> +				return false;
>>> +		}
>>> +	}
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +static inline int
>>> +__guestmem_invalidate_begin(struct address_space *const mapping, pgoff_t start,
>>> +			    pgoff_t end)
>>> +{
>>> +	struct guestmem *gmem = mapping->i_private_data;
>>> +	struct list_head *entry;
>>> +	int ret = 0;
>>> +
>>> +	list_for_each(entry, &mapping->i_private_list) {
>>> +		ret = gmem->ops->invalidate_begin(entry, start, end);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static inline void
>>> +__guestmem_invalidate_end(struct address_space *const mapping, pgoff_t start,
>>> +			  pgoff_t end)
>>> +{
>>> +	struct guestmem *gmem = mapping->i_private_data;
>>> +	struct list_head *entry;
>>> +
>>> +	if (gmem->ops->invalidate_end) {
>>> +		list_for_each(entry, &mapping->i_private_list)
>>> +			gmem->ops->invalidate_end(entry, start, end);
>>> +	}
>>> +}
>>> +
>>> +static void guestmem_free_folio(struct address_space *mapping,
>>> +				struct folio *folio)
>>> +{
>>> +	WARN_ON_ONCE(!__guestmem_release_folio(mapping, folio));
>>> +}
>>> +
>>> +static int guestmem_error_folio(struct address_space *mapping,
>>> +				struct folio *folio)
>>> +{
>>> +	pgoff_t start, end;
>>> +	int ret;
>>> +
>>> +	filemap_invalidate_lock_shared(mapping);
>>> +
>>> +	start = folio->index;
>>> +	end = start + folio_nr_pages(folio);
>>> +
>>> +	ret = __guestmem_invalidate_begin(mapping, start, end);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	/*
>>> +	 * Do not truncate the range, what action is taken in response to the
>>> +	 * error is userspace's decision (assuming the architecture supports
>>> +	 * gracefully handling memory errors).  If/when the guest attempts to
>>> +	 * access a poisoned page, kvm_gmem_get_pfn() will return -EHWPOISON,
>>> +	 * at which point KVM can either terminate the VM or propagate the
>>> +	 * error to userspace.
>>> +	 */
>>> +
>>> +	__guestmem_invalidate_end(mapping, start, end);
>>> +
>>> +out:
>>> +	filemap_invalidate_unlock_shared(mapping);
>>> +	return ret ? MF_DELAYED : MF_FAILED;
>>> +}
>>> +
>>> +static int guestmem_migrate_folio(struct address_space *mapping,
>>> +				  struct folio *dst, struct folio *src,
>>> +				  enum migrate_mode mode)
>>> +{
>>> +	WARN_ON_ONCE(1);
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static const struct address_space_operations guestmem_aops = {
>>> +	.dirty_folio = noop_dirty_folio,
>>> +	.free_folio = guestmem_free_folio,
>>> +	.error_remove_folio = guestmem_error_folio,
>>> +	.migrate_folio = guestmem_migrate_folio,
>>> +};
>>> +
>>> +int guestmem_attach_mapping(struct address_space *mapping,
>>> +			    const struct guestmem_ops *const ops,
>>> +			    struct list_head *data)
>>> +{
>>> +	struct guestmem *gmem;
>>> +
>>> +	if (mapping->a_ops == &guestmem_aops) {
>>> +		gmem = mapping->i_private_data;
>>> +		if (gmem->ops != ops)
>>> +			return -EINVAL;
>>> +
>>> +		goto add;
>>> +	}
>>> +
>>> +	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
>>> +	if (!gmem)
>>> +		return -ENOMEM;
>>> +
>>> +	gmem->ops = ops;
>>> +
>>> +	mapping->a_ops = &guestmem_aops;
>>> +	mapping->i_private_data = gmem;
>>> +
>>> +	mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
>>> +	mapping_set_inaccessible(mapping);
>>> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
>>> +	WARN_ON_ONCE(!mapping_unevictable(mapping));
>>> +
>>> +add:
>>> +	list_add(data, &mapping->i_private_list);
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(guestmem_attach_mapping);
>>> +
>>> +void guestmem_detach_mapping(struct address_space *mapping,
>>> +			     struct list_head *data)
>>> +{
>>> +	list_del(data);
>>> +
>>> +	if (list_empty(&mapping->i_private_list)) {
>>> +		kfree(mapping->i_private_data);
>>
>> Mike was helping me test this out for SEV-SNP. They helped find a bug
>> here. Right now, when the file closes, KVM calls
>> guestmem_detach_mapping() which will uninstall the ops. When that
>> happens, it's not necessary that all of the folios aren't removed from
>> the filemap yet

Yes, that's the real issue. There either must be some lifetime tracking 
(kfree() after the mapping is completely unused), or you have to tear it 
all down before you mess with the mapping.

>>
>> There are a few approaches I could take:
>>
>> 1. Create a guestmem superblock so I can register guestmem-specific
>>      destroy_inode() to do the kfree() above. This requires a lot of
>>      boilerplate code, and I think it's not preferred approach.
>> 2. Update how KVM tracks the memory so it is back in "shared" state when
>>      the file closes. This requires some significant rework about the page
>>      state compared to current guest_memfd. That rework might be useful
>>      for the shared/private state machine.
>> 3. Call truncate_inode_pages(mapping, 0) to force pages to be freed
>>      here. It's might be possible that a page is allocated after this
>>      point. In order for that to be a problem, KVM would need to update
>>      RMP entry as guest-owned, and I don't believe that's possible after
>>      the last guestmem_detach_mapping().
>>
>> My preference is to go with #3 as it was the most easy thing to do.
> 
> #3 is my preference as well. The semantics are that the guest is "closing" the gmem
> object, which means all the memory is being released from the guest.

Agreed.

-- 
Cheers,

David / dhildenb


