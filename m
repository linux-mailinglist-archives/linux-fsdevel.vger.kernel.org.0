Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC87940F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbjIFQAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 12:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbjIFQAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:00:35 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396A7CE2;
        Wed,  6 Sep 2023 09:00:03 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170]) by mx-outbound44-194.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 06 Sep 2023 15:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrZxq6p5mRCRWRSuZ1NyPNYJ4KzcvSwHs4QcDPSqRzji8zH6iKXq2ASkbZglNcaTOyS307nGQJY+CX5ovYNmwIdzFDDKeS17/RjnAVQcPA7FPnGkpelHtQiFt42SlCfrommSwyoIvOLunHCyvfZvmG4ICabIdF1ZNFMwxKSKgdVtHoyB2JXvn1eN0Dkcd08tIYLH96c8z4NgIJ2Dl3xrPeizXOKXbcC2ix8VpcZqtezF4LGL7WPeA0t/vfBxZnMlVzmN9cMxFLMGd03qVDYcUwoI3aYUYS3OTFn9i9m9UhA4zEFb0wbEHbf25QN1bjHCzqqtePoL9MkBpcOfvdRDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T2GfYuWGNk7CVzIjXA+QLIYCGB02jb8z46E/iCFEv0=;
 b=O+nuYhRXq+HjPM2k2gj0H5p2WfCH/YwkJ9iryP7nVtw8q1aLJfHdrjnHf4/N9Cy/fe/W8lxeO3OoH5q0QRAvZz63HbnrBKLa/S39wWSKqLKX9UZ+uKkFyn+3oe82OPGMqotJTI9K10lOikDqoKLbbzswmCUsgAbZ57dsfv4H1mhEnVqys0kCYAS0F8YDJXJl14CNpudSGXbcDVNt9ODZQ9ALYtNWbQcxXNOS48ivWto8oiO270MOh/AY1uo337tWDkmEa5zlKRlvf9HufPt/htt2bxYJX33pnhah+mcQ9FTsNiqFF8tY4GX0yPAcAdbfLsLb+IF9L41Uo8LGb9sP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8T2GfYuWGNk7CVzIjXA+QLIYCGB02jb8z46E/iCFEv0=;
 b=aaYQBHWnNpSpalDf3hfhyJRMLCWzZ5w4nFg9a5EaPSFObH6xcFCKI6SkoGT+JIJFaHO19qn2ccA1qoM17MJDNDwB6603JwhFVt2uy3kdXFFMc2C7k2CwAKoLSHjufjPW2jvNw8bNC3ULQ6qLcQUo1k8qLNjEgnQZKuvZy0/2j7o=
