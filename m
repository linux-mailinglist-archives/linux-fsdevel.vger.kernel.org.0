Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8DD74B271
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjGGOB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 10:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjGGOBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:01:39 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC591FE8
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 07:01:26 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound46-29.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 07 Jul 2023 14:01:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+35i0yFxbVjAiE2AhFDLDdW3jQej3Qcr8zZzAG3YTfgEezuib4IiArkLsPG8I55nNGeNtuv+ashrH3cZG3jfk4n2lSjzNtIG9QBs9xrhozoYHXypBV2/Sbry1znuKRr/YaVClLBV+k8jn1XiU0Na6BOsPjJmOIaWQoKN6euxNn08bhHb3c4rC7fUARE8rIdX2NQ6u8U4UjFo64JcS8EvFRFcCHPOurVkK9a8ZCq2pR9eCzzR/rrlm7HLPtw4rzhIoy+2XXYpJZbppr6c8AirXWEnF6YVQyhXL4/a4Comi2m43ulknjdZeCZfas3nVSGFoAKZnDFHHzQxv7mUIqjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/idSVVXvEeJ+ojzUiS8dZwwCtgVegngDhFpZV+rGRg=;
 b=QLlFrzvUbB0eU7qE0W816jCQ8Mwi/dxBbDh0jmX/vbN23aACuXIxlQogGb6DxqADVUkV/D6tc9zqGJThb+CJ7zfT34BI/oo1goLHtyxq8vu2QXR7wg4d+83c9BLBsGDOaFKH88KtsLut+osbtJ0urqJe+nCF+Bwq3qCoHrmKLdicHqfC1G/IMppZV7Q9tDN92rRVj20u5pRtogvqb+dGWPmTHd1E3/OCJusWxvqroLhnrhtxX8CaM1cjBiuWNmE9zlH7P5QKUadBTIzzGDCjWNS5VZPfyvPpXwjRBByhMJ+8dX5KcZcBEUfiMaEvK9JhPnNdxoA+hloX81fjpQK6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/idSVVXvEeJ+ojzUiS8dZwwCtgVegngDhFpZV+rGRg=;
 b=JXppSWD8DPqHeK9Sa2p5yoSWn2eklWERrSWKku9V6cL2eX4K16N/8VsuhyT3iZeZAwlmcVFrW3ux1qSYzO2E883U+P0re57+zrCdO+ZthA6g9vIAsXGwj2VOz00nKo5snLZNuKh98RZMhsBKoggE+sFg/9af9mHY1UqCRHimylg=
