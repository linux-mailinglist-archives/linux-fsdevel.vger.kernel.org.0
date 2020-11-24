Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E812C1CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 05:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgKXE1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 23:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKXE1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:27:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4809CC0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 20:27:09 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j205so26951341lfj.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 20:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24cszGpR4ywO4s4bnLwJTzF6tXtNEZ3Sx4FvfUI5fRM=;
        b=Qo/w8pRweB3KyHg3F/WpjXkumwlz+D/AvIsfhGajTbc5rxWuFX6axMRr2JB4kSL4pA
         hIBC4OqrP3RwB25oHrD6ZaKBqVFGtNoYL6Y4nSMoCfYeCeQOINqE3jTOyTbnWeWoHLiI
         UkFQ9R+vhIKbEe6WKzj2zXtFUjc557jUOVygU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24cszGpR4ywO4s4bnLwJTzF6tXtNEZ3Sx4FvfUI5fRM=;
        b=I4PR31/yHycO2kVxQ3tPabXo+Fj5UbDNU94dv8lfpKt+nPZr19YQhlYGzZozTB2g+0
         vIhhdXLEm37KB7X4FIMy2F4fXJFiVDPPDzH4j9A+cMFX9RFvyzKzMC1p7mryv2dWeiYP
         InfvXEGDR3lw9TKrdr+l0JHRcP8vNcBrS0Cm67KRdc01mAvZVFrOE35OJlundQzcgWjR
         mpB1WR6jHkjbW8uVPctQ8di0fsvMH0iALGi8i8cYN9Dt8zJKBArAyamHgKLI08QW+Wnr
         qbbYMZpFqaBnqF4Ll5M0w6qI5MansaFxbj+kw+7zHgMTXxmgNtU65rU3A/R5IJUKMHPn
         DAlw==
X-Gm-Message-State: AOAM533S2vBCTfnJtfRV3DjSqhVaviaHGDIGrlKjDZc3fE3QQQkEbiSN
        dIiI9Lmya4GQ3DclfJUza/tOTCgyVn4Vpw==
X-Google-Smtp-Source: ABdhPJwwgv23RAvOGLn7F4ZCOuCQqTU8tNO+YbNXiw4swo0r0e/7AX4tU/CREBqor7c7vHV5XkqZWA==
X-Received: by 2002:a19:228f:: with SMTP id i137mr1009855lfi.477.1606192027415;
        Mon, 23 Nov 2020 20:27:07 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id p15sm1592867lfk.111.2020.11.23.20.27.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 20:27:07 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id t6so10828543lfl.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 20:27:06 -0800 (PST)
X-Received: by 2002:a19:3f55:: with SMTP id m82mr1019862lfa.344.1606192024162;
 Mon, 23 Nov 2020 20:27:04 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Nov 2020 20:26:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjcSFM+aqLnh7ucx3_tHpc1+9sJ+FfhSgVFH316uX2FZQ@mail.gmail.com>
Message-ID: <CAHk-=wjcSFM+aqLnh7ucx3_tHpc1+9sJ+FfhSgVFH316uX2FZQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 8:07 PM Hugh Dickins <hughd@google.com> wrote:
>
> The problem is that PageWriteback is not accompanied by a page reference
> (as the NOTE at the end of test_clear_page_writeback() acknowledges): as
> soon as TestClearPageWriteback has been done, that page could be removed
> from page cache, freed, and reused for something else by the time that
> wake_up_page() is reached.

Ugh.

Would it be possible to instead just make PageWriteback take the ref?

I don't hate your patch per se, but looking at that long explanation,
and looking at the gyrations end_page_writeback() does, I go "why
don't we do that?"

IOW, why couldn't we just make the __test_set_page_writeback()
increment the page count if the writeback flag wasn't already set, and
then make the end_page_writeback() do a put_page() after it all?

            Linus
