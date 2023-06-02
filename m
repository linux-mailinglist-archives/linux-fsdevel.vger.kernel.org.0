Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA372000D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjFBLHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjFBLH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:07:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21200E44
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 04:07:02 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230602110658euoutp02b726e5c9572055b16390d652e475b7cd~k0t_rZL8g2929029290euoutp02y
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 11:06:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230602110658euoutp02b726e5c9572055b16390d652e475b7cd~k0t_rZL8g2929029290euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685704018;
        bh=BhjlbE3l65EDbxXPKpYH+/IItCuSaglkyGpoc2fZJys=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=X0LTpbuqcSvbiXMG8CGVd2hMCiFANmN0MeNr9nHqf5XoJm0XPowTlO9Q39fGZsCww
         VYNpi/yndgc1369Xeb/TxQjIua+Zz5/gD72Hwb0UpzYmcH3UCVX7WF/P+iAQwScyo5
         4hY8AAhHhkMuo17hdYwUhg74s6lqbCIm7csNdLy0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602110658eucas1p27ccf28cedfee77b724984314dfce3c77~k0t_jdLpI2052120521eucas1p2d;
        Fri,  2 Jun 2023 11:06:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 97.77.11320.25DC9746; Fri,  2
        Jun 2023 12:06:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230602110658eucas1p27d31eeac2417f9e19f8d4b6de012209b~k0t_KGxtF2052220522eucas1p2z;
        Fri,  2 Jun 2023 11:06:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602110658eusmtrp19add2e18ca5bb2a26ee0cbd401c5a237~k0t_JjZpq2194821948eusmtrp12;
        Fri,  2 Jun 2023 11:06:58 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-9a-6479cd527b71
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.B9.10549.15DC9746; Fri,  2
        Jun 2023 12:06:57 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230602110657eusmtip2922d74715e738263fbe99c2d1cb968c1~k0t9_p76L0244502445eusmtip27;
        Fri,  2 Jun 2023 11:06:57 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 12:06:57 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 8/8] sysctl: replace child with a flags var
Date:   Fri, 2 Jun 2023 13:06:38 +0200
Message-ID: <20230602110638.789426-9-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602110638.789426-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djPc7pBZytTDCbdELfYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DKeP5oEnPBUrOKJzevMzcw
        PtXpYuTkkBAwkbi2+AdzFyMXh5DACkaJ/QvWMEE4XxglDk7pZ4dwPjNKdE6ZwgzTcrxpHQtE
        YjmjxInFG5ngqn6v64FytjBKvGrbyQLSwiagI3H+zR2wdhEBcYkTpzczghQxC0xglOhb9wus
        SFjAWqL77xJGEJtFQEXi8rz5bCA2r4CNxI2Dx6F2y0u0XZ8OVsMpYCtx6PQZqBpBiZMzn4DN
        YQaqad46mxnClpA4+OIFVK+yxIR1v1kh7FqJU1tuMUHYBzgktk8Ph7BdJNb92QxVIyzx6vgW
        dghbRuL05B6wnyUEJgOD6d8HdghnNaPEssavUJOsJVquPIHqcJTo790FtJkDyOaTuPFWEOIg
        PolJ26ZDhXklOtqEJjCqzELywiwkL8xC8sICRuZVjOKppcW56anFRnmp5XrFibnFpXnpesn5
        uZsYgYnj9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRFeobDyFCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1MOy7cush8WI87YYdC45XLBsV85Z77eOuZlCNF
        uLJml7nqmdfr/fk8e02/e/LZVKMrV2w4NsXeFl+w3mzb+49S+zlDogUZ68rcFxyZJ5TxxCn7
        6ow9VrLFZjK71pz7KKXbuuZ54cWPeRtOa1757bj1b5n/ltlSvvUBxl2u4e9rT0bNa05T6VvB
        pn0xfKqPimlrQrKYebzaW7vDbSVpESelRLaJ7/Lb9J5bYIX4wn8VqT77zX+8c1JWdt4Qu6eI
        xWXpPYNFifp7jv7/VN2fNHF+27O/zf9ndX8VNeNJ3P6n6CtDocc0lvRd4bwzlkycslssfsrs
        lZL7QpcbG11cJzBDyZ97k6kir7jEQYfqN15KLMUZiYZazEXFiQCl5pPziwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7qBZytTDK4ftLHYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLeP5oEnPBUrOKJzevMzcwPtXpYuTkkBAwkTjetI6li5GL
        Q0hgKaNEx5EfLBAJGYmNX66yQtjCEn+udbFBFH1klLgxeSYThLOFUeLk0tXMIFVsAjoS59/c
        AbNFBMQlTpzezAhSxCwwgVGib90vsLHCAtYS3X+XMILYLAIqEpfnzWcDsXkFbCRuHDzODLFO
        XqLt+nSwGk4BW4lDp8+A1QgB1aw/c4Edol5Q4uTMJ2AzmYHqm7fOZoawJSQOvngBNUdZYsK6
        31Av1Ep8/vuMcQKjyCwk7bOQtM9C0r6AkXkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYFRt
        O/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIrFFaeIsSbklhZlVqUH19UmpNafIjRFOjPicxSosn5
        wLjOK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpginw5ye355S9L
        uGIrg1zeNGxcsvXd9HMnnssv3H/lvMb0+25NC+qWTnlm/ibnk4tR4YokyTc8HH0Z0dryZX97
        eUxWPtWdx8T8nOOL3qevLZ+8zmdutvZf+fBszJLWn01PHkY/ePQ86quTZ9Zzbd4TZ1mlTmxb
        IvB88ksTN+WfH9e2VDGszSjfFZ7ZwL8p6u7e7N7dM2vefrvdVm3fE/9+Web7+cddz4nFB/6x
        n728oJ/Drzdqe98sHb5vOxLcLHmfbLr8tcaH/YzSRo+rNondu5p0ZbYLunrd57/pOq9+6qNk
        fl2VTon8Dc84WWapB86qKZB8uNGwvFzebY7TLY/g4/MqE4qmHPup91QltD4gQomlOCPRUIu5
        qDgRABcI0OAzAwAA
