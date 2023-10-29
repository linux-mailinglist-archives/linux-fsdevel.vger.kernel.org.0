Return-Path: <linux-fsdevel+bounces-1513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973E7DB0C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 00:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09BF28138D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063E156FB;
	Sun, 29 Oct 2023 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Emsjtjrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A414F9C
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 23:17:37 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211BA121;
	Sun, 29 Oct 2023 16:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e7NRE5J4yBZqR0H04zSj76mSU3bYxFrKgKvbigz2r28=; b=EmsjtjrntCdnf9uidPLCUElZDB
	rrLD1wAHhepXZQrvGeOqBYYrY7Tm2+OM6jT7pom/tNGj7AoH891NPoJT8KuPKRh+AQtMYBMCMefDo
	wm8nGdoeNoLPEYQnXSZMLM15uLPaSqp3IWyB6tnhucTKnq8OkQBIBfEc0M9GdszRLCv6VRvaz7BG+
	T1lynS2U8rv14NYjMUt+c7y/24ViXrjkv7SMQGjLsXCBjOxwpQwqezBIlD0j4NLC/6M5emqrwV333
	VVXTpXKU77MAEC886DdrahAN0jCoTeiAqivl/OOSPi04RStNzzcwbeuzwXO+omjsHDhBkFnpQpnCg
	5VkJ8ejg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qxF28-000e0z-RF; Sun, 29 Oct 2023 23:17:28 +0000
Date: Sun, 29 Oct 2023 23:17:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "minchan@kernel.org" <minchan@kernel.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC PATCH 07/11] shmem: remove huge arg from
 shmem_alloc_and_add_folio()
Message-ID: <ZT7oCHiNa8YZQmzA@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211546eucas1p2147a423b26a6fa92be7e6c20df429da5@eucas1p2.samsung.com>
 <20231028211518.3424020-8-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-8-da.gomez@samsung.com>

On Sat, Oct 28, 2023 at 09:15:45PM +0000, Daniel Gomez wrote:
> The huge flag is already part of of the memory allocation flag (gfp_t).
> Make use of the VM_HUGEPAGE bit set by vma_thp_gfp_mask() to know if
> the allocation must be a huge page.

... what?

> +	if (gfp & VM_HUGEPAGE) {

Does sparse not complain about this?  VM_HUGEPAGE is never part of
the GFP flags and there's supposed to be annotations that make the
various checkers warn.

