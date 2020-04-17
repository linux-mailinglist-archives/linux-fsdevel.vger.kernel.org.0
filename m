Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED66C1ADBF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 13:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgDQLMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729846AbgDQLMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:12:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05544C061A0C;
        Fri, 17 Apr 2020 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8sFIV+/8fWUY1Zbo7nie6mENpkyN/bnZv7/UFlj2FCU=; b=YYrgq/hvPgReVdxVWoGhcDq5OH
        bTtip9uQNfhfbbmBEukbzi+TjuaHGEoFqG47UgzsbLv240p6s/vtR8k6s1thPihwHGajzkKlVVXpb
        nTTfBMJZn8WTuTDH4+oh/r6SS4ofu22zRjXRhVOqlSJKl6Mz6q3qvnI+JsCN1nx3obijkON7+ZOYG
        5B53aEmaqbpH41A0CRp9eYifRtoWPLrLG/9sLsiac6odvXQ9wBPqGH5QZSR6Ui9lTNY5WmIpcj0Oc
        RVS1FKCoO8b2LZuXy4Lj1EXODCGwav1Un8/U+rzwjHrv5kedEqM/tsdpghQBno3bTfzS/+mjkfCm7
        Z6SzouSw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPOvB-0006uy-Fk; Fri, 17 Apr 2020 11:12:33 +0000
Date:   Fri, 17 Apr 2020 04:12:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 00/11] Make PageWriteback use the PageLocked
 optimisation
Message-ID: <20200417111233.GL5820@bombadil.infradead.org>
References: <20200416220130.13343-1-willy@infradead.org>
 <CAMuHMdWxhVoPCZ5+=Pf1LFpdE9vPv9GGTqTYMQP9oFz7eCxDaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWxhVoPCZ5+=Pf1LFpdE9vPv9GGTqTYMQP9oFz7eCxDaQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 09:28:14AM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 17, 2020 at 12:01 AM Matthew Wilcox <willy@infradead.org> wrote:
> > v3:
> >  - Added implementations of clear_bit_unlock_is_negative_byte()
> >    to architectures which need it
> 
> I have two questions here?
>   1. Why not implement arch_clear_bit_unlock_is_negative_byte()
>      instead, so the kasan check in asm-generic is used everywhere?

That would be a larger change.  As I understand it (and I may misunderstand
it), I would need to rename all the clear_bit(), __clear_bit(), change_bit(),
... functions to have an 'arch_' prefix and then include instrumented-lock.h

>   2. Why not add the default implementation to
>      include/asm-generic/bitops/instrumented-lock.h, in case an arch_*()
>      variant is not provided yet?
> 
> Note that you did 1 for s390.

Well, s390 already uses instrumented-lock.h so I followed along with
what they're doing.  I don't think instrumented-lock.h is used at all on
these other architectures, but the whole bitops header files are such a
mess that I could easily have built a completely wrong mental model of
what's going on.
