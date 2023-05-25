Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF671185A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbjEYUoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 16:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYUoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 16:44:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E5D3;
        Thu, 25 May 2023 13:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICCyhP1RzCLM0AphLyhV93JgfQLsX8iMj3z3vQf7JNVLKQhkUiGbX0cs5m83nx020JJXHztgYSBWqlawtukugF6+oXAKCDfxmOkaS7s9WSTyYRNKGxwWkIEz7XzdlL/DqUlbT441tIA/Fmp1RfAE7PMzXMqSBUqXsSxuGFcsqqMskrS/q9M0myc2pZq4K7VkkZa2/kay7bsjWukYFXdM4n8DTkrigdqDaTc/VvUirrGLXBG2l12Cw/QrpCaLd78pmpom0flk7P3/Gz27VhCgpM4UPoZRdJfH/25+mWG+ECeSFG0NnKhqXkdZPXZ2MxjuCOufRpqcIX4ymEyx2+BBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHv6/FizfqOfQJDVL98OPZqH68YfY8hQAeEVz4+r1Es=;
 b=G6vCIuIStO7EuFK419kWqF2BJKQU+9m+V6p/R8GiUVNulGbpzxWtpzRxmIk3PcE642Db9pEkd5ZfRGw9z1pTmX8NZonkmPWEt7ZAEjR1If2WjPNnkaxieE+qj9jR+d+J8az0ysYRjM15iWrPjMQa5eoN6knns5vIV+bChpWW+U13Eo2S5tSWKfmNPu5wawDz4r1SJxwlnIsfGu/5COPguIb7O2Wql4oaUJKcJyF9aSbXpRXto3gUEdqiUHSTN2qyVlx8FvP2OJwv23Cp6/a5z2usco3JPyxb3fMy1xUTaWlhlec9d9MGeOV5FPRNnjKR8VCAypgnyqmMMMTuUSeG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHv6/FizfqOfQJDVL98OPZqH68YfY8hQAeEVz4+r1Es=;
 b=39+rQx019zSZbrHPZO9WWplaV4g2/5WzErAUjFPkReocyXA5r8vZiHoxmAzSaKRLAQsF7QwmX7FNcpaHK276zFlHDzF+IVSYVveDYAIZO95Pd+0qV70//OBOKyqkIs/Y6gsF6RWadaKxcbQOYiR7L31PG/GWLR6WyiejAvDrrkk=
Received: from CY5PR19CA0092.namprd19.prod.outlook.com (2603:10b6:930:83::6)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 20:44:31 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:83:cafe::a2) by CY5PR19CA0092.outlook.office365.com
 (2603:10b6:930:83::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18 via Frontend
 Transport; Thu, 25 May 2023 20:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Thu, 25 May 2023 20:44:30 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 15:44:29 -0500
From:   Avadhut Naik <Avadhut.Naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <avadnaik@amd.com>, <yazen.ghannam@amd.com>,
        <alexey.kardashevskiy@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 0/3] Add support for Vendor Defined Error Types in Einj Module
Date:   Thu, 25 May 2023 20:44:19 +0000
Message-ID: <20230525204422.4754-1-Avadhut.Naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9e32d8-8103-40b7-0952-08db5d60d726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlVjaq+URpmOwha7M+vWxtVjmEG52CcJrzcuTDomUoJSh5kIaZ/uC0LxAUGhJGJsL9s7qWeAC9GNqAFkDvifEEbmhZYDrNWyN0VLF0boiAdzfFlLmPy3bvri/vCL/w+aQ8LZCWd+s8mVwlOBL0lIlIqdrP1veel2oaVMl9I0KRW2hmTP7exA9mYsX7yzemxMQ8R0c4Q4F8N3VacRYDxe9p5QgARQyo/crd9aD8cCJa/H2VS8s4O7abM9DYF6YRbA5ojL3s4x/NPNvzKa/GWpYJMm8JVJRd9qzzt2ItjQStDpq6qw8JICjITs24glYG9x7x1xkl0lscjk1ADK9eFGVDf57/EzY2cQL3WTMMEy6+wI0Z6hS7GXAbp2nSC62mNrctO0p57oiqe4Dia1i2DpjyRUQ27agzWCp0hIoK49NeoZ1TX2gmNmNMX9dQoyqLA62G8qzL5lTgkL1XlfXcViTSZds0LkTGZBm5NSGrzIrvsXQTtChOckT+0B7RrOdVCN+GYuIHNpmLJR8ZPymy6bMEfxkTbfzTTKObNYzJcNMDU6mKfcvzsh4e07J+iEkz4lJGwNoUVDNSbNqvLYKxAFOmDai5citZuTnSFTjIyORmu60HeYWLDJTHC6E7OascXi+oPUP+g8c9MkJiKKkM/GIRLRqhAUm7K+JSE6TgY6ZMyy+c7diLIMqpvGuWvE1C7irDFkG3sz72Pjkg7sXxtloDERlHsdHL18KjNLdaz8VCmhf10bIMAxUT7I93GAqFajtk4zwjFGF5ZvXs2OXdjna0WNcDhr68/wfosOe8BNAP4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(2616005)(47076005)(83380400001)(2906002)(186003)(16526019)(36756003)(36860700001)(86362001)(82310400005)(356005)(81166007)(40480700001)(82740400003)(70206006)(70586007)(5660300002)(4326008)(6666004)(41300700001)(7696005)(54906003)(316002)(8936002)(1076003)(26005)(8676002)(110136005)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 20:44:30.9957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9e32d8-8103-40b7-0952-08db5d60d726
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

Changes in V2:
 - Split the v1 patch, as was recommended, to have a seperate patch for
changes in debugfs.
 - Refactored available_error_type_show() function into a seperate patch.
 - Changed file permissions to octal format to remove checkpatch warnings.

Avadhut Naik (3):
  ACPI: APEI: EINJ: Refactor available_error_type_show()
  fs: debugfs: Add write functionality to debugfs blobs
  ACPI: APEI: EINJ: Add support for vendor defined error types

 drivers/acpi/apei/einj.c | 62 ++++++++++++++++++++++++++--------------
 fs/debugfs/file.c        | 28 ++++++++++++++----
 2 files changed, 64 insertions(+), 26 deletions(-)

-- 
2.34.1

