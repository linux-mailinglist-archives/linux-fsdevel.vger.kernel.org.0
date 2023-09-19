Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7234E7A684E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjISPri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjISPrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:47:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598679C;
        Tue, 19 Sep 2023 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g5QeAE66e6/eIPraNu6QOQyjX6nvU/9GMNBQ0Ke/KUk=; b=fWxvIu7FKZoXqgsvtrDKoBVWxg
        kw8qbjMTOFnJw+ZYUoutIVucpU5xXpewuyIpcqBfRsvAu/vch2LaSP4urAsnkcwLCEEewFS1xI1nj
        K4qzrawhFqoD6GzNlrbIXNhCiwFHU8+ur54vvykDWwSBcD8ZUpTEFlFdCo4L15zKERXJHOsHTrp74
        kA7l/SMsr2TeAY8dcLrx7KN/VrR5kSSx5mD1N3vSUa/SfDLAskEDjtwuRDBer6MWJmLiG7PAPc0Zx
        OpNbfZPORPzkE9W6GjoYj72CyIcN8WoPU21XIUCni7JCbQs1GaLJGuYQiob0DOjG3oY/uLk7k7Fdd
        gyMsohwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qicwb-000Qwp-B1; Tue, 19 Sep 2023 15:47:21 +0000
Date:   Tue, 19 Sep 2023 16:47:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Greg Ungerer <gregungerer@westnet.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Message-ID: <ZQnCiZuMbFnwbEUt@casper.infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
 <ZQmvhC+pGWNs9R23@casper.infradead.org>
 <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
 <ZQm67lGOBBdC2Dl9@casper.infradead.org>
 <c61a58a1f5a34f2b96c6043840635197@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61a58a1f5a34f2b96c6043840635197@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 03:22:25PM +0000, David Laight wrote:
> > Anyway, that's not the brief.  We're looking to (eg) clear bit 0
> > and test whether bit 7 was set.  So it's the sign bit of the byte,
> > not the sign bit of the int.
> 
> Use the address of the byte as an int and xor with 1u<<24.
> The xor will do a rmw on the three bytes following, but I
> doubt that matters.

Bet you a shiny penny that Coldfire takes an unaligned access trap ...
and besides, this is done on _every_ call to unlock_page().  That might
cross not only a cacheline boundary but also a page boundary.  I cannot
believe that would be a high-performing solution.  It might be just fine
on m68000 but I bet even by the 030 it's lower performing.
