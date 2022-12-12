Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EB64A788
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 19:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiLLSsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 13:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiLLSqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:46:32 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B04B62D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 10:46:23 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id j16so9772503qtv.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 10:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbkdJaLOP/vMBqN0DWbeXqbCoBKj/NLdfM5o1UZoPtg=;
        b=BiflXrMvkQL86DwDsuvp6zeu20P/QSTZLdhXa0elHIV0T/SgbjFyJwd6jvnjoc+f88
         41OV0DeplENg78lX4yl9EdygKEKISQ3t6ZyaGuN+6sNg+M9nXKZsRrRw/7x9eMgHOEqr
         fscuXjvYupahus/kO2WGkZtW5EAaFAD2+yxyOYZ624vIgFYw6UZZFcxVqX22QIi34AU1
         /fpStE00hMo0mxyXrXq1Bru6OBSweQ+rKUt66IltQb85gCfaod0CbdDFSZLMueN+uL2v
         Wcol1WibOeTSE+o+ofOg67Gjf99MJGhFJbqpoO1Uoad11Tht0XVZZApO5oRxve2JL4+w
         X7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbkdJaLOP/vMBqN0DWbeXqbCoBKj/NLdfM5o1UZoPtg=;
        b=u1/byaHaR8Kj6ZOybruVZPOtxK91GEJyT5/8o1SSW7y25qds6LY+2WMclkiTvK4bnY
         RQzZCmLyd1uYRgxvVHMnD5jTjapQsF+CfhgmAY8/0aDx5nT2EZecR2OpQ99BQR1CVfkn
         bsKtU7fUI7J+AH0Yiu9bfbvySvaLxA6y+bIbF3kO5j6XGFTGQYMlOdid/fJaO2CUIrEH
         Z+CtfQIBk/RuQFvdZ8l2Nx1tgcU6vAJEqLOq4NaKdtrlQ1bg4QejPpMaeiHv2pEVMrud
         V63bCz6/I/7cpv+aW/jQVZaUQ28JFg68aEKhIbXBvhKlD+F26++7gc6LU/7BR55xkjsB
         t3uQ==
X-Gm-Message-State: ANoB5pkgoKBINovMfXKjpF+qEVDmR2ktDOwnSujgrh9OUDELKYfZQiT1
        93tiyEAN5FpkQZGte2EJnmt9CA==
X-Google-Smtp-Source: AA0mqf5lCcZ3o+7m0AnrGOzD69vhiTmFeYO42EEJpCHJDRdGBUIxLCGMJx4ZMqEDyrKPzYFZZSMrqA==
X-Received: by 2002:ac8:5c83:0:b0:3a6:c4eb:2e52 with SMTP id r3-20020ac85c83000000b003a6c4eb2e52mr29409230qta.43.1670870782424;
        Mon, 12 Dec 2022 10:46:22 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i12-20020ac813cc000000b003a50248b89esm6155964qtj.26.2022.12.12.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:46:21 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:46:19 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: consolidate btrfs checksumming, repair and bio splitting v2
Message-ID: <Y5d2+3hCpEwT7QG2@localhost.localdomain>
References: <20221120124734.18634-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120124734.18634-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 20, 2022 at 01:47:15PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series moves a large amount of duplicate code below btrfs_submit_bio
> into what I call the 'storage' layer.  Instead of duplicating code to
> checksum, check checksums and repair and split bios in all the caller
> of btrfs_submit_bio (buffered I/O, direct I/O, compressed I/O, encoded
> I/O), the work is done one in a central place, often more optiomal and
> without slight changes in behavior.  Once that is done the upper layers
> also don't need to split the bios for extent boundaries, as the storage
> layer can do that itself, including splitting the bios for the zone
> append limits for zoned I/O.
> 
> The split work is inspired by an earlier series from Qu, from which it
> also reuses a few patches.
> 
> The rebasing against the latest misc-next was a bit painful due to the
> various large cleanups, but very little logic changed, so I've kept the
> review tags for now, but I'd appreciated another careful round of eyes.
> 
> A git tree is also available:
> 
>     git://git.infradead.org/users/hch/misc.git btrfs-bio-split
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-split
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the patches that don't already have my reviewed-by tag.  Thanks,

Josef
