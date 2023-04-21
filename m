Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43C16EA910
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 13:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjDULXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjDULX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:23:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB19ECF;
        Fri, 21 Apr 2023 04:23:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8771F219BB;
        Fri, 21 Apr 2023 11:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682076205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mhMuSBytC1u79ds/SRzprRtVZibTN/coJdP50HWJQVo=;
        b=GVt4IME2mo9Rn4w1GWHik6DM02ADjg6XAFt4RW7L6yVZBB772fan2FnrciUzGvPSk6towk
        8b/OLGsG63Yy50neQpDB/KxWkMvZlZhtHug5rU7SbiHSjOR4XO9LK2bDyiOvk5cPDil8xU
        +K4JsRm3j8lctLd6nUtQEV6L2KLlnV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682076205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mhMuSBytC1u79ds/SRzprRtVZibTN/coJdP50HWJQVo=;
        b=e1TsdJbyCcrdCPwjbIAZzpkG5dW4wRaIAR2qIDtlEfKs3FGOQpGMV10uHXcV5hN5N4JESb
        vCchfDjc3Np77fCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CDD813456;
        Fri, 21 Apr 2023 11:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PZyCGi1yQmQSEQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 11:23:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 00A0BA0729; Fri, 21 Apr 2023 13:23:24 +0200 (CEST)
Date:   Fri, 21 Apr 2023 13:23:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCHv6 0/9] ext2: DIO to use iomap
Message-ID: <20230421112324.mxrrja2hynshu4b6@quack3>
References: <cover.1682069716.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682069716.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ritesh,

On Fri 21-04-23 15:16:10, Ritesh Harjani (IBM) wrote:
> Hello All,
> 
> Please find the series which rewrites ext2 direct-io path to use modern
> iomap interface.

The patches now all look good to me. I'd like to discuss a bit how to merge
them. The series has an ext4 cleanup (patch 3) and three iomap patches
(patches 6, 8 and 9). Darrick, do you want to take the iomap patches through
your tree?

The only dependency is that patch 7 for ext2 is dependent on definitions
from patch 6 so I'd have to pull your branch into my tree. Or I can take
all the iomap patches through my tree but for that it would be nice to have
Darrick's acks.

I can take the ext4 patch through my tree unless Ted objects.

I guess I won't rush this for the coming merge window (unless Linus decides
to do rc8) but once we settle on the merge strategy I'll push out some
branch on which we can base further ext2 iomap conversion work.

								Honza

> PATCHv5 -> PATCHv6:
> ===================
> 1. Patch-2 Added generic_buffers_fsync_noflush() & generic_buffers_fsync() functions.
> 2. Patch-3 & Patch-4 to use above functions in ext4 & ext2.
> 3. Added Reviewed-by from Christoph on Patch-9 (iomap: Add DIO tracepoints)
> 
> RFCv4 -> PATCHv5:
> =================
> 1. Added trace_iomap_dio_rw_begin tracepoint in __iomap_dio_rw()
> 2. Added Reviewed-by tags from Christoph
> 
> RFCv3 -> RFCV4:
> ===============
> 1. Renamed __generic_file_fsync_nolock() from libfs to generic_buffer_fsync() in
>    fs/buffer.c
>    (Review comment from Christoph)
> 2. Fixed s/EVENTD/EVENTFD/ in TRACE_IOCB_STRINGS
> 3. Fixed few data types for parameters in ext2 trace patch (size_t && ssize_t)
> 4. Killed this patch "Minor refactor of iomap_dio_rw"
> 5. Changed iomap tracepoint patch and fixed the data types (size_t && ssize_t)
>    (addressed review comments from Christoph)
> 
> RFCv2 -> RFCv3:
> ===============
> 1. Addressed minor review comments related to extern, parameter naming in
>    function declaration, removing not required braces and shorting overly long
>    lines.
> 2. Added Reviewed-by from various reviewers.
> 3. Fixed a warning & couple of compilation errors in Patch-7 (ext2 trace points)
>    related to CFLAGS_trace & second related to unable to find function
>    definition for iov_iter_count(). (requires uio.h file)
>    CFLAGS_trace is required in Makefile so that it can find trace.h file from
>    tracepoint infrastructure.
> 4. Changed naming of IOCB_STRINGS TO TRACE_IOCB_STRINGS.
> 5. Shortened naming of tracepoint events for ext2 dio.
> 6. Added iomap DIO tracepoint events.
> 7. Disha tested this series internally against Power with "auto" group for 4k
>    and 64k blocksize configuration. Added her "Tested-by" tag in all DIO
>    related patches. No new failures were reported.
> 
> Thanks everyone for the review and test. The series is looking good to me now.
> It has been tested on x86 and Power with different configurations.
> Please let me know if anything else is required on this.
> 
> v2: https://lore.kernel.org/all/ZDTybcM4kjYLSrGI@infradead.org/
> 
> Ritesh Harjani (IBM) (9):
>   ext2/dax: Fix ext2_setsize when len is page aligned
>   fs/buffer.c: Add generic_buffers_fsync*() implementation
>   ext4: Use generic_buffers_fsync_noflush() implementation
>   ext2: Use generic_buffers_fsync() implementation
>   ext2: Move direct-io to use iomap
>   fs.h: Add TRACE_IOCB_STRINGS for use in trace points
>   ext2: Add direct-io trace points
>   iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
>   iomap: Add DIO tracepoints
> 
>  fs/buffer.c                 |  70 ++++++++++++++++++++
>  fs/ext2/Makefile            |   5 +-
>  fs/ext2/ext2.h              |   1 +
>  fs/ext2/file.c              | 126 +++++++++++++++++++++++++++++++++++-
>  fs/ext2/inode.c             |  58 ++++++++++-------
>  fs/ext2/trace.c             |   6 ++
>  fs/ext2/trace.h             |  94 +++++++++++++++++++++++++++
>  fs/ext4/fsync.c             |  33 +++++-----
>  fs/iomap/direct-io.c        |   9 ++-
>  fs/iomap/trace.c            |   1 +
>  fs/iomap/trace.h            |  78 ++++++++++++++++++++++
>  include/linux/buffer_head.h |   4 ++
>  include/linux/fs.h          |  14 ++++
>  include/linux/iomap.h       |   6 --
>  14 files changed, 456 insertions(+), 49 deletions(-)
>  create mode 100644 fs/ext2/trace.c
>  create mode 100644 fs/ext2/trace.h
> 
> --
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
