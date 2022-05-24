Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426A7532ED1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbiEXQUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 12:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiEXQUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 12:20:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B84A6351B;
        Tue, 24 May 2022 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EUeQwmTBOWOfObmRhBnhBfMctz5HwYy150UhFHZvYt8=; b=UnHRh6h4UTReP5lgmM+TnvIKB7
        AxleJR/jOfQ46N4JnR7MlT1t2lHCsViMy+iYZPl3TLicGBrfrztfFMg6E4oW8pXM9OTWL2Mcl+Qjg
        feoZ3DhIOyVD8BRxhKCtAH+cpBqSLVvOCWdf7qxKNaY4t4PDjRPtjmWkptwxCRZ9NVKMXm26S6BAk
        Y942KBggU/xKCx/gvw9XzgqxAAAyhT5VBXvBXqBRCd7AXTcxER9XPKqVGQtsLZ2NJbyJb9VW5YG0W
        ZyB4HtLHubX91W9y2oEjujYVl2Cqb/II4yFQzBQtWD24n7dBYVjjViU8sU3faKNTgWBpc2nqPOr9K
        U8ei3a+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntXGo-008e2P-QD; Tue, 24 May 2022 16:20:30 +0000
Date:   Tue, 24 May 2022 09:20:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v2] sysctl: handle table->maxlen properly for proc_dobool
Message-ID: <Yo0FzkTJj2TrLtTO@bombadil.infradead.org>
References: <20220522052624.21493-1-songmuchun@bytedance.com>
 <YovECEBVeCZl79fi@bombadil.infradead.org>
 <CAMZfGtWfD62CRTPSesqKJALvcBLEOVWj7DyXrv05x+99seKTgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWfD62CRTPSesqKJALvcBLEOVWj7DyXrv05x+99seKTgA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 24, 2022 at 10:30:01AM +0800, Muchun Song wrote:
> On Tue, May 24, 2022 at 1:27 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Sun, May 22, 2022 at 01:26:24PM +0800, Muchun Song wrote:
> > > Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> > > to sizeof(int) is counter-intuitive, it is easy to make mistakes.  For
> > > robustness, fix it by reimplementing proc_dobool() properly.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Iurii Zaikin <yzaikin@google.com>
> > > ---
> >
> > Thanks for your patch Muchun!
> >
> > Does this fix an actualy issue? Because the comit log suggest so.
> 
> Thanks for taking a look.
> 
> I think it is an improvement not a real bug fix.

Then please adjust the commit log accordingly.

> When I first use
> proc_dobool in my driver, I assign sizeof(variable) to table->maxlen.
> Then I found it was wrong, it should be sizeof(int) which was
> counter-intuitive. So it is very easy to make mistakes. Should I add
> those into the commit log?

Yes that is useful information when doing patch review as well.

  Luis
