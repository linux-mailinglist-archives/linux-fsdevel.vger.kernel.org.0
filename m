Return-Path: <linux-fsdevel+bounces-53758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63399AF67F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 04:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA5F4A6A21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85591FFC5E;
	Thu,  3 Jul 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gXx4bsi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351C1E520D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751509721; cv=none; b=HapDae1jdyeW+o6VQWZGIwdjObeCBEWsGl7Sbca7hldNGBdwJhMXfFOzQAOAvCOf88OpB2ZjXjth0vX7S1tie+cjoDjUWIXfeslpkPxHZY4K2/DI9WPzRDLY/NwxpW7/9s3iN0xjzZE6KmRDdk8icno75cqSygMdAFD3s58uKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751509721; c=relaxed/simple;
	bh=oI+NQH+nFJLnW1KEYVWh8bCi6cQjiUciyVOdI8RQ9jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwgtSsT13e5jD/c8cSh3fasiW0WCclx1Uv6CDM3P1bdnXgfExRyPufmnJOGjJiIKHA7G+wMpx7ogIJmFl2e1oX/SInvsvj0RL2d9HtxYQETIMTus25Fup+lX5SVq0xSQ1Um4K//G+H2g78hHr/1rYjyeoxrvwIPBy405smy7SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gXx4bsi2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6223484b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751509717; x=1752114517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2nTXIo+CvpirZ9A1QVaQpQOlJd4MreiW9qDAdilxYI=;
        b=gXx4bsi27gy8C/9QSu11WuXlJ2tNIZ3xTcmLj8+js07ghOG5/TIusM5Enf3iism0En
         LmMygaeq8TWHzB9s/5xAZZToWDjJ4CDaNCf2uVze4KKKUP/UZAjcOEs04St4fAhgxXkp
         tfG9A3LuLXDxV2Ty3D18qbtZxQN6L2LF3KZAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751509717; x=1752114517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2nTXIo+CvpirZ9A1QVaQpQOlJd4MreiW9qDAdilxYI=;
        b=HyqyS72kNNehRzOAi7UzQlIZI8SXHpUEvssrP8TV8dAk8iOcXVJhDrT8vhVNzBjk9C
         +nL+EHpkX89eGmXRrmv1G3gI2m6mZGPC8qiO3UGBAfq3BKelaLHEBpqmCcJdLQ8YZsP8
         80UwespDjFIgEvxiSXUbRKeT8AeCD0CxIGjafzk84hqg488GR2LNOZEVEQXrDbMHJ3ih
         1U9SY2fQol+dbjoJIptLAgwu/vAADZQ9MpaEgWwNNfrpzes2ISZ14ceKJGwbv/v1nib9
         mVmPVUOX1kQjxJz8RwjetViIin7NnFwhhwuhPCNcw/0hzwr8f8dAMxX7o4RoFw1EF0+t
         I9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWE+wu9GEirp004uETlN96CL3OEjHv3ECkTMyhJH1x5q328uR+6tICJrWVqQgh4HUou3ogYA3QPPVaPiQvJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCnYsI6FUeteyeFUEKAbUUYzkXkpCQOC0VQuPp+SPijopvyqE
	uPFoYIcl05qZ2eU4T3ZcpRYeeWwH/512PstGFsUDlo9+AhFmnJuEWay/8laoJcFruA==
X-Gm-Gg: ASbGncuQac4no8JDIKFXH+lP5iCqwvf/zDT/Ogz0XdqyFZ72U/iEmkf3MwrTkAd7muh
	LPkETnevTJz/Z5oHCQtEsbGd9SevGkZTV1eCFHkarMr4fDkJXhM22Pw6Z6ecxQmn4mFJMpC1sr8
	lcouqRuC0hZs/fZWEVcjqZsaTLUGjyOQUNXP7rEZPiA8ZRnoMPuBrYbTvWAx8GuOVOIUOVIoXtM
	K/BQn3AUttzQ2i2jaIfODKtTAItOoOt5aMBp2okc7Yd2KMh7CQ4D58gnbQbMY3hWdSWyIEke1lv
	eh8yHcjLVNE05aQ2lj/If3UkHvJQQy4IHk93EWhJlqza1inKLyM54bP8sedce/CeVA==
X-Google-Smtp-Source: AGHT+IF0mvA6yS/npwsiNYiL0/8VVavPM/4qMbTse5ZctfFIAIwQSgruKczXUi/oxdeocj+35zKyHA==
X-Received: by 2002:a05:6a00:3d11:b0:748:de24:1ade with SMTP id d2e1a72fcca58-74c9980d533mr2410295b3a.7.1751509716701;
        Wed, 02 Jul 2025 19:28:36 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8e3f:7c33:158f:349b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541d23fsm15895056b3a.59.2025.07.02.19.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 19:28:35 -0700 (PDT)
Date: Thu, 3 Jul 2025 11:28:23 +0900
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
Message-ID: <5thkl2h5qan5gm7putqd4o6yn5ht2c5zeei5qbjoni677xr7po@kbfokuekiubj>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
 <zmsay3nrpmjec5n7v44svfa7iwl6vklqan4dgjn4wpvsr5hqt7@cqfwdvhncgrg>
 <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>
 <ugm7j66msq2w2hd3jg3thsxd2mv7vudozal3nblnfemclvut64@yp7d6vgesath>
 <11de6ae0-d4ec-43d5-a82e-146d82f17fff@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11de6ae0-d4ec-43d5-a82e-146d82f17fff@redhat.com>

On (25/07/02 12:55), David Hildenbrand wrote:
> On 02.07.25 12:10, Sergey Senozhatsky wrote:
> > On (25/07/02 10:25), David Hildenbrand wrote:
> > > On 02.07.25 10:11, Sergey Senozhatsky wrote:
> > > > On (25/06/30 14:59), David Hildenbrand wrote:
> > > > [..]
> > > > >    static int zs_page_migrate(struct page *newpage, struct page *page,
> > > > > @@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
> > > > >    	unsigned long old_obj, new_obj;
> > > > >    	unsigned int obj_idx;
> > > > > +	/*
> > > > > +	 * TODO: nothing prevents a zspage from getting destroyed while
> > > > > +	 * isolated: we should disallow that and defer it.
> > > > > +	 */
> > > > 
> > > > Can you elaborate?
> > > 
> > > We can only free a zspage in free_zspage() while the page is locked.
> > > 
> > > After we isolated a zspage page for migration (under page lock!), we drop
> >                        ^^ a physical page? (IOW zspage chain page?)
> > 
> > > the lock again, to retake the lock when trying to migrate it.
> > > 
> > > That means, there is a window where a zspage can be freed although the page
> > > is isolated for migration.
> > 
> > I see, thanks.  Looks somewhat fragile.  Is this a new thing?
> 
> No, it's been like that forever. And I was surprised that only zsmalloc
> behaves that way

Oh, that makes two of us.

> > > While we currently keep that working (as far as I can see), in the future we
> > > want to remove that support from the core.
> > 
> > Maybe comment can more explicitly distinguish zspage isolation and
> > physical page (zspage chain) isolation?  zspages can get isolated
> > for compaction (defragmentation), for instance, which is a different
> > form of isolation.
> 
> Well, it's confusing, as we have MM compaction (-> migration) and apparently
> zs_compact.

True.

> I'll try to clarify that we are talking about isolation for page migration
> purposes.

Thanks.

