Return-Path: <linux-fsdevel+bounces-63850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F184BCFD26
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 00:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19F074E2580
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC800234963;
	Sat, 11 Oct 2025 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ludl2j9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149F188580;
	Sat, 11 Oct 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760221244; cv=none; b=Waw1xg28jESFw1sIbZ+IlmcbzF+DK4cekK+F1wxTf9GY5rvFBtkAscyfBIhSEZi8Gyns3KVnDNjlxuHjIWNfm7m4IXcEA5Dnztc+ZYMJ8J/FwIuAl4wX2y7kGk57KbWLAVFSzqio2Uc1xTyWoPQIf0SQddY8BDAK+q7HTJHkiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760221244; c=relaxed/simple;
	bh=w0Ch1PGWYR23xW90AGLkDlnjd6lbrZwy3WsRV/8vBA8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RkkQUyRaJLx7AtboQRdoPxIiPJT7bWxI1Lleoe7n4qfJQHH5g5cfs7kSf4a95XPRf7N/xN08YexERVvVFAxX5SC2Op88WLsgdoLOhz3VqQazZ3Qga/9ezLVsTYdV9MU7XNcCIX/Fpo7ckCREUBlOKNgZejBTjPlg+Kzl7nPUvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ludl2j9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9B7C4CEF8;
	Sat, 11 Oct 2025 22:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760221243;
	bh=w0Ch1PGWYR23xW90AGLkDlnjd6lbrZwy3WsRV/8vBA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ludl2j9CJrXuKwLZOFb/fPXtjvs+n7WohU3N6xu4FM9F2oSlLwH5CjQWCbrEVUP19
	 kxBjbArvGOTSsKE9P6NihOL0TA51fwUPfveoh3k7YXyuFB9Te6Mydv8ktBc4Fi5WYV
	 XIvhyrraIZYLz45PXs8hLS74gM1b0RuQrA+49ECk=
Date: Sat, 11 Oct 2025 15:20:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, Nanhai
 Zou <nanhai.zou@intel.com>, Gang Deng <gang.deng@intel.com>, Tianyou Li
 <tianyou.li@intel.com>, Vinicius Gomes <vinicius.gomes@intel.com>, Tim Chen
 <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/readahead: Skip fully overlapped range
Message-Id: <20251011152042.d0061f174dd934711bc1418b@linux-foundation.org>
In-Reply-To: <6bcf9dfe-c231-43aa-8b1c-f699330e143c@linux.intel.com>
References: <20250923035946.2560876-1-aubrey.li@linux.intel.com>
	<20250922204921.898740570c9a595c75814753@linux-foundation.org>
	<93f7e2ad-563b-4db5-bab6-4ce2e994dbae@linux.intel.com>
	<cghebadvzchca3lo2cakcihwyoexx7fdqtibfywfm4xjo7eyp2@vbccezepgtoe>
	<6bcf9dfe-c231-43aa-8b1c-f699330e143c@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 13:35:43 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:

> file_ra_state is considered a performance hint, not a critical correctness
> field. The race conditions on file's readahead state don't affect the
> correctness of file I/O because later the page cache mechanisms ensure data
> consistency, it won't cause wrong data to be read. I think that's why we do
> not lock file_ra_state today, to avoid performance penalties on this hot path.
> 
> That said, this patch didn't make things worse, and it does take a risk but
> brings the rewards of RocksDB's readseq benchmark.

So if I may summarize:

- you've identifed and addressed an issue with concurrent readahead
  against an fd

- Jan points out that we don't properly handle concurrent access to a
  file's ra_state.  This is somewhat offtopic, but we should address
  this sometime anyway.  Then we can address the RocksDB issue later.

Alternatively, we could fix this issue right now and let the
concurrency fixes come later.  Not as pretty, but it's practical.

Another practicality: improving a benchmark is nice, but do we have any
reasons to believe that this change will improve any real-world
workload?  If so, which and by how much?


