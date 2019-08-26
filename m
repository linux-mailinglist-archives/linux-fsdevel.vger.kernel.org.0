Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B242B138E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfILR2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7948 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbfILR2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309333; x=1599845333;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=3Lfc37RaSpRlLsat5fuUZVrZy5V506BDOaoJ2FCddtY=;
  b=D8YwtHd/hWlLtrY5S5e97ME3eOc2RUBD7IyvyIZuGu5O9ZlWn3pTCbHZ
   glsnj+lIc7R3yo4uGjTmLgDnq7CW3CiMxzoZQm3S6yZUNAO8/N4xIfJ9h
   834ewJKkf09yriYTBOvZZanxxIwp8tgBp0lW/6kloqRCLPE0VjPBkmKlQ
   E=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414961235"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 97093A2522;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D06UEA002.ant.amazon.com (10.43.61.198) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D06UEA002.ant.amazon.com (10.43.61.198) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E4B57C0567; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <05d6bcef1c90fb3d635081d33071740ecffb6a8d.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 26 Aug 2019 21:53:51 +0000
Subject: [RFC PATCH 04/35] nfs: parse the {no}user_xattr option
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Parse the {no}user_xattr option to enable the optional NFS4.2 user
extended attribute support.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 703f595dce90..bbb93bc87887 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -93,6 +93,7 @@ enum {
 	Opt_resvport, Opt_noresvport,
 	Opt_fscache, Opt_nofscache,
 	Opt_migration, Opt_nomigration,
+	Opt_user_xattr, Opt_nouser_xattr,
 
 	/* Mount options that take integer arguments */
 	Opt_port,
@@ -190,6 +191,9 @@ static const match_table_t nfs_mount_option_tokens = {
 	{ Opt_fscache_uniq, "fsc=%s" },
 	{ Opt_local_lock, "local_lock=%s" },
 
+	{ Opt_user_xattr, "user_xattr" },
+	{ Opt_nouser_xattr, "nouser_xattr" },
+
 	/* The following needs to be listed after all other options */
 	{ Opt_nfsvers, "v%s" },
 
@@ -643,6 +647,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		{ NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
 		{ NFS_MOUNT_UNSHARED, ",nosharecache", "" },
 		{ NFS_MOUNT_NORESVPORT, ",noresvport", "" },
+		{ NFS_MOUNT_USER_XATTR, ",user_xattr", "" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
@@ -1316,6 +1321,12 @@ static int nfs_parse_mount_options(char *raw,
 		case Opt_noacl:
 			mnt->flags |= NFS_MOUNT_NOACL;
 			break;
+		case Opt_user_xattr:
+			mnt->flags |= NFS_MOUNT_USER_XATTR;
+			break;
+		case Opt_nouser_xattr:
+			mnt->flags &= ~NFS_MOUNT_USER_XATTR;
+			break;
 		case Opt_rdirplus:
 			mnt->flags &= ~NFS_MOUNT_NORDIRPLUS;
 			break;
-- 
2.17.2

