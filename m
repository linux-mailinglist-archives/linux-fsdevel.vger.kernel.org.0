Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB4173AEA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 04:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFWCcz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 22:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjFWCcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:32:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B829B2136
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 19:32:52 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-196.bstnma.fios.verizon.net [173.48.111.196])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35N2WXDD008707
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 22:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687487555; bh=I+VMhLMXxWq6sRcX/DfOebgIsflCUWXieno3lSi5mbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hlkYQZ63iYW+xAKCWi4QfD6c1RID7JUVQDmFIrIUBH8pbreSMvaYcCD9XSfZSAZAJ
         wlV8qBJjxkEFyOinq3d987Ix8tbRKPFNmoqYOBIBSD1ejkb5dkYy59LVbl615k2Hw5
         R3dYPdMA1S7z0yVbTobpUMMlloI2ckJwjFCjR37pAS6/Y9Bq3LmuCjfosaXEglKngx
         8FVNNg5mWLbyYP9g44Jxxb9G8rzuPebXCD4b8GwX+kltNSscLZ+V1QnarltcWfbkrC
         ae+QRfpNj3JVWCKJRLXI2rIRyzGm98sALsCuX9KGmOzGSGZbwqe5nmUpL3Ad+vda/F
         t9esX0ssgGa3A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5DBF715C027E; Thu, 22 Jun 2023 22:32:33 -0400 (EDT)
Date:   Thu, 22 Jun 2023 22:32:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeremy Bongio <bongiojp@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/1] iomap regression for aio dio 4k writes
Message-ID: <20230623023233.GC34229@mit.edu>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
 <ZJOO4SobNFaQ+C5g@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJOO4SobNFaQ+C5g@dread.disaster.area>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 09:59:29AM +1000, Dave Chinner wrote:
> Ah, you are testing pure overwrites, which means for ext4 the only
> thing it needs to care about is cached mappings. What happens when
> you add O_DSYNC here?

I think you mean O_SYNC, right?  In a pure overwrite case, where all
of the extents are initialized and where the Oracle or DB2 server is
doing writes to preallocated, pre-initialized space in the tablespace
file followed by fdatasync(), there *are* no post-I/O data integrity
operations which are required.

If the file is opened O_SYNC or if the blocks were not preallocated
using fallocate(2) and not initialized ahead of time, then sure, we
can't use this optimization.

However, the cases where databases workloads *are* doing overwrites
and using fdatasync(2) most certainly do exist, and the benefit of
this optimization can be a 20% throughput.  Which is nothing to sneeze
at.

What we might to do is to let the file system tell the iomap layer via
a flag whether or not there are no post-I/O metadata operations
required, and then *if* that flag is set, and *if* the inode has no
pages in the page cache (so there are no invalidate operations
necessary), it should be safe to skip using queue_work().  That way,
the file system has to affirmatively state that it is safe to skip the
workqueue, so it shouldn't do any harm to other file systems using the
iomap DIO layer.

What am I missing?

Cheers,

						- Ted
