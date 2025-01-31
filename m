Return-Path: <linux-fsdevel+bounces-40496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0AEA23F0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 15:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253FB3A65DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAD71CEAD5;
	Fri, 31 Jan 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GcI+YDUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38752EAC6;
	Fri, 31 Jan 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333306; cv=none; b=k1DvFfCEFPIgUkTHcFbW6TGASlNoJqGTECiv+Aqu0Uj1iVPTGExmDBvZSBJFSp4quXDUZERuh3kdviOF551lTTyA6xgRqGq4On6bt5qD8JHqQ5U9fNAi8FxxCpqtyk2LxRUI+jZANv11e3CdQOedco8KMdraj7+LAeLLNmAVWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333306; c=relaxed/simple;
	bh=f24bChgj7REtNaoNkH2tAqocNhxOhtVih4QvozTv6m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQoI+E1D9iMCf+kU0rwR4iGPN/U7Ix9RjkdtkBlkESPUbbCmbKq5j4/Q4+hfJTlRYKjx9H2iECUiDKQgFwNrGnBXkJ9ZfA8oMepkQweBSe1PgYUaDh+FEcWOnUTsSi1XAudKIb/Bs0gXT8CKefq1CMuuJ8+FN+4gNw9BRTHY9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GcI+YDUi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gn6ROdhimfH2SlxaFG9S9wImJavIsJGvPsiITl9Tyxg=; b=GcI+YDUi42q8wWLAaliLPMiJCL
	jC3vbx12pAXO2Q4jttDBHLad6PFrI8gKFC3UGsAmD9CGyvTct74eea7pwBUi30YOPI6ohMHsELXRa
	WTkZKm4FPDerhWo7QwIC3sY8fg06rYWHQ+C/HxXpwV2FZ1kAuXRRCAg1UfEL2sqGk4RbLj6BuD2qa
	NQw6KWjJxuVhMY3rwD/NiDfpZcCBes6Wo+8nK9PgbM5Tqg7/Fr0zPXey2d2H8QVOORFMWSgoJTKjk
	/JriUdLVUEli8ufJKmilaBRGPP2FpKCWfAuKk2Ubz4QxzjU62JGSWjoLnj8bempgYL3036hFSGCmw
	xa5KYQwA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdrtX-0000000EmeT-34tM;
	Fri, 31 Jan 2025 14:21:19 +0000
Date: Fri, 31 Jan 2025 14:21:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCHv3 02/11] drm/i915/gem: Convert __shmem_writeback() to
 folios
Message-ID: <Z5zcXyYfXSI0PYBY@casper.infradead.org>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
 <20250130100050.1868208-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130100050.1868208-3-kirill.shutemov@linux.intel.com>

On Thu, Jan 30, 2025 at 12:00:40PM +0200, Kirill A. Shutemov wrote:
> Use folios instead of pages.
> 
> This is preparation for removing PG_reclaim.

Well, this is a horrid little function.  Rather than iterating just the
dirty folios, it iterates all folios, then locks them before checking
whether they're dirty.

I don't know whether the comments are correct or the code is correct.
This comment doesn't match with setting PageReclaim:

         * Leave mmapings intact (GTT will have been revoked on unbinding,
         * leaving only CPU mmapings around) and add those pages to the LRU
         * instead of invoking writeback so they are aged and paged out
         * as normal.

so I wonder if Chris was confused about what PageReclaim actually does.
Let's find out if he still remembers what he thought it did!

