Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3794270257
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIRQiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRQiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:38:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE9C0613CE;
        Fri, 18 Sep 2020 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wnkmMqCj1FBD6uSuttY6DF/GiQPO4Wqs8PtFBAIvkyE=; b=qmXqChVDcs4uL+AHX2DUTPweol
        NsX/+eICH3liS/uQlKMGnxjPT9mNL4Ayh8c1lpnJzHz1KLzmBydYF23wte/qzc6OGucctSuTgq+vP
        WltWtlv59y5eIjGW5kIrKQJRTabxsoyz7MzxVmSuybCKe03f0eJYyEIqpS149Mw/LX4OOa9VAi7YV
        NsraXAuHVcnuEWodmOSjc8dQeMNXOB2UqHZfHqrV8sgbbSnR4sY2OHshv9IVtApwXqCVeRnev1xf3
        Ea9YsX/nMboNN8nhFFP1MqcunkBpZde0+vHYb1DzFvXbCtTD+ftSylXHbH08hCfDgrCnMl9sHGAYw
        ajXXucBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJJOo-0006x3-VD; Fri, 18 Sep 2020 16:38:15 +0000
Date:   Fri, 18 Sep 2020 17:38:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Joe Perches <joe@perches.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH v5 03/10] fs/ntfs3: Add bitmap
Message-ID: <20200918163814.GF32101@casper.infradead.org>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-4-almaz.alexandrovich@paragon-software.com>
 <d1dc86f2792d3e64d1281fc2b5fddaca5fa17b5a.camel@perches.com>
 <5b2fbfee0a9d4ee59c0e624844560413@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b2fbfee0a9d4ee59c0e624844560413@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 04:29:34PM +0000, Konstantin Komarov wrote:
> From: Joe Perches <joe@perches.com>
> Sent: Sunday, September 13, 2020 9:44 PM
> > 
> > On Fri, 2020-09-11 at 17:10 +0300, Konstantin Komarov wrote:
> > > This adds bitmap
> > 
> > $ make fs/ntfs3/
> >   SYNC    include/config/auto.conf.cmd
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND  objtool
> >   CC      fs/ntfs3/bitfunc.o
> >   CC      fs/ntfs3/bitmap.o
> > fs/ntfs3/bitmap.c: In function ‘wnd_rescan’:
> > fs/ntfs3/bitmap.c:556:4: error: implicit declaration of function ‘page_cache_readahead_unbounded’; did you mean
> > ‘page_cache_ra_unbounded’? [-Werror=implicit-function-declaration]
> >   556 |    page_cache_readahead_unbounded(
> >       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |    page_cache_ra_unbounded
> > cc1: some warnings being treated as errors
> > make[2]: *** [scripts/Makefile.build:283: fs/ntfs3/bitmap.o] Error 1
> > make[1]: *** [scripts/Makefile.build:500: fs/ntfs3] Error 2
> > make: *** [Makefile:1792: fs] Error 2
> > 
> Hi Joe! Doesn't seem to be an issue for 5.9_rc5. Which repo should've
> been used to reproduce?

It's in the -mm tree, which is included in linux-next.
