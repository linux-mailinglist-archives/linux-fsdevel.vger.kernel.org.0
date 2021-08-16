Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B213ECC20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 02:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhHPAoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 20:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhHPAoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 20:44:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C98C061764;
        Sun, 15 Aug 2021 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7y4QptOz1V4ztlsofAPbksKAkQftUXrC/D8qql+onCY=; b=fteGMPsu8vTa5KcQw4azbU4JYA
        Faq4mtIy1sEdSqUaCmmRT3v62FIODMivNsEsaCK+HhuHFGM3myJ0uK6BcdGx+T+nexEVEjeilpNyp
        7IRgXtCGXPXrSWlL9Xm0AuFRqnX216adxVHoIdngDS2tec0YVKndK2UYzhOMaBTuc5pGrhFtdS6Nm
        +WXdWOn5T1Z04U+3nUtgM5sRBkI6SMyuqhXRcyvxYopwtoAVOpOZh0dZ1PxHo9TL0lLJGTfIHWMxp
        w22SNja7mMrWsFxNVoj0bn+pAxn28NuWfVk4Vsk21DlGWY+UXFl8KZQlhdNEyUSPV+LgxGcdOqT6a
        aoAsHslw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFQiq-000nYp-Ny; Mon, 16 Aug 2021 00:43:32 +0000
Date:   Mon, 16 Aug 2021 01:43:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 081/138] mm: Add folio_evictable()
Message-ID: <YRm0rCTY7G1xVbFl@casper.infradead.org>
References: <20210715033704.692967-82-willy@infradead.org>
 <20210715033704.692967-1-willy@infradead.org>
 <1814102.1628631690@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1814102.1628631690@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:41:30PM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > This is the folio equivalent of page_evictable().  Unfortunately, it's
> > different from !folio_test_unevictable(), but I think it's used in places
> > where you have to be a VM expert and can reasonably be expected to know
> > the difference.
> 
> It would be useful to say how it is different.  I'm guessing it's because a
> page is always entirely mlocked or not, but a folio might be partially
> mlocked?

folio_test_unevictable() checks the unevictable page flag.
folio_evictable() tests whether the folio is evictable (is any page
in the folio part of an mlocked VMA, or has the filesystem marked
the inode as being unevictable (eg is it ramfs).

It does end up looking a bit weird though.

                if (page_evictable(page) && PageUnevictable(page)) {
                        del_page_from_lru_list(page, lruvec);
                        ClearPageUnevictable(page);
                        add_page_to_lru_list(page, lruvec);

but it's all mm-internal, not exposed to filesystems.
