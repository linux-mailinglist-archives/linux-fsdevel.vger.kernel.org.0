Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A717379F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 05:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjFUDwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 23:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFUDw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:52:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC11737;
        Tue, 20 Jun 2023 20:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3ufBURWBHnkiREgxooDRS1671ZJdEmfkTdPwMo97MGDC/57cEFVuLsKIes9bKsPpxtXQED6YRFhmFjpM5MGtuJGwLCKZPUfQ8d7kYzXjVKfohsNIlhMjIt9ZluIU2vBF7KcyUKdLKKqoXBy8YDGpEFTiIo1nBn6dHDwbuba72uLR803Ktqs7Kku7x4ST2+q/htRBODTkGIE2AGr6VLs2vKCKRyoMV04r/1z1hbzDutqjPMy2+oc0sgUdro7xrsd+Iwf9q3Cy1WyMmfotar49xK3sNzuVgPui69DoJMmM59PHUFQG9mHXBM90Sdd8QNWv+hammBhFZyJ7YrPP/nS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3vzg9K4jeNL/nHvCAwQ6GIQOW4T7hIJBssaA6MeG0M=;
 b=f924sLexSBKz6+rKKkMRdWDWxbv1qzIDVqIIpK52nmKKR+FZlMC6aba6A2b4nbgPUJZKd4Y0U9lEj+iFmyyNcRm3OjlX34RILPRB+WtQsooNG7pn03CpOKyB6AH1faFzZWtU6tvQknYcs2ZEQ3aI6UoUN8BDzg0tjwZ/repRuA1jMYcQ+47AZ3lXodxG1KfgL/dMX+dA/88d3CEM11evN9Nbpo9VA+UiI7d2KcJMhKXwappDoRjRolNyRxzW9CreoCI60HQgwEXaQ0H0jVASIw7tkaD8SoY5F+8o9w7OaSWAuVvGUbXaF7rtoKb2/cucfhb8+JHNqpHfzOheDlEi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3vzg9K4jeNL/nHvCAwQ6GIQOW4T7hIJBssaA6MeG0M=;
 b=h3zV16rbxqH9Fz5ngltiJNaFoZLIpHGe7JpQI7uNgqspgKMNuiMLgtUynOYaowYqujIMpme4WS/ZVwHz9wzsNAijeREurrNemFIifAJeyC7BPjMFpdD8+wUXvii0WIHId9Ug3ggWyFTS9Y89i9tI/8Y68BPgWgcLBlLZhOWduXo=
Received: from CY8PR11CA0019.namprd11.prod.outlook.com (2603:10b6:930:48::28)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Wed, 21 Jun
 2023 03:52:16 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::2) by CY8PR11CA0019.outlook.office365.com
 (2603:10b6:930:48::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 03:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 03:52:16 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 22:52:15 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v4 3/4] platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
Date:   Wed, 21 Jun 2023 03:51:01 +0000
Message-ID: <20230621035102.13463-4-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 5384493e-9d0c-4140-7682-08db720ae79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HJlN/RbwKYR/amipIigw1/UlytCIk5v59ZUfHOg3TnypmemcHh/DLZd0pPUCxydI31lQXqNm4j+I+yKBURnAPUI+JqB075DfZGkCWHqM5EtDgpT43zEOxnTPr0XB8Ne3y7B+iH1J87dqVevPYw2QLO+dLlHvaVZFUn8zdhhFaeVNgKFzeOb3z5xbxKlvgz3nxioczdg+v0ip71h63yjEnnG17NjylF0/9VoIM2lFXPXVGwGHfq9njR5orlYKnEz7U1qijHHx818nn03QHHk+mUnmB/4Xa9cs4TT9SYvIKdXWJVlal7mUlWpak6vC3INent55haFlx/jHl3/aDBL2KiP9/zs89PP75ewnedSKbH+HeJTI4qmOaqt50/vGr1NTjcKTtf1aCty4IhjNHaUBPkpEwn1GZM888gflAUvIzdvnqmKLDuHDuUeMS4VXzzrEvnpnHXndvRr3vnlfQ4tI1Z5hlXlwvpIaQF632vUgHGftctsUs+lMX65ugwLcHx6txSeE7u51s9+aVHOT3nzpLyLvEe3sWd8Y30E7Zu1HMbJUm/5ZXdqBiqb+E1UAzwvO3PgJGgUHnHgEYvj6zExrvfyH0F/G2F2xraA21cgHeGAg9OzyktmclGQ8QrKOhZ3RdLe+3JUN5EPeVIjj0omenhr9saBFhW/jJzOd9J88ky7yCEvsIleHB4KvdTtB2pNUbx4BR5pRtSz7fAE3ZFSH2r749EkcaYS+Afkeldsc8N2023Bi0I3aF/vUtHOMY6AHl7cZAGuWiVTiZl1CKXiho+2mb0N2ZWBrTC3dCZR9xk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(356005)(81166007)(40480700001)(40460700003)(36756003)(86362001)(82740400003)(6666004)(7696005)(16526019)(186003)(26005)(8676002)(8936002)(5660300002)(44832011)(1076003)(478600001)(110136005)(41300700001)(316002)(54906003)(4326008)(2906002)(70206006)(70586007)(36860700001)(426003)(83380400001)(2616005)(336012)(47076005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 03:52:16.3190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5384493e-9d0c-4140-7682-08db720ae79f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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

The debugfs_create_blob() function has been used to create read-only binary
blobs in debugfs. The function filters out permissions, other than S_IRUSR,
S_IRGRP and S_IROTH, provided while creating the blobs.

The very behavior though is being changed through previous patch in the
series (fs: debugfs: Add write functionality to debugfs blobs) which makes
the binary blobs writable.

As such, rectify the permissions of panicinfo file to ensure it remains
read-only.

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index c876120e0ebc..4428dcbd2a68 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -454,7 +454,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	debug_info->panicinfo_blob.data = data;
 	debug_info->panicinfo_blob.size = ret;
 
-	debugfs_create_blob("panicinfo", S_IFREG | 0444, debug_info->dir,
+	debugfs_create_blob("panicinfo", 0444, debug_info->dir,
 			    &debug_info->panicinfo_blob);
 
 	return 0;
-- 
2.34.1

