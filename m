Return-Path: <linux-fsdevel+bounces-48646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF80EAB1B22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFB5188A5E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1469238C03;
	Fri,  9 May 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ6kQRZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB42FB2;
	Fri,  9 May 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810041; cv=none; b=htT6UWhQCxnPIL+vVTqjB2RMFg/cX/a5jN27g4TDyoHii/CZOtAtWvsJ7CzP7rRxYnuAeKkyvG2OmFucXwbM3Q5GGFi507k533S+IquI+0/6Xm5AnROxj5taov3fy/szR+E6UR9zqK3KrZAZ3yF0h8VnwffIngoseiZXH9brqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810041; c=relaxed/simple;
	bh=v8aT0esMtON2igM9clzd+Iz9eVGJJsfy0v6RpB4K4Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijzjl6QtCz7jxpxIdReJybDmmEBcUnoVDdOkOColEkBJaBZv8BL6AY1TmK1+LyTjDqgWYQmLOGg6Pg7wLTf87FhUVI3IsjAQkBiPfMFVmglUXEN+hKQS5uwDwL8tnJsUMDTaqRchQq7NcE6JU8VVjrH8NsAtZZRMZF00gabe4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ6kQRZ7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0b9c371d8so1871073f8f.0;
        Fri, 09 May 2025 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810037; x=1747414837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3y/ArPgmdR6dErepYvrr+YxReqTE9cfVVTjKHMMQQo=;
        b=eQ6kQRZ7mluTiY7GxPLoU3J7jhhCKrM5zot7hgoqbul8JiKUbVoSQcf5vdt7/byc3M
         HPpfejDelf3bdv132Yobkxl26fz7PHr+C+ALjBZ5n2AJChFO9lLeoqudgNhqYnzJC85H
         8Jk3KSVNhxt20YIm/qAW56oI1YaH2onK+sDZMEQ/IPRzE9OF9R1cpzl6EhXJhYl0uqPu
         aBur36PnGdQva8m3Iyx9WK9ozOXoaD0DR4fNQG9ACu8esY6p0DtXsb5PbTLMjcV2s4F9
         y/s+4nA+9tEOB/amjYQ1d/g2lXKFCTw9I+tKKnynBs+V/nqOTx+4wrJc+tKLiTFz8IaK
         Xfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810037; x=1747414837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3y/ArPgmdR6dErepYvrr+YxReqTE9cfVVTjKHMMQQo=;
        b=e6dLQo6JD3vLFneZt3d/ybenSD6+PXK228JC4p70WTXOd091q7h5hOVUnSJ+VR9ZU9
         Gn/QJf0Y3obOZnQnOqf1Vpw3f207jahcE+oTnddUGAAh7tchIATcKNaKrvxYe+CtgCWg
         Q/qoKF6syvvDAFXPf/xhkzKDHzTkZ4jYAKq4vAj/e+XNeqTr4X9J7A/NxEuIOsMRsyvp
         E6lyZZHQ0VhxDffOnylus6yoyVKSIH+wwe3at9LcAyf5iVtpZsch986OLHj1NRCecwPx
         wOqaeETZ1/dtVm5ebCG+OyhBeiElkOkP+rijvbM5thsJH99bF8J3aNWRetERJnDt4Ta9
         /7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkU64JykVIYO1mltDdeLbj12qAYrmsj9bfFjDxqNslLrPZO8BEenR6KXetZUxpPcLvJvRmbUFsqLZAKt6XYQ==@vger.kernel.org, AJvYcCWZmalmwYjD9O/ZvKcOZwEmw4oac8cHjzOOSG8y9wmLk9xxez9Zk1Q8UGSnGufcV9wZZz94ZIkB@vger.kernel.org
X-Gm-Message-State: AOJu0YxOozkd0zz/T6GVkSA7sN2HF9bRWHVYjE9F29gCGmO134iN4/Jc
	almWOZubMQ8+i+cznDR/QXEmCLrejG1XoxIioB+zEWJOUSU851kA8gDLyEGKi0c=
X-Gm-Gg: ASbGncscab5fr+tHbT60dTuChWYAjHVEsqPhIQ2JC9xmtMlmYvITJDQYrKxexFd90LQ
	n6O34jbkUc7KTcMiELwuqiBv+AeqVdz8KTfWtsM7G5hcTY1g0NraXWqrPmItYsCly6kdo1OXgYD
	DUTLnDE1gO7K5acu9Drck/JxP4QzEZke5QmYpDgj30RVGm6lvbEDD9bo7Fsr+Sneh8VPG1y/Qzr
	8fst6huJmL97kGk97XJO3UXTHfq091nVLMlIpZsJjslX6KyEcfC2jqkutHCIEHFgo9UvvTntxm4
	Wb15wv139+7hxIMBJag/4EvJT6VVN8VvykNISraKF2uoH5VxgDI0qU+KBiKr+rSgqWdsAk7vM2v
	BkrXmTBm19qAfTkhpkjGeLDTvXCiaysCokTxjEw==
