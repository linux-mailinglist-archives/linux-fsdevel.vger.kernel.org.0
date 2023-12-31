Return-Path: <linux-fsdevel+bounces-7047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB8820B6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 14:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB027B21192
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49A98F67;
	Sun, 31 Dec 2023 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vd+WJ1ej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF58F49;
	Sun, 31 Dec 2023 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qgrieap/ole6x6jYsISD/ePi3BdA5BVA5GTXQ+NppF8=; b=vd+WJ1ejSpDkbMALMRIQ/s2vTl
	LL0gwyRqKsqKp8i+9VpptdcjB4juRO5y6b8zARSBmABKf8PGUAMle9KVhdTXYTf0Am/saSQXw04uU
	6FKKnvptyzbh+H/34h9ASMoZ9/1umfKgtOX/JXOJOScchowUFOR0tRuRao5DVTKh2Fy1AWQvpuz5K
	3FLRaIY25URYIf9cbU4DrsqLzrDYRc5T1JT9HKZFAzOhsA47apLLIhtJhj6zxqZc0i634KOliIqYg
	cdmqun3zNvB981cxyf71clmsF97kLsiBoyDdV+29moFlm6vtwuPtkcM185TGn/GRbXFMIK00u+C9F
	ed/sgQcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rJvWx-007p83-SY; Sun, 31 Dec 2023 13:07:03 +0000
Date: Sun, 31 Dec 2023 13:07:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Message-ID: <ZZFnd3tZZvg2eZun@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
 <20231231012846.2355-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231012846.2355-1-hdanton@sina.com>

On Sun, Dec 31, 2023 at 09:28:46AM +0800, Hillf Danton wrote:
> On Sat, Dec 30, 2023 at 10:23:26AM -0500 Genes Lists <lists@sapience.com>
> > Apologies in advance, but I cannot git bisect this since machine was
> > running for 10 days on 6.6.8 before this happened.
> >
> > Dec 30 07:00:36 s6 kernel: ------------[ cut here ]------------
> > Dec 30 07:00:36 s6 kernel: WARNING: CPU: 0 PID: 521524 at mm/page-writeback.c:2668 __folio_mark_dirty (??:?) 
> > Dec 30 07:00:36 s6 kernel: CPU: 0 PID: 521524 Comm: rsync Not tainted 6.6.8-stable-1 #13 d238f5ab6a206cdb0cc5cd72f8688230f23d58df
> > Dec 30 07:00:36 s6 kernel: block_dirty_folio (??:?) 
> > Dec 30 07:00:36 s6 kernel: unmap_page_range (??:?) 
> > Dec 30 07:00:36 s6 kernel: unmap_vmas (??:?) 
> > Dec 30 07:00:36 s6 kernel: exit_mmap (??:?) 
> > Dec 30 07:00:36 s6 kernel: __mmput (??:?) 
> > Dec 30 07:00:36 s6 kernel: do_exit (??:?) 
> > Dec 30 07:00:36 s6 kernel: do_group_exit (??:?) 
> > Dec 30 07:00:36 s6 kernel: __x64_sys_exit_group (??:?) 
> > Dec 30 07:00:36 s6 kernel: do_syscall_64 (??:?) 
> 
> See what comes out if race is handled.
> Only for thoughts.

I don't think this can happen.  Look at the call trace;
block_dirty_folio() is called from unmap_page_range().  That means the
page is in the page tables.  We unmap the pages in a folio from the
page tables before we set folio->mapping to NULL.  Look at
invalidate_inode_pages2_range() for example:

                                unmap_mapping_pages(mapping, indices[i],
                                                (1 + end - indices[i]), false);
                        folio_lock(folio);
                        folio_wait_writeback(folio);
                        if (folio_mapped(folio))
                                unmap_mapping_folio(folio);
                        BUG_ON(folio_mapped(folio));
                                if (!invalidate_complete_folio2(mapping, folio))

... and invalidate_complete_folio2() is where we set ->mapping to NULL
in __filemap_remove_folio -> page_cache_delete().


