Return-Path: <linux-fsdevel+bounces-11099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E08510B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F0C1F2266F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB218624;
	Mon, 12 Feb 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cU4TXmjb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE221B273;
	Mon, 12 Feb 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733469; cv=none; b=gNzRYnBl/3XMjT/hcywxLONmnxEfBUYS5eVMDS1QYZq/XJz3HtQnZVGZ2v2SFs07Nq2pDAXSJ75g8QtwOnmvKSBW8m+X2ssr+Nk8F5y7iAneDY5AEx18U2ct9JvIx+fnVwQtUF25OTJBAEbBE8+YNv/HRCoTENHVfCUP+GXDUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733469; c=relaxed/simple;
	bh=/IkSyB87unJUMSt0t7EdxVIcPTv7ssGTsQqsknTFmlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+uEu6+DM3xkIITz60myBUYuZD+f0Ze0hkMfRlFG5XkbiOVTc51JDLuFLYwAj4gYq5hDN0dBax+nwcaX3QYsPMTSQSvRURwpTZZNSpIH2jjOVhLm0GhZVy/HUYAdEG1rXkq+hSIGapItyF0lUU3SfehxDVtssxceLD/6w/ypsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cU4TXmjb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rjQFj2Y3qw5mwmHLRiMU4jGR0CXRoHG5WfGG9b74Q3A=; b=cU4TXmjbQ8YvfC7Gfc1RedGceJ
	Nj46EdFUx5xoSvev+Uh4BQgqZ9PYjSYA8R+mWQItKpbzvniRq5InhuKK62Z+U/1jKU0tqDl3g278M
	fuPxpYzV934A1mAgdh6elHtOrQCPkkd0WuvYIFGyWupR4VzF5bGOuYhJvWrB1dUCgcjCEkOGFdY2k
	mDsG0ROIYyWy/9lD43cV2s4vO9UAldXJvp3WeXE1oTwki+pqrdahMa5w5QLzSZcUROEhiLjl14anp
	RWz39xL4+AD/11nI7O0Ni8kvXrWei6D76bGYnVBQQQQ/RmAHUEGWYu3GffRIfh85bD3WJ7t5sz7UE
	TsLNwc6g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTU6-0000000Adzq-18Cf;
	Mon, 12 Feb 2024 10:24:22 +0000
Date: Mon, 12 Feb 2024 10:24:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v3 00/26] ext4: use iomap for regular file's buffered
 IO path and enable large foilo
Message-ID: <Zcnx1pP_iZBf6Y-t@casper.infradead.org>
References: <20240212061842.GB6180@frogsfrogsfrogs>
 <87ttmef3fp.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttmef3fp.fsf@doe.com>

On Mon, Feb 12, 2024 at 02:46:10PM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> > though iirc willy never got the performance to match because iomap
> 
> Ohh, can you help me provide details on what performance benchmark was
> run? I can try and run them when I rebase.

I didn't run a benchmark, we just knew what would happen (on rotating
storage anyway).

> > didn't have a mechanism for the caller to tell it "run the IO now even
> > though you don't have a complete page, because the indirect block is the
> > next block after the 11th block".
> 
> Do you mean this for a large folio? I still didn't get the problem you
> are referring here. Can you please help me explain why could that be a
> problem?

A classic ext2 filesystem lays out a 16kB file like this (with 512
byte blocks):

file offset	disk block
0-6KiB		1000-1011
6KiB-16KiB	1013-1032

What's in block 1012?  The indirect block!  The block which tells ext2
that blocks 12-31 of the file are in disk blocks 1013-1032.  So we can't
issue the read for them until we've finished the read for block 1012.

Buffer heads have a solution for this, BH_Boundary.  ext2 sets it for
block 11 which prompts mpage.c to submit the read immediately (see
the various calls to buffer_boundary()).  Then ext2 will submit the read
for block 1012 and the two reads will be coalesced by the IO scheduler.
So we still end up doing two reads instead of one, but that's
unavoidable because fragmentation might have meant that 6KiB-16KiB were
not stored at 1013-1032.

There's no equivalent iomap solution.  What needs to happen is:

 - iomap_folio_state->read_bytes_pending needs to be initialised to
   folio_size(), not 0.
 - Remove "ifs->read_bytes_pending += plen" from iomap_readpage_iter()
 - Subtract plen in the iomap_block_needs_zeroing() case
 - Submit a bio at the end of each iomap_readpage_iter() call

Now iomap will behave the same way as mpage, only without needing a
flag to do it (instead it will assume that the filesystem coalesces
adjacent ranges, which it should do anyway for good performance).

