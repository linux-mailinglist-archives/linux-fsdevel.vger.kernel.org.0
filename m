Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00122C2CE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 17:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbgKXQ2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 11:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390470AbgKXQ2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:28:32 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE142C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 08:28:32 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 11so7349030oty.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ah+J2wD/1faDZjYB3Zrgws96wmPFn4mzRk/eDM0VpfE=;
        b=h2tPcALcjB1t4yCELbdTsVIXBflLhIBZpuIe7YEIWaqMrErciI4oYibsR4PuSR3eBm
         a1HQUDkbKIXT7dw2dF1osk+Ewd3ry8H3qWPqrsnSSvpwphmnYiduGvPC/acc89Z4HoBF
         dQR/Qust/cntC0l8MxoB01tlPMhZdg1GZvFe3YCRbX0EKSlHwbCzgWJ+8KF8ujYqRMcW
         p809jw2U5Nyr4t7ccXvc7ZQ/lpTlBodFDk0ppPG9Td5VTTRT1dKl5zZ+op8i964Uwmcn
         oQyidKfqYMNIuIxyBYIQwwGDr7gMOmgSS8FTpPSS8SBScIpqSj6pDarOKlRo1GGyy13e
         DtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ah+J2wD/1faDZjYB3Zrgws96wmPFn4mzRk/eDM0VpfE=;
        b=Dw6l0ocgyfY1+bztCrjpBJZtujJqH61VEUI6U7+NbYsp0eCcwIDqo5f4UWLP6wBTq5
         fC2a25S61Xc9vur6yYCInQu9fNckv2QPjW63smiIZJ2g5Xu1N7B/KU3EeheIwiorAbI+
         6uKqDZYyMozUjs8ncsFOj0k7zL/rjPqU5ri//kxXkIhMkS8gUxfQcIssOkTGjzu+HQBu
         JuinMp0WsjL0FIkpq3ka7fW6JApzoPIEdYBYm2q1rnXCV83uNZ3oKdbN+ygMtz05tieP
         N9E1bMMw3q1rofuy255V2FelQ6Mn24JGugJ0t/YF3dhFg6zAY6v1K2pftyiaWv10D7aj
         SNvw==
X-Gm-Message-State: AOAM53100g9PHW6+KNVOMfEQ4cPxp1aPhBhzIOFzWvG48ApP2rgllRbK
        tjZy+Sa37EWUERv2mcjOxXXcYw==
X-Google-Smtp-Source: ABdhPJwD6ulzDfoJYVk98EDsBubLOjkB0ZnaCfJOcW8zo99O0ipagto7b7cafmz/JIb+EReFJU1LvA==
X-Received: by 2002:a05:6830:1f11:: with SMTP id u17mr4030280otg.287.1606235311779;
        Tue, 24 Nov 2020 08:28:31 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u4sm7428592ote.71.2020.11.24.08.28.29
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2020 08:28:30 -0800 (PST)
Date:   Tue, 24 Nov 2020 08:28:16 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
In-Reply-To: <20201124121912.GZ4327@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2011240810470.1029@eggly.anvils>
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz> <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com> <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
 <20201124121912.GZ4327@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Nov 2020, Matthew Wilcox wrote:
> On Mon, Nov 23, 2020 at 08:07:24PM -0800, Hugh Dickins wrote:
> > 
> > Then on crashing a second time, realized there's a stronger reason against
> > that approach.  If my testing just occasionally crashes on that check,
> > when the page is reused for part of a compound page, wouldn't it be much
> > more common for the page to get reused as an order-0 page before reaching
> > wake_up_page()?  And on rare occasions, might that reused page already be
> > marked PageWriteback by its new user, and already be waited upon?  What
> > would that look like?
> > 
> > It would look like BUG_ON(PageWriteback) after wait_on_page_writeback()
> > in write_cache_pages() (though I have never seen that crash myself).
> 
> I don't think this is it.  write_cache_pages() holds a reference to the
> page -- indeed, it holds the page lock!  So this particular race cannot
> cause the page to get recycled.  I still have no good ideas what this
> is :-(

It is confusing. I tried to explain that in the final paragraph:

> > Was there a chance of missed wakeups before, since a page freed before
> > reaching wake_up_page() would have PageWaiters cleared?  I think not,
> > because each waiter does hold a reference on the page: this bug comes
> > not from real waiters, but from when PageWaiters is a false positive.

but got lost in between the original end_page_writeback() and the patched
version when writing that last part - false positive PageWaiters are not
relevant.  I'll try rewording that in the simpler version, following.

The BUG_ON(PageWriteback) would occur when the old use of the page, the
one we do TestClearPageWriteback on, had *no* waiters, so no additional
page reference beyond the page cache (and whoever racily frees it). The
reuse of the page definitely has a waiter holding a reference, as you
point out, and PageWriteback still set; but our belated wake_up_page()
has woken it to hit the BUG_ON.

Hugh
