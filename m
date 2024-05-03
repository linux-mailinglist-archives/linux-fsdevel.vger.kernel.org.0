Return-Path: <linux-fsdevel+bounces-18665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09528BB346
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 20:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D611F23001
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF2158A3F;
	Fri,  3 May 2024 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VCBbHlyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D963C8;
	Fri,  3 May 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761036; cv=none; b=ZrV9ZjV8J50j2bqFWOG7RLAK3PfZz0/5JZsI3T2R9EG/BPPT9pEX2RSD9EeRFHZn0OmZGIu5mvdOEMokc+3WMzP3JXvh3L7s8H9wbHgfTbQLnm/3nbFOA5AX7I0jVGX11oOjhnI4POc+TU04smQim8Sp6S3nTjCAPna9CfAhUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761036; c=relaxed/simple;
	bh=EAIFxHaAPyzBkAmVKi0pTDTDrJz6VOKyp8xDUa6EGxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qej4WezhDYIFFxAm67chM6o6EsBG4FYtDc4KSLHNL+HczaFPsVeNe4Xiu13i0SO1kJf/feOG2EURMoS1aXaqtMUalGF5/h7BLcZhCctF+eo5NB1VLSVXWy9SDa/nAZFXP4fwWpljswyqf7kZgnitQxA8dwZSPrUXTSUjqHnd/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VCBbHlyh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zKeJhkU6mpI7ErDHj+NeL+Ui4doyR9klcioh+DXyEI8=; b=VCBbHlyhWvXWMO1qyc4byN9D9w
	nr977TGODc/Ug/XTU/gvgWUmzs+xWcTN5GESoUVd/JCrlsfK+vVe0Jjpr59GXzZAY0Q7Z3XewwiTu
	v+JqXvszMjQFgnWbBoCn6cLNtHxR2ZBQO7TVAZN/xy/IW617g/4UTtkjgJXjKU+CXiryqud80CvsS
	MzekiuF4I0vc5ZBuZxFOwxXj0o1neUh/kv51T4twXP/zGgkPi1wSvnXvo2wEokSNlDLLCYmwU4Frq
	tf41kO+7h+HP1FHAZmXMQifOEzOwgZi7BDUMjY2B+mEVSW+gOsIFGJJPdFMy/9L5q4meW8QC1L2h9
	BoSErFUw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2xg0-00000004eQX-1yn7;
	Fri, 03 May 2024 18:30:32 +0000
Date: Fri, 3 May 2024 19:30:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 2/4] gfs2: Add a migrate_folio operation for journalled
 files
Message-ID: <ZjUtSAxhcMnQ71fO@casper.infradead.org>
References: <20240403172400.1449213-1-willy@infradead.org>
 <20240403172400.1449213-3-willy@infradead.org>
 <CAHc6FU6gdBq5+GYqcxUEfvypTokAsoGWSEt19jJUyBpVXW5myw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU6gdBq5+GYqcxUEfvypTokAsoGWSEt19jJUyBpVXW5myw@mail.gmail.com>

On Thu, May 02, 2024 at 10:23:41PM +0200, Andreas Gruenbacher wrote:
> On Wed, Apr 3, 2024 at 7:24 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> > For journalled data, folio migration currently works by writing the folio
> > back, freeing the folio and faulting the new folio back in.  We can
> > bypass that by telling the migration code to migrate the buffer_heads
> > attached to our folios.
> 
> This part sounds reasonable, but I disagree with the following assertion:
> 
> > That lets us delete gfs2_jdata_writepage() as it has no more callers.
> 
> The reason is that the log flush code calls gfs2_jdata_writepage()
> indirectly via mapping->a_ops->writepage. So with this patch, we end
> up with a bunch of Oopses.
> 
> Do you want to resend, or should I back out the gfs2_jdata_writepage
> removal and add the remaining one-liner?

Ugh, I see.  If you could just add the one-liner for now, and I'll
come back with a better proposal next for merge window?

