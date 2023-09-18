Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC57A3F0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 03:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjIRA7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 20:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjIRA7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 20:59:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950E110C
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 17:59:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c44a25bd0bso11356525ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 17:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694998751; x=1695603551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qm4Qos5mQOezOnQCScED3Zy6FW2h/SfYALWyPREfknI=;
        b=b1foU04pYk5sX+iPRkaj5+ZHqKBGukyIiJy7U1B0Wxr3qHXCBv49AVHxhYvsrx7xEM
         ZFBYyIc1udBUcYDYVuo3Eu8fWQrYU1h+SB5ZuQF0Q6rgtLEmu8JiuU4rQp201at1eru2
         iZW9wz3/P6Z898LsOjffyZ5LJavlY+cxI5ozLiJcfrsrDNEgHwBOFE8yP2JEaWlLxshd
         9mknEcMk/KxufpFuMN+mQkvXoQySX4g1VRvn1HEbJ3Wl7InuelTA7MQ4fzgmOiLO0kfw
         83nJlMMh4sYQ1SZQA5mdn6XF5fGg+/aMrSoYGLrsGn4E0oagCyV/x1y8Y8LIcICXIf2V
         dB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694998751; x=1695603551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm4Qos5mQOezOnQCScED3Zy6FW2h/SfYALWyPREfknI=;
        b=vDpFBYrf+jkh5bNXnVe8HhVI4f5kQo85QaQlvRvM+R8dVAJH8e9v0rP/QVHrNiGMCS
         Y1KBT82c3rp+kZaFYtuk/T5m2wQ3ruzAuPKZ81XX4+KsCxdxqnKUdMIy0ETbKZHtn6z1
         F2qR0o/+3tctnq9uzRWEpN571K6ArfzLelzeim/EeC7H3WtH87+pk+HiAlhUhED6UvCJ
         e4NtYS2nUsIbpjPIcH6azWPgg48w/Qpy3y2J3XEFwzJQzJoYAqmfBx8UizxWT1oFr0Rz
         T0icNOx7/xmjRQs/I6p7oRcZKWSM3XDuzTYDrT+3zjxdZWxbPGpFFISOcG8akpgWSmvh
         ZPvw==
X-Gm-Message-State: AOJu0YyyF5MAeWPfvRD/UxqGM2Hs/5EIJcurgJPTZN7BmtbBKcbOfv6t
        AAqcJZWGA4czkEjeROCXyFBJ0w==
X-Google-Smtp-Source: AGHT+IHX4V79CdX85ezWirEQ7CIH5inrn7qIR8qQTaeGk8r5UhpcT2m4AfVt6ErvhHF9G1V1eunp2w==
X-Received: by 2002:a17:902:e5cd:b0:1c4:5a9:a45e with SMTP id u13-20020a170902e5cd00b001c405a9a45emr10620570plf.27.1694998751014;
        Sun, 17 Sep 2023 17:59:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c14200b001b672af624esm1578859plj.164.2023.09.17.17.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 17:59:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qi2bT-0028nc-1y;
        Mon, 18 Sep 2023 10:59:07 +1000
Date:   Mon, 18 Sep 2023 10:59:07 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        djwong@kernel.org, dchinner@redhat.com, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, brauner@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com
Subject: Re: [RFC v2 00/10] bdev: LBS devices support to coexist with
 buffer-heads
Message-ID: <ZQeg2+0X6yzGL1Mx@dread.disaster.area>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
 <ZQd/7RYfDZgvR0n2@dread.disaster.area>
 <ZQeIaN2WC+whc/OP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQeIaN2WC+whc/OP@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 12:14:48AM +0100, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 08:38:37AM +1000, Dave Chinner wrote:
> > On Fri, Sep 15, 2023 at 02:32:44PM -0700, Luis Chamberlain wrote:
> > > LBS devices. This in turn allows filesystems which support bs > 4k to be
> > > enabled on a 4k PAGE_SIZE world on LBS block devices. This alows LBS
> > > device then to take advantage of the recenlty posted work today to enable
> > > LBS support for filesystems [0].
> > 
> > Why do we need LBS devices to support bs > ps in XFS?
> 
> It's the other way round -- we need the support in the page cache to
> reject sub-block-size folios (which is in the other patches) before we
> can sensibly talk about enabling any filesystems on top of LBS devices.
>
> Even XFS, or for that matter ext2 which support 16k block sizes on
> CONFIG_PAGE_SIZE_16K (or 64K) kernels need that support first.

Well, yes, I know that. But the statement above implies that we
can't use bs > ps filesytems without LBS support on 4kB PAGE_SIZE
systems. If it's meant to mean the exact opposite, then it is
extremely poorly worded....

> > > There might be a better way to do this than do deal with the switching
> > > of the aops dynamically, ideas welcomed!
> > 
> > Is it even safe to switch aops dynamically? We know there are
> > inherent race conditions in doing this w.r.t. mmap and page faults,
> > as the write fault part of the processing is directly dependent
> > on the page being correctly initialised during the initial
> > population of the page data (the "read fault" side of the write
> > fault).
> > 
> > Hence it's not generally considered safe to change aops from one
> > mechanism to another dynamically. Block devices can be mmap()d, but
> > I don't see anything in this patch set that ensures there are no
> > other users of the block device when the swaps are done. What am I
> > missing?
> 
> We need to evict all pages from the page cache before switching aops to
> prevent misinterpretation of folio->private. 

Yes, but if the device is mapped, even after an invalidation, we can
still race with a new fault instantiating a page whilst the aops are
being swapped, right? That was the problem that sunk dynamic
swapping of the aops when turning DAX on and off on an inode, right?

> If switching aops is even
> the right thing to do.  I don't see the problem with allowing buffer heads
> on block devices, but I haven't been involved with the discussion here.

iomap supports bufferheads as a transitional thing (e.g. for gfs2).

Hence I suspect that a better solution is to always use iomap and
the same aops, but just switch from iomap page state to buffer heads
in the bdev mapping interface via a synchronised invalidation +
setting/clearing IOMAP_F_BUFFER_HEAD in all new mapping requests...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
