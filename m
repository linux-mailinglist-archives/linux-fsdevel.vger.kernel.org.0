Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4D73FEF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjF0Ovi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 10:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjF0OvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:51:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC8346BB;
        Tue, 27 Jun 2023 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2q4n1zKRqrV3v5scjVFFq+TN6vQz15i/WxunL9evbOk=; b=PadBDPEnw+r1U1a2NesSR9R0J3
        4D4avMQnSzeeXMJTw4OZDlNRLAzlJoOTXBDCcYfMfgwnucu67fcOxbkZFax5h9PwM9a3oI3GEIw4n
        afRibzDA8+iYgWNTFxz5G9rROJXu4Acexu3PWFqA6XyZ4uMs8CYgWcmxlzch9cLoODVgX3GD9crJc
        D/b9QFOo77xyhUvjS68Fso+p5um4Dw3z05lScl7baFip/xNorcmYi67oqcV2tXXdJu7nf75qFy5fO
        gzpa+fFMOviRbwqTPE80Hm22Yo8vcBphziqcI6qLzanIu8lSi+Den6TujPfHnRibWe9W7aGMFa1hG
        DHt63sZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qE9zS-002oS5-26; Tue, 27 Jun 2023 14:48:22 +0000
Date:   Tue, 27 Jun 2023 15:48:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 03/12] writeback: Factor should_writeback_folio() out of
 write_cache_pages()
Message-ID: <ZJr2tr30FhGcwVR3@casper.infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-4-willy@infradead.org>
 <ZJphl4Ws4QzitTny@infradead.org>
 <ZJrFEto4BbLB+ubt@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJrFEto4BbLB+ubt@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:16:34PM +0100, Matthew Wilcox wrote:
> This might be a good point to share that I'm considering (eventually)
> not taking the folio lock here.
> 
> My plan looks something like this (not fully baked):
> 
> truncation (and similar) paths currently lock the folio,  They would both
> lock the folio _and_ claim that they were doing writeback on the folio.
> 
> Filesystems would receive the folio from the writeback iterator with
> the writeback flag already set.
> 
> 
> This allows, eg, folio mapping/unmapping to take place completely
> independent of writeback.  That seems like a good thing; I can't see
> why the two should be connected.

Ah, i_size is a problem.  With an extending write, i_size is updated
while holding the folio lock.  If we're writing back a partial folio,
we zero the tail.  That must not race with an extending write.  So
either we'd need to take both the folio lock & wb_lock when updating
i_size, or we'd need to take both the lock and wb_lock when writing
back the last page of a file.
