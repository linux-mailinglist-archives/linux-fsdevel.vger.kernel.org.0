Return-Path: <linux-fsdevel+bounces-43555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B67A58848
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 21:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA49D16B026
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 20:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055321D3F7;
	Sun,  9 Mar 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m22jmojt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3A136351;
	Sun,  9 Mar 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741553881; cv=none; b=vAJZa7w/Yi1Yktkds/AOuPeG9KOU7IdJHog73yPvgxftFq8uQOAYd22AG1Ztq7hZd8CyVKDk4XQYjp2ggYg9xYIdOGDeviLqlRxa+t8a0mhaSNgCIUml0o7KfgdKeWAP1IF90PlYzNkUEG0eYFe0eOpcxbhFjRQS9KasXaUpuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741553881; c=relaxed/simple;
	bh=RtOQ3Ysv0H5cZnf8XlgxEXCv2n3+apWNk/IeBfHAlJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxRlvSlK2rdB5crHQKYhG8wgn86XyUXJ8eFua/Q9ByphM65H6KrOaXPvSaEvwRa3sCRRdrcH8Ubr428gnkOeGuw5Z4FE6BRXoRHa62P9nswLNL2OJ3e4rhz9IfoGefsKXvlypLchpojmuX/dB32+EIbSSgU9vgNJojDn+P+EicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m22jmojt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gjePp6wFm8YT6TWX23VF1tMZMC00OqOhmAHrzAnyTj8=; b=m22jmojt33FzwcEsotRLyat8VN
	tvPj98yHkIKZikLQ84qmq2f8bn2thLVpeDH0c8j8YUpfz+vstw/i6ia5pCiDuIVKNhtuVUWQQ3j8x
	SPpiPCYri+T9/8d6y5aINgssKtiyS10H4vkNxkYCyKJP/F56ONLik61l13YqYy7lsvdIkENOEsm6w
	WodWDefLtqAStrCwsKWmJuVNTx21rz1TNHd4QGrdx1c/SAUaTfl827YDmjotJZo5V3/5xDbt6eDoC
	k71sr1q23mpym2cgzzFcn0OtgMUvDxPyVCqujGXoZFO4Nh0TI9C5Xf3gKlWbhw0rIFyf4aL1lNS1v
	/TkhPmig==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trNiV-00000007YrL-0dGX;
	Sun, 09 Mar 2025 20:57:47 +0000
Date: Sun, 9 Mar 2025 20:57:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/8] gfs2: Convert gfs2_end_log_write_bh() to work on a
 folio
Message-ID: <Z84Ay7gj2JQMUuRE@casper.infradead.org>
References: <20250210133448.3796209-1-willy@infradead.org>
 <20250210133448.3796209-8-willy@infradead.org>
 <CAHc6FU5GrXSfxiRyrx_ShR7hJkCMaQD=k-mhTJ37CzbUMR68dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU5GrXSfxiRyrx_ShR7hJkCMaQD=k-mhTJ37CzbUMR68dQ@mail.gmail.com>

On Sun, Mar 09, 2025 at 06:33:34PM +0100, Andreas Gruenbacher wrote:
> On Mon, Feb 10, 2025 at 2:35 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> > gfs2_end_log_write() has to handle bios which consist of both pages
> > which belong to folios and pages which were allocated from a mempool and
> > do not belong to a folio.  It would be cleaner to have separate endio
> > handlers which handle each type, but it's not clear to me whether that's
> > even possible.
> >
> > This patch is slightly forward-looking in that page_folio() cannot
> > currently return NULL, but it will return NULL in the future for pages
> > which do not belong to a folio.
> >
> > This was the last user of page_has_buffers(), so remove it.
> 
> Right now in for-next, ocfs2 is still using page_has_buffers(), so I'm
> going to skip this part.

How odd.  I see it removed in 1b426db11ba8 ecee61651d8f 0fad0a824e5c
414ae0a44033 and all of those commits are in 6.14-rc1.

$ git show v6.14-rc1:fs/ocfs2/aops.c |grep page_has
(no output)

