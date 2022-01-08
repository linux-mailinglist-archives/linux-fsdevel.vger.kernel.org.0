Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86CC488643
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 22:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiAHVZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 16:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiAHVZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 16:25:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02951C06173F
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jan 2022 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qtbjPWoztzRYckFEmxn4kNr+GnVFDsIhl8E7nBMnnZc=; b=Q+JRI5KcsvIg/r4UNzNUUAq2UX
        n/PCj9vkrq3DgQid4p9gILq+UdSepwtB/RiVYGzqI4hmNfNVqyCRqroPq7g8Y7JwiyR/uGD9yiEXR
        NjxeDUNLEwiirCl+mHO/USuUfeFJmAbYNjllk6mYaenxHhBvgRgPLuN9uU83h1ZHAMmaB7hD6zCOM
        z8ui/rjmtnP4UbeZEADe3d0tNSyyK3QInDqANXGs5XZtXXSWYWNppXVwpsp90YkytPxnxxsFi+/NR
        LOnzK209io4T9e6Jbs8qMSjLbuD6Nwh6S0li7DOnTwpRLZHf3wh7QeTfJUcvzuD7d8eqZspAFPj0E
        eLyoCFrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6JDZ-000vIj-1e; Sat, 08 Jan 2022 21:25:41 +0000
Date:   Sat, 8 Jan 2022 21:25:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 2/3] shmem: Fix data loss when folio truncated
Message-ID: <YdoBVXifWo8/Oxie@casper.infradead.org>
References: <24d53dac-d58d-6bb9-82af-c472922e4a31@google.com>
 <Ydhh39A92g7Xe1df@casper.infradead.org>
 <54faec38-f3f9-a326-65e2-cba91a40ccca@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54faec38-f3f9-a326-65e2-cba91a40ccca@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 08, 2022 at 09:12:08AM -0800, Hugh Dickins wrote:
> On Fri, 7 Jan 2022, Matthew Wilcox wrote:
> > On Sun, Jan 02, 2022 at 05:34:05PM -0800, Hugh Dickins wrote:
> > > xfstests generic 098 214 263 286 412 used to pass on huge tmpfs (well,
> > > three of those _require_odirect, enabled by a shmem_direct_IO() stub),
> > > but still fail even with the partial_end fix.
> > > 
> > > generic/098 output mismatch shows actual data loss:
> > >     --- tests/generic/098.out
> > >     +++ /home/hughd/xfstests/results//generic/098.out.bad
> > >     @@ -4,9 +4,7 @@
> > >      wrote 32768/32768 bytes at offset 262144
> > >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >      File content after remount:
> > >     -0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > >     -*
> > >     -0400000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >     +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >     ...
> > 
> > generic/098 is passing for me ;-(  I'm using 'always' for THPs.
> > I'll have to try harder.  Regardless, I think your fix is good ...
> 
> Worrying that the test behaves differently.  Your 'always':
> you have '-o huge=always' in the exported TMPFS_MOUNT_OPTIONS?
> That should be enough, but I admit to belt and braces by also
> echo force > /sys/kernel/mm/transparent_hugepage/shmem_enabled

Ah, I hadn't done TMPFS_MOUNT_OPTIONS, just the
    echo always >/sys/kernel/mm/transparent_hugepage/shmem_enabled

Adding TMPFS_MOUNT_OPTIONS and retrying with what I originally posted
reproduces the bug.  Retrying with the current for-next branch doesn't.
So now I can confirm that there was a bug and your patch fixed it.
And maybe I can avoid introducing more bugs of this nature in the future.
