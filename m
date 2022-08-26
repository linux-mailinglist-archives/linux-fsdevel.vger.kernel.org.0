Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3211A5A3181
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 23:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbiHZVt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 17:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345237AbiHZVtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:49:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D848E86B0;
        Fri, 26 Aug 2022 14:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77380611B8;
        Fri, 26 Aug 2022 21:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0523C433C1;
        Fri, 26 Aug 2022 21:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661550470;
        bh=gLz5Ruse5elfcIgvMDWKp/BReownfZtaD32WbbWr76A=;
        h=From:To:Cc:Subject:Date:From;
        b=FfcrPUI2YtcwItJUli98wIyMhirsFq8i/ojoPLXVo4YVq5CrRAammwmg8IU+jM7nK
         h3ZWcORGhfZ5E2MPhkdk4hMmEMx67+WTrQpYNf22qqBjkysL7AsDGszadAod937Rbl
         kMGcojNQDcJaTl5ErtpYRKwsRj8WscbmbfDqROL4CeifPc/+ZerLa3gGarI8KU03o/
         VT/ujDmyDKADuDo6MH9uECUTCmhpHyBKtyvxWcNWTJzjZYnmdL5BpVvNK6I95LeVgt
         tA6Eq1HK4BaVHo+SoOMUxdSzH1nKqDzEOuJLX2D0LkzyE2OESJYNM/0pCWOM4/rlkI
         c+/rmFfC8elyQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org, linux-man@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [man-pages PATCH] statx, inode: document the new STATX_INO_VERSION field
Date:   Fri, 26 Aug 2022 17:47:47 -0400
Message-Id: <20220826214747.134964-1-jlayton@kernel.org>
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

We're planning to expose the inode change attribute via statx. Document
what this value means and what an observer can infer from a change in
its value.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man2/statx.2 | 13 +++++++++++++
 man7/inode.7 | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/man2/statx.2 b/man2/statx.2
index 0d1b4591f74c..644fb251f114 100644
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
+STATX_INO_VERSION	Want stx_ino_version (since Linux 6.1)
 .TE
 .in
 .PP
@@ -411,6 +413,17 @@ and corresponds to the number in the first field in one of the records in
 For further information on the above fields, see
 .BR inode (7).
 .\"
+.TP
+.I stx_ino_version
+The inode version, also known as the inode change attribute. This
+value is intended to change any time there is an inode status change. Any
+operation that would cause the stx_ctime to change should also cause
+stx_ino_version to change, even when there is no apparent change to the
+stx_ctime due to timestamp granularity.
+.IP
+Note that an observer cannot infer anything about the nature or
+magnitude of the change from the value of this field. A change in this value
+only indicates that there may have been an explicit change in the inode.
 .SS File attributes
 The
 .I stx_attributes
diff --git a/man7/inode.7 b/man7/inode.7
index 9b255a890720..d296bb6df70c 100644
--- a/man7/inode.7
+++ b/man7/inode.7
@@ -184,6 +184,16 @@ Last status change timestamp (ctime)
 This is the file's last status change timestamp.
 It is changed by writing or by setting inode information
 (i.e., owner, group, link count, mode, etc.).
+.TP
+Inode version (i_version)
+(not returned in the \fIstat\fP structure); \fIstatx.stx_ino_version\fP
+.IP
+This is the inode change attribute. Any operation that would result in a ctime
+change should also result in a change to this value. The value must change even
+in the case where the ctime change is not evident due to timestamp granularity.
+An observer cannot infer anything from the actual value about the nature or
+magnitude of the change. If it is different from the last time it was checked,
+then something may have made an explicit change to the inode.
 .PP
 The timestamp fields report time measured with a zero point at the
 .IR Epoch ,
-- 
2.37.2

