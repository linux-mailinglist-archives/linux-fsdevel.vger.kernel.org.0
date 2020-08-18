Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957EE248446
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHRL6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 07:58:20 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:14618 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHRL6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:58:19 -0400
IronPort-SDR: ugdH8JAyc2BH7itCWvKGUDcD3p9mMn+kNtLgxH9cGyc7/kczRQmNfAAySWZXOGr8//wEEOWquQ
 jSea8J8pxOGyGiXackOa7lBoofGo5B3rVoioRAVuSMuz8+GvxPj5niZoxXuSF6CGvbTOouSwFP
 1TzVg34o0yga/mYu94ITbkw5J8Bd9VbCb9Yq99kj0wwh1gvFdZfuQ5JdztziO5C+xms7H1G4j9
 MkpGGs6lN+r2NOHL8qYCKYKvYAg6C5GNc8ERKEcjDatPLmyZHCHZQuQpRLquaD/vY1IVtaX6cB
 jJU=
X-IronPort-AV: E=Sophos;i="5.76,327,1592899200"; 
   d="scan'208";a="54194417"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 18 Aug 2020 03:58:18 -0800
IronPort-SDR: UacQbdCiZh6aLafhHVEmRcUXoNib6UbiNdqpwhet+hEKxZkvk+OYUUR+f9yf6A+NJRyEd8YZHA
 I4iIXGc6vZRUSEqQxRk3ein5Pt6wgk1kNTVMe+2Zj8nXV2Y/t5KNXwNAOSwQwRmfA5zl4DitRr
 euRNdMn1Iar92Sab2H0DoOIt3xyxkzC5Q5DX8pJiPj2N8kc0a+x4xoDNvFk42n6TMgKQAF0xxx
 LzGLV6f4KdWoTGPkXM3kl2/kW4ne5G/5LRLr3lfG7Io+G3AkfSRW8dhU3UPVR8g5yQMAitQsSp
 PO4=
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
From:   Jim Baxter <jim_baxter@mentor.com>
Subject: PROBLEM: Long Workqueue delays V2
CC:     "Resch Carsten (CM/ESO6)" <Carsten.Resch@de.bosch.com>,
        "Rosca, Eugeniu (ADITG/ESB)" <erosca@de.adit-jv.com>
Message-ID: <625615f2-3a6b-3136-35f9-2f2fb3c110cf@mentor.com>
Date:   Tue, 18 Aug 2020 12:58:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am asking this question again to include the fs-devel list.


We have issues with the workqueue of the kernel overloading the CPU 0 
when we we disconnect a USB stick.

This results in other items on the shared workqueue being delayed by
around 6.5 seconds with a default kernel configuration and 2.3 seconds
on a config tailored for our RCar embedded platform.



We first noticed this issue on custom hardware and we have recreated it
on an RCar Starter Kit using a test module [1] to replicate the
behaviour, the test module outputs any delays of greater then 9ms.

To run the test we have a 4GB random file on a USB stick and perform
the following test.
The stick is mounted as R/O and we are copying data from the stick:

- Mount the stick.
mount -o ro,remount /dev/sda1

- Load the Module:
# taskset -c 0 modprobe latency-mon

- Copy large amount of data from the stick:
# dd if=/run/media/sda1/sample.txt of=/dev/zero
[ 1437.517603] DELAY: 10
8388607+1 records in
8388607+1 records out


- Disconnect the USB stick:
[ 1551.796792] usb 2-1: USB disconnect, device number 2
[ 1558.625517] DELAY: 6782


The Delay output 6782 is in milliseconds.



Using umount stops the issue occurring but is unfortunately not guaranteed
in our particular system.


From my analysis the hub_event workqueue kworker/0:1+usb thread uses around
98% of the CPU.

I have traced the workqueue:workqueue_queue_work function while unplugging the USB
and there is no particular workqueue function being executed a lot more then the 
others for the kworker/0:1+usb thread.


Using perf I identified the hub_events workqueue was spending a lot of time in
invalidate_partition(), I have included a cut down the captured data from perf in
[2] which shows the additional functions where the kworker spends most of its time.


I am aware there will be delays on the shared workqueue, are the delays
we are seeing considered normal?


Is there any way to mitigate or identify where the delay is?
I am unsure if this is a memory or filesystem subsystem issue.


Thank you for you help.

Thanks,
Jim Baxter

[1] Test Module:
// SPDX-License-Identifier: GPL-2.0
/*
 * Simple WQ latency monitoring
 *
 * Copyright (C) 2020 Advanced Driver Information Technology.
 */

#include <linux/init.h>
#include <linux/ktime.h>
#include <linux/module.h>

#define PERIOD_MS 100

static struct delayed_work wq;
static u64 us_save;

static void wq_cb(struct work_struct *work)
{
	u64 us = ktime_to_us(ktime_get());
	u64 us_diff = us - us_save;
	u64 us_print = 0;

	if (!us_save)
		goto skip_print;


	us_print = us_diff / 1000 - PERIOD_MS;
	if (us_print > 9)
		pr_crit("DELAY: %lld\n", us_print);

skip_print:
	us_save = us;
	schedule_delayed_work(&wq, msecs_to_jiffies(PERIOD_MS));
}

static int latency_mon_init(void)
{
	us_save = 0;
	INIT_DELAYED_WORK(&wq, wq_cb);
	schedule_delayed_work(&wq, msecs_to_jiffies(PERIOD_MS));

	return 0;
}

static void latency_mon_exit(void)
{
	cancel_delayed_work_sync(&wq);
	pr_info("%s\n", __func__);
}

module_init(latency_mon_init);
module_exit(latency_mon_exit);
MODULE_AUTHOR("Eugeniu Rosca <erosca@de.adit-jv.com>");
MODULE_LICENSE("GPL");


[2] perf trace:
    95.22%     0.00%  kworker/0:2-eve  [kernel.kallsyms]
    |
    ---ret_from_fork
       kthread
       worker_thread
       |          
        --95.15%--process_one_work
		  |          
		   --94.99%--hub_event
			 |          
			  --94.99%--usb_disconnect
			  <snip>
				|  
				--94.90%--invalidate_partition
				   __invalidate_device
				   |          
				   |--64.55%--invalidate_bdev
				   |  |          
				   |   --64.13%--invalidate_mapping_pages
				   |     |          
				   |     |--24.09%--invalidate_inode_page
				   |     |   |          
				   |     |   --23.44%--remove_mapping
				   |     |     |          
				   |     |      --23.20%--__remove_mapping
				   |     |        |          
				   |     |         --21.90%--arch_local_irq_restore
				   |     |          
				   |     |--22.44%--arch_local_irq_enable
				   |          
					--30.35%--shrink_dcache_sb 
					<snip>
					  |      
					  --30.17%--truncate_inode_pages_range

