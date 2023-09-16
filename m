Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65BF7A2CA5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 02:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbjIPApI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 20:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbjIPAov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:44:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEDD2D6B;
        Fri, 15 Sep 2023 17:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R5aeK6zwe25Ptl62pFOh2GCwRsBEX0nDeC8Pt5rbj/4=; b=Wp2BlON3UigV+k/RUTG4ysbk71
        s289QQRWhQ80mUnwAGkkqX51zDYcAGhSwPlPj7IsI+qg1XYlaPEC8bF556obBtCJuP1he8zUg5y9d
        dWP8mrVWm+2pCuXlUbmqD1bDLfrBkssIPfDsaKZqOtAClNJXzYtuoRRI5e0WstlNXFWck9tTgZ7jS
        SPpsDmbni5pn3qY4gtfGK0lDCnQYLjszEo2TBoKw2FFC2cvVwbmjj4+U6/u9G7N/Ahg/iME1bEbdE
        yLcZrjND3D+FXuzOgzb6OiLwWeEXi4pUC/vPp/MmrJxoOfFU7jrlZFfnhSufLXm/rdMp7jeGSX/cT
        gB80SVHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhJKI-00D2RH-Nf; Sat, 16 Sep 2023 00:38:22 +0000
Date:   Sat, 16 Sep 2023 01:38:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
Message-ID: <ZQT4/gA4vIa/7H6q@casper.infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-9-willy@infradead.org>
 <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:27:17PM -0700, Linus Torvalds wrote:
> On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > +       "1:     ldl_l %0,%4\n"
> > +       "       xor %0,%3,%0\n"
> > +       "       xor %0,%3,%2\n"
> > +       "       stl_c %0,%1\n"
> 
> What an odd thing to do.
> 
> Why don't you just save the old value? That double xor looks all kinds
> of strange, and is a data dependency for no good reason that I can
> see.
> 
> Why isn't this "ldl_l + mov %0,%2 + xor + stl_c" instead?
> 
> Not that I think alpha matters, but since I was looking through the
> series, this just made me go "Whaa?"

Well, this is my first time writing Alpha assembler ;-)  I stole this
from ATOMIC_OP_RETURN:

        "1:     ldl_l %0,%1\n"                                          \
        "       " #asm_op " %0,%3,%2\n"                                 \
        "       " #asm_op " %0,%3,%0\n"                                 \
        "       stl_c %0,%1\n"                                          \
        "       beq %0,2f\n"                                            \
        ".subsection 2\n"                                               \
        "2:     br 1b\n"                                                \
        ".previous"                                                     \

but yes, mov would do the trick here.  Is it really faster than xor?
