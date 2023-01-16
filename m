Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA466B6A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 05:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjAPEiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 23:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjAPEiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:38:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893F72A9;
        Sun, 15 Jan 2023 20:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PDkdlvplykONDhtm6dJQ9N1joXtgLBKkIFPyp5U/kn4=; b=Rh9FRGbOBXc8wtDvk20k7DdbHW
        zvbTl0mBX2a7wrR+XeZaZwQwOzdDzgFpsqH3ENndlxsNKLtB+IHvkz9tF/p9VUEmHCsNwUtcNtTZB
        GeByJS4I+sWG7Ut9m0rzx/43/mbInl0Hv60JehkUYQfc5pPzb0Jf85bjHpcqhAVz3ht63rABKVcA+
        b3OIsGBScxCafRSkOn+ACgfqnNh2jN+44l9ddqsArleNjsD9yt/jCHt1fHdKc+YoHwU5u+qwA/nhD
        Siqf8BcmzF+/GfP1mcjNO0himzCNRbIyK7fEYevlNjl21x8AU/HLfH0bKh4l9NjLt35yMflXTUaNU
        hUSqmaUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHHFx-008QQF-WF; Mon, 16 Jan 2023 04:38:02 +0000
Date:   Mon, 16 Jan 2023 04:38:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     maobibo <maobibo@loongson.cn>
Cc:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-ID: <Y8TUqcSO5VrbYfcM@casper.infradead.org>
References: <20230107012324.30698-1-zhanghongchen@loongson.cn>
 <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn>
 <4b140bd0-9b7f-50b5-9e3b-16d8afe52a50@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b140bd0-9b7f-50b5-9e3b-16d8afe52a50@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:16:13AM +0800, maobibo wrote:
> Hongchen,
> 
> I have a glance with this patch, it simply replaces with
> spinlock_irqsave with mutex lock. There may be performance
> improvement with two processes competing with pipe, however
> for N processes, there will be complex context switches
> and ipi interruptts.
> 
> Can you find some cases with more than 2 processes competing
> pipe, rather than only unixbench?

What real applications have pipes with more than 1 writer & 1 reader?
I'm OK with slowing down the weird cases if the common cases go faster.
