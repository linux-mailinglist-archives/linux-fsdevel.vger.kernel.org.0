Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC862741BAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjF1WOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjF1WNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:13:52 -0400
Received: from out-48.mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F6D2117
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:13:49 -0700 (PDT)
Date:   Wed, 28 Jun 2023 18:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687990428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8WVoQUFJwrHXrcj8iB/cmADxHGelZ4I+K1br+JoT3I=;
        b=c2rOpx7HvgGzuU9oykOoqbse4XOSwYZ4wb/OkY+9zmp5xL/0qECfYdcr3bryvf+X8z/3lh
        ImguE4Rp0ECCFxI6vwJL0XpIV/6ePGsHS591NZPBgP9gATRlDYB0Kq9Kf0dn89xmGFZRBQ
        hOiS+AQCgaXsXCG+9t2kVRMbBIQieB4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
References: <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 03:17:43PM -0600, Jens Axboe wrote:
> Case in point, just changed my reproducer to use aio instead of
> io_uring. Here's the full script:
> 
> #!/bin/bash
> 
> DEV=/dev/nvme1n1
> MNT=/data
> ITER=0
> 
> while true; do
> 	echo loop $ITER
> 	sudo mount $DEV $MNT
> 	fio --name=test --ioengine=aio --iodepth=2 --filename=$MNT/foo --size=1g --buffered=1 --overwrite=0 --numjobs=12 --minimal --rw=randread --output=/dev/null &
> 	Y=$(($RANDOM % 3))
> 	X=$(($RANDOM % 10))
> 	VAL="$Y.$X"
> 	sleep $VAL
> 	ps -e | grep fio > /dev/null 2>&1
> 	while [ $? -eq 0 ]; do
> 		killall -9 fio > /dev/null 2>&1
> 		echo will wait
> 		wait > /dev/null 2>&1
> 		echo done waiting
> 		ps -e | grep "fio " > /dev/null 2>&1
> 	done
> 	sudo umount /data
> 	if [ $? -ne 0 ]; then
> 		break
> 	fi
> 	((ITER++))
> done
> 
> and if I run that, fails on the first umount attempt in that loop:
> 
> axboe@m1max-kvm ~> bash test2.sh
> loop 0
> will wait
> done waiting
> umount: /data: target is busy.
> 
> So yeah, this is _nothing_ new. I really don't think trying to address
> this in the kernel is the right approach, it'd be a lot saner to harden
> the xfstest side to deal with the umount a bit more sanely. There are
> obviously tons of other ways that a mount could get pinned, which isn't
> too relevant here since the bdev and mount point are basically exclusive
> to the test being run. But the kill and delayed fput is enough to make
> that case imho.

Uh, count me very much not in favor of hacking around bugs elsewhere.

Al, do you know if this has been considered before? We've got fput()
being called from aio completion, which often runs out of a worqueue (if
not a workqueue, a bottom half of some sort - what happens then, I
wonder) - so the effect is that it goes on the global list, not the task
work list.

hence, kill -9ing a process doing aio (or io_uring io, for extra
reasons) causes umount to fail with -EBUSY.

and since there's no mechanism for userspace to deal with this besides
sleep and retry, this seems pretty gross.

I'd be willing to tackle this for aio since I know that code...
