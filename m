Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2575EDDF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiI1NmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiI1NmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F16E2F4;
        Wed, 28 Sep 2022 06:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F8F761EB1;
        Wed, 28 Sep 2022 13:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB686C433D6;
        Wed, 28 Sep 2022 13:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664372524;
        bh=PDniZhspoAjFGFPMZfaZ8GgB4DLLy5mz44zztNU7B+8=;
        h=From:To:Cc:Subject:Date:From;
        b=DqtgQ/m//i1BdMXDYXkHNALzJc+Fb2CkxwupnjD5iFoPUOy+RjGzDkBw6u16woact
         Ek+6D4V044/DHPxZTiHl8kuYrAVeeMg2TUGzyu9mlJpBrkxFJqDxhyeySNUTWPuyDE
         hkbGAN5/XfCvtPpm39Zv+BugYwMfdEX6eE42uDuYEIIMtghXn56j8tNz+CdNoTpYGY
         oLA0DJOske77HfN24JeefL9hG37cIs4JMzuBMxszwi1t7W9Jgu94CxlxxpRk9x88qB
         1bv9fv5W8vrBkEn3A2+rUfg9FkuebF8rP6DNdglXtFDEV9ehvhMRQoF+tvVevKpvLP
         8XuQDoIktoBXA==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [man-pages RFC PATCH v6] statx, inode: document the new STATX_VERSION field
Date:   Wed, 28 Sep 2022 09:42:00 -0400
Message-Id: <20220928134200.28741-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm proposing to expose the inode change attribute via statx [1]. Document
what this value means and what an observer can infer from it changing.

NB: this will probably have conflicts with the STATX_DIOALIGN doc
patches, but we should be able to resolve those before merging anything.

Signed-off-by: Jeff Layton <jlayton@kernel.org>

[1]: https://lore.kernel.org/linux-nfs/20220826214703.134870-1-jlayton@kernel.org/T/#t
---
 man2/statx.2 | 13 +++++++++++++
 man7/inode.7 | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

v6: incorporate Neil's suggestions
    clarify how well-behaved filesystems should order things

diff --git a/man2/statx.2 b/man2/statx.2
index 0d1b4591f74c..ee7005334a2f 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -62,6 +62,7 @@ struct statx {
     __u32 stx_dev_major;   /* Major ID */
     __u32 stx_dev_minor;   /* Minor ID */
     __u64 stx_mnt_id;      /* Mount ID */
+    __u64 stx_version;     /* Inode change attribute */
 };
 .EE
 .in
@@ -247,6 +248,7 @@ STATX_BTIME	Want stx_btime
 STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
 	It is deprecated and should not be used.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
+STATX_VERSION	Want stx_version (DRAFT)
 .TE
 .in
 .PP
@@ -407,10 +409,16 @@ This is the same number reported by
 .BR name_to_handle_at (2)
 and corresponds to the number in the first field in one of the records in
 .IR /proc/self/mountinfo .
+.TP
+.I stx_version
+The inode version, also known as the inode change attribute. See
+.BR inode (7)
+for details.
 .PP
 For further information on the above fields, see
 .BR inode (7).
 .\"
+.TP
 .SS File attributes
 The
 .I stx_attributes
@@ -489,6 +497,11 @@ without an explicit
 See
 .BR mmap (2)
 for more information.
+.TP
+.BR STATX_ATTR_VERSION_MONOTONIC " (since Linux 6.?)"
+The stx_version value monotonically increases over time and will never appear
+to go backward, even in the event of a crash. This can allow an application to
+make a better determination about ordering when viewing different versions.
 .SH RETURN VALUE
 On success, zero is returned.
 On error, \-1 is returned, and
diff --git a/man7/inode.7 b/man7/inode.7
index 9b255a890720..e8adb63b1f6a 100644
--- a/man7/inode.7
+++ b/man7/inode.7
@@ -184,6 +184,12 @@ Last status change timestamp (ctime)
 This is the file's last status change timestamp.
 It is changed by writing or by setting inode information
 (i.e., owner, group, link count, mode, etc.).
+.TP
+Inode version (version)
+(not returned in the \fIstat\fP structure); \fIstatx.stx_version\fP
+.IP
+This is the inode change counter. See the discussion of
+\fBthe inode version counter\fP, below.
 .PP
 The timestamp fields report time measured with a zero point at the
 .IR Epoch ,
@@ -424,6 +430,36 @@ on a directory means that a file
 in that directory can be renamed or deleted only by the owner
 of the file, by the owner of the directory, and by a privileged
 process.
+.SS The inode version counter
+.PP
+The \fIstatx.stx_version\fP field is the inode change counter. Any operation
+that could result in a change to \fIstatx.stx_ctime\fP must result in an
+increase to this value. Soon after a change has been made, an stx_version value
+should appear to be larger than previous readings. This is the case even
+when a ctime change is not evident due to coarse timestamp granularity.
+.PP
+An observer cannot infer anything from amount of increase about the
+nature or magnitude of the change. In fact, a single increment can reflect
+multiple discrete changes if the value was not checked while those changes
+were being processed.
+.PP
+Changes to stx_version are not necessarily atomic with the change itself, but
+well-behaved filesystems should increment stx_version after a change has been
+made visible to observers rather than before. This is especially important for
+read-caching algorithms which could be fooled into associating a newer
+stx_version with an older version of data. Note that this does leave a window
+of time where a change may be visible, but the old stx_version is still being
+reported.
+.PP
+In the event of a system crash, this value can appear to go backward if it was
+queried before ever being written to the backing store. Applications that
+persist stx_version values across a reboot should take care to mitigate this.
+If the filesystem reports \fISTATX_ATTR_VERSION_MONOTONIC\fP in
+\fIstatx.stx_attributes\fP, then it is not subject to this problem.
+.PP
+The stx_version is a Linux extension and is not supported by all filesystems.
+The application must verify that the \fISTATX_VERSION\fP bit is set in the
+returned \fIstatx.stx_mask\fP before relying on this field.
 .SH STANDARDS
 If you need to obtain the definition of the
 .I blkcnt_t
-- 
2.37.3

