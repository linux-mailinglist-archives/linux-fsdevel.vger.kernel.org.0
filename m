Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4475FC4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGXQhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjGXQhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:37:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE9B93
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=86Sml5/4Juo5dfBsbJVnV+JsVX44yMB+2OJxZMAGIZE=; b=AXdNMh4BbdzOKPB9RuG4mftfxb
        3CTRIM63VjO88N6o8Whnh3q4xx/xx6/Ggoe8un2WSgEa4isDbTWfpVjWXpYHjcU3fVlBTLroWwEJd
        /ey4oo3GkXy8lfAxN6w90rMjhJnVfmSFm4LRHKb07fDtTUCT9dab//p1Un1DRzTu4VJiqqcryl9bK
        XYwdSpEdG2MrcjEX5SvY88r308/bLg4tmI+tzwP6zaZg0ZvD9hY4bo9Eh9jIGjd3W3OCpFyWLDiRY
        t94/gN6QQ4geWEuPL8m3cLOqPIjcD5luC4n1A0Levg481tIXoj+t6ZJiW5gZ7uR+hvukQG6ypOz9F
        FqBoL08Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qNyYP-004b6H-OB; Mon, 24 Jul 2023 16:37:01 +0000
Date:   Mon, 24 Jul 2023 17:37:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: Re: [PATCH v2 4/9] mm: Move FAULT_FLAG_VMA_LOCK check into
 handle_pte_fault()
Message-ID: <ZL6orfmFWyekqSv1@casper.infradead.org>
References: <20230711202047.3818697-1-willy@infradead.org>
 <20230711202047.3818697-5-willy@infradead.org>
 <CAG48ez3jouPFr2j3=06jezeO61qdJNR=eK7OednhCgRU+Y_bYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3jouPFr2j3=06jezeO61qdJNR=eK7OednhCgRU+Y_bYg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:46:57PM +0200, Jann Horn wrote:
> On Tue, Jul 11, 2023 at 10:20 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> > Push the check down from __handle_mm_fault().  There's a mild upside to
> > this patch in that we'll allocate the page tables while under the VMA
> > lock rather than the mmap lock, reducing the hold time on the mmap lock,
> > since the retry will find the page tables already populated.
> 
> This commit, by moving the check from __handle_mm_fault() to
> handle_pte_fault(), also makes the non-anonymous THP paths (including
> the DAX huge fault handling) reachable for VMA-locked faults, right?
> Is that intentional?

Oof, this patch is all kinds of buggy.  Will split this into several
pieces.  Thanks!
