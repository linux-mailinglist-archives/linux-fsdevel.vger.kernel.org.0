Return-Path: <linux-fsdevel+bounces-48505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF39AB0439
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54994E3A2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 19:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E32A28A73F;
	Thu,  8 May 2025 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G/HNkgA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060B288C23
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734361; cv=none; b=kks3mBJfAPBxvcYW9zAtF9tLNBr3dYC972FwLLJPUAbaB0d/DKPdFDNmJ6+OB3gaAWO5Jh3XSFemmhpzAnBBwUwoS2ny8dKe/xxAmUn6YRO5eDa6C1JnpVQTzytuwNI1QjNaTAsEQJZD8BBXb66l1yGnOgesYQgkXfk68vR/LUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734361; c=relaxed/simple;
	bh=2z4khigyoAhC5KNlPeu+YZs6YzfxwiQWR2tgE/Ov2C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCof9xtvDu3ITHY1YIxhv6th+sVjs58PQBXODqAp7zHvJLW/YY9yU5KTMiCV23L+koaveV048fB0IeFK2+Vbhw6OQ2dwNLJtSEeYzr+6Khye8vBmCeR4GL0fDOiH0rZbDuMB1A82kjJiY8QwfKt4XFXzjGwIhKB0baPIkJeXKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G/HNkgA9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gRvKtN7Bjo+XxrtDIysDBDKxsS2+dP725UWkUeymprY=; b=G/HNkgA9MsLufCH60xl+HoNOdn
	8Wo+Ai96TuoXn3w4rkAH0cGFUxR1lCgHN93wzKn+HLmYndyMiRqUf5arogzHZ6fQe4MChgzBmhSC6
	yhSSUT+X3te7irGA3+36ZaoXytwpSKcdEDtFEr4XkYU4D+deddhtOpBE6pwBJIMyVCh+6z6LRFr8e
	nZElpuuQDcj7UgqVXrJtiZT6eReAtU0xLNzfOOwGFrbjD0ptmTSS/NPik4ukq2gpo+OfM9V13uaPJ
	sfM7XrmuPr3cDiw5/6oBbvB1HlH6jqO6sOAqAoJWbvS23GvUEDPWLVE4yS8J/dyXSKReSkxn3tONG
	pOyqy8fw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD7Om-00000007pQr-3QSy;
	Thu, 08 May 2025 19:59:16 +0000
Date: Thu, 8 May 2025 20:59:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: more breakage there (was Re: [RFC] move_mount(2): still breakage
 around new mount detection)
Message-ID: <20250508195916.GC2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508055610.GB2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 08, 2025 at 06:56:10AM +0100, Al Viro wrote:

> I'll cook something along those lines (on top of "do_move_mount(): don't
> leak MNTNS_PROPAGATING on failures") and if it survives overnight tests
> post it tomorrow^Win the morning...

Got it.  Pushed out to viro/vfs.git#fixes; just 4 commits there at the moment -

1) __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
2) do_umount(): add missing barrier before refcount checks in sync case
3) do_move_mount(): don't leak MNTNS_PROPAGATING on failures
4) fix IS_MNT_PROPAGATING uses

I've got reliable reproducers for #3 and #4, but they'll probably need to
be massaged for kselftests - any help with that would be very welcome.

Patches and those two reproducers in followups; please review and test.