X-CMS-MailID: 20230602110658eucas1p27d31eeac2417f9e19f8d4b6de012209b
X-Msg-Generator: CA
X-RootMTR: 20230602110658eucas1p27d31eeac2417f9e19f8d4b6de012209b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110658eucas1p27d31eeac2417f9e19f8d4b6de012209b
References: <20230602110638.789426-1-j.granados@samsung.com>
        <CGME20230602110658eucas1p27d31eeac2417f9e19f8d4b6de012209b@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the effort to remove the empty element at the end of
ctl_table structs. "child" was a deprecated elem in this struct and was
being used to differentiate between two types of ctl_tables: "normal"
and "permanently emtpy".

What changed?:
* Replace "child" with a u8 "flag" variable and use it to differentiate
  between types by refactoring the permanently empty helper functions.
* Remove the "empty child" check from sysctl_check_table
* Remove count_subheaders function as there is no longer a need to
  calculate how many headers there are for every child
* Remove the recursive call to unregister_sysctl_table as there is no
  need to traverse down the child tree any longer
* Add a new SYSCTL_PERM_EMPTY_DIR binary flag
* Remove the last remanence of child from partport/procfs.c

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/parport/procfs.c |  1 -
 fs/proc/proc_sysctl.c    | 81 +++++++++-------------------------------
 include/linux/sysctl.h   |  4 +-
 3 files changed, 20 insertions(+), 66 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 0f2d2e1ee28e..4e5b972c3e26 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -387,7 +387,6 @@ parport_device_sysctl_template = {
 			.data		= NULL,
 			.maxlen		= 0,
 			.mode		= 0555,
-			.child		= NULL
 		},
 		{}
 	}
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 07804097f997..a180bc952397 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -29,9 +29,8 @@ static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
 /* Support for permanently empty directories */
-
 struct ctl_table sysctl_mount_point[] = {
-	{ }
+	{.flags = SYSCTL_PERM_EMPTY_DIR }
 };
 
 /**
@@ -48,21 +47,14 @@ struct ctl_table_header *register_sysctl_mount_point(const char *path)
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
-static bool is_empty_dir(struct ctl_table_header *head)
-{
-	return head->ctl_table[0].child == sysctl_mount_point;
-}
-
-static void set_empty_dir(struct ctl_dir *dir)
-{
-	dir->header.ctl_table[0].child = sysctl_mount_point;
-}
-
-static void clear_empty_dir(struct ctl_dir *dir)
-
-{
-	dir->header.ctl_table[0].child = NULL;
-}
+#define sysctl_is_perm_empty_ctl_table(tptr)		\
+	(tptr[0].flags & SYSCTL_PERM_EMPTY_DIR)
+#define sysctl_is_perm_empty_ctl_header(hptr)		\
+	(sysctl_is_perm_empty_ctl_table(hptr->ctl_table))
+#define sysctl_set_perm_empty_ctl_header(hptr)		\
+	(hptr->ctl_table[0].flags |= SYSCTL_PERM_EMPTY_DIR)
+#define sysctl_clear_perm_empty_ctl_header(hptr)	\
+	(hptr->ctl_table[0].flags &= ~SYSCTL_PERM_EMPTY_DIR)
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll)
 {
@@ -230,20 +222,22 @@ static void erase_header(struct ctl_table_header *head)
 static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 {
 	struct ctl_table *entry;
+	struct ctl_table_header *dir_h = &dir->header;
 	int err;
 
+
 	/* Is this a permanently empty directory? */
