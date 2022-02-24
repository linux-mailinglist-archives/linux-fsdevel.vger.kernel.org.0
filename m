Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444004C281E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 10:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiBXJd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 04:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiBXJdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:23 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EAC20DB13
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 01:32:53 -0800 (PST)
X-QQ-mid: bizesmtp88t1645695147tgwdwkrk
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 24 Feb 2022 17:32:03 +0800 (CST)
X-QQ-SSF: 01400000000000B0F000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8esjqh9jW/ic4y9x7g7V3PVFwHyCbsFjWvtnbyYVlEAO51fszt3T
        bHxSjNJkqhDKUPW3TEdys3rX/ZjRS2WriSEw7szpdmFr/wjNCZ3jy56t5N8eNio1rzwavz9
        g+NrNE0rkbkIglNhcKQPmsFNTM+I/Moj/xIV9pAImVgNztfggHlOmlPsCsIIOZSZVhkpkNL
        izzDMA51RSzItJVneHxc9/MQE6Z+LIbwQD3tSUqbIjj2t/VxU3jZiT3G/JepSwPApydef8p
        cl4EL/QX0ywPwrDkNQ+JHzuetTFGg1Qvi/emVHK++mxW5+pUkJqzmjBufyCtfjCv6vAJLzb
        KDYE1h3DWLL2Qa5JaX4/pPWb0yLeg==
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] fs/proc: optimize exactly register one ctl_table
Date:   Thu, 24 Feb 2022 17:32:01 +0800
Message-Id: <20220224093201.12440-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, sysctl is being moved to its own file. But ctl_table
is quite large(64 bytes per entry) and every array is terminated
with an empty one. This leads to thar when register exactly one
ctl_table, we've gone from 64 bytes to 128 bytes.

So, it is obviously the right thing that we need to fix.

In order to avoid compatibility problems, and to be compatible
with array terminated with an empty one and register exactly one
ctl_table, add the register_one variable in the ctl_table
structure to fix it.

When we register exactly one table, we only need to add
"table->register = true" to avoid gone from 64 bytes to 128 bytes.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 fs/proc/proc_sysctl.c  | 58 +++++++++++++++++++++++++++++++++++++++---
 include/linux/sysctl.h |  1 +
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7d9cfc730bd4..9ecd5c87e8dd 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -215,16 +215,24 @@ static void init_header(struct ctl_table_header *head,
 	INIT_HLIST_HEAD(&head->inodes);
 	if (node) {
 		struct ctl_table *entry;
-		for (entry = table; entry->procname; entry++, node++)
+		for (entry = table; entry->procname; entry++, node++) {
 			node->header = head;
+
+			if (entry->register_one)
+				break;
+		}
 	}
 }
 
 static void erase_header(struct ctl_table_header *head)
 {
 	struct ctl_table *entry;
-	for (entry = head->ctl_table; entry->procname; entry++)
+	for (entry = head->ctl_table; entry->procname; entry++) {
 		erase_entry(head, entry);
+
+		if (entry->register_one)
+			break;
+	}
 }
 
 static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
@@ -252,6 +260,9 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 		err = insert_entry(header, entry);
 		if (err)
 			goto fail;
+
+		if (entry->register_one)
+			break;
 	}
 	return 0;
 fail:
@@ -1159,6 +1170,9 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
 			err |= sysctl_err(path, table, "bogus .mode 0%o",
 				table->mode);
+
+		if (table->register_one)
+			break;
 	}
 	return err;
 }
@@ -1177,6 +1191,9 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 	for (entry = table; entry->procname; entry++) {
 		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
+
+		if (entry->register_one)
+			break;
 	}
 
 	links = kzalloc(sizeof(struct ctl_table_header) +
@@ -1199,6 +1216,9 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 		link->mode = S_IFLNK|S_IRWXUGO;
 		link->data = link_root;
 		link_name += len;
+
+		if (entry->register_one)
+			break;
 	}
 	init_header(links, dir->header.root, dir->header.set, node, link_table);
 	links->nreg = nr_entries;
@@ -1218,6 +1238,15 @@ static bool get_links(struct ctl_dir *dir,
 		link = find_entry(&head, dir, procname, strlen(procname));
 		if (!link)
 			return false;
+
+		if (entry->register_one) {
+			if (S_ISDIR(link->mode) && S_ISDIR(entry->mode))
+				break;
+			if (S_ISLNK(link->mode) && (link->data == link_root))
+				break;
+			return false;
+		}
+
 		if (S_ISDIR(link->mode) && S_ISDIR(entry->mode))
 			continue;
 		if (S_ISLNK(link->mode) && (link->data == link_root))
@@ -1230,6 +1259,8 @@ static bool get_links(struct ctl_dir *dir,
 		const char *procname = entry->procname;
 		link = find_entry(&head, dir, procname, strlen(procname));
 		head->nreg++;
+		if (entry->register_one)
+			break;
 	}
 	return true;
 }
@@ -1295,6 +1326,8 @@ static int insert_links(struct ctl_table_header *head)
  *
  * mode - the file permissions for the /proc/sys file
  *
+ * register_one - set to true when exactly register one ctl_table
+ *
  * child - must be %NULL.
  *
  * proc_handler - the text handler routine (described below)
@@ -1329,9 +1362,13 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_node *node;
 	int nr_entries = 0;
 
-	for (entry = table; entry->procname; entry++)
+	for (entry = table; entry->procname; entry++) {
 		nr_entries++;
 
+		if (entry->register_one)
+			break;
+	}
+
 	header = kzalloc(sizeof(struct ctl_table_header) +
 			 sizeof(struct ctl_node)*nr_entries, GFP_KERNEL);
 	if (!header)
@@ -1461,6 +1498,9 @@ static int count_subheaders(struct ctl_table *table)
 			nr_subheaders += count_subheaders(entry->child);
 		else
 			has_files = 1;
+
+		if (entry->register_one)
+			break;
 	}
 	return nr_subheaders + has_files;
 }
@@ -1480,6 +1520,9 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 			nr_dirs++;
 		else
 			nr_files++;
+
+		if (entry->register_one)
+			break;
 	}
 
 	files = table;
@@ -1497,6 +1540,9 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 				continue;
 			*new = *entry;
 			new++;
+
+			if (entry->register_one)
+				break;
 		}
 	}
 
@@ -1532,6 +1578,9 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 		pos[0] = '\0';
 		if (err)
 			goto out;
+
+		if (entry->register_one)
+			break;
 	}
 	err = 0;
 out:
@@ -1686,6 +1735,9 @@ static void put_links(struct ctl_table_header *header)
 			sysctl_print_dir(parent);
 			pr_cont("%s\n", name);
 		}
+
+		if (entry->register_one)
+			break;
 	}
 }
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6353d6db69b2..889c995d8a08 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -134,6 +134,7 @@ struct ctl_table {
 	void *data;
 	int maxlen;
 	umode_t mode;
+	bool register_one;		/* Exactly register one ctl_table*/
 	struct ctl_table *child;	/* Deprecated */
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
-- 
2.20.1



