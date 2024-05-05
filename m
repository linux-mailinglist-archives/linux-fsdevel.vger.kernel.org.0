Return-Path: <linux-fsdevel+bounces-18758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375578BC05D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDB9281E06
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632EA18E3F;
	Sun,  5 May 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HpwKRvwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAE186A
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714911969; cv=none; b=jRKCBwEA/gyv3X3hGXBHJ4PjNYEtDFJmtEB4OLMGjIWbKVSaxYYUh5n3vbDSWmr1hXh4SE21UG+nODcD/oTx1kykiBomETSKKba3N5ZzUfESHCaAFBNLMu9+iUxa62H5HgvRiLsRefjBs4lK2t0EzVZoU6RrfSyOT4EN3ikkVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714911969; c=relaxed/simple;
	bh=SNONyhD1xyP2gU8JXMrGGt/K2nTIsUHjAQGJPXJdLFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rLM4RDDswj8GfYBbbPp83sxb0qPiAOe/redXUI8jAv8Y3LzjXXkN8IC0+jzlOlLO8ChOyoBtTwPlRdUkAP03Yhc20FJowRNfa2gSuJQAtECOX3DEwl29yBWSH38FUIvyPi3h8B5URjdD/EfHNuAKAsSslgWYXnwocJtWNBf7KBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HpwKRvwg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=xgLABeNOKMr2PKC0Jdo0jUUPTZqrLr99KdTRg3trTOI=; b=HpwKRvwg7DMvDV7BUT/XMvPJ7g
	7lOhO4uCy5d9x5b8XRVjkTjh4R5vWiZmysu8m9PHpP0P6ur/JttByX8WVGlewuSd8uDBGxAvuVH87
	do0OzQ1Fj9t7XMCtW3dhTXRqN99zzD1BYLN3Qq7nLCf8Q0qVfSP6c9KuVwHxd6tHCFcyolftfNR+S
	OM3Vpa4XhyKdi1K1LpfAHENPqGlSB7c4a5lSF8jF+FExVh83Zvm8jnbDC8C/yuU9U2nGqOpmrcKUc
	ni6+tHbI/BS/Rq771wIjdrwDVMqPAq5o6y3Qg8OyurZxxgQOaQIWjpqf7s9XLBtDJhSy7lh33qwXp
	jMA5CrqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3awI-00000008ax8-37NF;
	Sun, 05 May 2024 12:25:58 +0000
Date: Sun, 5 May 2024 13:25:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org
Subject: kmap + memmove
Message-ID: <Zjd61vTCQoDN9tUJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's a fun bug that's not obvious:

hfs_bnode_move:
                                dst_ptr = kmap_local_page(*dst_page);
                                src_ptr = kmap_local_page(*src_page);
                                memmove(dst_ptr, src_ptr, src);

If both of the pointers are guaranteed to come from diffeerent calls to
kmap_local(), memmove() is probably not going to do what you want.
Worth a smatch or coccinelle rule?

The only time that memmove() is going to do something different from
memcpy() is when src and dst overlap.  But if src and dst both come
from kmap_local(), they're guaranteed to not overlap.  Even if dst_page
and src_page were the same.

Which means the conversion in 6c3014a67a44 was buggy.  Calling kmap()
for the same page twice gives you the same address.  Calling kmap_local()
for the same page twice gives you two different addresses.

Fabio, how many other times did you create this same bug?  Ira, I'm
surprised you didn't catch this one; you created the same bug in
memmove_page() which I got Fabio to delete in 9384d79249d0.