X-Google-Smtp-Source: AGHT+IEur+KXoyNIYgd5WUu8CxRX/pyAthifZXZZHQlyN6Y17E5x7xBgVXwIrS7w0E+a0XPZarBC7w==
X-Received: by 2002:a05:6000:220d:b0:3a0:b76a:2451 with SMTP id ffacd0b85a97d-3a1f64c0b10mr3230129f8f.50.1746810036957;
        Fri, 09 May 2025 10:00:36 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7d2bsm78469245e9.36.2025.05.09.10.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:00:36 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] open_by_handle: add support for testing connectable file handles
Date: Fri,  9 May 2025 19:00:32 +0200
Message-Id: <20250509170033.538130-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509170033.538130-1-amir73il@gmail.com>
References: <20250509170033.538130-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test for kernel and filesystem support for conenctable file handles.

With -N flag, encode connectable file handles and fail the test if the
kernel or filesystem do not support conenctable file handles.

Verify that decoding connectable file handles always results in a non
empty path of the fd.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc            | 16 ++++++++++---
 src/open_by_handle.c | 53 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/common/rc b/common/rc
index 6592c835..6407b744 100644
--- a/common/rc
+++ b/common/rc
@@ -3829,8 +3829,14 @@ _require_freeze()
 }
 
 # Does NFS export work on this fs?
-_require_exportfs()
+_require_open_by_handle()
 {
+	local what="NFS export"
+	local opts="$1"
+	if [ "$1" == "-N" ]; then
+		what="connectable file handles"
+	fi
+
 	_require_test_program "open_by_handle"
 
 	# virtiofs doesn't support open_by_handle_at(2) yet, though the syscall
@@ -3841,10 +3847,14 @@ _require_exportfs()
 		_notrun "$FSTYP doesn't support open_by_handle_at(2)"
 
 	mkdir -p "$TEST_DIR"/exportfs_test
-	$here/src/open_by_handle -c "$TEST_DIR"/exportfs_test 2>&1 \
-		|| _notrun "$FSTYP does not support NFS export"
+	$here/src/open_by_handle $opts -c "$TEST_DIR"/exportfs_test 2>&1 \
+		|| _notrun "$FSTYP does not support $what"
 }
 
+_require_exportfs()
+{
+	_require_open_by_handle
+}
 
 # Does shutdown work on this fs?
 _require_scratch_shutdown()
diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index a99cce4b..7b664201 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -96,6 +96,9 @@ Examples:
 #ifndef AT_HANDLE_MNT_ID_UNIQUE
 #	define AT_HANDLE_MNT_ID_UNIQUE 0x001
 #endif
+#ifndef AT_HANDLE_CONNECTABLE
+#	define AT_HANDLE_CONNECTABLE   0x002
+#endif
 
 #define MAXFILES 1024
 
@@ -121,6 +124,7 @@ void usage(void)
 	fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test files and hardlinks, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test files, drop caches and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -M <test_dir> [N] - do not silently skip the mount ID verifications\n");
+	fprintf(stderr, "open_by_handle -N <test_dir> [N] - encode connectable file handles\n");
 	fprintf(stderr, "open_by_handle -p <test_dir>     - create/delete and try to open by handle also test_dir itself\n");
 	fprintf(stderr, "open_by_handle -i <handles_file> <test_dir> [N] - read test files handles from file and try to open by handle\n");
 	fprintf(stderr, "open_by_handle -o <handles_file> <test_dir> [N] - get file handles of test files and write handles to file\n");
@@ -130,14 +134,16 @@ void usage(void)
 	fprintf(stderr, "open_by_handle -C <feature>      - check if <feature> is supported by the kernel.\n");
 	fprintf(stderr, "  <feature> can be any of the following values:\n");
 	fprintf(stderr, "  - AT_HANDLE_MNT_ID_UNIQUE\n");
+	fprintf(stderr, "  - AT_HANDLE_CONNECTABLE\n");
 	exit(EXIT_FAILURE);
 }
 
