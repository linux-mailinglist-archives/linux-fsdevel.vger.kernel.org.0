Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65546DDB0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 14:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjDKMkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDKMkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:40:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B407792;
        Tue, 11 Apr 2023 05:40:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso9499557wmo.0;
        Tue, 11 Apr 2023 05:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681216842; x=1683808842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9eULK5T/AR038Lb9fVHHOrciM7+eUNTM+3elsNko2A=;
        b=Tez97/llUBH1dM+UV3pBlIHE2H+NAM6fQV3H8t8T8IpiupqD6bdewrJXYHVq8A8kvs
         5zMOJl6QeIpo55ji9KIkWkQhF26hwvs5CzXCid8GxPtotqdfWocpHQTP3P/535t+zspa
         j/GxA4/rjHlGB0ulK8vKTaABQiAJRmU8f+5ouy0MNVz38kHp52dXbDvy1Nys61d8X6kO
         EKqHDiW8MULSnZz0rWnxOb/OjoLmQ6vtk1Fl/KXbgRWY/J9v3WjYSaNdVIJ//GAo9tN6
         b+m6SXvfNnXAm1J73eZDfTbOGOglS8MtA4E5DnVZ2Ohuc3M+k/1pSSRiEptFhfT3JyzV
         bu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681216842; x=1683808842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9eULK5T/AR038Lb9fVHHOrciM7+eUNTM+3elsNko2A=;
        b=oUbApvxK8pPAObrJCrNEzlPLVhwdkwr2ljssLvWvqLdu3Op68e2uTJGM2yI4WDDmM8
         GjrOL3H63XuI4wQOgHVbx7gGuUi6oOyDB86ybi75us3h36hTQ/O5Y77eaMh1EujopZG7
         1juPVfp5DxC3czHA+snBriDfkR7vebqTxn1K7vKzn8+JR54NnA0gvyT835x7IazdsyW8
         axtitsBkw0CUhMM2NILM6rqIVAPK7YrtRs/X8caXmA7uJlWIJTjyjHlIp95aeRuKGBLC
         QDKLn1vp3pJrZAf8xA1ubjtlrpNL2LrdhgNaKEcJZAjrw3tLdxyU5sGMGQ+ZClopJ5uh
         Td0Q==
X-Gm-Message-State: AAQBX9efpfESuj509XcvsvXwahybuenREal9pYMKBav+hDnERz+lFthP
        cfyjhL8F80C2HM1HUqqiXi0=
X-Google-Smtp-Source: AKy350b9hMGRmjtzXRMYjnVO8SvNNk1dw8TBb/GLj/b+hulyWBosiUBD0Fuih2r9ZEwMrISewSplbA==
X-Received: by 2002:a7b:c4cd:0:b0:3ef:732e:2d5a with SMTP id g13-20020a7bc4cd000000b003ef732e2d5amr1941449wmk.34.1681216841799;
        Tue, 11 Apr 2023 05:40:41 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id b2-20020a05600c4e0200b003f04057bf1bsm20543769wmq.18.2023.04.11.05.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:40:41 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem types
Date:   Tue, 11 Apr 2023 15:40:37 +0300
Message-Id: <20230411124037.1629654-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If kernel supports FAN_REPORT_ANY_FID, use this flag to allow testing
also filesystems that do not support fsid or NFS file handles (e.g. fuse).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

I wanted to run an idea by you.

My motivation is to close functional gaps between fanotify and inotify.

One of the largest gaps right now is that FAN_REPORT_FID is limited
to a subset of local filesystems.

The idea is to report fid's that are "good enough" and that there
is no need to require that fid's can be used by open_by_handle_at()
because that is a non-requirement for most use cases, unpriv listener
in particular.

I chose a rather generic name for the flag to opt-in for "good enough"
fid's.  At first, I was going to make those fid's self describing the
fact that they are not NFS file handles, but in the name of simplicity
to the API, I decided that this is not needed.

The patch below is from the LTP test [1] that verifies reported fid's.
I am posting it because I think that the function fanotify_get_fid()
demonstrates well, how a would-be fanotify library could be used to get
a canonical fid.

That would-be routine can easily return the source of the fid values
for a given filesystem and that information is constant for all objects
on a given filesystem instance.

The choise to encode an actual file_handle of type FILEID_INO64 may
seem controversial at first, but it simplifies things so much, that I
grew very fond of it.

The LTP patch also demonstrated how terribly trivial it would be to
adapt any existing fanotify programs to support any fs.

Kernel patches [2] are pretty simple IMO and
man page patch [3] demonstrates that the API changes are minimal.

Thoughts?

Amir.

P.S.: Apropos closing gaps to inotify, I have WIP patches to add
      FAN_UNMOUNT and possibly FAN_IGNORED events.

