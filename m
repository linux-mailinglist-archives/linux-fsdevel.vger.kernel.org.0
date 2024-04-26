Return-Path: <linux-fsdevel+bounces-17851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5F78B2EE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 05:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979241F22A20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 03:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46376408;
	Fri, 26 Apr 2024 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BuuTDgfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37942BAE5;
	Fri, 26 Apr 2024 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102067; cv=none; b=O8+zFUSgNXDYJplTN4xi45/F4fnxoCOnE+FgS0Q4vwwlZiAxEWHyqclM0ZBbHim/YTbNkOSFa4/3Stz0/Ygt+SsoKN8t5dr4N1hyAuYqazGvR1S1OyP4igjwh9gb2ivZ3byooyWPiaMZuQSNzMWLR6/55CQOKg9V5Lp+3TBWPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102067; c=relaxed/simple;
	bh=ObdL6GZrnYLvFumBWkqwM4roFej+lx1IDQ53cn3DmkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQuc86pxrfiAyclH+zyxmbKF7ezngm+JqRM+wu/sEUXyhVGTWzECccj/3fWTj+HGGRyFfWaK7+vaXOpBP19nrCMDoplIrK+U1Vll4AZbotl6Lz230rBrZ7YrtarjM9F0TGSo2vIXnOLKVJOkqwpRuNVYIoGWncLqZKpfQ/DTPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BuuTDgfw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BruGrpEeGl8Bbb8+2NZYWt0i7WnhcaeFDM/TK8ffawQ=; b=BuuTDgfwOMhAdCpISaRUpEsXy1
	QG0pECDaaF/LHOZ4e+IvNsCKOBvnbzJ6D58i2S3z1bwYR1KG3SdjcAfSzEP1MZUB+83TT7IJC/Xpc
	0kTZcERULzGplBdGhF5TIZI16oUgFRfzbOLLtxDbftLsvOYnznBayqZvU2khbbCxdUtZ4IYl+E6gB
	DRl+yDpJE1epqEsM3K1xot37H2sWZ2QosSBiK9uLsb29u2JlBGdN0N4oAn/UCBb80z9b9MgirdLIX
	AO4ZQI/vC+YvpCQkuwVs2PMDkHYaxFpfxik0zMdHaeG1a/lBaIpbqzASCZY/cYTHlKZ9H6yMEULkp
	xmiqxC8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0CFQ-00000004Nec-2lek;
	Fri, 26 Apr 2024 03:27:40 +0000
Date: Fri, 26 Apr 2024 04:27:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: dave.kleikamp@oracle.com, brauner@kernel.org,
	jfs-discussion@lists.sourceforge.net, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Message-ID: <ZisfLI3Va6D5PjT6@casper.infradead.org>
References: <ZiqNMLWFIvf43Mr-@casper.infradead.org>
 <20240426023412.52281-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426023412.52281-1-aha310510@gmail.com>

On Fri, Apr 26, 2024 at 11:34:12AM +0900, Jeongjun Park wrote:
> I forgot to add Dave to the cc, so I'm sending it again.
> 
> Send final patch. With the patch that modified the location of
> release_metapage(), out-of-bounds vulnerabilities can now be
> sufficiently prevented.

This is not a good commit message.

> +	if(agno >= MAXAG || agno < 0)

Please follow normal kernel whitespace rules -- one space between 'if'
and the open paren.

