Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7765B66BFC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjAPN2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 08:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAPN2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:28:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C951717C;
        Mon, 16 Jan 2023 05:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3WX91qejGpsVe+BTTVWqlDspV1ielBR/ADdhl0/AtKo=; b=QzG7PjWcPxLw4/tmqmezWk8aBn
        pBJ4EqKrNT6uJNUcYnxh13ieXCiKeGn7/6oT8qRxi5gNIltu9KYa0EsL8lo/uoeL226HnX1u9BPmE
        A74YKueRDxUG8xipGk0ujcWtymHeOkvaDEXSw0KCzlPwXphLfxtR5kGV6WW8ZTy3WUC1omfXTtl7t
        7tO/FwR0rPIqBMmHRgAp77kOBQJYyfVU+Bi5q1qGMEosK3P7fgJq/xrxEbwJB+bM1HjK32vtkZ/TP
        h9CvuMt48vuRHdsI7bedqah2Z8cCA1R8ehXjISVSKIzdy7H5M5KZQFD+WLQEfDsoHyt7b/Ucafaon
        rNQRBiAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHPX1-008ln6-MQ; Mon, 16 Jan 2023 13:28:11 +0000
Date:   Mon, 16 Jan 2023 13:28:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs
 cpu_relax)
Message-ID: <Y8VQ612fm0Wi4j4w@casper.infradead.org>
References: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de>
 <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com>
 <CA+icZUXEz7ZxmkV5bw5O2ORjF4bwDXBMyj3Wk_HST98gMPt97g@mail.gmail.com>
 <CA+icZUUhY7-F5Bpw-jxofhw4nMP3nzyfpt9huzeSWwUguguNsA@mail.gmail.com>
 <Y8NIYSMqAk7BhSv5@casper.infradead.org>
 <a6dda4b2-1124-7189-ecd8-9cf85c1b790d@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6dda4b2-1124-7189-ecd8-9cf85c1b790d@physik.fu-berlin.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 10:41:14AM +0100, John Paul Adrian Glaubitz wrote:
> On 1/15/23 01:27, Matthew Wilcox wrote:
> > More useful perhaps is to look at https://popcon.debian.org/
> > 
> > There are three machines reporting popcon results.  It's dead.
> 
> It's an opt-in mechanism that reports 190,000 machines running Debian
> on x86_64. Do you think that there are only 190,000 servers world-wide
> running Debian?

No.  I think there are so few ia64 machines still in operation that the
effort required to continue to support them is now too high relative
to the benefits.  We've dropped support for hardware that still exists
before, and we'll do it again.  The only question is when.

I still have two ia64 machines in my basement.  I've turned one of them
on once since 2009.  And that was because I had a bug I needed to track
down and fix (2018, commits 4b664e739f77 and 2879b65f9de8).
