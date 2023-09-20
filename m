Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB87A8AAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjITRf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjITRf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:35:26 -0400
Received: from outbound-ip201b.ess.barracuda.com (outbound-ip201b.ess.barracuda.com [209.222.82.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96462B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:35:14 -0700 (PDT)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48]) by mx-outbound16-233.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 20 Sep 2023 17:35:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwafHqrbPwqwJlBd/0aWG8D7qF7eMpNsER22zOfoaaMAwSYIUA0g1S4Wcf4lZc2ieyD6qJV6+5n1MGVLJ80e8f25pFdGBG4rvnScfma6owocNZq1xsPGkPwOLSSs+lKdnbaqzaZ+fQJdjufTIQu3aw41LAfmchIawkbErbsnYRvUvff6lSQmT8vd+H/WXlm7ck86m2NtnvGq+WIoOHRhITWf1O7dQEQRz1iJgRVfpXrAqKnNVi8bLby+5dni6xyMYfx5YFfOsUt5Osip+ZrK6QgWMSiF8hWDpBuN2KQmQU0yS5pFFnQ0jMF8iyX/V5rsRqpWuuapJBIKeBcFbDttXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXR/rdIx0cAylq+12eF8vnP5D9doFD1zmaDrJFvyH7g=;
 b=VTz8g/yCGppFjxtCcqnqT8mwmGD8mpFexeQQgLu7nUNOQw0vmmNwquPxrKfpMRIlyz5Fg4aK/lvsBD1NGDGwc+QU36o9yvB6od8td5QWYprj3XB4fcZYQcP2BTvQanc2FP10JhX9IF/OEL5vGHEF2RqXYS1kOmI7I83r0o1oh1b1puOz4qGfTMDgmOysBPMT7nHN3E6nelxuqmCWtyloZdKW7WF/XBI+id6TBA8z/0Ii8xOYmH3wz52YTW+K2qhnf0KydubWk39dwk6ZK0kqAOcJ4OvjPxfF+YzRM9/p5WOPxMEwUihhQQ3WZnTEJXYoizrGGwCjfmo1W7RQfBMxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXR/rdIx0cAylq+12eF8vnP5D9doFD1zmaDrJFvyH7g=;
 b=DcCsVmU5Frsws9GAkGm6b4n8t0uL4uJihQwUlFvth0c4aqZxhpC6BB3IhygC0CsvJ/lznSMmKxJWmNGrPTfmgY4tgr1V58m5bgqmL0FkWPAzemDeR+lbIADcxqac+q+5R4TvaX8PyONJyKq+LHCY8Nencf0Z556gMqsxGO6YYM8=
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by DM6PR19MB4091.namprd19.prod.outlook.com (2603:10b6:5:229::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 17:34:54 +0000
Received: from BN8NAM04FT020.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::2c) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 17:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT020.mail.protection.outlook.com (10.13.160.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Wed, 20 Sep 2023 17:34:54 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 41E5020C684C;
        Wed, 20 Sep 2023 11:35:59 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v9 5/7] fuse: Revalidate positive entries in fuse_atomic_open