-static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
-				int bufsz, bool force_check_mountid)
+static int do_name_to_handle_at(const char *fname, struct file_handle *fh, int bufsz,
+				bool force_check_mountid, bool connectable)
 {
 	int ret;
 	int mntid_short;
+	int at_flags;
 
 	static bool skip_mntid, skip_mntid_unique;
 
@@ -181,18 +187,24 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
 		}
 	}
 
+	at_flags = connectable ? AT_HANDLE_CONNECTABLE : 0;
 	fh->handle_bytes = bufsz;
-	ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
+	ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, at_flags);
 	if (bufsz < fh->handle_bytes) {
 		/* Query the filesystem required bufsz and the file handle */
 		if (ret != -1 || errno != EOVERFLOW) {
 			fprintf(stderr, "%s: unexpected result from name_to_handle_at: %d (%m)\n", fname, ret);
 			return EXIT_FAILURE;
 		}
-		ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
+		ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, at_flags);
 	}
 	if (ret < 0) {
-		fprintf(stderr, "%s: name_to_handle: %m\n", fname);
+		/* No filesystem support for encoding connectable file handles (e.g. overlayfs)? */
+		if (connectable)
+			fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_CONNECTABLE) not supported by %s\n",
+					fname, errno == EINVAL ? "kernel" : "filesystem");
+		else
+			fprintf(stderr, "%s: name_to_handle: %m\n", fname);
 		return EXIT_FAILURE;
 	}
 
@@ -245,8 +257,17 @@ static int check_feature(const char *feature)
 			return EXIT_FAILURE;
 		}
 		return 0;
+	} else if (!strcmp(feature, "AT_HANDLE_CONNECTABLE")) {
+		int ret = name_to_handle_at(AT_FDCWD, ".", NULL, NULL, AT_HANDLE_CONNECTABLE);
+		/* If AT_HANDLE_CONNECTABLE is supported, we get EFAULT. */
+		if (ret < 0 && errno == EINVAL) {
+			fprintf(stderr, "name_to_handle_at(AT_HANDLE_CONNECTABLE) not supported by running kernel\n");
+			return EXIT_FAILURE;
+		}
+		return 0;
 	}
 
+
 	fprintf(stderr, "unknown feature name '%s'\n", feature);
 	return EXIT_FAILURE;
 }
@@ -270,13 +291,13 @@ int main(int argc, char **argv)
 	int	create = 0, delete = 0, nlink = 1, move = 0;
 	int	rd = 0, wr = 0, wrafter = 0, parent = 0;
 	int	keepopen = 0, drop_caches = 1, sleep_loop = 0;
-	int	force_check_mountid = 0;
+	bool	force_check_mountid = 0, connectable = 0;
 	int	bufsz = MAX_HANDLE_SZ;
 
 	if (argc < 2)
 		usage();
 
-	while ((c = getopt(argc, argv, "cC:ludmMrwapknhi:o:sz")) != -1) {
+	while ((c = getopt(argc, argv, "cC:ludmMNrwapknhi:o:sz")) != -1) {
 		switch (c) {
 		case 'c':
 			create = 1;
@@ -313,6 +334,9 @@ int main(int argc, char **argv)
 		case 'M':
 			force_check_mountid = 1;
 			break;
+		case 'N':
+			connectable = 1;
+			break;
 		case 'p':
 			parent = 1;
 			break;
@@ -445,7 +469,8 @@ int main(int argc, char **argv)
 				return EXIT_FAILURE;
 			}
 		} else {
-			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz, force_check_mountid);
+			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz,
+						   force_check_mountid, connectable);
 			if (ret)
 				return EXIT_FAILURE;
 		}
@@ -475,7 +500,8 @@ int main(int argc, char **argv)
 				return EXIT_FAILURE;
 			}
 		} else {
-			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz, force_check_mountid);
+			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz,
+						   force_check_mountid, connectable);
 			if (ret)
 				return EXIT_FAILURE;
 		}
@@ -589,6 +615,15 @@ int main(int argc, char **argv)
 		errno = 0;
 		fd = open_by_handle_at(mount_fd, &handle[i].fh, wrafter ? O_RDWR : O_RDONLY);
 		if ((nlink || keepopen) && fd >= 0) {
+			char linkname[PATH_MAX];
+			char procname[64];
+			sprintf(procname, "/proc/self/fd/%i", fd);
+			int n = readlink(procname, linkname, PATH_MAX);
+
+			/* check that fd is "connected" - that is has a non empty path */
+			if (connectable && n <= 1) {
+				printf("open_by_handle(%s) returned a disconnected fd!\n", fname);
+			}
 			if (rd) {
 				char buf[4] = {0};
 				int size = read(fd, buf, 4);
-- 
2.34.1


