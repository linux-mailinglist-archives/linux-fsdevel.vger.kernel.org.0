Return-Path: <linux-fsdevel+bounces-56226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67003B14766
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6433A9224
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 05:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D1233133;
	Tue, 29 Jul 2025 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uZIUutkv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F01F181F;
	Tue, 29 Jul 2025 05:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765458; cv=none; b=Om9A1JBfb3NjpYR2/vxxTz7+fKYleE/9r/ljPA3cv61V8aM/cq5X6jQPjEvAYXlxjlkKMjBT8OYM52FwPNq4UpUQY2W94+Uom3XJ20LEuv8qGW+nRkzlMbSyPgFr0301jDnoyWbkeR7GBqCoX4Q2d16vHjkq0QCDeTjgSePaxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765458; c=relaxed/simple;
	bh=ROR30oxXQP8SyjpFaU2BEVXdL1p0y4nDMKbh5C+9hvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzmK4AQXysMT1BdDFoKr4B/hYLwPrDIWcucJQ4pEw7gioMsd1a2fl38y+8WaDWr1vAG2xdAxMU/0/O6dDQROMFvtmFYAAiLm0pNhOfq+BkQ+zP6MZOlWuKjTgs/CTTycQGW6+acQkky5Zy0QJHleJVH6hGe2xWrwZQcejyDC3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uZIUutkv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ohsgeF+Zcb1Y+PgOJKt/GHASL2ZENfidzd2SCnAOx+A=; b=uZIUutkvyYzIBEwPUl1rFVEHVS
	VJ85jNCA8z0jYEDsEEBfM4nS74aDNHx6tIA1QUHJauepB3qFornGnLsXYLSOMTQLhC+BfCCaRiigD
	86r0ldrqRuL/0MniBNTjml1U5OCMseTn0n7CmcVPkhwib7/PhRMoyxkgxnFJBPg54GjgNoS8eAfMN
	mjMGTHVdR8P3QflevIDbqMiaLkFaJhCdzPpIkzM/TnfHdz7MvL2tnlOUotyZ+4lDLqyyyt18SOwQS
	J1Dzl2Vy417Lg8bfrQ8hAUgkxAGH9SrkieifICC+eJOiCCTUEcfLEZJrCMkS1QwiwhKm8iIm0cGrK
	t8Y7SSlw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugcVZ-0000000H3U3-2yo3;
	Tue, 29 Jul 2025 05:04:13 +0000
Date: Tue, 29 Jul 2025 06:04:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fat: Prevent the race of read/write the FAT16 and FAT32
 entry
Message-ID: <20250729050413.GF222315@ZenIV>
References: <20250728163526.GD222315@ZenIV>
 <tencent_3066496863AAE455D76CD76A06C6336B6305@qq.com>
 <20250729045323.GE222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729045323.GE222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 29, 2025 at 05:53:23AM +0100, Al Viro wrote:

> FAT12 problem is that FAT entries being accessed there are 12-bit, packed in
> pairs into an array of 3-byte values.

PS: they most definitely can cross the cacheline boundaries - cacheline size
is not going to be a multiple of 3 on anything realistic.  Hell, they can
cross *block* boundaries (which is why for FAT12 that code is using two
separate pointers - most of the time they point to adjacent bytes, but
if one byte is in one block and the next one is in another...; that's
what that if in fat12_ent_set_ptr() is doing)...

We could map the entire array contiguously (and it might simplify some of
the logics there), but it's not going to avoid the problem with a single
entry occupying a byte in one cacheline and half of a byte in another.

So nothing like cmpxchg would suffice - we need a spinlock for FAT12 case.

