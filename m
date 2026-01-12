Return-Path: <linux-fsdevel+bounces-73312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE6D1557F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 21:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB3A3037CD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91024358D21;
	Mon, 12 Jan 2026 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="VpM+IqTK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB922147E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251556; cv=none; b=qkAtWAG80f8SZ5Pt3qpdJMl/DDzIIhAfWjgrxqM0R8Z2Z/zUgkWQD0qSWnIrV2lAMHpE9/Fji8O1JhqgNg8bro6v8iWQO0Sr/RcJInVgn5nDo77re6PMSWalzeCMnK6uF914fZBLnCk7SJQKvlwJZJzXY3Zfl43ly5+fNVrS+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251556; c=relaxed/simple;
	bh=xKYRLKpuM+sQImj23PBCnkebqVm/eqDdchxej7U9Apw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oia+wLavDmmH9+OQqB6tgCCM57wHCuQiH3lodtrtV+ygDSQ+Wt2Dc6nSIFA/5TMuc7/tX3CP+XL/l7BeZYava5gq7SmrzBOcMIGnnMcsdM7qLCMlgCk/qBJOdjT2l1/eUk1eN//faUU0JT8TObfFW974bS9Y7hC6SHTa1HEiLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=VpM+IqTK; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6455a60c12bso6521247d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1768251552; x=1768856352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvo6+EsDKRRfc3HTMCn0lfwSOccr6CCC/pevgcIHrpQ=;
        b=VpM+IqTKMl7hGiKphf26TwaoqpRXCtvwNfZaZOcFRFgA5LVXiLxaPgNsHiM42Zq8Yn
         ApiCjKmF6MJAv20k99Fuj72rxJJl96I3sMsXoTgIFekMZzxkoOB06WFWV8k05bNQDlww
         W/lvsLoTXskPBRd/CuHQv/vTAIIiTAm2DOyjZxi5M/7Ux1Wmu72gKUwADE8wJrXVsFr/
         EMQKqH9EX+oOl0xaE5AooYPFgyRkne/yJfIEhwww165C2DDkGOVu4g3r1yZuMRW+tkhi
         hFcu4Wj78HcHXQJk06QYHJetXnXJ5EVmDa2N8R4KD90msqivGmSY/11zJSfLqkJy+yVL
         7mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768251552; x=1768856352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvo6+EsDKRRfc3HTMCn0lfwSOccr6CCC/pevgcIHrpQ=;
        b=PQG1W0kosekBp9jg+zsu1fgnGULtI9+5LU40RzFQxWkB0MYKcZzxlSnmjvEbayhHGa
         teMa6/Zk9TTQrUMMWZVrUwDRD7md869VsGS9dv2mpTnMvClOGO2Rd8FVrvqb7hgQFCux
         6cTD9yh6fgPKRiGnzSAspnn7pJzOFTeoaHrPJGZcnjuWtC3xHElJ2L0+kQ5mnPN3j9ji
         JqgzH95t1sj+RJove0PI/iIQSUSp9lYo5L2bOLFGl7bf9rBDMPE5pyS6tu/a76b68fDf
         7njQL3l72sAD5pjkcG4zsTgWTf2VNqtYQ5cOVc1F++1ILvedaUXu7sGLA/M+VE9nu0sw
         he6g==
X-Forwarded-Encrypted: i=1; AJvYcCUyKgEjA+SJi9phAXKVwqRJuK9oIuAoxba5q8/4tP9DBiGx+t1EHG7jeYQjAjbYCQCN9K79diwrAEptoa37@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSGoEwOkfiaDH9mBQJmcfd0hWQmkwEb7zQ+M4Hy2Ypwfxyd/t
	++rKTpZoL3uepQwoXMkyRRDZbDjwyzC9/qDLIIkJ2FWKbnE62PnQa2y6xwEW4Fh07wU=
X-Gm-Gg: AY/fxX6NcYj1JlTNtLmfJsKS5G6X2vkxytntNhjPuOO9LvL+FD8F6BWgdl9SVjiUN2V
	KzSQdDVOs3q8Vxx/dJH6hexRms69K3AB1novSkytIG2wJahLfmkBb6NjbalAZ1P9799aXtNDZt5
	0JbDRuOEXfmDle27aNzggODKv59UlhZAnn+Jvt6rAvPEmEC9XG3kRp2jTkSaw1BLYhlNK9afyg3
	U91Be+rJaLYFd/YPCi4ETvPR+EKpHKhoOu3h+9b/Ib3xcVH1xoMn+51tGjX7AIrJ5KIKb8l8aN5
	Z+3na3OZj8LlUG5iOhAgg7LIEU1Z5h0tNXKpa9xAb3iF2sL1ci+eN2r+KT5ZyIQnNPpfosrbWxd
	iD++1csOqlHP5OUllYvv8oC2DgyqkxwoWUEngeLWezH/hZszll+94t70dum9unX5DpGFxwHSvzN
	HzvZhnJZCzj+0oMnLIrv79icDLHAajQsSGNIlQLuD9TrU/0eAcFDIVn7Ay8BfMAELlfHhJFC8zJ
	1DxfITmZhlJAv047r0=
X-Google-Smtp-Source: AGHT+IENxy+5x2i2xgYMrz0SKExm/H8Y6u2iabD+v8jPA4ysG46WOfa8D8B0YhZSz4/3C2jKDn1FJQ==
X-Received: by 2002:a05:690e:400a:b0:646:e68a:c886 with SMTP id 956f58d0204a3-64716b34ac7mr16215312d50.19.1768251551980;
        Mon, 12 Jan 2026 12:59:11 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:5da1:5daf:bcea:9f2c])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f7c04sm8475793d50.2.2026.01.12.12.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:59:11 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: util-linux@vger.kernel.org,
	kzak@redhat.com
