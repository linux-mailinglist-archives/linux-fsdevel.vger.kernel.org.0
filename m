Return-Path: <linux-fsdevel+bounces-7260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C133F8236B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 21:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB551F24A34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848E1D69D;
	Wed,  3 Jan 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="juG5Hu96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1751D692;
	Wed,  3 Jan 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FArP6PojXIZHet0fgMSniHDnTIp6uCjlhRACZk/+G9I=; b=juG5Hu96B9Os64jtzlPJUweiCH
	NALNeCQr+bp+tXkddMN3ilW5eE+53ZveDjsdEuJ5CcAdIocf0ZMw94aUdhcf6acbGrrtbajHVBMXB
	HiDhuq3ByVMCFix8qfC/m5NXxwANJRJyWqKbNxzPL779BOXPYx6zmNcA5fNahUOrphf1AnF0rcfKE
	kusBxHX+pgEG/pLbZl26oUe7OpE4RraljMC5coQ17sgieH28a86sFyL+UosKNkQz+Z+WrwdcxTqdx
	Y6wYTOJMigCNVwOIpmqXoHIL09c7p1jCK0w6smcSCixsL/HRJbX8Pv3tl1EZSa3JBl8sjhTJBRMfv
	LJG0GrFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rL83P-000isv-21;
	Wed, 03 Jan 2024 20:41:31 +0000
Date: Wed, 3 Jan 2024 20:41:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <20240103204131.GL1674809@ZenIV>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 03, 2024 at 02:14:34PM -0500, Kent Overstreet wrote:

> We don't need to copy the C interface as is; we can use this as an
> opportunity to incrementally design a new API that will obviously take
> lessons from the C API (since it's wrapping it), but it doesn't have to
> do things the same and it doesn't have to do everything all at once.
> 
> Anyways, like you alluded to the C side is a bit of a mess w.r.t. what's
> in a_ops vs. i_ops, and cleaning that up on the C side is a giant hassle
> because then you have to fix _everything_ that implements or consumes
> those interfaces at the same time.
> 
> So instead, it would seem easier to me to do the cleaner version on the
> Rust side, and then once we know what that looks like, maybe we update
> the C version to match - or maybe we light it all on fire and continue
> with rewriting everything in Rust... *shrug*

No.  This "cleaner version on the Rust side" is nothing of that sort;
this "readdir doesn't need any state that might be different for different
file instances beyond the current position, because none of our examples
have needed that so far" is a good example of the garbage we really do
not need to deal with.

