Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E11F3BCB69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 13:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhGFLLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 07:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGFLLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:11:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBEDC061574;
        Tue,  6 Jul 2021 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ujhsZIEffiBU8YDQW2JxEemVJB22hCG0N5jEdqMO6sY=; b=oHTNsFlvR32AIvh3SJZS+oIKYM
        N/D7UTCrnz4Efptg6IgjxFJNuVX2VsZi7A3VcMx6bXy0bebWiNRzvO2KaS90p4FO1Qo6X+pCW1pRi
        DX9Uk+MWeLXpIIYqyAr7Id0a5+LVsVefLII4v9w8UX7eQfXKW4LOr+R5/Zgh8CtO3R7LyiZJruzhq
        fTaDV4JxeCigEKhsRnIA9gGuZmhICV/SRALP2ToY3GPALHUI7tZaVCoNvPeFPY5q1sPYom1YyjUK3
        yAYq8hLUFi0BP7Oox2P6guqXozOFtzV/yaLDhqYbKtXBZM1RgraQ7udD/VaRolaydb40+hbAFZvd6
        f2Y9xEWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0iw2-00BAUP-KO; Tue, 06 Jul 2021 11:08:17 +0000
Date:   Tue, 6 Jul 2021 12:08:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
Message-ID: <YOQ5nuuoBVHABK1C@casper.infradead.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
 <YN9vZfo+84gizjtf@casper.infradead.org>
 <492c7a7b-6f2e-de45-c733-51c80422305e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492c7a7b-6f2e-de45-c733-51c80422305e@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 05, 2021 at 11:35:08AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/7/3 3:56, Matthew Wilcox wrote:
> > On Fri, Jul 02, 2021 at 05:21:09PM +0800, Zhen Lei wrote:
> >> Move the evaluation expression "size - offset" after the "if (offset < 0)"
> >> judgment statement to eliminate a false positive produced by the UBSAN.
> >>
> >> No functional changes.
> >>
> >> ==========================================================================
> >> UBSAN: Undefined behaviour in fs/iomap.c:1435:9
> >> signed integer overflow:
> >> 0 - -9223372036854775808 cannot be represented in type 'long long int'
> > 
> > I don't understand.  I thought we defined the behaviour of signed
> > integer overflow in the kernel with whatever-the-gcc-flag-is?
> 
> -9223372036854775808 ==> 0x8000000000000000 ==> -0
> 
> I don't fully understand what you mean. This is triggered by explicit error
> injection '-0' at runtime, which should not be detected by compilation options.

We use -fwrapv on the gcc command line:

'-fwrapv'
     This option instructs the compiler to assume that signed arithmetic
     overflow of addition, subtraction and multiplication wraps around
     using twos-complement representation.  This flag enables some
     optimizations and disables others.

> lseek(r1, 0x8000000000000000, 0x3)

I'll see about adding this to xfstests ...
