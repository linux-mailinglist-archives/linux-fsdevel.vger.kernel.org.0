Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F252D3967
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 05:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgLIEEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 23:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgLIEEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 23:04:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E127C0613CF;
        Tue,  8 Dec 2020 20:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ptjl1vOkAECNNGD8FjP9CmBCmHgTzCuywcTzKIYkzYw=; b=gYUQXZT87oKHPRmAzCyz2v0+q2
        Q6+nWIVVrwqJR4T7g2r38PdidVo/NscPGofu4tGqU0lFPRs61ECqei/fKI9cPhLCM2o7OeFfv1oRy
        BSXvNTRUH7hxvUuQRtydYrk7P0KDK4puaetLnP/RgTTDl/AezCyTUpf6rg7D8BaL5gulYtO8JR5BU
        eCgfNrCiQxriCWNJbp4ZySU9FXWHXCmA0thvvB/VbCds/U3u/FL0B057XyJVlBG8ZSLj2Gc9Yh82Z
        icd0zYpjbNCe5CW0tpPj46TktpIECNya3xBKJvWNUrzZ5FNJhR2rDi7JUoMmn4nhE9ZsI0+mN3Srd
        diIYI5WQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmqh6-0006FZ-Up; Wed, 09 Dec 2020 04:03:13 +0000
Date:   Wed, 9 Dec 2020 04:03:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
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
Message-ID: <20201209040312.GN7338@casper.infradead.org>
References: <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org>
 <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
 <20201208215028.GK7338@casper.infradead.org>
 <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
 <20201208223234.GL7338@casper.infradead.org>
 <20201208224555.GA605321@magnolia>
 <CAPcyv4jEmdfAz8foEUtDw4GEm2-+7J-4GULZ=6tCD+9K5CFzRw@mail.gmail.com>
 <20201209022250.GP1563847@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209022250.GP1563847@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 06:22:50PM -0800, Ira Weiny wrote:
> Right now we have a mixed bag.  zero_user() [and it's variants, circa 2008]
> does a BUG_ON.[0]  While the other ones do nothing; clear_highpage(),
> clear_user_highpage(), copy_user_highpage(), and copy_highpage().

Erm, those functions operate on the entire PAGE_SIZE.  There's nothing
for them to check.

> While continuing to audit the code I don't see any users who would violating
> the API with a simple conversion of the code.  The calls which I have worked on
> [which is many at this point] all have checks in place which are well aware of
> page boundaries.

Oh good, then this BUG_ON won't trigger.

> Therefore, I tend to agree with Dan that if anything is to be done it should be
> a WARN_ON() which is only going to throw an error that something has probably
> been wrong all along and should be fixed but continue running as before.

Silent data corruption is for ever.  Are you absolutely sure nobody has
done:

	page = alloc_pages(GFP_HIGHUSER_MOVABLE, 3);
	memcpy_to_page(page, PAGE_SIZE * 2, p, PAGE_SIZE * 2);

because that will work fine if the pages come from ZONE_NORMAL and fail
miserably if they came from ZONE_HIGHMEM.

> FWIW I think this is a 'bad BUG_ON' use because we are "checking something that
> we know we might be getting wrong".[1]  And because, "BUG() is only good for
> something that never happens and that we really have no other option for".[2]

BUG() is our only option here.  Both limiting how much we copy or
copying the requested amount result in data corruption or leaking
information to a process that isn't supposed to see it.

What Linus is railing against is the developers who say "Oh, I don't
know what to do here, I'll just BUG()".  That's not the case here.
We've thought about it.  We've discussed it.  There's NO GOOD OPTION.

Unless you want to do the moral equivalent of this:

http://git.infradead.org/users/willy/pagecache.git/commitdiff/d2417516bd8b3dd1db096a9b040b0264d8052339

I think that would look something like this ...

void memcpy_to_page(struct page *page, size_t offset, const char *from,
			size_t len)
{
	page += offset / PAGE_SIZE;
	offset %= PAGE_SIZE;

	while (len) {
		char *to = kmap_atomic(page);
		size_t bytes = min(len, PAGE_SIZE - offset);
		memcpy(to + offset, from, len);
		kunmap_atomic(to);
		len -= bytes;
		offset = 0;
		page++;
	}
}

Now 32-bit highmem will do the same thing as 64-bit for my example above,
just more slowly.  Untested, obviously.
