Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAD96F6F80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjEDQAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjEDP77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 11:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7DB468B;
        Thu,  4 May 2023 08:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C34A4626FF;
        Thu,  4 May 2023 15:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F61EC433D2;
        Thu,  4 May 2023 15:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683215995;
        bh=FBaesmDueThgzce1AGXwzBYeheoMfDTnfkfXOq6hmkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6vIlkM6jH9hdIbBTD5WahjazhJLSIoImfHG90DvPIb2qNO7tn3CEfHYd1ASraeUQ
         ce3sWdSjQD2NlVAbqsoR7rlRMggbeKTLJf2WDHZaR6Am3yx8MMYYBG+S4PW/jgc3ZS
         HVqT/jsnKTSn0bHsF3phyZEtsJKFTm9WgAxHbmvs7KywT1FMXYDJ6JHEL2SrDdvLXH
         642WKkofFkrUhxEF0NrcttDNFOrw0mW6DhiA2981Urtt2/8eyshs3hpQayzVG0PTGC
         3+I+YOdb4QTWf1tzorXtLSO0O2Y5u6i/3WVLxe4OvyBDFoFOS3tAmiD0zAqiSf2gj0
         BxEyBBQrUflOA==
Date:   Thu, 4 May 2023 09:59:52 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZFPWeOg5xJ7CbCD0@kbusch-mbp.dhcp.thefacebook.com>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:20:28AM +0800, Ming Lei wrote:
> Hello Guys,
> 
> I got one report in which buffered write IO hangs in balance_dirty_pages,
> after one nvme block device is unplugged physically, then umount can't
> succeed.
> 
> Turns out it is one long-term issue, and it can be triggered at least
> since v5.14 until the latest v6.3.
> 
> And the issue can be reproduced reliably in KVM guest:
> 
> 1) run the following script inside guest:
> 
> mkfs.ext4 -F /dev/nvme0n1
> mount /dev/nvme0n1 /mnt
> dd if=/dev/zero of=/mnt/z.img&
> sleep 10
> echo 1 > /sys/block/nvme0n1/device/device/remove
> 
> 2) dd hang is observed and /dev/nvme0n1 is gone actually

Sorry to jump in so late.

For an ungraceful nvme removal, like a surpirse hot unplug, the driver
sets the capacity to 0 and that effectively ends all dirty page writers
that could stall forward progress on the removal. And that 0 capacity
should also cause 'dd' to exit.

But this is not an ungraceful removal, so we're not getting that forced
behavior. Could we use the same capacity trick here after flushing any
outstanding dirty pages?
