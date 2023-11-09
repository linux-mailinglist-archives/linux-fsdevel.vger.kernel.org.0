Return-Path: <linux-fsdevel+bounces-2517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E75B7E6BDD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3EE2B20D08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460F1E529;
	Thu,  9 Nov 2023 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EgnRhzm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0531DFF2
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:00:10 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE61B3;
	Thu,  9 Nov 2023 06:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cJx1aXyy4QVSvWKbJmU/0WcSwBWfkXB+0pmnNSq22MM=; b=EgnRhzm5BxEswLLtihvLUn73y1
	G2xofd5AR0y9nCllY9+WJp8QpNUt7bI6R/Qmd2E9tqYs1gssx9tqVF5Fz4bsvq7+/JH/uwH85dZPl
	SZK5ppHLbennavE0zzUcpjBarbVIpc/PFaRAXjryjUpmv6qVHc0DpRWUuKWAUlfP533/y1huYksUV
	kSRsR2vlysMO3s2Rc54+mgrXA+CoCJtX3rgar80wYAP06bHg9gR6O6PrmtbvXkR7LU+gITkUq50P4
	U8h/ljhxZ9Rw5I1/8O88fskfy29ejkT3mwlq5JR1R7QpkVNMnDFxKGaAejULtLy6Ve0WnmgIDY644
	LZpPxRkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r15ZR-007cAw-J9; Thu, 09 Nov 2023 13:59:45 +0000
Date: Thu, 9 Nov 2023 13:59:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Xie <jeff.xie@linux.dev>
Cc: akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
	cl@linux.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	chensong_2000@189.cn, xiehuan09@gmail.com
Subject: Re: [RFC][PATCH 1/4] mm, page_owner: add folio allocate post
 callback for struct page_owner to make the owner clearer
Message-ID: <ZUzl0U++a5fRpCQm@casper.infradead.org>
References: <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-2-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109032521.392217-2-jeff.xie@linux.dev>

On Thu, Nov 09, 2023 at 11:25:18AM +0800, Jeff Xie wrote:
> adding a callback function in the struct page_owner to let the slab layer or the
> anon/file handler layer or any other memory-allocated layers to implement what
> they would like to tell.

There's no need to add a callback.  We can tell what a folio is.

> +	if (page_owner->folio_alloc_post_page_owner) {
> +		rcu_read_lock();
> +		tsk = find_task_by_pid_ns(page_owner->pid, &init_pid_ns);
> +		rcu_read_unlock();
> +		ret += page_owner->folio_alloc_post_page_owner(page_folio(page), tsk, page_owner->data,
> +				kbuf + ret, count - ret);
> +	} else
> +		ret += scnprintf(kbuf + ret, count - ret, "OTHER_PAGE\n");

	if (folio_test_slab(folio))
		ret += slab_page_owner_info(folio, kbuf + ret, count - ret);
	else if (folio_test_anon(folio))
		ret += anon_page_owner_info(folio, kbuf + ret, count - ret);
	else if (folio_test_movable(folio))
		ret += null_page_owner_info(folio, kbuf + ret, count - ret);
	else if (folio->mapping)
		ret += file_page_owner_info(folio, kbuf + ret, count - ret);
	else
		ret += null_page_owner_info(folio, kbuf + ret, count - ret);

In this scenario, I have the anon handling ksm pages, but if that's not
desirable, we can add

	else if (folio_test_ksm(folio))
		ret += ksm_page_owner_info(folio, kbuf + ret, count - ret);

right before the folio_test_anon() clause

