Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EDE518FD0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 23:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiECVPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 17:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiECVPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 17:15:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77AF40A18
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WPe7wnkFUKpUZBDi2c8e4iUxhhEPkpK//lI+1BIiKxc=; b=gJf6DHKp9qrf6SdlIMPf4cxX9U
        pCfXIlqxgCffbVWO3/hQtriNissfE3hjuR0inezAQq7yEbFNz/pneU93wSgS1OcM9CBi/EYH9MPI3
        DlFx5H3qXOf5+UShQoreJyZ66d95Qizo9wgu2abTWykPc6QfcPUbiYwIreT+xWOCT7kHopyMDt/81
        EOgKH7qs+W0PWeh9ZkUTyOZxLiq3jwJvFx3W3BBnZamrkAXSS2S7uuvK9OCjUPvANi+zv9T04DaSj
        a6s74dlOJIudqwKNeTiyAaaQ/SC9fEw6vTs5GyATSVygggJ6An1m6jezUwGCjJLO69c+zVC2aQSru
        DAtQSV1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlzoW-00Fxxz-17; Tue, 03 May 2022 21:12:08 +0000
Date:   Tue, 3 May 2022 22:12:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/69] scsicam: Fix use of page cache
Message-ID: <YnGap/hM8d2h8hCC@casper.infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
 <20220429172556.3011843-2-willy@infradead.org>
 <YnE9vaA14JqqbD1W@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnE9vaA14JqqbD1W@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 07:35:41AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 29, 2022 at 06:24:48PM +0100, Matthew Wilcox (Oracle) wrote:
> > Filesystems do not necessarily set PageError; instead they will leave
> > PageUptodate clear on errors.  We should also kmap() the page before
> > accessing it in case the page is allocated from HIGHMEM.
> 
> The PageError to PageUptodate change looks sane.  But block device
> page cache absolutely must not be in highmem, so I don't see a point
> in the kmap conversion here.

Huh, I didn't know that.  I think I've seen that some filesystems also
require non-highmem pages for directory or symlink inodes.

Coincidentally, I was in Ira's session earlier today where he was
talking about reusing/abusing kmap/kmap_local/kmap_atomic to implement
protection keys.  I'm not entirely sold on the concept, but something
like this might also be useful for a CHERI-style architecture.

I'm kind of inclined to say "We should always kmap() anything we get from
the page cache to support the unmapped-by-default case" because it's not
exactly expensive to call kmap() on a page which is permanently mapped.
I dunno.
