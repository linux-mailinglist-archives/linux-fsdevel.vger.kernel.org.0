Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3964BE9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 22:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiLMVkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 16:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiLMVkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:40:52 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC005183B4
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 13:40:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jn7so1227678plb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WWOreJPQx5jt0V0oltby0KYxV6q8nWo5V1Bt/xC127M=;
        b=l3oX1rtw3raFFroaEmbpolXxzpo6JcgJ+bqOf4pLeQUW6ghXrUi6UOP3xpqruOc1jB
         bxr8dPt5qlTyWJ65qDnuHC3ULzcGuFq6yfcASRBD9z1O9NH4HCKvXJNQOiBbr28YysAm
         vj8Hh54+a3/bpvZWE2zJm/y0agfbWTUPz280CRQJvLeIzmJDnbyydP7pFOI7Z4yzDlkB
         F02q53UrxzdNkqr+PggEZFsLTnq3WwKrcnnGgsg+GPxxb5JIVSIMuFe0VXR/6N+2CKMv
         Q+GTi8P9lBdE8FXXCqNeiZdo1N4itQwZo4fu4dxCQXnc6webZXclbTf2bbTUl2cfwrPm
         Z5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWOreJPQx5jt0V0oltby0KYxV6q8nWo5V1Bt/xC127M=;
        b=4bJJm4k7uIuCgqdJCEclLNs4zSPmCYQKlDNh0hTD3N3LSj6dQIWRuxHaKyZ0La7EUi
         n1b6FQ0Pd/X/dByl4H5LQfJA/vXI+DjZkq9LdWGjRfPpRlM3v13gJJNat9TQl0/nwcHE
         07gwTO3qJyab3EwtJPT+x+0jyMMz0qgGek2yHwtjhVq5xaITsozhvrq/D7MHEf5fgmvv
         kFz+8ykb60D459AMIgM26ExOegT04aCMLbbSrMN7U3D886eeB+rzAyBD29ohGnQBdKpd
         QpdIq6etIdEgaxIHsAf7a77I6oCWQ7frShbngEDpZRKWbs/98Tz90Ro2NKDh7KF2de35
         3Xyg==
X-Gm-Message-State: ANoB5pl41mrJHCtCj1H2e2l/14pSEaPYoLuEbet45C2beJM5kdJiQJ/d
        WIbh8Oupe+VUXMaMIoGS+FeoDg==
X-Google-Smtp-Source: AA0mqf7nRdA9TjhwgmnelX9M4i3O367M3cDxRaiadXWXydAbqGuTYmSxzPwDrYF+IQtJE9Lx+ax+QQ==
X-Received: by 2002:a17:902:f2ca:b0:189:ac49:fe9d with SMTP id h10-20020a170902f2ca00b00189ac49fe9dmr20556259plc.19.1670967651169;
        Tue, 13 Dec 2022 13:40:51 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b001869581f7ecsm362068ple.116.2022.12.13.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 13:40:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5D15-00867t-Rw; Wed, 14 Dec 2022 08:40:47 +1100
Date:   Wed, 14 Dec 2022 08:40:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] xfs: add fs-verity support
Message-ID: <20221213214047.GY3600936@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-11-aalbersh@redhat.com>
 <Y5jNvXbW1cXGRPk2@sol.localdomain>
 <20221213203319.GV3600936@dread.disaster.area>
 <Y5jjC5kcF4kCiwNB@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jjC5kcF4kCiwNB@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:39:39PM -0800, Eric Biggers wrote:
> On Wed, Dec 14, 2022 at 07:33:19AM +1100, Dave Chinner wrote:
> > On Tue, Dec 13, 2022 at 11:08:45AM -0800, Eric Biggers wrote:
> > > On Tue, Dec 13, 2022 at 06:29:34PM +0100, Andrey Albershteyn wrote:
> > > > 
> > > > Also add check that block size == PAGE_SIZE as fs-verity doesn't
> > > > support different sizes yet.
> > > 
> > > That's coming with
> > > https://lore.kernel.org/linux-fsdevel/20221028224539.171818-1-ebiggers@kernel.org/T/#u,
> > > which I'll be resending soon and I hope to apply for 6.3.
> > > Review and testing of that patchset, along with its associated xfstests update
> > > (https://lore.kernel.org/fstests/20221211070704.341481-1-ebiggers@kernel.org/T/#u),
> > > would be greatly appreciated.
> > > 
> > > Note, as proposed there will still be a limit of:
> > > 
> > > 	merkle_tree_block_size <= fs_block_size <= page_size
> > 
> > > Hopefully you don't need fs_block_size > page_size or
> > 
> > Yes, we will.
> > 
> > This back on my radar now that folios have settled down. It's
> > pretty trivial for XFS to do because we already support metadata
> > block sizes > filesystem block size. Here is an old prototype:
> > 
> > https://lore.kernel.org/linux-xfs/20181107063127.3902-1-david@fromorbit.com/
> 
> As per my follow-up response
> (https://lore.kernel.org/r/Y5jc7P1ZeWHiTKRF@sol.localdomain),
> I now think that wouldn't actually be a problem.

Good to hear.

> > > merkle_tree_block_size > fs_block_size?
> > 
> > That's also a desirable addition.
> > 
> > XFS is using xattrs to hold merkle tree blocks so the merkle tree
> > storage is are already independent of the filesystem block size and
> > page cache limitations. Being able to using 64kB merkle tree blocks
> > would be really handy for reducing the search depth and overall IO
> > footprint of really large files.
> 
> Well, the main problem is that using a Merkle tree block of 64K would mean that
> you can never read less than 64K at a time.

Sure, but why does that matter?

The typical cost of a 64kB IO is only about 5% more than a
4kB IO, even on slow spinning storage.  However, we bring an order
of magnitude more data into the cache with that IO, so we can then
process more data before we have to go to disk again and take
another latency hit.

FYI, we have this large 64kB block size option for directories in
XFS already - you can have a 4kB block size filesystem with a 64kB
directory block size. The larger block size is a little slower for
small directories because they have higher per-leaf block CPU
processing overhead, but once you get to millions of records in a
single directory or really high sustained IO load, the larger block
size is *much* faster because the reduction in IO latency and search
efficiency more than makes up for the single block CPU processing
overhead...

The merkle tree is little different - once we get into TB scale
files, the merkle tree is indexing millions of individual records.
At this point overall record lookup and IO efficiency dominates the
data access time, not the amount of data each individual IO
retreives from disk.

Keep in mind that the block size used for the merkle tree would be a
filesystem choice. If we have the capability to support 64kB
merkle tree blocks, then XFS can make the choice of what block size
to use at the point where we are measuring the file because we know
how large the file is at that point. And because we're storing the
merkle tree blocks in xattrs, we know exactly what block size the
merkle tree data was stored in from the xattr metadata...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
