Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A165EF62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 15:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjAEOx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 09:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjAEOxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:53:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0018E50;
        Thu,  5 Jan 2023 06:53:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DAE0B81ABD;
        Thu,  5 Jan 2023 14:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84522C433D2;
        Thu,  5 Jan 2023 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672930430;
        bh=bkepSjHYCKkz9fl1KfF2UOsXKAPPaLvryIauMLx2cdw=;
        h=From:Date:Subject:To:Cc:From;
        b=j/rjWHsje/rRSDeDtGW1rJKSWmgmMSisU9ndu7xEF2nCEjCz/fFbYJK0clkFZs48R
         Mwx1f4kPloGXc9YtE6lZahfsBtkbmVaoLFRC/bfHHZ/v2A0ci7SpTrrLZ27WU2Wu+2
         TtIOkW7ak0nnWntSd8ku6ZH3DkZ7JJNjUL3MtLKIL3QxmQJ6HlrZP9oxAhxiHnNUFw
         e7oDjeNmTxcCu5pBCS06pwDNL0i4LTLCgvb40cPNRAXC3bZZyPUwaFsjoRcwdfAVkz
         Thq8we0dBEDthO1ZnAJp0wlAxZkmL+x/VQ41owD+3prhc78xmNLeuiudBuO76IWyCO
         C3ZHMY5f9LRrQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Thu, 05 Jan 2023 15:53:36 +0100
Subject: [PATCH v3] generic: update setgid tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-fstests-setgid-v6-2-v3-1-5950c139bfcc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHDktmMC/42NQQ6CMBBFr0K6dkw7BQFX3sO4oGWARlJMBxsN4
 e4Wdm6My/eT/94imIIjFudsEYGiYzf5BPqQCTs0vidwbWKBErVUUkPHM/HMwDT3roV4AoTcUlEV
 2CpFKNLTNExgQuPtkL7+OY5pfATq3GtPXW+JB8fzFN57Oapt/R2JChSYqi7RaqnJ0OVOwdN4nEI
 vNmHEPySYJLUtJRE2uVL6S7Ku6weU92TMEQEAAA==
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>, Zorro Lang <zlang@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12-dev-aab37
X-Developer-Signature: v=1; a=openpgp-sha256; l=15532; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bkepSjHYCKkz9fl1KfF2UOsXKAPPaLvryIauMLx2cdw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRve1JTEratLGJScIrJ0iaXns5VbulpE6IP9nBfEWRannBI
 8aNVRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQermT4n35o1o4HS+axPe7TVDkeGb
 7ITXNzTW3chja3Pe3Ckq9nszIyrJpT7RT5RWBKwcv6G6L1WjJBT3JFc6a0fb5u82BX1Bs1JgA=
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
irregardless of the file's executability. Remove the obsolete tests as
they're not a security issue and will cause spurious warnings on older
distro kernels.

Note, that only with v6.2 setgid inheritance works correctly for
overlayfs in the write path. Before this the setgid bit was always

Link: https://lore.kernel.org/linux-ext4/CAOQ4uxhmCgyorYVtD6=n=khqwUc=MPbZs+y=sqt09XbGoNm_tA@mail.gmail.com
Link: https://lore.kernel.org/linux-fsdevel/20221212112053.99208-1-brauner@kernel.org
Link: https://lore.kernel.org/linux-fsdevel/20221122142010.zchf2jz2oymx55qi@wittgenstein
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v3:
- Miklos Szeredi <miklos@szeredi.hu>
  - Instead of fixing up the test which changed, remove them.
- Link to v2: https://lore.kernel.org/r/20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org

Changes in v2:
- Darrick J. Wong <djwong@kernel.org>:
  - Also update generic/686 and generic/687.
- Link to v1: https://lore.kernel.org/r/20230103-fstests-setgid-v6-2-v1-1-b8972c303ebe@kernel.org
---
 tests/generic/673     | 16 ++--------------
 tests/generic/673.out | 16 ++--------------
 tests/generic/683     | 16 ++--------------
 tests/generic/683.out | 12 ++----------
 tests/generic/684     | 16 ++--------------
 tests/generic/684.out | 12 ++----------
 tests/generic/685     | 16 ++--------------
 tests/generic/685.out | 12 ++----------
 tests/generic/686     | 16 ++--------------
 tests/generic/686.out | 12 ++----------
 tests/generic/687     | 16 ++--------------
 tests/generic/687.out | 12 ++----------
 12 files changed, 24 insertions(+), 148 deletions(-)

