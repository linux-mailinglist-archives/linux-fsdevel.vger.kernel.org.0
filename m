Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AD378EBEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 13:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbjHaLYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 07:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjHaLYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:24:52 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A1CE4;
        Thu, 31 Aug 2023 04:24:47 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173]) by mx-outbound23-180.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 31 Aug 2023 11:24:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJLnrUb9DjlcMkdt7rLmD5506MtfxAv3AKZjdt/e0bxXh3b8iW1z3oJ7d6vj2c/qfyWzRGjF9BU8pu6w59hPc7ma6c7Ld9rPO9xVT+XqNR3uU62cEyKDIewHW19BOAwqGIMbSBW7dasfkNnFW8p6aNZXBCz9Hw0UzbjLsG3aWSvp/LPYF3FhFRgHamb5beZ8nEx+JCH1RgQ6aRACBa2gx1qMnY7WAqQI3FV9+SBpRNggwSHyDNclxAa90PWWeiN2LzB4/VpweXQxvsmXCtjvfn3Nl38Q8RrHPsVwGkAx6Fv2VaVvDD/5T/vmPiQyh7lOvnESnYsBkXa2N9y1Eegzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF1eSqoL5JhboBKNpfZY3n9Bv/tC68B4oK8Zk/vMHK4=;
 b=gszn2JlsTogc2RJ0/8cFZVjqKI1EDKlo25HM9Dw12gc9ex+U+zpn6cQdK8SSy99B/7Z2A6tnj74RywqIBLRAjveh0C/zaK+wF1Fl+ANf4peVk0izk2iPky3L2DGLnnaUo3rvJXuTc6H4geXCGJitXKzM4FQusJbS+Ac4Y0hI8PECLGk/uJJtcWqUPgpOBKhLxC/+1wlkBAsQ8BdNTx0PP8n+IGc4mhR+1l/EOT9pg5b+ygLbrr8BwH6uTVZ9gnvYvW+jYBYeJ4qjnkjYMjE23luulIZcj7QuySp7Xz0KluRVK6rlCgikIh7zusPfzCkt+E8axjCbc1sqli0c5yD4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF1eSqoL5JhboBKNpfZY3n9Bv/tC68B4oK8Zk/vMHK4=;
 b=0xXjJCnX8IldSVhykRoq6DJyy8C6Tp8qqbNzYpzUpZalyZzHVNUVyqHYQCzHZgyBCTeurOfmxlL8n9WrNeHT4CDbRhp99h01KPZgwVFyOhzC7WC1tXdRaw6NNDQqCF/W8ZqnahCev91Fosej0Howy1MSfzH51iGnNrsHvVVe3Ik=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by SN4PR19MB5376.namprd19.prod.outlook.com (2603:10b6:806:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 11:24:39 +0000
Received: from MW2NAM04FT016.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::90) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 11:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT016.mail.protection.outlook.com (10.13.30.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21 via Frontend Transport; Thu, 31 Aug 2023 11:24:39 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id DEC2C20C684C;
        Thu, 31 Aug 2023 05:25:44 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/2] fs: Add and export file_needs_remove_privs
