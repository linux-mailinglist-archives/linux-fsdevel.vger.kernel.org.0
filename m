Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E4F66AEE5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jan 2023 01:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjAOA1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Jan 2023 19:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjAOA1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Jan 2023 19:27:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BB9A273;
        Sat, 14 Jan 2023 16:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2C00BT3n+YbTKiQeV33HXBf4b40S5kmIf4Iwv6fNwSI=; b=cEsfEytJF+y/mCwOWmsbB5zBf+
        QmCBVBptSk+O6m0cm4cfLPa5ShHQSCMlrhNHumJB6bgibUH/o/5BHwuE0K18BcHt3G3hO27KYlczD
        D3tPQMZa079DW8BpDz/T2NRRZgVn7hmL+VOJ732+Zl/dW5s9uHubN0DRj6fmOcRY8RG+LvRUyTvt9
        4/dYbVnu4AV9tYYPjerktwM/aFjoNl/PwWYVY3go6ass1frXujjw7g/4x4DBVwg4E+ek8E0wL59VN
        f/gulWhYFDavCFogA4T8Y13KaVGrW3FngLR+qH64YlPfqnAl3YPcrqODSv79K+0UFd0ZIvFhpwLz/
        qPDkfI6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGqrh-007QIv-F1; Sun, 15 Jan 2023 00:27:13 +0000
Date:   Sun, 15 Jan 2023 00:27:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
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
Message-ID: <Y8NIYSMqAk7BhSv5@casper.infradead.org>
References: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de>
 <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com>
 <CA+icZUXEz7ZxmkV5bw5O2ORjF4bwDXBMyj3Wk_HST98gMPt97g@mail.gmail.com>
 <CA+icZUUhY7-F5Bpw-jxofhw4nMP3nzyfpt9huzeSWwUguguNsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUhY7-F5Bpw-jxofhw4nMP3nzyfpt9huzeSWwUguguNsA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 14, 2023 at 12:28:30PM +0100, Sedat Dilek wrote:
> [ ... ]
> 
> > Best is to ask the Debian release-team or (if there exist) maintainers
> > or responsibles for the IA64 port - which is an ***unofficial*** port.
> >
> 
> Here we go:
> 
> https://lists.debian.org/debian-ia64/
> 
> Posting address: debian-ia64@lists.debian.org
> 
> Found via <https://lists.debian.org/completeindex.html>

More useful perhaps is to look at https://popcon.debian.org/

There are three machines reporting popcon results.  It's dead.
