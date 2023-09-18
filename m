Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BC07A4FE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjIRQ4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjIRQz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:55:58 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD105CCD;
        Mon, 18 Sep 2023 09:44:00 -0700 (PDT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173]) by mx-outbound44-224.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0UHv2atXxualH+iz/FIIwLJ4TlmFTj9oxuLMhGIjUNj0xYRJt+rCdRmdDH2VHo/OMavZA0VEn4n3EaNtW1FnNrvw8P/fLPFQknJkBGZ0fE+LFflPqOCgw1qUfvLMmlsy5wPzdC99P7uY+v9ZIDdBLpmzmtUvxx4CdOshtdbGaNYozzllKdsF5+Wr/fBqctustoMw7tgvcJeMDid/UrWl58Bi8oy4pIs2BFtde5RMgWPjk97EFRNf49C/gFLA2AUJN3P9RqIGLQqqIvJBnGmKj48GNJDcpw9Sen7zvP6ZBE1RIes3sjNhhp2j333L/UGqdxaNEuPxUFl3vcGDHz+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnexB5ObDrCBd2UjCzBCuAxh3eUROHhCyafkaz30oJE=;
 b=XtDb4NfgweM7qGaVzNEph2Uljm3xs+uZ410HRXR/Y+PD7LOAJBg1pvoMsdN8lNyxkGUvQL9wwKQst7lpvXemFWnW7F2lUpOZHHtiU4Hm2iiwcbf7jIFXa++AOxll6UbSA1nU5pN5YRw39mi623R95Gor8uCyrRkmRp13qhdm14osD4So+yY00bR7swrJHcWpqZgHGIteeJX6qUmtA2C/YqUiaz4XGVvBOnwhX3LcyV90RqA1wAVTyfVWA6llzJXRFK9o0U6WCaKd0PAaw6la+4Ny7SWf5RMWtMGJYLD8GI+4bz9dYahWH+Jj0qdvsVpJQbwWy9LWNWjNeJWJW7b+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnexB5ObDrCBd2UjCzBCuAxh3eUROHhCyafkaz30oJE=;
 b=nwYNNgYpPdS9j6SnrlEp4eGsaEsFaWVvlUhkPtHCx0iESeHpoCuRhE9XthMgOcFFg1z5ByXkuUtW3z6THwRQsf4xushfOPKtqBchaYhIsC/KBTxjCLfjQ42Yq5zBEksrOKvuH2fB2fbBZw1S7oytp9TPQZIkMIefJAdNiAZfJ5c=
