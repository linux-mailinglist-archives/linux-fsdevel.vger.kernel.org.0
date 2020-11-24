Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC62C3381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 22:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgKXVrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 16:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732515AbgKXVrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:47:00 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BD3C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 13:47:00 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id v202so345501oia.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 13:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=04YZn/oOi9cwlQjeUz6wAhKNr23VM3kG20feokh0qeg=;
        b=VzQAooJ4hoEvvjBCc+1Qt2u70siZAJm6h9WtKGpP0ywmkQ1vspYXHydmfQoTf4ym3I
         oqKJzcR5krrs+o2BlUzYp3kcBIpfa6E6ew96qdIC2DTZU5N5pj5QjitRF0O5vAP3DLm/
         Rw71YTkXEZBmOi1/VFYN3Po6znE+JQDeN5AQ5GT8PpDyb4DUQYVH9RDLVPxXCtlzpqGL
         NLPgS8k2q9XJZCcEqp0jixScddihjCkoUiurydf3GmXYEZPzwqkjXKYbEuCjos3F0Dgj
         X3M8gEHfAlkVbtkko2WkcUF0RRIGEvajB3ukYdimzdhZa9OdqeypZLEs6CnYwqCUGZF7
         gNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=04YZn/oOi9cwlQjeUz6wAhKNr23VM3kG20feokh0qeg=;
        b=q8nild6WAECZQ4jq6NKhWL7rWc6d5IcW8kKVLSAztuAB0ei148f3EQhzREq6hBykZ9
         9LcsQbMGwZQVJn0L+O9BbgQ1SKxAIjEyeCIbPgH/OCIIn2R1/k+xbEhxiW8T2MK3W8j1
         cAOwORTs1sZgLNEX3ZKMx6VyxoUgB0Mqovab78kaTUgznI4g1MAr/yLlRVAZ1EkIbLHD
         soxuGdFfgLRg6/lpOyfyMZz538dbBecvaQiWk3cV3rjjp/1M5BqHmzLR0JIoRLslS3ZC
         W63Iv/Zn/SVUyCSRD3dlm+tsXusoKRyia4eiBLRdoLC566Wz9KpC9OtBJBWH1QBW7tcm
         SXJA==
X-Gm-Message-State: AOAM532cQ84jYiACEMPk3EU9ob+UkVji4zuoy/A/ju7L3fZ9WeyMhpek
        YYizg/dlJU2jp5WIeYR2xQrZrA==
X-Google-Smtp-Source: ABdhPJxOVg+Bowm05sagrPqp3xv+YibTG16pRL9z0qkeXz1sv96JtkxPJaBWAFfkjlhlZQfRI/zZYw==
X-Received: by 2002:aca:f5c8:: with SMTP id t191mr213734oih.40.1606254419120;
        Tue, 24 Nov 2020 13:46:59 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a4sm139138otj.29.2020.11.24.13.46.56
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2020 13:46:58 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:46:44 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
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
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
In-Reply-To: <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2011241322540.1777@eggly.anvils>
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz> <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com> <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
 <20201124121912.GZ4327@casper.infradead.org> <alpine.LSU.2.11.2011240810470.1029@eggly.anvils> <20201124183351.GD4327@casper.infradead.org> <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com> <20201124201552.GE4327@casper.infradead.org>
 <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Nov 2020, Linus Torvalds wrote:
> On Tue, Nov 24, 2020 at 12:16 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > So my s/if/while/ suggestion is wrong and we need to do something to
> > prevent spurious wakeups.  Unless we bury the spurious wakeup logic
> > inside wait_on_page_writeback() ...
> 
> We can certainly make the "if()" in that loop be a "while()'.
> 
> That's basically what the old code did - simply by virtue of the
> wakeup not happening if the writeback bit was set in
> wake_page_function():
> 
>         if (test_bit(key->bit_nr, &key->page->flags))
>                 return -1;
> 
> of course, the race was still there - because the writeback bit might
> be clear at that point, but another CPU would reallocate and dirty it,
> and then autoremove_wake_function() would happen anyway.
> 
> But back in the bad old days, the wait_on_page_bit_common() code would
> then double-check in a loop, so it would catch that case, re-insert
> itself on the wait queue, and try again. Except for the DROP case,
> which isn't used by writeback.
> 
> Anyway, making that "if()" be a "while()" in wait_on_page_writeback()
> would basically re-introduce that old behavior. I don't really care,
> because it was the lock bit that really mattered, the writeback bit is
> not really all that interesting (except from a "let's fix this bug"
> angle)
> 
> I'm not 100% sure I like the fragility of this writeback thing.
> 
> Anyway, I'm certainly happy with either model, whether it be an added
> while() in wait_on_page_writeback(), or it be the page reference count
> in end_page_writeback().
> 
> Strong opinions?

Responding to "Strong opinions?" before having digested Matthew's
DMA sequence (no, not his DNA sequence).

I think it comes down to whether my paranoia (about accessing an
unreferenced struct page) is realistic or not: since I do hold
that paranoia, I do prefer (whatever variant of) my patch.

I'm not a memory hotremove guy. I did search mm/memory_hotplug.c
for references to rcu or stop_machine(), but found none.  I can
imagine that the memory containing the struct pages would be
located elsewhere than the memory itself, with some strong
barrier in between removals; but think there were patches posted
just a few days ago, with intent to allocate struct pages from
the same memory block.  It would be easy to forget this writeback
issue when hotremove advances, if we don't fix it properly now.

Another problem with the s/if/while/ solution: I think Matthew
pointed to another patch needed, to prevent wake_up_page_bit()
from doing an inappropriate ClearPageWaiters (I've not studied
that patch); and would also need a further patch to deal with
my PF_ONLY_HEAD VM_BUG_ON(PageTail).  More?

I think the unreferenced struct page asks for trouble.

Hugh
