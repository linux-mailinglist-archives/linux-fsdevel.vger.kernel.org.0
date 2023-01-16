Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C814066C372
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjAPPTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 10:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjAPPSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:18:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A381A4AE;
        Mon, 16 Jan 2023 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JYw4vYNo6I8ONL1oEHQpMq0Clr6CFL2bXHpSXpJOtI0=; b=E7mc3QbKC7DPlTHSAjTqru6OUZ
        Kcs0+09JF2aMv6SI5wQOt5rSq0BM8ct5mlPnirn/4I6QRcjS0hfJBo+x3Ny3hfq1FoEia6+CcSw4d
        Ln3RqowsC/MpEce8Kaq588urT3GLTAs6FzQ7UQfh7+V2rdRQYSJ1zK5+bWn6CaJPOBY5p4U4BOzV6
        OtOBMBvR44bGeLU2GMbt0MEeofc23vH+kjnBDDkuASHVjacOFQrEzK+xeBE2UyppGDUIV5I1CfgzX
        a2UFVC3h1+gI1FCNORS0EaQAVLf46ZAG4YoN1e0EblBtA+2QEp5Fu/0Q/Wk4pK4A2ckvbUgUn9jWZ
        B2kGePaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHR7V-008puo-Vx; Mon, 16 Jan 2023 15:09:58 +0000
Date:   Mon, 16 Jan 2023 15:09:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, tony.luck@intel.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Jan Glauber <jan.glauber@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Memory transaction instructions
Message-ID: <Y8Voxald4aGck3fA@casper.infradead.org>
References: <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com>
 <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
 <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo>
 <1966767.1673878095@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1966767.1673878095@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 02:08:15PM +0000, David Howells wrote:
> Hi Linus,
> 
> I'm not sure how relevant it is to the topic, but I seem to remember you
> having a go at implementing spinlocks with x86_64 memory transaction
> instructions a while back.  Do you have any thoughts on whether these
> instructions are ever likely to become something we can use?

Ever is a long time, but not while they're still buggy:

https://en.wikipedia.org/wiki/Transactional_Synchronization_Extensions

and not while they're not actually available on a vast majority of
x86 hardware.  ie AMD needs to implement them, make them available as
standard, forcing Intel to enable them globally instead of restricting
them to those who pay the $2.50/month subscription fee.
