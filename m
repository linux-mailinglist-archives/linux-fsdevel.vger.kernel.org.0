Return-Path: <linux-fsdevel+bounces-9294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B98283FD3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 05:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC291C229C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 04:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FA63C6B9;
	Mon, 29 Jan 2024 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WLe6nUl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7E3C47A;
	Mon, 29 Jan 2024 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706502733; cv=none; b=SZr5c9EyMtrq7X3NcWzWK3p8fhwy+lAhf1Vm4c2mwGvs/ePYzRTxMJYJ1wbYkyISwj7rwnlFLn9DP1F/pckqhcvnq2J6/7Cti8bpQZRfP1E/tR4wJdrwCHC14O+Mxd+t6KuxzAFtZsI52R+Hsoadx81qoyHE3aYCbQpZUYmHVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706502733; c=relaxed/simple;
	bh=vnBCw+VEsZoMU7uXPkz67lpbjtbkGDarP0i7dAApyj4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NhBXoMBjM73xUg9IjM1tpSs8RzrpyvaUCLwDLFyesSA0HAaN+Pn5Cit6qzT5mUS2MspY0Q6biT7v1/FNtCtNAYrY749gtQOAD1dbAngqjqlKEU0zcv9d47T/7AoqiuqcQAgltrLjYBt/9qW9obQPDfZkXgBXyXYVETVMtEjzzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WLe6nUl3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=H8WTJ8NBmRpbZtf94nTTt/tZUYzTLnihYXaoQXGtdRA=; b=WLe6nUl3NiNOhbZzoHeryOF0bU
	P5+xpXLngxxGVebSFsePFiFuI/Tje4zs+Zsk0N8ZJB99kB7M5AanK0s0NzdnlE8eRw+vuYTO7UKYw
	GuYzR0j2zpvVPfRPNwSJ1JNVPTbd4KlXaXcLyUpbS/AMy938NTCRo8+GPJ0oE76c4XVH6RPNdXt+I
	FaQFBumBWxrEMciRiP6PwVK8WLIHygrOro+u9TQHSSK0waUD4WD+doKz2NHNFX8a9pmVRw7vlEcW3
	CE1Deh9g/lgotxHlH9x9TsKC402E2Ze1tzLTttiJTWI+L055MOwTe4bpnXfM80IRGtNESiLNW5uVB
	t24sKqEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUJJT-00000005VPu-4AB6;
	Mon, 29 Jan 2024 04:32:04 +0000
Date: Mon, 29 Jan 2024 04:32:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Our documentation of the current page flags is ... not great.  I think
I can improve it for the page cache side of things; I understand the
meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
has_hwpoisoned, hugetlb and large_remappable.

Where I'm a lot more shaky is the meaning of the more "real MM" flags,
like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
unevictable, young, idle, swapcache, isolated, and reported.

Perhaps we could have an MM session where we try to explain slowly and
carefully to each other what all these flags actually mean, talk about
what combinations of them make sense, how we might eliminate some of
them to make more space in the flags word, and what all this looks like
in a memdesc world.

And maybe we can get some documentation written about it!  Not trying
to nerd snipe Jon into attending this session, but if he did ...

[thanks to Amir for reminding me that I meant to propose this topic]

