Return-Path: <linux-fsdevel+bounces-42915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848DA4B70E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 04:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2655816CBEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 03:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F851D9A54;
	Mon,  3 Mar 2025 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YH4gWqoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5113D539;
	Mon,  3 Mar 2025 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740974382; cv=none; b=qCLvOWcLw4NCPOxzvhmnkk60PhArFVHTgievwUhNy+5eCNofXUGg2TBA/Y4A0166FVbw1lt/5Xn1AWdMq0cnZ5QlJKsWTAEPZZKCPeBX4RqqgMfqmPFRsw8LhY1IZ1DCBmP/GbQLn3X6hXg5kyowwpykyXghg0B8RKEzzkdlFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740974382; c=relaxed/simple;
	bh=k8QWvNzSXPMT0Q7oeCz/tqEfFS6yw2nN5g5C0OAOXSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQOhFYaKRdo9hODWuiUS1n9SKhvC+9D+NsUR0wclCWCEVZaQ1iBABk+mIJVaq8BSbNHX1LQgwK9hv5IWcbOO2GJvVDOzhAVTIw96VQVf2v4VqKU8jhGN86e3Ctmy3vYO1q3MT8wt+Cr+M3FORaBCI7jjA3sIht20ZL9Hrj3PZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YH4gWqoL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aa8mvQyOEUS77gys5KLXfRplxUaBAVj2Xvp0aXyzh9g=; b=YH4gWqoLk5Y2ptWvbyOhJlT85R
	ERxeOot+7fsMiBaf0ddeQJefKzZtvBA68BDtBGwNGcq56cY5N7AGB7sQbu1KMTd1UCAcGd31As2RP
	ae3MWOcCmMPdoBp/FIRq8WBvTmAMLANdvsScjFetQ6h0+8vNB/Kg+AtEoH9xLmU8G2+mU7FLaNOei
	Rp8KpJB9oDi2X/0ndpfgRu4dUXlurgbABxXfxhxtJYQABAXvOGGNVDb4Ngis0/bvwuRRbTUMawgj3
	snYmf9iNXMjeUUlJLN+15c1wvHUY/S3e0buqYO6DD2arFxi4jvuMpbHRLwsN9CgrBx2ATEG8Eg+tL
	NkqsA/3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1towxo-0000000AQNf-1CUV;
	Mon, 03 Mar 2025 03:59:32 +0000
Date: Mon, 3 Mar 2025 03:59:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Strforexc yn <strforexc@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: KASAN: slab-out-of-bounds Read in hfsplus_bnode_read in
 v6.14-rc4 kernel
Message-ID: <Z8UpJLt_k7r_49ED@casper.infradead.org>
References: <CA+HokZpS9NC4ck36kK33pRha4RCM5cUr2nTakpUzO514C-w9CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HokZpS9NC4ck36kK33pRha4RCM5cUr2nTakpUzO514C-w9CA@mail.gmail.com>

On Mon, Mar 03, 2025 at 09:52:56AM +0800, Strforexc yn wrote:
> KASAN detects a slab-out-of-bounds read of size 8 at address
> ffff888044c23ac0 in hfsplus_bnode_read (fs/hfsplus/bnode.c:32) during
> a rename operation. Preceding logs report: hfsplus: request for
> non-existent node 65030 in B*Tree.

hfsplus is unmaintained and rarely used.  I'd rather delete it than
spend any time analysing this report.