[1] https://github.com/amir73il/ltp/commits/fan_report_any_fid
[2] https://github.com/amir73il/linux/commits/fan_report_any_fid
[3] https://github.com/amir73il/man-pages/commits/fan_report_any_fid

 include/lapi/fanotify.h                       |  3 ++
 testcases/kernel/syscalls/fanotify/fanotify.h | 32 +++++++++++++++----
 .../kernel/syscalls/fanotify/fanotify13.c     | 16 +++++++---
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/include/lapi/fanotify.h b/include/lapi/fanotify.h
index 4bd1a113c..511b35bbd 100644
--- a/include/lapi/fanotify.h
+++ b/include/lapi/fanotify.h
@@ -32,6 +32,9 @@
 #define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
 				     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
 #endif
+#ifndef FAN_REPORT_ANY_FID
+#define FAN_REPORT_ANY_FID	0x00002000
+#endif
 
 /* Non-uapi convenience macros */
 #ifndef FAN_REPORT_DFID_NAME_FID
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 51078103e..b02295138 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -72,6 +72,10 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #define MAX_HANDLE_SZ		128
 #endif
 
+#ifndef FILEID_INO64
+#define FILEID_INO64		0x80
+#endif
+
 /*
  * Helper function used to obtain fsid and file_handle for a given path.
  * Used by test files correlated to FAN_REPORT_FID functionality.
@@ -80,21 +84,37 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 				    struct file_handle *handle)
 {
 	int mount_id;
+	struct statx stx;
 	struct statfs stats;
 
+	if (statx(AT_FDCWD, path, 0, 0, &stx) == -1)
+		tst_brk(TBROK | TERRNO,
+			"statx(%s, ...) failed", path);
 	if (statfs(path, &stats) == -1)
 		tst_brk(TBROK | TERRNO,
 			"statfs(%s, ...) failed", path);
 	memcpy(fsid, &stats.f_fsid, sizeof(stats.f_fsid));
 
+	if (!fsid->val[0] && !fsid->val[1]) {
+		/* Fallback to fsid encoded from stx_dev */
+		fsid->val[0] = stx.stx_dev_major;
+		fsid->val[1] = stx.stx_dev_minor;
+	}
+
 	if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id, 0) == -1) {
-		if (errno == EOPNOTSUPP) {
-			tst_brk(TCONF,
-				"filesystem %s does not support file handles",
-				tst_device->fs_type);
+		if (errno != EOPNOTSUPP) {
+			tst_brk(TBROK | TERRNO,
+				"name_to_handle_at(AT_FDCWD, %s, ...) failed", path);
 		}
-		tst_brk(TBROK | TERRNO,
-			"name_to_handle_at(AT_FDCWD, %s, ...) failed", path);
+
+		tst_res(TINFO,
+			"filesystem %s does not support file handles - using ino as fid",
+			tst_device->fs_type);
+
+		/* Fallback to fid encoded from stx_ino */
+		handle->handle_type = FILEID_INO64;
+		handle->handle_bytes = sizeof(stx.stx_ino);
+		memcpy(handle->f_handle, (void *)&stx.stx_ino, sizeof(stx.stx_ino));
 	}
 }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index c3daaf3a2..e50ad0f75 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -90,6 +90,7 @@ static struct test_case_t {
 
 static int nofid_fd;
 static int fanotify_fd;
+static int fanotify_init_flags;
 static int filesystem_mark_unsupported;
 static char events_buf[BUF_SIZE];
 static struct event_t event_set[EVENT_MAX];
@@ -143,15 +144,16 @@ static void do_test(unsigned int number)
 	struct fanotify_mark_type *mark = &tc->mark;
 
 	tst_res(TINFO,
-		"Test #%d: FAN_REPORT_FID with mark flag: %s",
-		number, mark->name);
+		"Test #%d: %s with mark flag: %s", number,
+		(fanotify_init_flags & FAN_REPORT_ANY_FID) ?
+			"FAN_REPORT_ANY_FID" : "FAN_REPORT_FID", mark->name);
 
 	if (filesystem_mark_unsupported && mark->flag & FAN_MARK_FILESYSTEM) {
 		tst_res(TCONF, "FAN_MARK_FILESYSTEM not supported in kernel?");
 		return;
 	}
 
-	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
+	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | fanotify_init_flags, O_RDONLY);
 
 	/*
 	 * Place marks on a set of objects and setup the expected masks
@@ -261,7 +263,13 @@ out:
 
 static void do_setup(void)
 {
-	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, MOUNT_PATH);
+	/* Try FAN_REPORT_ANY_FID */
+	fanotify_init_flags = FAN_REPORT_FID | FAN_REPORT_ANY_FID;
+	if (fanotify_init_flags_supported_on_fs(fanotify_init_flags, MOUNT_PATH)) {
+		/* Fallback to FAN_REPORT_FID */
+		fanotify_init_flags = FAN_REPORT_FID;
+		REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(fanotify_init_flags, MOUNT_PATH);
+	}
 
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
 
-- 
2.34.1

