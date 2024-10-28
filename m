Return-Path: <linux-fsdevel+bounces-33042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68859B2A8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0993B21129
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3021922CD;
	Mon, 28 Oct 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x3TXW5jz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VQAr2k4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D03617CA1B;
	Mon, 28 Oct 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104913; cv=none; b=VjToIdT5wkpJHVUNG9A75zKdXjyMEVXPt5e569+bpTMKpIQza/7HuyNRsNfNa6iO612ywNo25F9fEJIEERRIq2uSLJ4467pBEi037WN+rYMzMF8sofD9//YiQbJI/uaXykznXbM1vE72ILZkDfnIVhj7o3p20AgZtY4OpufgnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104913; c=relaxed/simple;
	bh=KTIfXUdYAvpwso49g1yYWYsZv6RvufQJe+aCEFcGvJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VnSLucdwAyS3PRlBF16+LTzRpI4DJkzBSWUdJNZjrdSHvB4mAZJGeWvjH1WyJlWbTK+APld7EWiYhcNSUUXbI5T7izHPbcNEOJdI+YcrjPsk8qFpoYTbf+oVzkYl+WicmYk+13Ml9uZ7bVptZesCRMwzV4sAo8QpuJ0deV6O2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x3TXW5jz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VQAr2k4I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730104909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1H44vgesP1XQXrv9CcIfmLIuQ+1Lb7UWNVl5j+TBJ08=;
	b=x3TXW5jzTZtadCH2BFHWSDUQsinXPlK0IrDDFRy/3tNQK0hzy3RehZqmDb5+LDPS5kOzQc
	sjnMxY5k25sQYGXLGYjtF6Teg3B84jy/bMViihmY1+l351ebf71jlbT5IqfVe40dQneeB3
	vKETQHeiYHoTnMEQ4/E9gkHBCmVSG0H21a4FRwH9RLTNgC4pNPkvjcWbza9iOzYXpTcOb6
	NKB13JlaGMBXliD2Dq9Na5nEvaPDkQYWh7KYhQShbbhXtic1cULYTlUI4tJPwgU550RGvk
	lUPOTglWIlyyGcXjEuR58wOsJ4hJd0Zpv72EbpMDTC6edTBiAM+tatV4FIUG1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730104910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1H44vgesP1XQXrv9CcIfmLIuQ+1Lb7UWNVl5j+TBJ08=;
	b=VQAr2k4I06KdONU7UIdNQErDeF0PPVIHebz4hNbPiOnA40OILCuO/XnqUe/puyjjeB+a6q
	D8khm6vUYCuFTgCQ==
To: Hugh Dickins <hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Brauner
 <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Christoph
 Hellwig <hch@lst.de>, Kent Overstreet <kent.overstreet@linux.dev>,
 "Darrick J. Wong" <djwong@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() if
 KMAP_LOCAL_FORCE_MAP
In-Reply-To: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com>
References: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com>
Date: Mon, 28 Oct 2024 09:41:48 +0100
Message-ID: <874j4w4o1f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 27 2024 at 15:23, Hugh Dickins wrote:
> generic/077 on x86_32 CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y with highmem,
> on huge=always tmpfs, issues a warning and then hangs (interruptibly):
>
> WARNING: CPU: 5 PID: 3517 at mm/highmem.c:622 kunmap_local_indexed+0x62/0xc9
> CPU: 5 UID: 0 PID: 3517 Comm: cp Not tainted 6.12.0-rc4 #2
> ...
> copy_page_from_iter_atomic+0xa6/0x5ec
> generic_perform_write+0xf6/0x1b4
> shmem_file_write_iter+0x54/0x67
>
> Fix copy_page_from_iter_atomic() by limiting it in that case
> (include/linux/skbuff.h skb_frag_must_loop() does similar).
>
> But going forward, perhaps CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is too
> surprising, has outlived its usefulness, and should just be removed?

It has caught real problems and as long as we have highmem support, it
should stay IMO to provide test coverage.

Thanks,

        tglx



