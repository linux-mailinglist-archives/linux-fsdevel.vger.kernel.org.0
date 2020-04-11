Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2171A53D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 23:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgDKVsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 17:48:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgDKVsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 17:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ZNCz+B4KIIk9p9ZumerQ70SmmhJHlat7P94bUwDWh8=; b=SINfAoTU4O24ytUDtYf1j82q+Z
        A1I3Ar8BrxWzvcxSg5gnFiUsb9qYKWvPSQR8YklWS0mUivQrwrgYFVzZeMfJAro6cscJhv312rb9q
        rebxadfwUUQudNav98lFPeHlzsOLnHymVfcahAaAz291r6PvfK80krtUtUGyKQ5L3FyxZE2Hy3bOE
        vAA99nQjABglrww54wXf5XYkdqPHUIg99xvICtZES0NxrPFdDTP1DRQZb5R4xmsVOcJOKuBzpsHZJ
        FkxE8iXkaeNsgLXTmMiAhN6ZXjxCYTlCJKAZnCIHDeofv+vO31n6+y+e3jVtQyQOR+siiz8hHwyJ1
        r5YgqHmQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNNz8-0004lD-Ct; Sat, 11 Apr 2020 21:48:18 +0000
Date:   Sat, 11 Apr 2020 14:48:18 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Rename page_offset() to page_pos()
Message-ID: <20200411214818.GH21484@bombadil.infradead.org>
References: <20200411203220.GG21484@bombadil.infradead.org>
 <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 01:57:56PM -0700, Linus Torvalds wrote:
> So honestly, i the confusion is that we have "pgoff_t", which is the
> offset of the page counted in _pages_, then my reaction is that
> 
>  (a) I think the truly confusing name is "pgoff_t" (and any
> "page_offset" variable of that type). Calling that "pgindex_t" and
> "page_index" would be a real clarification.

I think you're right.  I have a patch series queued for 5.8 which
renames a lot of 'pgoff_t offset' to 'pgoff_t index'.  I wouldn't mind
at all renaming pgoff_t to pgindex_t.  If you're amenable, pgidx_t would
be shorter.

>  (b) if we really do want to rename page_offset() because of confusion
> with the page index "offset", then the logical thing would be to
> clarify that it's a byte offset, not the page index.

I wasn't entirely forthcoming ... I actually want to introduce a new

#define page_offset(page, x) ((unsigned long)(x) & (page_size(page) - 1))

to simplify handling huge pages.  So I always want to see offset be a
byte count.  offset_in_page() is already taken, and I have no idea what
else to call the function to get the offset of this address within a
particular page.

> If we'd want a _descriptive_ name, then "byte_offset_of_page()" would
> probably be that. That's hard to mis-understand.
> 
> Yes that's also more of a mouthful, and it still has the "two
> different names for the same thing" issue wrt
> stable/old/rebased/whatever patches.

That was one of the options we discussed, along with file_offset_of_page().

> Which is why I'd much rather change "pgoff_t" to "pgindex_t" and
> related "page_offset" variables to "page_index" variables.

There's only about 20 of those out of the 938 pgoff_t users.  But there's
over a hundred called 'pgoff'.  I need to get smarter about using
Coccinelle; I'm sure it can do this.