Received: from MW4PR03CA0111.namprd03.prod.outlook.com (2603:10b6:303:b7::26)
 by DM4PR19MB5835.namprd19.prod.outlook.com (2603:10b6:8:66::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 15:03:20 +0000
Received: from MW2NAM04FT056.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::32) by MW4PR03CA0111.outlook.office365.com
 (2603:10b6:303:b7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT056.mail.protection.outlook.com (10.13.30.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Mon, 18 Sep 2023 15:03:20 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 6500720C684B;
        Mon, 18 Sep 2023 09:04:25 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 04/10] fs: Add and export file_needs_remove_privs
Date:   Mon, 18 Sep 2023 17:03:07 +0200
Message-Id: <20230918150313.3845114-5-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT056:EE_|DM4PR19MB5835:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ecdddd77-28e5-4bfd-4721-08dbb8586586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3drmnCselvCjcCLjr3v3prn+mGKWfhb2Ek/trhk1mUtvs5dru6dkBGUffNcSnJ+RcpqrWYjb1ynX293FoGal2GI/+ovA/K2wLkt3Dm9aXrQXzhCmmjRK4hNhOowPdgzjS1lv6vKhYKTz10YKNKlNp2top0vpWjH4AmdrFiC8QtzyqQVXx4hAYWDocL0/XYN90ub/PtXPQVyWfD55icZsEEk905DNCfZZaoIMLFTKz9dpkzt4qQPG82GoMKRAaZ5GkocjlO0mTFeCUWGi1kkPNSml2C/ZyDiSjNL1wqxMYa6N2odctPBPI+jMXPusrJfwAFxO3OP2/LxCypy77eqGgSXR/ZfJokcbt/puO+G8fI/9tEi9uEanr7qytNh/gkY344PHHqNJwlYz4IHW/qxc0u3EPS1uq68sZ4rnf+PdlRRUMajwIxm8zcF2fA+sP3l2+3raQAMvBFpbX0X26uOJAkkx3HLt1GGYNgkdCYC+pN3rIMoP3z75Z1fpFQOKrzc1zAf6tb3hZyap8/lLXPkf3SLn4vcWrDzdDhY4h0CxIsP1/ZRRR3OdLa3rDaGBSEaK4+SL/MGzohrmjuw5avh+NNzEZqedKpJ2mZK/m3RDxvsBCXjLz5q8eHQzAs8QILMpgjuMVHeemwncsn9e5i2ol93ObggoBCADzfcWrjeepmETVFT93aZsNKP6/tCSmv0Pn5kHspOx5SHGkatVh2jlbFKwUyxGlTngejpBo2e65YBIhaPDWjjtXksB1a6e/Le
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(136003)(376002)(346002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(356005)(81166007)(26005)(82740400003)(2616005)(8936002)(1076003)(4326008)(8676002)(83380400001)(36860700001)(2906002)(36756003)(47076005)(336012)(6266002)(40480700001)(5660300002)(86362001)(478600001)(6666004)(6916009)(316002)(54906003)(70586007)(70206006)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/Tu8TLSI8J40LXYcEGKvs79yCr+O5SBiR29url4OMb1/7s1e6dWVbSSNiqbl?=
 =?us-ascii?Q?n2FMyApJHdOkPlMwYYoCTyGEhyvU1QUF5zktRLwsQz5Wgu8rcXtCEDdc21V7?=
 =?us-ascii?Q?4NeD1D8xiX03mUorvF8prE8Px1gQXkvDJ1ZrCnP7MKO1/dYOiT+BAANpQ1f2?=
 =?us-ascii?Q?lEZF2P4XfzlQv+ev8wQWsjjfkBAW21YDQKw1e7bkgVyNBWX4us3YTu9FI7B0?=
 =?us-ascii?Q?xxfXSRbNumByyMiXiD/IKhHHCpx+iK1KY6XZB2hD1a/xM4Eg4M6CnSzQeRCY?=
 =?us-ascii?Q?1F62t3aMExfJErtaxdw4+bOPvKJw+JTkRoEDt0l+hUQRxGft3dQvhxPXccGq?=
 =?us-ascii?Q?zQhIcPRRIQP49VY1avE0ue7B91c6Cz3OOYiAu1riw49v3lKoEHo9A9rEuZOb?=
 =?us-ascii?Q?0Ga4r+heujjUQlew+wJvmtMKOHP/nDhOuaMn+zn9U2XFFjufTmeh7EKgKpvl?=
 =?us-ascii?Q?tKeJmJnNQlaVNAKRxC4zgdXSPtnobvm8mCVVCKmE3D4rLAhkvBLNL7Mz/X8M?=
 =?us-ascii?Q?uYYNJ9EKOfQYWe89T3Hu1ij09jRZzKx608j8ATlF2p7s9hNiPw++61fiQEso?=
 =?us-ascii?Q?n8v+0RXEFOWscuaO0A299HbpFb5C1wTjRAKaOfm0CC6g/u0554BfBTzKlCyQ?=
 =?us-ascii?Q?ZdRpqaADG2goadaz1H6sCMl8Ctr/ZOhqL1iTRknCnOtLXZZ/65cX7RUAtBPa?=
 =?us-ascii?Q?nic6pddx/hl8aU35qNnDRNtrWHNFosAhGWSrTEqchgMMdnvxZeSBNNQdtl/X?=
 =?us-ascii?Q?Tc72Zmhz9azHTuJtnvNCEOFhrW4+ogNZHfqHAp9gzZCgf8xi9TO9Y1PZac9d?=
 =?us-ascii?Q?/8FO5zxLqLH4miTYMRIWruZlbE08ouDnCAf/KbPznGi8iqI0hFagGZH/ps7T?=
 =?us-ascii?Q?A/rB73LUsAD3L8KixdPXhesyfyM1Wx4X2bcK5sMzp5SNelhzfMI44G3w+DK7?=
 =?us-ascii?Q?p2efPo1ZzgPbX3rXyf7m0PN6xQd7vHs4hDBM5HEJmag=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:20.2207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdddd77-28e5-4bfd-4721-08dbb8586586
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT056.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5835
X-BESS-ID: 1695055438-111488-12353-4715-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.59.173
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobm5iZAVgZQ0MI02SwlKTHZzN
        wk1cDcIiUxxcA0zSwtNdnUONUkzdxMqTYWAGRHAMNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan17-98.us-east-2b.ess.aws.cudaops.com]
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

Fuse cannot rely on S_NOSEC as local block device file systems.
In order to still being able to parallel direct IO writes,
it is going to use the new and exported function
file_needs_remove_privs() in an upcoming commit.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-btrfs@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
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
index 562f2623c9c9..f7b45722bb6f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2721,6 +2721,7 @@ extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
+int file_needs_remove_privs(struct file *file);
 extern int file_remove_privs(struct file *);
 int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 			     const struct inode *inode);
-- 
2.39.2

