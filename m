Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170CA6606F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 20:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjAFTNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 14:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAFTNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:13:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFB868799;
        Fri,  6 Jan 2023 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4fFJTo3td0EaVTFdM5bjLZ2rfCzevY+CZk+c5LeFYls=; b=gBTyIAy13xD19rRq3HNUq2LAQA
        9519MzZCt8oZpCQDgIUYkvArms/BnXH5g0qNTXpM204LENwQnaf7n9L1f71TQRbBTdP/GfPUFoQGf
        sYd0v+Uqz/Z50GBoNO9rtisMhd2JxoKzyL+K+hWyUpCKTgib667xXZrI7qBeYhiapb7APoEGZlSjN
        EH4XR8rEn5nJo5f4ncJjf/fYGjOxOkoTOR60ShDJatQPocMEc8ByQF8lRGUlD+ZeZiDf2n5Rvv4rA
        9NA+JTBhKSwM5zNDgs4oTLxfxbZGx8JkhmbDWO5xjstPxpw8m59i5n/za4+zeKCyvyDRxUHqSVzDO
        oE7LCFDQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDs9L-00EYJA-Gb; Fri, 06 Jan 2023 19:13:07 +0000
Date:   Fri, 6 Jan 2023 11:13:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-ID: <Y7hyw+fTdgAF6uYP@bombadil.infradead.org>
References: <20230106094844.26241-1-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106094844.26241-1-zhanghongchen@loongson.cn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:44PM +0800, Hongchen Zhang wrote:
> Use spinlock in pipe_read/write cost too much time,IMO
> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> On the other hand, we can use __pipe_{lock,unlock} to protect
> the pipe->{head,tail} in pipe_resize_ring and
> post_one_notification.
> 
> I tested this patch using UnixBench's pipe test case on a x86_64
> machine,and get the following data:
> 1) before this patch
> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> Pipe Throughput                   12440.0     493023.3    396.3
>                                                         ========
> System Benchmarks Index Score (Partial Only)              396.3
> 
> 2) after this patch
> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> Pipe Throughput                   12440.0     507551.4    408.0
>                                                         ========
> System Benchmarks Index Score (Partial Only)              408.0
> 
> so we get ~3% speedup.
> 
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---

After the above "---" line you should have the changlog descrption.
For instance:

v3:
  - fixes bleh blah blah
v2:
  - fixes 0-day report by ... etc..
  - fixes spelling or whatever

I cannot decipher what you did here differently, not do I want to go
looking and diff'ing. So you are making the life of reviewer harder.

  Luis
