Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657507A8AB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 19:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjITRfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjITRfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:35:38 -0400
Received: from outbound-ip179b.ess.barracuda.com (outbound-ip179b.ess.barracuda.com [209.222.82.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDD8B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:35:24 -0700 (PDT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172]) by mx-outbound-ea17-82.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 20 Sep 2023 17:35:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOaPLgSqDOAv5pJ8rhD3yKerNX9geMGvM86Dc0YLMc6LeNSGW59Nd0hEYSziuSBwb9jepNbsID0b6oHk+f1ekHuj3Zls5VGZ6PLTIh5nTpCjfRGfH6RUKFdKzqKiju+9kxgSpHPm8qHUC8lOt7RHfBGEi1nNpzScbh7Gr+nlSCUAQjDH+uw0qtVDoYgo9BsIHrvl8VCOKmd368wnd+BI7H4+nsJe4sgMqrIQb5SI27ilavD9wrtxNL4xWJ1woLJmAM+S7s4SLhgPIxZ7V6AoFLqsOP/+tEMvmbS2nAhrv9tSWENE6obGeO70yKY6jQMc6sNVWdYuqq33IxjGT5bzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbbC94ZywEbpEvq6+rADuITlvUXN+TjFGHOSOfnCsd4=;
 b=hO/K/JePzTc7L2ieu9nWF28rlCM024MxT5HVgPPeZMuVbCatqZYjGWigcg34N0Tm6LTKDsU0lEfM1EQ3JzDg1Y3KtFHI7dDDJq0dqPLyPKnCjGKGrP2p3WtDvgM+yzEHcrAhM3Z8ExdokUJbrkuIpZphlI539cWznPqw3z1VNeW/AUDMvHylIvCm4Jtq+q59pP0B0TSIw0wqzoXUQUJFmAf2KBh2dyhLDRgt9RCEX9/UCX2pEP4CALzU48NUAQ7A0NTFdua+PTHZ3lQh0NyUx8T0LFz6UOvdp5ofGsr1ldd7aR0wtUK3+EtPLcm1p4XZPGfJJOIGTwjqao0GHqui4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbbC94ZywEbpEvq6+rADuITlvUXN+TjFGHOSOfnCsd4=;
 b=XKOuR3OflPX8YwbVmJIpByf74wLRXg/P3rOH1d+uZqZtJa3VulzmTZrmbb0guhLQy8RSkFbRyvQ4GG7QeTZd9+BlXhi+Z2l27ESI+O1LrSbDRKExUCZSNTmqTQMvCkNxho/E3mGDoz97Jcu8R+n1nP0MBOcjslx47Dr4z70QE0Y=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by SJ0PR19MB5462.namprd19.prod.outlook.com (2603:10b6:a03:3e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 17:34:51 +0000
Received: from BN8NAM04FT047.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::4b) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 17:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT047.mail.protection.outlook.com (10.13.161.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20 via Frontend Transport; Wed, 20 Sep 2023 17:34:51 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 5032B20C684B;
        Wed, 20 Sep 2023 11:35:56 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v9 2/7] fuse: introduce atomic open
Date:   Wed, 20 Sep 2023 19:34:40 +0200
Message-Id: <20230920173445.3943581-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920173445.3943581-1-bschubert@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT047:EE_|SJ0PR19MB5462:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ca371612-d2cf-4393-ea04-08dbb9ffe51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBfj9Y7ngkEDvzA9SnEzUastXtgpljD+bK2zGUR0IVw3syxGuQyl6raPFy9aTkyEo3IFwo5n1oGA/ir2wC/U1jrjc9FS66iKEsIroGjn8h+bN303bfRdFNqjZrE5nUZaRbUcIf4xJwsfxNmsaKAE3GRtTW996qKLshPK1h6Xmwb1IxLOdGTPMN5nFHDN68FCcqIkLcRd7PzXUZ+AdtUQT7P48950VMThil2Ewd0liv9WBuV+eed2DgeIwFiLgSdwc4KnwZy/eUvf9WiSQeGbERE9mC+e+U4eUZitLr+JWM73xXVobBAMOX+kTO/GiBLDUl+Z28l6gcuyErHyPmS2yzMlkV2ye5svh0KO6deQHg24WAmlu/L6mdUm0UAcglOpDaSZ1mbqAsHWkredrgOBazNJVKu7o0t0ahm+cW3OFuZz3mP1zMGzcVTfz+fBWD0Hv4E8azrTpXv4Y/QrJ2IODIz/wYfLnNoRtKS3aXYrROUkBYrzKB/VIiBxVSe2A6/kiHcoVk3ihzQ2k6JRZSA2TUutfYFwI785VIwpCWfxz1Fh3NbG7rtmWXqdZZTM6vFEnVLcEn2JfUWXBcwQcpCqn/fVpgxoo5EB4wkrzM9boLZmMggKtoBtvCrtiKHl9xVWcHe7+mCDLdOMhlODw8uZK1v7daCvuw6hkfVjhHHEiRRzT3Df9wOFj85wqR4Zu4US9gqRBZGaUpBFJfFta9I6Xs7trvzel1cY+CZawTasyldVM3bbe9ReiiuMabythLnU
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39850400004)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(6666004)(478600001)(81166007)(86362001)(356005)(36756003)(40480700001)(82740400003)(36860700001)(2616005)(2906002)(1076003)(26005)(336012)(47076005)(6266002)(83380400001)(8676002)(41300700001)(5660300002)(6916009)(4326008)(8936002)(70206006)(54906003)(316002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6Le7W4XqFiFC7nNc86GCuxWREflJ/WSywi/508+6o9O99/OpdWNpPHEk5woU?=
 =?us-ascii?Q?N/ICkM95txVARvn+BclZv7/2HU9Wwp/TirwalsawC9m5y9xnkCGYGc+mWpjX?=
 =?us-ascii?Q?FN9VDSQa8pMNO/cVcTSEjug4mAHb9qHbxtAZSsyyCQxa4JhP7p5y8J8dUlcy?=
 =?us-ascii?Q?1mZHu8u6zMFcpl7UI5Deatbia89URGlWcnrGv8J8dKjzHtBEKaAD8OpTionQ?=
 =?us-ascii?Q?G5fZPGO+oxBHE9cdsuchJCe9j02+QiiSjRle8V+YwG9GWyGDYRXBMLZmugOz?=
 =?us-ascii?Q?XgvIKegpBKAo63YZ/h5vF4oFACpg3ZX3DZ6tlq2nyTeGzxjr5k5NNpaidlMJ?=
 =?us-ascii?Q?06Ic2kfsugYLGVShTxlh4TzZ6wcv26UlT9NXJxvk7EGhEuCq/GALsSkMLDUd?=
 =?us-ascii?Q?X4fy6wB1T0IV5avuX3psiznZKiNvV/qA0oGlu7cV7cQLNkMcmSDmdRGOxbGK?=
 =?us-ascii?Q?kp9XsOVK5XA64N3GmxY0n2QCGOpae+LnNP/EXROzaacc+j2Hf19iWYK4XSUL?=
 =?us-ascii?Q?BvXY+xNuNIddYIKDH0WxE48UlOuuFs2qZVNrRDNDwdrQBi7S8vw92+OXINc+?=
 =?us-ascii?Q?8ODOraE7e4N0NIhKyOgGYhdwnUPwP8mMrb+bKf/UGjN4cCFM2DEazubB6Dkh?=
 =?us-ascii?Q?NGDzWoXHiN0Dpl9plXXYThRxfAPEAdBIfk/4aaOeP9uP/FJxfu/ruEaAVfVm?=
 =?us-ascii?Q?GTpQDAf+oWVJrWi1kGImZftKP0u+RWYd/l76PBSqSTcT1Moc7bKOS8QCV55k?=
 =?us-ascii?Q?QdstQwcHgWE9I9Otks3IFczxmbIjFhnuMShiTZb7cQbhRQjcGakFVpFuuaMS?=
 =?us-ascii?Q?qWRY/u+2j1ukHjzG8i1utULTUseDf3OPpucw1OIYF92Iw//YlrHPWSnhvojP?=
 =?us-ascii?Q?Q8nd61oh//ecHbhoOXhrsARs7BD5Xy/49bFKO8uBSBoaTfFNK921TRfRMmq9?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:34:51.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca371612-d2cf-4393-ea04-08dbb9ffe51b
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT047.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5462
X-BESS-ID: 1695231304-104434-8569-5778-1
X-BESS-VER: 2019.3_20230913.1605
X-BESS-Apparent-Source-IP: 104.47.57.172
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZGBgZAVgZQMDktycDI3DQpxd
        gkMS3FMDE1NcXU3NIk0dzY0iTNItFMqTYWABZhLqJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250962 [from 
        cloudscan20-6.us-east-2b.ess.aws.cudaops.com]
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

This adds full atomic open support, to avoid lookup before open/create.
If the implementation (fuse server/daemon) does not support atomic open
it falls back to non-atomic open.

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
 fs/fuse/dir.c             | 214 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |   3 +
 include/uapi/linux/fuse.h |   3 +
 3 files changed, 219 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 542086140781..4cb2809a852d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -722,7 +722,7 @@ static int _fuse_create_open(struct inode *dir, struct dentry *entry,
 
 static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
-static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
+static int fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
 			    umode_t mode)
 {
@@ -768,6 +768,218 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
+			     struct file *file, unsigned flags,
+			     umode_t mode)
+{
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
+	struct dentry *switched_entry = NULL, *alias = NULL;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+
+	/* Expect a negative dentry */
+	if (unlikely(d_inode(entry)))
+		goto fallback;
+
+	/* Userspace expects S_IFREG in create mode */
+	if ((flags & O_CREAT) && (mode & S_IFMT) != S_IFREG)
+		goto fallback;
+
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
+	free_ext_value(&args);
+	if (err == -ENOSYS) {
+		fc->no_open_atomic = 1;
+		fuse_file_free(ff);
+		kfree(forget);
+		goto fallback;
+	}
+
+	if (!err && !outentry.nodeid)
+		err = -ENOENT;
+
+	if (err)
+		goto out_free_ff;
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
+
+	/* prevent racing/parallel lookup on a negative hashed */
+	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
+		d_drop(entry);
+		switched_entry = d_alloc_parallel(entry->d_parent,
+						   &entry->d_name, &wq);
+		if (IS_ERR(switched_entry)) {
+			err = PTR_ERR(switched_entry);
+			goto out_free_ff;
+		}
+
+		if (unlikely(!d_in_lookup(switched_entry))) {
+			/* fall back */
+			dput(switched_entry);
+			switched_entry = NULL;
+			goto free_and_fallback;
+		}
+
+		entry = switched_entry;
+	}
+
+	if (d_really_is_negative(entry)) {
+		d_drop(entry);
+		alias = d_exact_alias(entry, inode);
+		if (!alias) {
+			alias = d_splice_alias(inode, entry);
+			if (IS_ERR(alias)) {
+				/*
+				 * Close the file in user space, but do not unlink it,
+				 * if it was created - with network file systems other
+				 * clients might have already accessed it.
+				 */
+				fi = get_fuse_inode(inode);
+				fuse_sync_release(fi, ff, flags);
+				fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+				err = PTR_ERR(alias);
+				goto out_err;
+			}
+		}
+
+		if (alias)
+			entry = alias;
+	}
+
+	fuse_change_entry_timeout(entry, &outentry);
+
+	/*  File was indeed created */
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
+
+	kfree(forget);
+
+	if (switched_entry) {
+		d_lookup_done(switched_entry);
+		dput(switched_entry);
+	}
+
+	dput(alias);
+
+	return err;
+
+out_free_ff:
+	fuse_file_free(ff);
+out_put_forget_req:
+	kfree(forget);
+out_err:
+	if (switched_entry) {
+		d_lookup_done(switched_entry);
+		dput(switched_entry);
+	}
+
+	return err;
+
+free_and_fallback:
+	fuse_file_free(ff);
+	kfree(forget);
+fallback:
+	return fuse_create_open(dir, entry, file, flags, mode);
+}
+
+static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
+			    struct file *file, unsigned int flags,
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
index 9b7fc7d3c7f1..c838708cfa2b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -672,6 +672,9 @@ struct fuse_conn {
 	/** Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
+	/** Is open atomic not implemented by fs? */
+	unsigned no_open_atomic:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b3fcab13fcd3..33fefee42697 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -315,6 +315,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_FILE_CREATED: the file was indeed created
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -323,6 +324,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_FILE_CREATED	(1 << 7)
 
 /**
  * INIT request/reply flags
@@ -575,6 +577,7 @@ enum fuse_opcode {
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
 	FUSE_TMPFILE		= 51,
+	FUSE_OPEN_ATOMIC	= 52,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.39.2

