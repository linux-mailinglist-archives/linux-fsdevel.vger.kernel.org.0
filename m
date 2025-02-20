Return-Path: <linux-fsdevel+bounces-42207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8CA3EAE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 03:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641417AB0CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 02:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A81D63F0;
	Fri, 21 Feb 2025 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="dCl5jRC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB2442F;
	Fri, 21 Feb 2025 02:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106306; cv=none; b=JgYp0CHk1UlMuIKUe9fB4Prx6mfdXW+8vHk0HKEMq2R1Or7WzuC8d2Cv/ijr5t1Ita3/BD0WdCZXsVgiUIf5rrqhdge7BDZFIRGahVfHRdWE1bBarh08f+acvA22RE4PlpN2nWaDjGv+z/d1lg/B9GWchIY4BlWk1OslLRo9Zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106306; c=relaxed/simple;
	bh=AEVqJje+U/dlYf1eeame0lCbwtleOMiyWF4wKhvGhlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOiSmIH7ek1wC36hOgLK8MdJPNYAwiZULNqqru35+CX1SIpom3kf1VKkY7qOnQFEnuYRNp7YqUSR2AF6mCJ+7l1tDl/6kWbFq/1Y0aRXlx7BB+Xd/itrLu369/cbV3sax1I69xF6TS//oNzN5kCIGbKByAF7Vcx8XBjkDNMO+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=dCl5jRC+; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C807914C2DB;
	Fri, 21 Feb 2025 03:41:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1740105717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNcc6KqdVu2nSV8k3rLKueper8Fe7B+V1orHMollzx8=;
	b=dCl5jRC+GxQ5RPQm/4sx5ZFxY8gLFJD5qdZ3wzn3yrDMXS5jrpI5rlSoKd5CmqX+yZ6SMX
	m1e/gsuiBpM0jGWHcjWdSLybmW6NTUIYjjhCA0poC+CYo5BYYTQQ8ciRYXLvLqHj7hggBk
	daBN+L/aV11DQDPy6e8B9fi1HH6Y58/xs/DeZeysPjCsFPWbBCT6Z7T5Zz6guxJfHYG9U/
	sE27G8BQPX7MPQ37qUnrnmEjYMXjnBwPXK8fT3s6Oyqbe7B7IGhWlQ6wndVxrdz1M2KEz/
	jW5aj55riEt8jx5mYeLxN1+XaaqEumPFkFrMqMZB6iqGoDDrz/TG1Hd/D5dWyA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 56f7ec9c;
	Thu, 20 Feb 2025 22:06:01 +0000 (UTC)
Date: Fri, 21 Feb 2025 07:05:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>,
	v9fs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
Message-ID: <Z7enOheevlbS1xpH@codewreck.org>
References: <67b75198.050a0220.14d86d.02e2.GAE@google.com>
 <Z7dVOaTWTVCojNzr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7dVOaTWTVCojNzr@casper.infradead.org>

Matthew Wilcox wrote on Thu, Feb 20, 2025 at 04:15:53PM +0000:
> On Thu, Feb 20, 2025 at 08:00:24AM -0800, syzbot wrote:
> > ------------[ cut here ]------------
> > kernel BUG at mm/filemap.c:1499!
> 
> Tried to unlock a folio that wasn't locked.
> 
> The entire log is interesting:
> 
> https://syzkaller.appspot.com/x/log.txt?x=12af2fdf980000
> 
> It injects a failure which hits p9_tag_alloc() (so adding the 9p people
> to the cc)

9p is calling iov_iter_revert() in p9_client_write() on failure, but at
this point of the failure copy_from_iter_full (which advanced the iter)
wasn't called yet because the format processing happens after
allocation...

This was changed by Al Viro in 2015 so it's a "fairly old" bug, but it's
a bug on 9p side alright - thanks for the cc

Now to figure out how to decide if we want to revert or not... I
honestly don't have any bright idea, but I don't know the iov API well
at all -- perhaps it's possible to copy without advancing and only
advance the iov if IO worked?

-- 
Dominique Martinet | Asmadeus

