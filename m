Return-Path: <linux-fsdevel+bounces-49207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36986AB936B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 03:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDAE1BC4011
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2320214A6A;
	Fri, 16 May 2025 01:06:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9472E628;
	Fri, 16 May 2025 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357582; cv=none; b=thLBhroi7Xvy4hEMuXJFlJmrvynSUmRcJaZEP8P//zzlpxgjFo26Ukyt/DlbNfIdGeI8/IBag6uzgbmMb1sR2k191U3Egq5BVK6WL2W3VMwQYNk92rdCbNMZTfKXdxWQeskDMV/0E1hat+ZBYFEsPbqM2zPUhGCTS50DaArVhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357582; c=relaxed/simple;
	bh=WZpnUn6JxkzkitCglNQnGzpqsVhsQeUN7lv4G3Mp424=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HJ79owodVD3oQtU347oPEfStYRdAmgmB7mbOjla5fNQm45JEBzUxSwGT5HZC306xXZWhe71rNGvSIarq9SSA8uY60cOTFYSMFVzfA11cEFFPYlbVleNtna8dqz3TAikwdA1UVmPQC29jaY7rRakG/rvZ/raW7pIqpMIPDj6KnUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G0A3U8008340;
	Fri, 16 May 2025 01:06:07 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbcjuhga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 May 2025 01:06:07 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 15 May 2025 18:06:02 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 15 May 2025 18:05:51 -0700
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jianqi.ren.cn@windriver.com>, <jack@suse.cz>, <amir73il@gmail.com>,
        <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>,
        <dima@arista.com>, <brauner@kernel.org>
Subject: [PATCH 5.15.y] fs: relax assertions on failure to encode file handles
Date: Fri, 16 May 2025 09:05:53 +0800
Message-ID: <20250516010553.1344365-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rGU5BXzlacFutxaqbSCQalgggnHl3nTl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDAwOCBTYWx0ZWRfX4COqIejjzbbk VOHv9dpNFZ+n4aCz9AwTGllGIrqtxVe903b4LaPjcPpSsO52NhvI0oXU23qUFoxIyNSn7e+iEo6 9xG06ar2OjkQA3GVXg1CyAmb5/BvJxh/TntvxarotKofvVX0ntajaAhiI97Mi4srXNDk5K3+6oZ
 +RUlhSo8f+JJj5aW/2096JOb2DjsoAnK4RdNOUcZP2DnccUh6RGD2GmyKqNPvWXQuTSXTk/Ih/r K1wFQM0CvxC+hZRZKs97BQj9D9LNoGRJYERlNeydcfCMPXuFyzhrMr/a6BO42mLd2UM8PW+8CSe I3aC9M7vkHvnv+jIZpIm8SW+RPJWA+EAgKG3urBaBYFAjssVaQzSG89uMUGrxbEjMQaZxxqmN9J
 hxQTlGrltQ5Suwb+HYfm1NPEUB91ZV1QkygDBFQ4itcxBb2ptQsNl7UwQ2c32Qf4pylzripj
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=68268f7f cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=n2GhSfulAAAA:8 a=t7CeM3EgAAAA:8
 a=AWMRjOQ4adq7_I6d_FkA:9 a=cQPPKAXgyycSBL8etih5:22 a=9NqWk_7B-uqI6kdQTXIl:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: rGU5BXzlacFutxaqbSCQalgggnHl3nTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_11,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505160008

From: Amir Goldstein <amir73il@gmail.com>

commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.

Encoding file handles is usually performed by a filesystem >encode_fh()
method that may fail for various reasons.

The legacy users of exportfs_encode_fh(), namely, nfsd and
name_to_handle_at(2) syscall are ready to cope with the possibility
of failure to encode a file handle.

There are a few other users of exportfs_encode_{fh,fid}() that
currently have a WARN_ON() assertion when ->encode_fh() fails.
Relax those assertions because they are wrong.

The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
encoding non-decodable file handles") in v6.6 as the regressing commit,
but this is not accurate.

The aforementioned commit only increases the chances of the assertion
and allows triggering the assertion with the reproducer using overlayfs,
inotify and drop_caches.

Triggering this assertion was always possible with other filesystems and
other reasons of ->encode_fh() failures and more particularly, it was
also possible with the exact same reproducer using overlayfs that is
mounted with options index=on,nfs_export=on also on kernels < v6.6.
Therefore, I am not listing the aforementioned commit as a Fixes commit.

Backport hint: this patch will have a trivial conflict applying to
v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.

Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
Reported-by: Dmitry Safonov <dima@arista.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
[Minor conflict resolved due to code context change.]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 fs/notify/fdinfo.c     | 4 +---
 fs/overlayfs/copy_up.c | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 55081ae3a6ec..dd5bc6ffae85 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -51,10 +51,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	size = f.handle.handle_bytes >> 2;
 
 	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
-	if ((ret == FILEID_INVALID) || (ret < 0)) {
-		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
+	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
-	}
 
 	f.handle.handle_type = ret;
 	f.handle.handle_bytes = size * sizeof(u32);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 5fc32483afed..c5d8ad610a37 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -366,9 +366,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 	buflen = (dwords << 2);
 
 	err = -EIO;
-	if (WARN_ON(fh_type < 0) ||
-	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
-	    WARN_ON(fh_type == FILEID_INVALID))
+	if (fh_type < 0 || fh_type == FILEID_INVALID ||
+	    WARN_ON(buflen > MAX_HANDLE_SZ))
 		goto out_err;
 
 	fh->fb.version = OVL_FH_VERSION;
-- 
2.34.1


