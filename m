Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6AE2D38BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 03:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgLICXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 21:23:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:48066 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgLICXb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:23:31 -0500
IronPort-SDR: uHvzLIC6jXf6pie8/ZcfVVV4zW0ilI3XeAdBTyjlqwsdUZT0LIXonUlht0vluLImeJoqByE42Y
 jZMSO13CObtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174153825"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174153825"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 18:22:50 -0800
IronPort-SDR: X7OpOgvlReRxSkhPvZFRfdFT0of14sphAk2JsWUHlrfeXmh5ht8zdLca5zdU6Bj+/aeLsroT/U
 NwCxfiwMznXg==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="363934735"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 18:22:50 -0800
Date:   Tue, 8 Dec 2020 18:22:50 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
Message-ID: <20201209022250.GP1563847@iweiny-DESK2.sc.intel.com>
References: <20201207232649.GD7338@casper.infradead.org>
 <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org>
 <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
 <20201208215028.GK7338@casper.infradead.org>
 <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
 <20201208223234.GL7338@casper.infradead.org>
 <20201208224555.GA605321@magnolia>
 <CAPcyv4jEmdfAz8foEUtDw4GEm2-+7J-4GULZ=6tCD+9K5CFzRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jEmdfAz8foEUtDw4GEm2-+7J-4GULZ=6tCD+9K5CFzRw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:40:52PM -0800, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 2:49 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> [..]
> > > So what's your preferred poison?
> > >
> > > 1. Corrupt random data in whatever's been mapped into the next page (which
> > >    is what the helpers currently do)
> >
> > Please no.
> 
> My assertion is that the kernel can't know it's corruption, it can
> only know that the driver is abusing the API. So over-copy and WARN
> seems better than violently regress by crashing what might have been
> working silently before.

Right now we have a mixed bag.  zero_user() [and it's variants, circa 2008]
does a BUG_ON.[0]  While the other ones do nothing; clear_highpage(),
clear_user_highpage(), copy_user_highpage(), and copy_highpage().

While continuing to audit the code I don't see any users who would violating
the API with a simple conversion of the code.  The calls which I have worked on
[which is many at this point] all have checks in place which are well aware of
page boundaries.

Therefore, I tend to agree with Dan that if anything is to be done it should be
a WARN_ON() which is only going to throw an error that something has probably
been wrong all along and should be fixed but continue running as before.

BUG_ON() is a very big hammer.  And I don't think that Linus is going to
appreciate a BUG_ON here.[1]  Callers of this API should be well aware that
they are operating on a page and that specifying parameters beyond the bounds
of a page are going to have bad consequences...

Furthermore, I'm still leery of adding the WARN_ON's because Greg KH says many
people will be converting them to BUG_ON's via panic-on-warn anyway.  But at
least that is their choice.

FWIW I think this is a 'bad BUG_ON' use because we are "checking something that
we know we might be getting wrong".[1]  And because, "BUG() is only good for
something that never happens and that we really have no other option for".[2]

IMO, These calls are like memcpy/memmove.  memcpy/memmove don't validate bounds
and developers have lived with those constructs for a long time.

Ira

[0] BTW, After writing this email, with various URL research, I think this
BUG_ON() is also probably wrong...

[1] 
	<quote>
	...
	It's [BUG_ON] not a "let's check that
	everybody did things right", it's a "this is a major design rule in
	this core code".
	...
	</quote>
		-- Linus (https://lkml.org/lkml/2016/10/4/337)

[2] https://yarchive.net/comp/linux/BUG.html

