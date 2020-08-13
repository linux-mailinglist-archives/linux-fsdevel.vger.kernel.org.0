Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FE243501
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMHcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 03:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMHcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:32:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABFAC061757;
        Thu, 13 Aug 2020 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KE27V78qJ9a8klzzlEspRBRIF40eqdSrExhzvQy0kE0=; b=vCR4Gd11/yGpNdBXSelbvdLmTu
        QPF25lxC1ic9Mcj29jqocIi8aR8tMq8oGp344hFIU7chBD0axr6vwTFewpeLQnQoNAtZRatbNudLM
        zUGv9mJx0nNquf277HQeRcoMQl6QZvsjidevQRpama8DAcTAQPejBy/0E7UJuONzKGd47ItrvVSTV
        NOMub8Yt4nBPziHuiGI2xd4FDZAfHJg8sgaioJt4RRb+S2o06mQTrh9Cg2iEz1xwEJtmoN1Uqjnsa
        OjJyWchE4uBqASv+8qjozmuavQr7hPCKVnobvW/urV85/xMq7zxyVj4iUjU7FwlmS2kUyrw9uTubg
        hbicJvbQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k67im-0004CU-Ka; Thu, 13 Aug 2020 07:32:20 +0000
Date:   Thu, 13 Aug 2020 08:32:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/select.c: batch user writes in do_sys_poll
Message-ID: <20200813073220.GB15436@infradead.org>
References: <20200813071120.2113039-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813071120.2113039-1-dja@axtens.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:11:20PM +1000, Daniel Axtens wrote:
> When returning results to userspace, do_sys_poll repeatedly calls
> put_user() - once per fd that it's watching.
> 
> This means that on architectures that support some form of
> kernel-to-userspace access protection, we end up enabling and disabling
> access once for each file descripter we're watching. This is inefficent
> and we can improve things by batching the accesses together.
> 
> To make sure there's not too much happening in the window when user
> accesses are permitted, we don't walk the linked list with accesses on.
> This leads to some slightly messy code in the loop, unfortunately.
> 
> Unscientific benchmarking with the poll2_threads microbenchmark from
> will-it-scale, run as `./poll2_threads -t 1 -s 15`:
> 
>  - Bare-metal Power9 with KUAP: ~48.8% speed-up
>  - VM on amd64 laptop with SMAP: ~25.5% speed-up
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Seem like this could simply use a copy_to_user to further simplify
things?

Also please don't pointlessly add overly long lines.
