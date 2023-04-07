Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6146DA960
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 09:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjDGHXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 03:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDGHXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:23:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80341AA;
        Fri,  7 Apr 2023 00:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7sMUSlW053cfPZzemnGRfaLTkpooilvn9HtyO/TwEjT8o+89tmvZUTK+iSl07N0I0eGiFctiEMTWeKeAlFL55+qRVswETnlcPxFcUxcEFL3AYeuN5cCMBrxe4LZwXnT5rMmgEU4eCTbdL4q6M3r/bMwlq1To2eBIm65ue/BSk0rHgkqNpGEhmwIsFVc+x09tF55WcXX/QqQezEK7W0SYwsQ/82H/jeL48hhvS8c/IJjWArhwPVu1DzPB/9lyjWJ74a4hJps04lMOswtkZ95xAq1MMyZD/xSIg41wbHRy8vNnPLgfeDocBu0VqtWd9V2LwM50RKKFIEJ+QPUokmedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa8s7jctBAs56tOQIH43Q0IRpOFPy9NjsiCsicmye1I=;
 b=NmF2UPKJJ/0+WBXuZ3UFkOn357sgpbfzig46dl1sznpIE6o78riAW2RlbDOFXimcwUW7gdLOXeRavqZ7kIsIm1Hx/FsZnxF/mCZlJS+Uhtb18AFY8fJfnORjpeViHlE0LjPlEumKnuCgOSrWWNCl9jMhG1cwg13kMH4NIo49USdOxcwa9Lk+3fBn+lx3ia43A3MAyygRfkPjZpRkefMW293zfYiNIPXAd6wnFBsCjJPCf8yfH5Qwy32vfqyJYjN7BQbIVEr5t4Xh7BcrINezgr9us11hmFnTwkYywBKyukMryIsUbEAKB8sLDkGvjXsXC3M93Oxm8CPodipYPNEBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa8s7jctBAs56tOQIH43Q0IRpOFPy9NjsiCsicmye1I=;
 b=qyU4UwFfROe6g2z+W87sM4pdmCBE2oiJW+l2DXNW1qSJjIj5st1JGR+n4HGbzJbpYFmoxT8ymR5fynhNqplN5jrU5eEsop8sjcKLoaagVu/ot2b1fGm4T3LKoe6bsenh4gbPG9Ab235nOrGSno34kABLYkzj0PT9ssnMim2XLFjo+sGW5mXcbigOCoAz9i78z7vFG3obkCE10jV5nKLcLg6xlhrYKqXm390PsLKEd7Qw/K5luaNR1lykwnF1uCKFR84zo2zXcu0Ui7bwYImnVkhMFg5SXLRa8Ltgcx1GoTm55dBvDyBNe1Jv8AJ3+HJsSwueAakoWWsJ9XFohNTQxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5855.apcprd06.prod.outlook.com (2603:1096:101:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 07:23:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 07:23:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     gregkh@linuxfoundation.org, xiang@kernel.org,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     damien.lemoal@opensource.wdc.com, frank.li@vivo.com,
        jth@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        naohiro.aota@wdc.com, rafael@kernel.org
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Date:   Fri,  7 Apr 2023 15:23:03 +0800
Message-Id: <20230407072303.34570-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <2023040602-stack-overture-d418@gregkh>
References: <2023040602-stack-overture-d418@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: f64e8ff4-e7c2-49a7-5e9b-08db3738f344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrQQxl1+Nj+MzC3qFQ+bfWP3vVWJOxdzLSWtkH+CJHCaK4n18SUMQl8r5019K6YUnoVkWr94nurEg2U+B9BlMVvn1WGFtZo8fUE8W8cISHPbGR+5NASlu1vlFqyjNQZtCHviasTmnfnZy1nTL8ZKcSfnmu5bc60JjXIz2F3t+izeESYsJj6+gnqRAni5UjJXh6F2GuZWkU+ycjFDajLrIX4f7SsZFZ6du2Ug90pGVNulTDKVuLWviQ3WSF5ENSFPR7oSF6shvlgYIjmS/rYkLSiCh4SnYUfayqfbzrk8gPVgGgHLroo46crLKE85VNE8oN0WiazZIUtxwNh2gKk3gkKdudeHfHyEkbCPvjR1Vj4EfHXnZ+hmtm/7WhlGECc3hTrt/UkLkszAbwUJ4K8T+g7iCev6VwSxijuGB1jU/n1kPcCo/ZyGkoJdBGK6qTdHaX3nVrMS9wcn7dANy6AIUU8Y4fwm75zrSsZJv0VhybL6n/AewRnYMSx60ufWHnWI3d/NufDL+6rCKVZ0HFNUK7SiubVsd/+xpcBmv0Ydjpzh0Db74EK16MditHW8J4Ha8D4Ek1dMOA31Ox+A6zHmztsI6SJysmH7T6wJ6HsZBuzBKHtykxvXBzdXJZMcM3Ya
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(36756003)(38350700002)(38100700002)(5660300002)(2906002)(7416002)(8676002)(86362001)(66556008)(66946007)(66476007)(41300700001)(4326008)(8936002)(83380400001)(2616005)(1076003)(110136005)(26005)(6506007)(6512007)(316002)(52116002)(478600001)(6486002)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPre3Ujfjn3znLQidvh/XtnRUPF+twcv9Z0mJLykuDsmHyEN5fFh0cMwjrRH?=
 =?us-ascii?Q?5xWW5wjGRjnSHD3KvdyOw764e8b4GJ+bFdSYxVQzI5C+X6404UHK7sLlXl7g?=
 =?us-ascii?Q?o3CTHYrcjMLLrIS2ixT5eVwdgCX53w/4ZOqjC8EmlETZOIxY/qYmA8ca9YoN?=
 =?us-ascii?Q?k3wsyfKxedTp21RqLxwAaSW0ODcdWGM5FVoiwIlnrvq8JJh9h36BARcT7mkp?=
 =?us-ascii?Q?2YIzudZq77fb9cC1JSugoul1AIUfcPUIaIyZ4yfFxQM20OChhlq5qniGpNzx?=
 =?us-ascii?Q?KgdN07Ad1vOfOJFt9M0Urm0sJzlwzO+F3t72a8lRKrjn5Zij7ma+1AnBB+w7?=
 =?us-ascii?Q?59YhjXmIFLNdzgZdjMU7jpLIZ2Ccx61CTEG/8IEa28i4x1xv3yAPxQkrt0Pj?=
 =?us-ascii?Q?OvQpHyGVP0oWQEARl4cxGpo3mrRKiaZG/mM0RFEGYBEp6GEo4BZW2n8d5rxr?=
 =?us-ascii?Q?ddWJdwEQf+ztc8qr/QW9zA+7+O8EHMyO5OZZWGfrDYL1EXtXGTUmLKQQRZ/R?=
 =?us-ascii?Q?bQxPxzJV0pgHXCnBrBv0es+MfP+ZySYbEbrU74SrjXdvkh6H6PJy9NGdFZLf?=
 =?us-ascii?Q?J8qi6wpfew2dWcBKpbXM44RMSHMWN8tx4ihN0cwJED9GuLhzp3z48Rs2DgWK?=
 =?us-ascii?Q?eq6xeWD3WcMF9ZlpADXzGn/xQFwRyixm7N0CHMJyh1uZtfGNI5PtpRY0CAmn?=
 =?us-ascii?Q?IdmPC94+Jj2Jh0ZWJ/RPJ2H0AQGef58nf/lYoqHvK83nw7wBVMXHf/tjV+CQ?=
 =?us-ascii?Q?PZF31Tuv5gpy1EYDvuu2QdQyXOvCbaUW0z0IVZ1uxw2xCdWPQKHyuTDCqJ4e?=
 =?us-ascii?Q?V3ubjJKb15It8H9uzw3267G8RXIUAG3BL8+iXDf4evWM+i44SUFI+mPJBbM2?=
 =?us-ascii?Q?+5OKHvcTU/7diBmzz7GqgOj8oF8kHnPvt4mzQnKMOGI/3aYACTl8otUCURZ9?=
 =?us-ascii?Q?8599znRVQMFOpmXcb0wBnfI3wWiiD6m9kUOMr/TVNyjqrYvxBzw956oLsrmq?=
 =?us-ascii?Q?9UI3S7UeF2N2niauEQaWc8M9tWZV5386bu44WxdXO7EeQWSh+T7p2UwGGZKE?=
 =?us-ascii?Q?wCmphzBgWuIApNjHQYSvYQSh1ODJEG48EbLfd9Q8zIYhwGWgTmge0T98cZDN?=
 =?us-ascii?Q?5Z2/u0Hd2FbGdCmRq474tC8dUvnV/oqstbVNCAXnSmPvxOSY/PT6eGWP2+CK?=
 =?us-ascii?Q?kwXSUjASu3UReP0g6I5bpDNIe3CLzQQ73FrLIiLD45iA2m3r0LJqdkffjcPc?=
 =?us-ascii?Q?ybTTMjn4eGtKaCOALs85Gpom4avBS1VxiJl3btfKCc/8h7LqPsH0uRiCFesD?=
 =?us-ascii?Q?2GjgRc8zyKTxmj0AFOi20gSPPIC+M6hG8kATZWwOGysJ71qWkR7TaNT95ZoP?=
 =?us-ascii?Q?M2sd/BPRqjSeDbfP2h+8WmmYjiT4+t2lXGF66gRX4NCSJF22uvJIgUsF41VH?=
 =?us-ascii?Q?D61k0/S4+WZMfwPxbzpFjwNKV+D2ZwwQRYv/W0GMdYhdlpJQHGMWmEmWwgrW?=
 =?us-ascii?Q?Gr7tUHxEFG4Bf/22JvIBmSVYvefdQnp3sTFOMy4wS9CZ7nLmGboJscKZ4Zrh?=
 =?us-ascii?Q?rr4Fv3jLR/kCxWvHHbDvOCN5JcaKYXcxIsPMp2+j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64e8ff4-e7c2-49a7-5e9b-08db3738f344
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 07:23:14.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJAlYvrX7lM4NlY/4ybnMDkCJROdtlirk1v/I0aUbLx4pCty8iHSFSl8EN3Y/MYcCjSRePoxKfeLAubWMMaHnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5855
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

> Later, I thought I could send some demo code that strips the kobject in sbi into a pointer.

I made the following modifications, not sure if I'm going the right way.

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1db018f8c2e8..8e1799f690c0 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -165,8 +165,7 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 
 	/* sysfs support */
-	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
-	struct completion s_kobj_unregister;
+	struct filesystem_kobject *f_kobj;
 
 	/* fscache support */
 	struct fscache_volume *volume;
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..70e915906012 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -8,6 +8,33 @@
 
 #include "internal.h"
 
+//maybe we should add following thins to include/linux/filesystem_kobject.h ?
+struct filesystem_kobject {
+	struct kobject kobject;
+	void *private;
+};
+
+void filesystem_kobject_put(struct filesystem_kobject *f_kobj)
+{
+	if (f_kobj)
+		kobject_put(&f_kobj->kobject);
+}
+
+void filesystem_kobject_set_private(struct filesystem_kobject *f_kobj, void *p)
+{
+	f_kobj->private = p;
+}
+
+void *filesystem_kobject_get_private(struct filesystem_kobject *f_kobj)
+{
+	return f_kobj->private;
+}
+
+struct kobject *filesystem_kobject_get_kobject(struct filesystem_kobject *f_kobj)
+{
+	return &f_kobj->kobject;
+}
+
 enum {
 	attr_feature,
 	attr_pointer_ui,
@@ -107,8 +134,9 @@ static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
 static ssize_t erofs_attr_show(struct kobject *kobj,
 				struct attribute *attr, char *buf)
 {
-	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
-						s_kobj);
+	struct filesystem_kobject *f_kobject = container_of(kobj, struct filesystem_kobject,
+						kobject);
+	struct erofs_sb_info *sbi = filesystem_kobject_get_private(f_kobject);
 	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
 	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
 
@@ -130,8 +158,9 @@ static ssize_t erofs_attr_show(struct kobject *kobj,
 static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 						const char *buf, size_t len)
 {
-	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
-						s_kobj);
+	struct filesystem_kobject *f_kobject = container_of(kobj, struct filesystem_kobject,
+						kobject);
+	struct erofs_sb_info *sbi = filesystem_kobject_get_private(f_kobject);
 	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
 	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
 	unsigned long t;
@@ -169,9 +198,12 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 
 static void erofs_sb_release(struct kobject *kobj)
 {
-	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
-						 s_kobj);
-	complete(&sbi->s_kobj_unregister);
+	struct filesystem_kobject *f_kobject = container_of(kobj, struct filesystem_kobject,
+						kobject);
+	struct erofs_sb_info *sbi = filesystem_kobject_get_private(f_kobject);
+
+	kfree(f_kobject);
+	sbi->f_kobj = NULL;
 }
 
 static const struct sysfs_ops erofs_attr_ops = {
@@ -205,6 +237,7 @@ static struct kobject erofs_feat = {
 int erofs_register_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct kobject *kobj;
 	char *name;
 	char *str = NULL;
 	int err;
@@ -222,17 +255,24 @@ int erofs_register_sysfs(struct super_block *sb)
 	} else {
 		name = sb->s_id;
 	}
-	sbi->s_kobj.kset = &erofs_root;
-	init_completion(&sbi->s_kobj_unregister);
-	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s", name);
+
+	sbi->f_kobj = kzalloc(sizeof(struct filesystem_kobject), GFP_KERNEL);
+	if (!sbi->f_kobj) {
+		kfree(str);
+		return -ENOMEM;
+	}
+	filesystem_kobject_set_private(sbi->f_kobj, sbi);
+	kobj = filesystem_kobject_get_kobject(sbi->f_kobj);
+	kobj->kset = &erofs_root;
+
+	err = kobject_init_and_add(&sbi->f_kobj->kobject, &erofs_sb_ktype, NULL, "%s", name);
 	kfree(str);
 	if (err)
 		goto put_sb_kobj;
 	return 0;
 
 put_sb_kobj:
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
+	filesystem_kobject_put(sbi->f_kobj);
 	return err;
 }
 
@@ -240,11 +280,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->s_kobj.state_in_sysfs) {
-		kobject_del(&sbi->s_kobj);
-		kobject_put(&sbi->s_kobj);
-		wait_for_completion(&sbi->s_kobj_unregister);
-	}
+	filesystem_kobject_put(sbi->f_kobj);
 }
 
 int __init erofs_init_sysfs(void)
