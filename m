Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C4D779724
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjHKSip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 14:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjHKSin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:38:43 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153BE30DC
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:38:39 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103]) by mx-outbound19-176.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 11 Aug 2023 18:38:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcJFSt/XIvaF4qqUSKFPWKkEJo6RxL/ANAGtOiu0SyhGhQAad1sJrllc7bp3uqcZFtUcwb/gq80XBtN7Ki+jut4CRWTNy/Ka4eZ+N2g2FZtob7pyFFnCZQdBU1W0SuBpCppNLGV+v+vg74/aDLEllfuTL4X4hlZMets0hft2II64TdCN2xNURIjl4qMPsyRbN6LfOwc6zXCPI1bLCtCmnRIhyhOFz8sJ+PVi/LQNuJILV8QZ+IWOBrHQeKyLjh52Vh9GerjurQTygukUt6Y6gYtgbJynkPGfFgjIhjH4zaQiPrvGCHRM3VZVASVjX5jKVBAmj4VoG5tX3WIITmi61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDgiDraLOqUY0epzpyLv4XeGEfNhSHKb/QaFImf7jks=;
 b=KqD+VJXFUAVO2ENaYgNHcjDT+84qalrKuJ6ERnw9dUQm9evzU8lUPd8nbC+b+Pq5T5rPysuctLH5MmRLKw55pkCjYn+BZEirzBSFF3EsC4kXfzWxIHsrw0h7FQIkFmNlIXEjPCXDdTrlg0lw/5Rv+TzJ0IeRIPJc6NNGdKWKa+5uXOzW+GnmEaYuKk0r2ww3y2DuGCjKRzv/nEx2Sj6qZsrOpf9BPhdZy+VFEYYhjSFMT0jgiS7v1s/7A+C166GP41sBKB2LJuu3mSp9cxr3ol7o/3gwEzvgEXnrpM5H5AfkKQMSUhj4h1qr0EPFHN8r8pK7ClFlA3wl1tiC6HghOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDgiDraLOqUY0epzpyLv4XeGEfNhSHKb/QaFImf7jks=;
 b=xGKY2zHEU/4tDkR8uaUCKwBSSK91jnYxpS8T8PvcaWsheMzRSfP3/HeERLBSVEG1ZVvaRe7a0HPWFHAtQfrnPOQUgmbuWBvYuvIKWbfzyRTEb0ALT25njAJV1b5gQAwinAIXqTk3dWepJbVoe2zSBVbAB/6PrSWaarnVLPHriB0=
