Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA4583BA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 12:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiG1KBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 06:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiG1KA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:00:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EEA167E5;
        Thu, 28 Jul 2022 03:00:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 376741FFA3;
        Thu, 28 Jul 2022 10:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659002456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MjBR5d5iF90QgK09LCBa7b8puT8yJDuRAnIWGff5/g=;
        b=p3SWZtJOXud4Li8R6rfKe2x881b6TTDg8HOqBY1Bty2qZUV/BOw4oHBobvYWKg7PKIeaav
        O+88qm2XQv3t098vubRxl0M7XSJB/WTtPoPPcDJpVY4r+VKbRUP/3aIzvOtfpdW9mTihy4
        AVuxtH5f4JfWxIkD4pGQBru+WRuOCu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659002456;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MjBR5d5iF90QgK09LCBa7b8puT8yJDuRAnIWGff5/g=;
        b=T8jJtrsDU6q84QyDoCMshrYrfIFt+wL3JI2SNyqF0xECz3qBuyImj/AAPEERFnFhYssjVH
        /ZM5bBJdClR670Ag==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D5F82C141;
        Thu, 28 Jul 2022 10:00:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 21874A0664; Thu, 28 Jul 2022 12:00:55 +0200 (CEST)
Date:   Thu, 28 Jul 2022 12:00:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Message-ID: <20220728100055.efbvaudwp3ofolpi@quack3>
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Mon 18-07-22 15:29:47, Stefan Wahren wrote:
> i noticed that since Linux 5.18 (Linux 5.19-rc6 is still affected) i'm
> unable to run "rpi-update" without massive performance regression on my
> Raspberry Pi 4 (multi_v7_defconfig + CONFIG_ARM_LPAE). Using Linux 5.17 this
> tool successfully downloads the latest firmware (> 100 MB) on my development
> micro SD card (Kingston 16 GB Industrial) with a ext4 filesystem within ~ 1
> min. The same scenario on Linux 5.18 shows the following symptoms:

Thanks for report and the bisection!
 
> - download takes endlessly much time and leads to an abort by userspace in
> most cases because of the poor performance
> - massive system load during download even after download has been aborted
> (heartbeat LED goes wild)

OK, is it that the CPU is busy or are we waiting on the storage card?
Observing top(1) for a while should be enough to get the idea.  (sorry, I'm
not very familiar with RPi so I'm not sure what heartbeat LED shows).

> - whole system becomes nearly unresponsive
> - system load goes back to normal after > 10 min

So what likely happens is that the downloaded data is in the pagecache and
what is causing the stuckage is that we are writing it back to the SD card
that somehow is much less efficient with mb_optimize_scan=1 for your setup.
Even if you stop the download, we still have dirty data in the page cache
which we need to write out so that is the reason why the system takes so
long to return back to normal.

> - dmesg doesn't show anything suspicious
> 
> I was able to bisect this issue:
> 
> ff042f4a9b050895a42cae893cc01fa2ca81b95c good
> 4b0986a3613c92f4ec1bdc7f60ec66fea135991f bad
> 25fd2d41b505d0640bdfe67aa77c549de2d3c18a bad
> b4bc93bd76d4da32600795cd323c971f00a2e788 bad
> 3fe2f7446f1e029b220f7f650df6d138f91651f2 bad
> b080cee72ef355669cbc52ff55dc513d37433600 good
> ad9c6ee642a61adae93dfa35582b5af16dc5173a good
> 9b03992f0c88baef524842e411fbdc147780dd5d bad
> aab4ed5816acc0af8cce2680880419cd64982b1d good
> 14705fda8f6273501930dfe1d679ad4bec209f52 good
> 5c93e8ecd5bd3bfdee013b6da0850357eb6ca4d8 good
> 8cb5a30372ef5cf2b1d258fce1711d80f834740a bad
> 077d0c2c78df6f7260cdd015a991327efa44d8ad bad
> cc5095747edfb054ca2068d01af20be3fcc3634f good
> 27b38686a3bb601db48901dbc4e2fc5d77ffa2c1 good
> 
> commit 077d0c2c78df6f7260cdd015a991327efa44d8ad
> Author: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Date:   Tue Mar 8 15:22:01 2022 +0530
> 
> ext4: make mb_optimize_scan performance mount option work with extents
> 
> If i revert this commit with Linux 5.19-rc6 the performance regression
> disappears.
> 
> Please ask if you need more information.

Can you run "iostat -x 1" while the download is running so that we can see
roughly how the IO pattern looks?

Also can get filesystem metadata image of your card like:
  e2image -r <fs-device> - | gzip >/tmp/ext4-image.gz

and put it somewhere for download? The image will contain only fs metadata,
not data so it should be relatively small and we won't have access to your
secrets ;). With the image we'd be able to see how the free space looks
like and whether it perhaps does not trigger some pathological behavior.

My current suspicion is that because the new allocator strategy spreads
allocations over more block groups, we end up with more open erase blocks
on the SD card which forces the firmware to do more garbage collection and
RMW of erase blocks and write performance tanks...

Thanks.
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
