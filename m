Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DBB2B51C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 21:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbgKPUAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 15:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgKPUAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:00:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F45C0613CF;
        Mon, 16 Nov 2020 12:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z8OzNGspQXnwNNcU0w++SX1K+3G8m57VI2juCCZTgyU=; b=XK+yWWrfRuNhvqIpyTCVd2+tvD
        vWQWosYHC19Eca/wSVQOQMZb2zbMs8UoCYy1sM3fbI/sA95r8PcW8CR9s/E+o+j9ATkT6oVzWymrj
        XrhRKXfPPOtuNWlonuzskNrvQAp0RHk0KXvtMo5GmDCcj0OyPy5XlGZ64v8adFr3l8z8T3UnryyaM
        qvHf2HlqdbUXaUZ5jRdagxG89IyoN9og6kb7rcHheL0Ihff1Yhdm8VIwf25IcmKSEcElLwUrmiHcq
        5Ek/GA7cp7K93BZZGRc2K4CH+trRpJDM5mLa15onBZYa/DFauROaUWnTvzBlag53u0jmCLXHGGftl
        F2cBjaXA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kekfZ-0002Di-VR; Mon, 16 Nov 2020 20:00:10 +0000
Date:   Mon, 16 Nov 2020 20:00:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
Message-ID: <20201116200009.GJ29991@casper.infradead.org>
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
 <20201116161930.GF29991@casper.infradead.org>
 <CA+FuTSdifgNAYe4DAfpRJxCO08y-sOi=XhOeMhd9mKbA3aPOug@mail.gmail.com>
 <eead2765ea5e417abe616950b4e5d02f@AcuMS.aculab.com>
 <CAF=yD-LGtfPGuqM8WP5Wz7d9_u6x-HdeBitKg81zdA8E6tMQwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-LGtfPGuqM8WP5Wz7d9_u6x-HdeBitKg81zdA8E6tMQwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 02:54:17PM -0500, Willem de Bruijn wrote:
> > You could also add a compile assert to check that the flag is reserved.
> 
> Like this?
> 
>         /* Check the EPOLL_* constant for consistency.  */
>         BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
> +        BUILD_BUG_ON(EPOLL_NSTIMEO & EPOLL_RESERVED_FLAGS);

i think you got the sense of that test wrong.  but yes.
