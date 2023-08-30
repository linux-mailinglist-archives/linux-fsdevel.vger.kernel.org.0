Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F19F78DBD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbjH3Shz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbjH3SP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:15:56 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BA194
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 11:15:42 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104]) by mx-outbound21-49.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 30 Aug 2023 18:15:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQoaLm6gU1grb5E0n0C/MLk4u6UpH3ww2hK1SPIn3OpvyHiOSYDfIJhqb3hNMAGVjJDu4pYCghBauWsq5Jq/MLbKi1ENwQoZcTCJT7lmZwdueQJKGIO1sxlg07YRCKDnT1eXYDlJCApthXo7iXT2AaRpUdPe3UWtuDLbBGNjMTwzASqPPSzbC0oi+HhAtpC2Q0PW6S+FhQEmgGr0PGXuGbMQ6TGfkMrAgWPYSob3HC9nORvGwj/fArINwFWhMM8J7vmi9g+kB5MeBT/EwVHI1jQ/4S9WHFZKhKZglE2pK67kCUUGGNpENIedIkMuiDQxzJspBca3HF2fIUn+qvRbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pANcYl1YecAm1CN2ypnPrpzWh/ORNo1j4L1Bx7lMHA=;
 b=eWAsuMC5AplkvyUlw2c4m+m2HO5ukiDsmFdWpmluA+PJWnIiHv9Kjuf85+AgJj+QxKb/AZDot7v/h4ZbZQfvKUqopD7HVJ9dWghpyAJgI0zDWoODfmQPVa/GvWh9BEFOAonV97aMVrEqZtirncQF0R8bYCk08vube/1sLM+C9GJX8VUz4PnRaAv3bCTr6tD1L4sJR+tymqjz4ecSiINe9iJyFl0OMhb8aMdZyDwSsAFDHl3zkXAA6nbYUkluvz3I48E9smE7MIQ9OAiCrb+0Sa0DO8aObNWCOpIWiUd1paNF6Fz3BXp92GMTjAapsqvYWxUFi2ltwu6e+To1prGqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pANcYl1YecAm1CN2ypnPrpzWh/ORNo1j4L1Bx7lMHA=;
 b=gwzjzDn6LU3zVIaKopdKec1Nh+w16QqgnyKdK3iNqxtcV1LrtZolyPhksota/iE3cX7pKPMkE4WYRxXr9J4eMJhLvKjpSW8cevyFAAevuAZpGOo+hIMM0myaoIL7srDUL0tZ7Mo/QgFaFVEvGr66nPLhDklNi6Rfh4XL5JWBbkA=
