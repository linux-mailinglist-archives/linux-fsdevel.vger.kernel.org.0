Return-Path: <linux-fsdevel+bounces-2763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211347E8E63
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 05:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC531C2082C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 04:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522D4428;
	Sun, 12 Nov 2023 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mvD6qLIQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58933F1
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 04:53:08 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D052C2D6B
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 20:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C7mbVvCxmmdoasQ2rmD+cwGlr698Dp5+DuFDa7Kru5M=; b=mvD6qLIQK7gTHrqN+6GT3YLZ8i
	8qMs4rko4igZwCCtM8LA9qBLiORO6uVkonQaTQSGHcUnLAueFDcvmR+lr/EWZGByLZ8+B8KN3Q9jr
	ZqMckFgWYrjRVjKA8jzYA25SUngWyjykrW5NCU4GXuaV8EsOrr2KAarMl3EdPhSW3g8XpKrmSYlv6
	ciLuHUf954Zvjb2gYM9Sq47XkcDR4aAGiMxt0cMlUbPNxZaUTn3ique7KKnAFOoJD0vuEtmRqgIoT
	bIE+Qf38xN88PLbWQ66BswF6EYIkwXWttM+uLr88MDp8ILoa7bCZNKFFmsHVKqOuMGrGP3jOWB8qZ
	O8nIIsMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r22Su-0066Sb-No; Sun, 12 Nov 2023 04:52:56 +0000
Date: Sun, 12 Nov 2023 04:52:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] buffer: Fix more functions for block size >
 PAGE_SIZE
Message-ID: <ZVBaKPHNM+9Ry7eq@casper.infradead.org>
References: <20231109210608.2252323-1-willy@infradead.org>
 <20231109210608.2252323-8-willy@infradead.org>
 <20231110045019.GB6572@sol.localdomain>
 <ZU49o9oIfSc84pDt@casper.infradead.org>
 <20231111180613.GC998@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111180613.GC998@sol.localdomain>

On Sat, Nov 11, 2023 at 10:06:13AM -0800, Eric Biggers wrote:
> On Fri, Nov 10, 2023 at 02:26:43PM +0000, Matthew Wilcox wrote:
> > Would you want to invest more engineering time in changing it?
> 
> It seems logical to just keep the existing approach instead of spending time
> trying to justify changing it to a less efficient one (divides).

Except the existing approach doesn't work for block size > PAGE_SIZE

