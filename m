Return-Path: <linux-fsdevel+bounces-5624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8FD80E501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 08:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0837E1C224EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE00171D7;
	Tue, 12 Dec 2023 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3ZJHg4Ex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD16BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 23:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0m/BbEGfqGhU9IZLa6Rvr7Xy/aZcNJznuBiNVsxcVfA=; b=3ZJHg4ExrXicJFtaAfbVIWgMPY
	Hl96lApw4s3U7jYW2g9nKrjf/stEbSYDzlOwcpaWK5Xzd2SQ/9TLkslT2nz+X23dOFLLKR2Un7nsn
	zuoGYUNI1lRwMfLhKKiTyyQWmg9dwWht0I8ImEi0xje06V3M1M7DI+S5xpaF23StSoIwmHGXurbD6
	6BMbppd2+XkR+cXuNhkN4eQfKk2PCBqRBL2EY+MQZtn2Iy/UgFGaXEb6vRuIDNA2Vaks2TF8KNnar
	xfBDh/wYOmtls3cFFWqUeXiyU204ELLi/OxiUMyiJtOHseCovYzajEuhFa9dhTXNjAaYGyBdBJMCl
	ncraZqGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCxRR-00Awy2-0l;
	Tue, 12 Dec 2023 07:44:33 +0000
Date: Mon, 11 Dec 2023 23:44:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] freevxfs: Convert vxfs_immed_read_folio to the new folio
 APIs
Message-ID: <ZXgPYX3jLfKPZ8Cg@infradead.org>
References: <20231206204629.771797-1-willy@infradead.org>
 <ZXFW8yGT3uuGgObF@infradead.org>
 <ZXHG+/aAiaDvLBxr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXHG+/aAiaDvLBxr@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 07, 2023 at 01:22:03PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 06, 2023 at 09:24:03PM -0800, Christoph Hellwig wrote:
> > On Wed, Dec 06, 2023 at 08:46:29PM +0000, Matthew Wilcox (Oracle) wrote:
> > > Use folio_fill_tail() and folio_end_read() instead of open-coding them.
> > > Add a sanity check in case a folio is allocated above index 0.
> > 
> > Where do these helpers come from?  Can't find them in Linus' tree.
> 
> Is your tree out of date?
> 
> 0b237047d5a7 for folio_end_read()
> $ git describe --contains 0b237047d5a7
> v6.7-rc1~90^2~161
> 
> folio_fill_tail() appears to only be in akpm's tree for now.  Looks like
> it's still in the 'unstable' part for now, so no sha1 for that.

Heh, I only looked for the first one.  But adding what tree you're
sending a patch against not only makes reviewing possible, but also
helps with the destination.

