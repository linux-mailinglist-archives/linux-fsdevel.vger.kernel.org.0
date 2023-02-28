Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E36A540B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 09:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjB1ICP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 03:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjB1IBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:01:50 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068D2BF32;
        Tue, 28 Feb 2023 00:01:15 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.2.36.16])
        by gnuweeb.org (Postfix) with ESMTPSA id F29B8831DA;
        Tue, 28 Feb 2023 08:01:10 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677571274;
        bh=xUpQ0Xo2NE8oaRu79qOTI/d+TDpkm3C5IO6ZS1rJgEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dskrUgXVrYPdXEFvsHlrNEygCz/KmoC03D5Tb7TNWTqmySshek9lolSNCkO8xRedE
         857OfpJoLbd++j7EhouXB0iQK9CTBZWFjHWapttlPz1F1Wp6mlchToG+9sIeNvrsuu
         JGj7oskiL3zEvKr4QGl/6GnuUckRZURfdGE9QmbDk1Xnjj6dIKcLdcYRjVVDVIfkWy
         R4TXtGFd6Ge01i9y7HtiSNzkW+0RN5QV5PHdVtffucBTsB3pB3xtouIOW411lajrLw
         QhRUn2vbIvR1WNFi7jtAkQ9D5t+5YdcBv+4ogD8ESiMCSL3MM3kf3dqVIagGrLqYXv
         XcZTWMflGaTqQ==
Date:   Tue, 28 Feb 2023 15:01:06 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
Message-ID: <Y/20wsdwxx8OSw/+@biznet-home.integral.gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
 <20230227221745.GI2825702@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227221745.GI2825702@dread.disaster.area>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 09:17:45AM +1100, Dave Chinner wrote:
> This seems like the wrong model for setting cpu locality for
> internal filesystem threads.
> 
> Users are used to controlling cpu sets and other locality behaviour
> of a task with wrapper tools like numactl. Wrap th emount command
> with a numactl command to limit the CPU set, then have the btrfs
> fill_super() callback set the cpu mask for the work queues it
> creates based on the cpu mask that has been set for the mount task.
> 
> That is, I think the model should be "inherit cpu mask from parent
> task" rather than adding mount options. This model allows anything
> that numactl can control (e.g. memory locality) to also influence
> the filesystem default behaviour without having to add yet more
> mount options in the future....

Good idea on the tooling part.

I like the idea of using numactl to determine a proper CPU set. But
users may also use /etc/fstab to mount their btrfs storage. In that
case, using mount option is still handy.

Also, if we always inherit CPU mask from the parent task who calls the
mount, it will be breaking the CPU affinity for old users who
inadvertently call their mount cmd with random CPU mask.

We should keep the old behavior and allow user to opt in if they want
to. Maybe something like:

   numactl -N 0 mount -t btrfs -o rw,wq_cpu_set=inherit /dev/bla bla

-- 
Ammar Faizi

