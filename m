Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884892B2DE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 16:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKNPWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 10:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgKNPWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:22:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F1AC0613D1;
        Sat, 14 Nov 2020 07:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6JrlagLDzZmUvhluP8XB/lv8Ud+95jz6vB9eZHvFliQ=; b=a8teAqDFl+rInAIZaN9hsHpPFa
        q8JEPPQrGvab2DAIvKwqKR24il+FYBW02+W16dHNN5m+Hu1qGWokX9ClibtYB7goEYW8xilz0IpU2
        A54vxIbH15PMQl8t5U53vxwUPPC4Se2eTxzaphTJHOdFbKK6PAL0RBV8fbYB+NiVAgQKH8nu3hVtP
        XiCq3E15OLZYYX78Q85vZeuQLZ+5X+UZ5XjJ3y46qYpDwqfBp1JqpqLljlwS+NbXd3TNKFPWalSFH
        qjc85gxlEJfuk/IMkSxM6aoItIvLqY+XWBNW97uM9lx1CYsuUT0gAvq9Rhm9fi/+NgM7nGYit/Vmm
        N5IWgaiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdxO9-0001Qp-1m; Sat, 14 Nov 2020 15:22:53 +0000
Date:   Sat, 14 Nov 2020 15:22:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
        yang.shi@linux.alibaba.com, dchinner@redhat.com,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v4 13/16] mm: Pass pvec directly to find_get_entries
Message-ID: <20201114152252.GM17076@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
 <20201112212641.27837-14-willy@infradead.org>
 <20201114102133.GN19102@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114102133.GN19102@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 14, 2020 at 11:21:33AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 12, 2020 at 09:26:38PM +0000, Matthew Wilcox (Oracle) wrote:
> > +	pvec->nr = ret;
> >  	return ret;
> 
> Do we need to return the number of found entries in addition to storing
> it in the pagevec?

We really only need a bool -- is pvec->nr zero or not.  But we have the
number calculated so we may as well return it.  All the current find_*()
behave this way and I haven't seen enough reason to change it yet.
Making it return void just makes the callers uglier.  I have a batch of
patches to do something similar for find_get_pages / find_get_pages_range
/ pagevec_lookup / pagevec_lookup_range, but I don't need them for the
THP patchset, so I haven't sent them yet.
