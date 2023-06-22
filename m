Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8B77394F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 03:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFVBz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 21:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjFVBz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:55:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF551738
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 18:55:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e3b15370so3871222b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687398927; x=1689990927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+ObdMW8OoUiyfLik8rkSqpBwoPFSpBmf3on8EgN4Qg=;
        b=YCL3h6qlwyBUoIzALg9lGVi/cVpj6iE3TExxFCOSFx/s0YoNabdJFVEqJ6e8mXUhy3
         78Dk5QxUhjJGSPliHQ6E1PECOUPmk45j3eDlkWIyciQPf8rMuGmGEys0ezqzfarCSTzS
         UQwnqHtfOxr/CX69CcdHVLjZJXBRBVMKPmnKaN8C6qHVBuyRQaJa84971xrRLA0KvXYT
         CxjHori3LWN0zB1DT3O8iNTObgy6Ho+j3cdK5nX3kzGZc0mikmflLk42ZWxwCVUgb2Nt
         /fmnwioLgl+dYRC6KsGEIDRmSWNBJHkgKyrB+6u6kNhTyWar+aKrfbYQO7+i4LzT0y1J
         /PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398927; x=1689990927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+ObdMW8OoUiyfLik8rkSqpBwoPFSpBmf3on8EgN4Qg=;
        b=gDp88ncHc1BS95JcyTvuXVqgrORHW80N5wvNvFbnLzLF+bjPZali2nxoUlqsNm4ZA8
         FfcQX6EWtnVFRzxfJeococB4K11Is01bR15PRki5J9z8oN+wKBqCW2RWdQnyHTqa6jYR
         1BADqKZ81tC6e4Yyt3iyOqhZaxPyqSmJ8wqYPOoqFMrlvn9IlnTnn7aJmwM91VAdcpf2
         E7rvGxyjA0ODjafKOwEUP1I/xjL69LCmjzbWEshY4a457FuuOmG3PAsAPM/SOzrpz3Iz
         4kELbeiGyqdusThSS2UMWCkTwnr4bUAWzEEa5ymJomrb01I/DHzNmejjw3r2uWMknYc2
         7fEA==
X-Gm-Message-State: AC+VfDx/9PrOcLuPVWsWyzROBQpwsSo8OABIEbEtsKuFZ68jhdSc1UL9
        AtIjsv6nQya+mkr6n9uSEkzhkA==
X-Google-Smtp-Source: ACHHUZ4HiKk1VLE3Wmy3vUtui6I6k3LDiDdDmYLqfv0n7WchOyoGpq0OFwfd1RFaCUn0V2ksYqma4A==
X-Received: by 2002:a05:6a00:2193:b0:668:852a:ffc4 with SMTP id h19-20020a056a00219300b00668852affc4mr8431093pfi.4.1687398926934;
        Wed, 21 Jun 2023 18:55:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id e20-20020a62ee14000000b0063b806b111csm3460107pfi.169.2023.06.21.18.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:55:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qC9Xf-00EffU-0i;
        Thu, 22 Jun 2023 11:55:23 +1000
Date:   Thu, 22 Jun 2023 11:55:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/1] iomap regression for aio dio 4k writes
Message-ID: <ZJOqC7Cfjr5AoW7S@dread.disaster.area>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
 <ZJOO4SobNFaQ+C5g@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJOO4SobNFaQ+C5g@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 09:59:30AM +1000, Dave Chinner wrote:
> On Wed, Jun 21, 2023 at 10:29:19AM -0700, Jeremy Bongio wrote:
> > Since no issues have been found for ext4 calling completion work
> > directly in the io handler pre-iomap, it is unlikely that this is
> > unsafe (sleeping within an io handler callback). However, this may not
> > be true for all filesystems. Does XFS potentially sleep in its
> > completion code?
> 
> Yes, and ext4 does too. e.g. O_DSYNC overwrites always need to be
> deferred to task context to be able to take sleeping locks and
> potentially block on journal and or device cache flushes.
> 
> i.e. Have you considered what context all of XFS, f2fs, btrfs,
> zonefs and gfs2 need for pure DIO overwrite completion in all it's
> different variants?
> 
> AFAIC, it's far simpler conceptually to defer all writes to
> completion context than it is to try to work out what writes need to
> be deferred and what doesn't, especially as the filesystem ->end_io
> completion might need to sleep and the iomap code has no idea
> whether that is possible.

Ok, so having spent a bit more thought on this away from the office
this morning, I think there is a generic way we can avoid deferring
completions for pure overwrites.

We already have a mechanism in iomap that tells us if the write is a
pure overwrite and we use it to change how we issue O_DSYNC DIO
writes. i.e. we use it to determine if we can use FUA writes rather
than a post-IO journal/device cache flush to guarantee data
integrity. See IOMAP_DIO_WRITE_FUA for how we determine whether we
need issue a generic_write_sync() call or not in the post IO
completion processing.

The iomap flags that determines if we can make this optimisation are
IOMAP_F_SHARED and IOMAP_F_DIRTY. IOMAP_F_SHARED indicates a COW is
required to break sharing for the write IO to proceed, whilst
IOMAP_F_DIRTY indicates that the inode is either dirty or that the
write IO requires metadata to be dirtied at completion time (e.g.
unwritten extent conversion) before the sync operation that provides
data integrity guarantees can be run.

If neither of these flags are set in the iomap, it effectively means
that the IO is a pure overwrite. i.e. the filesytsem has explicitly
said that this write IO does not need any post-IO completion
filesystem work to be done.

At this point, the iomap code can optimise for a pure overwrite into
an IOMAP_MAPPED extent, knowing that the only thing it needs to care
about on completion is internal data integrity requirements (i.e.
O_DSYNC/O_SYNC) of the IO.

Hence if the filesystem has told iomap that it has no IO completion
requirements, and iomap doesn't need generic_write_sync() for data
integrity (i.e. no data integrity required or FUA was used for the
entire IO), then we could complete the DIO write directly from the
bio completion callback context...

IOWs, what you want can be done, it's just a whole lot more complex
than just avoiding a queue_work() call...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
