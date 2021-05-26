Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0439125B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 10:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhEZIdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 04:33:15 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:39008 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231410AbhEZIdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 04:33:14 -0400
Received: from dread.disaster.area (pa49-180-230-185.pa.nsw.optusnet.com.au [49.180.230.185])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id CD4E1104350A;
        Wed, 26 May 2021 18:31:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1llowz-005N7h-2k; Wed, 26 May 2021 18:31:37 +1000
Date:   Wed, 26 May 2021 18:31:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Wu Bo <wubo40@huawei.com>, linfeilong@huawei.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/2] crypto: af_alg - use DIV_ROUND_UP helper macro for
 calculations
Message-ID: <20210526083137.GK2817@dread.disaster.area>
References: <1621930520-515336-1-git-send-email-wubo40@huawei.com>
 <1621930520-515336-2-git-send-email-wubo40@huawei.com>
 <20210525103744.Horde.nmFFeC3J2_-Qdu7udOYa8g1@messagerie.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210525103744.Horde.nmFFeC3J2_-Qdu7udOYa8g1@messagerie.c-s.fr>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=dUIOjvib2kB+GiIc1vUx8g==:117 a=dUIOjvib2kB+GiIc1vUx8g==:17
        a=8nJEP1OIZ-IA:10 a=5FLXtPjwQuUA:10 a=i0EeH86SAAAA:8 a=7-415B0cAAAA:8
        a=PjDj1IsLZaY1bt5ZHPIA:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 10:37:44AM +0200, Christophe Leroy wrote:
> Wu Bo <wubo40@huawei.com> a écrit :
> 
> > From: Wu Bo <wubo40@huawei.com>
> > 
> > Replace open coded divisor calculations with the DIV_ROUND_UP kernel
> > macro for better readability.
> > 
> > Signed-off-by: Wu Bo <wubo40@huawei.com>
> > ---
> >  crypto/af_alg.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> > index 18cc82d..8bd288d 100644
> > --- a/crypto/af_alg.c
> > +++ b/crypto/af_alg.c
> > @@ -411,7 +411,7 @@ int af_alg_make_sg(struct af_alg_sgl *sgl, struct
> > iov_iter *iter, int len)
> >  	if (n < 0)
> >  		return n;
> > 
> > -	npages = (off + n + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +	npages = DIV_ROUND_UP(off + n, PAGE_SIZE);
> 
> You should use PFN_UP()

No. We are not using pfns here - we're converting a byte count to a
page count.

Besides, "PFN_UP" is a horrible, awful api. It does not decribe what
it does and anyone who is not a mm developer will look at it and ask
"what <the ....> does this do?" and have to go looking for it's
definition to determine what it does. Yes, that's exactyl what I've
just done, and I really wish I didn't because, well, it just
reinforces how much we suck at APIs...

OTOH, what DIV_ROUND_UP() does is obvious, widely understood, self
documenting and easy to determine if the usage is correct, which
indeed this is.

The lesson: do not use whacky obscure, out of context macros when a
simple, obvious, widely known macro will give the same result and
make the code easier to understand.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
