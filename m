Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF23B0BAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhFVRrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhFVRrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:47:07 -0400
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82747C06175F;
        Tue, 22 Jun 2021 10:44:50 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id B0CAD2E1A81;
        Tue, 22 Jun 2021 20:44:44 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id DDAVePy4c6-iiROfo5h;
        Tue, 22 Jun 2021 20:44:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1624383884; bh=ciRTZJfij6cVnqNZqE5x+i0wgdqTt0UNUw4QNl1os3M=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=DQKjT6Pku0bm7BO0C1crKmLBtMDW8c7lOiNte65YZyyvQa3TxLwd4Mn5t+gBk1jJD
         gat7wS/dnDjm5S7xws0kOqAtKGnwJUKum9hIg1g40weWJqg+pEnA5aBKmzdfVyPQ2v
         ajANnAirLHdT3V1cVERPutZL6rrZuRXZaTQHo8CE=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gVbf2yAtam-ii9mY4ig;
        Tue, 22 Jun 2021 20:44:44 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     willy@infradead.org
Cc:     dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, warwish@yandex-team.ru
Subject: [PATCH v2 00/10] reduce stack footprint printing bdev names
Date:   Tue, 22 Jun 2021 20:44:14 +0300
Message-Id: <20210622174424.136960-1-warwish@yandex-team.ru>
In-Reply-To: <YLe9eDbG2c/rVjyu@casper.infradead.org>
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes from v1:
Updated formatting according to Matthew Wilcox <willy@infradead.org> advice.
Some lines may be longer than preferred 80 characters (even 100 in some cases),
but they still remain easily readable (and could be found via grep).

The patchset shows significant reduce of stack footprint:

	./block/blk-core.c	submit_bio_checks	248	112	-136
	./block/blk-lib.c	__blkdev_issue_discard	240	104	-136
	./block/blk-settings.c	disk_stack_limits	256	192	-64
	./block/partitions/amiga.c	amiga_partition	424	368	-56
	./block/partitions/sgi.c	sgi_partition	352	288	-64
	./block/partitions/sun.c	sun_partition	392	328	-64
	./drivers/block/drbd/drbd_req.c	drbd_report_io_error	200	72	-128
	./drivers/block/pktcdvd.c	pkt_seq_show	288	224	-64
	./drivers/block/pktcdvd.c	pkt_setup_dev	272	136	-136
	./drivers/block/pktcdvd.c	pkt_submit_bio	288	224	-64
	./drivers/dax/super.c	__bdev_dax_supported	192	56	-136
	./drivers/dax/super.c	__generic_fsdax_supported	344	280	-64
	./drivers/md/dm-cache-target.c	cache_ctr	392	328	-64
	./drivers/md/dm-cache-target.c	cache_io_hints	208	72	-136
	./drivers/md/dm-clone-target.c	clone_ctr	416	352	-64
	./drivers/md/dm-clone-target.c	clone_io_hints	216	80	-136
	./drivers/md/dm-crypt.c	crypt_convert_block_aead	408	272	-136
	./drivers/md/dm-crypt.c	kcryptd_async_done	192	56	-136
	./drivers/md/dm-integrity.c	integrity_metadata	872	808	-64
	./drivers/md/dm-mpath.c	parse_priority_group	368	304	-64
	./drivers/md/dm-table.c	device_area_is_invalid	208	72	-136
	./drivers/md/dm-table.c	dm_set_device_limits	200	72	-128
	./drivers/md/dm-thin.c	pool_io_hints	216	80	-136
	./drivers/md/md-linear.c	linear_make_request	248	112	-136
	./drivers/md/md-multipath.c	multipath_end_request	232	96	-136
	./drivers/md/md-multipath.c	multipath_error	208	72	-136
	./drivers/md/md-multipath.c	multipathd	248	112	-136
	./drivers/md/md-multipath.c	print_multipath_conf	208	64	-144
	./drivers/md/md.c	autorun_devices	312	184	-128
	./drivers/md/md.c	export_rdev	168	32	-136
	./drivers/md/md.c	md_add_new_disk	280	80	-200
	./drivers/md/md.c	md_import_device	200	56	-144
	./drivers/md/md.c	md_integrity_add_rdev	192	56	-136
	./drivers/md/md.c	md_ioctl	560	496	-64
	./drivers/md/md.c	md_reload_sb	224	88	-136
	./drivers/md/md.c	md_run	416	296	-120
	./drivers/md/md.c	md_seq_show	232	96	-136
	./drivers/md/md.c	md_update_sb	304	168	-136
	./drivers/md/md.c	read_disk_sb	184	48	-136
	./drivers/md/md.c	super_1_load	392	192	-200
	./drivers/md/md.c	super_90_load	304	112	-192
	./drivers/md/md.c	unbind_rdev_from_array	200	64	-136
	./drivers/md/raid0.c	create_strip_zones	400	200	-200
	./drivers/md/raid0.c	dump_zones	536	464	-72
	./drivers/md/raid1.c	fix_read_error	352	288	-64
	./drivers/md/raid1.c	print_conf	224	80	-144
	./drivers/md/raid1.c	raid1_end_read_request	216	80	-136
	./drivers/md/raid1.c	raid1_error	216	96	-120
	./drivers/md/raid1.c	sync_request_write	336	200	-136
	./drivers/md/raid10.c	fix_read_error	384	312	-72
	./drivers/md/raid10.c	print_conf	216	72	-144
	./drivers/md/raid10.c	raid10_end_read_request	216	80	-136
	./drivers/md/raid10.c	raid10_error	216	80	-136
	./drivers/md/raid5-cache.c	r5l_init_log	224	88	-136
	./drivers/md/raid5-ppl.c	ppl_do_flush	256	136	-120
	./drivers/md/raid5-ppl.c	ppl_flush_endio	192	56	-136
	./drivers/md/raid5-ppl.c	ppl_modify_log	192	56	-136
	./drivers/md/raid5-ppl.c	ppl_recover_entry	1296	1232	-64
	./drivers/md/raid5-ppl.c	ppl_submit_iounit_bio	192	56	-136
	./drivers/md/raid5-ppl.c	ppl_validate_rdev	184	48	-136
	./drivers/md/raid5.c	print_raid5_conf	208	64	-144
	./drivers/md/raid5.c	raid5_end_read_request	272	128	-144
	./drivers/md/raid5.c	raid5_error	216	80	-136
	./drivers/md/raid5.c	setup_conf	360	296	-64
	./drivers/target/target_core_iblock.c	iblock_show_configfs_dev_params	192	56	-136
	./fs/block_dev.c	blkdev_flush_mapping	200	56	-144
	./fs/ext4/page-io.c	ext4_end_bio	224	88	-136
	./security/loadpin/loadpin.c	loadpin_read_file	200	56	-144

