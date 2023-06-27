Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B14473F469
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 08:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjF0GUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 02:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF0GUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:20:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30AB99
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 23:20:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-262ec7b261bso1552428a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687846824; x=1690438824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpHw1QDmEHx/Q28CDegBguPn7MiNP2UVGDtHMJ0+VaY=;
        b=4oDV2LPC3PUNVaSWUo/A3usF0IsC5xn2HUf04m0EFO+cQvYmCEaDvpOZ4ynCHQM7gf
         a8ViXxsQdcdEihu7IkrlD0ZdfYEdP0dDU5YGoCjioCnPI4d3kJFPrcCBqHJbYcGIYfFk
         MMja2IOqv8dfeD0meHBrLe5/GCKGgiGU5mc7fJAFP1pkkIXELi2m0lRLBskVxCxRKC4B
         G2c08CSmRGPcwyPBIaxJfZ+B6DDyDr6lvuE6N8b99pPvHmrhDeTmvypli3RryQiWoX/h
         UN6GxLv3UR12/mPXmewHShdOXXlZN+pJj7ddrbulLaPujqCaZYWJopfzmHx9PFp7FX7C
         pKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687846824; x=1690438824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpHw1QDmEHx/Q28CDegBguPn7MiNP2UVGDtHMJ0+VaY=;
        b=YINTfauwCVxtJH+DQvMWy322f64ZVfg0wtltk6DxuduJqzFws4/1AGMOfudee3+L7k
         a+9E0zyZ/1RqfgkRWNWefi4RXmS3KUueVKdSbeO+0XXL6WgQ053fMMjjJKqYKwmJb8bg
         jUAPRJF98v/BHJQdKO0VlGFFpjZdL0gRPJ8xQUzZ0jsUzFo2vyMSaHKZb8DAmQdTH9si
         TzBk6nQm6J0j34OjGs4gk6ZrlYGZVsJb5kM8HKI4cT5ou8AtwyYoeOdQonuI1SuuOI9I
         T3nRp4WXpAuP8q7l1SPIFIGqp88i3ywf2nmLODnxKbzWXso8nA3ZwG5xB0G+wrh0jPon
         gGAw==
X-Gm-Message-State: AC+VfDyRIbREQJSSH3iIhx3lIZ6p31oEx3Mc1MU26U4h0DVdxQZwp2Xa
        MYA/jS1nmNyPMTSQ5uxjy2D9sg==
X-Google-Smtp-Source: ACHHUZ5q0L4ILWE12lYi9ixbt5lpxLi6IrFLNxsWcp9qqTYF4DOpdcPeYWrXe4KERaaHpe0Zb/yPaQ==
X-Received: by 2002:a17:90a:1906:b0:25e:a8ab:9157 with SMTP id 6-20020a17090a190600b0025ea8ab9157mr28909265pjg.22.1687846824202;
        Mon, 26 Jun 2023 23:20:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090a744600b00262d9b4b527sm4248928pjk.52.2023.06.26.23.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 23:20:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qE23p-00Gisw-0r;
        Tue, 27 Jun 2023 16:20:21 +1000
Date:   Tue, 27 Jun 2023 16:20:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [Reproducer] Corruption, possible race between splice and
 FALLOC_FL_PUNCH_HOLE
