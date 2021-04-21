Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591AB36707B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 18:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbhDUQrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 12:47:18 -0400
Received: from mx2.veeam.com ([64.129.123.6]:42390 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244429AbhDUQq4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:46:56 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 55116424B9;
        Wed, 21 Apr 2021 12:46:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1619023576; bh=+8+0fKeMJvrXulCBXhw1N6zV3TO5UJB7NtBUlKBwUWY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dBMT7IY86FudF1J3JjVsTJ+Jc5bLVGSH1vPpSQrvcKJ2xg36jpAsLmq/zMFsJt4ih
         M7tT5fIeCgS4ThRvCUo5kUuEXX732/p3BLxLRIHR4MT//DCo2we26s5Qtr4cPx19IK
         pnzo7Ko+HC0I11KhGTn4+NmWBjcezgbCKDYGsPSI=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 21 Apr 2021 18:46:00 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v9 4/4] Using dm_get_device_ex() instead of dm_get_device()
Date:   Wed, 21 Apr 2021 19:45:45 +0300
Message-ID: <1619023545-23431-5-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
References: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B59677566
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not every DM target needs the ability to attach via blk_interposer.
A DM target can attach and detach 'on the fly' only if the DM
target works as a filter without changing the location of the blocks
on the block device.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/md/dm-cache-target.c | 5 +++--
 drivers/md/dm-delay.c        | 3 ++-
 drivers/md/dm-dust.c         | 3 ++-
 drivers/md/dm-era-target.c   | 4 +++-
 drivers/md/dm-flakey.c       | 3 ++-
 drivers/md/dm-linear.c       | 3 ++-
 drivers/md/dm-log-writes.c   | 3 ++-
 drivers/md/dm-snap.c         | 3 ++-
 drivers/md/dm-writecache.c   | 3 ++-
 9 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 541c45027cc8..885a6fde1b9b 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2140,8 +2140,9 @@ static int parse_origin_dev(struct cache_args *ca, struct dm_arg_set *as,
 	if (!at_least_one_arg(as, error))
 		return -EINVAL;
 
-	r = dm_get_device(ca->ti, dm_shift_arg(as), FMODE_READ | FMODE_WRITE,
-			  &ca->origin_dev);
+	r = dm_get_device_ex(ca->ti, dm_shift_arg(as), FMODE_READ | FMODE_WRITE,
+			     dm_table_is_interposer(ca->ti->table),
+			     &ca->origin_dev);
 	if (r) {
 		*error = "Error opening origin device";
 		return r;
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 2628a832787b..1b051a023a5d 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -153,7 +153,8 @@ static int delay_class_ctr(struct dm_target *ti, struct delay_class *c, char **a
 		return -EINVAL;
 	}
 
-	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &c->dev);
+	ret = dm_get_device_ex(ti, argv[0], dm_table_get_mode(ti->table),
+			       dm_table_is_interposer(ti->table), &c->dev);
 	if (ret) {
 		ti->error = "Device lookup failed";
 		return ret;
diff --git a/drivers/md/dm-dust.c b/drivers/md/dm-dust.c
index cbe1058ee589..5eb930ea8034 100644
--- a/drivers/md/dm-dust.c
+++ b/drivers/md/dm-dust.c
@@ -366,7 +366,8 @@ static int dust_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		return -ENOMEM;
 	}
 
-	if (dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &dd->dev)) {
+	if (dm_get_device_ex(ti, argv[0], dm_table_get_mode(ti->table),
+			     dm_table_is_interposer(ti->table), &dd->dev)) {
 		ti->error = "Device lookup failed";
 		kfree(dd);
 		return -EINVAL;
diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index d9ac7372108c..db8791981605 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1462,7 +1462,9 @@ static int era_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		return -EINVAL;
 	}
 
-	r = dm_get_device(ti, argv[1], FMODE_READ | FMODE_WRITE, &era->origin_dev);
+	r = dm_get_device_ex(ti, argv[1], FMODE_READ | FMODE_WRITE,
+			     dm_table_is_interposer(ti->table),
+			     &era->origin_dev);
 	if (r) {
 		ti->error = "Error opening data device";
 		era_destroy(era);
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index b7fee9936f05..89bb77545757 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -243,7 +243,8 @@ static int flakey_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	if (r)
 		goto bad;
 
-	r = dm_get_device(ti, devname, dm_table_get_mode(ti->table), &fc->dev);
+	r = dm_get_device_ex(ti, devname, dm_table_get_mode(ti->table),
+			     dm_table_is_interposer(ti->table), &fc->dev);
 	if (r) {
 		ti->error = "Device lookup failed";
 		goto bad;
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 92db0f5e7f28..1301b11dd2af 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -51,7 +51,8 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	lc->start = tmp;
 
-	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &lc->dev);
+	ret = dm_get_device_ex(ti, argv[0], dm_table_get_mode(ti->table),
+			       dm_table_is_interposer(ti->table), &lc->dev);
 	if (ret) {
 		ti->error = "Device lookup failed";
 		goto bad;
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 57882654ffee..32a389ea4eb1 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -554,7 +554,8 @@ static int log_writes_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	atomic_set(&lc->pending_blocks, 0);
 
 	devname = dm_shift_arg(&as);
-	ret = dm_get_device(ti, devname, dm_table_get_mode(ti->table), &lc->dev);
+	ret = dm_get_device_ex(ti, devname, dm_table_get_mode(ti->table),
+			       dm_table_is_interposer(ti->table), &lc->dev);
 	if (ret) {
 		ti->error = "Device lookup failed";
 		goto bad;
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 11890db71f3f..eab96db253e1 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2646,7 +2646,8 @@ static int origin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad_alloc;
 	}
 
-	r = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &o->dev);
+	r = dm_get_device_ex(ti, argv[0], dm_table_get_mode(ti->table),
+			     dm_table_is_interposer(ti->table), &o->dev);
 	if (r) {
 		ti->error = "Cannot get target device";
 		goto bad_open;
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 4f72b6f66c3a..bb0801fe4c63 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2169,7 +2169,8 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	string = dm_shift_arg(&as);
 	if (!string)
 		goto bad_arguments;
-	r = dm_get_device(ti, string, dm_table_get_mode(ti->table), &wc->dev);
+	r = dm_get_device_ex(ti, string, dm_table_get_mode(ti->table),
+			     dm_table_is_interposer(ti->table), &wc->dev);
 	if (r) {
 		ti->error = "Origin data device lookup failed";
 		goto bad;
-- 
2.20.1

