Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C15B5A967F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 14:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiIAMRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 08:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiIAMRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:17:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC006118A63;
        Thu,  1 Sep 2022 05:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C462B825E4;
        Thu,  1 Sep 2022 12:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8490C433D6;
        Thu,  1 Sep 2022 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662034638;
        bh=HMRBvtGrMdseHHO8WD6RRw3JemO/uRhitrcEcBh7oNk=;
        h=From:To:Cc:Subject:Date:From;
        b=JI38jC2mevkX/4GtWpVjQre7XaNbn7VhZ+Rkhr5IpRF7UZvDH5XtH3JLJL8qdirl+
         Cj7CH8pj40ihyuVu6GQF/Bf3e0VZ6/LxPC2yXycJopLmTWI4Xtxhqk40NqrnQtVg8d
         zi3zvxmPfRS1JLpJa9fMCqGzXhOvcXClFUvpC2yevjgLyZk2PVOyOkCCp6EQS+9pHE
         ZDN1pjgpUw+le3WE/VmsnR5pEkX47pYbZMgTwMHBy6KCf3+8pjTkYGbk6lmWCviG7f
         vbGIubjeVMuSqwdxdutaaV/Il3IrzTukDESCtg5R7nLPG3wi+Qh9yEvTIxxtwAZsy+
         uF5I3/4+RPJ4A==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, linux-man@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [RFC PATCH v2] statx, inode: document the new STATX_INO_VERSION field
Date:   Thu,  1 Sep 2022 08:17:14 -0400
Message-Id: <20220901121714.20051-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm proposing to expose the inode change attribute via statx [1]. Document
what this value means and what an observer can infer from it changing.

Signed-off-by: Jeff Layton <jlayton@kernel.org>

[1]: https://lore.kernel.org/linux-nfs/20220826214703.134870-1-jlayton@kernel.org/T/#t
---
 man2/statx.2 | 17 +++++++++++++++++
 man7/inode.7 | 12 ++++++++++++
 2 files changed, 29 insertions(+)

v2: revised the definition to be more strict, since that seemed to be
    consensus on desired behavior. Spurious i_version bumps would now
    be considered bugs, by this definition.

diff --git a/man2/statx.2 b/man2/statx.2
index 0d1b4591f74c..493e4e234809 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -62,6 +62,7 @@ struct statx {
     __u32 stx_dev_major;   /* Major ID */
     __u32 stx_dev_minor;   /* Minor ID */
     __u64 stx_mnt_id;      /* Mount ID */
+    __u64 stx_ino_version; /* Inode change attribute */
 };
 .EE
 .in
@@ -247,6 +248,7 @@ STATX_BTIME	Want stx_btime
 STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
 	It is deprecated and should not be used.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
+STATX_INO_VERSION	Want stx_ino_version (DRAFT)
 .TE
 .in
 .PP
@@ -411,6 +413,21 @@ and corresponds to the number in the first field in one of the records in
 For further information on the above fields, see
 .BR inode (7).
 .\"
+.TP
+.I stx_ino_version
+The inode version, also known as the inode change attribute. This
+value must change any time there is an inode status change. Any
+operation that would cause the
+.I stx_ctime
+to change must also cause
+.I stx_ino_version
+to change, even when there is no apparent change to the
+.I stx_ctime
+due to coarse timestamp granularity.
+.IP
+An observer cannot infer anything about the nature or magnitude of the change
+from the value of this field. A change in this value only indicates that
+there has been an explicit change in the inode.
 .SS File attributes
 The
 .I stx_attributes
diff --git a/man7/inode.7 b/man7/inode.7
index 9b255a890720..d5e0890a52c0 100644
--- a/man7/inode.7
+++ b/man7/inode.7
@@ -184,6 +184,18 @@ Last status change timestamp (ctime)
 This is the file's last status change timestamp.
 It is changed by writing or by setting inode information
 (i.e., owner, group, link count, mode, etc.).
+.TP
+Inode version (i_version)
+(not returned in the \fIstat\fP structure); \fIstatx.stx_ino_version\fP
+.IP
+This is the inode change attribute. Any operation that would result in a change
+to \fIstatx.stx_ctime\fP must result in a change to this value. The value must
+change even in the case where the ctime change is not evident due to coarse
+timestamp granularity.
+.IP
+An observer cannot infer anything from the returned value about the nature or
+magnitude of the change. If the returned value is different from the last time
+it was checked, then something has made an explicit change to the inode.
 .PP
 The timestamp fields report time measured with a zero point at the
 .IR Epoch ,
-- 
2.37.2

