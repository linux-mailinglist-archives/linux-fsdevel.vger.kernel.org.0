Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CC631609D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 09:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhBJIJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 03:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbhBJIIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:08:30 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B14C061786
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 00:07:49 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id q7so1016846iob.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 00:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=98mx76uaPdJqL0VhtaVU92mMJ6dVgmBYgimqJ+8i0UI=;
        b=O4WEm0xyaRW+E3d88T5ocr3SaTP/FpZmyScK7tiawMOmO7k/DmdjpLZc7VFNtgGEs8
         vhJgV1K5OHZg44KvjQy7jvBEoqb54obKeIfTh0fAhOzjQ+zI4Xpbql6PIL91+oPJfJvW
         cGyl9M1MVB2gN3BxvHdeXtlEEuYtdqdJDbf/Vh0p8WHux07THNA0E/9fCq8xO5SHizhM
         kThMz2X5iR3Dr7eRdXGTuoZcBkv3eQ8QREs+0VTmMlbeqMw6YB7scmyQ9Zr6OuQmk8Qb
         UiN0Z7y7gKpiQLSu8YlBxhN3ZfRsjGs4IA+dkwi5cs3F86WcbMZmpV2XNJnjzIhdVJx8
         zlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=98mx76uaPdJqL0VhtaVU92mMJ6dVgmBYgimqJ+8i0UI=;
        b=GsGq1oUG7+qCQyrD9/C2uTJHMDSe/wVeMKAlHd2+6sxusWH4yxOvvd+GaFz5zXK3FY
         M01lsNhcvqPsqoMm64Xi9XqqSWc8Aub4FJFdYtEpX+x3gF7OITaTEz7K9VkGjwrs349x
         PvUIy0EMKYveRAVZX+m5WUEIxS3fTFgXBBorfpJ+G4HmELlbtD1sgAiTmecL6YCcl5DY
         HF7nfh/UZNtDSRERyBP+Lz8zlPt6E37gFSX7SX61S34XK78I2UHf3bPHSB6n8j4TOwdu
         kOPLn7fRjc8zFHOEpVYQQIenyHCK2uPZkX+7OwaY7mfjpVJRU0b1NEqAyGUZcEcQq6CV
         aWmA==
X-Gm-Message-State: AOAM533MARCzNgv4UPO9AgHE+1mXBe+zIXHc7GAlHth70hz6g0nSlMYT
        q+HMukPOReRLvfTtuwP1VKXcNdqxiqubGy0B4WXObK9+E/U=
X-Google-Smtp-Source: ABdhPJwNf7tFtRDQsW/ENn0nmrH2qUgHVU/kFEvAXxZxABDlzboo4kjWk/ogZAteD2hJUCqUjPudp/VXN4u3w3arT/U=
X-Received: by 2002:a05:6638:2694:: with SMTP id o20mr2074509jat.132.1612944469295;
 Wed, 10 Feb 2021 00:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20210209023008.76263-1-axboe@kernel.dk> <20210209115542.3e407e306a4f1af29257c8f6@linux-foundation.org>
 <32dba5cc-7878-3b7b-45e4-84690a45a998@kernel.dk>
In-Reply-To: <32dba5cc-7878-3b7b-45e4-84690a45a998@kernel.dk>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 10 Feb 2021 09:07:44 +0100
Message-ID: <CA+icZUWBrHA72gQzyByKbNeCzaaVcNX85VwnYHozp6KWBt5tHQ@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/3] Improve IOCB_NOWAIT O_DIRECT reads
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 9, 2021 at 10:25 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/9/21 12:55 PM, Andrew Morton wrote:
> > On Mon,  8 Feb 2021 19:30:05 -0700 Jens Axboe <axboe@kernel.dk> wrote:
> >
> >> Hi,
> >>
> >> For v1, see:
> >>
> >> https://lore.kernel.org/linux-fsdevel/20210208221829.17247-1-axboe@kernel.dk/
> >>
> >> tldr; don't -EAGAIN IOCB_NOWAIT dio reads just because we have page cache
> >> entries for the given range. This causes unnecessary work from the callers
> >> side, when the IO could have been issued totally fine without blocking on
> >> writeback when there is none.
> >>
> >
> > Seems a good idea.  Obviously we'll do more work in the case where some
> > writeback needs doing, but we'll be doing synchronous writeout in that
> > case anyway so who cares.
>
> Right, I think that'll be a round two on top of this, so we can make the
> write side happier too. That's a bit more involved...
>
> > Please remind me what prevents pages from becoming dirty during or
> > immediately after the filemap_range_needs_writeback() check?  Perhaps
> > filemap_range_needs_writeback() could have a comment explaining what it
> > is that keeps its return value true after it has returned it!
>
> It's inherently racy, just like it is now. There's really no difference
> there, and I don't think there's a way to close that. Even if you
> modified filemap_write_and_wait_range() to be non-block friendly,
> there's nothing stopping anyone from adding dirty page cache right after
> that call.
>

Jens, do you have some numbers before and after your patchset is applied?

And kindly a test "profile" for FIO :-)?

Thanks.

- Sedat -
