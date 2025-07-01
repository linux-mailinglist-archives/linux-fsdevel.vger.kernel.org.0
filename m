Return-Path: <linux-fsdevel+bounces-53578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37443AF03EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068C01C2199D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157728136B;
	Tue,  1 Jul 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SydD+gry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA91F76A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398724; cv=none; b=Y4fmgrkCV+dmIaVnOdxrtPX2NIvqRPavBk4bCy7t6YpUetBm3t6G5Ozy6sE1IklauFmziuSSrhH5gjfH9A6cSrnFkiYowjmCIc4OWgsuqiAKHOrU4tpOK1KTg0gNaf4BToY07EPAxpeplnQNi9YTcRSJGfKR1402KpuqNn+aEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398724; c=relaxed/simple;
	bh=/gDBtxT109hf9ai3868bZtZVWwsPmd555OsHp/op8gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlCwfnZPRVBcHPCov0dSdXuIZP8erDMdJ6ecdSeLTYZyJ1NRRFaiem+XuM69GEVoSRHrqoH63yFVeJYEGuUdB89dGoWAZ0fZiy7wg1Z1WC+DKuD359fuI3hJhLrTQoUWOEK2oOPlsgFrHmg+Po+HW5J98mDwRq97rL5J3FltiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SydD+gry; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751398721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lElXDuIbz+447o51stvN3qhEUqBMiy6QYykeUTYpuzk=;
	b=SydD+gry4kCmE7uZw3Xk6J0LwOOa/lDM6sPnxRRxPOoZgu1UkwWuomqQqPwwqL/wet+GZo
	SqcTou+ikVjWYu/BlzU8LpucozAIEJPlYq9s4DakoRQ45dMoB6DdcW8NObAcZVdhpROZHv
	AxFOGP+ONXBIfq8etYsDWW48hUObYo0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-dLmcgikzPEawGQbmFYKj5A-1; Tue, 01 Jul 2025 15:38:40 -0400
X-MC-Unique: dLmcgikzPEawGQbmFYKj5A-1
X-Mimecast-MFC-AGG-ID: dLmcgikzPEawGQbmFYKj5A_1751398719
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a58939191eso1319192f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 12:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398719; x=1752003519;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lElXDuIbz+447o51stvN3qhEUqBMiy6QYykeUTYpuzk=;
        b=P/16yHiX+twBedcBK1qu64XlqWudP+rCPEJTCWU1jkVnxcf2KH41rUTLZ6manIe85Z
         m8BqiyoME88zOyG4NZ+iGbugwATLfKiMgLvqsVkl9n55yHXJnIwosPwtg5NKZv0spguu
         1JWpZnJOVqrqpVE+K1EupXCO4+icsWZqJNbG8GK6223CsxwXT5o1wEIga3xSbti3W32V
         AFLF3YgOoFtExKEDVocZDGegYdgX2vf+Y5IvuWYT9GNCmdlivi0VWo3dhuwZL/GqbSdy
         alQ80zVc4NYUKtLBxTZw0dTZIhLlVfCqy1rMgU6b1tgkzHe4cS9PWYO+wOg8A2A6r9XM
         OAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbcsfdGiiyzoAVPysuVVmkAIktpCERNcVZVkjAmtDq50lG4EDfH5BrhOtEGmHMbk9nnYfUJ78TaePOzmKU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4RwUDWtnDKE/LTe0riz+QcakTRuwZv7hK3rZHeYt6EdqTQ7F
	LvyYhih2a4u0I2sW9t+Ddx+1W2c4wYnlhy+9W/UBtbjt0tR4uxmdJ/vD0jYqbHWgFg97vS3HHTm
	VCVSTt9eWdxPJWTh3Qbwo6OZgQD07A01i9TweJ8anh5KkdBLw5zBvncEqAhuYE+nDZGM=
X-Gm-Gg: ASbGncudjK9rl2u4RJNqQGtuiWbYrARndBclocCMduwItQwFB4BLeGWbIxDxsIzI7xj
	oLvro4up27H7V71wZLP9fE5kFLNcVpsKKRAJIoT9uIICjp4YhhzCcq8H2VtVNlfaeFg/Ny9gYQo
	r8EItNGd4kifqOjRXSq5//vSf+ubjlRSXU8lxi8CkiBhrFluC5qDOe0WVBPSYpkup5VsHAd4MgT
	wGE/KKEiH0V8fbIoRt1IKOD/91JkMdsll5BXWFTYRxgYpH+GYQXbjl36UyLr/tRx8DwyqTyh1pa
	1v7MYVPS/gXYRs+J0lQ9b8paDkOnWR8DGrVZKI6QkT31gCk0RvQ2MDZVSKWAt72AC/yPdBbngXB
	jcVWbKeEnE6Ues3i4eCrQdXRnTopCMI5BDG5q04G7V8Cb3zMqaw==
X-Received: by 2002:adf:9d87:0:b0:3a4:f7af:b41 with SMTP id ffacd0b85a97d-3a8f4a15c99mr14175380f8f.15.1751398718879;
        Tue, 01 Jul 2025 12:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLFyo8RcgMuSgcAM1cNXXfDuXZjnZVKPC4QmHAvknSOXyWUZGyTCuS2ZP2Izn55tZDj/Vv7w==
X-Received: by 2002:adf:9d87:0:b0:3a4:f7af:b41 with SMTP id ffacd0b85a97d-3a8f4a15c99mr14175369f8f.15.1751398718397;
        Tue, 01 Jul 2025 12:38:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52a5asm14214194f8f.54.2025.07.01.12.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:38:37 -0700 (PDT)
Message-ID: <bf300002-7020-44c2-bda8-e4fa718832bf@redhat.com>
Date: Tue, 1 Jul 2025 21:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/29] mm/migration: rework movable_ops page migration
 (part 1)
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 14:59, David Hildenbrand wrote:
> Based on mm/mm-new.
> 
> In the future, as we decouple "struct page" from "struct folio", pages
> that support "non-lru page migration" -- movable_ops page migration
> such as memory balloons and zsmalloc -- will no longer be folios. They
> will not have ->mapping, ->lru, and likely no refcount and no
> page lock. But they will have a type and flags :)
> 
> This is the first part (other parts not written yet) of decoupling
> movable_ops page migration from folio migration.
> 
> In this series, we get rid of the ->mapping usage, and start cleaning up
> the code + separating it from folio migration.
> 
> Migration core will have to be further reworked to not treat movable_ops
> pages like folios. This is the first step into that direction.
> 
> Heavily tested with virtio-balloon and lightly tested with zsmalloc
> on x86-64. Cross-compile-tested.

Thanks everybody for the review!

I'm planning on sending v2 probably later tomorrow, so we can get it 
into mm-new.

So if someone wants to review parts of this series either (a) do it 
until tomorrow; or (b) scream STOP and I'll wait with v2 a bit longer; 
or (c) wait until v2.

-- 
Cheers,

David / dhildenb