Patchset was tested with kvm-xfstests -c 4k full using
https://github.com/tytso/xfstests-bld/blob/master/kernel-configs/x86_64-config-5.10
kernel config:
	-------------------- Summary report
	KERNEL:    kernel 5.13.0-rc6-next-20210618-xfstests-00010-g225cff5e67be #12 SMP Sat Jun 19 00:13:37 MSK 2021 x86_64
	CMDLINE:   -c 4k full
	CPUS:      2
	MEM:       1960.88
	
	ext4/4k: 537 tests, 45 skipped, 5381 seconds
	Totals: 492 tests, 45 skipped, 0 failures, 0 errors, 5327s
	
	FSTESTVER: blktests 4bc88ef (Sun, 7 Mar 2021 12:38:37 -0800)
	FSTESTVER: fio  fio-3.26 (Mon, 8 Mar 2021 17:44:38 -0700)
	FSTESTVER: fsverity v1.3-2-gcf8fa5e (Wed, 24 Feb 2021 13:32:36 -0800)
	FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
	FSTESTVER: nvme-cli v1.13 (Tue, 20 Oct 2020 16:50:31 -0700)
	FSTESTVER: quota  v4.05-40-g25f16b1 (Tue, 16 Mar 2021 17:57:19 +0100)
	FSTESTVER: util-linux v2.36.2 (Fri, 12 Feb 2021 14:59:56 +0100)
	FSTESTVER: xfsprogs v5.11.0 (Fri, 12 Mar 2021 15:05:13 -0500)
	FSTESTVER: xfstests linux-v3.8-3068-g4072b9d3 (Mon, 5 Apr 2021 15:44:33 -0400)
	FSTESTVER: xfstests-bld 4ec07f9 (Mon, 12 Apr 2021 23:49:18 -0400)
	FSTESTCFG: 4k
	FSTESTSET: -g auto
	FSTESTOPT: aex

Anton Suvorov (10):
  drbd: reduce stack footprint in drbd_report_io_error()
  dax: reduce stack footprint dealing with block device names
  raid-md: reduce stack footprint dealing with block device names
  dm: reduce stack footprint dealing with block device names
  block: reduce stack footprint dealing with block device names
  target: reduce stack footprint in iblock_show_configfs_dev_params()
  vfs: reduce stack footprint in __blkdev_put()
  ext4: reduce stack footprint in ext4_end_bio()
  security: reduce stack footprint in loadpin_read_file()
  block: remove unused symbol bio_devname()

 block/bio.c                         |   6 --
 block/blk-core.c                    |  12 +--
 block/blk-lib.c                     |   5 +-
 block/blk-settings.c                |   7 +-
 block/partitions/amiga.c            |  10 +--
 block/partitions/sgi.c              |   4 +-
 block/partitions/sun.c              |   4 +-
 drivers/block/drbd/drbd_req.c       |  12 ++-
 drivers/block/pktcdvd.c             |  13 +--
 drivers/dax/super.c                 |  27 ++----
 drivers/md/dm-cache-target.c        |  10 +--
 drivers/md/dm-clone-target.c        |  10 +--
 drivers/md/dm-crypt.c               |   6 +-
 drivers/md/dm-integrity.c           |   4 +-
 drivers/md/dm-mpath.c               |   5 +-
 drivers/md/dm-table.c               |  34 ++++---
 drivers/md/dm-thin.c                |   8 +-
 drivers/md/md-linear.c              |   5 +-
 drivers/md/md-multipath.c           |  24 +++--
 drivers/md/md.c                     | 135 +++++++++++-----------------
 drivers/md/raid0.c                  |  28 +++---
 drivers/md/raid1.c                  |  25 +++---
 drivers/md/raid10.c                 |  65 ++++++--------
 drivers/md/raid5-cache.c            |   5 +-
 drivers/md/raid5-ppl.c              |  40 ++++-----
 drivers/md/raid5.c                  |  39 ++++----
 drivers/target/target_core_iblock.c |   4 +-
 fs/block_dev.c                      |   6 +-
 fs/ext4/page-io.c                   |   5 +-
 include/linux/bio.h                 |   2 -
 security/loadpin/loadpin.c          |   5 +-
 31 files changed, 212 insertions(+), 353 deletions(-)

-- 
2.25.1

