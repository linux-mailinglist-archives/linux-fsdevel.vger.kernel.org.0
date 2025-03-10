Return-Path: <linux-fsdevel+bounces-43564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E940BA58AE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 04:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0681697FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 03:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACA834CF5;
	Mon, 10 Mar 2025 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VH5dgrcs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6EC28F5;
	Mon, 10 Mar 2025 03:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741578379; cv=none; b=kzjgYnd798e/hLlCNV+w5GRLqWEypvwRYpM/QA6YYbn46816+gY9+heHjqNowRaF3T32wsvdaOOy3RC4F+Kirt1Hg01ZmAboexTmKK5wMSyUScS3uxrbvv8PBBSfkWi/wQPFXdK2INx2f0Fm/AsfDIBVox6EW0aq56gK5FjhzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741578379; c=relaxed/simple;
	bh=th7eu9057QYYzVjhaqqmKYNC4O6U+v7938LwRE7BALk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRhGrluFVBJRrgDVRbawZEltXVmDUnYvS8sfJiqGA7NjiIsUJI4EDLyZc4nVzUfP2H6WYKe54+fA4UIpEpRwtgyBGCW/8mf/zrrN9T3sAY2HkeHm/FE4Wb0KBycddWSxnhTaK0N2EBlPXPVBaY6Vd9PGQ+eSTmq1LprwZDKwcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VH5dgrcs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ALMu6quBRPl8ZxozLsps77wa4AR7GWlhwAneA5Pu/AI=; b=VH5dgrcsG4eRAMsyo8HsyyTSj3
	+O8kdyqPwYQu1z885SYvQEIRuxPBfA0WVNYNPBleI8B2bU9RHt2vahTBI6w5KQfOslAuLLCMO41hS
	vBhlimhe+UivEhl3xG+Usk2togFzsVUaUXwGI6O0mFmUFtw7NYsU8HFtgyA7gNNh6R9yQUwuZT/Fe
	UScQhoqvv+hKRo2/g9D8Zg5VNigB130wo3YrpxnHO7HZh3E5aaHAMjdbIUYCGm2CdOlIboObxG9zb
	H6M8kdiPJCJAvSDRHNMv3yA0ZT/59pNaBqyS7qdAX00RgS1cwFlS/B2G6LL821JxZZnKQQV6mRoEo
	7R7WNpvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trU5h-0000000Gc9B-1YrI;
	Mon, 10 Mar 2025 03:46:09 +0000
Date: Mon, 10 Mar 2025 03:46:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/8] gfs2: Convert gfs2_end_log_write_bh() to work on a
 folio
Message-ID: <Z85gf3GfqNX3enPs@casper.infradead.org>
References: <20250210133448.3796209-1-willy@infradead.org>
 <20250210133448.3796209-8-willy@infradead.org>
 <CAHc6FU5GrXSfxiRyrx_ShR7hJkCMaQD=k-mhTJ37CzbUMR68dQ@mail.gmail.com>
 <Z84Ay7gj2JQMUuRE@casper.infradead.org>
 <CAHc6FU5TcVWAOH+Yu1Q0v2j363NXnm8cd2cA0_ug14MmdTtzqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU5TcVWAOH+Yu1Q0v2j363NXnm8cd2cA0_ug14MmdTtzqw@mail.gmail.com>

On Sun, Mar 09, 2025 at 10:53:29PM +0100, Andreas Gruenbacher wrote:
> On Sun, Mar 9, 2025 at 9:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Sun, Mar 09, 2025 at 06:33:34PM +0100, Andreas Gruenbacher wrote:
> > > On Mon, Feb 10, 2025 at 2:35 PM Matthew Wilcox (Oracle)
> > > <willy@infradead.org> wrote:
> > > > gfs2_end_log_write() has to handle bios which consist of both pages
> > > > which belong to folios and pages which were allocated from a mempool and
> > > > do not belong to a folio.  It would be cleaner to have separate endio
> > > > handlers which handle each type, but it's not clear to me whether that's
> > > > even possible.
> > > >
> > > > This patch is slightly forward-looking in that page_folio() cannot
> > > > currently return NULL, but it will return NULL in the future for pages
> > > > which do not belong to a folio.
> > > >
> > > > This was the last user of page_has_buffers(), so remove it.
> > >
> > > Right now in for-next, ocfs2 is still using page_has_buffers(), so I'm
> > > going to skip this part.
> >
> > How odd.  I see it removed in 1b426db11ba8 ecee61651d8f 0fad0a824e5c
> > 414ae0a44033 and all of those commits are in 6.14-rc1.
> >
> > $ git show v6.14-rc1:fs/ocfs2/aops.c |grep page_has
> > (no output)
> 
> Hmm, you're right, it's only that automatic test that's based on an
> older kernel. Sorry for the confusion.

Looks like your for-next doesn't include v6.14-rc1.

gfs2            104b4d597ff21b923b1e963c5793efcadeae047e

is the entry in SHA1s for next-20250307.  And:

$ git log v6.14-rc1 ^104b4d597ff21b923b1e963c5793efcadeae047e
shows quite a lot of commits (9847 of them).  So I think you didn't pull
from Linus before branching for the v6.15 merge window.  Not sure how
you manage your trees and how you'd like to improce this situation
(do you rebase?  Do you want to bring in a merge commit of some -rc
version?  If so, which one?)