Date:   Wed, 20 Sep 2023 19:34:43 +0200
Message-Id: <20230920173445.3943581-6-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920173445.3943581-1-bschubert@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT020:EE_|DM6PR19MB4091:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1bc5f4f5-4091-496d-0aae-08dbb9ffe6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VChQ28SZfP+wn8bcUZlFilUFxxms9ifVECiGIlzrygQn3laMyVDK3zSOMKdr3Db8BoHLbMR9gOIZ1hwqvvaHWNSMvwORFS8eML1dxwhYgnwfc+D3aOorsdP0oZq++NbfewpAnmoia8h+mEH2ASHWUlANJngMXSHsKr1khs4h+KL85bPRDxt7Zo8jI/zuClGb49MySDkCtYPg/gsyR6TUS6mkhZVMB5D1eczgABrz33GoyLQGgwmkBzIoRKKX8UUlrk1a/pKEr9bsi2PEYGMXSU8HL1at/VTsFp+Op+ODIv3IxZXMSp7AYiQuwYlX6+0PbkfC7voQ214+jSplNpv9ncxO9+YALDToWu+cbfvOWfoE61h4/gzkJKd+7X+p+4T+7dNqato8zF7pLR9XMt3j46iaoS9u6aLoizK6kKodAlQsk56obapdcvN57c/80j8WZMz+1v/zGThNCQES0skJ+JeS0UiEduguuG8LCPvRgj1jJ0SumBXOIYCdvYXZqhqlz3N4A7IG+abbiYcQ6+DK8jHI4M/OoihxreKJPGldL8EgBlIJ7xBrPnJ/Db4/TuHs+yThUec9gUPqD2zlnuesVFLaqAti/b5GKFP0NWmgGTT48aUG31/0891GdVzMIsYeOPXPGa6DpWny9w0a2Ke7M/JI1e7VEeVoA0qYtsev3r9msJg3sv4g6CAaj6NY7fzUXeCXj9W5hgXh+CHGgs1ynvOtWRs6S6gsbS9rrr1XCRosVmw5lt1RwGSLQhgpb3qnnmuX1e2Nc8/5q1UaIDOoWWeVFl9a9u9gtidGK/0B/KM=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39850400004)(136003)(346002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(6666004)(478600001)(356005)(81166007)(36756003)(82740400003)(40480700001)(1076003)(86362001)(36860700001)(8936002)(336012)(2906002)(47076005)(26005)(5660300002)(6266002)(83380400001)(6916009)(4326008)(41300700001)(8676002)(316002)(70206006)(54906003)(70586007)(2616005)(21314003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?W18o46EMT9ydov2OlfEIon4j5zEAdsJ+z/77EUuKkb6nlIYFhk4dyVbHkWsH?=
 =?us-ascii?Q?Y0o21d6Vs/OXmoXGb23KVOYkwAn1+crR3ZPGjNGTCE/BgFKDsbWlr/LVm4NR?=
 =?us-ascii?Q?3SksthELJJsnKnjwnVUUEDFX6qCniKGCTLwjIUEmgPH/mKS6sC/6AfhDG4z4?=
 =?us-ascii?Q?6cr3PgeomSXXMgL5/wLTtwpP1030L8E1VpWJuzavtu5Phu9EAp1FQ/hbESrZ?=
 =?us-ascii?Q?SC+tVJD5n3USxqm35p9x0WL1GIyHxUBq0PH5LjKegVMsCoojxeW97RO98Xdz?=
 =?us-ascii?Q?GuXJC6/vCulDIoOn2CbOsj/yUskOWWlvPtnZje0/CTkRv2099BIZ/Yd15tYa?=
 =?us-ascii?Q?0iYt0mZSdt4lJXOhj4F6gyXJVtuCoOmET+S8SXh/0UY2Dw5TTn5wnOvDCsJN?=
 =?us-ascii?Q?bW5U/nbT3uTCmDTL/wGpKOsdL6eL7JfHnCfLMUTlunltHXdPJiE3tLwK3DK7?=
 =?us-ascii?Q?GvGIhlfeFwcV1ILslAc6heZeUAz3d2KVjGTvYX/phQIiz/Utb1QLuRyS8wAv?=
 =?us-ascii?Q?lCI20S8dgeutQSKEaOjyPneenuH5pDfOsU85iZILIZvzx6t8wRsZG0qkJvd/?=
 =?us-ascii?Q?2AK5epBORIcw+kwBWUHjNaSRt/bAR4o6nkzej/P/BzUvRmyU3X4xevrc+e/2?=
 =?us-ascii?Q?o4IPIgeOh7NrhKngzL6RmEBnJATmX02UIlDkhSMREI+UosXMfsDqCtlX7fZd?=
 =?us-ascii?Q?HxDldSC/bb6kOlwrHLy6kGTsSCWvG6JtrMLR71w3DSvETAjwdx6GpFuMY3AD?=
 =?us-ascii?Q?MOGNRZE/QAaoFyO7aL+/xVnwGz3EH5bWt6/vartOvVx+DC4J2lzumxb25tjd?=
 =?us-ascii?Q?1UQfNnZuHX6qHBd8C6mIJXfgBWZuFmTg/YJesR7CCi18tzGQ4BYgFzahdpz0?=
 =?us-ascii?Q?CKlzWqgyJkzB3aVremiVw0oyLyorUJCgiA4QXA9PV3JfSCfWZXpoCDpVCSBn?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:34:54.2146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc5f4f5-4091-496d-0aae-08dbb9ffe6d7
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT020.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4091
X-BESS-ID: 1695231301-104329-12361-15483-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.73.48
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmpmZAVgZQ0CTNwDzZOMXYND
        HJyNjY0NTQ2MDM1Mw40dzI0MIw2cJYqTYWADlJN7tBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250962 [from 
        cloudscan21-118.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dharmendra Singh <dsingh@ddn.com>

This makes use of the vfs changes and fuse_dentry_revalidate()
can now skip revalidate, if the fuse implementation has
atomic_open support, which will has to do the dentry
revalidation.

Skipping revalidate is only possible when we absolutely
know that the implementation supports atomic_open, so
another bit had to be added to struct fuse_conn, which
is set when atomic_open was successful.

Once struct fuse_conn has the positive 'has_open_atomic'
fuse_dentry_revalidate() might set DCACHE_ATOMIC_OPEN.
vfs use that flag to use atomic_open.

If the file was newly created, the previous positive dentry
is invalidated and a new dentry and inode are allocated
and linked (d_splice_alias).

If file was not created, we revalidate the inode. If inode is
stale, current inode is marked as bad. And new inode is allocated
and linked to new dentry(old dentry invalidated). In case of
inode attributes differing with fresh attr, we allocate new
dentry and hook current inode to it and open the file.

For negative dentry, FS just allocate new inode and hook it onto
passed entry from VFS and open the file.

Co-developed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c    | 203 ++++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h |   3 +
 2 files changed, 176 insertions(+), 30 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4cb2809a852d..aefd783c7552 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -230,6 +230,19 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
+		/* If open atomic is supported by FUSE then use this opportunity
+		 * to avoid this lookup and combine lookup + open into a single call.
+		 *
+		 * Note: Fuse detects open atomic implementation automatically.
+		 * Therefore first few call would go into open atomic code path
+		 * , detects that open atomic is implemented or not by setting
+		 * fc->no_open_atomic. In case open atomic is not implemented,
+		 * calls fall back to non-atomic open.
+		 */
+		if (fm->fc->has_open_atomic && flags & LOOKUP_OPEN) {
+			ret = D_REVALIDATE_ATOMIC;
+			goto out;
+		}
 		forget = fuse_alloc_forget();
 		ret = -ENOMEM;
 		if (!forget)
@@ -280,12 +293,12 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			dput(parent);
 		}
 	}
-	ret = 1;
+	ret = D_REVALIDATE_VALID;
 out:
 	return ret;
 
 invalid:
-	ret = 0;
+	ret = D_REVALIDATE_INVALID;
 	goto out;
 }
 
