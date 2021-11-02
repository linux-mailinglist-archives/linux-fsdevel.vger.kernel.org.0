Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1544262F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 04:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhKBDyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 23:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhKBDyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:54:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A2C061714;
        Mon,  1 Nov 2021 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AB5n3/LuEh2928VCurg1CoaRmnjr3rvLQBzfgJuYk64=; b=i2B3uaOzl6E5PPWgRrD2R1JSQK
        boSK3XI1+/V7bOV7N3LIsuD0VoBv42Kd45inktYeYsqX7H710YuXIgV141GWah6a0ScHomeRewpiN
        2wClGB8Ky50+APo0v/J0ziL29R+UgoQpPOS41KgURhjbPMjGoU1BzQlaMDMPKO7GGrZUp8fjB5YrK
        d+lsNIqbYtz+sLmfFyA1EM7DB2qdZ2jC8TDRm9+iD2cCsf75hc898ywJ8CDRTZOh7E5ZLHALPiSZJ
        +NwNpCO7r0Kj2zmMVyvCoEK/nSdzR3SJixmSy0ghCKvBzMwaD4/9PBMVvZjp7T9vE9QRrqdc/D81E
        LTrLljBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhknW-004E5Z-Rh; Tue, 02 Nov 2021 03:49:43 +0000
Date:   Tue, 2 Nov 2021 03:49:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Jue Wang <juew@google.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [v5 PATCH 6/6] mm: hwpoison: handle non-anonymous THP correctly
Message-ID: <YYC1Phb5eFn9hJfG@casper.infradead.org>
References: <CAPcxDJ5rgmyswPN5kL8-Mk2hk7MCjHXVy6pS50i=KQKzUGFHfA@mail.gmail.com>
 <CAHbLzkp7mN0ePsZiSY4obA_cVqmReSnDd6tF-yxRAmALBzzKAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkp7mN0ePsZiSY4obA_cVqmReSnDd6tF-yxRAmALBzzKAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 01:11:33PM -0700, Yang Shi wrote:
> On Mon, Nov 1, 2021 at 12:38 PM Jue Wang <juew@google.com> wrote:
> >
> > A related bug but whose fix may belong to a separate series:
> >
> > split_huge_page fails when invoked concurrently on the same THP page.
> >
> > It's possible that multiple memory errors on the same THP get consumed
> > by multiple threads and come down to split_huge_page path easily.
> 
> Yeah, I think it should be a known problem since the very beginning.
> The THP split requires to pin the page and does check if the refcount
> is expected or not and freezes the refcount if it is expected. So if
> two concurrent paths try to split the same THP, one will fail due to
> the pin from the other path, but the other one will succeed.

No, they can both fail, if the timing is just right, because they each
have a refcount, so neither will succeed.
