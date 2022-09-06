Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C05AE995
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbiIFN3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbiIFN3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:29:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35214BC05;
        Tue,  6 Sep 2022 06:29:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D44BAB818C2;
        Tue,  6 Sep 2022 13:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791BCC433D6;
        Tue,  6 Sep 2022 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662470972;
        bh=eT4U+WivGyOotiGD0LRV2zLl7flGTzXZdjdWMcvNt7E=;
        h=From:To:Cc:Subject:Date:From;
        b=XwovBfCAI5xmw0RPdItCdZLjQ7bhW5v9Eu/vggCoju8MpsiPBXQ9MB2FAMttCv+DJ
         nNFf4HHdz4g+SXNSMUeZuf3erv08qXCs76NUClj77fMxrGkpexrIX0KiBJSs6U6lea
         9T5yCH9BS4KEJiwDQv3CKt0Iaxtygw8eFvyYON+QXJ0tmYGToCCggQFH3M6U/QMCdL
         io2MN9GWbXvJuhHMWUHnhg4WzOz8GYzvsNHs65QkYDYqt+Za12C1yUaIdLNRr/jD5M
         cS9+EXliVqd5LDrc34V0Nrx1sGR8zzIZtyqalLz/D+OAPa/mnX5D5iR0PCCL/LqEvE
         BvVSERciktYmA==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [man-pages RFC PATCH v3] statx, inode: document the STATX_INO_VERSION field
Date:   Tue,  6 Sep 2022 09:29:28 -0400
Message-Id: <20220906132928.106134-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
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
what this value means and what an observer can infer from a change in
its value.

Signed-off-by: Jeff Layton <jlayton@kernel.org>

[1]: https://lore.kernel.org/linux-nfs/20220826214703.134870-1-jlayton@kernel.org/T/#t
---
 man2/statx.2 |  8 ++++++++
 man7/inode.7 | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

v3: Move most verbiage to inode(7)
    Clarify that this must be monotonically increasing
    Flesh out usage discussion
    Mention issues with value moving backward and how to combat them

diff --git a/man2/statx.2 b/man2/statx.2
index 0d1b4591f74c..d98d5148a442 100644
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
@@ -407,10 +409,16 @@ This is the same number reported by
 .BR name_to_handle_at (2)
 and corresponds to the number in the first field in one of the records in
 .IR /proc/self/mountinfo .
+.TP
+.I stx_ino_version
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
diff --git a/man7/inode.7 b/man7/inode.7
index 9b255a890720..80c2ed4acccd 100644
--- a/man7/inode.7
+++ b/man7/inode.7
@@ -184,6 +184,12 @@ Last status change timestamp (ctime)
 This is the file's last status change timestamp.
 It is changed by writing or by setting inode information
 (i.e., owner, group, link count, mode, etc.).
+.TP
+Inode version (i_version)
+(not returned in the \fIstat\fP structure); \fIstatx.stx_ino_version\fP
+.IP
+This is the inode change counter. See the discussion of
+\fBthe inode version counter\fP, below.
 .PP
 The timestamp fields report time measured with a zero point at the
 .IR Epoch ,
@@ -424,6 +430,34 @@ on a directory means that a file
 in that directory can be renamed or deleted only by the owner
 of the file, by the owner of the directory, and by a privileged
 process.
+.SS The inode version counter
+.PP
+The
+.I statx.stx_ino_version
+field is the inode change counter. Any operation that would result in a
+change to \fIstatx.stx_ctime\fP must result in an increase to this value.
+The value must increase even in the case where the ctime change is not
+evident due to coarse timestamp granularity.
+.PP
+An observer cannot infer anything from amount of increase about the
+nature or magnitude of the change. If the returned value is different
+from the last time it was checked, then something has made an explicit
+data and/or metadata change to the inode.
+.PP
+In the event of a system crash, this value can appear to go backward,
+if it were queried before ever being written to the backing store. If
+the value were then incremented again after restart, then an observer
+could miss noticing a change.
+.PP
+In order to guard against this, it is recommended to also watch the
+\fIstatx.stx_ctime\fP for changes when watching this value. As long as the
+system clock doesn't jump backward during the crash, an observer can be
+reasonably sure that the i_version and ctime together represent a unique inode
+state.
+.PP
+The i_version is a Linux extension and is not supported by all filesystems.
+The application must verify that the \fISTATX_INO_VERSION\fP bit is set in the
+returned \fIstatx.stx_mask\fP before relying on this field.
 .SH STANDARDS
 If you need to obtain the definition of the
 .I blkcnt_t
-- 
2.37.3

