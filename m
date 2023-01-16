Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8703066D1A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 23:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjAPWRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 17:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjAPWQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:16:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9DD274A8;
        Mon, 16 Jan 2023 14:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6947DB80FCD;
        Mon, 16 Jan 2023 22:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D545C433D2;
        Mon, 16 Jan 2023 22:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673907370;
        bh=fAp1RRQ1TQOiJxJ6yT+4EP8DpJCt64A2ozBpATDf7rI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QkjDoSgF01hWN5FO0jMvhEH/X64ZCw5Y3ulmkynnXYc0jhMJQc9O7SYgKgIs7LG8Z
         fYIcnx3D94RJZEYA2yBZUNrNy92TbIwL/Ok2FnofVwE99D7o2IP2fybuTZclXoOm53
         O5bfq4XlXJgh01NrSpdWb54fADzJYKLvyvPWQopM=
Date:   Mon, 16 Jan 2023 14:16:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        maobibo <maobibo@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        David Howells <dhowells@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-Id: <20230116141608.a72015bdd8bbbedd5c50cc3e@linux-foundation.org>
In-Reply-To: <Y8W9TR5ifZmRADLB@ZenIV>
References: <20230107012324.30698-1-zhanghongchen@loongson.cn>
        <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn>
        <4b140bd0-9b7f-50b5-9e3b-16d8afe52a50@loongson.cn>
        <Y8TUqcSO5VrbYfcM@casper.infradead.org>
        <Y8W9TR5ifZmRADLB@ZenIV>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 16 Jan 2023 21:10:37 +0000 Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Mon, Jan 16, 2023 at 04:38:01AM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 16, 2023 at 11:16:13AM +0800, maobibo wrote:
> > > Hongchen,
> > > 
> > > I have a glance with this patch, it simply replaces with
> > > spinlock_irqsave with mutex lock. There may be performance
> > > improvement with two processes competing with pipe, however
> > > for N processes, there will be complex context switches
> > > and ipi interruptts.
> > > 
> > > Can you find some cases with more than 2 processes competing
> > > pipe, rather than only unixbench?
> > 
> > What real applications have pipes with more than 1 writer & 1 reader?
> > I'm OK with slowing down the weird cases if the common cases go faster.
> 
> >From commit 0ddad21d3e99c743a3aa473121dc5561679e26bb:
>     While this isn't a common occurrence in the traditional "use a pipe as a
>     data transport" case, where you typically only have a single reader and
>     a single writer process, there is one common special case: using a pipe
>     as a source of "locking tokens" rather than for data communication.
>     
>     In particular, the GNU make jobserver code ends up using a pipe as a way
>     to limit parallelism, where each job consumes a token by reading a byte
>     from the jobserver pipe, and releases the token by writing a byte back
>     to the pipe.

The author has tested this patch with Linus's test code from 0ddad21d3e
and the results were OK
(https://lkml.kernel.org/r/c3cbede6-f19e-3333-ba0f-d3f005e5d599@loongson.cn).

I've been stalling on this patch until Linus gets back to his desk,
which now appears to have happened.

Hongchen, when convenient, please capture this discussion (as well as
the testing results with Linus's sample code) in the changelog and send
us a v4, with Linus on cc?

