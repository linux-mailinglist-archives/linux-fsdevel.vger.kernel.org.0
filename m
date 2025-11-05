Return-Path: <linux-fsdevel+bounces-67197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B35C379AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 21:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B57F34D0EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 20:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266730EF7F;
	Wed,  5 Nov 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZSxGdxX9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862E32E6B1
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372868; cv=none; b=HTSojtrFI+6yBy5hPFWKl7wApPAS2M9wbo/h9BMGhAcMAkSx+ClcTRdHb9VpKOuEYaLcAmExl0GpYIfBLJrqyn2XtLH4jceAfGnvYBqXFf6AlVlu+QZB1althcQEbLnbSVhXKXYuYozxKLzoZmEXwosdH8JSMIQNtCQDPBylNh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372868; c=relaxed/simple;
	bh=GsjEeX/yoeLxBaD+dnbSv8Mk07ocMdYdXojXWIK+l4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow9e4SK6ZEGMFaSnKS8OrK268nSafF8lJQXyq79HlQVssmokYqgAVX94Id2S43sveCEvLFoc1EkU5Bu4MHFx77lNVsQS3TJ4vZmzMweeyGTsTLTITFkT7VlcL9hI41y5u6lh83Cn1Mw1RalCp8P/af0J8WFijXMQicRE5FWa0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZSxGdxX9; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88043139c35so2225636d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762372865; x=1762977665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldDyq3tsFgYvyoHI8nWeYS5HdbVk0rd4V1r4ezrVHxs=;
        b=ZSxGdxX9xCk1HKNpVIcM3JeGL4ppDGq/ppX1tKu4zzry89rvCfCuRLNhxVQTwFsO/1
         xzBHvTqNEf1f//pxFOyyjiKoLv3JQ6jMFuZ1U0gtSFs0gUY5788vd0Bw+sW7CJcHcas5
         /cwugQ+wGeG5ifFdnhLsHYmm7TAMulD3ytgLT9U21uBeTuEwU3xQhOJyUj57qplDnfTR
         6OGd4k3TKUOwqaDx7S/HHNZKW9KXKtxkZML1HmUe3fcX1+KMtLTI5WtXaoSnN5l1vuRl
         ThKKki1xOPnWTPWwyCqM3j+KNciRfeFxGonXxktJUKdXwJHAPgOsc3ryftcHX8Y9jd+0
         lCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372865; x=1762977665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldDyq3tsFgYvyoHI8nWeYS5HdbVk0rd4V1r4ezrVHxs=;
        b=HCtmM97QaH7Wd6E0QFTTZS11fR6GveVNulYbKzFMU0LdhdFNgNy3wpQb0vYnhZ2FEp
         MkrBEasgMlvI7ofGioGj7R09jejjbwoY08EKRiP3xoMtPHDUfoCyJicGPDhNFCztlIkc
         t+k8jcLo2lbf7pEfsQ2ml1mua7fRXez4IMkgvqr1YBKUamofy6TeDvLeX976nBRFVDX8
         7L7Ik+Ne5ocIDX4WQ6gnb8wVhr/KK1wqSxT40vF0TpckCS6LuiDdxShnvZtr+4g2sfAC
         TpWbgutxq55o/vLJs3EnyAJpPDcMlLFBJAxXuXF0Y3fIthQlYZxau5KPzrnNrSrMgVZ3
         3NPw==
X-Forwarded-Encrypted: i=1; AJvYcCXuW77bZkjvVL7fjVQCWD5FfsLZWrKcA5Kmhj+kRABHm3hz8MqihsdgJ9U51vTme2V/W24boy5FTSJRxszD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ythsBcn8SKVdtYeeq7IaN2A9xWUYPY37fMr0mBP9Qmj8z9v4
	jbrdYARoKfPjnqi7ZcFRps6OvB9+T7QAYFjxUtK6EwOWLEK9bqqQjWthf+41yJEuQqg=
X-Gm-Gg: ASbGncuc+Uqq4QSK/WC8irnW3nbfSl44ge2Sf1XxsDMhK6i+sWlIY2oq42TQwzLmgjt
	/mtsFuMuWhnNvocZOJVwL9sdEW5Bv7wTYOrvEA2BlsR4rX89gu+i0woZPTvZBZefOzuaJMaTky5
	/s/xmR0hiJVxl4GoLDHUsVXYv8cyrbLWRs7I+4L+/VrpXn596NtfysmhHelsaUfUgKYDXxmjFwC
	9qK/Q4pJGmylkvn5n9WDcGcQ4IzLFXNxjHUpd7tbVU7DGGfjggLV/raXxYmYdmhXa5pPDGQ3CMY
	SWe5ZggFOMxGZJm1m5HT3ttUWQz69NvFdJ/TZ1PeAONAYJVUqONoi3QuMSPbldUUCkQ2CV5TQLi
	9bgaqHchg3qkht81Ti5xmALiOPzOk6HUGMYPrQQCEB/qCtRG1sKhpHNBv9FAvcAe4Db8DNlLoPO
	QmAqX6l/snYVKS0mWmIj2I1rNa43cDHTd4ntXHZhhDtmjwtJMeYV9GzlFHX+Q=
X-Google-Smtp-Source: AGHT+IFrPbLMeE9CYwB+D7eMKoLl9vB1NdinT/slFi02CGhPHxsO1o1rCTabfaRmYf3n9WMkLz+GWg==
X-Received: by 2002:a05:6214:20ad:b0:880:4896:5d81 with SMTP id 6a1803df08f44-88071135a41mr51873106d6.3.1762372864533;
        Wed, 05 Nov 2025 12:01:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c4570sm4100556d6.10.2025.11.05.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:01:03 -0800 (PST)
Date: Wed, 5 Nov 2025 15:01:00 -0500
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>

On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
> On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
> > On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> I thought about doing this but it doesn't really work as the type is
> _abstracted_ from the architecture-specific value, _and_ we use what is
> currently the swp_type field to identify what this is.
> 
> So we would lose the architecture-specific information that any 'hardware leaf'
> entry would require and not be able to reliably identify it without losing bits.
> 
> Trying to preserve the value _and_ correctly identify it as a present entry
> would be difficult.
> 
> And I _really_ didn't want to go on a deep dive through all the architectures to
> see if we could encode it differently to allow for this.
> 
> Rather I think it's better to differentiate between s/w + h/w leaf entries.
>

Reasonable - names are hard, but just about anything will be better than swp_entry.

SWE / sw_entry seems perfectly reasonable.

~Gregory

