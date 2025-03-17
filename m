Return-Path: <linux-fsdevel+bounces-44225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EC3A66196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 23:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A0B189652D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608719D081;
	Mon, 17 Mar 2025 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lnqQ8GWQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FD1EB5F0
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250611; cv=none; b=YUlylBFfUbaNwbsU+KFijr+bIO6D8YD4NE1ueRdH2D1lQGqA1+qNsAl0Ugl4zWidG1GySMsROlmyIEwfXL/1FimiAMiIU2EN6FNnt/Y4JN/c5ImtHstfLs44O208FVBmQW0ye7dzIJRqWyUsMSpnaCBHMV/DmaeyA14u13a0D2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250611; c=relaxed/simple;
	bh=Rmlk9kmUZVdqcCbrsjOU7sRJoUx9ZamFBeSNQknldEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBFd00w1JMAE1rIRRt9dIH2UjLGYW62035ltb75B1VGfn8TVwlReDdt2s4yqffjG+riSEwxxx66CwTJtCAzM4kIaflxxX6K/PFPy1xinhHUDIG+nppLp90Rtpu+TDTU408bN9WDURlUv5b7BXEK2GZ5kgoeC9zvzjptffiyrh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lnqQ8GWQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=j5kfpSpCW3Y67C0StqdtkYxDyNl1nfMhxEJXQKT31Zo=; b=lnqQ8GWQJPuTHf0POXM4ZAutD3
	JO3eo1JAyCPUoWQLx5ExFjSN8D8EGfJcU6wdjr01FhiDe3p6f88sNLY1fnPaPUBfz2Zq5R/TDTs7E
	2MOu2txj7EzeNRp7sZaCr4USvP3iJJCWjri8hRHVG2vb3yC91F3Ai4SHuyJSR5RizmcKcYdStTKGE
	Rq/JG6IIZ1WcJWh/fHEksb8Aoqdxaz3Q2A8fpmxq7Rys8oE83FTcdMVJJxAjCrXLGLdZvDHZ9iRby
	0xQAQTktKcm1jIgBjuOu8xB0we1L6ivbHyrhDYdVPbYJDqTXrBScXqVGXO7IvXxua+5wNYKJCGZ8c
	nQg4YOfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuIyD-0000000A0Ax-2frk;
	Mon, 17 Mar 2025 22:30:05 +0000
Date: Mon, 17 Mar 2025 22:30:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Fan Ni <nifan.cxl@gmail.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 11/11] fs: Remove aops->writepage
Message-ID: <Z9iibbHs-jHTu7LP@casper.infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
 <20250307135414.2987755-12-willy@infradead.org>
 <Z9d2JH33sLeCuzfE@fan>
 <Z9eVdplZKs2XVB9J@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9eVdplZKs2XVB9J@casper.infradead.org>

On Mon, Mar 17, 2025 at 03:22:30AM +0000, Matthew Wilcox wrote:
> On Sun, Mar 16, 2025 at 06:08:52PM -0700, Fan Ni wrote:
> > On Fri, Mar 07, 2025 at 01:54:11PM +0000, Matthew Wilcox (Oracle) wrote:
> > > All callers and implementations are now removed, so remove the operation
> > > and update the documentation to match.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > 
> > Hi Matthew,
> > 
> > Tried to apply the remaining patches in the patchest (Patch 5-11)  which
> > have not picked up by linux-next. It seems we have more to cleanup.
> > 
> > For example, I hit the following issue when try to compile
> > ----------------------------------------------------------------
> > drivers/gpu/drm/ttm/ttm_backup.c: In function ‘ttm_backup_backup_page’:
> > drivers/gpu/drm/ttm/ttm_backup.c:139:39: error: ‘const struct address_space_operations’ has no member named ‘writepage’; did you mean ‘writepages’?
> >   139 |                 ret = mapping->a_ops->writepage(folio_file_page(to_folio, idx), &wbc);
> 
> Looks like that was added to linux-next after I completed the removal of
> ->writepage.  Thomas, what's going on here?

This patch fixes the compilation problem.  But I don't understand why
it's messing with the reclaim flag.  Thomas, can you explain?

+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -136,13 +136,13 @@ ttm_backup_backup_page(struct ttm_backup *backup, struct page *page,
                        .for_reclaim = 1,
                };
                folio_set_reclaim(to_folio);
-               ret = mapping->a_ops->writepage(folio_file_page(to_folio, idx), &wbc);
+               ret = shmem_writeout(to_folio, &wbc);
                if (!folio_test_writeback(to_folio))
                        folio_clear_reclaim(to_folio);
                /*
-                * If writepage succeeds, it unlocks the folio.
-                * writepage() errors are otherwise dropped, since writepage()
-                * is only best effort here.
+                * If writeout succeeds, it unlocks the folio.  errors
+                * are otherwise dropped, since writeout is only best
+                * effort here.
                 */
                if (ret)
                        folio_unlock(to_folio);


