Return-Path: <linux-fsdevel+bounces-10080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D18479B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2E51F26063
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5090A15E5DE;
	Fri,  2 Feb 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tU6DypZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC415E5C6;
	Fri,  2 Feb 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902365; cv=none; b=aeysKa605/Cm9BENq5W5Os2vYAqHb2AxiUSoEphDLjJN8MgUyGB6/xZyqweXksOw3VTfqWR6qXmuivQr57FNLvcoiigvUg2JdTltY9ounRgBMYIulr5LC9kqxHx1/8L7IeETzluDu4wdox9EzRH4VwpkBhexMI0sumEwZmWKW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902365; c=relaxed/simple;
	bh=HYz6/hJ3oOA9kZreAOM5bZVw9xL3BPQoAckmdbalIFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eyw8N8PKBpvXUM2EuUGP6NNrA5Q/Q6wYKnlM9CI6/ESe1yewGL0iyCD1iLx4lYBmUM/zJImoZeSEMdCk97lYzFrCBMIYnRiwWJ5PtubtlRcZ3YLLmSIFVibdQUN3tSP2QHYW1B0zhLcKmABFW9gY2wDCqBk0uiTMn/oFqI0bmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tU6DypZY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SpRGWjsjOgKS2iXgevZZ/0uJ3SDShG6QHurdZ8ks1JM=; b=tU6DypZYqDQ4nNWUx28WBq+zCK
	veUNIQtjIgWRYe3kxZXlqPpdWqTeVdLSLyc8JRtkx8K05tKREYS/6TlvuVw+xeitWHLEfh93ihpjc
	l9ihXf7j5rafYtGokZvpiwuMXRadvGP7kL5VCWRgMmsmV+IBhCxx+bpBAl081oEzkP+o8itHamZx9
	f5LUJOtZLevrDtQrOqN6z+X4q86GwiOJeC2yjXje48Kk1OdWKXZZ8X+W6RxWkq6BDVLtp9OQbYyRH
	OL9Tn6FOWpBJub8ibAew3KYVIBxEOjnhx3gOcmJfeecgrKJ9Ij4W5iqaQjTC4NODbN+DesWPfqLwI
	uRWcVsqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVzHA-00000001tem-2lt6;
	Fri, 02 Feb 2024 19:32:36 +0000
Date: Fri, 2 Feb 2024 19:32:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	CobeChen@zhaoxin.com, LouisQi@zhaoxin.com, JonasZhou@zhaoxin.com
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <Zb1DVNGaorZCDS7R@casper.infradead.org>
References: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>
 <Zb0EV8rTpfJVNAJA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb0EV8rTpfJVNAJA@casper.infradead.org>

On Fri, Feb 02, 2024 at 03:03:51PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 02, 2024 at 05:34:07PM +0800, JonasZhou-oc wrote:
> > In the struct address_space, there is a 32-byte gap between i_mmap
> > and i_mmap_rwsem. Due to the alignment of struct address_space
> > variables to 8 bytes, in certain situations, i_mmap and
> > i_mmap_rwsem may end up in the same CACHE line.
> > 
> > While running Unixbench/execl, we observe high false sharing issues
> > when accessing i_mmap against i_mmap_rwsem. We move i_mmap_rwsem
> > after i_private_list, ensuring a 64-byte gap between i_mmap and
> > i_mmap_rwsem.
> 
> I'm confused.  i_mmap_rwsem protects i_mmap.  Usually you want the lock
> and the thing it's protecting in the same cacheline.  Why is that not
> the case here?

We actually had this seven months ago:

https://lore.kernel.org/all/20230628105624.150352-1-lipeng.zhu@intel.com/

Unfortunately, no argumentation was forthcoming about *why* this was
the right approach.  All we got was a different patch and an assertion
that it still improved performance.

We need to understand what's going on!  Please don't do the same thing
as the other submitter and just assert that it does.

