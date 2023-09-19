Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A837A67CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 17:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjISPPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 11:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjISPPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:15:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F6194;
        Tue, 19 Sep 2023 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ho41svlP2AnIR71/YViS49+x6zj9O4UA2RkQCTRc9gI=; b=iJkDmrycNCqwLPt1Ftw8ltXU7+
        LOjQxHwJ6iYkjxpyldZnAuh2aSS7AKrg2/mzddsIaYA1OTsUVNU1ZO4NSkVmNRIGnHe4eUwa4zwUg
        E4ILepeUdxk1UVaou2f3LxRg/MBkqIH5RY+P1uQZ9E7PkVoynsBc6k5rkuhF5eZdei5cd2mCziz/w
        I0tyivnheP6EdtcYbBgTet8ziVqzM+diyh/sYOviI90omnLhM2OqG6qQaXKKvoC7OHyrRj9cDx7a0
        HkhqaR6HWtvonBFNFulP0R+E9cRt0F+PjV7idl9gObPI7sI6mlag8I5gObVC7s03f6+jBYXjpHDEv
        1VYLssBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qicRC-000J2M-Q8; Tue, 19 Sep 2023 15:14:54 +0000
Date:   Tue, 19 Sep 2023 16:14:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Greg Ungerer <gregungerer@westnet.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Message-ID: <ZQm67lGOBBdC2Dl9@casper.infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
 <ZQmvhC+pGWNs9R23@casper.infradead.org>
 <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:35:25PM +0000, David Laight wrote:
> From: Matthew Wilcox <willy@infradead.org>
> > Sent: 19 September 2023 15:26
> > 
> > On Tue, Sep 19, 2023 at 01:23:08PM +0000, David Laight wrote:
> > > > Well, that sucks.  What do you suggest for Coldfire?
> > >
> > > Can you just do a 32bit xor ?
> > > Unless you've got smp m68k I'd presume it is ok?
> > > (And assuming you aren't falling off a page.)
> > 
> > Patch welcome.
> 
> My 68020 book seems to be at work and I'm at home.
> (The 286, 386 and cy7c600 (sparc 32) books don't help).
> 
> But if the code is trying to do *ptr ^= 0x80 and check the
> sign flag then you just need to use eor.l with 0x80000000
> on the same address.

I have a 68020 book; what I don't have is a Coldfire manual.

Anyway, that's not the brief.  We're looking to (eg) clear bit 0
and test whether bit 7 was set.  So it's the sign bit of the byte,
not the sign bit of the int.
