Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3F72D386
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbjFLVvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjFLVvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:51:51 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2687CE9;
        Mon, 12 Jun 2023 14:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVv1JEQbIofsKqdKKpDwdNtcmuwDT5tBvPa5RUQh5hX92R7rjLW9+0X36t3v15qrUlL1vbLynTOvujbNWOnaKn8TAhSumUZ2eImmkS1dkdNOLXIxZoNmsKmDu0giHp/xH1LdTXgnOoi3dl6HncWF+TnDQfSAdjbNIvehh1PhbrGffP/f1FqUiV7JcIkSRMdlJbAPIc4ugRwTUNaxc0CPQqDHNb9eDxgw8zxlozc55EMW8nTh+KAVWfKikrdbSaS9oFt7LYvmiRmwp06AvATOqK0a+B82NaURgKII3wbCdyZHGOpE2fCxgJwEVgnbonQ5dCqqZmOfL1c9c0ms8Otwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KP08No+KChqfyB7qy1tnfkqxkvSlj5i+VH8AYadgvU=;
 b=O/TLmQ7zghEkhB27H6rkcWT5kpVyle6o1frXTctidantPOaNopsgXV3ehEFRNpz9fsU2iecSf0qq8OmQEfx1kF2yEpx9OmQSHeANyf6jgyF3Xt3ZV/nqlRpPcdUo51Wrx/tmtLUH4uLrG8ulkw4RBSXgEgw9Y/fx8V97y6OBqSqthQW5bwbvx8sGFV7n9HNTQpYlpvVWK6tq1Y0d5UAVdRLDREkA/c7Uj0iJLnAvU/KtJLMm5sskx8Tv5gLGowJ+ejrX0ArN22TxsaDkixI5uhw/x0WoQY+l0njwqHxgQlfY6sCm8milUR5fczl9dY3KyPcRj3YmVuMjLO78f0QsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KP08No+KChqfyB7qy1tnfkqxkvSlj5i+VH8AYadgvU=;
 b=P/FNzTZOG3POR5upZr10aiR593IbxURNdvsG4tpl6OTvGJD0oEkNyNjDDSK50aSOgnYdCZew3vo7eHVBLUCffICXAchtEzjJYEXtVewu3e/IBR/+5+8wGF/8jTvPlhBR/507PcePE+VZY/nc8J7tiI6pa2IstspGIHkgxZf7Drw=
Received: from MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:51:47 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::15) by MW4PR04CA0222.outlook.office365.com
 (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 21:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.4 via Frontend Transport; Mon, 12 Jun 2023 21:51:47 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 16:51:46 -0500
From:   Avadhut Naik <Avadhut.Naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <avadnaik@amd.com>, <yazen.ghannam@amd.com>,
        <alexey.kardashevskiy@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 0/3] Add support for Vendor Defined Error Types in Einj Module
Date:   Mon, 12 Jun 2023 21:51:36 +0000
Message-ID: <20230612215139.5132-1-Avadhut.Naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: f47698ef-fcf2-404e-614c-08db6b8f387b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xad3Is2ZV2P+A31BlV/yqJxa4RoS4wXkkWxkatqK5TJNS1imsfq8Y5LeCg6KUh2NsUcSELN4rHL9WnvFeHpZknpXocmV4KHH9dZ2nN3c+dsRdTth7RFV3484NSqy3wBDPr9R04LHrwXibA4aFHW3KGhMVS7bMbVhRNsdy9S3mZwLraM0syyHi0cacbwyrElFRWdNDAAilnQBl7ndJ4CD1EvYtH+2iEWeMZ004bfN2ssvmssILU+VRcYiaOuM2JeMHusGq/CIX30x90i87j/jg8adb7MDjZENK4AeXitnBj/aKlXZAAyj6hisxB3lnvKoNxn0UM/0aJUWWdEqgFrE3he8Z+Vx7IVPetMey73/hhmi7pN543TrKFSdb701A846MXLBXgyM8F00KKGKV3wrpxgWygpbGDlxuYNHV7OKnJh+ifd1Y5Y4q16GnZ507e7BGJhI6Os0RxUsO9EkV4a6fzoEQ1i4/wT2kJMyWBPX171LVUR6qIES9oOqRyUJo6zHUUnmUx0zW7TeFpf4+3j7ENpMmAltRg6Bl3OqWSYlskJaQSSx069FX6qzBGGeGlow2FxRu2e/TR+kYRpDN3+MoZ2fYpDayL9NotFO5TvmNgWCwQ0+rVzJsZNgcH4QFDp/i3RWhKIg8PEDLVxQiRBNlvL0BxYYU01dFHJ4myMWQBHpnN7C1QEo8oDOl4keB9QqYwsFAA9HSipJZ+s0SOTviSfPP9dm0CkGNmfYOuHz4Wats92k/UirsqEFvIF9y3NuaDdEYieXZvh7wpQwCYn5QJ6z0ni8Kdkyf7giI1hzYmc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(82310400005)(7696005)(40460700003)(316002)(8676002)(41300700001)(82740400003)(83380400001)(5660300002)(26005)(81166007)(40480700001)(1076003)(356005)(6666004)(36860700001)(8936002)(36756003)(336012)(4326008)(426003)(70586007)(70206006)(47076005)(478600001)(186003)(16526019)(54906003)(2906002)(2616005)(110136005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:51:47.3756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47698ef-fcf2-404e-614c-08db6b8f387b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds support for Vendor Defined Error types in the einj
module by exporting a binary blob file in module's debugfs directory.
Userspace tools can write OEM Defined Structures into the blob file as
part of injecting Vendor defined errors.

The first patch refactors available_error_type_show() function to ensure
all errors supported by the platform are output through einj module's
available_error_type file in debugfs.

The second patch adds a write callback for binary blobs created through
debugfs_create_blob() API.

The third adds the required support i.e. establishing the memory mapping
and exporting it through debugfs blob file for Vendor-defined Error types.

Changes in v2:
 - Split the v1 patch, as was recommended, to have a separate patch for
changes in debugfs.
 - Refactored available_error_type_show() function into a separate patch.
 - Changed file permissions to octal format to remove checkpatch warnings.

Changes in v3:
 - Use BIT macro for generating error masks instead of hex values since
ACPI spec uses bit numbers.
 - Handle the corner case of acpi_os_map_iomem() returning NULL through
a local variable to a store the size of OEM defined data structure.

Avadhut Naik (3):
  ACPI: APEI: EINJ: Refactor available_error_type_show()
  fs: debugfs: Add write functionality to debugfs blobs
  ACPI: APEI: EINJ: Add support for vendor defined error types

 drivers/acpi/apei/einj.c | 67 +++++++++++++++++++++++++++-------------
 fs/debugfs/file.c        | 28 ++++++++++++++---
 2 files changed, 69 insertions(+), 26 deletions(-)

-- 
2.34.1

