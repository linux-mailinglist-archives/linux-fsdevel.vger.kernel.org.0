Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206576ED007
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjDXOLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDXOLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:11:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A907A97;
        Mon, 24 Apr 2023 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bq3FErVwk6M7hagQ0GD1FNXKEMmm/PaaMbSDlReCnio=; b=p7qYCXJOFKoCGTxABU4EaERCCa
        IKkL5LC9IPoxExAgJqEmtn9q9ogp/aaNGh31JpFf1IVut/3jxVphxoKIP4j0g5etvfZZ4AXAmAxbq
        hvJIpfn+GNdLGVPtQY1mDRV6wqoZcS0Sofn05kw8Z2CuqlI1sTdQU6Ggo6Y5H67VTReqf/AslgE7k
        yp63l+AZ28HKIPxG5dqMTlNKmorvKbsizZOwQ9YNNQ4Zq0kENk+sst6QEDXCglYoSy8oN7JJizslE
        OscwY4fgTcJdMSA7qH0ulSPDp8bMqyd3Ti8KuuqL91T0LALbfqODRhj/PbJBcdrW/OHjJHZtqi3YO
        hiV9fITQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pqwu4-000W5P-S6; Mon, 24 Apr 2023 14:10:52 +0000
Date:   Mon, 24 Apr 2023 15:10:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com>,
        djwong@kernel.org, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in __filemap_remove_folio
 / folio_mapping (2)
Message-ID: <ZEaN7PP794H2vbe/@casper.infradead.org>
References: <000000000000d0737c05fa0fd499@google.com>
 <CACT4Y+YKt-YvQ5fKimXAP8nsV=X81OymPd3pxVXvmPG-51YjOw@mail.gmail.com>
 <ZEaCSXG4UTGlHDam@casper.infradead.org>
 <CACT4Y+YeV8zU2x+3dpJJFez5_33ic3q7B2_+KYrcNOQxooRWpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YeV8zU2x+3dpJJFez5_33ic3q7B2_+KYrcNOQxooRWpw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:49:04PM +0200, Dmitry Vyukov wrote:
> On Mon, 24 Apr 2023 at 15:21, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Apr 24, 2023 at 09:38:43AM +0200, Dmitry Vyukov wrote:
> > > On Mon, 24 Apr 2023 at 09:19, syzbot
> > > <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com> wrote:
> > > If I am reading this correctly, it can lead to NULL derefs in
> > > folio_mapping() if folio->mapping is read twice. I think
> > > folio->mapping reads/writes need to use READ/WRITE_ONCE if racy.
> >
> > You aren't reading it correctly.
> >
> >         mapping = folio->mapping;
> >         if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
> >                 return NULL;
> >
> >         return mapping;
> >
> > The racing write is storing NULL.  So it might return NULL or it might
> > return the old mapping, or it might return NULL.  Either way, the caller
> > has to be prepared for NULL to be returned.
> >
> > It's a false posiive, but probably worth silencing with a READ_ONCE().
> 
> Yes, but the end of the function does not limit effects of races. I

I thought it did.  I was under the impression that the compiler was not
allowed to extract loads from within the function and move them outside.
Maybe that changed since C99.

> to this:
> 
> if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) && folio->mapping)
>    if (test_bit(AS_UNEVICTABLE, &folio->mapping->flags))
> 
> which does crash.

Yes, if the compiler is allowed to do that, then that's a possibility.

