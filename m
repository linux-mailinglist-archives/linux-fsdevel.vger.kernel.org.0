Return-Path: <linux-fsdevel+bounces-56316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF83B15894
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 07:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F3118A5534
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 05:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572E11EC006;
	Wed, 30 Jul 2025 05:51:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69B1DC9B3;
	Wed, 30 Jul 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753854697; cv=none; b=bw96CX+1KDPIT1iDbVfjoT7yLdhB/XYN00bB17hRMAV97vJVCCuJHLbePmMWmr9YHCzt+IV48v3HO6scxa9DJLeUOQJItn69hbQmh2N+olRhrrS6kFTkT18zu6LKH9NL/4tGY7dCwaue8EvroKF1qMiBx88h8mfUw0OtdEy4Zlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753854697; c=relaxed/simple;
	bh=7CHgoPjSNoxSE7B23pCo1i1BPf8MFQOuRlCizMyCJt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMUhMCKSeLjFqyfh48T/SkOAebM+xT/uwacyZwDobrA5SBmJgY8b4aA9iYXftjOzNw2Oe4vEFl5YHX0KvyWh4fjQYC0Z+WJpW0iSdVVsSl5dPc3h9LpIpPNMIL0MjUNLNI76pbPoUsY8wgyrmIiyazDVmhXydyOtDbsHskTJYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:1726:a1d9:9a49:d971])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id B7D7F40625;
	Wed, 30 Jul 2025 05:51:31 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:1726:a1d9:9a49:d971) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: syztest
Date: Wed, 30 Jul 2025 06:51:26 +0100
Message-ID: <20250730055126.114185-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68894408.a00a0220.26d0e1.0013.GAE@google.com>
References: <68894408.a00a0220.26d0e1.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175385469222.11884.11046834632476464238@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5978,10 +5978,6 @@ struct mddev *md_alloc(dev_t dev, char *name)
 
 	disk->events |= DISK_EVENT_MEDIA_CHANGE;
 	mddev->gendisk = disk;
-	error = add_disk(disk);
-	if (error)
-		goto out_put_disk;
-
 	kobject_init(&mddev->kobj, &md_ktype);
 	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");
 	if (error) {
@@ -5999,6 +5995,9 @@ struct mddev *md_alloc(dev_t dev, char *name)
 	kobject_uevent(&mddev->kobj, KOBJ_ADD);
 	mddev->sysfs_state = sysfs_get_dirent_safe(mddev->kobj.sd, "array_state");
 	mddev->sysfs_level = sysfs_get_dirent_safe(mddev->kobj.sd, "level");
+	error = add_disk(disk);
+	if (error)
+		goto out_put_disk;
 	mutex_unlock(&disks_mutex);
 	return mddev;
 
-- 
2.43.0


