Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017978EBEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346086AbjHaLYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHaLYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:24:51 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF365CF3;
        Thu, 31 Aug 2023 04:24:46 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by mx-outbound-ea46-177.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 31 Aug 2023 11:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+WKiCEmixej8cqA5v4HqCntnlGQTYFEZ6oRpVPe3szSEsqP+vwionzXCinbPeaCy6wTX13cZzoZFMVBN+uJgfRUb0vfce5zaUuDNjEXr+48/DKnMy9z8KDF5BhLwifZJ4XByuSDy7Acjzaer47O+mQ7JFatZdEiOKcRPgSBqXYbOgu7J07sJNJlyhJLWpy6hZSwwQX/jw+78CLyd3hy7AiNlSI+GH1eS0Ky7iI5Q/Z15snM6ohq7V4uSjH9diIrzOmnRykB37TVtBAmYWP1wSSbsUIyGIVQWuPxT/FW5HURSkocSBoySXsUBqA8tx/djoyidiITXJuEDWupvaQ+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU215NrAf/pFuMtiOt7fKzQgmTPqMDd9WVVhEr66Nc0=;
 b=hKwkZbzGurJeOLZkvqZMWSHS6mwSSc0grdpciJJv1dPQUtu+IjP5CQeMIfad2xNLtGHyGPGQaYVY4oV1A2fFwY3QtCUyAzpDl0UCgMrLsrArWrH1mWABJn0fSatv7Rjgb3PRnyZNe32ZWF6f72xq8BOfEYyXMyqA/8aiGd0MmttDyCADoGw0mTDChN1/WDRL9ZpzBYMnXUVXSkmL1tB7Vjp0a7o/TRzVvjZhJa0LMj9la8+hVLuGYfrMhn3FDmdKkJhFByun8d2sQng9v/Sz+KbBP6SmSUXQbHj2L7nw0nrXlElEjOk4Y4+iqcmp8F4N+A6BcRHhrhtC3JlZJqYSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU215NrAf/pFuMtiOt7fKzQgmTPqMDd9WVVhEr66Nc0=;
 b=wr+iZH+nvGh2f6pqq0G/HM+emIlTd79QZGlaZtpfYPUtSY2EGVvgGZHUkeKDXTIXihTxrOaDdj72x5mKAnWnn+Rv+sJHKO1y/A0bxGGYvj0xC3Ez0MtOQDF1RBqqbnhn4o9ZK+GXjBPwBVNCJQsAZgzA9xx2+PoJG/GcT0C+CvU=
