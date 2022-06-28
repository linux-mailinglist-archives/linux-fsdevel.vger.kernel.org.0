Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8E55ECCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiF1Slk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 14:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiF1Slj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:41:39 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E1E22B30
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+rJ5ChPJBcey/2CAv22XxejWQCh1WczXzKtC7mYHzz8=; b=i05lw8chAPcIAg1vH6au9fCeTu
        d7qkH2fJg8ddjNnArN/BPmHDgZBHnRiu90bLgNrM13aaCm5XTrCvRt3p9jZAlsfB4BciPTeWdO+2X
        c+Pzu884QoevHjREk4DdvD+IGEIbqcHjziB00Vb0L2s2Foq6LVU5Y6mzYmtnL1qGvl9m9GMaVdDmB
        A9yBL54Q5bmyjWCpejs66FGayhWlloRqTQYMuB9jCerADyxHJXvQsCOOo5vRdVL4yAtvmwrrss9kq
        /tl6FQlyxxp1EyyDxfkEyOzE/kJJpidjr4k04BFmz1Z18l5taEQHsyFLvI+ADPYdyRZp/b9X6+9yS
        64n8CQhw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o6G9Y-005iEH-Nw;
        Tue, 28 Jun 2022 18:41:36 +0000
Date:   Tue, 28 Jun 2022 19:41:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 09/44] new iov_iter flavour - ITER_UBUF
Message-ID: <YrtLYIrlwGrlzXNi@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-9-viro@zeniv.linux.org.uk>
 <07ad7be25bab03c164bbd1f2d2264c9e6f79b70d.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ad7be25bab03c164bbd1f2d2264c9e6f79b70d.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:47:03PM -0400, Jeff Layton wrote:
 
> The code looks reasonable but is there any real benefit here? It seems
> like the only user of it so far is new_sync_{read,write}, and both seem
> to just use it to avoid allocating a single iovec on the stack.

Not really - for one thing, it's less overhead in data-copying primitives,
for another... Jens had plans for it as well.  It's not as simple as "just
use it whenever you are asked for a single-segment iovec", but...
