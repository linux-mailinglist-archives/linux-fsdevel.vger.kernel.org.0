Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1123773F411
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjF0FsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 01:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0FsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:48:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E819A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 22:48:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5577900c06bso3123320a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 22:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687844881; x=1690436881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEXhdoBO3XVeP2WAHcxLJ5PeystxjsMEujKnxzwdraM=;
        b=LeGNSscTGe6Uvt6dQATHXjA/mUuBKpX1a8L3eBiaGimCbd/mv3Ljm7cb5ofQTnjF60
         fb9FMH6f3U6i6qsj8j0v++bh66JMD45RKxNratA4HPxVzd/IdCbfSZESe+lOGssSUdE3
         bpJv9wbPTkJpxjk3EFVZY4U2ZKJ8lpyLGpbR+KPKrmVAGV1DchtwEKmTgU9lRxx/A7I+
         NfISh/emDgptUyI1NdC+2FU8kZn7YSYu1/jhxW8eKOi9zTl/a4FakVYMjVpKnv99Qe5M
         TT9B32iIQL6L1A22Ot4DvJ21m7f/9d2zdnIQ8Muk9L1GBgGZZZ2JUR2jPK5WATcV6R15
         xN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687844881; x=1690436881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEXhdoBO3XVeP2WAHcxLJ5PeystxjsMEujKnxzwdraM=;
        b=D0d/W4/DCanVvEWIXQOVbDQX3gE7rEzXa0lSyJ2YOeAGBqpkZJG/Tcm36hSrfnlpm9
         sfAR0Q7d8JA8B/LDVAJArHFkFoh9haYPZjicuSHsJWnxQYsPu20ASDoLn44orMoOwkr3
         S3vX0aL3oJmajHla+870/I/8+KsG09uTMopyIGqfh5Zoy93By7DDH9FvVCUsczh8sHic
         4ktShMWsODXPftA/JohDViCsU5oXPXR98GvZyMNBj8coortGh/hNtCg+aSJNbgGhV5ra
         yvOijz6X4qvUm1gJiXGEHJ5d79VCvvFA9hpVpGb6FSMWBBoghq4IIl19GAYqx9oaf2fn
         zqew==
X-Gm-Message-State: AC+VfDwtMfx6W6iPWVIgFjNfC9f/Ml2wJMVi/pbhIQFO3bAIXWxC5V4/
        gOs0SHKt2KQ1HJVSErpNE4X7/43Mbku/klMIB6o=
X-Google-Smtp-Source: ACHHUZ7w9upNXvkwvi5GPtISe7+s53mTRs+n8B0DY1qSziojju0x7mFNPBn3kwJRAXPxZ4R5IL1CkQ==
X-Received: by 2002:a05:6a20:12c8:b0:127:6bda:a2ae with SMTP id v8-20020a056a2012c800b001276bdaa2aemr5232634pzg.10.1687844881244;
        Mon, 26 Jun 2023 22:48:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b0064d47cd116esm2139739pfn.161.2023.06.26.22.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:48:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qE1YT-00GiLA-2i;
        Tue, 27 Jun 2023 15:47:57 +1000
Date:   Tue, 27 Jun 2023 15:47:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [Reproducer] Corruption, possible race between splice and
 FALLOC_FL_PUNCH_HOLE
Message-ID: <ZJp4Df8MnU8F3XAt@dread.disaster.area>
References: <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:12:52PM -0400, Matt Whitlock wrote:
> Hello, all. I am experiencing a data corruption issue on Linux 6.1.24 when
> calling fallocate with FALLOC_FL_PUNCH_HOLE to punch out pages that have
> just been spliced into a pipe. It appears that the fallocate call can zero
> out the pages that are sitting in the pipe buffer, before those pages are
> read from the pipe.
> 
> Simplified code excerpt (eliding error checking):
> 
> int fd = /* open file descriptor referring to some disk file */;
> for (off_t consumed = 0;;) {
>   ssize_t n = splice(fd, NULL, STDOUT_FILENO, NULL, SIZE_MAX, 0);
>   if (n <= 0) break;
>   consumed += n;
>   fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, consumed);
> }

Huh. Never seen that pattern before - what are you trying to
implement with this?

> Expected behavior:
> Punching holes in a file after splicing pages out of that file into a pipe
> should not corrupt the spliced-out pages in the pipe buffer.

splice is a nasty, tricky beast that should never have been
inflicted on the world...

> Observed behavior:
> Some of the pages that have been spliced into the pipe get zeroed out by the
> subsequent fallocate call before they can be consumed from the read side of
> the pipe.

Which implies the splice is not copying the page cache pages but
simply taking a reference to them.

> 
> 
> Steps to reproduce:
> 
> 1. Save the attached ones.c, dontneed.c, and consume.c.
> 
> 2. gcc -o ones ones.c
>   gcc -o dontneed dontneed.c
>   gcc -o consume consume.c
> 
> 3. Fill a file with 32 MiB of 0xFF:
>   ./ones | head -c$((1<<25)) >testfile
>
> 4. Evict the pages of the file from the page cache:
>   sync testfile && ./dontneed testfile

To save everyone some time, this one liner:

# xfs_io -ft -c "pwrite -S 0xff 0 32M" -c fsync -c "fadvise -d 0 32M" testfile

Does the same thing as steps 3 and 4. I also reproduced it with much
smaller files - 1MB is large enough to see multiple corruption
events every time I've run it.

> 5. Splice the file into a pipe, punching out batches of pages after splicing
> them:
>   ./consume testfile | hexdump -C
> 
> The expected output from hexdump should show 32 MiB of 0xFF. Indeed, on my
> system, if I omit the POSIX_FADV_DONTNEED advice, then I do get the expected
> output. However, if the pages of the file are not already present in the
> page cache (i.e., if the splice call faults them in from disk), then the
> hexdump output shows some pages full of 0xFF and some pages full of 0x00.

Like so:

00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
01b0a000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
01b10000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
01b12000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
01b18000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
01b19000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
01b20000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
01b22000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
01b24000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
01b25000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
01b28000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
01b29000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
01b2c000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

Hmmm. the corruption, more often than not, starts on a high-order
aligned file offset. Tracing indicates data is being populated in
the page cache by readahead, which would be using high-order folios
in XFS.

All the splice operations are return byte counts that are 4kB
aligned, so punch is doing filesystem block aligned punches. The
extent freeing traces indicate the filesystem is removing exactly
the right ranges from the file, and so the page cache invalidation
calls it is doing are also going to be for the correct ranges.

This smells of a partial high-order folio invalidation problem,
or at least a problem with splice working on pages rather than
folios the two not being properly coherent as a result of partial
folio invalidation.

To confirm, I removed all the mapping_set_large_folios() calls in
XFS, and the data corruption goes away. Hence, at minimum, large
folios look like a trigger for the problem.

Willy, over to you.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
