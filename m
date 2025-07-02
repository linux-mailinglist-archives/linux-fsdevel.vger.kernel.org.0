Return-Path: <linux-fsdevel+bounces-53621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C9AF1156
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F454A211D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D325393E;
	Wed,  2 Jul 2025 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RchncG7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51224A07A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451049; cv=none; b=lRN7KapIazHzeEEUBLB54MFnMBmE4At0ddC0rbCrgIgKfbUY4nDP+TNEF4RMqb8lpoB2mqosJauuywGe9rvYzjxy1yJBvO+5Px47m5isJBLt+QSOxrTRxI2LcKdeI4Dt9pomgHKpFmXpUxJLfXp6EuNEIyBz4Zy8T1A3j0ALZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451049; c=relaxed/simple;
	bh=X/8cCALWl6B46verGcMgk1pVS/SO1QUX5EH6YbyQquQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiPx6vTghmqwnbnuSprQX3zLDGaf61gYM3mpE3pWW41hyFZ4wSFm4SRjw0RISKpP4jinmMsq+RdleVcyGql1SkbkxyoeL0AXxD+donopp/UpbtHO1BSqNHgU69fCm4YbrQEkdJYD6Eufc/CkactwZdPT8A48XFqT/P+yF8DKyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RchncG7I; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so3217509a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751451047; x=1752055847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld1XwWyA21yaiRgsO+RmuHJahSek4BWAE0bK6K3RNA8=;
        b=RchncG7IPeq1A1lS1fUZ8SZUGpOUPDZkFaiIL67nEZdW697fpG3n+FDT4QuI3L+rz/
         xqSHHBBnSOvChhZdxNvzWuVve1mwl5anE5VQ0n9ypya+t3pxtAWsqRY9EUXmduTWhyP8
         uYMgUyThWVvwssYfj/o3If9vw0xlqX3W4Nf9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451047; x=1752055847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld1XwWyA21yaiRgsO+RmuHJahSek4BWAE0bK6K3RNA8=;
        b=HOdxZew9sZ2jIMMlGEViLG1Or8uXgxenrbliYox6R7ML6UXKFMVNfuGZqnVGDq0khH
         NrSf0Xo/QS08ntLJ4jJAlLWOkfQwCrLQeJVB+zrynp/5hj3P7aMPnTbY3EyywU8DmHSB
         k96UdFmZh3VxvhKxrsS/UadvbIrpn/Er8Yr/HiZtSeGEi4Fvb9+PZHde7xEeyQvoNb6j
         d3KGjLbb58BeSMhCZt0uOqsm+dHkLowIpyldgZ6vp0nwkS5XUeKF3TBjVT1t6G6XptOa
         4w7zqTV7doRRLbvsP+PsxNt6kiEeo2VyVonfzJIgSyOpqblL++1rjNenGzxCpiJyHga7
         /tUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAdvh1PvbrTayK2dMccgxKJmo/kRr3GMR5mkyb6tbDJ++DAUc9mlJ6Y+BpYIM7XJjMPb01Ke96d+1m743q@vger.kernel.org
X-Gm-Message-State: AOJu0YwnODiGrUHudmwOnISBTcuB94CVpGI1zcdBzjx9DBKIBdhBUVmV
	q+afhpLGYVtLGOI+kytpxkNKk7hPrq1hNZPhqG86IAj/HkhzYfka4xro11aqI3MWMA==
X-Gm-Gg: ASbGnctr3gQ90phSn/Mkz/XZK1ixjO0kl2pounrtuboOGiUKegqcmJExp/h6H680YEW
	wO581YGkXDAdbkXuCtEOQ3+D0CA8+WmjnHE6iNeLYFvTWjytIrxNr9IivZ9Z32caMbw352h9BES
	d9Y75Za3WoWwKrSm1OVT5nADbrbOVSUYLfsFiZ6ZRpfHmLTsoRe2zi+gBeNGYqsopP2CmqP1Tps
	OcIO+PWF2Boh/9ZXXgvsotDRkPVkhmKj/s9gdWrmVt1VBKd3GCeRAU0T/SMoouDAECkRa80UfIS
	9Rl1YfxXH3I/NLJNou2B0/xuDqGTIsWX8EiQyMUYwwhDsr6wsPsh0RZ2dUlMWHCnGy6YfEJgbJ+
	w
X-Google-Smtp-Source: AGHT+IFD0I3P0mnZDdceuRH9XAJvvYKmYNHVDtVURKEkoHBc3BGVYVJeT3uh933j6Dzbu2Zpclzgcw==
X-Received: by 2002:a17:90a:d64e:b0:312:18e:d930 with SMTP id 98e67ed59e1d1-31a90bd4c31mr3078996a91.19.1751451046749;
        Wed, 02 Jul 2025 03:10:46 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8825:8cdb:cb6b:8e71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5383eb6sm19125723a91.10.2025.07.02.03.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:10:46 -0700 (PDT)
Date: Wed, 2 Jul 2025 19:10:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Message-ID: <ugm7j66msq2w2hd3jg3thsxd2mv7vudozal3nblnfemclvut64@yp7d6vgesath>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
 <zmsay3nrpmjec5n7v44svfa7iwl6vklqan4dgjn4wpvsr5hqt7@cqfwdvhncgrg>
 <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>

On (25/07/02 10:25), David Hildenbrand wrote:
> On 02.07.25 10:11, Sergey Senozhatsky wrote:
> > On (25/06/30 14:59), David Hildenbrand wrote:
> > [..]
> > >   static int zs_page_migrate(struct page *newpage, struct page *page,
> > > @@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
> > >   	unsigned long old_obj, new_obj;
> > >   	unsigned int obj_idx;
> > > +	/*
> > > +	 * TODO: nothing prevents a zspage from getting destroyed while
> > > +	 * isolated: we should disallow that and defer it.
> > > +	 */
> > 
> > Can you elaborate?
> 
> We can only free a zspage in free_zspage() while the page is locked.
> 
> After we isolated a zspage page for migration (under page lock!), we drop
                      ^^ a physical page? (IOW zspage chain page?)

> the lock again, to retake the lock when trying to migrate it.
> 
> That means, there is a window where a zspage can be freed although the page
> is isolated for migration.

I see, thanks.  Looks somewhat fragile.  Is this a new thing?

> While we currently keep that working (as far as I can see), in the future we
> want to remove that support from the core.

Maybe comment can more explicitly distinguish zspage isolation and
physical page (zspage chain) isolation?  zspages can get isolated
for compaction (defragmentation), for instance, which is a different
form of isolation.

> So what probably needs to be done is, checking in free_zspage(), whether the
> page is isolated. If isolated, defer freeing to the putback/migration call.

Perhaps.