Received: from DM6PR12CA0002.namprd12.prod.outlook.com (2603:10b6:5:1c0::15)
 by CH3PR19MB7635.namprd19.prod.outlook.com (2603:10b6:610:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 18:15:25 +0000
Received: from DM6NAM04FT023.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::db) by DM6PR12CA0002.outlook.office365.com
 (2603:10b6:5:1c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 18:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT023.mail.protection.outlook.com (10.13.158.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Wed, 30 Aug 2023 18:15:23 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 6FCF520C684B;
        Wed, 30 Aug 2023 12:16:29 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] Use exclusive lock for file_remove_privs
Date:   Wed, 30 Aug 2023 20:15:17 +0200
Message-Id: <20230830181519.2964941-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT023:EE_|CH3PR19MB7635:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf476a4b-03ff-4985-b2e7-08dba985142f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4uOLdA1oUSbPkYL0dE9wufwO9KGT7FFpxBm9GGFZ2CUcsd9sJjWa+etyCARk5vnXoEhSDg1VY/I5EsTLIndXXWw3S4x5twecv4P1BRdC2vIwfaAv2iq4qV5MF+h08KISx0lx2TxFG/PdUUERwKgYCa5NRSsbk+hPBf1STI/5z7rnHax+TyY0K9RorpA7Ljmp1YZH//WcpMcMjNgIosIK/V8SQZwHj3j1iokIXczn3lkDD80QMKkugP8ky0EIWNopHYTKzxPmbYIe3JAkpkFwCwKwy4K+hiHbSrFsPl4ikeFy4DYtwxBah99zw8wOcXQ14w6glWNMiIkZ6tO7iblAdMJWqkovrwccr8cP9FHOpmf4uHoGWFt+72czpRiOowXcoswbRwF3PEc7thRWGP0Haa/p2czQXZ/0czQuA9BmFYpctis1GPBj1+25QZ+tthAR7Lhsbu1VaiBDyydU5jyQDi4gZ+AArvoi5+TIrekWE188B1hsqpxfSrOGbvdDFe12PDGJV4LDbM7Bp3xqklg5ewbJ2otyRBXdPOoinR81Ct+fbaMLRj6CoBYJEc8DPOTbhDayZFSDzkDCecc8ZDcsko0om0A+eNWUflbDbc4rLOqTOHm2bckGY/nhtdAlSvzDS0M+LRPRpM/TM/GYbJgQEAUrSM4mPoMiVpk2e6c8+0/xknUrn1Rl0y42M77uaZNd12O5rZoT+chiHt2wVCXU+VCyk+VKr55B4cL/iwB9IGdQkEpIDClzigBGiQC4lGt
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39850400004)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(316002)(41300700001)(336012)(4326008)(6266002)(5660300002)(6916009)(2906002)(47076005)(83380400001)(2616005)(26005)(8676002)(86362001)(36756003)(1076003)(36860700001)(40480700001)(8936002)(6666004)(82740400003)(356005)(81166007)(54906003)(70206006)(70586007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EJFTZZWhd463qFfkADgaylZQ+ZgRab0P6gQLHgu2qGaxf3XQAHOmS3c+Ak+D?=
 =?us-ascii?Q?lMjZVRTi4rYFW/e+pznyZ1ieJ6TAQOYoaVFpDoXev5Xvs9tRwjz/W62oOL6Q?=
 =?us-ascii?Q?TtSLNNMSTzTnHLn8CY+KaCL64FioRXVH56sXCVkkIckhfsd1dlNJQRbh0/5l?=
 =?us-ascii?Q?WQRjP06wL48VMw5zL22kijZuIvotM7oNNtuiVyySpZsisfbNLhHjsmUTF4UJ?=
 =?us-ascii?Q?+jJkWIB/On09MLZvkVs0HBfoGzhjPOm4RQJ32cyz3DyDjcEwGKEvU3/xdiVn?=
 =?us-ascii?Q?u0jSh73AX6SaZIYmo1EtBUS/XCNQVX2BQvTozRs6ABdhY9nXapozTGzWbLt2?=
 =?us-ascii?Q?1UsjZrbdiEjxBOiNKQOz0Lz7OMxg80hW46wgTjh/3vEsIde7sE5qQ0OKJrkT?=
 =?us-ascii?Q?nuSk3Y2NJ3Kb+yOvE8266/blUHDjw+JEZqQ3V2TJOHUXbGsXVsJLLCIhxppp?=
 =?us-ascii?Q?xdysuJuqEYn+5Gf1qmKvmXg0d09Q8PHpYNmAxz6jVGxriU62xcY5yx+v7eaC?=
 =?us-ascii?Q?Gp+qzbCgjA7wRA//PA/N0k7G2UJdEpYfVEoxMSF4MWy2BueN3mrtsdVy9oeG?=
 =?us-ascii?Q?nSut+/SRJ3+2Q8LYMtRgsSyD/+IA7whAG3iApCvcqGhdHjzhQALTgk+x2g5I?=
 =?us-ascii?Q?FBqMLMBzIDcYGLIws2mND2szsL3nuup9XsKYW2YDNTIH+dMsyOuSWgJcy6P8?=
 =?us-ascii?Q?PolA6jvFSBIUatD3o7PuZ5Zv9Xau0bHQN1XtxIgtBY1szaXZb8Hb1rtC1Nfn?=
 =?us-ascii?Q?n/ehi8J9qVBCfdHdwbIzxJJMjx1HkJR0IAjEAXg9Afpkn2wMDJa1YaJPszL9?=
 =?us-ascii?Q?vLK9XId3DURgTdmE07uiP6olO4QsdnQLQcC1HDl43B5civgguNOVdDgPHI6c?=
 =?us-ascii?Q?DXDc5zn1DCTb+L0/PqkWp7rlzfLQ5Y74Ms6Cyxi1jnaZhGBHIwglj0aZiMY0?=
 =?us-ascii?Q?UxCQxn3xpWc0Pwf3lKhkZR9It+woDIN9Kyq9BSpyyjI=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:15:23.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf476a4b-03ff-4985-b2e7-08dba985142f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT023.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7635
X-BESS-ID: 1693419328-105425-27300-972-1
X-BESS-VER: 2019.1_20230830.1749
X-BESS-Apparent-Source-IP: 104.47.58.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGRuZAVgZQMCU5JdUy1dLUAA
        gSk4HAMMnYzDLNwsAk1TDRMNVUqTYWAD3iRL9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250495 [from 
        cloudscan18-67.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While adding shared direct IO write locks to fuse Miklos noticed
that file_remove_privs() needs an exclusive lock. I then
noticed that btrfs actually has the same issue as I had in my patch,
it was calling into that function with a shared lock.
This series adds a new exported function file_needs_remove_privs(),
which used by the follow up btrfs patch and will be used by the
DIO code path in fuse as well. If that function returns any mask
the shared lock needs to be dropped and replaced by the exclusive
variant.

Note: Compilation tested only.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org


Bernd Schubert (2):
  fs: Add and export file_needs_remove_privs
  btrfs: file_remove_privs needs an exclusive lock

 fs/btrfs/file.c    | 37 +++++++++++++++++++++++++++++--------
 fs/inode.c         |  8 ++++++++
 include/linux/fs.h |  1 +
 3 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.39.2

