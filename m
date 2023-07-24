Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C587475FA68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 17:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGXPGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 11:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGXPGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:06:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F085E73;
        Mon, 24 Jul 2023 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=CwS+gUuv2XOM9O2NP111HTOnlB9f6LWeUnrAZXT+Fo4=; b=DqdjuzgXScazPigNtNUZlVnbyL
        uMvl+IyKGN0rU8xl2LdMl8dKeIgKmF2Y/jK3Ne5JFQ+Ouw+yIB1M0y9Htp0OloZRLt4iHABQQ4Q5s
        R1JeDZBcqOzSZJklEnAD7/Yw3Yg0hbe7qI/S2jUq3aaa5D37v8Cn4r/uqG+FmfjQ8sCfvomkSQmfI
        XKJCQvDdCDLhl66QTE+mTDwXaw0vfCMF9qkejWMgDh0spc4fLYToc+ElLDLqivK/Ukl0UKalmkO8P
        y0DheW7astIQWDW/3pDf7DgC7gCfJDN+aWFUGLBR0Oin9HYOwSVeXmNItgLIbvk2D/xvgLNKmk6CY
        Jor71GpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qNx8K-004WKn-4z; Mon, 24 Jul 2023 15:06:00 +0000
Date:   Mon, 24 Jul 2023 16:06:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/9] Revert "tcp: Use per-vma locking for receive
 zerocopy"
Message-ID: <ZL6TWDCasQon3h4r@casper.infradead.org>
References: <20230711202047.3818697-1-willy@infradead.org>
 <20230711202047.3818697-2-willy@infradead.org>
 <CAJuCfpGTRZO121fD0_nXi534D45+eOSUkCO7dcZe13jhkdfnSQ@mail.gmail.com>
 <ZLDCQHO4W1G7qKqv@casper.infradead.org>
 <CAG48ez3bv2nWaVx7kGKcj2eQXRfq8LNOUXm8s1gNVDJJoLsprw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3bv2nWaVx7kGKcj2eQXRfq8LNOUXm8s1gNVDJJoLsprw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 04:49:16PM +0200, Jann Horn wrote:
> On Fri, Jul 14, 2023 at 5:34 AM Matthew Wilcox <willy@infradead.org> wrote:
> > On Thu, Jul 13, 2023 at 08:02:12PM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Jul 11, 2023 at 1:21 PM Matthew Wilcox (Oracle)
> > > <willy@infradead.org> wrote:
> > > >
> > > > This reverts commit 7a7f094635349a7d0314364ad50bdeb770b6df4f.
> > >
> > > nit: some explanation and SOB would be nice.
> >
> > Well, it can't be actually applied.  What needs to happen is that the
> > networking people need to drop the commit from their tree.  Some review
> > from the networking people would be helpful to be sure that I didn't
> > break anything in my reworking of this patch to apply after my patches.
> 
> Are you saying you want them to revert it before it reaches mainline?
> That commit landed in v6.5-rc1.

... what?  It was posted on June 16th.  How does it end up in rc1 on
July 9th?  6.4 was June 25th.  9 days is long enough for something
that's not an urgent fix to land in rc1?  Networking doesn't close
development at rc5/6 like most subsystem trees?
