Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF91672AC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 22:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjARVnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 16:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjARVnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:43:25 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA88066EDC
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 13:42:27 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i65so41905pfc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25/ogZ1IY1yCzD+p9FJLZ5EqJq4IvrsYWI+uktJqoc8=;
        b=b6n2HzUq915R4Q52gekT31VCYQfhro59qvgUT/934MH4Ph5mOu/m74OMQPxPnVS/Jj
         udr4O/ozJG9Wr9xUuH2pWLtCd0DTUDFDxmD74lfUUGrbGuRaGcSnGoh0rNX1AC2NFXV6
         qMCOhTTi27jvwOqSTZhFFRHiEyeZfv1Z7SJm/zUnPYhEZFr3pUaYsE1UE9b+AyxmBdYe
         7NiRz5Hqjq2balCLmD9DyIqwhWgbKeB2es8kJ68QDAwvLHxSwwYUN+FimGMTNMO7OYv4
         LSx+3Sfiw6/J+ifh5//FHTHi/49BsvmL+hcFXy0sAcr90oEDNxS5oG5e41N6r7Nqtgwz
         BdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25/ogZ1IY1yCzD+p9FJLZ5EqJq4IvrsYWI+uktJqoc8=;
        b=f4BJq570us9wZhHdxUm7PoAwPFK1/23/9PvKL41+pkEDDY/0sEbcoEYXUW+LP++hGj
         GF0XXg0O8x8Jiaefv6HHiQvg+paTQ5WA8vFpgYIQHDJOo6e4moag43biu+qohFo1NvBx
         50dheiBcx6NJVZ9TTCTwOwYgOw8dA4lD1jsUSduWoaNdBlC9kwaTEDBt3otof/CAKQNc
         pjpas0HPMfWRvUg8UTP7cq2VJeq+BEOa1LgvX/rKNAP9Ac6hRt07uXFD/NR1GbYs2ybi
         Htx5Q7OrLBiVEGg+4f1u1p5pKU3QMFmbBOEglO8WRYVsLSPshCkGL3mrB7kAJNF6i/Kl
         KRNQ==
X-Gm-Message-State: AFqh2kpLaHie4oPwGajdf8eD5Z+fObI/BR/OlrgP7/DxhV+fq6+CRuU+
        EkvMJJy9U3bw8FToNxICDizjSg==
X-Google-Smtp-Source: AMrXdXuUhT365uogRqJeciSgZ6jusXovRP6UIOCn0m3CnHYkFzQba4SbhSlaI19LX086ihdE2UUqBA==
X-Received: by 2002:a05:6a00:4088:b0:58d:aadf:5e62 with SMTP id bw8-20020a056a00408800b0058daadf5e62mr9302248pfb.18.1674078147224;
        Wed, 18 Jan 2023 13:42:27 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id m2-20020a62a202000000b005869a33dd3bsm20734472pff.164.2023.01.18.13.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:42:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pIGCN-004hTW-Hg; Thu, 19 Jan 2023 08:42:23 +1100
Date:   Thu, 19 Jan 2023 08:42:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v6 08/10] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <20230118214223.GH360264@dread.disaster.area>
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-9-agruenba@redhat.com>
 <20230108215911.GP1971568@dread.disaster.area>
 <CAHc6FU4z1nC8zdM8NvUyMqU29_J7_oNu1pvBHuOvR+M6gq7F0Q@mail.gmail.com>
 <20230109225453.GQ1971568@dread.disaster.area>
 <CAHpGcM+urV5LYpTZQWTRoK6VWaLx0sxk3mDe_kd3VznMY9woVw@mail.gmail.com>
 <Y8Q4FmhYehpQPZ3Z@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Q4FmhYehpQPZ3Z@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 15, 2023 at 09:29:58AM -0800, Darrick J. Wong wrote:
> 2. Do we need to revalidate mappings for directio writes?  I think the
> answer is no (for xfs) because the ->iomap_begin call will allocate
> whatever blocks are needed and truncate/punch/reflink block on the
> iolock while the directio writes are pending, so you'll never end up
> with a stale mapping.  But I don't know if that statement applies
> generally...

The issue is not truncate/punch/reflink for either DIO or buffered
IO - the issue that leads to stale iomaps is async extent state.
i.e. IO completion doing unwritten extent conversion.

For DIO, AIO doesn't hold the IOLOCK at all when completion is run
(like buffered writeback), but non-AIO DIO writes hold the IOLOCK
shared while waiting for completion. This means that we can have DIO
submission and completion still running concurrently, and so stale
iomaps are a definite possibility.

From my notes when I looked at this:

1. the race condition for a DIO write mapping go stale is an
overlapping DIO completion and converting the block from unwritten
to written, and then the dio write incorrectly issuing sub-block
zeroing because the mapping is now stale.

2. DIO read into a hole or unwritten extent zeroes the entire range
in the user buffer in one operation. If this is a large range, this
could race with small DIO writes within that range that have
completed

3. There is a window between dio write completion doing unwritten
extent conversion (by ->end_io) and the page cache being
invalidated, providing a window where buffered read maps can be
stale and incorrect read behaviour exposed to userpace before
the page cache is invalidated.

These all stem from IO having overlapping ranges, which is largely
unsupported but can't be entirely prevented (e.g. backup
applications running in the background). Largely the problems are
confined to sub-block IOs. i.e.  when sub-block DIO writes to the
same block are being performed, we have the possiblity that one
write completes whilst the other is deciding what to zero, unaware
that the range is now MAPPED rather than UNWRITTEN.

We currently avoid issues with sub-block dio writes by using
IOMAP_DIO_OVERWRITE_ONLY with shared locking. This ensures that the
unaligned IO fits entirely within a MAPPED extent so no sub-block
zeroing is required. If allocation or sub-block zeroing is required,
then we force the filesystem to fall back to exclusive IO locking
and wait for all concurrent DIO in flight to complete so that it
can't race with any other DIO write that might cause the map to
become stale while we are doing the zeroing.

This does not avoid potential issues with DIO write vs buffered
read, nor DIO write vs mmap IO. It's not totally clear to me
whether we need ->iomap_valid checks in the buffered read paths
to avoid the completion races with DIO writes, but there are windows
there where cached iomaps could be considered stale....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
