Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F1265D067
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjADKJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 05:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjADKIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:08:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E001648E;
        Wed,  4 Jan 2023 02:08:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D78861155;
        Wed,  4 Jan 2023 10:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C6EC433D2;
        Wed,  4 Jan 2023 10:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672826922;
        bh=HvGmkbQgHHB4C3jDucLP9gLeB7Qi1ZGtVJnCeMs8Y18=;
        h=From:Date:Subject:To:Cc:From;
        b=VHKctE0nf0w62LvZ/3m5wFHg0uMY2kMGc5pyaLmj0FtUXAwKZ6KBIxF+7RUE+GHdM
         7IznNNTxsyBmF7KFEWCKEVDYP0LuPvgY6AxuuLpLs7cV3npCu3fX87iaGeXrnTV5uP
         6TvsRi0A81Y0QOkbQWmaX7GytT1ZrHIhr2yVr13v+ESgGYM6gBEi74RLZqncyu+JWr
         25TldTqFi7eeuAsI3Y+mKSt/Wogly/U/jasI9HNUza382fUSuOJQx6EZ+ZzmkWGuv0
         uwNksepZ9EAXfZZ5f21MFN+n8a5eRoBxdeoCmiq3B7QAxNK9wgI+p7DwIGxv8aSD3B
         3NH7ZTxagRycA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 04 Jan 2023 11:08:19 +0100
Subject: [PATCH v2] generic: update setgid tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org>
X-B4-Tracking: v=1; b=H4sIABNQtWMC/32NQQ6CMBAAv2J6dk27FUVP/sNwoGWBRlLMbm00h
 L9beYDHmWQyixLiQKKuu0Ux5SBhjgVwv1N+bONAELrCCjVabbSFXhJJEhBKQ+ggnwDh6KmqK+yM
 IVSldK0QOG6jH0sbX9NU5JOpD+9tdW8Kj0HSzJ/tnM3P/p9kAwZcfTmjt9qSo9uDONJ0mHlQzbq
 uX9OMRKHMAAAA
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>, Zorro Lang <zlang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15631; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HvGmkbQgHHB4C3jDucLP9gLeB7Qi1ZGtVJnCeMs8Y18=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRvDdDYN2Fu1JOVq4Pe1tc/TGYUmOT7j0v/5LUrpbv7juhv
 e/JkdkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEFikw/K952rjmWoSnrtjhf2xuku
 wztffs2y1579uduPW+n192H9Zm+F9t8u/x8tdTpnzSipzY1vPyeMhZlY/P/7bPPdzmISK8Yi8HAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Over mutiple kernel releases we have reworked setgid inheritance
significantly due to long-standing security issues, security issues that
were reintroduced after they were fixed, and the subtle and difficult
inheritance rules that plagued individual filesystems. We have lifted
setgid inheritance into the VFS proper in earlier patches. Starting with
kernel v6.2 we have made setgid inheritance consistent between the write
and setattr (ch{mod,own}) paths.

The gist of the requirement is that in order to inherit the setgid bit
the user needs to be in the group of the file or have CAP_FSETID in
their user namespace. Otherwise the setgid bit will be dropped
irregardless of the file's executability. Change the tests accordingly
and annotate them with the commits that changed the behavior.

Note, that only with v6.2 setgid inheritance works correctly for
overlayfs in the write path. Before this the setgid bit was always
retained.

Link: https://lore.kernel.org/linux-ext4/CAOQ4uxhmCgyorYVtD6=n=khqwUc=MPbZs+y=sqt09XbGoNm_tA@mail.gmail.com
Link: https://lore.kernel.org/linux-fsdevel/20221212112053.99208-1-brauner@kernel.org
Link: https://lore.kernel.org/linux-fsdevel/20221122142010.zchf2jz2oymx55qi@wittgenstein
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v2:
- Darrick J. Wong <djwong@kernel.org>:
  - Also update generic/686 and generic/687.
- Link to v1: https://lore.kernel.org/r/20230103-fstests-setgid-v6-2-v1-1-b8972c303ebe@kernel.org
---
 tests/generic/673     | 12 +++++++++---
 tests/generic/673.out |  8 ++++----
 tests/generic/683     | 11 ++++++++---
 tests/generic/683.out |  8 ++++----
 tests/generic/684     | 11 ++++++++---
 tests/generic/684.out |  8 ++++----
 tests/generic/685     | 11 ++++++++---
 tests/generic/685.out |  8 ++++----
 tests/generic/686     | 11 ++++++++---
 tests/generic/686.out |  8 ++++----
 tests/generic/687     |  6 +++---
 tests/generic/687.out |  8 ++++----
 12 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/tests/generic/673 b/tests/generic/673
