Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381D568BF61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 15:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBFOEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 09:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjBFOEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:04:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E7F26581;
        Mon,  6 Feb 2023 06:03:50 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqLc2014770;
        Mon, 6 Feb 2023 14:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Y3HrFUOexQ6VH5dv344tNM6Q5Y8CiOzvHA8ouQNFU0I=;
 b=GnmHwBDA24UkuhIZ8kZpKc7Lj1G/dNnbGOm2Y1XDkVIV1nIaazXIzVkRQvzvavaqCMup
 L5pnVCEaa3t7WdMrFegCc6oR7Lf8Bd4kG6e5vTUvmzBxxDci+z8Gm1wK7VrSuk4JFqzc
 Vy+An3f1kPKMUnXzuSqwyAdbvSpWvR9vbLmu9xjn5fwwEuCQnRrOdox2siHcFHbqhdiC
 XpgbLnj5pZhXjlybxAdsJiRbqgkOuB0/1LhZsn6fvn2DVxD4mf2dX/z2v6rmYY8ZBOFG
 U6r2aOlFJbXrz/oFcMf/puTwNZmHIPVrW4BUO3AfQlcdOuengRcQiGVhKf/xYks3laJL MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1gkk408-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:27 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DrS09026265;
        Mon, 6 Feb 2023 14:03:26 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1gkk3xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:26 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CAqhx017625;
        Mon, 6 Feb 2023 14:03:25 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3nhf07dq4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3Noj8651404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A32D75805D;
        Mon,  6 Feb 2023 14:03:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AF2658058;
        Mon,  6 Feb 2023 14:03:21 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:21 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Denis Semakin <denis.semakin@huawei.com>
Subject: [PATCH v15 11/26] ima: Define mac_admin_ns_capable() as a wrapper for ns_capable()
Date:   Mon,  6 Feb 2023 09:02:38 -0500
Message-Id: <20230206140253.3755945-12-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OCOKYBV_Jf_BVibSB-tOhiL8KIyApJvF
X-Proofpoint-GUID: EoywHmqD2FWtZtFc-RuWF-JZWTW1Hngd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define mac_admin_ns_capable() as a wrapper for the combined ns_capable()
checks on CAP_MAC_ADMIN and CAP_SYS_ADMIN in a user namespace. Return
true on the check if either capability or both are available.

Use mac_admin_ns_capable() in place of capable(SYS_ADMIN). This will allow
an IMA namespace to read the policy with only CAP_MAC_ADMIN, which has
less privileges than CAP_SYS_ADMIN.

Since CAP_MAC_ADMIN is an additional capability added to an existing gate
avoid auditing in case it is not set.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v13:
  - implemented file_sb_user_ns(const struct file *); const is needed so it
    can be called with seq_file's 'const struct file *file'

v11:
  - use ns_capable_noaudit for CAP_MAC_ADMIN to avoid auditing in this case
---
 include/linux/capability.h      | 6 ++++++
 include/linux/fs.h              | 5 +++++
 security/integrity/ima/ima.h    | 6 ++++++
 security/integrity/ima/ima_fs.c | 5 ++++-
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..dc3e1230b365 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool mac_admin_ns_capable(struct user_namespace *ns)
+{
+	return ns_capable_noaudit(ns, CAP_MAC_ADMIN) ||
+		ns_capable(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 			   const struct dentry *dentry,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..4662efed3171 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2730,6 +2730,11 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
 	return mnt_user_ns(file->f_path.mnt);
 }
 
+static inline struct user_namespace *file_sb_user_ns(const struct file *file)
+{
+	return i_user_ns(file_inode(file));
+}
+
 static inline struct mnt_idmap *file_mnt_idmap(struct file *file)
 {
 	return mnt_idmap(file->f_path.mnt);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4de8ec776611..69f95ed0b8c6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -492,4 +492,10 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #define	POLICY_FILE_FLAGS	S_IWUSR
 #endif /* CONFIG_IMA_READ_POLICY */
 
+static inline
+struct user_namespace *ima_user_ns_from_file(const struct file *filp)
+{
+	return file_sb_user_ns(filp);
+}
+
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 89d3113ceda1..c41aa61b7393 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -377,6 +377,9 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
+#ifdef CONFIG_IMA_READ_POLICY
+	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
+#endif
 	struct ima_namespace *ns = &init_ima_ns;
 
 	if (!(filp->f_flags & O_WRONLY)) {
@@ -385,7 +388,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!capable(CAP_SYS_ADMIN))
+		if (!mac_admin_ns_capable(user_ns))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
-- 
2.37.3