Message-ID: <ZJp/pVQntJjEy3Lj@dread.disaster.area>
References: <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJp4Df8MnU8F3XAt@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 03:47:57PM +1000, Dave Chinner wrote:
> On Mon, Jun 26, 2023 at 09:12:52PM -0400, Matt Whitlock wrote:
> > Hello, all. I am experiencing a data corruption issue on Linux 6.1.24 when
> > calling fallocate with FALLOC_FL_PUNCH_HOLE to punch out pages that have
> > just been spliced into a pipe. It appears that the fallocate call can zero
> > out the pages that are sitting in the pipe buffer, before those pages are
> > read from the pipe.
> > 
> > Simplified code excerpt (eliding error checking):
> > 
> > int fd = /* open file descriptor referring to some disk file */;
> > for (off_t consumed = 0;;) {
> >   ssize_t n = splice(fd, NULL, STDOUT_FILENO, NULL, SIZE_MAX, 0);
> >   if (n <= 0) break;
> >   consumed += n;
> >   fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, consumed);
> > }
> 
> Huh. Never seen that pattern before - what are you trying to
> implement with this?
> 
> > Expected behavior:
> > Punching holes in a file after splicing pages out of that file into a pipe
> > should not corrupt the spliced-out pages in the pipe buffer.
> 
> splice is a nasty, tricky beast that should never have been
> inflicted on the world...
> 
> > Observed behavior:
> > Some of the pages that have been spliced into the pipe get zeroed out by the
> > subsequent fallocate call before they can be consumed from the read side of
> > the pipe.
> 
> Which implies the splice is not copying the page cache pages but
> simply taking a reference to them.
> 
> > 
> > 
> > Steps to reproduce:
> > 
> > 1. Save the attached ones.c, dontneed.c, and consume.c.
> > 
> > 2. gcc -o ones ones.c
> >   gcc -o dontneed dontneed.c
> >   gcc -o consume consume.c
> > 
> > 3. Fill a file with 32 MiB of 0xFF:
> >   ./ones | head -c$((1<<25)) >testfile
> >
> > 4. Evict the pages of the file from the page cache:
> >   sync testfile && ./dontneed testfile
> 
> To save everyone some time, this one liner:
> 
> # xfs_io -ft -c "pwrite -S 0xff 0 32M" -c fsync -c "fadvise -d 0 32M" testfile
> 
> Does the same thing as steps 3 and 4. I also reproduced it with much
> smaller files - 1MB is large enough to see multiple corruption
> events every time I've run it.
> 
> > 5. Splice the file into a pipe, punching out batches of pages after splicing
> > them:
> >   ./consume testfile | hexdump -C
> > 
> > The expected output from hexdump should show 32 MiB of 0xFF. Indeed, on my
> > system, if I omit the POSIX_FADV_DONTNEED advice, then I do get the expected
> > output. However, if the pages of the file are not already present in the
> > page cache (i.e., if the splice call faults them in from disk), then the
> > hexdump output shows some pages full of 0xFF and some pages full of 0x00.
> 
> Like so:
> 
> 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 01b0a000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> *
> 01b10000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 01b12000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> *
> 01b18000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 01b19000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> *
> 01b20000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 01b22000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> *
> 01b24000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 01b25000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> *
> 01b28000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 01b29000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> *
> 01b2c000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 
> Hmmm. the corruption, more often than not, starts on a high-order
> aligned file offset. Tracing indicates data is being populated in
> the page cache by readahead, which would be using high-order folios
> in XFS.
> 
> All the splice operations are return byte counts that are 4kB
> aligned, so punch is doing filesystem block aligned punches. The
> extent freeing traces indicate the filesystem is removing exactly
> the right ranges from the file, and so the page cache invalidation
> calls it is doing are also going to be for the correct ranges.
> 
> This smells of a partial high-order folio invalidation problem,
> or at least a problem with splice working on pages rather than
> folios the two not being properly coherent as a result of partial
> folio invalidation.
> 
> To confirm, I removed all the mapping_set_large_folios() calls in
> XFS, and the data corruption goes away. Hence, at minimum, large
> folios look like a trigger for the problem.
> 
> Willy, over to you.

Just to follow up, splice ends up in the iov_iter code with
ITER_PIPE as the destination. We then end up with
copy_page_to_iter(), which if the iter is a pipe spits out to
copy_page_to_iter_pipe(). This does does not copy the page contents,
it simply grabs a reference to the page and then stuffs it into the
pipe buffer where it then sits until it is read.

IOWs, the splice to pipe operation is taking a reference to the
pagei cache page, then we drop all the locks that protect it, return
to userspace which then triggers an invalidation of the page
with a hole punch, and the data disappears from the page that is
referenced in the pipe.

So copy_page_to_iter_pipe() is simply broken. It's making the
assumption that it can just take a reference to a page cache page
and the state/contents of the page will not change until the page
is released (i.e. consumed by a pipe reader). This is not true
for file-backed pages - if the page is not locked, then anything
can happen to it while it is sitting on the pipe...

Why this requires large folios to trigger is something I don't
understand - the code looks broken even for single page objects in
the page cache. It's probably just a timing issue that high order
folios tickle much more easily with different readahead and
invalidation patterns.

Anyway, this needs iov_iter/folio expertise at this point...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
