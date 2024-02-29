Return-Path: <linux-fsdevel+bounces-13203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90F386D128
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 18:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8031C20B72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98312757EF;
	Thu, 29 Feb 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hVW2ydcj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8770AEF
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229209; cv=none; b=e0B89tAjhnrhEF728x1S2pFFSS0dZ+ejgBqKKAJHO3rdfme2Ch4hMGt3vBR/eh2+PCzRY2FH5BzlxDTaN8arbUNbTMOnKfr/SKUlWLhteR6fVYc/gLbYo+U8BAjl3Y88ZMhbu/dOdTYuXM0ZLr9mSC6LrS8YHNGS39ZFkh1TC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229209; c=relaxed/simple;
	bh=jOIe08W4YaLqbo4X/2OKlnmLamFrWQtOjh6Pu2GtBRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KUuXg7TbSbz626OlfdEHON3+iIxfHCQvuOrfjb6DTrzxUd0nchNfu3VLJEK73Qm5La9qYSTYmyghpW6CzZf/BywabBiHSOqGW4JJfa8a6upxkwlXAyYMWBF845AgIUMjnsywDoxHyYrCC8sClCYBKljA4uZRI6WD0V1+dS/smK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hVW2ydcj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41THqKhl010993;
	Thu, 29 Feb 2024 17:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=E4UJ8yaKzXNqCIlNVz+jay0nuZFsWnm/q8thL43VsjQ=;
 b=hVW2ydcjWqA+s5b2bTly/h/YwTjpJ2PBirfqzYz68oA5cmE5IknXwx4oznXqjU3Gx811
 c6h2xlCqQo6VnScs4JuZen59Qm03NJEEPhZS9FWLsaf3pYISD2fc6fHka7FaoPdJxZS1
 yLwW/whgFVbOz/zf4ZBVlvAoJNKylmAKsgIHLttwZOKi6z35HiwfyTY9FWxzE05ZI4Mg
 erPoFvJZocDzEs9q94/oMLNJbgBn7lN+u/la0pvebQ3tpQZmmbIiHFWSpx+rDP0aoxyD
 O8roDyXamlz8ozQQB17nflVJbiT7oI2e8FaJlzLePXtwQS/Y3fmBjReNOVBTxiu7+WkF jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjxpyr0na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 17:53:22 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41THWPbW007937;
	Thu, 29 Feb 2024 17:45:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjxdhre9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 17:45:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41THd87e023910;
	Thu, 29 Feb 2024 17:41:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0kps33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 17:41:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41THfjli42468000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 17:41:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E1AE20040;
	Thu, 29 Feb 2024 17:41:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 668E220043;
	Thu, 29 Feb 2024 17:41:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 17:41:45 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: jack@suse.cz
Cc: amir73il@gmail.com, repnop@google.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: move path permission and security check
Date: Thu, 29 Feb 2024 18:41:45 +0100
Message-Id: <20240229174145.3405638-1-meted@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2IK5dUFocWAupmL4Yp_EnhuHl6Gt9SUx
X-Proofpoint-ORIG-GUID: LC4RpRogoppT9Qj6M57U-cgBl0Zz3EeE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_04,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=680
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290138

In current state do_fanotify_mark() does path permission and security
checking before doing the event configuration checks. In the case
where user configures mount and sb marks with kernel internal pseudo
fs, security_path_notify() yields an EACESS and causes an earlier
exit. Instead, this particular case should have been handled by
fanotify_events_supported() and exited with an EINVAL.
Move path perm and security checks under the event validation to
prevent this from happening.
Simple reproducer;

	fan_d = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY);
	pipe2(pipes, O_CLOEXEC);
        fanotify_mark(fan_d,
		      FAN_MARK_ADD |
		      FAN_MARK_MOUNT,
		      FAN_ACCESS,
		      pipes[0],
		      NULL);
	// expected: EINVAL (22), produces: EACCES (13)
        printf("mark errno: %d\n", errno);

Another reproducer;
ltp/testcases/kernel/syscalls/fanotify/fanotify14

Fixes: 69562eb0bd3e ("fanotify: disallow mount/sb marks on kernel internal pseudo fs")

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 fs/notify/fanotify/fanotify_user.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index fbdc63cc10d9..14121ad0e10d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1015,7 +1015,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 			fdput(f);
 			goto out;
 		}
-
+		ret = 0;
 		*path = f.file->f_path;
 		path_get(path);
 		fdput(f);
@@ -1028,21 +1028,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 			lookup_flags |= LOOKUP_DIRECTORY;
 
 		ret = user_path_at(dfd, filename, lookup_flags, path);
-		if (ret)
-			goto out;
 	}
-
-	/* you can only watch an inode if you have read permissions on it */
-	ret = path_permission(path, MAY_READ);
-	if (ret) {
-		path_put(path);
-		goto out;
-	}
-
-	ret = security_path_notify(path, mask, obj_type);
-	if (ret)
-		path_put(path);
-
 out:
 	return ret;
 }
@@ -1894,6 +1880,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		if (ret)
 			goto path_put_and_out;
 	}
+	/* you can only watch an inode if you have read permissions on it */
+	ret = path_permission(&path, MAY_READ);
+	if (ret)
+		goto path_put_and_out;
+
+	ret = security_path_notify(&path, mask, obj_type);
+	if (ret)
+		goto path_put_and_out;
 
 	if (fid_mode) {
 		ret = fanotify_test_fsid(path.dentry, flags, &__fsid);
-- 
2.40.1


