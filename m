Return-Path: <linux-fsdevel+bounces-32384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EDD9A486A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 22:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73A51C21AC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE71718D625;
	Fri, 18 Oct 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XF+vlJ/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEFB186616
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284436; cv=none; b=a1yppTQiqA+JD5F8ZP8ZbTqs/I+jj10dSgXF1BVJeHBVuB0rzOpQctHI7xa4zPOAaTdVCnF1Z+Xny8NJ3R7CrUbtycZ3o80FnV6O5j8IYm3kmCMOHkkBIxpuFgnOk1bTFG/+6HBSzEpJg933t04U1pjTXgmb6RQOCOkNy9U0d48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284436; c=relaxed/simple;
	bh=nKg2hj4JPhuF7GYC8K9cjvS75IRmIG0Ho8HOQgiJ0gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAIuvVlJ+NGrWcF2ByuG3/pwnHsGnJAoa87hX/WfkT7PKGw7Q723Dat55pg7yoms2XF5DtucMGN6yb19hfihjUtT+q4zqStRCNHUDVypbZ3FJEqW6A6jQkqA3t3UP+7hU3Nb3aSOaMMDBvWU6UtTSMwDbYvblW5jMAg9l6rYOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XF+vlJ/M; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Oct 2024 13:46:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729284426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jogk9aVfGbN67BqEX3ZruxXbBFHssSEgAJ8XnBDsh/g=;
	b=XF+vlJ/MxwUXhUCbu7t5mcDOouWtUSQ3N5r5BeanIj5PJzk6sXvU/yTx0y3+OCtnyHDtNa
	dqPzfWAS1lHRHxQVgXgHmn7WV76vUDD1X/JyHUvV0ZsdOVNEg6nKqZjUyRHjgm+P1FdRuo
	Rn96/yoJTGRu5Tc/JhBetWmjs1lxwPU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <5wgtyqxkmxr5vrcfksgv4mrrgxmuqmu5z3glgasb6nxxw4metr@c56mvtzeph2x>
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1bByc+qJTAvfJZxp5=o=N8EdgKWxQN-jWOW8Rv-PZMZRA@mail.gmail.com>
 <tbkfwtebn4l46cnwoqrf2cm7e5r5ndy7zj2bvdnk4n2q7yk5xh@gmno3qfufaur>
 <CAJnrk1ak-rVG2tthwkNd-PPVD6hVH_Vczye1Z2OYfvtDLiZEFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ak-rVG2tthwkNd-PPVD6hVH_Vczye1Z2OYfvtDLiZEFg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 18, 2024 at 12:57:08PM GMT, Joanne Koong wrote:
> On Thu, Oct 17, 2024 at 10:57 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Oct 17, 2024 at 06:30:08PM GMT, Joanne Koong wrote:
> > > On Tue, Oct 15, 2024 at 3:01 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Mon, 14 Oct 2024 at 20:23, Joanne Koong <joannelkoong@gmail.com> wrote:
> > > >
> > > > > This change sets AS_NO_WRITEBACK_RECLAIM on the inode mapping so that
> > > > > FUSE folios are not reclaimed and waited on while in writeback, and
> > > > > removes the temporary folio + extra copying and the internal rb tree.
> > > >
> > > > What about sync(2)?   And page migration?
> > > >
> > > > Hopefully there are no other cases, but I think a careful review of
> > > > places where generic code waits for writeback is needed before we can
> > > > say for sure.
> > >
> > > The places where I see this potential deadlock still being possible are:
> > > * page migration when handling a page fault:
> > >      In particular, this path: handle_mm_fault() ->
> > > __handle_mm_fault() -> handle_pte_fault() -> do_numa_page() ->
> > > migrate_misplaced_folio() -> migrate_pages() -> migrate_pages_sync()
> > > -> migrate_pages_batch() -> migrate_folio_unmap() ->
> > > folio_wait_writeback()
> >
> > So, this is numa fault and if fuse server is not mapping the fuse folios
> > which it is serving, in its address space then this is not an issue.
> > However hugepage allocation on page fault can cause compaction which
> > might migrate unrelated fuse folios. So, fuse server doing compaction
> > is an issue and we need to resolve similar to reclaim codepath. (Though
> > I think for THP it is not doing MIGRATE_SYNC but doing for gigantic
> > hugetlb pages).
> 
> Thanks for the explanation. Would you mind pointing me to the
> compaction function where this triggers the migrate? Is this in
> compact_zone() where it calls migrate_pages() on the cc->migratepages
> list?
> 

Something like the following:

__alloc_pages_direct_compact() ->
try_to_compact_pages() ->
compact_zone_order() -> /* MIGRATE_ASYNC or MIGRATE_SYNC_LIGHT */
compact_zone() ->
migrate_pages() ->
migrate_pages_sync() ->
migrate_pages_batch() ->
migrate_folio_unmap() ->
folio_wait_writeback()


The following is one code path from hugetlb:

alloc_contig_range_noprof() -> /* MIGRATE_SYNC */
__alloc_contig_migrate_range() ->
migrate_pages() ->
migrate_pages_sync() ->
migrate_pages_batch() ->
migrate_folio_unmap() ->
folio_wait_writeback()


