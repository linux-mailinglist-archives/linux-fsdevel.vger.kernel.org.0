Return-Path: <linux-fsdevel+bounces-35186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBBF9D24DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 12:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D911F22AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894D1C4A0F;
	Tue, 19 Nov 2024 11:30:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D510142E7C;
	Tue, 19 Nov 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015823; cv=none; b=C+9x55njlPYqlTnDT0DOpiDvgrxVAG+HomB2D0l9tO+R037growy3shLRmKUIwgDXGS6jnVI9adfbXsaVEcJllVfqA+2ld/47HWkN9Z1VgtXgyiblXyuuoXc9EFOOu1603Anzj9Cy/3qFoIvYkmptJJqbgd6SfJ1o3+KPn7FvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015823; c=relaxed/simple;
	bh=1lFIcRb9qoRuN9aLYUQMbGjnYMhTsgPxp1CrEUn/gHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0QETQdF4kyIBxl5F0S3aEhRwPTrianSeTFFe4+fhq2/yTWqGVpwBKdyn3a6QY0nT6+t0XkmU+Z6xVIx45E+Fhqq1XOO2PJT1IITeSjtouDcDM8Jce0Pyv6mQz9G9Kq9KJ3XDFW3egTeqKYu4S1V5N1m7yR4QLob/8oeAVljMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7p93Q006003;
	Tue, 19 Nov 2024 11:29:50 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc8avwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Nov 2024 11:29:49 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 19 Nov 2024 03:29:48 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 19 Nov 2024 03:29:46 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ntfs3@lists.linux.dev>,
        <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V2] fs: improve the check of whether i_link has been set
Date: Tue, 19 Nov 2024 19:29:45 +0800
Message-ID: <20241119112945.767118-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241116023241.GZ3387508@ZenIV>
References: <20241116023241.GZ3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FN9QB39rltRAUrdKUNEAg6XhTFkjfWQk
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=673c76ad cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=mg1Wa837EIQHRb_qIgQA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: FN9QB39rltRAUrdKUNEAg6XhTFkjfWQk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_03,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=877
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411190083

syzbot reported a null-ptr-deref in pick_link. [1]

First, i_link and i_dir_seq are in the same union, they share the same memory
address, and i_dir_seq will be updated during the execution of walk_component,
which makes the value of i_link equal to i_dir_seq.
In this case, setting i_dir_seq is triggered by move_mount, and the calltrace
is as follows:
move_mount()->
  user_path_at()->
    filename_lookup()->
      path_lookupat()->
        lookup_last()->
          walk_component()->
            __lookup_slow()->
              ntfs_lookup()->
                d_splice_alias()->
                  __d_add()->
                    end_dir_add()

In pick_link(), the simple "if (!i_link)" is used to determine whether i_link
has been set, which is not rigorous enough.

On the other hand, the mode value of the symlink inode becomes REG because
attr_set_size() fails to set the attribute and calls ntfs_bad_inode().
By confirming that the i_link pointer value is valid, the null-ptr-deref
problem in pick_link can be avoided.

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

Fixes: ad6cc4c338f4 ("finally fold get_link() into pick_link()")
Reported-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=73d8fc29ec7cba8286fa
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 --> V2: add the root cause of the i_link not set issue and imporve the check

 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4a4a22a08ac2..49bd5ac16137 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1845,7 +1845,7 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 		return ERR_PTR(error);
 
 	res = READ_ONCE(inode->i_link);
-	if (!res) {
+	if (!virt_addr_valid(res)) {
 		const char * (*get)(struct dentry *, struct inode *,
 				struct delayed_call *);
 		get = inode->i_op->get_link;
-- 
2.43.0


