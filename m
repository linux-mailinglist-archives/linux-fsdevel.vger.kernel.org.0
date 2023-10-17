Return-Path: <linux-fsdevel+bounces-554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3EC7CCB19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095961C20C50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FA844490;
	Tue, 17 Oct 2023 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h/K9RdHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87262D78F;
	Tue, 17 Oct 2023 18:49:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1578F7;
	Tue, 17 Oct 2023 11:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBjWYqKrvt4dyfOwBSRywjra16/7MilddfGF5aSOujz4dZnEzIZKxdJUQbIcIQL5Iadrj7M6n2rkgvV9pvF019Cci5tmTlYMDz/rjd+L6Ho1KBa9NQKz8cTzBBUeluZURW7zhoRCJti5qCaALP5EPd2E+KM/VO4i4fUmkI04MA1Q7rulv9xkgZ97ufpD3PCxPMlS3/nQgm4AVRk53v1IAzLGQ6nrkZfU/1Uvw+QvQ6fFm17FiVqGdkH8qcwHeWQW/8XX7Az8E0vqr9TELHmc2uWD2vfTw3t6/IlsdR2KfrVcdTJ1skwb0OZOKdlW+5QCyzz1vC3JOSF64XY3yWDR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84uLtFWe683Q7ghmKNl6phfPaP04HSjMY5NwcYTyBmY=;
 b=MP/cr30XBqISduSM58mI/P+H3f31HEtHoN2i58+3APC6ow0VRLxIG4YBopjKgg1JCIAD5fK6B5MaE8aIkeE6A/TbZPedPTpKd3dCOHnCOaA8LqCGcVBYs2qWlKfCXDng7F9Xq39WtXFSxwL+lxu0/MPyIxNG9r05YjgKOHl+7mezAQJ8wh/XWNezGRUSXK6zsYQgMmnA24Ur3UCmAPqgY/TNx1fPwECIunNsW9Hm+QWo8Ej2Kc1/1BRaSlaFx8QBunCQc97pN7AKfa1pCzrA73vZCKQ6q5hMhEyALVydu3812rwZCiakgp74pir1D50rK7j/X3WnE/AvwqwbvtMNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84uLtFWe683Q7ghmKNl6phfPaP04HSjMY5NwcYTyBmY=;
 b=h/K9RdHr894CzlUvYUhxtCyi/K1kgmurU09eUj30jrR7lStcG6Z96wW5z/19dZH5EI9yyJ7dLQWBpILBdCCbvBBkqVKnMCV5zK3uweG/OdjrL6IACkXj0V8OHnFztJN7zwdbwvPf9N3P6b5MkhaENqWbzGM2/Mzf9l2RQ4T5WlM=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 17 Oct
 2023 18:49:18 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::d9) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 18:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 18:49:18 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 17 Oct 2023 13:49:17 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
CC: <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
	<gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v5 2/4] fs: debugfs: Add write functionality to debugfs blobs
Date: Tue, 17 Oct 2023 13:48:42 -0500
Message-ID: <20231017184844.2350750-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017184844.2350750-1-avadhut.naik@amd.com>
References: <20231017184844.2350750-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1647ca-5aa6-4a45-1b04-08dbcf41c497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xa3AURmgBGGUX+v1VtTe1/ELMKgZUAmUxTStBEyV+ozaHyFbJEivGVVnOZzZREii59cBt3wkNpARKBE7OcpdBoxnecgcrQagEI2yFzMoeNDSOpDeTuk5+nuU/lqYdRH/9EZ4ugEmSCXf842KifuFtgQZE4EXQmAtJIKkUp7vZkcGQ5itNqtnifjDt+x9GEFKA67WiLoOwnpzCm4mLXhRt//aSmt9R3ygIKJzz9cuoaiXhyGAiG93A2o/NJkrRLLlXv62MHnn2WpnLGQ6qPlP7/TtLf9gcHRmsi5ENuQd1iiUTes3pHXilBtcXg2lhnX1jbl6WbhrpK4yDqj4UopHIMRSL1IGPxdWpzOhn7UdhoEAaajTnKoYMAmXAKBkNA+jXMh+waeg+4y8eQuISSnP49MWkJxfYzifKW6MiEZatOnI2rLLUW5aR2Q+ibITxdcfM86ih/kwLnU9wa0oTXYMmLgJHi6d/34sfzqaPT6VfhVu7iXqHwhjQC1NQCK8l13+oo6x/NjUSnLMIvBLueyHShYi8Mcz1y42rRmtrp75l9NhjXj9B+JEjroC0bHtncsnZW1IURouq8HJ4VnAsMd2MEw7BjVdQcBChd/qiBfNoRX0ZfjSvRAagZ+IGnvr0cc7r2fJJz1KVr8vmbP0wL3/FRY5pA1YgRN+Rz4Lj3D7YV05E4cQKCXxzmrboAyB7ODcOQqeEckjlWCiyays6S+TuDbeAWHdNNJ3RojIN8C3iT48Kd54krlHTv5rLGz/Kve8muECzTzCxW1k6HtXHlo8xdCe7J0mi4ivOwVBaRwLNUQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(70206006)(7696005)(40480700001)(47076005)(86362001)(6666004)(336012)(36756003)(82740400003)(16526019)(1076003)(426003)(26005)(2616005)(83380400001)(356005)(81166007)(36860700001)(41300700001)(4326008)(40460700003)(8676002)(5660300002)(478600001)(8936002)(110136005)(54906003)(2906002)(44832011)(316002)(70586007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:49:18.0649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1647ca-5aa6-4a45-1b04-08dbcf41c497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/file.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87b3753aa4b1..28f658760180 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1008,17 +1008,35 @@ static ssize_t read_file_blob(struct file *file, char __user *user_buf,
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
@@ -1027,7 +1045,7 @@ static const struct file_operations fops_blob = {
  *
  * This function creates a file in debugfs with the given name that exports
  * @blob->data as a binary blob. If the @mode variable is so set it can be
- * read from. Writing is not supported.
+ * read from and written to.
  *
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
@@ -1042,7 +1060,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				   struct dentry *parent,
 				   struct debugfs_blob_wrapper *blob)
 {
-	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
+	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_blob);
 
-- 
2.34.1


