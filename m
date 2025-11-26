Return-Path: <linux-fsdevel+bounces-69907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 500BBC8B79E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2687345C16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBC3311950;
	Wed, 26 Nov 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ivStOe1K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965F30C63E;
	Wed, 26 Nov 2025 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182906; cv=none; b=SWa7e6rMxyjpL2OEDkZNAKvI4LrH3jfWQaIlB/a9MUGdqz3ciqzXHfgozRASsFjELDlqRyeW4JMVZaNOXdb6aGbHmdd+UZ35ZxmU1J8LRQ6c2wv84dQpHizG27UDl897wU19NMDsts2lr+W/h0igppH/CEPtIFaAfNnsbzd0ueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182906; c=relaxed/simple;
	bh=iV8Y7gCnEoMJ2BuwpWUsDTQC7AVPdeIU6c+WASkK7Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoyB817+Yp66SB5bh4QTzR+lSe2Hl3N1RYvkpxXwCYYGH7EZwnxt7XCZo4kG4m/4QYhIVA4ZU71vlFHOh0GCodyddNIP+hOSsxpRPH4jdHW0FnGnC9JoSGkrvfxagKi17mk713igTRXYxechcqCXcI3hSIG6goRCXdH2l1NwLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ivStOe1K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mdfgXlkpyLxaObMMHx43Tkpr2ds6LGq9BHgJcGxz0JU=; b=ivStOe1KLxJxw1t8tb72zR8h5B
	W24XagOg7rDcPXZgjOv1FG9rwU2wWxKjHritLGxQkB7rwfZ46htLdBTDboPRj4SILvJyeNToEyTH0
	xeQY2zH9Jt34KfvU2TX7aaPQ873aCah7B6FLdWXnT3cieEefNdrNf0WEnG++C62r58kjy8crDm7u4
	VEzwxCE2EyyrsKYMOSP3AqVbLC/mQaYK2K+5cxl1C8/K9l4KdbpoFZB9ffzoEDmP/AQmnEhi/ckwf
	o0rUliXD2IRZhnuuNzU64OPR1fgeLSdXpAp6NE7v/QLeLHI48lVuZknFaIWBHEGVZkKcxbZcjIAtw
	PyuQ+Jgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vOKYu-0000000HYvd-2akG;
	Wed, 26 Nov 2025 18:48:20 +0000
Date: Wed, 26 Nov 2025 18:48:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, linux@armlinux.org.uk,
	will@kernel.org, nico@fluxnic.net, akpm@linux-foundation.org,
	hch@lst.de, jack@suse.com, wozizhi@huaweicloud.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <20251126184820.GB3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126101952.174467-1-xieyuanbin1@huawei.com>
 <20251126181031.GA3538@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126181031.GA3538@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 26, 2025 at 06:10:31PM +0000, Al Viro wrote:
> On Wed, Nov 26, 2025 at 06:19:52PM +0800, Xie Yuanbin wrote:
> > When the path is initialized with LOOKUP_RCU flag in path_init(), the
> > rcu read lock will be acquired. Inside the rcu critical section,
> > load_unaligned_zeropad() may be called. According to the comments of
> > load_unaligned_zeropad(), when loading the memory, a page fault may be
> > triggered in the very unlikely case.
> 
> > Add pagefault_disable() to handle this situation.
> 
> Way too costly, IMO.  That needs to be dealt with in page fault handler
> and IIRC arm used to do that; did that get broken at some point?

FWIW, on arm64 it's dealt with hitting do_translation_fault(), which
sees that address is kernel-space one, goes into do_bad_area(), sees
that it's from kernel mode and proceeds into __do_kernel_fault() and
from there - to fixup_exception().  No messing with VMA lookups, etc.
anywhere in process.

Had been that way since 760bfb47c36a "arm64: fault: Route pte translation
faults via do_translation_fault"...

Did that get broken?  Or is it actually arm32-specific?

In any case, making every architecture pay for that is insane - taking
a fault there is extremely rare to start with and callers sit on very
hot paths.  Deal with that in the fault handler.  Really.

We have no business even looking at VMAs when the fault is on kernel-mode
read access to kernel-space address.  And callers of load_unaligned_zeropad()
are not the place for dealing with that.

It's been years since I looked at 32bit arm exception handling, so I'd need
quite a bit of (re)RTF{S,M} before I'm comfortable with poking in
arch/arm/mm/fault.c; better let ARM folks deal with that.  But arch/* is
where it should be dealt with; as for papering over that in fs/*:
NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

