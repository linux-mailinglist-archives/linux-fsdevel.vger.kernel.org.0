Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD278DA7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjH3Sg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbjH3SP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:15:56 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96E132
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 11:15:51 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103]) by mx-outbound19-113.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 30 Aug 2023 18:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAFVlAm60K5C09gOx4UmY3JhZZcKl8nZFSkVLV44QVqp8pYi8Bq47bVJSRbD5K3zxBgt6phdpOtw6FMBcn4UrrPnTrWj9ZMDCheBRNGsohDdfZLmIhzcZ2w9kIBBJNCg8YGXnZtIQXSLtPJhVxGCiqN9XV6qlErIY4z5sWenOwHnSQ3omHac+iRUyNNPPM8nuLoQHjCxeFs1SGSg+Elg9FQhtTZ3xg4tSirnVSIhJ4T+kV4nfSeLMU4bUGX0X+aRCKgD4p31a7eMATkvi1UiV/voNDymj0LioKmc4zIsAz8qOaOK9u4tgHV/u+r0JIweyrAdnbjSi1gNmAX3UT8LIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF1eSqoL5JhboBKNpfZY3n9Bv/tC68B4oK8Zk/vMHK4=;
 b=jFJ4u8VYOT2r2KLiFIIxRA4cB/TNgRFKcUESFkZzgt/D7TyKNWXl3ZRy8pY7aTer+Rz9UZrAsFZDonmI0UVoX84lOZhQWztL1oi5duzftMWg89ix6TcAxxkSF4lNMvBYF0XIGDhg5KUO/IyuD8kTzHvTn1gVcfYwPE4mDED0GoR5xBxdSu8QvWrms+LVD3EDO3bJf55wztsdNOPqoBJ28RYutATJzBBi+qM5LWrTa/u3B5GmG2P++klbvpB9cN4rnvsr8JCyqEMvjm96mQsNjzUTEX+xK2J7Gd04RZeYR6h8ZxizGyarMjdVQlgryd8Nwu6+njwu/Qms7VHTLvou9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF1eSqoL5JhboBKNpfZY3n9Bv/tC68B4oK8Zk/vMHK4=;
 b=xRJvUdcZa38aE8R7O8bbvnNut42Ai8VegZOpbOyDL2iRysgcuPspASbiAzumFRHV70gIeqet4Q3tZ/AnHB5f2AGh44hEl3oAqrzpFUi3TG9Ume6cOlN7GNPPIC8fSSSClc1mbLFr5l3a8orS5yQ860+lE+JG43Wu99pwY0I6HTE=
