Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FB9248CDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 19:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgHRRWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 13:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgHRRWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:22:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F4C061389;
        Tue, 18 Aug 2020 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=FmYiny6Y/5Pb9ex+9gFqdnDzd6qjJ/9YMPjKhe0IpLs=; b=vIKfUHvR8qR+mc1Y3Fjx/q0wdX
        3YPNaWSCjfBBPPOIdcg+F8lKPTsWE3Gso7LDXqquj1HdackjHYKSUk4CxjagslhjORjr1Wvh+xkec
        u6qSmQ7pSyFLtkDX80qBY4H9T46dn4TGzOY8JpOR0d5Rn9PdRTX9Qg4RpwrZVEJLFIBcmrY2SSMaz
        Fjg239Kr8MnU0F/hBC0z0aTbcjJtXK+CitsJUz2IXSadkW72AVYIxChgdbxtlnxwTmSpieWjAPSDF
        e58sdWyUQtfwWKpuDXXIc8hEZ4M8vdRe/pmyC8I16JuN9IJQB8vWVuHbDIf8ktfhw2hrlmY7eDQZb
        2q12yXPg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k85Jf-0004wk-68; Tue, 18 Aug 2020 17:22:32 +0000
Date:   Tue, 18 Aug 2020 18:22:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Support for I/O to a bitbucket
Message-ID: <20200818172231.GU17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One of the annoying things in the iomap code is how we handle
block-misaligned I/Os.  Consider a write to a file on a 4KiB block size
filesystem (on a 4KiB page size kernel) which starts at byte offset 5000
and is 4133 bytes long.

Today, we allocate page 1 and read bytes 4096-8191 of the file into
it, synchronously.  Then we allocate page 2 and read bytes 8192-12287
into it, again, synchronously.  Then we copy the user's data into the
pagecache and mark it dirty.  This is a fairly significant delay for
the user who normally sees the latency of a memcpy() now has to wait
for two non-overlapping reads to complete.

What I'd love to be able to do is allocate pages 1 & 2, copy the user
data into it and submit one read which targets:

0-903: page 1, offset 0, length 904
904-5036: bitbucket, length 4133
5037-8191: page 2, offset 942, length 3155

That way, we don't even need to wait for the read to complete.

I envisage block allocating a bitbucket page to support devices which
don't have native support for bitbucket descriptors.  We'd also need a
fallback path for devices which don't support whatever alignment the
I/O is happening at ... but the block layer already has support for
bounce-buffering, right?

Anyway, I don't have time to take on this work, but I thought I'd throw
it out in case anyone's looking for a project.  Or if it's a stupid idea,
someone can point out why.
