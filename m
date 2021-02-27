Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F2F326D6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 15:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhB0OuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 09:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhB0OuA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 09:50:00 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0481164EDB;
        Sat, 27 Feb 2021 14:49:17 +0000 (UTC)
Date:   Sat, 27 Feb 2021 09:49:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, mingo@redhat.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [blktrace]  c055908abe:
 WARNING:at_kernel/trace/trace.c:#create_trace_option_files
Message-ID: <20210227094916.701a8a50@oasis.local.home>
In-Reply-To: <20210227114440.GA22871@xsang-OptiPlex-9020>
References: <20210225070231.21136-34-chaitanya.kulkarni@wdc.com>
        <20210227114440.GA22871@xsang-OptiPlex-9020>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Feb 2021 19:44:40 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> [   20.216017] WARNING: CPU: 0 PID: 1 at kernel/trace/trace.c:8370 create_trace_option_files (kbuild/src/consumer/kernel/trace/trace.c:8370 (discriminator 1)) 
> [   20.218480] Modules linked in:
> [   20.219395] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.11.0-09341-gc055908abe0d #1
> [   20.221182] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   20.224540] EIP: create_trace_option_files (kbuild/src/consumer/kernel/trace/trace.c:8370 (discriminator 1)) 
> [ 20.225816] Code: d5 01 83 15 2c b7 08 d5 00 83 c0 01 39 c8 0f 84 c7 00 00 00 8b 14 c7 39 72 44 75 df 83 05 10 b7 08 d5 01 83 15 14 b7 08 d5 00 <0f> 0b 83 05 18 b7 08 d5 01 83 15 1c b7 08 d5 00 83 05 20 b7 08 d5

Looks to be from this:

> +static struct tracer blk_tracer_ext __read_mostly = {
> +	.name		= "blkext",
> +	.init		= blk_tracer_init,
> +	.reset		= blk_tracer_reset,
> +	.start		= blk_tracer_start,
> +	.stop		= blk_tracer_stop,
> +	.print_header	= blk_tracer_print_header,
> +	.print_line	= blk_tracer_print_line_ext,
> +	.flags		= &blk_tracer_flags,

                          ^^^

As blk_tracer already registers those flags, when it gets registered as
a tracer, and flag names can not be duplicated.

I could fix the infrastructure to detect the same set of flags being
registered by two different tracers, but in the mean time, it may still
work to use the blk_trace_flags from blk_tracer, and keep .flags NULL
here.

-- Steve


> +	.set_flag	= blk_tracer_set_flag,
> +};
> +
