Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15162294908
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502033AbgJUHki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 03:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502031AbgJUHki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:40:38 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F148C0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2020 00:40:38 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id p25so717737vsq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2020 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mtQOW6D1USj4MjnIX8atmYyrC1zhErL4qFSeejgPT8=;
        b=k3WmRGdAFyK8jMXfE7roxIWmia7TeryL7DVPGIAhx9S8ozMk7jwNZD668y6Oz1Faeg
         5LN/AUxEQjonkjrr6wX1s0YwcnZz617LCFPrybtchZ6pzczGLmjPbeyemtzPkAMnv930
         OO83ISIcg5X4BmqFg0rFSEowJmZ3z8w7i3SX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mtQOW6D1USj4MjnIX8atmYyrC1zhErL4qFSeejgPT8=;
        b=Gk64mNqmAcQsQ54SoCK9c4BZgKx34mgwOf0LaFFydP/Xd/Id9nOgUKUck9OGAFoc2g
         F0Q2/Lgid4t1XZPo7KrALxNv1uh9f3FYxtrYQ2CsCvb86KF+A3c+g9cOn7VyfUlpAL1C
         ldz/M2A44HIkqSpquNwRrqYkwJGxQpDg0Iz2ZqIwswfI5NmvCh2uwoSAn07PM3gcVb/V
         InrLzPICkkrYtAd6Q/+wfLuCTace1C23uDzoOTCyvMqgohsmvp2F2nHgrHgLQZh1WOLf
         KA4/edowKfKW1rW2dG7cbiX7PCvXI/snQGUUSC7OZzvBY97e6o+CnLqsaRRa7hgmp5fu
         5UtA==
X-Gm-Message-State: AOAM533gE9tT3gVa3iHFSCGBP25N03KyR6ZKcJ8EQTvikAlSV+4QrhIi
        Lytr0lEtY/FYWVIRHJHwzaBhn+iAHSu+TlDcwPPknA==
X-Google-Smtp-Source: ABdhPJxsPR/XLiWCus69OSm6AV0nscBgh+CbaaNx3IONePVwbpD6FAXRc791kqaLdWxN/7qWOH8bmMck3vMq/vJ25ng=
X-Received: by 2002:a05:6102:21aa:: with SMTP id i10mr849419vsb.9.1603266037215;
 Wed, 21 Oct 2020 00:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw> <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com> <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
 <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com> <20201020204226.GA376497@redhat.com>
In-Reply-To: <20201020204226.GA376497@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Oct 2020 09:40:26 +0200
Message-ID: <CAJfpegsi8UFiYyPrPbQob2x4X7NKSnciEz-a=5YZtFCgY0wL6w@mail.gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> As you said, for the full page WRITE, we can probably mark it
> page uptodate write away and drop page lock (Keep reference and
> send WRITE request to fuse server). For the partial page write this will
> not work and there seem to be atleast two options.
>
> A. Either we read the page back from disk first and mark it uptodate.
>
> B. Or we keep track of such partial writes and block any further
>    reads/readpage/direct_IO on these pages till partial write is
>    complete. After that looks like page will be left notuptodate
>    in page cache and reader will read it from disk. We are doing
>    something similar for tracking writeback requests. It is much
>    more complicated though and we probably can design something
>    simpler for these writethrough/synchronous writes.
>
> I am assuming that A. will lead to performance penalty for short
> random writes.

C.  Keep partial tail page locked.  If write involves a partial and
head AND tail page, then read head page first.  I think that would be
a good compromise between performance and simplicity.

WDYT?

Thanks,
Miklos
