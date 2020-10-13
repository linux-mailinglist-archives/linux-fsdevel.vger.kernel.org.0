Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4228D509
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgJMUAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 16:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgJMUAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:00:01 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D09C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 13:00:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 184so1098620lfd.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Jb7sx7Ii01LC6NuZKYQ5O8hpG74QZCcZIdRozAwLv18=;
        b=VVHDW+0Di2iz6lOyiO4UFXzhSJcqHmh6VEQh3cSXio04Yl6FhiJ93gduvN+RGQ6Rpm
         KFmuX84jR/0srD4WnmztHdL6WbXXrxZ+1v29zV1nMr88Kg4y+n5DNCJT2MKPQfS30B3S
         2Qqm/tSlGwZk9TqZCLiYO+Hf7dX3gtQRD9l5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Jb7sx7Ii01LC6NuZKYQ5O8hpG74QZCcZIdRozAwLv18=;
        b=kmKEcsVrYMx/W/1nA9SkMgSBnk2hMkmrLlOlR/0cmoZjiEokBgzLyccr3zt8z31U37
         EqitjrvwSWY2B3yzOYcx2WHFU6cFUJB0JyavMKuOnnnkvQAMGOXbpSyMryTtVyfDhfDV
         r/fM8aYy/yFHWNlvcoxdrZU26vQ5KenkaYZqVU8/0MBycTai4P3jpchW9CpRA4/yYd4+
         NWzfmrCrw4rkJuj7jWbbPkZG4JOChGeQsUI+Dt6A+ChI8L5uI2TS1tPnWeqCKbDpcXWZ
         AZFqhW9lvzsoOLca3FIE8y0WHjyHVoz+UiZXLiIbpU3QrMFNDmnhsUh5LjwnyYT9A897
         hzKA==
X-Gm-Message-State: AOAM533q50UwtxTha2fPAzTK5Qd+QRzbr4nHMm+j/XWLSw7mDW9VTgWh
        0obHG0REPos9MkWVEGxma5BQtnEpQGuFPw==
X-Google-Smtp-Source: ABdhPJwJf1Lj1G7sVWrqxQO7AGMU0H2nlDHpXCt1B24/RMzVqhGnkLn2Kv9gjp3rimlY7uhWtG725A==
X-Received: by 2002:a19:8c07:: with SMTP id o7mr287752lfd.525.1602619198925;
        Tue, 13 Oct 2020 12:59:58 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u25sm242056lfq.84.2020.10.13.12.59.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:59:58 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id a7so1075988lfk.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 12:59:57 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr337669lfa.603.1602619197380;
 Tue, 13 Oct 2020 12:59:57 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Oct 2020 12:59:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
Message-ID: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
Subject: [PATCH 0/4] Some more lock_page work..
To:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So this is all just preliminary, but I'd really like to have people
think more about the page fault handling of the page lock, and I have
a small experimental series of patches for people to look at and maybe
get the discussion started.

The three first patches are really just fairly trivial cleanups. They
also likely don't really matter, because the *bulk* of all faults -
particularly the ones that really shouldn't need any page locking
games - should be all about just "filemap_map_pages()". Which is that
optimistic "let's insert pages from the page cache as efficiently as
possible" case.

That's how all the normal private pages that don't actually get
modified (so executables, but also any load that uses mmap as a
zero-copy read) should generally get populated.

That code doesn't actually do "lock_page()" itself (because it all
runs under the RCU read lock), but it does to do a trylock, and give
up if the page was locked. Which is fine as long as you don't get any
contention, but any concurrent faults of the same page in different
address spaces will then just mess with other faulters and cause it to
fall out of the fast path.

And looking at that code, I'm pretty sure it doesn't actually *need*
the page lock. It wants the page lock for two reasons:

 - the truncation worries (which may or may not be relevant - xfs
wraps the map_pages with xfs_ilock)

 - compound page worries (sub-page mapcount updates and page splitting issues)

The compound page case I'm not sure about, but it's probably fine to
just lock the page in that case - once we end up actually just mapping
a hugepage, the number of page faults should be small enough that it
probably doesn't matter.

The truncation thing could be handled like xfs does, but honestly, I
think it can equally well be handled by just doing some operations in
the right order, and double-checking that we don't race with truncate.
IOW, first increasing the page mapcount, and then re-checking that the
page still isn't locked and the mapping is still valid, and reachable
in the xarray.

Because we can still just drop out of this loop and not populate the
page table if we see anything odd going on, but if *this* code doesn't
bother getting the page lock (and we make the COW code not do it
either), then in all the normal cases you will never have that "fall
out of the common case".

IOW, I think right now the thing that makes us fall back to the actual
page lock is this code itself: by doing the 'trylock", it will make
other users of the same page not able to do the fast-case. And I think
the trylock is unnecessary.

ANYWAY. The patch I have here isn't actually that "just do the checks
in the right order" patch. No, it's a dirty nasty "a private mapping
doesn't need to be so careful" patch. Ugly, brutish and nasty. Not the
right thing at all. But I'm doing it here simply because I wanted to
test it out and get people to look at this.

This code is "tested" in the sense that it builds for me, and I'm
actually running it right now. But I haven't actually stress-tested it
or tried to see if it gets rid of some page lock heavy cases.

Comments?

                         Linus