Date:   Thu, 31 Aug 2023 13:24:30 +0200
Message-Id: <20230831112431.2998368-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831112431.2998368-1-bschubert@ddn.com>
References: <20230831112431.2998368-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT016:EE_|SN4PR19MB5376:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c7a0a900-3007-48be-dbf9-08dbaa14dd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfav0BfFH9YowxrIhHD/YX8uH6IlAAhYfccc7SXUcwCeSbaGa8d2zDaGPvMikpnVgEJCvRWxEFZ/cY8PnQcfSdURUu7Aj+MJbuXsybsRUvz9TJtAcZYjSlyjVk+Gm3Um1f/dEAkeKe+OakoAOMB7qd6lTnyfnM2tMZAXH5mCLJmJodpCE+3IsoLDULIKo/dys6yFd23to5Ck9JfkRAjFmguMO1rWqIy7CXDPEsnnIubZ0jPwSoUeSB3WLHRzyoRKFNhTRh42fCMeF4BvRma0akwlarqXxEhc529HyT6BpFRNBnPUVzmLQf5BYG5lYIzk3FxswKzLI/swl5V542n/XhrcnsHmbeuu2DoLSr1+vHSD9MkDb7rJyFfenMPzvoGJhFkGuu7RPm7CLYbTTvJ33TDGCO9ivSKEINDYI3CkR7IUgccl5/wSWRPJf1y1ft2SCs+GxlDa9DIYVZbC3m/4myXvl7hC8yGoYv2kKqabb8T/yzfSswARsdtsCY3OxrAUbkrDF/VfVwYVTJri3xrMrghUfeEOoHye1fxgVb3VX475F1gZMXRvakEsF6sVwuWP5ql5bIirQor4x3PD+H3qMpl+eMfS7Bb7Bpe6DclTATK7BvS2p54oY8o0Y/3IH2MZmqLJdOZdp+pdVvcy7Ei9dDJf07Y7VBkl4dee8YZjAVIt9RqSKSHbKUeKS+Hl1lJrFQRy3+yjidLNghl64gAPm1poBlIHIxKar/kDSO7HTasPzZGuxxwSu1AGYkMjOYYw
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39850400004)(136003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(6666004)(478600001)(83380400001)(336012)(2616005)(1076003)(2906002)(6266002)(26005)(41300700001)(54906003)(6916009)(316002)(70206006)(70586007)(8936002)(8676002)(5660300002)(4326008)(36756003)(40480700001)(47076005)(36860700001)(86362001)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?P9hsXdg3cm2yP62cLGp3J7pBhbXAvMrXD21D+OzTHjM54GEYkQTArz5uOTyD?=
 =?us-ascii?Q?RkfdU8hIBcUGHVbIrcezSXwdUUnrBm9CVZR8CF5iYuofkdGzVP6Khrn7Ddse?=
 =?us-ascii?Q?c2VlxPplWLBCHXh1hnUperXqq2FXYt/5sguyZhx6xwDXSsRGzIpEdDoQJCrx?=
 =?us-ascii?Q?Zuu02yjhu2ESPN4Y+t9qwOA0tqQeLweogdJ/5mN+9rWtK8Y4JWGXIVSsyp5z?=
 =?us-ascii?Q?n31XZVOSd8UX9pyFYOb/VrZs3L+hYstUX+4MIhNVXXZoKP9VjAkkQOkPXXKD?=
 =?us-ascii?Q?doUqVVsSf9Qr69a/aH9S9kXTdyq34qkRVlg+xrhA6TBBSb50POyuAulCNLnR?=
 =?us-ascii?Q?eYaybhYjD8AB+jL0PO/MLAUT4ct6ZUlIcec2nzluyQiAlpvqw+UvuYt6Hsmf?=
 =?us-ascii?Q?v5IsiJnQdXDzQeTvR93U7V3X3tt7pTzDDfzVEPItabIoOHXULxPYRh03wD7w?=
 =?us-ascii?Q?qWBt/zGamzC7pkOxeY4Udn8WGgCjO0ONwOXyqd5GFmdPM04cn3v6TIMqrPyK?=
 =?us-ascii?Q?Fb7qxL3VeDRqDa73aupTu6zNCSGtnJRZqobWJSsVfGQBxdgrl8V2kHLFVA4o?=
 =?us-ascii?Q?5vCEDx6XMiW8EVrLDDWtr+dzV8xKylL1ewW62ZvkguCJjxI78EZW1NaSFmoj?=
 =?us-ascii?Q?t7yW23NqagB1JjsW/oTPrDhsLEHtp4q+i9JPfQfUv2Vr0KKm0sHii8PvJdbY?=
 =?us-ascii?Q?22VUHDxtWz5NHDG7W7LHBvEyRSkJbIRcCCE9Xs+lpUPc43pmaf9z3hdERWey?=
 =?us-ascii?Q?X+wmBjrEbssk6X0IuvaAfxoShgmjuB3SZTEIf7zxlCj15nky3ZKgehax9MBW?=
 =?us-ascii?Q?nQM9ybh4JXW81IdCRluypvLNNpMb1ja3+h1i8eOyqx9RcyxhhFh0HAusWfjo?=
 =?us-ascii?Q?+6/CV9kwxTKZiqBTbs9VqE/RABr/ZR7vT7rihg88L4gBIQEDHx11F1p0Ssfm?=
 =?us-ascii?Q?EKHeoJ06DOQqlxfde6N8Jm52vtY1I9wNcPzXfWcRM94=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 11:24:39.2652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a0a900-3007-48be-dbf9-08dbaa14dd63
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT016.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB5376
X-BESS-ID: 1693481082-106068-12764-70319-1
X-BESS-VER: 2019.1_20230830.2058
X-BESS-Apparent-Source-IP: 104.47.56.173
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobm5hZAVgZQ0CTZONnUIMnIJM
        0szTzN2CQ5Lc3AxCTVJDXRyCDFICVJqTYWAHLaTghBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250513 [from 
        cloudscan17-18.us-east-2b.ess.aws.cudaops.com]
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

