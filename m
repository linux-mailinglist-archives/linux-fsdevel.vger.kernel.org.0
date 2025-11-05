Return-Path: <linux-fsdevel+bounces-67188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E84C37771
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 20:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EBD18C7539
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DB133EB0A;
	Wed,  5 Nov 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HsKyD+db"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCD32D431
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370742; cv=none; b=ChnM4wqtFU5C1rXvPI6LE4sTqKpab1YQMd6VXlDDRh+CsgtUbvz0DkFC98BAwU5vuSA8Ocn7AKpqqj4l2KgQKI/Wo8ebvuq4Y/jzaFwu1ZtCNXZAE72Iz5QIIJbdC+uF6FrJy54qc6ixlaSSNNJxSGSFaaShYNXozoC7FLq6U+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370742; c=relaxed/simple;
	bh=Nu03Bte3QnL2ZmTAQ8EJFRG0YuAObGrFfyjxidVrgGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/ogsXm2+wj6zICJDo3SO5rjHW0c3ggZhUn0gQZjtw2Ptnd6ZwzA3TbS+MjP7hdZwKVeM9/YdfbTmLCf6/Laj522nPG2KLj0719G6zPBPFc8qSueQfFwYUjpSUP0KW+mNIILCjL86NV4xE73EVZaeOpWhw0UgAbxZcBUsvp3pi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HsKyD+db; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b145496cc1so22096485a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762370739; x=1762975539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3c7ISS42F3tYlBvNOZmQXpwFtE1e4tCRa3nMbV4lv0=;
        b=HsKyD+dbblu5fR8+XfO4QDYF3ZU96k25c0OR5LKNuo8ojUSKZDUwyc1VK1IVw5aIh4
         sQye0FP2b5ay1oBbWg0HzhJTNlDvYyWqm4PY6CYN5fk+JMKmstLH3AarRKSdzK/KfHfV
         fRtvhSmQ/ppueWx8O/OKrHcQBTkE9Sh7OiSXd8dB8VV/7WnJJ3M1ip1F0FoauUNesHNU
         NNjhxsRXmUbzqsCFzhec+11IuhUQDpLY+Jo8HzLKUk5vaHIzZJzY91iScXWWOeROi3mo
         bw5KGFMf+w8cwElcAKOVYS7jUkRg5KDpkHXrC6OMVtHTCBVYNujMi5b+hVTfhvdU27JV
         pIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370739; x=1762975539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3c7ISS42F3tYlBvNOZmQXpwFtE1e4tCRa3nMbV4lv0=;
        b=DI0qlfSSjENWrRA6CIMK/oF8k10ObOBBaFtK7LxIA64OFeKU3CrZ6ECyZPk0qWS65s
         fUistTi6pDY1vZLmYI9gCvWXTHS+qgd6bTJrIfoP8tzIFNg+S1ZS12mcl3J6GFGaM3/b
         XUk7HNrkxcum0u00I28RCfQMf1K1Dkb37zgG8xUPct/TgT7cNqgpIo1pUm3StxY2Bjhw
         z6O5bLmyyKRDg/85LN2Z4QZs3x5A9HboicB8driY+ryYV5HACWrKotodw0uOSWpoa/Mh
         yA/KcscFuVW9mzZCkW0UWgi89V+r4FKKCFdONyns3ShHbsBAZzUidmywgh/Rd49TdhCl
         CReA==
X-Forwarded-Encrypted: i=1; AJvYcCW1Cm3G+oADPLl1lgsAXEY3+SlQHFX5dVOI6gY0XjtOcuN9xSjZlBVvhEhDnZ13StOE0MmDGcwKZa/bOt9i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgee+GJ/gnsKmStl6AaYVypVFI+UCEhIQTBU/5LC61MiMNpId2
	i3rkFspOywIh60HUjp8TgTFAfHOzEoGrJpAhpLc6DXfk31O60S1HF1ZF/3DtTqUYdMI=
X-Gm-Gg: ASbGnct3/am6+mHMeG0ckcXk62NQ+lgqU4juELWxtXL6nfdgKyPmOfmWnNL7FR/HTrw
	z1Ri96b4fqbd/sJn8kViPFPes6F0jvv1rPeA4ijCxGnm7cVzjIptrwwJQiMqRsN7mDlwq6yhlFs
	HPuIEEY5z7cAQiISOYvzZ8LbFfXmkdELFBmIs6l2kFBoMhLbaOssKBidXLeVg0Y04zLhIx7WdEZ
	fgwAfAAGWYd0WcT4y2vKnXx68C2hwnWQBK9uftYnciOJ9RurnhdFH0xDrjSHfantyDAZ6V1VFm5
	/Aejx/dAwyOVy7IFBgAPtvX3tN+iYT3NHvmZ4Te5ZCq91aRWempKpcRfBdM/Z95b+KMLKrtX7Xx
	5G3GGO3DfgM3Ed2jEHZ8I4iYA5Bw8jpF8u8MIrM0lwhBmMkoTaoQA5rj8+VOulTzMKTuKnrb2nF
	VqqKLgNaM2g7qC+47puYy/HVFGQn6fzaUBby3lwwd3jQjAq4a8a/h04gboRwk=
X-Google-Smtp-Source: AGHT+IE93lZWq2OeBwVItF8pvYDXcfH6WZ0IIQ5p6JNn6wR82KcxAzEptz788KT3rDLJ0XOoUhNeCw==
X-Received: by 2002:a05:620a:4887:b0:8b1:a624:17b1 with SMTP id af79cd13be357-8b220b03a22mr560424085a.27.1762370739005;
        Wed, 05 Nov 2025 11:25:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355e7208sm27162885a.18.2025.11.05.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:25:38 -0800 (PST)
Date: Wed, 5 Nov 2025 14:25:34 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQugI-F_Jig41FR9@casper.infradead.org>

On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 03, 2025 at 12:31:43PM +0000, Lorenzo Stoakes wrote:
> > The kernel maintains leaf page table entries which contain either:
> > 
> > - Nothing ('none' entries)
> > - Present entries (that is stuff the hardware can navigate without fault)
> > - Everything else that will cause a fault which the kernel handles
> 
> The problem is that we're already using 'pmd leaf entries' to mean "this
> is a pointer to a PMD entry rather than a table of PTEs".

Having not looked at the implications of this for leafent_t prototypes
...
Can't this be solved by just adding a leafent type "Pointer" which
implies there's exactly one leaf-ent type which won't cause faults?

is_present() => (table_ptr || leafent_ptr)
else():      => !leafent_ptr

if is_none()
	do the none-thing
if is_present()
	if is_leafent(ent)  (== is_leafent_ptr)
		do the pointer thing
	else
		do the table thing
else() 
	type = leafent_type(ent)
	switch(type)
		do the software things
		can't be a present entry (see above)


A leaf is a leaf :shrug:

~Gregory

