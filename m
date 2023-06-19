Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2253B735FF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 00:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFSW5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 18:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSW5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 18:57:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B14E58
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 15:57:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666eb03457cso1398345b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 15:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687215472; x=1689807472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjXwtZnJw92XR661FFt1WCJs9pFxmVufx8xRZE1MlmA=;
        b=fovhd81vHX+kdEyYuyB+Zfu4MO9kROfPT54Lgr7qb8ZoefAX06xHlEhWuKLNw0GIbD
         oefMv1glR3njUPLJ2AAsUYZMVSYhiBoj8l7BlJXJDpoNtSULk+eJ/qqtVxopuZH+Ud8u
         4fYpZ1tny/cL+uoxRNXmagyo10ZukGRtywD+alN5avXBzae58IPKZf01g/CcAQ5+Az4v
         BTLFWAPJ0XnGhQQGQimHCP1iS9J2k+HtXO9HTAyw826Dkshs45DjB25n3EHWEbK00Xdu
         AnAFC1fFjv38EMT/MbCndQR72fJ6dGdN9CVN7GAr1Vc8wYs/j8cMCI04/XGrAgcr15JT
         Lobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687215472; x=1689807472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjXwtZnJw92XR661FFt1WCJs9pFxmVufx8xRZE1MlmA=;
        b=hd71/3EJoUBCqSes6cK5sdSDbNOUfqy2OisHNQFX05oLyBpBPncSTMdTB3TdCc5h+U
         MzGK+Y/xId2FNB1RcST9VTwevxXPeAA70CtRsIOUm02862I//ZuWh8GA3JMb6ZECebN8
         1uRYyoL62F+oM1OMo2f+LVf0Lc33jkRmP20SJQGA7CGL397/i+bxx0ZE78WCYpnyknYy
         WqeDGDjhRs98XeQ0ib/vEq/k2JouNrcpcewAX9gE+a0Mz4S/Z+rQ6SS1YOtMMzU5zST+
         QB9WanTzB6Jz+lznOfx5Zidy0ivybJkLYzU+WuI+sEAEBf5MR0OwSWiLYAynA954VsK1
         V5oQ==
X-Gm-Message-State: AC+VfDwaLChX7j2SWh4238/Bm71LQbRgxFUOA4/5we+jzwzLDmuMgc64
        e/morZZ5sV1WHsKr4APgc5/BVg==
X-Google-Smtp-Source: ACHHUZ4mYODDAn40TIMpC6vCOTcHo8TSKgeWuTVjpTKBzCCzwdkWkEOFRRkg2SNGaBzU0dlGAN+qZQ==
X-Received: by 2002:a05:6a00:2406:b0:63d:260d:f9dd with SMTP id z6-20020a056a00240600b0063d260df9ddmr7109838pfh.33.1687215471663;
        Mon, 19 Jun 2023 15:57:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b00643355ff6a6sm155493pfn.99.2023.06.19.15.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:57:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qBNoi-00DpLn-0h;
        Tue, 20 Jun 2023 08:57:48 +1000
Date:   Tue, 20 Jun 2023 08:57:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>, gost.dev@samsung.com
Subject: Re: [PATCH 6/7] mm/filemap: allocate folios with mapping blocksize
Message-ID: <ZJDdbPwfXI6eR5vB@dread.disaster.area>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-7-hare@suse.de>
 <CGME20230619080901eucas1p224e67aa31866d2ad8d259b2209c2db67@eucas1p2.samsung.com>
 <20230619080857.qxx5c7uaz6pm4h3m@localhost>
 <b6d982ce-3e7e-e433-8339-28ec8474df03@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d982ce-3e7e-e433-8339-28ec8474df03@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 10:42:38AM +0200, Hannes Reinecke wrote:
> On 6/19/23 10:08, Pankaj Raghav wrote:
> > Hi Hannes,
> > On Wed, Jun 14, 2023 at 01:46:36PM +0200, Hannes Reinecke wrote:
> > > The mapping has an underlying blocksize (by virtue of
> > > mapping->host->i_blkbits), so if the mapping blocksize
> > > is larger than the pagesize we should allocate folios
> > > in the correct order.
> > > 
> > Network filesystems such as 9pfs set the blkbits to be maximum data it
> > wants to transfer leading to unnecessary memory pressure as we will try
> > to allocate higher order folios(Order 5 in my setup). Isn't it better
> > for each filesystem to request the minimum folio order it needs for its
> > page cache early on? Block devices can do the same for its block cache.

Folio size is not a "filesystem wide" thing - it's a per-inode
configuration. We can have inodes within a filesystem that have
different "block" sizes. A prime example of this is XFS directories
- they can have 64kB block sizes on 4kB block size filesystem.

Another example is extent size hints in XFS data files - they
trigger aligned allocation-around similar to using large folios in
the page cache for small writes. Effectively this gives data files a
"block size" of the extent size hint regardless of the filesystem
block size.

Hence in future we might want different sizes of folios for
different types of inodes and so whatever we do we need to support
per-inode folio size configuration for the inode mapping tree.

> > I have prototype along those lines and I will it soon. This is also
> > something willy indicated before in a mailing list conversation.
> > 
> Well; I _though_ that's why we had things like optimal I/O size and
> maximal I/O size. But this seem to be relegated to request queue limits,
> so I guess it's not available from 'struct block_device' or 'struct
> gendisk'.

Yes, those are block device constructs to enable block device based
filesystems to be laid out best for the given block device. They
don't exist for non-block-based filesystems like network
filesystems...

> So I've been thinking of adding a flag somewhere (possibly in
> 'struct address_space') to indicate that blkbits is a hard limit
> and not just an advisory thing.

This still relies on interpreting inode->i_blkbits repeatedly at
runtime in some way, in mm code that really has no business looking
at filesystem block sizes.

What is needed is a field into the mapping that defines the
folio order that all folios allocated for the page cache must be
aligned/sized to to allow them to be inserted into the mapping.

This means the minimum folio order and alignment is maintained
entirely by the mapping (e.g. it allows truncate to do the right
thing), and the filesystem/device side code does not need to do
anything special (except support large folios) to ensure that the
page cache always contains folios that are block sized and aligned.

We already have mapping_set_large_folios() that we use at
inode/mapping instantiation time to enable large folios in the page
cache for that mapping. What we need is a new
mapping_set_large_folio_order() API to enable the filesystem/device
to set the base folio order for the mapping tree at instantiation
time, and for all the page cache instantiation code to align/size to
the order stored in the mapping...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
