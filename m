Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1E6A336C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 19:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBZS00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 13:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBZS0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:26:25 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C0711EB0;
        Sun, 26 Feb 2023 10:26:24 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 8C45E83191;
        Sun, 26 Feb 2023 18:26:20 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677435984;
        bh=Iz5h8+IvB6AGuGph3EUQwH4CjEnn4umqDZWcNOgJEhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmoHYGC+4XhKP+Syq5r9hpOCyl3yg8Xx/8d669vPKBl7eFyJUSGrRhheM9/1baMmP
         K1o48wOEL17Kzehoq3ICGyDQRKXrmh4/zvoE/EwsCWNEubD4NORt9yUgPDy0e1E4aS
         fgk0v3Ms1+TEjwmt5+XfsJbFBuN7zHnlC5yhyMNCQyTCTuTLjjOI3YYVUVvdSAosRY
         gwrNbez2CLyCg0YwV5ZgRhHV4swMlLHhDqYAawuouYWCc06HJq/PzuR/YvtZMrQy2U
         BdLJSfiZQfthlsrUxT7iTfmXKNyhgYLXyfsBm326fAqefkfAgt6gfO8yIGXZDSk+9O
         r7MEDUsqCzp1Q==
Date:   Mon, 27 Feb 2023 01:26:16 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
Message-ID: <Y/ukSBodK65MEsuL@biznet-home.integral.gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
 <Y/uQdXp8ioY1WQEp@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/uQdXp8ioY1WQEp@slm.duckdns.org>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Sun, 26 Feb 2023 07:01:41 -1000, Tejun Heo wrote:
> Hmm... the allowed cpumasks for unbounded workqueues can already be set
> through /sys/devices/virtual/workqueue/cpumask and also each individual
> workqueue can be exposed in the matching subdirectory by setting WQ_SYSFS.
> Wouldn't the proposed btrfs option be a bit reduandant?

Thank you for the comment. I just realized the sysfs facility for this.
So I will take a look into it deeper. For now, I have several reasons to
use the `wq_cpu_set` option:

1. Currently, there are 15 btrfs workqueues. It would not be convenient
   to let the user manage each of them via the sysfs. Using `wq_cpu_set`
   option at mounting time allows the user to set all of them in one
   shot.

   (for btrfs maintainers):
   I am also not sure if the number of btrfs workqueues is stable so
   that the user can rely on the WQ_SYSFS facility.

2. I looked at /sys/devices/virtual/workqueue/ and saw its
   subdirectories. The directory name is taken from the wq->name. But
   how to distinguish multiple workqueues with the same name?

Each btrfs mount will at least do this:

	alloc_workqueue("btrfs-compressed-write", flags, max_active);

When we do:

	mount -t -o rw btrfs /dev/sda1 a;
	mount -t -o rw btrfs /dev/sda2 b;
	mount -t -o rw btrfs /dev/sda3 c;
	mount -t -o rw btrfs /dev/sda4 d;

Is there a way to identify which sysfs devices correspond to a specific
mounted btrfs fs workqueues? Let's say I want each mount to have a
different CPU mask.

-- 
Ammar Faizi

