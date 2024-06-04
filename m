Return-Path: <linux-fsdevel+bounces-20943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58598FB110
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A981F21F95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3B1459FB;
	Tue,  4 Jun 2024 11:26:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BD1442E3;
	Tue,  4 Jun 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500401; cv=none; b=niW+C+dORK+AvZEEOU5O6kB/nlp9unq2og5+ZAtgTWQFBXi2XZtK8JUMxc+KSTDdKsxJ2wjCG7gzzgJuVUTeFDzIELrA6659gZyJqic/+9Y9JqWvnmAuCIsxsvtqrpPbEGj9xvldQ6yRkBvZJYUSMA5dZc/LtlxYDTmTsutO/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500401; c=relaxed/simple;
	bh=ZExI+57O0zbDnRE+F0agz7VJP6zV/CMKBCosJpqOa0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j1gWO7CYeayg/S7SFDjUCqlSyhEKP49ztqkmv5FU03EPXHvJ2npT8bq5tWHgBjC9V6G/uK6Zulm1fT/iOdBT2DyrbFzIU8Lk9+hbFRmYVPqBmPQ5dY4rj+MVfkLeaiuceHrNnY8o/IyOdDNVo6ndrxuwbTGWn8XGSbb5jRtXog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VtpFY4zM8z4f3jsq;
	Tue,  4 Jun 2024 19:26:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4BF6C1A0874;
	Tue,  4 Jun 2024 19:26:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAXKwTp+V5mJkItOg--.61165S4;
	Tue, 04 Jun 2024 19:26:34 +0800 (CST)
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
Subject: [PATCH RFC 0/2] NFSv4: set sb_flags to second superblock
Date: Tue,  4 Jun 2024 19:26:34 +0800
Message-Id: <20240604112636.236517-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXKwTp+V5mJkItOg--.61165S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr15KrWfZr4UXr1xJr1kKrg_yoWxCrg_J3
	97XF48ArWxXry2kr4fCwn7trWxK3yfCF13XryftryUXryDZFyYk3WDAry8uFs3WF4ftr1f
	CF1jkrn0vr1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ6p
	PUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

Added sb_flags parameter to d_automount callback function and
fs_context_for_submount().
NFSv4 uses this parameter to set the second superblock.

Li Lingfeng (2):
  fs: pass sb_flags to submount
  NFSv4: set sb_flags to second superblock

 fs/afs/internal.h          | 2 +-
 fs/afs/mntpt.c             | 4 ++--
 fs/autofs/root.c           | 4 ++--
 fs/debugfs/inode.c         | 2 +-
 fs/fs_context.c            | 5 +++--
 fs/fuse/dir.c              | 4 ++--
 fs/namei.c                 | 3 ++-
 fs/nfs/internal.h          | 2 +-
 fs/nfs/namespace.c         | 4 ++--
 fs/smb/client/cifsfs.h     | 2 +-
 fs/smb/client/namespace.c  | 2 +-
 include/linux/dcache.h     | 2 +-
 include/linux/fs_context.h | 3 ++-
 13 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.39.2


