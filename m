Return-Path: <linux-fsdevel+bounces-25138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF18949596
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D131F21FE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4E39FF3;
	Tue,  6 Aug 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aL+6iT/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C002BAE5
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961933; cv=none; b=qsEKkTVLVvz6GZtcxraOjv7ld+NqzV9QDnQUXyAdmulj3jds3lg/7WxOLpTYK708OcmgHNdESypdlGz0p16X7bodl7ZNCQVvCaLroQS/dLB8tBRfJ0f7tDl/I/QnVST11YgaKNk9Nlp1NyZbMQF1yEgfO+04MNyeXuGyMBY2Sso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961933; c=relaxed/simple;
	bh=Cc1ER0hRtjYVVQLp4n8RAVqvaNwqDkNDifkyjeSBGwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pq0+fN1seIpZgj2jf/LVT3rOdi8ebnoflLzCkKZQMACY59x07JyVIdmPqCzgcXr8r17J5voCnTqjKrXc8cN89FPAey2003qx6XwKfNRRzj7Ztqv4BfYRI3qzxlABq/d4OS85RFfhtshY7mLt/7EnoWHFtkZYa+DB3s0P3HwlQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aL+6iT/Q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rQ+2h0rVDRewUvlC5yTmX0O8P+zCBHlR48DHStIxmyU=; b=aL+6iT/Qt1UidQOiaor9hpwUIT
	JaJAOjPoyStBOg6lC1E3LjHy7xNDUmLQSLvY3qiIU7Cc0FF6A/AEg+2f8SzAxsgpsslZs1vr5S/38
	94NWanNp9jZA9oEjEMk5kZCDPSH0GZFf7QHkEAWmHzGUcUWXMSFosyL7xogt7I0QpxV11p3h3VeQP
	gppy3ulTjAnr+ucKyD6mm41LNqHOYet72xLJuTP7VQEIylCuxHelKIlDFnSlStN42eVQX30+8qM1j
	CKcivEAm/FKnBxIm2eZID4U5oFrC90VyHYvXNtEGCyW8kJ2/EN+GVhWbNA7Z79miHieNrEX7AwqbG
	GzgV96xg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbN6W-00000001zKK-2hHn;
	Tue, 06 Aug 2024 16:32:08 +0000
Date: Tue, 6 Aug 2024 17:32:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240806163208.GQ5334@ZenIV>
References: <20240803225054.GY5334@ZenIV>
 <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV>
 <20240804034739.GB5334@ZenIV>
 <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
 <20240804211322.GD5334@ZenIV>
 <20240805234456.GK5334@ZenIV>
 <CAHk-=wjb1pGkNuaJOyJf9Uois648to5NJNLXHk5ELFTB_HL0PA@mail.gmail.com>
 <20240806010217.GL5334@ZenIV>
 <20240806-beugen-unsinn-9433e4a8e276@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-beugen-unsinn-9433e4a8e276@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 06, 2024 at 10:41:59AM +0200, Christian Brauner wrote:

> > Would rcu_assign_pointer of pointers + smp_store_release of max_fds on expand
> > (all under ->files_lock, etc.) paired with
> > smp_load_acquire of max_fds + rcu_dereference of ->fd on file lookup side
> > be enough, or do we need an explicit smp_wmb/smp_rmb in there?
> 
> Afair, smp_load_acquire() would be a barrier for both later loads and
> stores and smp_store_release() would be a barrier for both earlier loads
> and stores.
> 
> Iiuc, here we only care about ordering stores to ->fd and max_fds on the
> write side and about ordering loads of max_fds and ->fd on the reader
> side. The reader doesn't actually write anything.
> 
> In other words, we want to make ->fd visible before max_fds on the write
> side and we want to load max_fds after ->fd.
> 
> So I think smp_wmb() and smp_rmb() would be sufficient. I also find it
> clearer in this case.

It's not the question of sufficiency; it's whether anything cheaper can be
had.

