Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A5175FE7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjGXRuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjGXRtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:49:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A222134
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5bpwVTVaUqtAVaYcNBEZIFegA2+4WwZEsgW7Px640jc=; b=h28sDPA0dxfJ1l6d8qgPu8DaIS
        fveaNEh6coImuHuXg7JTKIrfvPrOuUxnHgjYKonu0bV6Gc6lbPfjIDhUqlNfcpg1870sRKWHsW7xr
        KskVhcPQ9T0M6BtTjopSc6851zMvWWp6Lwu701U1UUsL3x842CijjkMa5HtMNzemWoRoJtPLvQe1q
        DAVSuAtAWKTT+OrSgPT320d0hHhOhM3t6ELZRb/2uNw7S9Rr+HYny/bPBvTuYTHu4rtzc1X3202Ot
        uaCEbFxWsr1FDKD2mvaYNEYs2UCSjbjyHlht9EvMNpYLXJYcyG749MgsAC9sLYXAZIiofJ06LjT4h
        +uf+rUug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qNzd7-004ew0-Sn; Mon, 24 Jul 2023 17:45:57 +0000
Date:   Mon, 24 Jul 2023 18:45:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: Re: [PATCH v2 5/9] mm: Move FAULT_FLAG_VMA_LOCK check down in
 handle_pte_fault()
Message-ID: <ZL641SdISu2hp89r@casper.infradead.org>
References: <20230711202047.3818697-1-willy@infradead.org>
 <20230711202047.3818697-6-willy@infradead.org>
 <CAG48ez2iccdvgjUh+tTpthJT8rHwd9eJwjgxBFMCWpa+imkQ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2iccdvgjUh+tTpthJT8rHwd9eJwjgxBFMCWpa+imkQ7w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:46:21PM +0200, Jann Horn wrote:
> > +       if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma)) {
> > +               vma_end_read(vmf->vma);
> > +               return VM_FAULT_RETRY;
> > +       }
> 
> At this point we can have vmf->pte mapped, right? Does this mean this
> bailout leaks a kmap_local() on CONFIG_HIGHPTE?

Yup.  Guess nobody's testing on 32-bit machines.  Thanks, fixed.
