Return-Path: <linux-fsdevel+bounces-20945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399628FB11C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAFF1C22025
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F0145B3A;
	Tue,  4 Jun 2024 11:26:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278F145343;
	Tue,  4 Jun 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500403; cv=none; b=fnSZQJBm3OuqOd+v2L26GZLH2dBJm2L9gKTU2EUDoak6Sc+pS3gW67oFVkJmrnN2ZGZzmfwFGTI3CifwCAW6nIAMHDJLEOYhiTa6r/tgiQz5VUt5nVjBdfUhztBelBmoBY3OrSIOecDEuxQ8R6NURh9P03wxoH2kPGekuOK4LfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500403; c=relaxed/simple;
	bh=2sqRP+cDWakjPW2TLGsMmWbJp1y1dv+ct4RW2zKc/Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovaM7Cbv1o0/0QFRYuoL7trceEwRa352OEwnSLSo0PohalmudRVYbzSubsOePK9f/f+yNsC6qLaueK4/Iyh0DSbgIWZkgrVi8Ji7+8ZQD22T1tMMkXyNMOofT4n8J6Z5hztyHNiWHyvrc+PNU1J/Xi7jJu/L6czCHlocZ/38IiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VtpFZ2z71z4f3mJP;
	Tue,  4 Jun 2024 19:26:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 78BD21A0CB7;
	Tue,  4 Jun 2024 19:26:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAXKwTp+V5mJkItOg--.61165S6;
	Tue, 04 Jun 2024 19:26:36 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	raven@themaw.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	trond.myklebust@hammerspace.com,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	djwong@kernel.org
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	zhangxiaoxu5@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH RFC 2/2] NFSv4: set sb_flags to second superblock
Date: Tue,  4 Jun 2024 19:26:36 +0800
Message-Id: <20240604112636.236517-3-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604112636.236517-1-lilingfeng@huaweicloud.com>
References: <20240604112636.236517-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXKwTp+V5mJkItOg--.61165S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1DCFW3ur1xAr1UGF1Utrb_yoW5CF1rpF
	WfAryUGrWkJF1UXa10yFWrXa4Sy34kZF4UAFn3ua4kAryDXr1xX3W3tFWY9a48Zr4fZr98
	XFWftF13C3ZrJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbvtC7UU
	UUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

During the process of mounting an NFSv4 client, two superblocks will be
created in sequence. The first superblock corresponds to the root
directory exported by the server, and the second superblock corresponds to
the directory that will be actually mounted. The first superblock will
eventually be destroyed.
The flag passed from user mode will only be passed to the first
superblock, resulting in the actual used superblock not carrying the flag
passed from user mode(fs_context_for_submount() will set sb_flags as 0).

If the 'ro' parameter is used in two consecutive mount commands, only the
first execution will create a new vfsmount, and the kernel will return
EBUSY on the second execution. However, if a remount command with the 'ro'
parameter is executed between the two mount commands, both mount commands
will create new vfsmounts.

The superblock generated after the first mount command does not have the
'ro' flag, and the read-only status of the file system is implemented by
checking the read-only flag of the vfsmount. After executing the remount
command, the 'ro' flag will be added to the superblock. When the second
mount command is executed, the comparison result between the superblock
with the 'ro' flag and the fs_context without the flag in the
nfs_compare_mount_options() function will be different, resulting in the
creation of a new vfsmount.

This problem can be reproduced by performing the following operations:
mount -t nfs -o ro,vers=4.0 192.168.240.250:/sdb /mnt/sdb
mount -t nfs -o remount,ro,vers=4.0 192.168.240.250:/sdb /mnt/sdb
mount -t nfs -o ro,vers=4.0 192.168.240.250:/sdb /mnt/sdb
Two vfsmounts are generated:
[root@localhost ~]# mount | grep nfs
192.168.240.250:/sdb on /mnt/sdb type nfs4 (ro,relatime,vers=4.0,
rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,
sec=sys,clientaddr=192.168.240.251,local_lock=none,addr=192.168.240.250)
192.168.240.250:/sdb on /mnt/sdb type nfs4 (ro,relatime,vers=4.0,
rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,
sec=sys,clientaddr=192.168.240.251,local_lock=none,addr=192.168.240.250)

Fix this by setting sb_flags to second superblock.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 887aeacedebd..8b3d75af60d4 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -158,7 +158,7 @@ struct vfsmount *nfs_d_automount(struct path *path, unsigned int sb_flags)
 	/* Open a new filesystem context, transferring parameters from the
 	 * parent superblock, including the network namespace.
 	 */
-	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry, 0);
+	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry, sb_flags);
 	if (IS_ERR(fc))
 		return ERR_CAST(fc);
 
-- 
2.39.2


