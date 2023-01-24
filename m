Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF030678F6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 05:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjAXEpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 23:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAXEpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 23:45:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533CF367D9;
        Mon, 23 Jan 2023 20:45:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0808611C8;
        Tue, 24 Jan 2023 04:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E69C433EF;
        Tue, 24 Jan 2023 04:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674535500;
        bh=uLobooDvuBLURSCK8z3RoEGS4cS1PpKpDD7QQUTMSD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdRV0h4/9wqTp6KPfHa6Si4KC562GC3ojVCDi8BBaWItEoPR6qLWzqTVqwgZjfEVW
         PWR1mRaLVCQfhQXQjGIz+tOcQ3XybYFpTTz1cTYbK/IvHbGXfvoff1itK6CbceI2zV
         u2hAQh7shcbt6mDphAr8VXMOOZe08a+NUbbNnaoLgXA4xFteTGX3xC+tnTeMYQsH3b
         iblJcu+BlCgM7O9J8F8S4gmXywpmNmIPTwfi6kF3hzlz9j3IsUu5kTW+V8kczaVxYC
         M6W2FhanDbbnWWz7ebjSP5XQQv1Lv8wVzAOCDGP+fnRp7geE4ztjfhvbZiD5XMDWqY
         CR88zcivq/+wQ==
Date:   Mon, 23 Jan 2023 21:44:57 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: What would happen if the block device driver/firmware found some
 block of a bio is corrupted?
Message-ID: <Y89iSQJEpMFBSd2G@kbusch-mbp.dhcp.thefacebook.com>
References: <5be2cd86-e535-a4ae-b989-887bf9c2c36d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be2cd86-e535-a4ae-b989-887bf9c2c36d@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:31:47AM +0800, Qu Wenruo wrote:
> I'm wondering what would happen if we submit a read bio containing multiple
> sectors, while the block disk driver/firmware has internal checksum and
> found just one sector is corrupted (mismatch with its internal csum)?
> 
> For example, we submit a read bio sized 16KiB, and the device is in 4K
> sector size (like most modern HDD/SSD).
> The corruption happens at the 2nd sector of the 16KiB.
> 
> My instinct points to either of them:
> 
> A) Mark the whole 16KiB bio as BLK_STS_IOERR
>    This means even we have 3 good sectors, we have to treat them all as
>    errors.

I believe BLK_STS_MEDIUM is the appropriate status for this scenario,
not IOERR. The MEDIUM errno is propogated up as ENODATA.

Finding specific failed sectors makes sense if a partial of the
originally requested data is useful. That's application specific, so the
retry logic should probably be driven at a higher level than the block
layer based on seeing a MEDIUM error.

Some protocols can report partial transfers. If you trust the device,
you could know the first unreadable sector and retry from there.

Some protocols like NVMe optionally support querying which sectors are
not readable. We're not making use of that in kernel, but these kinds of
features exist if you need to know which LBAs to exclude for future
retries.

Outside that, you could search for specific unrecoverable LBAs with
split retries till you find them all, divide-and-conquer.
