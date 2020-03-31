Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23D1988AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 02:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgCaAGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 20:06:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgCaAGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VV89E7/0ITfr47FqhbuzNIICqyct8AhRAZZh1V1ewNo=; b=CWOYYkMN6YxBiPtv3S5YzHn5ld
        hLNYvpbJBQUngQwAPYD4s2QHupCqMSm+dVq6HNhcMG4eVRibSXgDRSS0u0PhAWyZ4kE9sAx0I2GCl
        q/6vwf9dZkFEwIHHsEiTehoHe+xHFmI7H2LY8bwoLjA/Y3EQB0fzOuXu5nbrQMtx2+Q3YGP+x29fQ
        yU0r62kHalK9xz9UcZzNVmG0tcwNfvyImddvgQ4sRbKKOoJTGgmBF7DircAYuDCPlJFFtNi8yVtut
        /Om7vcvM5DgEgOfXIildUIX2xwBa3U7k0zRFlNJko28n20u0Rb5hZzC9xqNPt5vLsXMNHp1eUTjMH
        Xe3iBOdw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ4Qb-0004SG-Lo; Tue, 31 Mar 2020 00:06:49 +0000
Date:   Mon, 30 Mar 2020 17:06:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] XArray: internal node is a xa_node when it is bigger
 than XA_ZERO_ENTRY
Message-ID: <20200331000649.GG22483@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-7-richard.weiyang@gmail.com>
 <20200330125006.GZ22483@bombadil.infradead.org>
 <20200330134519.ykdtqwqxjazqy3jm@master>
 <20200330134903.GB22483@bombadil.infradead.org>
 <20200330141350.ey77odenrbvixotb@master>
 <20200330142708.GC22483@bombadil.infradead.org>
 <20200330222013.34nkqen2agujhd6j@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330222013.34nkqen2agujhd6j@master>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:20:13PM +0000, Wei Yang wrote:
> On Mon, Mar 30, 2020 at 07:27:08AM -0700, Matthew Wilcox wrote:
> >On Mon, Mar 30, 2020 at 02:13:50PM +0000, Wei Yang wrote:
> >> On Mon, Mar 30, 2020 at 06:49:03AM -0700, Matthew Wilcox wrote:
> >> >On Mon, Mar 30, 2020 at 01:45:19PM +0000, Wei Yang wrote:
> >> >> On Mon, Mar 30, 2020 at 05:50:06AM -0700, Matthew Wilcox wrote:
> >> >> >On Mon, Mar 30, 2020 at 12:36:40PM +0000, Wei Yang wrote:
> >> >> >> As the comment mentioned, we reserved several ranges of internal node
> >> >> >> for tree maintenance, 0-62, 256, 257. This means a node bigger than
> >> >> >> XA_ZERO_ENTRY is a normal node.
> >> >> >> 
> >> >> >> The checked on XA_ZERO_ENTRY seems to be more meaningful.
> >> >> >
> >> >> >257-1023 are also reserved, they just aren't used yet.  XA_ZERO_ENTRY
> >> >> >is not guaranteed to be the largest reserved entry.
> >> >> 
> >> >> Then why we choose 4096?
> >> >
> >> >Because 4096 is the smallest page size supported by Linux, so we're
> >> >guaranteed that anything less than 4096 is not a valid pointer.
> >> 
> 
> So you want to say, the 4096 makes sure XArray will not store an address in
> first page? If this is the case, I have two suggestions:
> 
>   * use PAGE_SIZE would be more verbose?

But also incorrect, because it'll be different on different architectures.
It's 4096.  That's all.

>   * a node is an internal entry, do we need to compare with xa_mk_internal()
>     instead?

No.  4096 is better because it's a number which is easily expressible in
many CPU instruction sets.  4094 is much less likely to be an easy number
to encode.

> >(it is slightly out of date; the XArray actually supports storing unaligned
> >pointers now, but that's not relevant to this discussion)
> 
> Ok, maybe this document need to update.

Did you want to send a patch?
