Return-Path: <linux-fsdevel+bounces-39381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85065A13302
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 07:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A067A164E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B618E750;
	Thu, 16 Jan 2025 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f/9vKTmt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E985A94A;
	Thu, 16 Jan 2025 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737008314; cv=none; b=Okbm9dtNj/yxvMneCdJMgqPcNVF6p7WvJBDxS13tIgVSu1gY1L4QCwC3z3IkVMlDyX467C3QoBlNsh93nZ67l4ZdI1X09uk/YemTCmuv8JwVHymeGW9QtdWppgqq29gLrHHgguJZJfjrOFUALMkiLpweyVHd67/Ast4TmT9wgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737008314; c=relaxed/simple;
	bh=5QSpWf0vAH/b20rX6EX94WIbXaRZC6wQQEmLRkebQo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYq9I1CMDU1zJ4++EBUlptYCNzkv+cs5btY8DPDGysTG4VO88+HSQtuyYJEv6ZJ5/AmG3IqObfWjSTWRiOEUc10QXsH8vET7/tXBQHPi6Va56EPMP87txnmyBg2U8jbAppyEiUCD/+GPQ4zmOCquUCls5b5lwSogkyBWbXdAj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f/9vKTmt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BwenzUwAE3QjZlUTg3HaFn6rqngicIwXNfQ8pFKmwdY=; b=f/9vKTmt1wc30CXs5Ywuc87B+B
	OG5Q6qmdeJdMbSH6xuuIVrgCzmA1giyEXJJplJKcQfOZbmaTRlvh7a6A3wnnip2UQe6PwsNbTDtKS
	GrkEgZR8RGpQ95xHQUzyvKyORMa2khfNA8BTDVTlWtbHv6N9UQrfO2UqBH9D3URF+BBolHd57qb1M
	M7oES8gWAj19SRw85jBkWh37NxuVlehOCIEXuzmEocHQ+K7JB6Q5DkVXet4F8P7bn4nrl0QdA0H5u
	UN/U6QfRrMFB5rWj59Pt//nTUezjY/NaA9/mNGs7QCeOM8EKOMmszwCh6YZwjRJLpoHigcLM9gie8
	LF9SAB5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJCq-0000000DwEd-2aQg;
	Thu, 16 Jan 2025 06:18:16 +0000
Date: Wed, 15 Jan 2025 22:18:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Airlie <airlied@gmail.com>,
	David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 11/11] mm: Rename PG_dropbehind to PG_reclaim
Message-ID: <Z4ikqJBQ-fBFM6UL@infradead.org>
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
 <20250115093135.3288234-12-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115093135.3288234-12-kirill.shutemov@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 15, 2025 at 11:31:35AM +0200, Kirill A. Shutemov wrote:
> Now as PG_reclaim is gone, its name can be reclaimed for better
> use :)
> 
> Rename PG_dropbehind to PG_reclaim and rename all helpers around it.

Why?  reclaim is completely generic and reclaim can mean many
different things.  dropbehind is much more specific.


