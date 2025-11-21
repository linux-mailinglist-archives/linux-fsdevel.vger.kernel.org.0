Return-Path: <linux-fsdevel+bounces-69473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8625BC7BF4B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 00:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87A9D4E2CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 23:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1826A30F537;
	Fri, 21 Nov 2025 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q+tMdxDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991082FFDC1
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763768700; cv=none; b=uOrkP51iJivJsmUZgv/McFb9Xmr9+tNyFm+Ugb6fChr71b54NXvZNe5Ei5E5LKHuw4tJWp0jYJXyoTYPO4bvvaIZaStghtyjXm/eo8ib1bnwE8503h1hXYobENQ+kbWJlk+OFlTA2a+LjoxZ6PrPWtWZYtkYsMeDO5h4S4M5GNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763768700; c=relaxed/simple;
	bh=94wkD2Iff42VLMlQNWegA9dtRPkkPQ7m6y0iMS1EKU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVmwGWbh/zepG1RKa/GMbNI4DXPMMANdGjK9ys9wZLxxfqFnyZ1ujYJgyD01RjzeztGTTHYFXSBewj1Q2AZ3Fp1d5kKJfYdph64RveoyoKFmUBNXVo7sdf2slMF7sa2rdWyLik9vzCmzCdd4uPjNJE9BLh5YZtj4YXc438aslDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q+tMdxDI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-882390f7952so26643866d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 15:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763768697; x=1764373497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94wkD2Iff42VLMlQNWegA9dtRPkkPQ7m6y0iMS1EKU4=;
        b=Q+tMdxDIkYXfhGhbArV0cRrjxNICLqpDxMfcVn6I12tSlGAKpER9GWu29DpBkymHRH
         8+vkLMXGdoMlRW1a8I3ymoYVhDXsc/zbDPsgk6dDtzh5juXd/l67yjvfrH6E2PCz7eSS
         0MnjazwGK0NRKyGqz2ACeRLGXyKvPtxTJ44QTasOxTfU2yErAHu4Ks44MCuNoubORnaA
         NCszOMN2Fla6VYB5ksgTIT29Z+nNac5UtoL3AGZVjOASPrtxjkUtZa4MLYMQCVpwpWT+
         xGLv13APEgGlkzM7Ys1yHg1j8bxhQAP5ngjohGYQXdfFgg/Iu3KmptXD0DSIe/JPz0hm
         mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763768697; x=1764373497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94wkD2Iff42VLMlQNWegA9dtRPkkPQ7m6y0iMS1EKU4=;
        b=ZafYw8iUfEevpycY+fhnt6vO5TVOdGyen3gRDSo68kBE4oGXY0NVJyxWA5nMgP4zxm
         RylxrqeRC51vBuRfCHp5nDSewO4zC0HcZWPviMCc4zE6S821ZtExah4FwwvfP1JTlVyU
         4gAUi+W4D1V4yyDIxV5HEWWiPQRv2wIyGnrbu9QptpYjBRFwQta5XONraZQ4wQzb1pjA
         Da4FG4Yx9TKNzhjEpRd2urVk+d4D0m9oaGynKBpoNgkklhoz8a0YL+PEaby07FFAzkQk
         oF337KBgYR5I9TQma4Mff31qfIVh2sgXxjQODJe/zQ4SYaV7+RKlmoQTGSB2Lsomngae
         oS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOwMrcRA4yyuoWYhUoschlxiCBNdAwizXmJYj0XZwfXcqPDGNrD2NaY6dbwa8cSEDGJHLGk/Q1M52iaJ6z@vger.kernel.org
X-Gm-Message-State: AOJu0YzIn9QZaonw+E60oX2wne2cb4qwCHU5JMnf7s/HTCwuUY+hz7nl
	WM02KRihmZ9Pd5gdKC4CJ0eWHXT3o45SqBU+FFoQReqDfhvwnkye0GCH3SVrJQN4d3k=
X-Gm-Gg: ASbGncuVJTW7GF6dLHwAjERf+tnuhQGjLeIkLpcVIKWD3YDZrWiwiniZLP50apBSOMv
	CUoLrJIzoQtvv0X1TB327DtYj1utNd7AH/WirltwlBDru+338pKRep97wHlEHWpFs3NGInlhyvb
	l1zNx4w0NKtwJpdIYrIqqqD/vBQq1dUixH+cUazuWowdMO8jURpCSvnvg4p8UoN4M3FMjEg45Wi
	4shnE8vdrT5Kzoia3gIkyfFRHHb+X5oiukcUsE2kWOy5m7FZT4Ridouz0zWUziV6QS8ZabIRXMK
	DrJFPs9GsZc5/1OxCS9TsZTJcn098cv73njSalKBsF4DCNPjtKFkMfRiCMQjdtlBrnwGWtMKPCm
	I6dK5dd/8k67qaEB4+KSnND8kZFaqV7AGKGx6a9d1kFXfNQxoD8pFRgmvckdCNsxMfBkTTcI5L4
	fVF/nGMEc27pr+ikAE4hve5HFhg5c4seSJYo1SyWQRtofYWVhelHy0XYcL
X-Google-Smtp-Source: AGHT+IEos7T2Axz389Mmy3AFU8+Jfh3PFehz2HfOxc6qgzO/Its691H7QS0uM/0VDIYstKPPxEQUqg==
X-Received: by 2002:a05:6214:226c:b0:87d:fc3e:6d9b with SMTP id 6a1803df08f44-8847c525de0mr61714186d6.42.1763768697300;
        Fri, 21 Nov 2025 15:44:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c32csm48350666d6.37.2025.11.21.15.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:44:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMaoC-00000001bmD-0arX;
	Fri, 21 Nov 2025 19:44:56 -0400
Date: Fri, 21 Nov 2025 19:44:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
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
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <20251121234456.GA383361@ziepe.ca>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>

On Mon, Nov 10, 2025 at 10:21:18PM +0000, Lorenzo Stoakes wrote:
> There's an established convention in the kernel that we treat leaf page
> tables (so far at the PTE, PMD level) as containing 'swap entries' should
> they be neither empty (i.e. p**_none() evaluating true) nor present
> (i.e. p**_present() evaluating true).

I browsed through this series and want to give some encourgement that
this looks nice and is a big step forward! Lots of details to check
the conversions so I wouldn't give any tags due to lack of time..

Jason