Received: from MW2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:907:1::16)
 by PH0PR19MB4744.namprd19.prod.outlook.com (2603:10b6:510:24::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 11:24:38 +0000
Received: from MW2NAM04FT063.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::be) by MW2PR16CA0039.outlook.office365.com
 (2603:10b6:907:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 11:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT063.mail.protection.outlook.com (10.13.31.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.22 via Frontend Transport; Thu, 31 Aug 2023 11:24:38 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id E2C1420C684B;
        Thu, 31 Aug 2023 05:25:43 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/2] Use exclusive lock for file_remove_privs
Date:   Thu, 31 Aug 2023 13:24:29 +0200
Message-Id: <20230831112431.2998368-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT063:EE_|PH0PR19MB4744:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f94d7766-be82-49d4-6151-08dbaa14dcd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3asnfCgivBLIdksKhnqhyIgKyh8mLVfdFdyta89JRwUAKjZqsd4GthjULtwrLXx42PaLsRcIT9Ga4VRlc3ylf/MJX/ipgl+SjpiXoKT2iCZh2RglSrZrDLGq/JxeslJ6+q0MjDecOx/kbZHGHluswE4ix6ud3KmAA2PUtHPAzuObrc28oSDs9NsOEbedEU2OdFHufR9SandUUMMDfT9ge1p+alN7e0/+zeWxAIaWuJ9xg0XwLimMfNzSY6BxejzMEhqna0Z/xQYJaNXYAsjL4IfC7b3DdALTXyf0Fx3ufeDcSDyM7wvwlZf5lQ8Acl0gzlbJutbqgZjedTT7jTumdtq9K5jJghuBaoS6ylvRYI2cAYllhIwoHkV6FzdXPsBlEWMSS7A0WnUYEBxvUrAlz2guOv51BvlwpIZUtHzFU3QgjljV90vKHI7z/YLCwwKHJpXgSUGI0h1dOXLGbNleoPkac5R7k2z0KlO0KdqdWKVoGc0UoyO16kpPaeaNiRTsZ5eNX//Wa9DRPjT7ApREQ8Aa6c//qcQl3bpkHO77gVlvZmkYjEHC/tT0e4rIsAb8p2WU0Z6XsQIy1dzCVr59lhSa19iJzeUIFDQ1v8gEfV7fs6zWK86LunAmyx8+zsoe7AgABhKe+Gz/8fLsxnkeruzPPn7grGEu7BjAwMT5i5tSImE0ulafolgIhqTDeZHY8vXVQyKo9Vb0+FGdpwaXl28VTI1RJ4bB9hgVc5sFU2jD8LBaMAViiDVGJ9JBqdf
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(396003)(136003)(346002)(376002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(8936002)(6666004)(82740400003)(47076005)(36756003)(40480700001)(356005)(86362001)(81166007)(36860700001)(2616005)(26005)(70206006)(6266002)(336012)(5660300002)(478600001)(1076003)(6916009)(70586007)(2906002)(41300700001)(4326008)(83380400001)(316002)(54906003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ketqSR+zfOdP4D+0eLN2wRiBnOHIuh7AvA4NtUHoFYQwrawWc1QNQuRne8TT?=
 =?us-ascii?Q?xxTdYQ+6rrg46ad5VCJtZbjdnMIN3xV2xvqfa4fhl1g6A9aD4ma0mFYaHfO2?=
 =?us-ascii?Q?Z/7CvuJyviXJzGFv7+RNs7pnIx5Bd+oTFBqjA7/CBGGxfeaZ/OOaeeNBp4AX?=
 =?us-ascii?Q?eJpKlN4ncs8owqMqCFI0vuDJ+/tzs751y8Nirmw2Yj0xRPEHMU95c7B6+pc7?=
 =?us-ascii?Q?MSiFgXdeUgN8AUuxRnavz98cR90CdNPjCwdU1lv+cyqQxjaomXDEFdhKOF9q?=
 =?us-ascii?Q?WiWdYeQU8furjKoLEe49Jko2oMQ1J2HCNzc6zTYGeM5X5lur6vVcsPZG1jjT?=
 =?us-ascii?Q?/xYxhwUOcXGqOrVleIugbRs1hcSGDoKOJWTtC/S4uDc4hGbnY6finKfN9rfO?=
 =?us-ascii?Q?mVFo2zvl1jkYPy9A43lT2jXfhbTuul7ARem1xnkFFFb9RrWjnOy42Vmys5Iq?=
 =?us-ascii?Q?NPSdi7sqthUguadYvKD+vwTGgDUTFVn5ZZZR+XUgrCM+ReVCXgAWoyfjts16?=
 =?us-ascii?Q?fpcrx+k2eQcNJdZLlI/ZnaPRL0xhKCpRzQNmQk+w5EKgsFd0Udm2qPib5T8j?=
 =?us-ascii?Q?YnEXbE3einjwYZaV4EwlK4uxiIu6tPRKBuK7SxwDxH+VEzGICLd9N4rLapNL?=
 =?us-ascii?Q?emBnKr9QuR7II3fUK7C8AElaGrjv+oUyOJskdiU7SWoG6V2JzYKV6oYLltc4?=
 =?us-ascii?Q?ZqjJppip5/SbQC+hTZYZ/+eEDoYus3F1zPvkb0A6blMCvIR/9y3VK8NcCy4k?=
 =?us-ascii?Q?gJOrH60GbKeK2u8pUw2xZkAFgaN6Y6zGpxsHbgkh/szji7sCSKbV7HB1n3gq?=
 =?us-ascii?Q?7DSl3a2rLX2WEDBGN6s0gSHezFEP3rwNprT5Vlefa+zNQU3ufxbfFb+2V17S?=
 =?us-ascii?Q?6oXk++T2imfWxITK1Qoh58ApwcMb3ghXof701cwn/5Y2b35KtrJhPS/BHw4X?=
 =?us-ascii?Q?VGsAQU7aA65k+XaerYubrs6fFTbAbs7ARbqfTDayAJc=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 11:24:38.3118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94d7766-be82-49d4-6151-08dbaa14dcd2
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT063.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4744
X-BESS-ID: 1693481081-111953-1076-37637-1
X-BESS-VER: 2019.3_20230830.2106
X-BESS-Apparent-Source-IP: 104.47.66.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGxsZAVgZQ0MQwyTTFxMTIxC
        jRPNHQItHM2MjIyDjJyNIo2SDN3NhUqTYWAEX8SNNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250513 [from 
        cloudscan12-102.us-east-2a.ess.aws.cudaops.com]
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

v2:
Already check for IS_NOSEC in btrfs_direct_write before the first
lock is taken.
Slight modification to make the code easier to read (boolean pointer
is passed to btrfs_write_check, instead of flags).

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

