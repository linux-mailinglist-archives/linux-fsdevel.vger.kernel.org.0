Return-Path: <linux-fsdevel+bounces-69920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5314C8BBFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 21:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C3394E4D71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C79331A6C;
	Wed, 26 Nov 2025 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LZmCZ9Gq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B093F22AE7A;
	Wed, 26 Nov 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764187348; cv=none; b=BN++t625Yp7NpqzYt1WRi4dNtM07fm7eKoC/FAvm/2ynqIXmHPHBIeeWXJjAYVF4HS8PlI7+IIKjjOvJizwqnIBepKfBbvC4eJQMtdw20W09p7hUYk+Jy+o2ww7F8id8Ftw8BNtDOxI5hd/7HmZZBcX06JrduVhWwgnP/qHHmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764187348; c=relaxed/simple;
	bh=atPrEASswSmPsduMD6vZd9+5n8DHMWs3bHxkkUVrB1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCeKSKs2kBGWEJaoInMZ18/8UAkpZA87TzHg44aGlOvHS8QojJfgOU6OzCAS4F6fRHRsBBbGi8/IHM0oKTcgO5CXg3tY7qW1BS50Yrrx2V4bOMwA9qjrNgMei2PYYuGhtQOeboNE1TI5tksO/a6p4tXb4xqs2LzNUtoO4sEgdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LZmCZ9Gq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o4aSs3i8MxSsH9LQQdFXRZ1BuzBNVqWnsabFj67iIHM=; b=LZmCZ9GqC2htrAE0BVjhaPqHbm
	INkERVhSMY1db6iQJ4Ngu9AKIvVQpb9JE8xz31dPizJduLq671DX531BBB+KJV1Sjyi/sey8w80IQ
	YOooCFH/lLeUp17ag+6xUA8yKj8RZDwMFNUSsjcs8VJMcvgbypRlKTy66U0t99XSc8VTR1NQehinX
	SKIa6txZRdmeT3ZKSTGrp4Wk3OXxlT1Stsz9j2rwT5sTQN4R4aAYzSJbTvsx88Wgb9TMv6xbiMhs5
	v6200KJYAwWcQ8YmK66v/BuAUrigq0ReBXRDD+8ti0UsNN07jiln45kL/AfUkfpouHzXAAC6n4Y5x
	st2zoTKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vOLiX-00000001VKP-2ggS;
	Wed, 26 Nov 2025 20:02:21 +0000
Date: Wed, 26 Nov 2025 20:02:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, brauner@kernel.org, jack@suse.cz,
	will@kernel.org, nico@fluxnic.net, akpm@linux-foundation.org,
	hch@lst.de, jack@suse.com, wozizhi@huaweicloud.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <20251126200221.GE3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126101952.174467-1-xieyuanbin1@huawei.com>
 <20251126181031.GA3538@ZenIV>
 <20251126184820.GB3538@ZenIV>
 <aSdPYYqPD5V7Yeh6@shell.armlinux.org.uk>
 <20251126192640.GD3538@ZenIV>
 <aSdaWjgqP4IVivlN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSdaWjgqP4IVivlN@shell.armlinux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 26, 2025 at 07:51:54PM +0000, Russell King (Oracle) wrote:

> I don't understand how that helps. Wasn't the report that the filename
> crosses a page boundary in userspace, but the following page is
> inaccessible which causes a fault to be taken (as it always would do).
> Thus, wouldn't "addr" be a userspace address (that the kernel is
> accessing) and thus be below TASK_SIZE ?
> 
> I'm also confused - if we can't take a fault and handle it while
> reading the filename from userspace, how are pages that have been
> swapped out or evicted from the page cache read back in from storage
> which invariably results in sleeping - which we can't do here because
> of the RCU context (not that I've ever understood RCU, which is why
> I've always referred those bugs to Paul.)

No, the filename is already copied in kernel space *and* it's long enough
to end right next to the end of page.  There's NUL before the end of page,
at that, with '/' a couple of bytes prior.  We attempt to save on memory
accesses, doing word-by-word fetches, starting from the beginning of
component.  We *will* detect NUL and ignore all subsequent bytes; the
problem is that the last 3 bytes of page might be '/', 'x' and '\0'.
We call load_unaligned_zeropad() on page + PAGE_SIZE - 2.  And get
a fetch that spans the end of page.

We don't care what's in the next page, if there is one mapped there
to start with.  If there's nothing mapped, we want zeroes read from
it, but all we really care about is having the bytes within *our*
page read correctly - and no oops happening, obviously.

That fault is an extremely cold case on a fairly hot path.  We don't
want to mess with disabling pagefaults, etc. - not for the sake
of that.

