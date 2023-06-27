Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE3773FA41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 12:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjF0KcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 06:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjF0KcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:32:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56793D9
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=thTh8k4/mcKzoxX44o19N0SQwKd7WnV+4mdkc5ITV+w=; b=dO8s6tZIXPcMld7kVtkGKbfyVs
        rgE/NWck+CtKZ/rDAZXcb8QExJHT/wxB6iRvqySR4bifoz5uG+3eHd+O+xGa4dAhU9pM3A6D2Ae3f
        507qrrNcgNy/eq7t1K16DRb0EGDAuybS2auPanIfABDN2YlzeeayF4oNy3QlKNVYV4WRuGkGINbKQ
        dIMbj9otEyopOFvONfPqkThGn8+M/xtLL5Ge4W9xiKS/z6q+cHT9XX5k/8f08dWASGes0Vu/KbTBs
        o5RO2/XsJC8PDxVd15YhUPtvNnivfL40jAzGstoxqr6JQrTmeRoLVri5nF3UOymAoFLLgfO69a0AF
        N6HegyHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qE5zI-002csu-UQ; Tue, 27 Jun 2023 10:31:56 +0000
Date:   Tue, 27 Jun 2023 11:31:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matt Whitlock <kernel@mattwhitlock.name>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and
 FALLOC_FL_PUNCH_HOLE
Message-ID: <ZJq6nJBoX1m6Po9+@casper.infradead.org>
References: <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJp4Df8MnU8F3XAt@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Indeed.  I understand the problem, I just don't know if it's a bug.

> > Observed behavior:
> > Some of the pages that have been spliced into the pipe get zeroed out by the
> > subsequent fallocate call before they can be consumed from the read side of
> > the pipe.
> 
> Which implies the splice is not copying the page cache pages but
> simply taking a reference to them.

Yup.

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

If you do a PUNCH HOLE, documented behaviour is:

       Specifying the FALLOC_FL_PUNCH_HOLE flag (available since Linux 2.6.38)
       in mode deallocates space (i.e., creates a  hole)  in  the  byte  range
       starting  at offset and continuing for len bytes.  Within the specified
       range, partial filesystem  blocks  are  zeroed,  and  whole  filesystem
       blocks  are removed from the file.  After a successful call, subsequent
       reads from this range will return zeros.

So we have, let's say, an order-4 folio and the user tries to PUNCH_HOLE
page 3 of it.  We try to split it, but that fails because the pipe holds
a reference.  The filesystem has removed the underlying data from the
storage medium.  What is the page cache to do?  It must memset() so that
subsequent reads return zeroes.  And now the page in the pipe has the
hole punched into it.

I think you can reproduce this problem without large folios by using a
512-byte block size filesystem and punching holes that are sub page
size.  The page cache must behave similarly.

Perhaps the problem is that splice() appears to copy, but really just
takes the reference.  Perhaps splice needs to actually copy if it
sees a multi-page folio and isn't going to take all of it.  I'm not
an expert in splice-ology, so let's cc some people who know more about
splice than I do.
