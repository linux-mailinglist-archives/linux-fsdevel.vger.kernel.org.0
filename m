Return-Path: <linux-fsdevel+bounces-55695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8475B0DE26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C865D7B72B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811142BF012;
	Tue, 22 Jul 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tnBhUf0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC0176AC5;
	Tue, 22 Jul 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194150; cv=none; b=Am2KVoB8s69+4HAKn2feWSLy0Do5aMKrAD9Mmtwiqk+SQIXWe9zlqt89CvWe43ySWqkSRRhWThFJgF/QNtrxs0JIjqw+SR9HQigY6JXk4EKRj4OwYAWD+7+xosNDPnQecvO9gt/rvJL5falwLVkhHMVNw+51kR8W3ZpNK4z+9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194150; c=relaxed/simple;
	bh=sgOD/G9e6sAkJSDLY7bbLHHkVxGsSaAU85Cwyqt1/Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxeq99G4n8wO55BwTZ414874+b/zmLrDCtmQ62O2GG3MGTZ2ChofW4Dwrt3ZSX5QD8R3NdwqxUVwmMmi6L7nIgXxh8NB4jeqA2JOrxo3cXQBSgG4qiLjfz6ETnhpTmB/bLmT6rzSHFhQNSiPrxm8t0lbkmWMjzTirm4my0gzzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tnBhUf0z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pxn4/Gktw1UVxYCnmMHxZiZ9oPqC1b4PgCug8zFDoYg=; b=tnBhUf0zpeHM9OrWGJ+Zy0hxQP
	XvAi49KngmJbTeocjxFjxtlMbduApJ2Xyj92Oflm7BCUXFIJDkaVzQHt7Ih2bOhST0fhMCZGM1XjH
	v7zpome4QE9I0CmQKdsnmNYRUmd574Mx0lgQQopSGK4rt2LygWS7usYGr3vqPouuUUryD3P3Qhdvx
	TUg8k3vAWDWKdj8t8J6mzL2QEB5JpZcAc2cP1dc0lZBl/Wm+Tj11RFPW7SebaT4Ey6ayHk3jpyLno
	BfnsCJgTMoGoGsKv7Ljvhr+suSeyW6GpPe2pAk6c7JkzacHJuwCEgZZzCSqrgwccaXlB7D4xHQOmZ
	0wsb9eBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueDsq-0000000BJVm-2v5f;
	Tue, 22 Jul 2025 14:22:20 +0000
Date: Tue, 22 Jul 2025 15:22:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Message-ID: <aH-enGSS7zWq0jFf@casper.infradead.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>

On Tue, Jul 22, 2025 at 11:04:30PM +0900, Tetsuo Handa wrote:
> On 2025/07/22 22:30, Matthew Wilcox wrote:
> > On Tue, Jul 22, 2025 at 07:42:35PM +0900, Tetsuo Handa wrote:
> >> I can update patch description if you have one, but I don't plan to try something like below.
> > 
> > Why not?  Papering over the underlying problem is what I rejected in v1,
> > and here we are months later with you trying a v4.
> 
> Because I don't know how HFS/HFS+ filesystems work.
> I just want to close these nearly 1000 days old bugs.
> 
> You can write your patches.

I don't understand this attitude at all.  Are you in QA and being paid
by "number of bugs closed per week"?

