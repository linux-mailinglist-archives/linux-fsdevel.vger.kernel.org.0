Return-Path: <linux-fsdevel+bounces-27274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3A795FFC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BE61F22C4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C73232;
	Tue, 27 Aug 2024 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i8xcbSD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3E1805E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729400; cv=none; b=lHQMJECMtpzzZrVS13DAyTFK9CQ41RA0SiirMjwvEK0QnABGJBWURH3wDKxhYir1ym3bxmS3BNCLF8rr895k6B/M/tNpgtYJlJQ/ffANdtRJnB/1GLGAiYDZrPSG+dLf/1Aq7//M6uwnFLM30YoVKYy+oBRoRpxT9uFcSffL2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729400; c=relaxed/simple;
	bh=WKIOaTG/O7gm+4/VSs3liOn/sNcWabSkU8R9R2Wzwc4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BiNqCpgWKDKmZbJWnpwsMvqxRq9DqqiZdVCtoNnX/qSsr0vjG+YgZzULzFSMAeeUWhbKkllC/7QdPfLqvkV+j4mUJTPs9Hp1uXwWfPrcUQoqAfOCyAWzATC8dLHlUOmW7c/NEhIY1Yb+/NJBJJJPeQM16WFsAcfsXes1stzHKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i8xcbSD1; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 23:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724729396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=WKIOaTG/O7gm+4/VSs3liOn/sNcWabSkU8R9R2Wzwc4=;
	b=i8xcbSD1ASqsUiZOK46wyT2H2y2KvX+yFJtQNePtQ8Jhn/SeA770yXrIrhJdqoP9xMD2qC
	DISxxYz1yd34hv1DRkXqrnKCS+gNxCY/JwgpU6yYnllUYTLfiaKvLLoo35WY+ECvHo0DWR
	+zAXU9wG/OplzgB1NY2W3hNLUH3afng=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org
Subject: bcachefs dropped writes with lockless buffered io path,
 COMPACTION/MIGRATION=y
Message-ID: <ieb2nptxxk2apxfijk3qcjoxlz5uitsl5jn6tigunjmuqmkrwm@le74h3edr6oy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

We had a report of corruption on nixos, on tests that build a system
image, it bisected to the patch that enabled buffered writes without
taking the inode lock:

https://evilpiepirate.org/git/bcachefs.git/commit/?id=7e64c86cdc6c

It appears that dirty folios are being dropped somehow; corrupt files,
when checked against good copies, have ranges of 0s that are 4k aligned
(modulo 2k, likely a misaligned partition).

Interestingly, it only triggers for QEMU - the test fails pretty
consistently and we have a lot of nixos users, we'd notice (via nix
store verifies) if the corruption was more widespread. We believe it
only triggers with QEMU's snapshots mode (but don't quote me on that).

Further digging implicates CONFIG_COMPACTION or CONFIG_MIGRATION.

Testing with COMPACTION, MIGRATION=n and TRANSPARENT_HUGEPAGE=y passes
reliably.

On the bcachefs side, I've been testing with that patch reduced to just
"don't take inode lock if not extending"; i.e. killing the fancy stuff
to preserve write atomicity. It really does appear to be "don't take
inode lock -> dirty folios get dropped".

It's not a race with truncate, or anything silly like that; bcachefs has
the pagecache add lock, which serves here for locking vs. truncate.

So - this is a real head scratcher. The inode lock really doesn't do
much in IO paths, it's there for synchronization with truncate and write
vs. write atomicity - the mm paths know nothing about it. Page
fault/mkwrite paths don't take it at all; a buffered non-extending write
should be able to work similarly: the folio lock should be entirely
sufficient here.

Anyone got any bright ideas?