-	if (is_empty_dir(&dir->header))
+	if (sysctl_is_perm_empty_ctl_header(dir_h))
 		return -EROFS;
 
 	/* Am I creating a permanently empty directory? */
-	if (header->ctl_table == sysctl_mount_point) {
+	if (sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
-		set_empty_dir(dir);
+		sysctl_set_perm_empty_ctl_header(dir_h);
 	}
 
-	dir->header.nreg++;
+	dir_h->nreg++;
 	header->parent = dir;
 	err = insert_links(header);
 	if (err)
@@ -259,9 +253,9 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	put_links(header);
 fail_links:
 	if (header->ctl_table == sysctl_mount_point)
-		clear_empty_dir(dir);
+		sysctl_clear_perm_empty_ctl_header(dir_h);
 	header->parent = NULL;
-	drop_sysctl_table(&dir->header);
+	drop_sysctl_table(dir_h);
 	return err;
 }
 
@@ -479,7 +473,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 		inode->i_mode |= S_IFDIR;
 		inode->i_op = &proc_sys_dir_operations;
 		inode->i_fop = &proc_sys_dir_file_operations;
-		if (is_empty_dir(head))
+		if (sysctl_is_perm_empty_ctl_header(head))
 			make_empty_dir_inode(inode);
 	}
 
@@ -1136,9 +1130,6 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 	struct ctl_table *entry;
 	int err = 0;
 	list_for_each_table_entry(entry, table) {
-		if (entry->child)
-			err |= sysctl_err(path, entry, "Not a file");
-
 		if ((entry->proc_handler == proc_dostring) ||
 		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
@@ -1465,25 +1456,6 @@ void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 	kmemleak_not_leak(hdr);
 }
 
-static int count_subheaders(struct ctl_table *table)
-{
-	int has_files = 0;
-	int nr_subheaders = 0;
-	struct ctl_table *entry;
-
-	/* special case: no directory and empty directory */
-	if (!table || !table->procname)
-		return 1;
-
-	list_for_each_table_entry(entry, table) {
-		if (entry->child)
-			nr_subheaders += count_subheaders(entry->child);
-		else
-			has_files = 1;
-	}
-	return nr_subheaders + has_files;
-}
-
 static void put_links(struct ctl_table_header *header)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
@@ -1546,28 +1518,11 @@ static void drop_sysctl_table(struct ctl_table_header *header)
  */
 void unregister_sysctl_table(struct ctl_table_header * header)
 {
-	int nr_subheaders;
 	might_sleep();
 
 	if (header == NULL)
 		return;
 
-	nr_subheaders = count_subheaders(header->ctl_table_arg);
-	if (unlikely(nr_subheaders > 1)) {
-		struct ctl_table_header **subheaders;
-		int i;
-
-		subheaders = (struct ctl_table_header **)(header + 1);
-		for (i = nr_subheaders -1; i >= 0; i--) {
-			struct ctl_table_header *subh = subheaders[i];
-			struct ctl_table *table = subh->ctl_table_arg;
-			unregister_sysctl_table(subh);
-			kfree(table);
-		}
-		kfree(header);
-		return;
-	}
-
 	spin_lock(&sysctl_lock);
 	drop_sysctl_table(header);
 	spin_unlock(&sysctl_lock);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 653b66c762b1..0cd79a7f1d3e 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -137,7 +137,7 @@ struct ctl_table {
 	void *data;
 	int maxlen;
 	umode_t mode;
-	struct ctl_table *child;	/* Deprecated */
+	u8 flags;
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
 	void *extra1;
@@ -229,7 +229,7 @@ extern int unaligned_enabled;
 extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
 
-extern struct ctl_table sysctl_mount_point[];
+#define SYSCTL_PERM_EMPTY_DIR	(1 << 0)
 
 #else /* CONFIG_SYSCTL */
 
-- 
2.30.2