diff --git a/tests/generic/673 b/tests/generic/673
index 6d1f49ea..ac8b8c09 100755
--- a/tests/generic/673
+++ b/tests/generic/673
@@ -102,26 +102,14 @@ setup_testfile
 chmod a+rwxs $SCRATCH_MNT/a
 commit_and_check
 
-#Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file, only sgid"
-setup_testfile
-chmod a+rw,g+rws $SCRATCH_MNT/a
-commit_and_check "$qa_user"
-
 #Commit to a group-exec file by an unprivileged user clears sgid
-echo "Test 10 - qa_user, group-exec file, only sgid"
+echo "Test 9 - qa_user, group-exec file, only sgid"
 setup_testfile
 chmod a+rw,g+rwxs $SCRATCH_MNT/a
 commit_and_check "$qa_user"
 
-#Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file, only sgid"
-setup_testfile
-chmod a+rw,u+x,g+rws $SCRATCH_MNT/a
-commit_and_check "$qa_user"
-
 #Commit to a all-exec file by an unprivileged user clears sgid.
-echo "Test 12 - qa_user, all-exec file, only sgid"
+echo "Test 10 - qa_user, all-exec file, only sgid"
 setup_testfile
 chmod a+rwx,g+rwxs $SCRATCH_MNT/a
 commit_and_check "$qa_user"
diff --git a/tests/generic/673.out b/tests/generic/673.out
index 0817857d..4276fa01 100644
--- a/tests/generic/673.out
+++ b/tests/generic/673.out
@@ -47,25 +47,13 @@ Test 8 - root, all-exec file
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
 6777 -rwsrwsrwx SCRATCH_MNT/a
 
-Test 9 - qa_user, non-exec file, only sgid
-310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
-2666 -rw-rwSrw- SCRATCH_MNT/a
-3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
-2666 -rw-rwSrw- SCRATCH_MNT/a
-
-Test 10 - qa_user, group-exec file, only sgid
+Test 9 - qa_user, group-exec file, only sgid
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
 2676 -rw-rwsrw- SCRATCH_MNT/a
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
 676 -rw-rwxrw- SCRATCH_MNT/a
 
-Test 11 - qa_user, user-exec file, only sgid
-310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
-2766 -rwxrwSrw- SCRATCH_MNT/a
-3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
-2766 -rwxrwSrw- SCRATCH_MNT/a
-
-Test 12 - qa_user, all-exec file, only sgid
+Test 10 - qa_user, all-exec file, only sgid
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
 2777 -rwxrwsrwx SCRATCH_MNT/a
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
diff --git a/tests/generic/683 b/tests/generic/683
index eea8d21b..304b1a48 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -110,26 +110,14 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a group-exec file by an unprivileged user clears sgid
-echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+echo "Test 9 - qa_user, group-exec file $verb, only sgid"
 setup_testfile
 chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,u+x,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a all-exec file by an unprivileged user clears sgid.
-echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+echo "Test 10 - qa_user, all-exec file $verb, only sgid"
 setup_testfile
 chmod a+rwx,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/683.out b/tests/generic/683.out
index ca29f6e6..de18ea5f 100644
--- a/tests/generic/683.out
+++ b/tests/generic/683.out
@@ -31,19 +31,11 @@ Test 8 - root, all-exec file falloc
 6777 -rwsrwsrwx TEST_DIR/683/a
 6777 -rwsrwsrwx TEST_DIR/683/a
 
-Test 9 - qa_user, non-exec file falloc, only sgid
-2666 -rw-rwSrw- TEST_DIR/683/a
-2666 -rw-rwSrw- TEST_DIR/683/a
-
-Test 10 - qa_user, group-exec file falloc, only sgid
+Test 9 - qa_user, group-exec file falloc, only sgid
 2676 -rw-rwsrw- TEST_DIR/683/a
 676 -rw-rwxrw- TEST_DIR/683/a
 
