Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932145ECEA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 22:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiI0UgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiI0UgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54C17C74D;
        Tue, 27 Sep 2022 13:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262C761B9D;
        Tue, 27 Sep 2022 20:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89516C433D6;
        Tue, 27 Sep 2022 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664310953;
        bh=KI+o4v/0Z/0uEBUC8hWcTFsL16DhcnsX1IF8KdH9XQM=;
        h=From:To:Cc:Subject:Date:From;
        b=Canh2CnpYzR+f3P5Nz3xhwztWCpngQuI14I5Ic++NDfv6vmn/5QJOR+A9EKg6rKDV
         0n8EQeDpiiURLNHEfjRG1vK3GqupNX2OZ84seYJOyeW1VAqpz7vpmlA01Ihm6ipRPT
         juAFBAgqrlmKzMFmZMwx+DW5iT22u021L7RRrXbPkVbmpR8Id6Sa5WdEFTUbRl2xQv
         ceTLua4ntz0NDvQ0upni7o/SfSi+LYf6OnnX97FGV9pU2K5SUmSYmFHe3ISaglYE+U
         hi7OXFCTJaQN+qjOLGNsflRnlwWyFDs5a4DInzF0PsCMJjbg8HUsLHkZpigqtlEJ9E
         Lxb8bORjtbAGg==
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
Subject: [PATCH] statx, inode: document the new STATX_VERSION field
Date:   Tue, 27 Sep 2022 16:35:50 -0400
Message-Id: <20220927203550.331261-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>

[1]: https://lore.kernel.org/linux-nfs/d9c065939af2728b1c0768d5ef7526995b634902.camel@kernel.org/T/#t
---
 man2/statx.2 | 13 +++++++++++++
 man7/inode.7 | 31 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

Another RFC posting to hopefully nail down the desired semantics. I
purposefully left out verbiage around atomicity, with the expectation
that we should be able to make the existing filesystems that support
i_version bump the counter after a write instead of before.

Also, for v5:
- drop _INO/_ino from the name (it's redunant)
- add STATX_ATTR_VERSION_MONOTONIC

diff --git a/man2/statx.2 b/man2/statx.2
index 0d1b4591f74c..b2fdb5ddf97a 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -62,6 +62,7 @@ struct statx {
     __u32 stx_dev_major;   /* Major ID */
     __u32 stx_dev_minor;   /* Minor ID */
     __u64 stx_mnt_id;      /* Mount ID */
+    __u64 stx_version; /* Inode change attribute */
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
index 9b255a890720..ec7f80dacaa8 100644
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
@@ -424,6 +430,31 @@ on a directory means that a file
 in that directory can be renamed or deleted only by the owner
 of the file, by the owner of the directory, and by a privileged
 process.
+.SS The inode version counter
+.PP
+The
+.I statx.stx_version
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
+In the event of a system crash this value can appear to go backward,
+if it were queried before being written to the backing store. If
+the value were then incremented again after restart, then an observer
+could miss noticing a change. Applications that persist stx_version values
+across a reboot should take care to mitigate this problem. If the filesystem
+reports \fISTATX_ATTR_VERSION_MONOTONIC\fP in stx_attributes, then it is not
+subject to this problem.
+.PP
+The stx_version is a Linux extension and is not supported by all filesystems.
+The application must verify that the \fISTATX_VERSION\fP bit is set in the
+returned \fIstatx.stx_mask\fP before relying on this field.
 .SH STANDARDS
 If you need to obtain the definition of the
 .I blkcnt_t
-- 
2.37.3

