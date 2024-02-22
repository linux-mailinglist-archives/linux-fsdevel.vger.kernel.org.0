Return-Path: <linux-fsdevel+bounces-12512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29686020C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8D62841EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9214B824;
	Thu, 22 Feb 2024 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wi0guPry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA114B803;
	Thu, 22 Feb 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628551; cv=none; b=aI535r4x1Rzn1D5oZ+a0lt1zLVueg8xl9jpVGLwuOeb9vh13b/R8fsdiVG3UxhekzuUsbh0Cw+6j8Ee7pjIv80XhkIEZjhrCLOl8k/kQuBMQPjpSsL6IehcrzrDwbBjhA6L0M8YI0oKh0NX/lcCWdnV+0OAhHxkWh075QWCyLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628551; c=relaxed/simple;
	bh=CyWrNEJOTduaLsfp/afgLhkUStrKX3T8j5ETszeVwW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFhtTqXs4loSrnao/fMbqGQzzA4O/f1aZsW130uK8n5XMt5IDElFZ1fqs9lE16XZIEd9BBhcs6k4+Fh9E//MX62yAAa3Ngphr79aDMDYLh/gkIRQmcUJLsk3VOZuGZ12o0JzzVEaLp1AUoWkmdJWDgMQ1Z6k+G0GCV2OHePA7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wi0guPry; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YCzvJZi0MIn/MC1Y9lAaG+iLw9IpGIZIgpDw63icD0g=; b=Wi0guPrypagKM5AyWUB9394kF3
	CFB6bUbQSvfLxajhjcmCeu7UuZP02tVovaF3blNETNVDWhHF+6o/5c6+RjokHzeL8mv5Nr7uEOfSm
	XQ+3BY6ac9/YkBaS7CF9NID8/0v5/vtnQtXaNTcFPb9JXScoKHZw4GD6coUUZ4WXOPkWG3K198JGu
	DjaUQAkdYCWmuQHJxPccl5Azh4D2YDIyqgrLfYUhsuadTX8E3y04HYjgisRh8Yop7+45G+O1wPQT9
	iCCW3QDg85QlcHZwCrwopX8rSc0jWaZvzYpUqoat0iH6KwLuPBQ1KL6kQo5E7Qv7pbWnWtTtHp61t
	XPpjjwOw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdEKu-00000006Ejv-0bd2;
	Thu, 22 Feb 2024 19:02:24 +0000
Date: Thu, 22 Feb 2024 11:02:24 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Yosry Ahmed <yosryahmed@google.com>, Chris Li <chrisl@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hugh Dickins <hughd@google.com>
Cc: David Howells <dhowells@redhat.com>, lsf-pc@lists.linux-foundation.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
Message-ID: <ZdeaQMDjsSmIRXHB@bombadil.infradead.org>
References: <2701740.1706864989@warthog.procyon.org.uk>
 <Zbz8VAKcO56rBh6b@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbz8VAKcO56rBh6b@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 02, 2024 at 02:29:40PM +0000, Matthew Wilcox wrote:
> So my modest proposal is that we completely rearchitect how we handle
> swap.  Instead of putting swp entries in the page tables (and in shmem's
> case in the page cache), we turn swap into an (object, offset) lookup
> (just like a filesystem).  That means that each anon_vma becomes its
> own swap object and each shmem inode becomes its own swap object.
> The swap system can then borrow techniques from whichever filesystem
> it likes to do (object, offset, length) -> n x (device, block) mappings.

What happened to Yosry or Chris's last year's pony [0]? In order to try
to take a stab at this we started with adding large folios to tmpfs,
which Daniel Gomez has taken on, as its a simple filesystem and with
large folios can enable us to easily test large folio swap support too.
Daniel first tried fixing lseek issue with huge pages [1] and on top of
that he has patches (a new RFC not posted yet) which do add large folios
support to tmpfs. Hugh has noted the lskeek changes are incorrect and
suggested instead a fix for the failed tests in fstests. If we get
agreement on Hugh's approach then we have a step forward with tmpfs and
later we hope this will make it easier to test swap changes.

Its probably then a good time to ask, do we have a list of tests for
swap to ensure we don't break things if we add large folio support?
We can at least start with a good baseline of tests for that.

[0] https://lwn.net/Articles/932077/
[1] https://lkml.kernel.org/r/20240209142901.126894-1-da.gomez@samsung.com

  Luis

