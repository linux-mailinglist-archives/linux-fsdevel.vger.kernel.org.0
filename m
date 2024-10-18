Return-Path: <linux-fsdevel+bounces-32300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40029A34E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8C31F24CC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC2D17DE36;
	Fri, 18 Oct 2024 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eJmcIDdi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08E914A09A
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231083; cv=none; b=MFw+oDIf5WkBmvoLQ2r0OUmeQITiLtV3T2WWd3nHqpMcBlPcshaM8VS/59xVPYDipHz2E+NSJTMiXwjsVjlOKb/V3t3KH9CIBGgmL+AeIDzZsvw2MsqxJ4ebqKdUuUvKw8xa4LrkNr3zA+2+fk8LFkS2DJGJkNUj7S1rNGzT/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231083; c=relaxed/simple;
	bh=swujssL8xBD9AmB8XeJlLuvcvUoXOB7R222POxt/WqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfLlfl+25gGjf7kVzKSegdwJSc3EbyGWxcYPN1agKPMg5IWhTsdtbJ1k514FNHXdHT46knEJn2Uj3yAaXUNqR4VR3LAyqjwfdqnF4eVW2wel1e1n2KkdiDRaQNiUbelIIBI0vH1EpGVCWXlvPH0z2YirNFOI4UwBIuXm5mabCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eJmcIDdi; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Oct 2024 22:57:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729231077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WiHxI2A8L7DxDjwomZoUbDGNWSprCSLc9WDB3DW9+s=;
	b=eJmcIDdiVcz8oEbJo4MVQLFPPqYmQ5zcE7ThCnNzyf1/o/ei99DRbEibCE7e3oKDJjIRcV
	bz4kNh7mNuyMQiXXaDypKmLfov6HhDoaMEC1cLxcX9hEIWD7/wa42lJM4NWUsQ28oksQ0S
	QfhCVbOKk9gNoazIe37Nj24NetQVjNs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <tbkfwtebn4l46cnwoqrf2cm7e5r5ndy7zj2bvdnk4n2q7yk5xh@gmno3qfufaur>
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1bByc+qJTAvfJZxp5=o=N8EdgKWxQN-jWOW8Rv-PZMZRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bByc+qJTAvfJZxp5=o=N8EdgKWxQN-jWOW8Rv-PZMZRA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 17, 2024 at 06:30:08PM GMT, Joanne Koong wrote:
> On Tue, Oct 15, 2024 at 3:01 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 14 Oct 2024 at 20:23, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > > This change sets AS_NO_WRITEBACK_RECLAIM on the inode mapping so that
> > > FUSE folios are not reclaimed and waited on while in writeback, and
> > > removes the temporary folio + extra copying and the internal rb tree.
> >
> > What about sync(2)?   And page migration?
> >
> > Hopefully there are no other cases, but I think a careful review of
> > places where generic code waits for writeback is needed before we can
> > say for sure.
> 
> The places where I see this potential deadlock still being possible are:
> * page migration when handling a page fault:
>      In particular, this path: handle_mm_fault() ->
> __handle_mm_fault() -> handle_pte_fault() -> do_numa_page() ->
> migrate_misplaced_folio() -> migrate_pages() -> migrate_pages_sync()
> -> migrate_pages_batch() -> migrate_folio_unmap() ->
> folio_wait_writeback()

So, this is numa fault and if fuse server is not mapping the fuse folios
which it is serving, in its address space then this is not an issue.
However hugepage allocation on page fault can cause compaction which
might migrate unrelated fuse folios. So, fuse server doing compaction
is an issue and we need to resolve similar to reclaim codepath. (Though
I think for THP it is not doing MIGRATE_SYNC but doing for gigantic
hugetlb pages).

> * syscalls that trigger waits on writeback, which will lead to
> deadlock if a single-threaded fuse server calls this when servicing
> requests:
>     - sync(), sync_file_range(), fsync(), fdatasync()
>     - swapoff()
>     - move_pages()
> 
> I need to analyze the page fault path more to get a clearer picture of
> what is happening, but so far this looks like a valid case for a
> correctly written fuse server to run into.
> For the syscalls however, is it valid/safe in general (disregarding
> the writeback deadlock scenario for a minute) for fuse servers to be
> invoking these syscalls in their handlers anyways?
> 
> The other places where I see a generic wait on writeback seem safe:
> * splice, page_cache_pipe_buf_try_steal() (fs/splice.c):
>    We hit this in fuse when we try to move a page from the pipe buffer
> into the page cache (fuse_try_move_page()) for the SPLICE_F_MOVE case.
> This wait seems fine, since the folio that's being waited on is the
> folio in the pipe buffer which is not a fuse folio.
> * memory failure (mm/memory_failure.c):
>    Soft offlining a page and handling page memory failure - these can
> be triggered asynchronously (memory_failure_work_func()), but this
> should be fine for the fuse use case since the server isn't blocked on
> servicing any writeback requests while memory failure handling is
> waiting on writeback
> * page truncation (mm/truncate.c):
>    Same here. These cases seem fine since the server isn't blocked on
> servicing writeback requests while truncation waits on writeback
> 
> 
> Thanks,
> Joanne
> 
> >
> > Thanks,
> > Miklos

