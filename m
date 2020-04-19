Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D375B1AF728
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 07:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSFQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 01:16:27 -0400
Received: from sonic307-37.consmr.mail.ne1.yahoo.com ([66.163.190.60]:42653
        "EHLO sonic307-37.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgDSFQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1587273386; bh=EE5KmZfn+FhHPKg6HDMjuPQl02xYs/YXlEDU6CDvLqo=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=lYKsslkX6edtbR8PA879u9pUDi/L63ItI49iYAfLUqTRQbLpx84Tul5gjklzZWQAA5rC7xylHZ8ZpOAPJXM/ghn3FybcIewCGPpan/Jnx3HQ+Ed+jcanmPgAUikn4pu3SxibWdc+IRWkWR+35vzar+fiG8qznXFk4GoJ5ws6EvrldgsDUE55tagqB9/6uA4eYDXS5M9TpkTZAgrC8ZT+5TxS35gCMh0kBURi7y+pYozxLnT2QcTnz4rPirG0X2AKomqslX5I7ncEh5kifX00NMupe/NWHYpROVPdp5vl8VFxn6Taun0kUY4uUjUMDJskbH9YEyFBNUC65BYrpt+NMw==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sun, 19 Apr 2020 05:16:26 +0000
Received: by smtp410.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b56449d512ead8487e4fcc13b444aa07;
          Sun, 19 Apr 2020 05:14:24 +0000 (UTC)
Date:   Sun, 19 Apr 2020 13:14:14 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
Message-ID: <20200419051404.GA30986@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200419031443.GT5820@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419031443.GT5820@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15651 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 08:14:43PM -0700, Matthew Wilcox wrote:
> On Sun, Apr 19, 2020 at 12:51:18AM +0200, Guoqing Jiang wrote:
> > When reading md code, I find md-bitmap.c copies __clear_page_buffers from
> > buffer.c, and after more search, seems there are some places in fs could
> > use this function directly. So this patchset tries to export the function
> > and use it to cleanup code.
> 
> OK, I see why you did this, but there are a couple of problems with it.
> 
> One is just a sequencing problem; between exporting __clear_page_buffers()
> and removing it from the md code, the md code won't build.
> 
> More seriously, most of this code has nothing to do with buffers.  It
> uses page->private for its own purposes.
> 
> What I would do instead is add:
> 
> clear_page_private(struct page *page)
> {
> 	ClearPagePrivate(page);
> 	set_page_private(page, 0);
> 	put_page(page);
> }
> 
> to include/linux/mm.h, then convert all callers of __clear_page_buffers()
> to call that instead.

Agreed with the new naming (__clear_page_buffers is confusing), that is not
only for initial use buffer head, but a generic convention for all unlocked
PagePrivate pages (such migration & reclaim paths indicate that).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mm.h?h=v5.7-rc1#n990

Thanks,
Gao Xiang


> 
