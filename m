Return-Path: <linux-fsdevel+bounces-53761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D530AF68A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 05:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67394A2F22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415722DF85;
	Thu,  3 Jul 2025 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SxMv53Xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0AE22B8C5
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512959; cv=none; b=k9RFvf0jEmcy6e07z/Odh+fhjbZYtGzwE+JID1ZCFQlQVJ6J/thUC0GzGmScnSrIM1IHy6dxHAnbxtvwMZrhufuQXf4Tytzf2L83R2bEcnC2OiorCp+TI44UXDMLDqYXlf6GiEafz3htjFFy+gqVPGcVJUvzmNTiYZLwGr9ggdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512959; c=relaxed/simple;
	bh=jRAp1AVjN+o0z0U9utUV1cQ17XRWoHhVViGsl36T9Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI6GCYOBrg99uEAGgA6CfzZShbUPHR6uDNvo0YM5E45dGa+sqRTxScJzFtYpce5VC7raP8YBayIOTyOvNVCQ16M8ORqUU7/BszI+2Lvt0qPhQCgh8cDchmAqIY3IJo4P7Jhv13eO/80vfM8w/B0z6Aa7eT1JF8My4VPmdhsP5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SxMv53Xx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so3866577a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 20:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751512956; x=1752117756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3/FURbw0Qjice8ym2SrrqkCxrOCjqZwE+s45rYEO0E=;
        b=SxMv53Xx6Degcdj47VTRozTEgcj9lqtxUGfqgW+mN15Ck/uN+S80/jxpVUbrPGDAse
         Tf3uQ0wMhzwJgoc1+99tdez86AOQV4WPinPUdktvYk37Dlv8Wfh0IDvP91+59DOAPC8M
         1yYMHzssFyQve7RxVvVq6GTiEh3Tntv1JfOiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512956; x=1752117756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3/FURbw0Qjice8ym2SrrqkCxrOCjqZwE+s45rYEO0E=;
        b=R5TYa2aIxYbh9t+Uwl6kCcfgVix47VCn0DHBv0N0LWhyQQzv0tvG0n3Z8/ixdG7Ls+
         3n31m7Bh7Kc2+VXLrCJb4hNJgWgSRPmcEQrOzb0W5sXPrlmlavjMpKw6C4bMmNiU8AOu
         +ItmJPFdsepbDb/sBfz0lvLjBFx4ZlIkDwZBHQViY+xQboC72G78FEdYDFGjdUOCLTtn
         I+6k/DqqHf4XZOH1j73Cz/bPPbwPGYxxgOMMqTFapK9HjU+KbUW6jhWasZqGl01XlqF+
         DJWuUSUur5JwxKlKxboZkfL6Y6JL3EI4YXq8f6x4MRzKpMGkLCe4NcmpDoOpTZ6Hw9fl
         LHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfTteRqOalFL9aQGU7zHC1/gsoSzGbaoDrl/+u//2+1iVmH4BGSoCIGNhaCLob5fC5x+T3PiUZiD+pQE9t@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1F5fJdfh4E5gosKcJ3xy7RReRprKKCTC1rUbR2ZVjQQJDWI3L
	ZURASGk9CRXBCjJ+dwbI/SIE9WI2KsfX03Vb/7IFI08zAZnk973uSoxCJuryMfpxSA==
X-Gm-Gg: ASbGnctldWoK9kLHWBbFoqjzZI9GkFtcET26vnY34MpqIwFgZUXYOQLoFHgb0h8OeLh
	ZlnfveFIjUCPa7VsdRi+b1V0Glh97gJ9fLEAEJI+m18lfH/5xJu6s60ycEePBOaLccKO3IRBIzk
	UJpAD/VU1x4V3wbmJPiy8A4yYAobcVp9OHD7hKcuB4E/wlisyGyuvX8+Hzq5kw4rFEvgxeK6GAz
	ZY4bJ6zOlkyHpZCcMGWo6e7UluUXEvQmNdvZDVuUgfloUkSDTWGhwHAna6Ta8kBMuxrE1Eg+0m8
	RSM7d/gR9JIEjju7QwDFyiEhlqRNFLzYM+ow0ikkk5RnXj6jMAEiU9gTU+xazqRz+hdyS6WXYuv
	L
X-Google-Smtp-Source: AGHT+IEAy0Xvd7q1RC5hmp7SawamH/oI/muiFAFExRx9I64wiUZ1PQhrNgi3qS6Dq4f35q/YwfITMQ==
X-Received: by 2002:a17:90b:3946:b0:311:e8cc:4264 with SMTP id 98e67ed59e1d1-31a9d545d21mr2763491a91.12.1751512955991;
        Wed, 02 Jul 2025 20:22:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8e3f:7c33:158f:349b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc5204bsm1117959a91.8.2025.07.02.20.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 20:22:35 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:22:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
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
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Message-ID: <vscedd6m3cq73c5ggjjz6ndordivgeh4dmvzeok222bnderr5c@dujm4ndthtxb>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
 <zmsay3nrpmjec5n7v44svfa7iwl6vklqan4dgjn4wpvsr5hqt7@cqfwdvhncgrg>
 <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>
 <ugm7j66msq2w2hd3jg3thsxd2mv7vudozal3nblnfemclvut64@yp7d6vgesath>
 <11de6ae0-d4ec-43d5-a82e-146d82f17fff@redhat.com>
 <5thkl2h5qan5gm7putqd4o6yn5ht2c5zeei5qbjoni677xr7po@kbfokuekiubj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5thkl2h5qan5gm7putqd4o6yn5ht2c5zeei5qbjoni677xr7po@kbfokuekiubj>

On (25/07/03 11:28), Sergey Senozhatsky wrote:
> > > > > >    static int zs_page_migrate(struct page *newpage, struct page *page,
> > > > > > @@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
> > > > > >    	unsigned long old_obj, new_obj;
> > > > > >    	unsigned int obj_idx;
> > > > > > +	/*
> > > > > > +	 * TODO: nothing prevents a zspage from getting destroyed while
> > > > > > +	 * isolated: we should disallow that and defer it.
> > > > > > +	 */
> > > > > 
> > > > > Can you elaborate?
> > > > 
> > > > We can only free a zspage in free_zspage() while the page is locked.
> > > > 
> > > > After we isolated a zspage page for migration (under page lock!), we drop
> > >                        ^^ a physical page? (IOW zspage chain page?)
> > > 
> > > > the lock again, to retake the lock when trying to migrate it.
> > > > 
> > > > That means, there is a window where a zspage can be freed although the page
> > > > is isolated for migration.
> > > 
> > > I see, thanks.  Looks somewhat fragile.  Is this a new thing?
> > 
> > No, it's been like that forever. And I was surprised that only zsmalloc
> > behaves that way
> 
> Oh, that makes two of us.

I sort of wonder if zs_page_migrate() VM_BUG_ON_PAGE() removal and
zspage check addition need to be landed outside of this series, as
a zsmalloc fixup.

