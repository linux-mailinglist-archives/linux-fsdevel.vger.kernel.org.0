Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306D3302A7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 19:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbhAYSkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 13:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbhAYSki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:40:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA3AC0613D6;
        Mon, 25 Jan 2021 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xDrM+KQwor0G/SdbRtjD80RNmodxEJyJhIdhGXlFIgE=; b=Bbshmc8Qe42MDqnwjvOxasP4nj
        Vg4HA95P32VId9EjIS8lC5g7crddUHowjUGle9iSoJzYC9ITVWgU1+N0epXXW2BR48oQjssbHRPbp
        S4BsVHG2ffwIqPgw6CYgJw9a93Jt0lNLUt3unazR+sWDnmp2XBNDCiYSnjS7z+CzB1rZogCgwe/16
        jPwELbppc6pf2eqpGwPUE+lXi5BNkApxd1aqbvqu2TLG0RUOBLzsj0Esi12oQk+94SeG7WeexeSlB
        JsW+Xj9r5Hkp6y+QeC8ho2w1svrfoBMml8PGCPDvaPRGnMExrc5NDRcihAT8RP3BAfUZiLBbHPIqa
        RNLoe2sA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l46li-004Wji-Nv; Mon, 25 Jan 2021 18:39:33 +0000
Date:   Mon, 25 Jan 2021 18:39:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+da4fe66aaadd3c2e2d1c@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        namjae.jeon@samsung.com, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: UBSAN: shift-out-of-bounds in exfat_fill_super
Message-ID: <20210125183918.GH308988@casper.infradead.org>
References: <000000000000c2865c05b9bcee02@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c2865c05b9bcee02@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 09:33:14AM -0800, syzbot wrote:
> UBSAN: shift-out-of-bounds in fs/exfat/super.c:471:28
> shift exponent 4294967294 is too large for 32-bit type 'int'

This is an integer underflow:

        sbi->dentries_per_clu = 1 <<
                (sbi->cluster_size_bits - DENTRY_SIZE_BITS);

I think the problem is that there is no validation of sect_per_clus_bits.
We should check it is at least DENTRY_SIZE_BITS and probably that it's
less than ... 16?  64?  I don't know what legitimate values are in this
field, but I would imagine that 255 is completely unacceptable.
