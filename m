Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD47411C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjF1Myj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjF1Mwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:52:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149332D6D
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=42xghz0j22EsuTLgkBbHB9SBQnDShLaZhIRL1rr/Uvw=; b=Gw4Oc+Pd/feH7hbDuP4d9g4MVE
        YROBmukuhZyrlSJuVrTDeMlWbgB1kyH4/gHYt0pcXz4fUL0DL+mGt3B7wnSf7+/ZcT9BgKrlmQjGB
        wIaJ8kIpGGWNmiDsNjLJcysx4XA/zA6bpsXtTo63P4sjG8sCYtXgpPqZO2JoPuhg5bYRHl2w58Lzv
        TLMQJdCphzMdbWRVAoHYGF8F2JboNhtJNKxRQAgJGy2D35K2dphj8dZ89zj6MfTkeE2ERir6E11jc
        F6t3KUzIVfsUbYaIeiYFkdI6+1+mV5TVx5yQlxTbMieTc8qCgnaSJeAL2zF3IKZF0hAHfd2SYEa8J
        yTqF8o8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEUe9-003mfn-BS; Wed, 28 Jun 2023 12:51:45 +0000
Date:   Wed, 28 Jun 2023 13:51:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and
 FALLOC_FL_PUNCH_HOLE
Message-ID: <ZJws4Yr9tcaF7Mis@casper.infradead.org>
References: <ZJvsJJKMPyM77vPv@dread.disaster.area>
 <ZJq6nJBoX1m6Po9+@casper.infradead.org>
 <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
 <3299543.1687933850@warthog.procyon.org.uk>
 <3388728.1687944804@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3388728.1687944804@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:33:24AM +0100, David Howells wrote:
> Would you consider it a kernel bug, then, if you use sendmsg(MSG_ZEROCOPY) to
> send some data from a file mmapping that some other userspace then corrupts by
> altering the file before the kernel has managed to send it?

I think there's a difference in that sendmsg() will block until it
returns (... right?)  splice() returns.  That implies the copy is done.
Then the same thread modifies the file, but the pipe sees the new
data, not the old.  Doesn't that feel like a bug to you?

