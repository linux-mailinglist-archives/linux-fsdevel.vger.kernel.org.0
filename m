Return-Path: <linux-fsdevel+bounces-12132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3985B757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F84E1C2427B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CE65FDD3;
	Tue, 20 Feb 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhlLTzP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0825FDC9
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421257; cv=none; b=MqjWuA04OwieE7svelnKt8M+B6htJAb+2Cft890+IccL4VZkVIjycSA83lr8KH0h4WQKYyJnjGTi7X6/1b2/R7OiDKz42x615nwHa1JJsF51FOrqiHnBvtGZlxzLjKePSzfLeRZg790rdQe0y1Yr78UIbo+ONqJ0wP2/ouZGJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421257; c=relaxed/simple;
	bh=MNS3Wenvd3CPGUa+1nbec3ZhkxNw0IUv2scXSvBHWGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD4oN2LBF9JsE6zqzPe6FHba1Eeg2QJZU/rPzBUtoTCxwmw2OzH1po6rF3PtdYfnYzUrUseGJzoDHDbYKhPjMlulUjCtvQKnM4j8docbdyQLKnJbev6llcBI5iEUvCAqfzofovUO/co4cH+jGcEPUarwvgqQQDiXRB1EefxMWM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhlLTzP2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e87b2de41so183743066b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421254; x=1709026054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUIZj7JHZQQzmuJwxcBCYLLycwgoQrzQW0HfSgl0F2M=;
        b=PhlLTzP2F6cx9IyZsRJ+dug7XWbpM2pDUeHK321i44qpUVqxep8ALb3u17wLemUtek
         c3a+OObF2cfZ6BywWuyAJcNxTdHMOnvpuVsjuwHE4mxzsqD5wVglKejHFkOYFxdiMx9S
         duNW/uHYdoDp58xrBsnAAHlFXkbfTfICmlWkL5UeU72bwNiuWNaed7NA+tNe5M8g94Fm
         dcOe1PIWAlTZXs++afMaidfSZLImu13D1UDEBb8Zd9ceQXZBM4Uflc4X0/RM+lv0NtaF
         2wSjfN70Xk4daFHsv9agSHFED7r0szhMPEjheET+DFa1lqegbf5XlafDQyLtmfc6JzkY
         BilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421254; x=1709026054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUIZj7JHZQQzmuJwxcBCYLLycwgoQrzQW0HfSgl0F2M=;
        b=bhnUG8KXhIZangTqXGsoSqVO6aX8G++Lr6FogTf+ug6oS2WJVRC8A8k8/+5mcH6pJp
         iQSQukvXmKFqmgFU813wCV/S/pfanaV1mEsPS/4J8A3tZvHnylDxiddM9bPVtObxrEEh
         ZhoCL1Wr76E9wyuyTIVpa5iEhwwyG8LQagoO8VrjSpgyHWnSZas2DS0CkiFDeQ+XT0UK
         fM+Ri7I/N3zeaNmfBaxAhUYCCIIpjpH4V9gDNxaLZA80i3+wEfV7W+yUQgDisWX8CCmy
         rt9a2HHqbjat/p/Tk1FSA78d/aC6rYAFd2wvoYJGb7sbONv5tVo3JvlptaE1a9CbHOUF
         6v7g==
X-Forwarded-Encrypted: i=1; AJvYcCX2mC252TjV1VhhLZ5lFM4H+TlRfrUkKQp7pBw+3KjnlEJ4of7qNjfdr1LUnn/6/Uyp6jYbIP9kTyCMfnaJwCUW51AVfshoGD1aKFpg6w==
X-Gm-Message-State: AOJu0Yy2nQBif2KDf3BHQFo/iFHu7sTT3dY59S1FBWbYiMfCrkWHV1u4
	3v/2IMYCjBsY1VI9dGzRMYKtWRRhtpM4m3yMpwkDMbxzaG3h9NjqLMOAdQJw3w==
X-Google-Smtp-Source: AGHT+IFdqEPrvw/m+2sSbOg1414dzXcYlw64hSpUftYqChu8q15/lbYfZWLZr3xxHjkOIFkPX+CszQ==
X-Received: by 2002:a17:906:3d41:b0:a3d:b7e1:2670 with SMTP id q1-20020a1709063d4100b00a3db7e12670mr8275844ejf.14.1708421254341;
        Tue, 20 Feb 2024 01:27:34 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709060d5200b00a3d12d84cffsm3752352ejh.167.2024.02.20.01.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:33 -0800 (PST)
