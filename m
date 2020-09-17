Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1A26E6AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIQUXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgIQUXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:23:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9353EC061354;
        Thu, 17 Sep 2020 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i2g+iVbAG39YGu0vGd8X2BoDQWoC64Ybtmoal27YBKM=; b=fG8NJDMUeO+xJ5IYHpW0p13xcC
        j1gcz/wF4EfyQcmVCgnx74Me+Y6xw4RzluusTZbQLmPxpnaf2SIT/GmD0TfjthlJEj4SB+Li87sNf
        zmKjGTVM8Q7YbyvxtN6dlZRn59TklFbJihAeZ70iiRP8Ov0sRdw2yHnJuf7xHk0JYkrBriOoUyxES
        Q0xOR4wNSZl+EOxV8ddmCS0BlCM61Esr/EtZdMfFydnH6J2Ut4E305DAHxTycDB9MzLoiaZlo3FHq
        MrCNFRlkW2rHha1lA/qdqaxbYgGXHCt5h10cVvM4+jjiI5QLgeJ3NcMpFl8XpbUuYnAicwrP4uEWZ
        WbSk9F9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIzYh-0002Gx-Io; Thu, 17 Sep 2020 19:27:07 +0000
Date:   Thu, 17 Sep 2020 20:27:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200917192707.GW5449@casper.infradead.org>
References: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
 <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org>
 <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org>
 <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:00:06PM -0700, Linus Torvalds wrote:
> On Thu, Sep 17, 2020 at 11:50 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Ahh.  Here's a race this doesn't close:
> >
> > int truncate_inode_page(struct address_space *mapping, struct page *page)
> 
> I think this one currently depends on the page lock, doesn't it?
> 
> And I think the point would be to get rid of that dependency, and just
> make the rule be that it's done with the i_mmap_rwsem held for
> writing.

Ah, I see what you mean.  Hold the i_mmap_rwsem for write across,
basically, the entirety of truncate_inode_pages_range().  I don't see
a problem with lock scope; according to rmap.c, i_mmap_rwsem is near
the top of the hierarchy, just under lock_page.  We do wait for I/O to
complete (both reads and writes), but I don't know a reason for that to
be a problem.

We might want to take the page lock anyway to prevent truncate() from
racing with a read() that decides to start new I/O to this page, which
would involve adjusting the locking hierarchy (although to a way in which
hugetlb and the regular VM are back in sync).  My brain is starting to
hurt from thinking about ways that not taking the page lock in truncate
might go wrong.

