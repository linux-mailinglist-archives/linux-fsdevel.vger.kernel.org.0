Return-Path: <linux-fsdevel+bounces-35623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36769D66F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 02:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320E01614E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 01:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D46DDDC;
	Sat, 23 Nov 2024 01:10:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35FF566A;
	Sat, 23 Nov 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732324233; cv=none; b=Sjqoy2vNNgFK1VMHUZxMWQKzvni5b9RbxuKbWTx4JhBi/jVjt2GPDDq2drB1eRbLpq7A5FLYOsbDhOiQG8IceiQZzB4AXXZpiO7nuBFpCN0QOqKo4zvAOwPcGekd1zaB5mPZmlmRo92ARrd25xQ8oJaNSPEVANwxaHa00JLmqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732324233; c=relaxed/simple;
	bh=JWd94+0NPNCGRHqkHrmvbsO8rPGqIVmYVcYWZUWqdwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aT8g/z9ukI0skKZd9Ge8xuQLrImywEHPGAX/lfFHfqKG5TQ41xOYjFTeC1cIjQhvmF4Xtwwqmys/B3zRpRhv6+y5V+UR9+8o/sONNZhLvNSAZh/qAH7oZUI7SHAkgzaBLLRtC00g9NkqmYxieiwhPjqyjpYRu0PaGuLREAijKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AN0jePm026285;
	Sat, 23 Nov 2024 01:10:01 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc8fg95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 23 Nov 2024 01:10:00 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 22 Nov 2024 17:09:59 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 22 Nov 2024 17:09:56 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <lizhi.xu@windriver.com>
CC: <viro@zeniv.linux.org.uk>, <almaz.alexandrovich@paragon-software.com>,
        <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ntfs3@lists.linux.dev>,
        <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V5] fs/ntfs3: check if the inode is bad before creating symlink
Date: Sat, 23 Nov 2024 09:09:56 +0800
Message-ID: <20241123010956.1590799-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122074952.1585521-1-lizhi.xu@windriver.com>
References: <20241122074952.1585521-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iVfm6Tl1F2CcqnrP8tSOxjhCSrtwn7XM
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=67412b68 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=OEdkkgd6TnMo6Y_G:21 a=VlfZXiiP6vEA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=vpW_iYbbhX9-InLknqQA:9
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: iVfm6Tl1F2CcqnrP8tSOxjhCSrtwn7XM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_14,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=867
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411230008

syzbot reported a null-ptr-deref in pick_link. [1]

First, i_link and i_dir_seq are in the same union, they share the same memory
address, and i_dir_seq will be updated during the execution of walk_component,
which makes the value of i_link equal to i_dir_seq.

Secondly, the chmod execution failed, which resulted in setting the mode value
of file0's inode to REG when executing ntfs_bad_inode.

Third, during the execution of the link command, it sets the inode of the
hardlink file to the already bad inode of file0 by calling d_instantiate, which
ultimately leads to null-ptr-deref when performing a mount operation on the
hardlink bus because it use bad inode's i_link and its value is equal to
i_dir_seq=2. 

Note: ("file0, bus" are defined in reproducer [2])

To avoid null-ptr-deref in pick_link, when creating a hardlink, first check
whether the inode of file is already bad.

[1]
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5310 Comm: syz-executor255 Not tainted 6.12.0-rc6-syzkaller-00318-ga9cda7c0ffed #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:pick_link+0x51c/0xd50 fs/namei.c:1864
Code: c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 fc 00 e9 ff 48 8b 2b 48 85 ed 0f 84 92 00 00 00 e8 7b 36 7f ff 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 a2 05 00 00 0f b6 5d 00 bf 2f 00 00 00
RSP: 0018:ffffc9000d147998 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88804558dec8 RCX: ffff88801ec7a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff8215a35f R09: 1ffffffff203a13d
R10: dffffc0000000000 R11: fffffbfff203a13e R12: 1ffff92001a28f93
R13: ffffc9000d147af8 R14: 1ffff92001a28f5f R15: dffffc0000000000
FS:  0000555577611380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc0a595ed8 CR3: 0000000035760000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 step_into+0xca9/0x1080 fs/namei.c:1923
 lookup_last fs/namei.c:2556 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2580
 filename_lookup+0x256/0x610 fs/namei.c:2609
 user_path_at+0x3a/0x60 fs/namei.c:3016
 do_mount fs/namespace.c:3844 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x297/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4b18ad5b19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2e486c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f4b18ad5b19
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 00007f4b18b685f0 R08: 0000000000000000 R09: 00005555776124c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc2e486c70
R13: 00007ffc2e486e98 R14: 431bde82d7b634db R15: 00007f4b18b1e03b
 </TASK>

[2]
move_mount(0xffffffffffffff9c, &(0x7f00000003c0)='./file0\x00', 0xffffffffffffff9c, &(0x7f0000000400)='./file0/file0\x00', 0x140)
chmod(&(0x7f0000000080)='./file0\x00', 0x0)
link(&(0x7f0000000200)='./file0\x00', &(0x7f0000000240)='./bus\x00')
mount$overlay(0x0, &(0x7f00000000c0)='./bus\x00', 0x0, 0x0, 0x0)

Reported-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=73d8fc29ec7cba8286fa
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 --> V2: add the root cause of the i_link not set issue and imporve the check
V2 --> V3: when creating a symbolic link, first check whether the inode of file is bad.
V3 --> V4: add comments for symlink use bad inode, it is the root cause
V4 --> V5: update comments for link command, it is creating hardlink

 fs/ntfs3/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index be04d2845bb7..fefbdcf75016 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1719,6 +1719,9 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
 	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
 	struct NTFS_DE *de;
 
+	if (is_bad_inode(inode))
+		return -EIO;
+
 	/* Allocate PATH_MAX bytes. */
 	de = __getname();
 	if (!de)
-- 
2.43.0