-Test 11 - qa_user, user-exec file falloc, only sgid
-2766 -rwxrwSrw- TEST_DIR/683/a
-2766 -rwxrwSrw- TEST_DIR/683/a
-
-Test 12 - qa_user, all-exec file falloc, only sgid
+Test 10 - qa_user, all-exec file falloc, only sgid
 2777 -rwxrwsrwx TEST_DIR/683/a
 777 -rwxrwxrwx TEST_DIR/683/a
 
diff --git a/tests/generic/684 b/tests/generic/684
index 541dbeb4..1ebffb01 100755
--- a/tests/generic/684
+++ b/tests/generic/684
@@ -110,26 +110,14 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a group-exec file by an unprivileged user clears sgid
-echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+echo "Test 9 - qa_user, group-exec file $verb, only sgid"
 setup_testfile
 chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,u+x,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a all-exec file by an unprivileged user clears sgid.
-echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+echo "Test 10 - qa_user, all-exec file $verb, only sgid"
 setup_testfile
 chmod a+rwx,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/684.out b/tests/generic/684.out
index 2e084ced..da5ada5e 100644
--- a/tests/generic/684.out
+++ b/tests/generic/684.out
@@ -31,19 +31,11 @@ Test 8 - root, all-exec file fpunch
 6777 -rwsrwsrwx TEST_DIR/684/a
 6777 -rwsrwsrwx TEST_DIR/684/a
 
-Test 9 - qa_user, non-exec file fpunch, only sgid
-2666 -rw-rwSrw- TEST_DIR/684/a
-2666 -rw-rwSrw- TEST_DIR/684/a
-
-Test 10 - qa_user, group-exec file fpunch, only sgid
+Test 9 - qa_user, group-exec file fpunch, only sgid
 2676 -rw-rwsrw- TEST_DIR/684/a
 676 -rw-rwxrw- TEST_DIR/684/a
 
-Test 11 - qa_user, user-exec file fpunch, only sgid
-2766 -rwxrwSrw- TEST_DIR/684/a
-2766 -rwxrwSrw- TEST_DIR/684/a
-
-Test 12 - qa_user, all-exec file fpunch, only sgid
+Test 10 - qa_user, all-exec file fpunch, only sgid
 2777 -rwxrwsrwx TEST_DIR/684/a
 777 -rwxrwxrwx TEST_DIR/684/a
 
diff --git a/tests/generic/685 b/tests/generic/685
index 29eca1a8..e4ada8e7 100755
--- a/tests/generic/685
+++ b/tests/generic/685
@@ -110,26 +110,14 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a group-exec file by an unprivileged user clears sgid
-echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+echo "Test 9 - qa_user, group-exec file $verb, only sgid"
 setup_testfile
 chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,u+x,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a all-exec file by an unprivileged user clears sgid.
-echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+echo "Test 10 - qa_user, all-exec file $verb, only sgid"
 setup_testfile
 chmod a+rwx,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/685.out b/tests/generic/685.out
index e611da3e..03eef362 100644
--- a/tests/generic/685.out
+++ b/tests/generic/685.out
@@ -31,19 +31,11 @@ Test 8 - root, all-exec file fzero
 6777 -rwsrwsrwx TEST_DIR/685/a
 6777 -rwsrwsrwx TEST_DIR/685/a
 
-Test 9 - qa_user, non-exec file fzero, only sgid
-2666 -rw-rwSrw- TEST_DIR/685/a
-2666 -rw-rwSrw- TEST_DIR/685/a
-
-Test 10 - qa_user, group-exec file fzero, only sgid
+Test 9 - qa_user, group-exec file fzero, only sgid
 2676 -rw-rwsrw- TEST_DIR/685/a
 676 -rw-rwxrw- TEST_DIR/685/a
 
-Test 11 - qa_user, user-exec file fzero, only sgid
-2766 -rwxrwSrw- TEST_DIR/685/a
-2766 -rwxrwSrw- TEST_DIR/685/a
-
-Test 12 - qa_user, all-exec file fzero, only sgid
+Test 10 - qa_user, all-exec file fzero, only sgid
 2777 -rwxrwsrwx TEST_DIR/685/a
 777 -rwxrwxrwx TEST_DIR/685/a
 
