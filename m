Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97267599F02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349753AbiHSPqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 11:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350265AbiHSPpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:45:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB5103637
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tw8kEMFFRbBUwts1QbL1tM2Tys2mNEpVsw+0+Hm+CxY=; b=RDtZCUrmOidmw/y4ynTuLO+0Sn
        Zv48f5Lcj2dW89zvMD3NRf861BK1XCYeE/gbbLaXBE/4JWgE0k0ghvOWDmD6P2R8eDwELBO08QTZR
        FC6iaja7ELLoNxLT3JMrlK3ZiN4gxblk8oUUGqD9hedu5BnQ7f2IC/qSdk0IOgfAYy1wVwhUeTNvr
        cyIXoGI+vKu3QJ2bh0tF8oIWRiu4hFv6KJyKB4IlsCLUfv5NTTFLrYYH7WKB11kLjVpmFgUPBGOtU
        NR2JoHv6MiouKLByKQDqzDq+2rhLapEpxlpptzXHMkbV6k9a1TFB8sHlQv8lrDyD7n7PtOwPZdyHj
        nMW1BeBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oP4BF-00BJ1L-GL; Fri, 19 Aug 2022 15:45:05 +0000
Date:   Fri, 19 Aug 2022 16:45:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] vmap_folio()
Message-ID: <Yv+wAS9JXbYvufaW@casper.infradead.org>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
 <Yv6qtlSGsHpg02cT@casper.infradead.org>
 <Yv9rrDY2qukhvzs5@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv9rrDY2qukhvzs5@pc636>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 12:53:32PM +0200, Uladzislau Rezki wrote:
> Looks pretty straightforward. One thing though, if we can combine it
> together with vmap(), since it is a copy paste in some sense, say to
> have something __vmap() to reuse it in the vmap_folio() and vmap().
> 
> But that is just a thought.

Thanks for looking it over!

Combining it with vmap() or vm_map_ram() is tricky.  Today, we assume
that each struct page pointer refers to exactly PAGE_SIZE bytes, so if
somebody calls alloc_pages(GFP_COMPOUND, 4) and then passes the head
page to vmap(), only that one page gets mapped.  I don't know whether
any current callers depend on that behaviour.

Now that I look at the future customers of this, I think I erred in basing
this on vmap(), it looks like vm_map_ram() is preferred.  So I'll redo
based on vm_map_ram().

