Return-Path: <linux-fsdevel+bounces-36700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5C59E82F8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 02:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B3118838B2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868198F77;
	Sun,  8 Dec 2024 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YhAXVBhp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61D749A
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Dec 2024 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733621002; cv=none; b=gqWoZdsZ9F88lH7tfftSlSo7/lU0wHquQidI/LHGRyrF13pZE7LgLzFz9uaHQDkNca7ZidCwBYLzYVsYrxcrBdvty4kYOvc13ZjPCjBMQC6tqsbzYnfMyTAChjaQG0fKpp64fvBelB6lhU5RZEGtwaj3V6e5ewJ8C0sfr9JtKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733621002; c=relaxed/simple;
	bh=BoSs5J/9aMAvkECBtH8PjokPon0ZmiSLPzWfBMdbdN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq66sU5ACg0hvmVUQnBDDF0bbdNu+aKOyeEEeyhVgEDUNuwVk7JDFalljOzrBdRxQ2q5L+xngZD/HUNpdz6DZCxRlhkmFtOf/f8/VyTEmhAr6RWPRVFSvptEkrcUvW7TIftzEIgGPhSis3XR8TIH4T3qjuX/jhiNmBXikM9xRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YhAXVBhp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WRRQjbDDptelQr6ZbG0yTj/HAgkanLDW0kbqF77AdB8=; b=YhAXVBhpj8pgvrtm8qM1MdmabX
	UuEYkVllw1WXCyZa38GxICEWjZZHMf5HKGw51FpgqAuGgfsz18Ob9DiO9My4OYXn2sPPyZp+y/roo
	maOTOhd0QQ6rKJ3TdovH3MZVVGuAYVfptYKtNzKK9NbNAgUem5+JQHKEFdq9vcWBEsfySi7w2YKd/
	h/EB27NRFq/qmyS00jW9kkLJig8Wei1l2B/11Upc1qrhQN9/ZpV8AkVLNsz83vXB9Ud8/LT8GmMcH
	3YK7JtUI/jpkg/1s9CK/I7MDKiItvWoUbvckz36ZSEs0kjXYtWkroscCjdg0/ynOsErRFwIAD+wE3
	HMl3Sb3g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tK60j-0000000Ghyj-2fO5;
	Sun, 08 Dec 2024 01:23:01 +0000
Date: Sun, 8 Dec 2024 01:23:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <Z1T09X8l3H5Wnxbv@casper.infradead.org>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>

On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
> me.     

That's a merge commit ... does the problem reproduce if you run
d1dfb5f52ffc?  And if it does, can you bisect the problem any further
back?  I'd recommend also testing v6.12-rc1; if that's good, bisect
between those two.

If the problem doesn't show up with d1dfb5f52ffc? then we have a dilly
of an interaction to debug ;-(

