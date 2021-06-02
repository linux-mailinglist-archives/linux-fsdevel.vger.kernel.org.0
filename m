Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B72398EBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhFBPfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhFBPfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:35:48 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846ECC061574;
        Wed,  2 Jun 2021 08:34:04 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id B4B5D2E16E7;
        Wed,  2 Jun 2021 18:29:15 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id QfSGlawkec-TF1m5VGG;
        Wed, 02 Jun 2021 18:29:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1622647755; bh=GHYHVjFgXMyBYXX9g5Vm44kIc3wPx/6lZzof53ArujY=;
        h=Cc:Message-Id:Date:Subject:To:From;
        b=J/92j8ZuZ+yMAOwCD78oNs5yFWA3WzuqHvE6UaGKJwGFvTIg/bUSW9HYlkmQ5rdh4
         pG8KPYslrzw8+ngiPZ3xckDHKvmyH9eyhQUys55+fbUg0o/AcxlRFDmrTbcih5t5vA
         05HdEG5dgChXLvlB4k1zM2N33dChXSw780eet7RI=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 42DbdVHlBw-TEoiZoxf;
        Wed, 02 Jun 2021 18:29:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     warwish@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH 00/10] reduce stack footprint printing bdev names
Date:   Wed,  2 Jun 2021 18:28:53 +0300
Message-Id: <20210602152903.910190-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dmitry Monakhov <dmtrmonakhov@yandex-team.ru> started "kernel newbies"
initiative at Yandex allowing developers unfamiliar with kernel
development process to join kernel development. Initiative includes easy
to fix bugs and some small improvments. This patchset was tailored as part
of the initiative.

Few years ago Dmitry Monakhov introduced %pg formatter for vsprintf()
(https://lore.kernel.org/lkml/1428928300-9132-1-git-send-email-dmonakhov@openvz.org/)
and switched some hot code paths to it instead of allocating temporary
buffer for device name on stack. This patchset continues his work and
expands to most places where temporary buffer with BDEVNAME_SIZE size
allocated on stack. There are also some changes in printk() calls
advised by checkpatch.pl script.


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
	./drivers/md/dm-table.c	device_area_is_invalid	216	80	-136
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
	./drivers/md/md.c	md_run	408	288	-120
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
	./drivers/md/raid1.c	sync_request_write	344	208	-136
	./drivers/md/raid10.c	fix_read_error	392	320	-72
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
	./fs/block_dev.c	__blkdev_put	224	80	-144
	./fs/ext4/page-io.c	ext4_end_bio	224	88	-136
	./security/loadpin/loadpin.c	loadpin_read_file	200	56	-144

Patchset was tested with kvm-xfstests -c 4k full using 
https://github.com/tytso/xfstests-bld/blob/master/kernel-configs/x86_64-config-5.10
kernel config:
	-------------------- Summary report
	KERNEL:    kernel 5.13.0-rc4-next-20210601-xfstests-00001-gf10818e9d103 #8 SMP Tue Jun 1 19:52:19 MSK 2021 x86_64
	CMDLINE:   -c 4k full
	CPUS:      2
	MEM:       1961.41
	
	ext4/4k: 537 tests, 45 skipped, 5331 seconds
	Totals: 492 tests, 45 skipped, 0 failures, 0 errors, 5281s
	
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
 block/partitions/amiga.c            |  13 ++-
 block/partitions/sgi.c              |   5 +-
 block/partitions/sun.c              |   5 +-
 drivers/block/drbd/drbd_req.c       |  12 +--
 drivers/block/pktcdvd.c             |  15 ++-
 drivers/dax/super.c                 |  34 +++----
 drivers/md/dm-cache-target.c        |  10 +-
 drivers/md/dm-clone-target.c        |  10 +-
 drivers/md/dm-crypt.c               |   6 +-
 drivers/md/dm-integrity.c           |   4 +-
 drivers/md/dm-mpath.c               |   6 +-
 drivers/md/dm-table.c               |  34 +++----
 drivers/md/dm-thin.c                |   8 +-
 drivers/md/md-linear.c              |   5 +-
 drivers/md/md-multipath.c           |  24 ++---
 drivers/md/md.c                     | 146 ++++++++++++----------------
 drivers/md/raid0.c                  |  28 +++---
 drivers/md/raid1.c                  |  25 ++---
 drivers/md/raid10.c                 |  66 +++++--------
 drivers/md/raid5-cache.c            |   5 +-
 drivers/md/raid5-ppl.c              |  41 ++++----
 drivers/md/raid5.c                  |  39 ++++----
 drivers/target/target_core_iblock.c |   5 +-
 fs/block_dev.c                      |   6 +-
 fs/ext4/page-io.c                   |   5 +-
 include/linux/bio.h                 |   2 -
 security/loadpin/loadpin.c          |   5 +-
 31 files changed, 242 insertions(+), 352 deletions(-)

-- 
2.25.1

