Return-Path: <linux-fsdevel+bounces-67142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA779C36202
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 15:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555B018874E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16B132E6BD;
	Wed,  5 Nov 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gCDf5z05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A632936B
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353751; cv=none; b=d1LXFWaQDKSAfu7EVP3EFdhJCXGyqlfdPRS68s0mBg0EhmzEhJjVuhu3iCK1b89VI1hLmrZWMNNE6xnBD+gW94LuV54o+gvUcBSa0TksBHECkjHj7qHJDMwmUSD2pH9yeD/5QU+5P9mEsgG3MVDRmqhD2UdcOMJyo9NZYflFxsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353751; c=relaxed/simple;
	bh=ij2iHrslX/5yNAV81WvwyiP5ZRrrhcDqQSgtHEa9ZoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrobb3pDFGpIjxtRmqqUZrYscLHFGtr5w2XuNgpA42b8PtJXhnxaDgSUJD5NMVvhh67YysERw1FEUpWgDtubLdCKVF6hxZEaEkNyf1udN8cPoAzx8hxeTyJ4deGmS4ovHMt8zoc8TSaLCfxHE/Pg+XQKUMpic2Z73f6j/CX65HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gCDf5z05; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8af121588d9so478622685a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762353748; x=1762958548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCP0hsq/q40gFxNmjoVFcp0QbOx89aTWebuusBQgCaY=;
        b=gCDf5z05uYtlJggKnF95ezS3J3umvz7sQMNDZDnGK8dtKLvayu7kdaLUtT1vMZ6cHs
         1GrwbtfIe7scOFlP2tQeblKFtqfnBbDDvWuaerJCvF4fbX4Iuw1jMMO5qNBS6ZY5ORf7
         wlXA8FlARkhwl3/zBiBwJU4aOeCxfoymxp+HA7s9/gBrOxzS0LNRs3+Mbv6zW6wrbKgS
         Vw1NtjBOiZPKJ476QYp/x9lkuvghR476RYKYUJr6/ygsD+kVyEil9ToZF0qbl82FpAPl
         jncikulGE0TeNC1J/5fCUZfNhIKnf6FldJa+Hdi7S90irvpaNARjjyogJGnYymejeFSJ
         J/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353748; x=1762958548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCP0hsq/q40gFxNmjoVFcp0QbOx89aTWebuusBQgCaY=;
        b=vU2WX1LiLevBWqwAvC2FdZ1UMR8CWP8wSZQS9HpGdRIU0uGZ3YtH7sYl53OzKeNbZ6
         d0lqbgSAIGJCrWVV7Tv7JXDFfASyxsmIsezuS12U03FrJMQEg9t1pHd/Y3f1J4C0ejyk
         mFKnf6W7naI5LesR4tOozotmtcp9ZkcfowFHOfCxqmxmJ92C/9QQp0x4aktTQr5JN9qJ
         JSauXvIsVuCA6Pkp5d94ESK/a0/eA1eElqx09mGL+ekyo4KKW4kZjFuWoYqtMHGIVvjQ
         /6hwVtCjhtnftIucGyOYOHyiPVxTBbmuVWTsravMgVUSkyKyRRhl537lhY0m179sWzXF
         Afwg==
X-Forwarded-Encrypted: i=1; AJvYcCWOaj5c4tmSrcDSL955GHptICEJ+WhW4Rj5DoppH1cg2VdA7wFTvyMq6dXAJmUL7sGmuFu40zeXAp+mm6s3@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAFn7cK63OsWCyOlmAIS+gtYwri4ry3q77Z4TTnv9BIAradCu
	Yi/s0K+i/XDJsjxUKzyOM+f+z3+FkrxepoFmMkAdAo/H4tXRo5wrNKrbUi3eywtdlwo=
X-Gm-Gg: ASbGncvhabzSQvYbtSs35BLTfXpX64lYjMdPD9nD3tQICnMqrRZLjWIbfDoRoqa4ceC
	pGqMGdBIyLhruhY1qvJesACGLVN14Qcy2UL5KdQ4RViteyq2UCbEJMS8iiv0vRNYZkPjIva+T58
	hkBy+POTXx9a7ih9Ny5RMV8BzTdXRDmYIb6kJQbAD0g1KqatO8TZ1R9/tIGRHzONu/nvhvf82kI
	iXeV3n/vcUG6No4hpzOYq9epMCmfVjNXVtq3IYKhicPw8HgupsrUs9XhT5vWJPC6WAS2a05pZpY
	XHRGWtjXb9UVmo60nS6zxUwuiDBRS7vkRwjE/Db0yhUZ5FSU8lMjxfF1FSU63p+/I+7BOty0NKB
	PGj1b8Y9NCyxOEHl/MTwPZ/Iby+5ZQ6BR8AA3TygFuPTNZQjYsFSOfNNKbjWAOVcyXenLpjJTt0
	kMlakAhFht2F1JMduFyNS4ISShVeglSCH4fxyF8AZr8xT6mGGfMl2fUdPVY6gBYTHwuEtebw==
X-Google-Smtp-Source: AGHT+IFOPmymxkVWTStAmI1fSxsEHrX8n+cH3NR2hrKHNMeSwi6zTbwFsDY5mjtR5/Zbzi6pU1fUXg==
X-Received: by 2002:a05:620a:4416:b0:8ab:4ada:9b2f with SMTP id af79cd13be357-8b220b7f441mr375892585a.56.1762353748298;
        Wed, 05 Nov 2025 06:42:28 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b21fc36dbasm239867985a.19.2025.11.05.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:42:27 -0800 (PST)
Date: Wed, 5 Nov 2025 09:42:24 -0500
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
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
Message-ID: <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>

On Mon, Nov 03, 2025 at 12:31:43PM +0000, Lorenzo Stoakes wrote:
> +typedef swp_entry_t leaf_entry_t;
> +
> +#ifdef CONFIG_MMU
> +
> +/* Temporary until swp_entry_t eliminated. */
> +#define LEAF_TYPE_SHIFT SWP_TYPE_SHIFT
> +
> +enum leaf_entry_type {
> +	/* Fundamental types. */
> +	LEAFENT_NONE,
> +	LEAFENT_SWAP,
> +	/* Migration types. */
> +	LEAFENT_MIGRATION_READ,
> +	LEAFENT_MIGRATION_READ_EXCLUSIVE,
> +	LEAFENT_MIGRATION_WRITE,
> +	/* Device types. */
> +	LEAFENT_DEVICE_PRIVATE_READ,
> +	LEAFENT_DEVICE_PRIVATE_WRITE,
> +	LEAFENT_DEVICE_EXCLUSIVE,
> +	/* H/W posion types. */
> +	LEAFENT_HWPOISON,
> +	/* Marker types. */
> +	LEAFENT_MARKER,
> +};
> +

Have been browsing the patch set again, will get around a deeper review,
but just wanted to say this is a thing of beauty :]

~Gregory

