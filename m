Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22F73CF53A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhGTGlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhGTGk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:40:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E4CC061574;
        Tue, 20 Jul 2021 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S44fEA8PhBtw3MXYTKBDeHZUQIviCFCTf/RdbSRDWZw=; b=clK5qvXwHzzWiyHuOVLO/6Wvfk
        whaNOohg2PsOYJsynI1r4aQisEQ1EqkKu3n3m6Yl/tiVQTxmsLg0/O++ey0Wi1P6asPInkhfdkOT0
        EkrlCrYm6LvAk8mdnkghIBXO4JpfZeEEn+Y9wKOzIJ7Osh8vUIq/b865OEWDjRhNeczJb3B49tlDj
        mdLxXIwfJnFAKA1uOCNymPudbF7lkca8nq/QMJzZR87iVkKIHi8/EyM2dJ7IWNguusy2lbL3KCYoW
        vvOLy5RW2aUwEcNG5as5o6JmtlsuvjtPyiGOSfByRijROgEh1YqbAPpa5Jf5N1waPF3iTRY0DKTP9
        TATPjFDg==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5k3Y-007rjO-38; Tue, 20 Jul 2021 07:20:58 +0000
Date:   Tue, 20 Jul 2021 09:20:43 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 16/17] iomap: Convert iomap_add_to_ioend to take a
 folio
Message-ID: <YPZ5S35wRlp3lMqY@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:40:00PM +0100, Matthew Wilcox (Oracle) wrote:
> -	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
> -			&same_page);
>  	if (iop)
>  		atomic_add(len, &iop->write_bytes_pending);
> -
> -	if (!merged) {
> -		if (bio_full(wpc->ioend->io_bio, len)) {
> -			wpc->ioend->io_bio =
> -				iomap_chain_bio(wpc->ioend->io_bio);
> -		}
> -		bio_add_page(wpc->ioend->io_bio, page, len, poff);
> +	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
> +		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
> +		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
>  	}

I actually have pretty similar changes for the red and write path to
avoid __bio_try_merge_page in my queue.  I'll send them out ASAP as
I think such a change should be done separately from the folio
switch.

>  	/*
> -	 * Walk through the page to find areas to write back. If we run off the
> -	 * end of the current map or find the current map invalid, grab a new
> -	 * one.
> +	 * Walk through the folio to find areas to write back. If we
> +	 * run off the end of the current map or find the current map
> +	 * invalid, grab a new one.

Why the reformatting?

Otherwise this looks sane to me.