index 6d1f49ea..1d8e4184 100755
--- a/tests/generic/673
+++ b/tests/generic/673
@@ -23,6 +23,12 @@ _require_scratch_reflink
 _scratch_mkfs >> $seqres.full
 _scratch_mount
 _require_congruent_file_oplen $SCRATCH_MNT 1048576
+
+# Due to multiple security issues and potential for subtle bugs around setgid
+# inheritance the rules in the write and chmod/chown paths have been made
+# consistent and are enforced by the VFS since kernel 6.2.
+_fixed_in_kernel_version "v6.2"
+
 chmod a+rw $SCRATCH_MNT/
 
 setup_testfile() {
@@ -102,8 +108,8 @@ setup_testfile
 chmod a+rwxs $SCRATCH_MNT/a
 commit_and_check
 
-#Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file"
 setup_testfile
 chmod a+rw,g+rws $SCRATCH_MNT/a
 commit_and_check "$qa_user"
@@ -115,7 +121,7 @@ chmod a+rw,g+rwxs $SCRATCH_MNT/a
 commit_and_check "$qa_user"
 
 #Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file, only sgid"
+echo "Test 11 - qa_user, user-exec file"
 setup_testfile
 chmod a+rw,u+x,g+rws $SCRATCH_MNT/a
 commit_and_check "$qa_user"
diff --git a/tests/generic/673.out b/tests/generic/673.out
index 0817857d..54e04232 100644
--- a/tests/generic/673.out
+++ b/tests/generic/673.out
@@ -47,11 +47,11 @@ Test 8 - root, all-exec file
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
 6777 -rwsrwsrwx SCRATCH_MNT/a
 
-Test 9 - qa_user, non-exec file, only sgid
+Test 9 - qa_user, non-exec file
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
 2666 -rw-rwSrw- SCRATCH_MNT/a
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
-2666 -rw-rwSrw- SCRATCH_MNT/a
+666 -rw-rw-rw- SCRATCH_MNT/a
 
 Test 10 - qa_user, group-exec file, only sgid
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
@@ -59,11 +59,11 @@ Test 10 - qa_user, group-exec file, only sgid
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
 676 -rw-rwxrw- SCRATCH_MNT/a
 
-Test 11 - qa_user, user-exec file, only sgid
+Test 11 - qa_user, user-exec file
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
 2766 -rwxrwSrw- SCRATCH_MNT/a
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
-2766 -rwxrwSrw- SCRATCH_MNT/a
+766 -rwxrw-rw- SCRATCH_MNT/a
 
 Test 12 - qa_user, all-exec file, only sgid
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
diff --git a/tests/generic/683 b/tests/generic/683
index eea8d21b..74b72e5b 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -30,6 +30,11 @@ verb=falloc
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
 
+# Due to multiple security issues and potential for subtle bugs around setgid
+# inheritance the rules in the write and chmod/chown paths have been made
+# consistent and are enforced by the VFS since kernel 6.2.
+_fixed_in_kernel_version "v6.2"
+
 junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/a
 mkdir -p $junk_dir/
@@ -110,8 +115,8 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rw,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
@@ -123,7 +128,7 @@ chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
 # Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+echo "Test 11 - qa_user, user-exec file $verb"
 setup_testfile
 chmod a+rw,u+x,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/683.out b/tests/generic/683.out
index ca29f6e6..a7e04e4a 100644
--- a/tests/generic/683.out
+++ b/tests/generic/683.out
@@ -31,17 +31,17 @@ Test 8 - root, all-exec file falloc
 6777 -rwsrwsrwx TEST_DIR/683/a
 6777 -rwsrwsrwx TEST_DIR/683/a
 
-Test 9 - qa_user, non-exec file falloc, only sgid
-2666 -rw-rwSrw- TEST_DIR/683/a
+Test 9 - qa_user, non-exec file falloc
 2666 -rw-rwSrw- TEST_DIR/683/a
+666 -rw-rw-rw- TEST_DIR/683/a
 
 Test 10 - qa_user, group-exec file falloc, only sgid
 2676 -rw-rwsrw- TEST_DIR/683/a
 676 -rw-rwxrw- TEST_DIR/683/a
 
-Test 11 - qa_user, user-exec file falloc, only sgid
-2766 -rwxrwSrw- TEST_DIR/683/a
+Test 11 - qa_user, user-exec file falloc
 2766 -rwxrwSrw- TEST_DIR/683/a
+766 -rwxrw-rw- TEST_DIR/683/a
 
 Test 12 - qa_user, all-exec file falloc, only sgid
 2777 -rwxrwsrwx TEST_DIR/683/a
diff --git a/tests/generic/684 b/tests/generic/684
index 541dbeb4..6fad7f75 100755
--- a/tests/generic/684
+++ b/tests/generic/684
@@ -30,6 +30,11 @@ verb=fpunch
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
 
+# Due to multiple security issues and potential for subtle bugs around setgid
+# inheritance the rules in the write and chmod/chown paths have been made
+# consistent and are enforced by the VFS since kernel 6.2.
+_fixed_in_kernel_version "v6.2"
+
 junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/a
 mkdir -p $junk_dir/
@@ -110,8 +115,8 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rw,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
@@ -123,7 +128,7 @@ chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
 # Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+echo "Test 11 - qa_user, user-exec file $verb"
 setup_testfile
 chmod a+rw,u+x,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/684.out b/tests/generic/684.out
index 2e084ced..5c803cd4 100644
--- a/tests/generic/684.out
+++ b/tests/generic/684.out
@@ -31,17 +31,17 @@ Test 8 - root, all-exec file fpunch
 6777 -rwsrwsrwx TEST_DIR/684/a
 6777 -rwsrwsrwx TEST_DIR/684/a
 
-Test 9 - qa_user, non-exec file fpunch, only sgid
-2666 -rw-rwSrw- TEST_DIR/684/a
+Test 9 - qa_user, non-exec file fpunch
 2666 -rw-rwSrw- TEST_DIR/684/a
+666 -rw-rw-rw- TEST_DIR/684/a
 
 Test 10 - qa_user, group-exec file fpunch, only sgid
 2676 -rw-rwsrw- TEST_DIR/684/a
 676 -rw-rwxrw- TEST_DIR/684/a
 
-Test 11 - qa_user, user-exec file fpunch, only sgid
-2766 -rwxrwSrw- TEST_DIR/684/a
+Test 11 - qa_user, user-exec file fpunch
 2766 -rwxrwSrw- TEST_DIR/684/a
+766 -rwxrw-rw- TEST_DIR/684/a
 
 Test 12 - qa_user, all-exec file fpunch, only sgid
 2777 -rwxrwsrwx TEST_DIR/684/a
diff --git a/tests/generic/685 b/tests/generic/685
index 29eca1a8..56be0a0c 100755
--- a/tests/generic/685
+++ b/tests/generic/685
@@ -30,6 +30,11 @@ verb=fzero
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
 
+# Due to multiple security issues and potential for subtle bugs around setgid
+# inheritance the rules in the write and chmod/chown paths have been made
+# consistent and are enforced by the VFS since kernel 6.2.
+_fixed_in_kernel_version "v6.2"
+
 junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/a
 mkdir -p $junk_dir/
@@ -110,8 +115,8 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rw,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
@@ -123,7 +128,7 @@ chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
 # Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+echo "Test 11 - qa_user, user-exec file $verb"
 setup_testfile
 chmod a+rw,u+x,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/685.out b/tests/generic/685.out
index e611da3e..788457ba 100644
--- a/tests/generic/685.out
+++ b/tests/generic/685.out
@@ -31,17 +31,17 @@ Test 8 - root, all-exec file fzero
 6777 -rwsrwsrwx TEST_DIR/685/a
 6777 -rwsrwsrwx TEST_DIR/685/a
 
-Test 9 - qa_user, non-exec file fzero, only sgid
-2666 -rw-rwSrw- TEST_DIR/685/a
+Test 9 - qa_user, non-exec file fzero
 2666 -rw-rwSrw- TEST_DIR/685/a
+666 -rw-rw-rw- TEST_DIR/685/a
 
 Test 10 - qa_user, group-exec file fzero, only sgid
 2676 -rw-rwsrw- TEST_DIR/685/a
 676 -rw-rwxrw- TEST_DIR/685/a
 
-Test 11 - qa_user, user-exec file fzero, only sgid
-2766 -rwxrwSrw- TEST_DIR/685/a
+Test 11 - qa_user, user-exec file fzero
 2766 -rwxrwSrw- TEST_DIR/685/a
+766 -rwxrw-rw- TEST_DIR/685/a
 
 Test 12 - qa_user, all-exec file fzero, only sgid
 2777 -rwxrwsrwx TEST_DIR/685/a
diff --git a/tests/generic/686 b/tests/generic/686
index a8ec23d5..bd54ad10 100755
--- a/tests/generic/686
+++ b/tests/generic/686
@@ -30,6 +30,11 @@ verb=finsert
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
 
+# Due to multiple security issues and potential for subtle bugs around setgid
+# inheritance the rules in the write and chmod/chown paths have been made
+# consistent and are enforced by the VFS since kernel 6.2.
+_fixed_in_kernel_version "v6.2"
+
 junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/a
 mkdir -p $junk_dir/
@@ -110,8 +115,8 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rw,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
@@ -123,7 +128,7 @@ chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
 # Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+echo "Test 11 - qa_user, user-exec file $verb"
 setup_testfile
 chmod a+rw,u+x,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/686.out b/tests/generic/686.out
index aa1e6471..355ef4c3 100644
--- a/tests/generic/686.out
+++ b/tests/generic/686.out
@@ -31,17 +31,17 @@ Test 8 - root, all-exec file finsert
 6777 -rwsrwsrwx TEST_DIR/686/a
 6777 -rwsrwsrwx TEST_DIR/686/a
 
-Test 9 - qa_user, non-exec file finsert, only sgid
-2666 -rw-rwSrw- TEST_DIR/686/a
+Test 9 - qa_user, non-exec file finsert
 2666 -rw-rwSrw- TEST_DIR/686/a
+666 -rw-rw-rw- TEST_DIR/686/a
 
 Test 10 - qa_user, group-exec file finsert, only sgid
 2676 -rw-rwsrw- TEST_DIR/686/a
 676 -rw-rwxrw- TEST_DIR/686/a
 
-Test 11 - qa_user, user-exec file finsert, only sgid
-2766 -rwxrwSrw- TEST_DIR/686/a
+Test 11 - qa_user, user-exec file finsert
 2766 -rwxrwSrw- TEST_DIR/686/a
+766 -rwxrw-rw- TEST_DIR/686/a
 
 Test 12 - qa_user, all-exec file finsert, only sgid
 2777 -rwxrwsrwx TEST_DIR/686/a
diff --git a/tests/generic/687 b/tests/generic/687
index ff3e2fe1..ab09756f 100755
--- a/tests/generic/687
+++ b/tests/generic/687
@@ -110,8 +110,8 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rw,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
@@ -123,7 +123,7 @@ chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
 # Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+echo "Test 11 - qa_user, user-exec file $verb"
 setup_testfile
 chmod a+rw,u+x,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/687.out b/tests/generic/687.out
index c5116c27..d88bbd08 100644
--- a/tests/generic/687.out
+++ b/tests/generic/687.out
@@ -31,17 +31,17 @@ Test 8 - root, all-exec file fcollapse
 6777 -rwsrwsrwx TEST_DIR/687/a
 6777 -rwsrwsrwx TEST_DIR/687/a
 
-Test 9 - qa_user, non-exec file fcollapse, only sgid
-2666 -rw-rwSrw- TEST_DIR/687/a
+Test 9 - qa_user, non-exec file fcollapse
 2666 -rw-rwSrw- TEST_DIR/687/a
+666 -rw-rw-rw- TEST_DIR/687/a
 
 Test 10 - qa_user, group-exec file fcollapse, only sgid
 2676 -rw-rwsrw- TEST_DIR/687/a
 676 -rw-rwxrw- TEST_DIR/687/a
 
-Test 11 - qa_user, user-exec file fcollapse, only sgid
-2766 -rwxrwSrw- TEST_DIR/687/a
+Test 11 - qa_user, user-exec file fcollapse
 2766 -rwxrwSrw- TEST_DIR/687/a
+766 -rwxrw-rw- TEST_DIR/687/a
 
 Test 12 - qa_user, all-exec file fcollapse, only sgid
 2777 -rwxrwsrwx TEST_DIR/687/a

---
base-commit: fbd489798b31e32f0eaefcd754326a06aa5b166f
change-id: 20230103-fstests-setgid-v6-2-4ce5852d11e2