Received: from MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) by
 SA0PR19MB4459.namprd19.prod.outlook.com (2603:10b6:806:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 18:38:26 +0000
Received: from MW2NAM04FT063.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::7e) by MW2PR16CA0032.outlook.office365.com
 (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 18:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT063.mail.protection.outlook.com (10.13.31.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9 via Frontend Transport; Fri, 11 Aug 2023 18:38:26 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 9601420C684B;
        Fri, 11 Aug 2023 12:39:31 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 2/6] fuse: introduce atomic open
Date:   Fri, 11 Aug 2023 20:37:48 +0200
Message-Id: <20230811183752.2506418-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811183752.2506418-1-bschubert@ddn.com>
References: <20230811183752.2506418-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT063:EE_|SA0PR19MB4459:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bcdfdece-5489-403e-711e-08db9a9a26ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smQa4Q+WWrIRYMn9Afb5WHQ+ZrQLdzLR0l04zpGaAjx7NHNNkJrCSzAvho4T3J6SxvD25fD7tWbet2KBo7aCSp9Mokjd+ZIPi5puhJpFcuYy92j3Y7MjUrh/p770kvqaMQj/kkfBwTgkptbCMud3B1nJy3kXgWk4vlUwSCgHK2/fmf7HeKT/mwznt2GG/XLZXZ3OUT6l0Usnfriw2PiR+PUEL9Ss7L7sLaQXcP1flo+1QquhMNhEHLEn9EUgwl/UTCCkMj6JefjYQsSHhgq/6mq9vFYlrVpzP59PV83COdVLSzOMwFqpiWTKOdPz0UUSqAqwO39nVpJZ895Uk2YlcePoKCepBhvBrSM3zdwxHOExDmDYRqhmETbxHNl5lGR8Go2cvSXL0k52DX9nS4G51aYFM6+DMQ7SmKoCIHdusj/3zHNTcx05E/C4R/CRXFUdc0VdzsCbXIQ3Ck6IJGABIn2zDwsA3VXkuvK57naQlRPR0hHZuYeeRvyoy0pRhWP9bKCeWf1in54PcEZgHjVXUKXdA6iXYxbVqIQsDO6hgEd2cRwGvD6/4ZRcxJu+6Gl+R2/ZxmnHuzlzZ/Exyww7t2RIq5RLRFJ6DS4DYf00GwV1CeHU+XKpzWpzQI4uVXaGDwqg5Gh0RdrB7NXbw8DOzLzfz8mgDYee6RMQQoYiDtWmhF3/CwqINNBSfb6rLIyhJ/BJKibWUIalyQZRFVfE1ZhrXRuZsUIkGCz0Ou7axrWRRMIkOZRanl1fLM7SKCKW
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39850400004)(376002)(396003)(186006)(451199021)(1800799006)(82310400008)(46966006)(36840700001)(6666004)(478600001)(6916009)(70586007)(4326008)(70206006)(5660300002)(316002)(54906003)(41300700001)(8676002)(8936002)(26005)(1076003)(86362001)(82740400003)(6266002)(336012)(40480700001)(36756003)(36860700001)(47076005)(356005)(83380400001)(81166007)(2906002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IJX09dwLLi5yS7jm0gge7xlj6oVxmZkyE0eS+B3YGnCfeqjfJz3bPgGA//LfhLPsyYsyp+paEJFbYl3fyvMU4PU8Ig2NVpp5Ju9uVbQGSVHJTep60zisWodgJWW2oxAa9UmNMtulFduMGa78HaV0EbHryJv7M5SsfOkCfgQ0z+ZIvkiDftAquFZ7AZYqvMFwD6E9W+3NjKK0ADJ+0a7gpdd5iiMhpVmvg55hjBp7TiHIHKs3y3XSmofyyR9jFmJcNZVBaUbzjIUy+M0xL2CWTowkdiTWGtNKS+7ITOGaK2jpcNY+FvhooYYjiLDWOxVPqKskw6v6lOMU1BcXm1FXwGizJgxiJ3HUR+j1OFx6QlBfbrvfwo+PnVGJDvDHxjLi4z59oqZpq5ecbYrfjGalzyflR3T/TKpypa5NjywXV8kH4QeTFerZdWHGBQB4kC2DuzMlu6EHxCcmNThMN6fNVJ4YrImrJr5vF/FOuN+WAQaGImmFWxoQpHiBqmECJS2yEXZjJ3wGCwAfZYCFAI+wgJZ64aq0gJ0kj5tjPnDUf7SGFvzLOae5r3SzRdzkmVbGMpoNnAiqXvNMBBNTfB6LaX1EtJATw0FaNhw8BchNFySX6CJu8qTJ1fENkmIntUE6kJ4XjrS7P+Lsp4uXYLBWMFkt+4fY80M/CSx586/HdYyGE3n2EEoOXcvE6bFyfYP+tN+LJzo4rjmrzhPGBWXXfQH3HfWlhOFWkP4stumDEeweFPR/7KXjbdrVM7djagW79kmHE/b3QinYK/VGcgMQYFihXy/sElonXR67gn9bm3e57bBLDNcarA9ptXESWV3qhI2oQejYYrWb3Lq1b0OPlAH+jIwJQ8igXk61wFfQNhlMrH7uMhcrHEdLvC+nYNubcpLAyEXtubnxGZ8jVgYafp2G+SDbM75yY0ASa6xCZcM=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:38:26.6661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdfdece-5489-403e-711e-08db9a9a26ad
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT063.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4459
X-BESS-ID: 1691779111-105040-12337-14224-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.70.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYmZsZAVgZQ0DIpNTklyTTF2D
        w11cQ4NcXQwjI1KSU1KSkl0TItJcVQqTYWACsuU7tBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250079 [from 
        cloudscan11-179.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c             | 222 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |   3 +
 include/uapi/linux/fuse.h |   3 +
 3 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 6ffc573de470..c02b63fe91ca 100644
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
@@ -770,6 +770,226 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
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
+	/* modified version of _nfs4_open_and_get_state - nfs does not open
+	 * dirs, fuse doe
+	 * nfs has additional d_really_is_negative condition, which does not
+	 * make sense as long as only negative dentries come into this function,
+	 * see BUG_ON above and missing revalidate patch - but needed if
+	 * we are going to handle revalidate
+	 */
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
2.34.1