Cc: ceph-devel@vger.kernel.org,
	idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com,
	Pavan.Rallabhandi@ibm.com
Subject: [PATCH] mount: (manpage) add CephFS kernel client mount options
Date: Mon, 12 Jan 2026 12:58:38 -0800
Message-ID: <20260112205837.975869-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Currently, manpage for generic mount tool doesn't contain
explanation of CephFS kernel client mount options. This patch
adds the description of CephFS mount options into
file system specific mount options section.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 sys-utils/mount.8.adoc | 86 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 4571bd2bfd16..191a3fabf501 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -853,6 +853,7 @@ This section lists options that are specific to particular filesystems. Where po
 |===
 |*Filesystem(s)* |*Manual page*
 |btrfs |*btrfs*(5)
+|cephfs |*mount.ceph*(8)
 |cifs |*mount.cifs*(8)
 |ext2, ext3, ext4 |*ext4*(5)
 |fuse |*fuse*(8)
@@ -913,6 +914,91 @@ Give blocksize. Allowed values are 512, 1024, 2048, 4096.
 **grpquota**|**noquota**|**quota**|*usrquota*::
 These options are accepted but ignored. (However, quota utilities may react to such strings in _/etc/fstab_.)
 
+=== Mount options for ceph
+
+CephFS is a POSIX-compliant distributed filesystem provided by Ceph. For more information, see the Linux kernel documentation at _Documentation/filesystems/ceph.rst_ or the Ceph documentation at _https://docs.ceph.com/_.
+
+**mon_addr=**__ip_address__[**:**__port__][**/**__ip_address__[**:**__port__]]::
+Monitor address(es) to bootstrap the connection to the Ceph cluster. Multiple monitor addresses can be specified, separated by forward slashes. If a port is not specified, the default port 6789 is used.
+
+**fsid=**__cluster-id__::
+The cluster FSID (unique identifier). This can be obtained via the *ceph fsid* command.
+
+**ip=**__A.B.C.D__[**:**__N__]::
+Specifies the local IP address and optionally the port that the client should bind to.
+
+**conf=**__path__::
+Path to a _ceph.conf_ configuration file. This can be used for auto-discovery of monitor addresses and authentication secrets.
+
+**secret=**__key__::
+The CephX secret key for authentication. This option is insecure because it exposes the secret on the command line. Use *secretfile* instead when possible.
+
+**secretfile=**__path__::
+Path to a file containing the CephX secret key. This is the preferred method for providing authentication credentials.
+
+**fs=**__name__ or **mds_namespace=**__name__::
+Specify a non-default Ceph filesystem to mount. The *mds_namespace* option is the older syntax.
+
+**mount_timeout=**__seconds__::
+Timeout value for mount operations in seconds. Default is 60 seconds.
+
+**wsize=**__bytes__::
+Maximum write size in bytes. Default is 67108864 (64 MB).
+
+**rsize=**__bytes__::
+Maximum read size in bytes. Default is 67108864 (64 MB).
+
+**rasize=**__bytes__::
+Maximum readahead size in bytes. Default is 8388608 (8 MB).
+
+**caps_max=**__number__::
+Maximum number of capabilities (caps) to retain. When this limit is exceeded, unused caps are released. Default is 0 (no limit).
+
+*rbytes*::
+When *stat*(2) is called on a directory, set the *st_size* field to 'rbytes', the summation of file sizes over all files nested beneath that directory. This is the default behavior.
+
+*norbytes*::
+When *stat*(2) is called on a directory, set the *st_size* field to the number of entries in that directory instead of the recursive byte count.
+
+*dcache*::
+Enable directory entry cache (dcache) for negative lookup caching and readdir operations. This is the default behavior.
+
+*nodcache*::
+Disable directory entry cache usage. This disables negative lookup caching and dcache-assisted readdir operations.
+
+*noasyncreaddir*::
+Disable asynchronous readdir operations that use the dcache.
+
+*nocrc*::
+Disable CRC32C calculation for data writes. If set, the storage nodes must rely on TCP's error correction to detect data corruption in the data payload.
+
+**snapdirname=**__name__::
+Sets the name of the hidden snapshots directory. Default is _.snap_.
+
+*dirstat*::
+Enable reading of directory stats via *cat* on the directory.
+
+*nodirstat*::
+Disable reading of directory stats via *cat* on the directory.
+
+*noquotadf*::
+Report overall filesystem usage in statfs instead of the quota for the root directory.
+
+*nocopyfrom*::
+Disable the use of RADOS copy-from operations in *copy_file_range*(2). The RADOS copy-from operation allows the copy to be performed server-side, which can be more efficient.
+
+**recover_session=**{**no**|*clean*}::
+Control the auto-reconnect behavior when the client has been blocklisted. The default is *no*, which prevents reconnection. The *clean* option (available since Linux kernel 5.4) reconnects automatically when blocklisted, but discards any dirty data and invalidates all caches. This can result in data loss.
+
+**ms_mode=**{**legacy**|**crc**|**secure**|**prefer-crc**|*prefer-secure*}::
+Select the connection transport protocol. *legacy* uses the v1 protocol. *crc* uses the v2 protocol without encryption. *secure* uses the v2 protocol with encryption. *prefer-crc* and *prefer-secure* indicate a preference but will fall back if the preferred mode is not available.
+
+*wsync*::
+Execute namespace operations (file/directory creations, deletions, etc.) synchronously.
+
+*nowsync*::
+Execute namespace operations asynchronously. This is the default behavior since Linux kernel 5.7.
+
 === Mount options for debugfs
 
 The debugfs filesystem is a pseudo filesystem, traditionally mounted on _/sys/kernel/debug_. As of kernel version 3.4, debugfs has the following options:
-- 
2.52.0


