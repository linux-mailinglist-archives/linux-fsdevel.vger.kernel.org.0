Return-Path: <linux-fsdevel+bounces-42211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A197A3EC3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 06:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D1D17F312
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 05:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C41FAC3D;
	Fri, 21 Feb 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ER5rf842"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F04207F;
	Fri, 21 Feb 2025 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116114; cv=none; b=HrFPcL437EMP2SsqP0hUo9d3tyX83jKd3CVz4FaXjuIe0zlfhZlgvqoXEc7vTPgiMSZdaq27HmJqsjwRqVGFF0QtlOeCIG9GDW/RxgVy2e5XqaFSGcNoG3oIqX79bCBYParmpPPPDCymBEuAeeDE6DrXImL/bVb3RNAC5uxyljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116114; c=relaxed/simple;
	bh=Deq4RgNshLf44XtdBJ/MBwUsysG7NkBwJVhTMwu8dIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwRmleam+l40kODUN0ylskVwO6Dpyv+GRi4X5JNvMrHAUDBUYwlRiyo4DNsx4+sei5MSoaCTEKuBfJDi/Py6UzaMbsUOykmxRXaw3gtGiob2ub2XHh72aQuAYSarnK41Bxeiu/K4sy1q/q+n7NE11rbj60lAAILQtRuZU2l1UWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ER5rf842; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xYm6rLvu5MjzHyT3qjofXRi0WdAYz7kv7wTL+Pyt/lI=; b=ER5rf842rCqcG9IYm5kw9pTvWy
	9n9WhFL+p+y2tAIOjfgiEHrPR25+qj0sZ0QCD6rvj7jpG1ZLNdEFRJbhPu9jJXRyLhZxTL7yICzV/
	MsnPoeyRR5tTWZsKvUCnsTlbnL1fRIUCTVQutp+g7auE8a59QLhdDWRxmTjKBDUfxj+oIfd8mAHz/
	kcAZ+S6BikNeekn8clr+UFHAeY7C0cxVKqyknmdfTZWd5RexhxwzcpsIR3+Y7OIWPtCDd2VPslrji
	AUYDNcCt3OHPc7UmRGXsF5Fd6yMtB2TtaYRuTUfQdFy0HW+DBEJHU8B3LEvOK1214VS39g0gh7hQf
	fluPrDyg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlLgr-0000000CQwy-1QgM;
	Fri, 21 Feb 2025 05:35:10 +0000
Date: Fri, 21 Feb 2025 05:35:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fscrypt: Change fscrypt_encrypt_pagecache_blocks() to
 take a folio
Message-ID: <Z7gQjS34D_Xg_uVo@casper.infradead.org>
References: <20250221051004.2951759-1-willy@infradead.org>
 <20250221051607.GA1259@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221051607.GA1259@sol.localdomain>

On Thu, Feb 20, 2025 at 09:16:07PM -0800, Eric Biggers wrote:
> On Fri, Feb 21, 2025 at 05:10:01AM +0000, Matthew Wilcox (Oracle) wrote:
> > ext4 and ceph already have a folio to pass; f2fs needs to be properly
> > converted but this will do for now.  This removes a reference
> > to page->index and page->mapping as well as removing a call to
> > compound_head().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> It's still assumed to be a small folio though, right?  It still just allocates a
> "bounce page", not a "bounce folio".

Yup, I haven't figured out how to do large folio support, so any
filesystem using fscrypt can't support large folios for now.  I'm
working on "separate folio and page" at the moment rather than "enable
large folios everywhere".  Maybe someone else will figure out how to
support large folios in fscrypt and I won't have to ;-)