Date: Tue, 20 Feb 2024 09:27:30 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 02/11] bpf/selftests: adjust selftests for BPF
 helper bpf_d_path()
Message-ID: <18c7b587d43bbc7e80593bf51ea9d3eb99e47bc1.1708377880.git.mattbobrowski@google.com>
References: <cover.1708377880.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708377880.git.mattbobrowski@google.com>

The BPF helper bpf_d_path() has been modified such that it makes use
of probe-read semantics. In turn, the behaviour of the BPF helper
bpf_d_path() has slightly changed under certain circumstances,
therefore needing to also adjust the backing test suite to account for
this.

The probe-read based d_path() implementation cannot handle dentries
that have their name backed by d_op->d_dname(). For paths containing
such dentries, the probe-read based implementation returns
-EOPNOTSUPP, so the test suite has been updated to assert this
behaviour.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../testing/selftests/bpf/prog_tests/d_path.c | 84 +++++++++++++++----
 .../testing/selftests/bpf/progs/test_d_path.c |  2 +-
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index ccc768592e66..d77ae1b1e6ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -6,7 +6,7 @@
 #include <sys/syscall.h>
 
 #define MAX_PATH_LEN		128
-#define MAX_FILES		7
+#define MAX_FILES		8
 
 #include "test_d_path.skel.h"
 #include "test_d_path_check_rdonly_mem.skel.h"
@@ -25,9 +25,15 @@
 
 static int duration;
 
+struct want {
+	bool err;
+	long err_code;
+	char path[MAX_PATH_LEN];
+};
+
 static struct {
 	__u32 cnt;
-	char paths[MAX_FILES][MAX_PATH_LEN];
+	struct want want[MAX_FILES];
 } src;
 
 static int set_pathname(int fd, pid_t pid)
@@ -35,12 +41,12 @@ static int set_pathname(int fd, pid_t pid)
 	char buf[MAX_PATH_LEN];
 
 	snprintf(buf, MAX_PATH_LEN, "/proc/%d/fd/%d", pid, fd);
