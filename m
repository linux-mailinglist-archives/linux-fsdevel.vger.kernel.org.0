Return-Path: <linux-fsdevel+bounces-46075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87165A82403
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136071B65841
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907A25E478;
	Wed,  9 Apr 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls7oo23j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5E25DAE4;
	Wed,  9 Apr 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199551; cv=none; b=OfUb/Ru0k9/PaKe6g3MM3DVylGEoLkklPbDZF1cTog67LssEDjp8IFLkYOxEYmAebpTNYmouYFNSeds+Zk1Qj+88ou4oPSLMPQrkEyHwlZQtXyrzTYnDxlmYStuZFTgvyLJuYTg0+CxaBP8Md5tmFCO+Nmq6xdTbKUFOcC6C60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199551; c=relaxed/simple;
	bh=dOeazHLABsCF2y5mX8YLtqKavySHNwonGyUet03Aaps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjeBpxZp8I27V8aYlSrbh6hi4b9Dt3yUfBk1X88KAI25ScKbtT8PefQ945fC5hKNMNpuaghjEwuXoMppUUZ+B25s13sLBt1rHVOjN9rUuPfjjTKq+cEKaf3gGnfKOV6v4R7AfBgtpG8Uj8ywDk5vUWae/XKwpXPexyti1c+Jf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls7oo23j; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-391342fc0b5so5209343f8f.3;
        Wed, 09 Apr 2025 04:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744199548; x=1744804348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gbnwx3UQ8HMr0aspq5T3L1ICouM+ZmHRZ1BZccKJ6NY=;
        b=ls7oo23jWY5pDaFWQ8isBFliClMKFZRyjW6OQo3g1Xfk5Ze2+6I2ciDZVQQibb2e4S
         NCQTJ4+GpqWipmCwgKZJ6f/ZRB09boeUfcpN2IEFv0+CJ2rYDwpTuWaAxvwYXR/VIc5v
         nSJLry/gjuR+VF4ZUU23Bn3oRbEYYqrCHFDSxXJx95OOFhK8Iqe6knkgHIdFmhKDB1gZ
         x4jwjp3g0QNE/7hgtPHO2PyrNLVXtFi/x/KQUMl/pU50h88WEw6Jc35YV2I6ZniWaOFP
         /9N6l2sTpRdEWPjF1zh1Sm0w2KJcx7pxC9jeDIEHywYTbjHBTqsQeddaZc2cWhCy58nF
         0omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744199548; x=1744804348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gbnwx3UQ8HMr0aspq5T3L1ICouM+ZmHRZ1BZccKJ6NY=;
        b=jDpFTlqEvVaj3iUdC0BZje7LRVMNm1wgFiPsNcHUgRSUABRySc+OaJ3mqNa8qM3YF4
         tNeC1b91dpYOAro9zEZqDUqO1MANDC3iv3ZqoyltV5Y0hkxNnyqAjqoNMf1rzmm5fE7f
         VF73KqM9Oz1yOio/D2C7aY+1B1zB5TYoPViXBoUi0QVcoNTP5PovEE4vbzaSqfGsZUqS
         mNAkISWowjPnopZENxyXCns69gH82mZiC55AgQSwvKuWgXyyXNmJt9CFMXUNIsFEb4WJ
         VAjDbhqzHRkZQk+i1h9y1qmRLvOmknTTfH30x1Kg+QPzcjim4ywIZMi8s3iQWqCrAMgg
         RV9w==
X-Forwarded-Encrypted: i=1; AJvYcCVaWiDkVKgZ01og8or1YZY/gpW+CmdaiyfSGZZHiLUHTRvfsPGZchoziguVokkegZwtUz9wkABM@vger.kernel.org, AJvYcCW0937P6vx/AN5X4bIyhOhOU9mNwbDQx0uVm8J+BHVtE2IbxHVj4I+PeYdOqfrv4Fy1nBaLH9H8aK9IwU2rPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr39UBsq7CJhQLv14fWbWQe0sMK2Xiw1+M+MrzgfQZ0ms1S2WB
	etGbNq6HPZRTKoJiWhLTrupLR+RwGmYgGKmRe8DDDqAI5/3pXoxy
X-Gm-Gg: ASbGncvP3j+cJgjxc2O+Abmvb34KuLD4dR/bP4pANBseFHS7v+55hFDTxCgqptoj9ru
	R6gis4gtE47gyuWM2SfUTqFbu2T8BQw5u+6t361b5HSMcu8+j2tilwVeVTMSidb4jvbhXUcW05i
	SH8OG3rlrXEfR1YRJD4Eog1v68AEVoIZHxAGUmC1sC+47lw1z4j8mxlgvOJhPivTWR2XCMVVWmF
	U4PjWjVgR9sRwuZrAyF/xwHxrbkl+Dd/cfoZPHjzE/2wdwQVCXrtjGN42rQccu7MPY+1HIy0YFQ
	KUCRNrMg1ZXGolctMZzeUee0PYgTOdSIKPcbJDl/qdnaK2lejfcljvrOTJZdMhMss98pJOUmknK
	GVq1fYjXihomyf4zKrZM+xmpy1ZSQEfB6OL6/rQ==
X-Google-Smtp-Source: AGHT+IHlj8ykBwsaHbvQg8yy+TAy/VpDboqoHLrOBoozcZmz+hLx7mZC4Bk4uNM53ZExlwRxv3eH8A==
X-Received: by 2002:a05:6000:4308:b0:38d:d666:5457 with SMTP id ffacd0b85a97d-39d88561926mr1909654f8f.42.1744199547544;
        Wed, 09 Apr 2025 04:52:27 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d069sm17786815e9.17.2025.04.09.04.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 04:52:27 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] open_by_handle: add support for testing connectable file handles
Date: Wed,  9 Apr 2025 13:52:19 +0200
Message-Id: <20250409115220.1911467-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409115220.1911467-1-amir73il@gmail.com>
References: <20250409115220.1911467-1-amir73il@gmail.com>
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

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc            | 16 +++++++++++++---
 src/open_by_handle.c | 44 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 12 deletions(-)

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
index a99cce4b..d281343a 100644
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
-- 
2.34.1


