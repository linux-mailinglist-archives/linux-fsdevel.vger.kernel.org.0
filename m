Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC05E31E126
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 22:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhBQVSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 16:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhBQVSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:18:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B235C061574;
        Wed, 17 Feb 2021 13:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SNT38Fllc6tHutd44Y7GFooJxf2Yr4uXKo6Dx/78xZs=; b=ko737ihvincKwgVwE+SBcA7l+I
        XWxZegvieOZAgBBTlEL9fgJpmPxLWd1jW5LPbEkvD+IQrCs6O/lXQLANBJlRnEJ/saZx+xpqW7i9X
        dz3M4lraunZrtQQLvjWziGj9RFZ1zW1xH25nFhdHYJoLXp3z8Iz1avEaQ6061bJEATQ782M0ZlRuy
        e5JSMA5V2eNJM+r2xXLF1wddHA5hUEc53DRVkWyF88OvTMOzp9vno14qfS4/M5YEAnUyVGLyIfqJ3
        jpsfb8ybZEPocMAlbcSGeVhLvbSslSWnImecTtH0vqIzsVDzKEWd7VjB6W9MaWvc2Y90ulCKYDIUO
        dAs0ovjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCUBA-000tCV-NY; Wed, 17 Feb 2021 21:16:28 +0000
Date:   Wed, 17 Feb 2021 21:16:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, david@redhat.com, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <20210217211612.GO2858050@casper.infradead.org>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
 <YC2Am34Fso5Y5SPC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC2Am34Fso5Y5SPC@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 12:46:19PM -0800, Minchan Kim wrote:
> > I suspect you do not want to add atomic_read inside hot paths, right? Is
> > this really something that we have to microoptimize for? atomic_read is
> > a simple READ_ONCE on many archs.
> 
> It's also spin_lock_irq_save in some arch. If the new synchonization is
> heavily compilcated, atomic would be better for simple start but I thought
> this locking scheme is too simple so no need to add atomic operation in
> readside.

What arch uses a spinlock for atomic_read()?  I just had a quick grep and
didn't see any.
