Return-Path: <linux-fsdevel+bounces-54274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8720AAFCF95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE69017069F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7702D9ECD;
	Tue,  8 Jul 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rad5TNkI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DB17DFE7
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989555; cv=none; b=AGfR8Z+CTUfueEEdMZYgSH9FI55lLNpnR4OY9x9dZAUkAKEONG0O3Ncap4GkxX20ycCa2PzTXTJIGWMJBdf8PI/o5Qv8K0EF9irj9hZdfZYlpwXVwYZtNNw6RwQmq/xCaVLlaeGU0K0OICkKmXc3njq3kJWvyXpvnwBmgQrZItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989555; c=relaxed/simple;
	bh=KVzkriYFcvDBA02Kho+N+/ARUJ5FSOZa48/gA51afA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mhvb6aVMHUsuual0B7wsuxuSgAZbCTTYEM2A6wgiUX5tMNlWHYQ/kq0FCN44VYl0XTZ/7XQJVhcbLeEi7Fo5UHUACEYpZB1XWBUR0NbP5bso53rpR21hyjRy8P6uaKTdh2dwBWm3VFdwHBZ5gQ2TnjMOWoMprPsLRNX7z4OnKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rad5TNkI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568870wI001507;
	Tue, 8 Jul 2025 15:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1JI2PYmyw553aCAqVq7NEaFXkIkRMZvGUQ5VSMWzM
	QI=; b=rad5TNkImvkydFqnR4fpTJtb4PvG4aSts+bn0+MIr/ZWpsopH3muWpKhb
	lwJDy8iCW1B5pan8jV2uifx4tXvPAJPNv1ZhkiMnRwqezZeJ6Plws5Lcb8U3EcT2
	B8//EO/fw4KXiMRtITsShywUQqYCbrOT80gZPq0QkbCfR6nXoJaJcOsZeF9MIEZf
	xpAZfU0YHX5CInq0SwUYrARp2B6yOmzJjFzhTxGCLcj67lvtzUd22Q0VVf+4huAA
	i1tfymL5zwoYyrTcj9sxZ5Si88pwkw63KGRqOsx2GzfzC+ZrexAkummmf8cHbD/X
	y5Sic8DuB17LKWjw/rrpm1Y+cPymA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjr0bhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 15:45:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 568EBRm6021566;
	Tue, 8 Jul 2025 15:45:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectkugm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 15:45:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 568Fjjeh59113852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 15:45:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CC4720043;
	Tue,  8 Jul 2025 15:45:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65F4720040;
	Tue,  8 Jul 2025 15:45:45 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Jul 2025 15:45:45 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/1] fs: Fix use of incorrect flags with splice() on pipe from/to memfd
Date: Tue,  8 Jul 2025 17:43:52 +0200
Message-ID: <20250708154352.3913726-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686d3d2c cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=KtyGq2lsQ3Ai_R4cFgEA:9
X-Proofpoint-ORIG-GUID: XnGzfS5DcVLYgms6EuKc5npvPmwhXa9v
X-Proofpoint-GUID: XnGzfS5DcVLYgms6EuKc5npvPmwhXa9v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyOSBTYWx0ZWRfXz+8BDq/6xTq5 dVnwwDn8AKaNb/nTFJqcdxiUKInQdsA+1TwY0IdLd13xusOsbDXPk07hyIQlRZB/u8HGbzHsO8E Nl5iNZkOp2G/l9HcODRHIl2AV8GnFzXXZjMGRbzzuyDbRsNU5hmKHky5atabPpUeuhdzdo4h6D6
 NNUpXEAecWKQwR3nmp6V5uQm7+IsBKOqOF51Q/GNentxFsAuHMixuYLskIi8GHGjbzx6gUaVFVN 0PwKnWMuewoCsWBBhx0D3gRmI0ua3AbPzd6xDyK9tI09OOGehfVK0Vqm98/yx+nRmNPn+fnxHq6 N/83VBNAY6mAeOXCr9xF3SG9BofjP3DulpXuchuJS4H5zCdPvpKEgOdBjvAS1H1D8BJoy6FDs8c
 z7fYUZuG9Z26BCyogsvlGAhOBcalw/nJbXzjHh9gPTd+hkJ5hD6EJqGCs37XfX2uzZttfJ58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080129

Fix use of incorrect flags when using splice() with pipe ends and
memfd secret. Ensure that pipe and memfd file descriptors are properly
recognized and handled to prevent unintended EACCES errors in scenarios
where EBADF or EINVAL are expected.

This resolves failures in LTP's splice07 test case:

    ./ltp-bin/testcases/bin/splice07
    [skip]
    splice07.c:54: TFAIL: splice() on pipe read end -> memfd secret expected EBADF, EINVAL: EACCES (13)
    [skip]
    splice07.c:54: TFAIL: splice() on memfd secret -> pipe write end expected EBADF, EINVAL: EACCES (13)
    [skip]

Fixes: cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 fs/anon_inodes.c   | 11 +++++++----
 include/linux/fs.h |  2 +-
 mm/secretmem.c     |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 1d847a939f29..f4eade76273b 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -104,6 +104,7 @@ static struct file_system_type anon_inode_fs_type = {
  * @name:	[in]	Name of the class of the newfile (e.g., "secretmem")
  * @context_inode:
  *		[in]	Optional parent inode for security inheritance
+ * @secmem	[in]	Indicates wheather the inode should be threaded as secretmem
  *
  * The function ensures proper security initialization through the LSM hook
  * security_inode_init_security_anon().
@@ -111,7 +112,7 @@ static struct file_system_type anon_inode_fs_type = {
  * Return:	Pointer to new inode on success, ERR_PTR on failure.
  */
 struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
-					   const struct inode *context_inode)
+					   const struct inode *context_inode, bool secmem)
 {
 	struct inode *inode;
 	int error;
@@ -119,8 +120,10 @@ struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *n
 	inode = alloc_anon_inode(sb);
 	if (IS_ERR(inode))
 		return inode;
-	inode->i_flags &= ~S_PRIVATE;
-	inode->i_op = &anon_inode_operations;
+	if (!secmem) {
+		inode->i_flags &= ~S_PRIVATE;
+		inode->i_op = &anon_inode_operations;
+	}
 	error =	security_inode_init_security_anon(inode, &QSTR(name),
 						  context_inode);
 	if (error) {
@@ -145,7 +148,7 @@ static struct file *__anon_inode_getfile(const char *name,

 	if (make_inode) {
 		inode =	anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
-						     name, context_inode);
+						     name, context_inode, false);
 		if (IS_ERR(inode)) {
 			file = ERR_CAST(inode);
 			goto err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 040c0036320f..50a32bee366e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3609,7 +3609,7 @@ extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
 struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
-					   const struct inode *context_inode);
+					   const struct inode *context_inode, bool secmem);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 9a11a38a6770..d28e1caa8847 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -196,7 +196,7 @@ static struct file *secretmem_file_create(unsigned long flags)
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";

-	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL);
+	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL, true);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);

--
2.48.1