@@ -768,12 +781,84 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+/**
+ * Revalidate inode hooked into dentry against freshly acquired
+ * attributes. If inode is stale then allocate new dentry and
+ * hook it onto fresh inode.
+ */
+static struct dentry *
+fuse_atomic_open_revalidate(struct fuse_conn *fc, struct dentry *entry,
+			    struct inode *inode, int switched,
+			    struct fuse_entry_out *outentry,
+			    wait_queue_head_t *wq, int *alloc_inode)
+{
+	u64 attr_version;
+	struct dentry *prev = entry;
+
+	if (outentry->nodeid != get_node_id(inode) ||
+	    (bool) IS_AUTOMOUNT(inode) !=
+	    (bool) (outentry->attr.flags & FUSE_ATTR_SUBMOUNT)) {
+		*alloc_inode = 1;
+	} else if (fuse_stale_inode(inode, outentry->generation,
+				  &outentry->attr)) {
+		fuse_make_bad(inode);
+		*alloc_inode = 1;
+	}
+
+	if (*alloc_inode) {
+		struct dentry *new = NULL;
+
+		if (!switched && !d_in_lookup(entry)) {
+			d_drop(entry);
+			new = d_alloc_parallel(entry->d_parent, &entry->d_name,
+					       wq);
+			if (IS_ERR(new))
+				return new;
+
+			if (unlikely(!d_in_lookup(new))) {
+				dput(new);
+				new = ERR_PTR(-EIO);
+				return new;
+			}
+		}
+
+		fuse_invalidate_entry(entry);
+
+		entry = new;
+	} else if (!*alloc_inode) {
+		attr_version = fuse_get_attr_version(fc);
+		forget_all_cached_acls(inode);
+		fuse_change_attributes(inode, &outentry->attr,
+				       entry_attr_timeout(outentry),
+				       attr_version);
+	}
+
+	if (prev == entry) {
+		/* nothing changed, atomic-open on the server side
+		 * had increased the lookup count - do the same here
+		 */
+		struct fuse_inode *fi = get_fuse_inode(inode);
+
+		spin_lock(&fi->lock);
+		fi->nlookup++;
+		spin_unlock(&fi->lock);
+	}
+
+	return entry;
+}
+
+/**
+ * Does 'lookup + create + open' or 'lookup + open' atomically.
+ * @entry might be positive as well, therefore inode is re-validated.
+ * Positive dentry is invalidated in case inode attributes differ or
+ * we encountered error.
+ */
 static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			     struct file *file, unsigned flags,
 			     umode_t mode)
 {
 	int err;
-	struct inode *inode;
+	struct inode *inode = d_inode(entry);
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	struct fuse_conn *fc = fm->fc;
 	FUSE_ARGS(args);
@@ -785,10 +870,7 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	struct fuse_file *ff;
 	struct dentry *switched_entry = NULL, *alias = NULL;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-
-	/* Expect a negative dentry */
-	if (unlikely(d_inode(entry)))
-		goto fallback;
+	int alloc_inode = 0;
 
 	/* Userspace expects S_IFREG in create mode */
 	if ((flags & O_CREAT) && (mode & S_IFMT) != S_IFREG)
@@ -840,37 +922,56 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	err = fuse_simple_request(fm, &args);
 	free_ext_value(&args);
-	if (err == -ENOSYS) {
-		fc->no_open_atomic = 1;
-		fuse_file_free(ff);
-		kfree(forget);
-		goto fallback;
-	}
 
 	if (!err && !outentry.nodeid)
 		err = -ENOENT;
 
-	if (err)
-		goto out_free_ff;
+	if (err) {
+		if (err == -ENOSYS) {
+			fc->no_open_atomic = 1;
+
+			/* Might come up if userspace tricks us and would
+			 * return -ENOSYS for OPEN_ATOMIC after it was
+			 * aready working
+			 */
+			if (unlikely(fc->has_open_atomic == 1))
+				pr_info("fuse server/daemon bug, atomic open "
+					"got -ENOSYS although it was already "
+					"succeeding before.");
+
+			/* This should better never happen, revalidate
+			 * is missing for this entry*/
+			if (d_really_is_positive(entry)) {
+				WARN_ON(1);
+				err = -EIO;
+				goto out_free_ff;
+			}
+
+			fuse_file_free(ff);
+			kfree(forget);
+			goto fallback;
+		} else {
+			if (d_really_is_positive(entry)) {
+				if (err != -EINTR && err != -ENOMEM)
+					fuse_invalidate_entry(entry);
+			}
+
+			goto out_free_ff;
+		}
+	}
+
+	if (!err && !fc->has_open_atomic) {
+		/* Only set this flag when atomic open did not return an error,
+		 * so that we are absolutely sure it is implemented.
+		 */
+		fc->has_open_atomic = 1;
+	}
 
 	err = -EIO;
 	if (invalid_nodeid(outentry.nodeid) || fuse_invalid_attr(&outentry.attr))
 		goto out_free_ff;
 
-	ff->fh = outopen.fh;
-	ff->nodeid = outentry.nodeid;
-	ff->open_flags = outopen.open_flags;
-	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
-			  &outentry.attr, entry_attr_timeout(&outentry), 0);
-	if (!inode) {
-		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
-		fuse_sync_release(NULL, ff, flags);
-		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
-		err = -ENOMEM;
-		goto out_err;
-	}
-
-	/* prevent racing/parallel lookup on a negative hashed */
+	/* prevent racing/parallel lookup */
 	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
 		d_drop(entry);
 		switched_entry = d_alloc_parallel(entry->d_parent,
@@ -884,10 +985,52 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			/* fall back */
 			dput(switched_entry);
 			switched_entry = NULL;
-			goto free_and_fallback;
+
+			if (!inode) {
+				goto free_and_fallback;
+			} else {
+				/* XXX can this happen at all and is there a
+				 * better way to handle it?
+				 */
+				err = -EIO;
+				goto out_free_ff;
+			}
+		}
+	}
+
+	if (inode) {
+		struct dentry *new;
+
+		err = -ESTALE;
+		new = fuse_atomic_open_revalidate(fm->fc, entry, inode,
+						  !!switched_entry,
+						  &outentry, &wq, &alloc_inode);
+		if (IS_ERR(new)) {
+			err = PTR_ERR(new);
+			goto out_free_ff;
 		}
 
+		if (new != entry && new != NULL)
+			switched_entry = new;
+	}
+
+	if (switched_entry)
 		entry = switched_entry;
+
+	ff->fh = outopen.fh;
+	ff->nodeid = outentry.nodeid;
+	ff->open_flags = outopen.open_flags;
+
+	if (!inode || alloc_inode) {
+		inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
+				  &outentry.attr, entry_attr_timeout(&outentry), 0);
+		if (!inode) {
+			flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
+			fuse_sync_release(NULL, ff, flags);
+			fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+			err = -ENOMEM;
+			goto out_err;
+		}
 	}
 
 	if (d_really_is_negative(entry)) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c838708cfa2b..3987046682b1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -675,6 +675,9 @@ struct fuse_conn {
 	/** Is open atomic not implemented by fs? */
 	unsigned no_open_atomic:1;
 
+	/** Is open atomic is proven to be implemented by fs? */
+	unsigned has_open_atomic:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
-- 
2.39.2