Received: from BN0PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:e8::14)
 by DS7PR19MB6422.namprd19.prod.outlook.com (2603:10b6:8:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 18:15:25 +0000
Received: from BN8NAM04FT019.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::92) by BN0PR04CA0039.outlook.office365.com
 (2603:10b6:408:e8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 18:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT019.mail.protection.outlook.com (10.13.160.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Wed, 30 Aug 2023 18:15:24 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 6CA1420C684C;
        Wed, 30 Aug 2023 12:16:30 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/2] fs: Add and export file_needs_remove_privs
Date:   Wed, 30 Aug 2023 20:15:18 +0200
Message-Id: <20230830181519.2964941-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830181519.2964941-1-bschubert@ddn.com>
References: <20230830181519.2964941-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT019:EE_|DS7PR19MB6422:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 003ba8fd-34f6-48a2-1c5b-08dba98514f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVacYzyqnXuXurDUMIXi0ebCJvBi6Sv9OfXk2rqnV5i73K1rUOa9qOOS/zLxB9oBIny2wcjfBiNogy4ZMCF0EEHT4p01i/QpbfoIueqPQ8uCMulo3PvbUGTtB1wyGSfq/86H1w/lJcFhl5UrEDRzm8dRjVYOuumwu5NCrxi8+cbROV/OA99Tz6RSmdd7fCAIu82FWCHUV9JXIkYeabhUgpLIacg37cc+yjKREXJnFF2qYoI7nVY7rBDKkktmTb0JR/lRTTofXAQmLXxY5j64kHnHpWqa2VuUJbl/S0bzVZVcOyf0kkyF/9SzA1L3rAPYN1CxzTV7CRxbCV0NYyeNdPeJQUlWPodkKqdO3ZE9p6kBSdDl6jbGfcwBr78rP4255CmpgvWVMSugfq6+zwrktTuhMdedTjHdtAt0OC42T1IQHM96ussmdIWt2Sfgsm5t6JeWBxUbq4tqPKKjYelQH/729gPx6NLKFQ7xIkEx4vvhSeS6/BTKzCQbMvDXXRaWGezvXatqKDb9fsenYPbjTNpTrli2A2nyRRifQVk29jpLXjumQu9iDy9/xgBEbN29/4SV3grOR22YGTT93cD9HydsbjjBMmrVSYAS13xe3Lm2sqkMl/LFR3ZECRz3Z2CCvOQNlC6ifsv4rDlgywPdIceTye9Gt/wD9jR56fnBdIR2cNW4Qq95UWvvbL7yJA3n/zPQ3Y0ZsWDtJPiGptWtU/Sf/7xIHosWN9nOOl+AuHD8iPfHFyCPV5CldLdo+n1K
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39850400004)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(316002)(41300700001)(336012)(4326008)(6266002)(5660300002)(6916009)(2906002)(47076005)(83380400001)(2616005)(26005)(8676002)(86362001)(36756003)(1076003)(36860700001)(40480700001)(8936002)(6666004)(82740400003)(356005)(81166007)(54906003)(70206006)(70586007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?B7f73LEUFFBR/m2lnX/nR+OKHU0OAId54qEZNYTJJuRu2amY0EYbT4aZClDJ?=
 =?us-ascii?Q?3bGAKixbkls6BuHfDTvL36VewOyTvZWHL24avfYHSG+JdcdHpekFOI0rMiD8?=
 =?us-ascii?Q?PMQP/Dr6gVOEIn+wcbu8r2Ztinp8vugmbjZjFB4V/+beOBlU7p35AF3GALID?=
 =?us-ascii?Q?Yp3S0VM3KEyjopPc7MuIPHaEnbrJ8CbM9jy0bl/sGsOSePIhmkaWFto3KxI0?=
 =?us-ascii?Q?0BdXkupDjcyAQ6/E3kGq15I8iTHuJLt3wbwQyuzoZ3LUbkdrR7bWsGmVD6co?=
 =?us-ascii?Q?8EN0Ep0Va3YSPknxd+ykUnQM9vg7RDYFJXL/45pwHVN00kKKAldjsiVXG8PC?=
 =?us-ascii?Q?7MEITPIufoQa/MOZvYO8v/qZwbtgrhU32w+BldSVchc+mQfgjAEQxkAUc0Dm?=
 =?us-ascii?Q?hOQMYADrXSfXVRUQMdqLHJHmcqiRDS5mtawOPBMuzrmQngqOnkJHwY9YarKV?=
 =?us-ascii?Q?9DD22QCBy2LZJlgyjEHEpNZrd2fKFA0XpEjyh8XrRHxkCCkONg7x8tChibFm?=
 =?us-ascii?Q?n3s7Hoao8Sumnns427GzpnQNKsvTwNWaKpkOzk8QgIa8YYrgiTlrpu9IIqKI?=
 =?us-ascii?Q?BnVsZIj8iO3U706hmuUOUE8hGbdTQ9s5OaUnhu+JgoZdYyEg9hQBwS+bK5pL?=
 =?us-ascii?Q?sx+jVL7D+G/cDv0TzQnULTOihinXwJDDDLBCq/drR5wU6PKHYUjoST/9COPJ?=
 =?us-ascii?Q?4/nHzjSpxSzkO6eQFiPzVbex9u7dru40NQB2+8uHLpd3s7AfrC7ohd5NhceK?=
 =?us-ascii?Q?WcUU0dQ+V1YH3akb3FHg9IVaAzzXG7i+fhiy8+0rgOz/AiU0QZyip79mnc63?=
 =?us-ascii?Q?RuxxEDU0Za/A0UKeBf1oWzm+i3+thja9/N0jjPnYCOAMZ8b9HKXdOFGrE+X2?=
 =?us-ascii?Q?RWsxx4vJt7qBTGu5JcyEC8eQgBjSp9QtoDy/7c6orlidzJ91NBr99mfPGBxA?=
 =?us-ascii?Q?CqKL6Rltd4HFiMUaXBOHKpvTEVnZ8V26wsA/KTuIpdM=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:15:24.8741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003ba8fd-34f6-48a2-1c5b-08dba98514f1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT019.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6422
X-BESS-ID: 1693419330-104977-12456-13-1
X-BESS-VER: 2019.1_20230830.1749
X-BESS-Apparent-Source-IP: 104.47.70.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobm5hZAVgZQ0CTZONnUIMnIJM
        0szTzN2CQ5Lc3AxCTVJDXRyCDFICVJqTYWAHLaTghBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250495 [from 
        cloudscan10-231.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

File systems want to hold a shared lock for DIO writes,
but may need to drop file priveliges - that a requires an
exclusive lock. The new export function file_needs_remove_privs()
is added in order to first check if that is needed.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/inode.c         | 8 ++++++++
 include/linux/fs.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 67611a360031..9b05db602e41 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2013,6 +2013,14 @@ int dentry_needs_remove_privs(struct mnt_idmap *idmap,
 	return mask;
 }
 
+int file_needs_remove_privs(struct file *file)
+{
+	struct dentry *dentry = file_dentry(file);
+
+	return dentry_needs_remove_privs(file_mnt_idmap(file), dentry);
+}
+EXPORT_SYMBOL_GPL(file_needs_remove_privs);
+
 static int __remove_privs(struct mnt_idmap *idmap,
 			  struct dentry *dentry, int kill)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 562f2623c9c9..9245f0de00bc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2721,6 +2721,7 @@ extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
+int file_needs_remove_privs(struct file *);
 extern int file_remove_privs(struct file *);
 int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 			     const struct inode *inode);
-- 
2.39.2

