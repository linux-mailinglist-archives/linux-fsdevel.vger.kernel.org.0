Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6624C6F9CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 01:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjEGXUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 19:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGXUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 19:20:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F4C7681
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Th+cg1WdpxBjx+qFGjiozltRGL4jA5g/nbgL8pl9X58=; b=HSDc7/KbLBzgDwKMe/Nc82Ijd2
        P9PqS3fT7bgi5bvaLtQ/g0fOazuttTw3Q2/3bhq3oY9YPr8lLzhY7f/BHmpdzWePA5DB0scP9v5yS
        QZoHdGIkzzy6mTUk9Ig3DvUTYWC+2yJ3cBs058nFzgvQrhbU9FS8oQCgDcLjTWYiIAINVQWGqKqV/
        Ve3oJOl6gYGuhaojFej6JvcZAajNBxG/3l5VJzifphaVrglZ9E/t6zk6P+MkRbRr2aAUQNK58Yj3+
        nS12xEEyo19pgUMlA8F0yPgTDJSoeFFQeyPf44EfrDBy2PkPZo1UTfjULScBp+ET0mMD3ySZaib1V
        AYnkzgoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pvngI-00DcxA-4I; Sun, 07 May 2023 23:20:42 +0000
Date:   Mon, 8 May 2023 00:20:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF] Whither Highmem?
Message-ID: <ZFgySub+z210Rvsk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I see there's a couple of spots on the schedule open, so here's something
fun we could talk about.

Highmem was originally introduced to support PAE36 (up to 64GB) on x86
in the late 90s.  It's since been used to support a similar extension
on ARM (maybe other 32-bit architectures?)

Things have changed a bit since then.  There aren't a lot of systems
left which have more than 4GB of memory _and_ are incapable of running a
64-bit kernel.  We certainly don't see 64GB systems; maybe 8GB systems,
but 64-bit registers are cheap and if you're willing to solder 8GB of
RAM to the board, you're probably willing to splurge on a 64-bit ALU.

The objection might be raised that kmap_local() is cheap, and it is.
But when we have multi-page folios, particularly for filesystem metadata,
it gets awkward to use kmap because it only supports individual pages;
you can't kmap an entire folio.

So I'd like to explore removing support for keeping filesystem metadata
and page tables in highmem.  Anon memory and file memory should probably
remain supported in highmem.

Interested?
