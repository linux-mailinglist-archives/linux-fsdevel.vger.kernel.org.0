Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9497379F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 05:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFUDwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 23:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjFUDwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:52:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116AFE6E;
        Tue, 20 Jun 2023 20:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrXgnYeFWpK8atVN5Itz90GVAN8Gc0mKHgXH7AsFgHdeL5U7vH5mZxOPx1fhjDlJuW4TKP35ifD+z+OCSrN+82s0WvJVPcdC6yu5+Jv/V+PK2LtNzIjCMIvJfmoO80Amub18/T8ydnrZhHqoSh0TphTNP4QMz43kDIyMWuatnge0Qpy+gC/Hhry1anL784hF9x0rWXnGdOTsAEW3+ixZCPx7crejC7tkHQCYdz4jI+m/o3m6+U193g/34c06cBaez5ZK5x0MklaGFSO7Cfj1s6/yuIdsxQnAOyojb25I9oq7pVf5wHGQikgyUlfV8yakMvpWoASoaqkMY/KOoQ/Tvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0f06PgbYTz/YGVW6UaOhvo6HPdiSicDEdPIR9gaBL0=;
 b=Z5Zp6ZGeSac3DmjvopeWUzTt6B1a3JOCPdNawtjOXX5WUIM0jGe2MnpEu2whgheI508ol51yVC/Pk37do/CNzToYONQ3aNB1gfV7/IdQ7vFwvRjv5W96eZANIjcpYKSJkPXHTjAoLAkNL4n63bwmZcrFOc7csAEwqp/KvQThjcE6FPRn2nYFEh+Wdf1psBSIjPL3GgOrFIT1qPC/stIofnct8hTneOrKHTB8PknoJGE9cbYnqITS/sDWp5mXgasodV/AOyclAjloocLmGJkXUIrH+73FGsyJjOK4UTzIxxWpFkO8pICdCsQqLJDDHS7UwVhqHA34M63iDs5UvXqV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0f06PgbYTz/YGVW6UaOhvo6HPdiSicDEdPIR9gaBL0=;
 b=jEPUqMI4l0tWgYQhwGqJOY7T64/9uvz195MOUu1lKiM1zPgiiXZcUUWEt2EaMRBhIifwUR0Y58Q/CWkIoPOdqyu8fpD0vIVzck+qTXDWZjYfLyiF8vzzT155jlDVh+ebV44/C6vGAKDUG+btahfddwkQvdjPt8NVkATj49Tuvdo=
Received: from CY8PR11CA0009.namprd11.prod.outlook.com (2603:10b6:930:48::13)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 03:52:07 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::fc) by CY8PR11CA0009.outlook.office365.com
 (2603:10b6:930:48::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 03:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 03:52:06 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 22:52:03 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v4 2/4] fs: debugfs: Add write functionality to debugfs blobs
Date:   Wed, 21 Jun 2023 03:51:00 +0000
Message-ID: <20230621035102.13463-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621035102.13463-1-avadhut.naik@amd.com>
References: <20230621035102.13463-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: d37a2293-74a4-4c50-2f0c-08db720ae1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0DZzi8m/cOBN4gAOgGj21UHAlcsFfz3e5NeNs3e7/y0cJHo+KmZ0zk9vVu7KOM2JZ4O16shtGaOhYNsw104UGSYcKW+deXhNymBQnNUMfP5jqGnI/Br45ooEaI/Tn9hL6bcPCsYWfeSSnB21UjFbAIY++67nUJENUoICR6aK0W17xGP0qP0Nts1PK/zoEi3DuJm3x1oFuti5uuG578Msl7BDQjmGNSLF3vOfZ+GaWunr7YwtQg5qJ7K5rER/CCW71sAUNa/0PHwd6cvt7MQymGPBG8Z8dEOcw/9XffNDO6MM0hbr7XGwY61JoVxr95o8TD0145f5gOcrlFkEBnHZWEpZuKCXm8EoTopH1xdneGzZvvzefb3VKFFCRFovEOJu69uCRqREUQuZfDb8LZBpz7Sqp2xhFsLZXCx8S5CtTK6IJALaOUoKCcueKA2hOszRmP4sfLl/JEXd2uWY9HosuPMAmzgJo9HEn+rUsWElif3jZjkBFIc1BRqRCROZ+/pAfTC/4GvBncb/Dw9HxpbWUZZZP3s7s0yshhOs14sj5sHN9zIftQQEndjb926Rlr02FZxpQddlD4xiXkDGnunmm6ss5Lfytk1+/EUi6rqhzBK2Y8tN5u6R5CJN2pz6nM0v1SQFQ3OAPR6iMoDa7nCrR9a8x3NFtDL9txKoxjM/F3737r/RAoaPsF28cpHqh/g+S7jojDw7tHSgCKs4ycJ70JKdgfIJsCiTYoQQs7GKgNrTrPXLu4b/P9DU+ZPwiYzxj7FWgGKnDrFijGRSiDYQ0eTJfhD97nyCysCoDuQTGs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(186003)(82310400005)(36860700001)(36756003)(81166007)(70206006)(356005)(44832011)(5660300002)(8676002)(40460700003)(41300700001)(8936002)(316002)(40480700001)(86362001)(70586007)(4326008)(82740400003)(426003)(2616005)(47076005)(478600001)(16526019)(26005)(1076003)(2906002)(54906003)(83380400001)(7696005)(110136005)(336012)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 03:52:06.7096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d37a2293-74a4-4c50-2f0c-08db720ae1e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

Currently, debugfs_create_blob() creates read-only debugfs binary blob
files.

In some cases, however, userspace tools need to write variable length
data structures into predetermined memory addresses. An example is when
injecting Vendor-defined error types through the einj module. In such
cases, the functionality to write to these blob files in debugfs would
be desired since the mapping aspect can be handled within the modules
with userspace tools only needing to write into the blob files.

Implement a write callback to enable writing to these blob files in
debugfs.

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
---
 fs/debugfs/file.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..fab5a562b57c 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -973,17 +973,35 @@ static ssize_t read_file_blob(struct file *file, char __user *user_buf,
 	return r;
 }
 
+static ssize_t write_file_blob(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct debugfs_blob_wrapper *blob = file->private_data;
+	struct dentry *dentry = F_DENTRY(file);
+	ssize_t r;
+
+	r = debugfs_file_get(dentry);
+	if (unlikely(r))
+		return r;
+	r = simple_write_to_buffer(blob->data, blob->size, ppos, user_buf,
+				   count);
+
+	debugfs_file_put(dentry);
+	return r;
+}
+
 static const struct file_operations fops_blob = {
 	.read =		read_file_blob,
+	.write =	write_file_blob,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
 
 /**
- * debugfs_create_blob - create a debugfs file that is used to read a binary blob
+ * debugfs_create_blob - create a debugfs file that is used to read and write
+ * a binary blob
  * @name: a pointer to a string containing the name of the file to create.
- * @mode: the read permission that the file should have (other permissions are
- *	  masked out)
+ * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
  *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
@@ -992,7 +1010,7 @@ static const struct file_operations fops_blob = {
  *
  * This function creates a file in debugfs with the given name that exports
  * @blob->data as a binary blob. If the @mode variable is so set it can be
- * read from. Writing is not supported.
+ * read from and written to.
  *
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
@@ -1007,7 +1025,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				   struct dentry *parent,
 				   struct debugfs_blob_wrapper *blob)
 {
-	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
+	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_blob);
 
-- 
2.34.1

