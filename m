Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4289F6E3CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 00:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjDPW5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 18:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDPW5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 18:57:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9892107
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 15:57:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso11650576pjb.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1681685828; x=1684277828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMp1HyUScPg9e5OjsE4H6AdsNng50u3kqrZV1kuxuXY=;
        b=aWAQXAI9lxWv380udXWiLplIbESigoZmgz5Gqm6HavbkFKoBlJM66dHBSEjSToJnRB
         nLfOLF+fS2g2dP6yAYlwvMbVi80maMmppQRvL9saTtzYigfWsuwwLfN5O65SaQMEHlUI
         d8dXpm2t8cLJBH7LohZDGTWK5SKv63WOFtxqueATaJilVY5r/YD7lmqYekI++v7K447v
         3TrB9bIQotwg6Vhu33b6vw2xVVj07cidQLaoPkYbwMEEfqfoTv7MquM8tBQWNX/I8ji9
         68qEVPGaxt03CI922g4ijudSHm6H2D6qum03jU5GbT0x5qipr3qf3d7qu2zdzUgVRGCA
         aftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681685828; x=1684277828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMp1HyUScPg9e5OjsE4H6AdsNng50u3kqrZV1kuxuXY=;
        b=JLJ5wI3b7zk/3j0ykXMaSrAhOziUIGq3S3y2ni78i47yyUFX7A7kDGyqThu805Oa8E
         NPXvPfhCTALn4abBHMhUup3ua05xZmTVCIFCCMbXOps+6S1lKgUQWSEMoCORHlKk5BG7
         WC1RBA8WYksflxjv45yubBIOe6yW7ydQtc2T6zvG361zgljdlHxLNm1rrEjl/7sR7xRU
         L+Jk3peot7UYF4ufUDa3Oy9KxxtIJdhaleWxBHPUuQRwbJIr4TAgl3/XvDRl6xsF2FBz
         KPHTfSVe0XDEv5Wj+CZppb3zhBT5DJuKIEXY5fV1zXQAZrn7ACOLKjEGmthG6bzZSqQ9
         ngHw==
X-Gm-Message-State: AAQBX9fkDWQW7jp3STRyYPxGJgj6Ydhc3noIMJwB8Evtsc9qoj34bXJa
        ZZWd/y+dDqODhIBTftAmY50tLQ==
X-Google-Smtp-Source: AKy350ZeudXCuZi7xXENjltppKRAfXMucBbiT6+WeYco4vnS98h1Dg3TdMh8eu8hcpWak3694GqwMg==
X-Received: by 2002:a17:902:f152:b0:1a1:ca37:525a with SMTP id d18-20020a170902f15200b001a1ca37525amr9361174plb.36.1681685828244;
        Sun, 16 Apr 2023 15:57:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902bc4500b001a1a82fc6d3sm6278141plz.268.2023.04.16.15.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 15:57:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1poBIu-004FMX-76; Mon, 17 Apr 2023 08:57:04 +1000
Date:   Mon, 17 Apr 2023 08:57:04 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "kbus @pop.gmail.com>> Keith Busch" <kbusch@kernel.org>,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <20230416225704.GC447837@dread.disaster.area>
References: <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDn3XPMA024t+C1x@bombadil.infradead.org>
 <ZDoMmtcwNTINAu3N@casper.infradead.org>
 <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
 <ZDodlnm2nvYxbvR4@casper.infradead.org>
 <31765c8c-e895-4207-2b8c-39f6c7c83ece@suse.de>
 <ZDraOHQHqeabyCvN@casper.infradead.org>
 <ZDtPK5Qdts19bKY2@bombadil.infradead.org>
 <ZDtuFux7FGlCMkC3@casper.infradead.org>
 <ZDuHEolre/saj8iZ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDuHEolre/saj8iZ@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 15, 2023 at 10:26:42PM -0700, Luis Chamberlain wrote:
> > > > Except ... we want to probe a dozen different
> > > > filesystems, and half of them keep their superblock at the same offset
> > > > from the start of the block device.  So we do want to keep it cached.
> > > > That's arguing for using the page cache, at least to read it.
> > > 
> > > Do we currently share anything from the bdev cache with the fs for this?
> > > Let's say that first block device blocksize in memory.
> > 
> > sb_bread() is used by most filesystems, and the buffer cache aliases
> > into the page cache.
> 
> I see thanks. I checked what xfs does and its xfs_readsb() uses its own
> xfs_buf_read_uncached(). It ends up calling xfs_buf_submit() and
> xfs_buf_ioapply_map() does it's own submit_bio(). So I'm curious why
> they did that.

XFS has it's own metadata address space for caching - it does not
use the block device page cache at all. This is not new, it never
has.

The xfs_buf buffer cache does not use the page cache, either. It
does it's own thing, has it's own indexing, locking, shrinkers, etc.
IOWs, it does not use the iomap infrastructure at all - iomap is
used by XFS exclusively for data IO.

As for why we use an uncached buffer for the superblock? That's
largely historic because prior to 2007 every modification that did
allocation/free needed to lock and modify the superblock at
transaction commit. Hence it's always needed in memory but a
critical fast path, so it is always directly available without
needing to do a cache lookup to callers that need it.

In 2007, lazy superblock counters got rid of the requirement to lock
the superblock buffer in every transaction commit, so the uncached
buffer optimisation hasn't really been needed for the past decade.
But if it ain't broke, don't try to fix it....

> > > > Now, do we want userspace to be able to dd a new superblock into place
> > > > and have the mounted filesystem see it? 
> > > 
> > > Not sure I follow this. dd a new super block?
> > 
> > In userspace, if I run 'dd if=blah of=/dev/sda1 bs=512 count=1 seek=N',
> > I can overwrite the superblock.  Do we want filesystems to see that
> > kind of vandalism, or do we want the mounted filesystem to have its
> > own copy of the data and overwrite what userspace wrote the next time it
> > updates the superblock?
> 
> Oh, what happens today?

In XFS, it will completely ignore the fact the the superblock got
trashed like this. When the fs goes idle, or the sb modified for
some other reason, it will relog the in-memory superblock and write
it back to disk, thereby fixing the corruption. i.e. while the
filesystem is mounted, the superblock is _write-only_...

> > (the trick is that this may not be vandalism, it might be the sysadmin
> > updating the uuid or running some fsck-ish program or trying to update
> > the superblock to support fabulous-new-feature on next mount.  does this
> > change the answer?)

If you need to change anything in the superblock while the XFS fs is
mounted, then you have to use ioctls to modify the superblock
contents through the running transaction subsystem. Editting the
block device directly breaks the security model of filesystems that
assume they have exclusive access to the block device whilst the
filesystem is mounted....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