Received: from BN9PR03CA0452.namprd03.prod.outlook.com (2603:10b6:408:139::7)
 by PH7PR19MB8233.namprd19.prod.outlook.com (2603:10b6:510:2e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 13:28:21 +0000
Received: from BN8NAM04FT058.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::a8) by BN9PR03CA0452.outlook.office365.com
 (2603:10b6:408:139::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 13:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT058.mail.protection.outlook.com (10.13.161.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.13 via Frontend Transport; Fri, 7 Jul 2023 13:28:20 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id C99B520C684B;
        Fri,  7 Jul 2023 07:29:26 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu,
        fuse-devel@lists.sourceforge.net, vgoyal@redhat.com,
        dsingh@ddn.com, Horst Birthelmer <hbirthelmer@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 2/2] fuse: introduce atomic open
Date:   Fri,  7 Jul 2023 15:27:46 +0200
Message-Id: <20230707132746.1892211-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707132746.1892211-1-bschubert@ddn.com>
References: <20230707132746.1892211-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT058:EE_|PH7PR19MB8233:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d26ef6f-fb8c-4ad2-5f22-08db7eee0847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pp4z4LYD8cH2MrwLAAoCfJDe5dvfCueYNtrlaNv2CIQ1KqHE4cZtsaZTRfJERaWbpHGhVdL3zAzLeMgcbbtcyu/j1rr2bpfoyyG04xHHyBQcXeyl0ZSi8Y5lC63zUfXrRk+GrrG9aUrg5HbKECp3muFeFqiIsJbpI7xODPN29z8MLmpuMeIA7W72e4H9HO6K8SrUOihuz2L6ZkNWMaOfG7GLPozG/CBMLpbwBEDzizZS1ZcL9sYsphSo+nBE1G+u5qAgZXRQGI9Q12/K8SJ7nz8bCf4YCUU+QxnXNvkEPxKgbrOo27DGVob7f6sKdBFXYM8zq0R3Lg+ItM+igNKu5OJee4MObE/MhYoT4Ez2FTJ/KApXJo8d2zRJLMFRc9TnzRUzvVoq9TZggSLZmFOVHyze5fqpdQaQ2xK2ZNzIZgAd8XRIqYiOVX44PvJmEgq/bym2MeHHiCTH2yFzVE7u1kEuCtXGr7OvLQGZd4qgN1bp6EBVvjEG2P7/6NGFXut5uFibpFEvSs2GXV477wY69MZD7bnLCyA1nlE5n6Hd+LCCSRQdoAbeGo47SqlTnOawq+hiLDfKogHLe4zBjle4tmYlOhy3xghASZ8bETW6+rKj9rgsk3nvDLhr13E7+76RSJfF1wQK44A0jk40oJ9pGfyb5STEGLE6HJ2TVT6L/oBhlfRVzl1QyziXMpGG2gIMq8Hpz5+v4dYv7AImb5n32bj3lTeGO4s+h+bVX2+EFbCxpdcgHwT95sLnDLGF05Bk
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(136003)(376002)(396003)(451199021)(46966006)(36840700001)(2906002)(82310400005)(356005)(81166007)(82740400003)(336012)(47076005)(83380400001)(2616005)(186003)(40480700001)(26005)(6266002)(36860700001)(5660300002)(1076003)(86362001)(8676002)(36756003)(54906003)(6666004)(478600001)(4326008)(6916009)(8936002)(70206006)(70586007)(316002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nCVBOUM4mvsZlHea33Q5+x/PP6V7/+SbgrE1lmffn408ZAy21XdVZ6xUg49x?=
 =?us-ascii?Q?dt0YGErqLdVrsJgCuyIxdi5D9KSmBmy4z9zckXQuc/mV2nor3XemfnQiHzmS?=
 =?us-ascii?Q?UuPqu7ClyGf/AK+8FBq32WZ0mRPPvs5x1p1hCv9JdbOb1iixLqxAK+8VT35G?=
 =?us-ascii?Q?tUcTZJ9Wax/93tt+NCa1eBxbwzv/S1+QBlaUEkAvT/PgmKgg+0g/exKvWy29?=
 =?us-ascii?Q?/VTg7DMyh0g6ibrzXMxbk/am6wrcAl1r8iIxvpBrPtQ79V1ETbjquH2NHuqd?=
 =?us-ascii?Q?VkQvunOCiXxFnvtcvsAo50Yuwj5ODQPq4bey+yvqMfbUkM1nXUTKQ5ihR6kf?=
 =?us-ascii?Q?2KSknucv7Sa/lBlCN1amYpdh2PCzWCuj3siEqt0s8Qwjds0KV5nHzM6rxGQW?=
 =?us-ascii?Q?OvAlx/KJtN+RH2BQmd1TESExLoXn7RfNeczWbLYD9pacMSbnj02FI9VBR55G?=
 =?us-ascii?Q?3PsP0/OyebQLCEmHl4tylZ5s4g6NGoh9xc4tMsOylQIDVwR29J0Yk5ztxM69?=
 =?us-ascii?Q?zKX95DXh4cJTQnD0RpMvGJZVm/93G4znTKieH4nFwovrT1B359Wpg907rQeR?=
 =?us-ascii?Q?X7Ne+oJslg4MS9wibD9TVND2n5N98yEVmPi/V+n2aqCw3BETrGu1KjfbdMh9?=
 =?us-ascii?Q?cbdbKTRZ8vP4hazMIhYUaqYr+kg7RR1EXR+nnxrJXmAvoQYPv9u/eCxZFW8C?=
 =?us-ascii?Q?2bLAB1zSpID0NfdsPRtEyiAEzf+luiVDFHy8Yn/KG+glCygQxciRU+cD3Df7?=
 =?us-ascii?Q?bKupibq4PNPKD6+NhTOEykH6styHHLx7gdMtVYkrZ8Qp4EGYe7+RS4ISRGOR?=
 =?us-ascii?Q?FBQzaMdiw9ltx/9iXKusTbVe2JCHjo4JUTP687xC+iuSm/sD1gpnc9BK86TY?=
 =?us-ascii?Q?ATgVqX6xYic1Aw3eWXJIwF7VDm0SOTfPqAuw350IdGLyMhpHMcYdl0lKGxu5?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 13:28:20.7862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d26ef6f-fb8c-4ad2-5f22-08db7eee0847
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT058.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB8233
X-BESS-ID: 1688738473-111805-5493-27227-1
X-BESS-VER: 2019.1_20230706.1616
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYGJpZAVgZQ0NTU3MwkKSktJT
        HR2CI10TjN1Dg5ycDQwtTS2MAi1dREqTYWABu4iHFBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.249330 [from 
        cloudscan9-38.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dharmendra Singh <dsingh@ddn.com>

This adds full atomic open support, to avoid lookup before open/create.
If the implementation (fuse server/daemon) does not support atomic open
it falls back to non-atomic open.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dir.c             | 170 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |   3 +
 include/uapi/linux/fuse.h |   3 +
 3 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 6ffc573de470..8145bbfc7a40 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -724,7 +724,7 @@ static int _fuse_create_open(struct inode *dir, struct dentry *entry,
 
 static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
-static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
+static int fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
 			    umode_t mode)
 {
@@ -770,6 +770,174 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
+			    struct file *file, unsigned flags,
+			    umode_t mode)
+{
+
+	int err;
+	struct inode *inode;
+	struct fuse_mount *fm = get_fuse_mount(dir);
+	struct fuse_conn *fc = fm->fc;
+	FUSE_ARGS(args);
+	struct fuse_forget_link *forget;
+	struct fuse_create_in inarg;
+	struct fuse_open_out outopen;
+	struct fuse_entry_out outentry;
+	struct fuse_inode *fi;
+	struct fuse_file *ff;
+	struct dentry *res = NULL;
+
+	/* Userspace expects S_IFREG in create mode */
+	if ((flags & O_CREAT) && (mode & S_IFMT) != S_IFREG) {
+		WARN_ON(1);
+		err = -EINVAL;
+		goto out_err;
+	}
+	forget = fuse_alloc_forget();
+	err = -ENOMEM;
+	if (!forget)
+		goto out_err;
+
+	err = -ENOMEM;
+	ff = fuse_file_alloc(fm);
+	if (!ff)
+		goto out_put_forget_req;
+
+	if (!fc->dont_mask)
+		mode &= ~current_umask();
+
+	flags &= ~O_NOCTTY;
+	memset(&inarg, 0, sizeof(inarg));
+	memset(&outentry, 0, sizeof(outentry));
+	inarg.flags = flags;
+	inarg.mode = mode;
+	inarg.umask = current_umask();
+
+	if (fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
+	    !(flags & O_EXCL) && !capable(CAP_FSETID)) {
+		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
+	}
+
+	args.opcode = FUSE_OPEN_ATOMIC;
+	args.nodeid = get_node_id(dir);
+	args.in_numargs = 2;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.in_args[1].size = entry->d_name.len + 1;
+	args.in_args[1].value = entry->d_name.name;
+	args.out_numargs = 2;
+	args.out_args[0].size = sizeof(outentry);
+	args.out_args[0].value = &outentry;
+	args.out_args[1].size = sizeof(outopen);
+	args.out_args[1].value = &outopen;
+
+	if (flags & O_CREAT) {
+		err = get_create_ext(&args, dir, entry, mode);
+		if (err)
+			goto out_free_ff;
+	}
+
+	err = fuse_simple_request(fm, &args);
+	if (err == -ENOSYS) {
+		fc->no_open_atomic = 1;
+		fuse_file_free(ff);
+		kfree(forget);
+		goto fallback;
+	}
+	if (err) {
+		if (err == -ENOENT)
+			fuse_invalidate_entry_cache(entry);
+		goto out_free_ff;
+	}
+
+	err = -EIO;
+	if (invalid_nodeid(outentry.nodeid) || fuse_invalid_attr(&outentry.attr))
+		goto out_free_ff;
+
+	ff->fh = outopen.fh;
+	ff->nodeid = outentry.nodeid;
+	ff->open_flags = outopen.open_flags;
+	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
+			  &outentry.attr, entry_attr_timeout(&outentry), 0);
+	if (!inode) {
+		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
+		fuse_sync_release(NULL, ff, flags);
+		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+		err = -ENOMEM;
+		goto out_err;
+	}
+	if (d_in_lookup(entry)) {
+		res = d_splice_alias(inode, entry);
+		if (res) {
+			if (IS_ERR(res)) {
+				/*
+				 * Close the file in user space, but do not unlink it,
+				 * if it was created - with network file systems other
+				 * clients might have already accessed it.
+				 */
+				fi = get_fuse_inode(inode);
+				fuse_sync_release(fi, ff, flags);
+				fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+				err = PTR_ERR(res);
+				goto out_err;
+			}
+			entry = res;
+		}
+	} else
+		d_instantiate(entry, inode);
+	fuse_change_entry_timeout(entry, &outentry);
+
+	if (outopen.open_flags & FOPEN_FILE_CREATED) {
+		if (!(flags & O_CREAT)) {
+			pr_debug("Server side bug, FOPEN_FILE_CREATED set "
+				 "without O_CREAT, ignoring.");
+		} else {
+			/* This should be always set when the file is created */
+			fuse_dir_changed(dir);
+			file->f_mode |= FMODE_CREATED;
+		}
+	}
+
+	if (!(flags & O_CREAT))
+		fuse_advise_use_readdirplus(dir);
+	if (S_ISDIR(mode))
+		ff->open_flags &= ~FOPEN_DIRECT_IO;
+	err = finish_open(file, entry, generic_file_open);
+	if (err) {
+		fi = get_fuse_inode(inode);
+		fuse_sync_release(fi, ff, flags);
+	} else {
+		file->private_data = ff;
+		fuse_finish_open(inode, file);
+	}
+	kfree(forget);
+	dput(res);
+	return err;
+
+out_free_ff:
+	fuse_file_free(ff);
+out_put_forget_req:
+	kfree(forget);
+out_err:
+	return err;
+
+fallback:
+	return fuse_create_open(dir, entry, file, flags, mode);
+}
+
+static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
+			    struct file *file, unsigned flags,
+			    umode_t mode)
+{
+	struct fuse_conn *fc = get_fuse_conn(dir);
+
+	if (fc->no_open_atomic)
+		return fuse_create_open(dir, entry, file, flags, mode);
+	else
+		return _fuse_atomic_open(dir, entry, file, flags, mode);
+}
+
 /*
  * Code shared between mknod, mkdir, symlink and link
  */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..4e2ebcc28912 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -672,6 +672,9 @@ struct fuse_conn {
 	/** Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
+	/** Is open atomic not impelmented by fs? */
+	unsigned no_open_atomic:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1b9d0dfae72d..ee36263c0f3a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -314,6 +314,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_FILE_CREATED: the file was indeed created
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -322,6 +323,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_FILE_CREATED	(1 << 7)
 
 /**
  * INIT request/reply flags
@@ -572,6 +574,7 @@ enum fuse_opcode {
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
 	FUSE_TMPFILE		= 51,
+	FUSE_OPEN_ATOMIC	= 52,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.37.2

