Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1C4504EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 14:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhKONIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 08:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhKONIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:08:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B29C061570;
        Mon, 15 Nov 2021 05:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uf02tZGLeZ80LvD7kU2WBviAw8LJxNZ/KvC0wOH0sfs=; b=Hb+BGzS0+V3mc4dHDKcAOgs2BQ
        M6QgtnIKDLsEtd8j/H6DLzgEaZpYH1ip5sTPcOhyrO2yIfe5k8Thl8HIrj13DGiccSYoPKvj9lRz0
        EWZH0sLTB6BYkcp+qQRAYlfZsah8NqhlLGpSOONN5+vsayPmqkwX4ekeRjCMF9rPh9U6Ifyy3/1IM
        ZGM2xzFr2MAHWWM3GnLNCY30EOa/X9yovneksFI1bixKgnO6fCrUMRHrAtrtuc/KZACcVZV65gj/x
        wVjZpcjjM7qe53ZLSZrVPJKre+33M40sfEo7Li8t1TNrh3CW7MVmg8Sx9uln20iTFZQ+JsfsoGx3z
        zuYg14EQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmbfY-005hm0-Ce; Mon, 15 Nov 2021 13:05:08 +0000
Date:   Mon, 15 Nov 2021 13:05:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pipe: fix potential use-after-free in pipe_read()
Message-ID: <YZJbBNs/63pnXngK@casper.infradead.org>
References: <20211115035721.1909-1-thunder.leizhen@huawei.com>
 <20211115035721.1909-2-thunder.leizhen@huawei.com>
 <YZHhQ5uUJ06BOnJh@casper.infradead.org>
 <d604e5f8-128a-d25c-848d-7380a5bde609@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d604e5f8-128a-d25c-848d-7380a5bde609@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 02:13:44PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/11/15 12:25, Matthew Wilcox wrote:
> > On Mon, Nov 15, 2021 at 11:57:20AM +0800, Zhen Lei wrote:
> >>  			if (!buf->len) {
> >> +				unsigned int __maybe_unused flags = buf->flags;
> > 
> > Why __maybe_unused?
> 
> It's used only if "#ifdef CONFIG_WATCH_QUEUE". Otherwise, a warning will be reported.

Better to turn the #ifdef into if (IS_ENABLED())
