Return-Path: <linux-fsdevel+bounces-42874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C3A4A7CE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 03:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6753BC155
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 02:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B13595A;
	Sat,  1 Mar 2025 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hi2q5pdw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642125760
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794608; cv=none; b=NW3T0WmDJAYnxen02s7VxCSQVYSfwxpV6Cp+ExrPElxPHGDB3R00rwhpVcz1KuMWd0gNu3YpLH6sPj8el67F5TkyUI9919pIoUxYj+/1ZZ07Bgy5vNTrQPp6mF8SbsIBtsZD21EF3XtTqOCC5xJWMnLXZeoAs8u7l0Xp5HgJNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794608; c=relaxed/simple;
	bh=LjaRuAm4UYg8oI3TaXEjmrDuFDyvw4ma5V4OGattKP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjW7FJUrb8cE07Z07Tlg0gK7YGpAAtK54lKOaI2h9uDBhhdLykn2fUUZ6W+TljHPcUtgXEn2qV4f+IY1yC/HzW1CG3C5V3ePnyukuFEAGSbbnSMILHnJaB9Q6FlMgBrH1k54URL6juszuCwkqET7vYmar97dr/ho/O5igZ5Sq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hi2q5pdw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=duBdWCqGMyot/biSupNGUk4zTVbkQMBzCGz559cvv0c=; b=hi2q5pdwHzGcYKAJLwGAwJK2F0
	HrGr5pBK+FAvqn/R57WbCCXJE1E7CHP/WkSIupNCUqPHyRb8AFO5MW7ry7mgwgVq4pK15cN2dTL6R
	8Yz66bm3iMyni+x0v0LvozEPOwxoB7mbZFmfair+M///bxJ7eYvhwpAHYiayYKOeQ47w2BgS7Werw
	jGeN/oT7lW6v7QCp2vFZCCQgSnBOCKHc9PGe/9SEhzwLgMuqWOm/8YpytibcSfdkoI+BnpX87N6Jn
	gwUtJjajPv4WqxrnMbCjHfh1GORJXlHJbhsMuK/6JnOmTtLZl7V5rb6qZSTIQmV0Vld27p+dMHYRh
	dqPgkapQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1toCCK-0000000Cn9b-1JUA;
	Sat, 01 Mar 2025 02:03:24 +0000
Date: Sat, 1 Mar 2025 02:03:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/27] f2fs: Add f2fs_get_node_folio()
Message-ID: <Z8Jq7PQNRDu_zmGq@casper.infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-18-willy@infradead.org>
 <39268c84-f514-48b7-92f6-b298d55dfc62@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39268c84-f514-48b7-92f6-b298d55dfc62@kernel.org>

On Sat, Mar 01, 2025 at 09:15:53AM +0800, Chao Yu wrote:
> >   struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
> >   {
> > -	return __get_node_page(sbi, nid, NULL, 0);
> > +	struct folio *folio = __get_node_folio(sbi, nid, NULL, 0);
> > +
> 
> 	if (IS_ERR(folio))
> 		return ERR_CAST(folio));
> 
> > +	return &folio->page;

No need.  It'll probably generate the saame code (or if not, it'll
generate worse code) and this wrapper function has to be deleted in
the next six to nine months anyway.  We use this idiom extensively.

