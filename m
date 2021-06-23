Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1053B15CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFWI24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:28:56 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:45194 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229833AbhFWI2z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:28:55 -0400
X-UUID: d701f4f7734d446a8f711030b3de84c8-20210623
X-UUID: d701f4f7734d446a8f711030b3de84c8-20210623
X-User: jiangguoqing@kylinos.cn
Received: from [172.30.60.82] [(106.37.198.34)] by nksmu.kylinos.cn
        (envelope-from <jiangguoqing@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 1084115594; Wed, 23 Jun 2021 16:25:51 +0800
Subject: Re: [PATCH v2 03/10] raid-md: reduce stack footprint dealing with
 block device names
To:     Anton Suvorov <warwish@yandex-team.ru>, willy@infradead.org
Cc:     dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
 <20210622174424.136960-1-warwish@yandex-team.ru>
 <20210622174424.136960-4-warwish@yandex-team.ru>
From:   Guoqing Jiang <jiangguoqing@kylinos.cn>
Message-ID: <803a31fb-7b51-d160-5b3e-7736c0aa6d2d@kylinos.cn>
Date:   Wed, 23 Jun 2021 16:26:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622174424.136960-4-warwish@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Maybe replace "raid-md" with "md/raid" or just "md".

On 6/23/21 1:44 AM, Anton Suvorov wrote:
> Stack usage reduced (measured with allyesconfig):
>
> ./drivers/md/md-linear.c	linear_make_request	248	112	-136
> ./drivers/md/md-multipath.c	multipath_end_request	232	96	-136
> ./drivers/md/md-multipath.c	multipath_error	208	72	-136
> ./drivers/md/md-multipath.c	multipathd	248	112	-136
> ./drivers/md/md-multipath.c	print_multipath_conf	208	64	-144
> ./drivers/md/md.c	autorun_devices	312	184	-128
> ./drivers/md/md.c	export_rdev	168	32	-136
> ./drivers/md/md.c	md_add_new_disk	280	80	-200
> ./drivers/md/md.c	md_import_device	200	56	-144
> ./drivers/md/md.c	md_integrity_add_rdev	192	56	-136
> ./drivers/md/md.c	md_ioctl	560	496	-64
> ./drivers/md/md.c	md_reload_sb	224	88	-136
> ./drivers/md/md.c	md_run	408	288	-120
> ./drivers/md/md.c	md_seq_show	232	96	-136
> ./drivers/md/md.c	md_update_sb	304	168	-136
> ./drivers/md/md.c	read_disk_sb	184	48	-136
> ./drivers/md/md.c	super_1_load	392	192	-200
> ./drivers/md/md.c	super_90_load	304	112	-192
> ./drivers/md/md.c	unbind_rdev_from_array	200	64	-136
> ./drivers/md/raid0.c	create_strip_zones	400	200	-200
> ./drivers/md/raid0.c	dump_zones	536	464	-72
> ./drivers/md/raid1.c	fix_read_error	352	288	-64
> ./drivers/md/raid1.c	print_conf	224	80	-144
> ./drivers/md/raid1.c	raid1_end_read_request	216	80	-136
> ./drivers/md/raid1.c	raid1_error	216	96	-120
> ./drivers/md/raid1.c	sync_request_write	344	208	-136
> ./drivers/md/raid10.c	fix_read_error	392	320	-72
> ./drivers/md/raid10.c	print_conf	216	72	-144
> ./drivers/md/raid10.c	raid10_end_read_request	216	80	-136
> ./drivers/md/raid10.c	raid10_error	216	80	-136
> ./drivers/md/raid5-cache.c	r5l_init_log	224	88	-136
> ./drivers/md/raid5-ppl.c	ppl_do_flush	256	136	-120
> ./drivers/md/raid5-ppl.c	ppl_flush_endio	192	56	-136
> ./drivers/md/raid5-ppl.c	ppl_modify_log	192	56	-136
> ./drivers/md/raid5-ppl.c	ppl_recover_entry	1296	1232	-64
> ./drivers/md/raid5-ppl.c	ppl_submit_iounit_bio	192	56	-136
> ./drivers/md/raid5-ppl.c	ppl_validate_rdev	184	48	-136
> ./drivers/md/raid5.c	print_raid5_conf	208	64	-144
> ./drivers/md/raid5.c	raid5_end_read_request	272	128	-144
> ./drivers/md/raid5.c	raid5_error	216	80	-136
> ./drivers/md/raid5.c	setup_conf	360	296	-64
>
> Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
> ---
>   drivers/md/md-linear.c    |   5 +-
>   drivers/md/md-multipath.c |  24 +++----
>   drivers/md/md.c           | 135 ++++++++++++++------------------------
>   drivers/md/raid0.c        |  28 ++++----
>   drivers/md/raid1.c        |  25 +++----
>   drivers/md/raid10.c       |  65 ++++++++----------
>   drivers/md/raid5-cache.c  |   5 +-
>   drivers/md/raid5-ppl.c    |  40 +++++------
>   drivers/md/raid5.c        |  39 +++++------
>   9 files changed, 144 insertions(+), 222 deletions(-)

Also a nice cleanup!  Acked-by: Guoqing Jiang <jiangguoqing@kylinos.cn>

Thanks,
Guoqing