Received: from DS7PR03CA0298.namprd03.prod.outlook.com (2603:10b6:5:3ad::33)
 by LV3PR19MB8441.namprd19.prod.outlook.com (2603:10b6:408:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 15:59:14 +0000
Received: from DM6NAM04FT022.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::ce) by DS7PR03CA0298.outlook.office365.com
 (2603:10b6:5:3ad::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 15:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT022.mail.protection.outlook.com (10.13.159.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.28 via Frontend Transport; Wed, 6 Sep 2023 15:59:14 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 26AC820C684B;
        Wed,  6 Sep 2023 10:00:20 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-btrfs@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/1] btrfs: Use exclusive lock for file_remove_privs
Date:   Wed,  6 Sep 2023 17:59:02 +0200
Message-Id: <20230906155903.3287672-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT022:EE_|LV3PR19MB8441:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a68c7382-b064-41d3-ff41-08dbaef237df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iISjC0gvv5p6amE5R5Xnv1HR94UQA7kU/+0j0qqmgZzfSLAG8MLZRyNqpgb5IXSU5rVYM6A+laHKnhuOF9RpMCbA/aBTP7LE6AYhm6N+3x6oQPdLAADGGXYVB2YLuc/pEi2il9G2mDfwrvPqtmqGeLhK17q+vmSn+VaoD0UBr7ZN+lpuoEjeH3lBqyYLnEGxFbeKrdRLLHQfZDnR+V2uPIuZMFnIiDwd+IPVmYcpPMY7+pG/mnUbtxB5/vA4/OpzETfSB82l24vbH21lO/TEyLfDTp7ta8EXVfJ0Y7L/3iMPQTq93PlGj/7vF0tusIBcGtIxQiD8basUMGNQHsAaZFzNm9fR3cbUnieYVpq0aQjL6Db5xLrSE5AG4p3kc5Nd+3pSW9Hqrt2A2WSI85Xmv22WqRIH1Yy9MEXgAA4w6IoVp4q0eTyIrWrJ//hul9EbroG5VkirMskDg3HzjgmohczboK/2kYC08if+QFmmlXh5fxkAVIEHxzm6MfFOMzG3yLMI4POJOICxcf3lf7WFYDLaOsmhS0pBn8FdKhsuLYEKtIQX4ipewD6h1tAfBA9o/oG0fEbQkdnq75kWrUWXpPKyqgkxJFhfs+mwPVXA0JcZ+ORIX47RldxMHIfe2upRUQCca6FnGHfymeasqsP5UdyrGeU5IA9EpRxQWIuCG70JR4pQVnfO8z6PLf3ZuXG69TAgrFCfwa/CC/rQQDBNGjnc88Xy8+HttQ1R6HbGf3FjXuutY+GDBIjkW83B9nXm
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39850400004)(136003)(396003)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(41300700001)(356005)(6266002)(6666004)(81166007)(82740400003)(86362001)(478600001)(83380400001)(2616005)(1076003)(47076005)(36860700001)(40480700001)(26005)(336012)(70586007)(70206006)(2906002)(316002)(6916009)(36756003)(54906003)(8936002)(5660300002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JZW0KU/CiFvezMzEUazfUiQpwkrmoVi7gCglZoWlsLqDRI9COkJ4i2n+63/3?=
 =?us-ascii?Q?4Clbn8f9QrfN1pRW8jeSYZtPZgOj0ABXfo9pGCIZdlA94vUHtRAWpxvsNLPg?=
 =?us-ascii?Q?VWfp48QYLXegwZFRetuYweIq0ta+6z0ePhb/kvzvYzYlfgt/UPOC2idcelGA?=
 =?us-ascii?Q?9c/UqV2UX5Sb0OmDefnIcovdg3bE2eX5xXEpXRLm+HCbYjV+QL2Pkqt11gg7?=
 =?us-ascii?Q?gHIUyf62QjWe4Os8ZgRJKqqiDXPV8kSMvksTGu204VassDBTDIjUDuc1jKrS?=
 =?us-ascii?Q?wVlAzZjeUqcZWmJr3Ls6IkHJEVtLhKCH4dUjSr5UqiGhDz9qZ7TkHMoil+ui?=
 =?us-ascii?Q?ZhMbE6K2FTuYa25cNvhbV86dkvJqRNfO0gyGZ72YaBZZ/bHzGntNs+b17FHf?=
 =?us-ascii?Q?saFhfWgcKI3gtqWC7cJb52LqVwm15WHjFoBoPewlbg3kQqaD4PSSAI0eCyGD?=
 =?us-ascii?Q?tHIVe0xP48otKpPUfdUEQPN5YxgADUIscLtMEYQJWG7wq0R0tj9PFJpN40rs?=
 =?us-ascii?Q?jximHab4gIsWUgw3I2Acm7+LfzOA1oaQqOLiMAlORzjdbO3puqy0j9glnbo0?=
 =?us-ascii?Q?pj7fPnEF+E2PdY4ZgLVY2YhVfcqs8/Fw8jZ6otdlgpdKxLsw1lG5RZjV0YhR?=
 =?us-ascii?Q?A7Wl+enoH8RdHiImpvmYz0F1UMBTDwBQ/f4rXHP6BeT9WWP6i00pCXzdFnmI?=
 =?us-ascii?Q?Cx5hHzIbzP463b7w+PileipDmB5QtTMod13+aF8j9QfTlG428SXCUn65WA1M?=
 =?us-ascii?Q?PbxkTG4x73iy1npaCTL7MDJ72dHihrJ6hobrDwqo5gvSjXcBO8dkbAoyUWiy?=
 =?us-ascii?Q?FyW1xcW6fAbdR9iUh4WesoTRr6T7pt1atnaBP+imfeGPgSNbMrfen+b3oqqK?=
 =?us-ascii?Q?jVZyR+TaqunxtKxJI8G15Ut59QQdRHa0LHXuFVKgCwbCZpiggDxuBv5m6T4g?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:59:14.5021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a68c7382-b064-41d3-ff41-08dbaef237df
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT022.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8441
X-BESS-ID: 1694015958-111458-13569-24-1
X-BESS-VER: 2019.1_20230901.1930
X-BESS-Apparent-Source-IP: 104.47.56.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamJqZAVgZQ0MDI3NTY3NjUMM
        kgzSLZNCXNyCTJwDglKdEw2dgECJVqYwGxwb8TQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250646 [from 
        cloudscan23-122.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

v3: Removed file_needs_remove_privs, btrfs can check for S_NOSEC.
Christoph had suggested to benchmark if using file_remove_privs
has any performance improvement before using it, but I'm not sure
what exactly to run and actually I think IS_NOSEC should be fine
for local block device file systems. The actual patch got also
easier to read with that.

v2:
Already check for IS_NOSEC in btrfs_direct_write before the first
lock is taken.
Slight modification to make the code easier to read (boolean pointer
is passed to btrfs_write_check, instead of flags).

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org


Bernd Schubert (1):
  btrfs: file_remove_privs needs an exclusive lock

 fs/btrfs/file.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.39.2

