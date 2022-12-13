Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821AF64BF26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 23:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiLMWLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 17:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbiLMWLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:11:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26CD12AB0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 14:11:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p24so1372799plw.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 14:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1Nx+dhohGWX7bG5EIAxBmvaHjOSWZNWavYhUAzzjLY=;
        b=dg1dzCH0kYQOSEHBnPCHI3b7XEPurSfoCFHsVRILMuh7T5NN9wA4LcWEcGgwjdnRfa
         2vxVYTZnNcjcy82ncACDo3SZLOkxuFk6zws0zmU4d+SiDmOWpdfywycY6Zik6EZ3ssUZ
         0hvcWUZKJaN4T92EQrDQank8meKoJCVslRps8N0qiDZYZoJPkbb0hXPdp6YXGiFixalb
         LMZJNMR3ff1OZ+GK4IfmZ0ZYOINct0+X2hnv1M/k9DZmxH7yV4LjqS9nbIMr4DVVtdTn
         KG0GWSTDtTU3sTHCZW1WpQMvxHlY+OfmG+Ng30qcN0m+/C+r+3ecNnOAAQHjyeSJZ0Dv
         zxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1Nx+dhohGWX7bG5EIAxBmvaHjOSWZNWavYhUAzzjLY=;
        b=xNfpQzbVSYFmNQRcuouWMy7L+/O1dR+A7uYoBQ1ca0v6Pk4HXB5aawqWz/F04Mq4N6
         WSrR8e0P4X6ESNSEc6CXu2wMfXUFARle5L1FDKSYgp3CZFzarKeenxoUUtoXsDFWBLAc
         BOJJ/hL5se31KDUZKa66/7yfJJqqJz2c3c8A+aipAphwxdz/1PSsPFNDaJ5ou0FeNd/o
         ex08bUEcJrCX1kgDe2Nz9ZupqrwSv5RwNAa79px1T+TBIBx26nnKv9kBcl82qa/LNY7x
         6frhLGVvrUaWFVosO4Cr6f5X0n1P5zVo+O4a/rjO0rXBML7ZhDBzDdyiiKgfGylxbyY8
         tmZg==
X-Gm-Message-State: ANoB5pmg8LL/Yy1L/YkEFzk0RNCwrGOcsv7ORgF7oar3T5ujCsGz0Qbv
        marfd9SqQodk7mdu/GobVfKrUQ==
X-Google-Smtp-Source: AA0mqf5SMikqN5FQMhm+FCUvMyCuZjnkU7+f1H1XtWXUxOKzgVvZtrGm5cWsMwx7pUVL+Cb7/y2fEA==
X-Received: by 2002:a17:902:c454:b0:189:fba2:3756 with SMTP id m20-20020a170902c45400b00189fba23756mr19901604plm.66.1670969502321;
        Tue, 13 Dec 2022 14:11:42 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902900800b00189327b022bsm330738plp.286.2022.12.13.14.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 14:11:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5DUx-0086dJ-9r; Wed, 14 Dec 2022 09:11:39 +1100
Date:   Wed, 14 Dec 2022 09:11:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] fs-verity support for XFS
Message-ID: <20221213221139.GZ3600936@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <Y5jllLwXlfB7BzTz@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jllLwXlfB7BzTz@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:50:28PM -0800, Eric Biggers wrote:
> On Tue, Dec 13, 2022 at 06:29:24PM +0100, Andrey Albershteyn wrote:
> > Not yet implemented:
> > - No pre-fetching of Merkle tree pages in the
> >   read_merkle_tree_page()
> 
> This would be helpful, but not essential.
> 
> > - No marking of already verified Merkle tree pages (each read, the
> >   whole tree is verified).

Ah, I wasn't aware that this was missing.

> 
> This is essential to have, IMO.
> 
> You *could* do what btrfs does, where it caches the Merkle tree pages in the
> inode's page cache past i_size, even though btrfs stores the Merkle tree
> separately from the file data on-disk.
>
> However, I'd guess that the other XFS developers would have an adversion to that
> approach, even though it would not affect the on-disk storage.

Yup, on an architectural level it just seems wrong to cache secure
verification metadata in the same user accessible address space as
the data it verifies.

> The alternatives would be to create a separate in-memory-only inode for the
> cache, or to build a custom cache with its own shrinker.

The merkel tree blocks are cached in the XFS buffer cache.

Andrey, could we just add a new flag to the xfs_buf->b_flags to
indicate that the buffer contains verified merkle tree records?
i.e. if it's not set after we've read the buffer, we need to verify
the buffer and set th verified buffer in cache and we can skip the
verification?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