-	return readlink(buf, src.paths[src.cnt++], MAX_PATH_LEN);
+	return readlink(buf, src.want[src.cnt++].path, MAX_PATH_LEN);
 }
 
 static int trigger_fstat_events(pid_t pid)
 {
-	int sockfd = -1, procfd = -1, devfd = -1;
+	int sockfd = -1, procfd = -1, devfd = -1, mntnsfd = -1;
 	int localfd = -1, indicatorfd = -1;
 	int pipefd[2] = { -1, -1 };
 	struct stat fileStat;
@@ -49,10 +55,15 @@ static int trigger_fstat_events(pid_t pid)
 	/* unmountable pseudo-filesystems */
 	if (CHECK(pipe(pipefd) < 0, "trigger", "pipe failed\n"))
 		return ret;
-	/* unmountable pseudo-filesystems */
+
 	sockfd = socket(AF_INET, SOCK_STREAM, 0);
 	if (CHECK(sockfd < 0, "trigger", "socket failed\n"))
 		goto out_close;
+
+	mntnsfd = open("/proc/self/ns/mnt", O_RDONLY);
+	if (CHECK(mntnsfd < 0, "trigger", "mntnsfd failed"))
+		goto out_close;
+
 	/* mountable pseudo-filesystems */
 	procfd = open("/proc/self/comm", O_RDONLY);
 	if (CHECK(procfd < 0, "trigger", "open /proc/self/comm failed\n"))
@@ -69,15 +80,35 @@ static int trigger_fstat_events(pid_t pid)
 	if (CHECK(indicatorfd < 0, "trigger", "open /tmp/ failed\n"))
 		goto out_close;
 
+	/*
+	 * With bpf_d_path() being backed by probe-read semantics, we cannot
+	 * safely resolve paths that are comprised of dentries that make use of
+	 * dynamic names. We expect to return -EOPNOTSUPP for such paths.
+	 */
+	src.want[src.cnt].err = true;
+	src.want[src.cnt].err_code = -EOPNOTSUPP;
 	ret = set_pathname(pipefd[0], pid);
 	if (CHECK(ret < 0, "trigger", "set_pathname failed for pipe[0]\n"))
 		goto out_close;
+
+	src.want[src.cnt].err = true;
+	src.want[src.cnt].err_code = -EOPNOTSUPP;
 	ret = set_pathname(pipefd[1], pid);
 	if (CHECK(ret < 0, "trigger", "set_pathname failed for pipe[1]\n"))
 		goto out_close;
+
+	src.want[src.cnt].err = true;
+	src.want[src.cnt].err_code = -EOPNOTSUPP;
 	ret = set_pathname(sockfd, pid);
 	if (CHECK(ret < 0, "trigger", "set_pathname failed for socket\n"))
 		goto out_close;
+
+	src.want[src.cnt].err = true;
+	src.want[src.cnt].err_code = -EOPNOTSUPP;
+	ret = set_pathname(mntnsfd, pid);
+	if (CHECK(ret < 0, "trigger", "set_pathname failed for mntnsfd\n"))
+		goto out_close;
+
 	ret = set_pathname(procfd, pid);
 	if (CHECK(ret < 0, "trigger", "set_pathname failed for proc\n"))
 		goto out_close;
@@ -95,6 +126,7 @@ static int trigger_fstat_events(pid_t pid)
 	fstat(pipefd[0], &fileStat);
 	fstat(pipefd[1], &fileStat);
 	fstat(sockfd, &fileStat);
+	fstat(mntnsfd, &fileStat);
 	fstat(procfd, &fileStat);
 	fstat(devfd, &fileStat);
 	fstat(localfd, &fileStat);
@@ -109,6 +141,7 @@ static int trigger_fstat_events(pid_t pid)
 	close(pipefd[0]);
 	close(pipefd[1]);
 	close(sockfd);
+	close(mntnsfd);
 	close(procfd);
 	close(devfd);
 	close(localfd);
@@ -150,24 +183,41 @@ static void test_d_path_basic(void)
 		goto cleanup;
 
 	for (int i = 0; i < MAX_FILES; i++) {
-		CHECK(strncmp(src.paths[i], bss->paths_stat[i], MAX_PATH_LEN),
-		      "check",
-		      "failed to get stat path[%d]: %s vs %s\n",
-		      i, src.paths[i], bss->paths_stat[i]);
-		CHECK(strncmp(src.paths[i], bss->paths_close[i], MAX_PATH_LEN),
-		      "check",
-		      "failed to get close path[%d]: %s vs %s\n",
-		      i, src.paths[i], bss->paths_close[i]);
+		struct want want = src.want[i];
+
+		/*
+		 * Assert that we get the correct error code from bpf_d_path()
+		 * when the underlying path contains a dentry that is backed by
+		 * a dynamic name.
+		 */
+		if (want.err) {
+			CHECK(want.err_code != bss->rets_stat[i], "check",
+			      "failed to match stat return[%d]: got=%d, want=%ld [%s]\n",
+			      i, bss->rets_stat[i], want.err_code,
+			      bss->paths_stat[i]);
+			CHECK(want.err_code != bss->rets_close[i], "check",
+			      "failed to match close return[%d]: got=%d, want=%ld [%s]\n",
+			      i, bss->rets_close[i], want.err_code,
+			      bss->paths_close[i]);
+			continue;
+		}
+
+		CHECK(strncmp(want.path, bss->paths_stat[i], MAX_PATH_LEN),
+		      "check", "failed to get stat path[%d]: %s vs %s\n", i,
+		      want.path, bss->paths_stat[i]);
+		CHECK(strncmp(want.path, bss->paths_close[i], MAX_PATH_LEN),
+		      "check", "failed to get close path[%d]: %s vs %s\n", i,
+		      want.path, bss->paths_close[i]);
 		/* The d_path helper returns size plus NUL char, hence + 1 */
 		CHECK(bss->rets_stat[i] != strlen(bss->paths_stat[i]) + 1,
 		      "check",
-		      "failed to match stat return [%d]: %d vs %zd [%s]\n",
-		      i, bss->rets_stat[i], strlen(bss->paths_stat[i]) + 1,
+		      "failed to match stat return [%d]: %d vs %zd [%s]\n", i,
+		      bss->rets_stat[i], strlen(bss->paths_stat[i]) + 1,
 		      bss->paths_stat[i]);
 		CHECK(bss->rets_close[i] != strlen(bss->paths_stat[i]) + 1,
 		      "check",
-		      "failed to match stat return [%d]: %d vs %zd [%s]\n",
-		      i, bss->rets_close[i], strlen(bss->paths_close[i]) + 1,
+		      "failed to match stat return [%d]: %d vs %zd [%s]\n", i,
+		      bss->rets_close[i], strlen(bss->paths_close[i]) + 1,
 		      bss->paths_stat[i]);
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..fc2754f166ec 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -5,7 +5,7 @@
 #include <bpf/bpf_tracing.h>
 
 #define MAX_PATH_LEN		128
-#define MAX_FILES		7
+#define MAX_FILES		8
 
 pid_t my_pid = 0;
 __u32 cnt_stat = 0;
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

