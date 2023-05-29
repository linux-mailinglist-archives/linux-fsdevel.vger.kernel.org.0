Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97944715021
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 21:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjE2T7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 15:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2T7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 15:59:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F770B7;
        Mon, 29 May 2023 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ig/CoxYXOH5AerUAGPj4vxhU49vpr7Ly8vfvJTkUBPY=; b=A6EyJNexFZu7hfFH516ye7zTW7
        wLWN5KXhlAxMD1xGtYJSVqQryjiyjm5rY3FFjIStQ93+KFvyxgZh9+02tUsRm1tlV+9LOutprbtbU
        7gjGRbVCeMZLYOBubQ2GoPXl4edJzLkOlMriRiD3BqU2GOON5mCOSTHEv/IDuN6S3xE3u+BD1Td7j
        /06UVh9M/EB0aCSQV+f3M4JlnEu5t5JvaAnJuHXb1x/ICNuAxWYXEfYuDKQ/87y0MDqyatB+DrsuQ
        aHziY+6sQIjSFgWkvJJoYxzAV9Ajt5EDVh9+rIokb5z1xWa3WccfxNXXrVAJSi2RD/lmc229li9N2
        gXHaJxhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3j1b-005fXY-Sx; Mon, 29 May 2023 19:59:28 +0000
Date:   Mon, 29 May 2023 20:59:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Splitting dirty fs folios
Message-ID: <ZHUEH849ff09pVpf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At the moment, when we truncate (also holepunch, etc) a file,
the VFS attempts to split any large folios which overlap the newly
created boundary in the file.  See mm/truncate.c for the callers of
->invalidate_folio.

We need the filesystem and the MM to cooperate on splitting a folio
because there's FS metadata attached to folio->private.  We have per-folio
state (uptodate, dirty) which the filesystem keeps per-block state for
and uses the folio state as a summary (if every block is uptodate,
the folio is uptodate.  if any block is dirty, the folio is dirty).
If we just throw away that per-folio extra state we risk not writing
back blocks which are dirty, or losing buffered writes as we re-read
blocks which were more uptodate in memory than on disk.  There's no
safe state to set the folio to.

This is fine if the entire folio is uptodate, and it generally is today
because large folios are only created through readahead, which will
bring the entire folio uptodate unless there is a read error.  But when
creating a large folio in the write path, we can end up with large folios
which are not uptodate under various circumstances.  For example, I've
captured one where we write to pos:0x2a0e5f len:0xf1a1.  Because this is
on a 1kB block size filesystem, we leave the first three blocks in the folio
unread, and the uptodate bits are fffffffffffffff8.  That means that
the folio as a whole is not uptodate.

Option 1: Read the start of the folio so we can set the whole folio
uptodate.  In this case, we're already submitting a read for bytes
0x2a0c00-0x2a0fff (so we can overwrite the end of that block).  We could
expand that to read 0x2a0000-0x2a0fff instead.  This could get tricky;
at the moment we're guaranteed to have the iomap that covers the start
of the block, but we might have to do a lookup to find the iomap(s)
that covers the start of the folio.

Option 2: In the invalidate_folio implementation, writeback the folio
so it is no longer dirty.  I'm not sure we have all the information we
need to start writeback, and it'll annoy the filesystem as it has to
allocate space if it wasn't already allocated.

Option 3: Figure out a more complicated dance between the FS and the MM
that allows the FS to attach state to the newly created folios before
finally freeing the original folio.

Option 4: Stop splitting folios on holepunch / truncate.  Folio splits
can fail, so we all have to cope with folios that substantially overhang
a hole/data/EOF boundary.  We don't attempt to split folios on readahead
when we discover we're trying to read from a hole, we just zero the
appropriate chuks of the folio.  We do attempt to not allocate folios
which extend more than one page past EOF, but that's subject to change
anyway.

Option 5: If the folio is both dirty and !uptodate, just refuse to split
it, like if somebody else had a reference on it.  A less extreme version
of #4.

I may have missed some other option.  Option 5 seems like the least
amount of work.
