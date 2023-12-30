Return-Path: <linux-fsdevel+bounces-7038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC967820816
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 19:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A551C1C220FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793FCBA57;
	Sat, 30 Dec 2023 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OF+JWlNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD5BA37;
	Sat, 30 Dec 2023 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mg4NEAtlIdMJsQ3DLm6kXqa/wV+e7FCzKtuVzxdonAU=; b=OF+JWlNJMC8/3tu2Szw4PK/Ar0
	5ey8YqWRAtAv2ZPHLGNnOKWZ4kZqbPXaN6M6v1zEI7L2qPhhwfbR5fkYIF1577WQXcdwEqymggxga
	0LAMzWx+nLz27hbMyWfQWxtP+1ebGkRL2fHtJjFi0Tn9W2W0RmDHpkYlxfnmfofHR5HUeeozGAJRr
	N1H3Jl08EL9sE/e+0ZYmT+XvqIXMdwgv2XKLSmLhpj7CB1NhLCeAsylVYa1bFFrM5JK34wWIUwhIN
	kASApqY2fx2FjZyRUidkpOxyNJ4LM9U2ni7HI1LE5tJXUk6KIKabqeDRzBTJo+lsYwlLMgqP1IVVF
	etclSpgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rJdfK-007C9z-VU; Sat, 30 Dec 2023 18:02:31 +0000
Date: Sat, 30 Dec 2023 18:02:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Message-ID: <ZZBbNm5RRSGEDlqk@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>

On Sat, Dec 30, 2023 at 10:23:26AM -0500, Genes Lists wrote:
> Apologies in advance, but I cannot git bisect this since machine was
> running for 10 days on 6.6.8 before this happened.

Thanks for the report.  Apologies, I'm on holiday until the middle of
the week so this will be extremely terse.

>  - Root, efi is on nvme
>  - Spare root,efi is on sdg
>  - md raid6 on sda-sd with lvmcache from one partition on nvme drive.
>  - all filesystems are ext4 (other than efi).
>  - 32 GB mem.

> Dec 30 07:00:36 s6 kernel: ------------[ cut here ]------------
> Dec 30 07:00:36 s6 kernel: WARNING: CPU: 0 PID: 521524 at mm/page-writeback.c:2668 __folio_mark_dirty (??:?) 

This is:

                WARN_ON_ONCE(warn && !folio_test_uptodate(folio));

> Dec 30 07:00:36 s6 kernel: CPU: 0 PID: 521524 Comm: rsync Not tainted 6.6.8-stable-1 #13 d238f5ab6a206cdb0cc5cd72f8688230f23d58df

So rsync is exiting.  Do you happen to know what rsync is doing?

> Dec 30 07:00:36 s6 kernel: block_dirty_folio (??:?) 
> Dec 30 07:00:36 s6 kernel: unmap_page_range (??:?) 
> Dec 30 07:00:36 s6 kernel: unmap_vmas (??:?) 
> Dec 30 07:00:36 s6 kernel: exit_mmap (??:?) 
> Dec 30 07:00:36 s6 kernel: __mmput (??:?) 
> Dec 30 07:00:36 s6 kernel: do_exit (??:?) 
> Dec 30 07:00:36 s6 kernel: do_group_exit (??:?) 
> Dec 30 07:00:36 s6 kernel: __x64_sys_exit_group (??:?) 
> Dec 30 07:00:36 s6 kernel: do_syscall_64 (??:?) 

It looks llike rsync has a page from the block device mmaped?  I'll have
to investigate this properly when I'm back.  If you haven't heard from
me in a week, please ping me.

(I don't think I caused this, but I think I stand a fighting chance of
tracking down what the problem is, just not right now).

