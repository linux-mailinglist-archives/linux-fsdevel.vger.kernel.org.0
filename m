Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDA95B0C56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIGSP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIGSP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:15:26 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B675CDF
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 11:15:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a22so11070466qtw.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 11:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=kcIYI8NmuWiMivmaomdBwvzucRaN50rRGw/j8RUlX3s=;
        b=wE3zYYLIthIV/0GUWFFTYDrY8LL+VGJKqBfYcF2unNJfFc9SETMVf5gdClCUb8c45n
         GVBf/27umXNzzink85C+rOIrrhuAnox3XzQmQX8t0wyHhldK6yK9ysO7DO8w2LPetoV2
         wzfziZpbOTQFPWm9FZaZuHtXq/+p3liImLRC5hSfEDz8jSxmtlKFpq/2owdgzkjoo0aW
         RNf+1f4lDISWwKKCR6kWvj+6jOyyMpJ3Vr+vBuyRc1rxznDkdfMC5efIxVwuYXlG4Hln
         UOuqckQ9hANvi8JfxZN6gxv/tvxYJn5tfmaZSWPWqvMY1CNZEW56G0UGhMYmWqPPUWVM
         vTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kcIYI8NmuWiMivmaomdBwvzucRaN50rRGw/j8RUlX3s=;
        b=rB/2tpMcM+6MAxPXa7vAXTKXSxciJ6ujALrOv/yrNgGjC/EjDP48TBYOL3Rz4yxyj3
         G8AYRdUZQvSLyz+YyDXgMZWk+mJjzoOR4GXdCXprjVYAU9ICWJjtGYLNvC08vDTRevqH
         r+kDNRrSHqMQ81PafoYyUWi+m8hid6C0isJL9G7IUD5gVaG+hBVMNe74bRnMHn1KjUvx
         8QrmxmOd5hCVOwhnVJPp+RT3e6GS5TXRW67/AiE1gkcxeOue8Zg4dAedAUgJ+Z7Y8dp9
         xnhKVS3DxXSLKhBVb/l4QvG2ioePOIUPAGmn7P7jj+Gb0I/C7K0ILeFEm6I82tDvQSup
         V8/g==
X-Gm-Message-State: ACgBeo0JG+TTnh8xsfGSqeZ4hkGbpDUnVUfex8BKYbBgFuwsyZKL9e5Z
        MPtOMOhZ9U7/Wu+8/nMOSmSSNQ==
X-Google-Smtp-Source: AA6agR5N8cD3U34IZMm5/LxdvClR6FJJIWZmMN1F/+WM0gP1vZe5y5EJQwBsG+kR7d9tNr1PTBuUjw==
X-Received: by 2002:ac8:5e52:0:b0:344:829f:2eb0 with SMTP id i18-20020ac85e52000000b00344829f2eb0mr4437152qtx.18.1662574524166;
        Wed, 07 Sep 2022 11:15:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a29-20020ac8611d000000b0033b30e8e7a5sm13081511qtm.58.2022.09.07.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:15:23 -0700 (PDT)
Date:   Wed, 7 Sep 2022 14:15:22 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/17] btrfs: handle checksum validation and repair at
 the storage layer
Message-ID: <YxjfuuJkmOfVPBoM@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-5-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:03AM +0300, Christoph Hellwig wrote:
> Currently btrfs handles checksum validation and repair in the end I/O
> handler for the btrfs_bio.  This leads to a lot of duplicate code
> plus issues with variying semantics or bugs, e.g.
> 
>  - the until recently completetly broken repair for compressed extents
>  - the fact that encoded reads validate the checksums but do not kick
>    of read repair
>  - the inconsistent checking of the BTRFS_FS_STATE_NO_CSUMS flag
> 
> This commit revamps the checksum validation and repair code to instead
> work below the btrfs_submit_bio interfaces.  For this to work we need
> to make sure an inode is available, so that is added as a parameter
> to btrfs_bio_alloc.  With that btrfs_submit_bio can preload
> btrfs_bio.csum from the csum tree without help from the upper layers,
> and the low-level I/O completion can iterate over the bio and verify
> the checksums.
> 
> In case of a checksum failure (or a plain old I/O error), the repair
> is now kicked off before the upper level ->end_io handler is invoked.
> Tracking of the repair status is massively simplified by just keeping
> a small failed_bio structure per bio with failed sectors and otherwise
> using the information in the repair bio.  The per-inode I/O failure
> tree can be entirely removed.
> 
> The saved bvec_iter in the btrfs_bio is now competely managed by
> btrfs_submit_bio and must not be accessed by the callers.
> 
> There is one significant behavior change here:  If repair fails or
> is impossible to start with, the whole bio will be failed to the
> upper layer.  This is the behavior that all I/O submitters execept
> for buffered I/O already emulated in their end_io handler.  For
> buffered I/O this now means that a large readahead request can
> fail due to a single bad sector, but as readahead errors are igored
> the following readpage if the sector is actually accessed will
> still be able to read.  This also matches the I/O failure handling
> in other file systems.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Generally the change itself is fine, but there's several whitespace errors.
Additionally this is sort of massive, I would prefer if you added the
functionality, removing the various calls to the old io failure rec stuff, and
then had a follow up patch to remove the old io failure code.  This makes it
easier for reviewers to parse what is important to pay attention to and what can
easily be ignored.  Clearly I've already reviewed it, but if you rework it more
than fixing the whitespace issues it would be nice to split the changes into
two.  Thanks,

Josef
