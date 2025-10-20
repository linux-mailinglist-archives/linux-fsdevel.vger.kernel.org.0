Return-Path: <linux-fsdevel+bounces-64672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5BBF05BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8618A06D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A752EC55D;
	Mon, 20 Oct 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5ssFmka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79263A930;
	Mon, 20 Oct 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954444; cv=none; b=bBpVvxZ/ioc6XOaYGHCNDxdBjI0wyIk43qcXL/9QvIL/rcaqutvNS6DH9ii3MUF/arA8cRjs2DKalCpCY7Oq38xKICOuj591QIi4i7U0ccn5Nl9Cus58t589iELAXJ73oK2vSavL/8SzSYukOnOtzl2NxZFT5XNOHIeg0DeatR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954444; c=relaxed/simple;
	bh=IrIP5sR8h20sh5eamOa17g5Ykn369L19kLt2nSQqlcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WohgS2gS4mBKzXoPOw7/IeMQsZiyQdAjhhsTJsSsCgz6xcHFpnBSPvQ1e2yt0SpB7o29ZigbHJ+iDAzIUAzSBq/2EvSeWykl2sIYIRV925NcJG4whxa9cJoFMgcVRs0HTutliSzDNuU2Rku+lJKzVvDv4QJdYRaSs506gD4JJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5ssFmka; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=6vPGsipqewFH0An8fbqPgnRT3TdYk8QOTnwKOAIuU2w=; b=g5ssFmkaJ1VQXeJw/jurNQB9hF
	NmA72962DCoxCCFbk7cJHkSN8364lgsT3N+hE1YOCM+UQHysCTs3oy4M1RY7HpT3xQJW4TirD3v5j
	Ckd46sg/3xxBJ9rFAyf2HU9/ZWQE+gIxn3T6D37gJstgLfXXoDeWidqtaV5FHFnMNGqhMwNJPkOR0
	pXaEAeAnzwmswGB68QSou16iHjnLFBmv0zc1gHclJ7I0p2JfQUM/8CWlgx09HNHHZplH5O+J7EJ7G
	ou/fQrD3j5eVqwZnxeVLfJS4tY3FJ7mCT6HsOEAPC6NRuwa70CTC9O9RIIM5wepN7xypSWGoy4NSe
	6DFBFEyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAmh1-0000000ChTZ-0C3R;
	Mon, 20 Oct 2025 10:00:43 +0000
Date: Mon, 20 Oct 2025 03:00:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	martin.petersen@oracle.com, jack@suse.com
Subject: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <aPYIS5rDfXhNNDHP@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 07:49:50PM +1030, Qu Wenruo wrote:
> There is a bug report about that direct IO (and even concurrent buffered
> IO) can lead to different contents of md-raid.

What concurrent buffered I/O?

> It's exactly the situation we fixed for direct IO in commit 968f19c5b1b7
> ("btrfs: always fallback to buffered write if the inode requires
> checksum"), however we still leave a hole for nodatasum cases.
> 
> For nodatasum cases we still reuse the bio from direct IO, making it to
> cause the same problem for RAID1*/5/6 profiles, and results
> unreliable data contents read from disk, depending on the load balance.
> 
> Just do not trust any bio from direct IO, and never reuse those bios even
> for nodatasum cases. Instead alloc our own bio with newly allocated
> pages.
> 
> For direct read, submit that new bio, and at end io time copy the
> contents to the dio bio.
> For direct write, copy the contents from the dio bio, then submit the
> new one.

This basically reinvents IOCB_DONTCACHE I/O with duplicate code?

> Considering the zero-copy direct IO (and the fact XFS/EXT4 even allows
> modifying the page cache when it's still under writeback) can lead to
> raid mirror contents mismatch, the 23% performance drop should still be
> acceptable, and bcachefs is already doing this bouncing behavior.

XFS (and EXT4 as well, but I've not tested it) wait for I/O to
finish before allowing modifications when mapping_stable_writes returns
true, i.e., when the block device sets BLK_FEAT_STABLE_WRITES, so that
is fine.  Direct I/O is broken, and at least for XFS I have patches
to force DONTCACHE instead of DIRECT I/O by default in that case, but
allowing for an opt-out for known applications (e.g. file or storage
servers).

I'll need to rebase them, but I plan to send them out soon together
with other T10 PI enabling patches.  Sorry, juggling a few too many
things at the moment.

> But still, such performance drop can be very obvious, and performance
> oriented users (who are very happy running various benchmark tools) are
> going to notice or even complain.

I've unfortunately seen much bigger performance drops with direct I/O and
PI on fast SSDs, but we still should be safe by default.

> Another question is, should we push this behavior to iomap layer so that other
> fses can also benefit from it?

The right place is above iomap to pick the buffered I/O path instead.

The real question is if we can finally get a version of pin_user_pages
that prevents user modifications entirely.


