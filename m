Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225E559125F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbiHLOjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiHLOjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:39:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E47AB1A0;
        Fri, 12 Aug 2022 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nl22ri9kHmMuIubWl/UE+mk2gjOsQI14vnHU03BPY2c=; b=DNAeDjtEj3AHpgo4A35DscYxuA
        whf9njf+SpKaEK7vGO5sx+p9ais31qhu5+OODJJKgNbrjKh3N4yFC1QEse0T5OPXFNA8sWzRzWL/g
        frfrWN/Y13ElYhhSbdbaADnIxg2Q5vhahHpHYbjKZwColXx4DEhObfIsBFH89RwgxZRRIouDAHuFg
        sKEKtJ+cMF4JriKoj8J700K8cn15jJSxWYeytFXu8eQJfeHzzmNhF5SG1RSADUudu1i7solC3vGPM
        t9tgKL7kpCfa9L+7PDnv7n0dciKZdun3GnzQehWxtY4lgRhe7HVnAYRKFDRzFlth6qYDbrH7C7thf
        Qd5gyLRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMVob-002Fh9-BR; Fri, 12 Aug 2022 14:39:09 +0000
Date:   Fri, 12 Aug 2022 15:39:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: State of the Page (August 2022)
Message-ID: <YvZmDfSFMydiulzw@casper.infradead.org>
References: <YvV1KTyzZ+Jrtj9x@casper.infradead.org>
 <20220812101639.ijonnx7zeus7h2hn@box.shutemov.name>
 <YvZW/exP02XceTVl@casper.infradead.org>
 <20220812143356.4kv5cycwbcy2t7ul@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812143356.4kv5cycwbcy2t7ul@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 05:33:56PM +0300, Kirill A. Shutemov wrote:
> If you really need info about these pages and reference their memdesc it
> is likely be 9 cache lines that scattered across memory instead of 8 cache
> lines next to each other in the same page.

Well, hopefully not.  Most allocations should be multiple pages.  That's
already true for slab, netpool and file (for xfs anyway), and hopefully
soon for anon.

> Initially, I thought we can offset the cost by caching memdescs instead of
> struct page/folio. Like page cache store memdesc, but it would require
> memdesc_to_pfn() which is not possible, unless we want to store pfn
> explicitly in memdesc.

I think we do, at least for some memdescs.  File folios definitely want
to store the pfn, but I don't think getting the PFN for a slab is a
common operation (although we'll still need to store the pointer to
the struct page, so it's equivalent).

> I don't want to be buzzkill, I like the idea a lot, but abstractions are
> often costly. Getting it upstream without noticeable performance
> regressions going to be a challenge.

I don't think there's a way to find out whether it'll be a performance
win without actually doing it.  Fortunately, the steps to get to this
point are mostly good cleanups anyway.