diff --git a/tests/generic/686 b/tests/generic/686
index a8ec23d5..d56aa7cc 100755
--- a/tests/generic/686
+++ b/tests/generic/686
@@ -110,26 +110,14 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a group-exec file by an unprivileged user clears sgid
-echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+echo "Test 9 - qa_user, group-exec file $verb, only sgid"
 setup_testfile
 chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,u+x,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a all-exec file by an unprivileged user clears sgid.
-echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+echo "Test 10 - qa_user, all-exec file $verb, only sgid"
 setup_testfile
 chmod a+rwx,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/686.out b/tests/generic/686.out
index aa1e6471..562e1ab9 100644
--- a/tests/generic/686.out
+++ b/tests/generic/686.out
@@ -31,19 +31,11 @@ Test 8 - root, all-exec file finsert
 6777 -rwsrwsrwx TEST_DIR/686/a
 6777 -rwsrwsrwx TEST_DIR/686/a
 
-Test 9 - qa_user, non-exec file finsert, only sgid
-2666 -rw-rwSrw- TEST_DIR/686/a
-2666 -rw-rwSrw- TEST_DIR/686/a
-
-Test 10 - qa_user, group-exec file finsert, only sgid
+Test 9 - qa_user, group-exec file finsert, only sgid
 2676 -rw-rwsrw- TEST_DIR/686/a
 676 -rw-rwxrw- TEST_DIR/686/a
 
-Test 11 - qa_user, user-exec file finsert, only sgid
-2766 -rwxrwSrw- TEST_DIR/686/a
-2766 -rwxrwSrw- TEST_DIR/686/a
-
-Test 12 - qa_user, all-exec file finsert, only sgid
+Test 10 - qa_user, all-exec file finsert, only sgid
 2777 -rwxrwsrwx TEST_DIR/686/a
 777 -rwxrwxrwx TEST_DIR/686/a
 
diff --git a/tests/generic/687 b/tests/generic/687
index ff3e2fe1..3a7f1fd5 100755
--- a/tests/generic/687
+++ b/tests/generic/687
@@ -110,26 +110,14 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a group-exec file by an unprivileged user clears sgid
-echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+echo "Test 9 - qa_user, group-exec file $verb, only sgid"
 setup_testfile
 chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
-setup_testfile
-chmod a+rw,u+x,g+rws $junk_file
-commit_and_check "$qa_user" "$verb" 64k 64k
-
 # Commit to a all-exec file by an unprivileged user clears sgid.
-echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+echo "Test 10 - qa_user, all-exec file $verb, only sgid"
 setup_testfile
 chmod a+rwx,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/687.out b/tests/generic/687.out
index c5116c27..f72f6d30 100644
--- a/tests/generic/687.out
+++ b/tests/generic/687.out
@@ -31,19 +31,11 @@ Test 8 - root, all-exec file fcollapse
 6777 -rwsrwsrwx TEST_DIR/687/a
 6777 -rwsrwsrwx TEST_DIR/687/a
 
-Test 9 - qa_user, non-exec file fcollapse, only sgid
-2666 -rw-rwSrw- TEST_DIR/687/a
-2666 -rw-rwSrw- TEST_DIR/687/a
-
-Test 10 - qa_user, group-exec file fcollapse, only sgid
+Test 9 - qa_user, group-exec file fcollapse, only sgid
 2676 -rw-rwsrw- TEST_DIR/687/a
 676 -rw-rwxrw- TEST_DIR/687/a
 
-Test 11 - qa_user, user-exec file fcollapse, only sgid
-2766 -rwxrwSrw- TEST_DIR/687/a
-2766 -rwxrwSrw- TEST_DIR/687/a
-
-Test 12 - qa_user, all-exec file fcollapse, only sgid
+Test 10 - qa_user, all-exec file fcollapse, only sgid
 2777 -rwxrwsrwx TEST_DIR/687/a
 777 -rwxrwxrwx TEST_DIR/687/a
 

---
base-commit: fbd489798b31e32f0eaefcd754326a06aa5b166f
change-id: 20230103-fstests-setgid-v6-2-4ce5852d11e2
