Return-Path: <linux-fsdevel+bounces-22272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CC7915754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 21:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA149281450
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A171A08A4;
	Mon, 24 Jun 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BVcPo0a7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F91A072D
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258073; cv=none; b=at3/NqxWI8+W15RGM3ay1SAjWtTP22exfGchGmHwbcc5Wxet44yVUKNfNa8pVDISACS51pB8KT9zHFhlFgrlqubjJsh8krv50vnWmDccUNKW8QubV6e/Fr6tEMgu4glPgmuEy6eKFzZ9hMx+k8ehjlXqfpWBRdwayaBzTWW44B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258073; c=relaxed/simple;
	bh=YSdpllJMtL3qq4g/8DhcpaxU5OyUxPFch0vjMfoWgLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXFxvki98yvtLjn8H4UIZa0xpdZekWGAA0qGBRZf5Ekc+L2aV62UfhSjSkW06vH8tnue0He0RnykFBGe/jF1HBZfPrOiPh/zPEbqE5TV61CaoRYELwGlU+By6P/6OOM454ik7dmE+eL90rjRSMzuN7NGWGmQ5C33PWbryAmkv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BVcPo0a7; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4eb02c0c851so1500000e0c.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719258070; x=1719862870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6B3HNmy01Oxg3r108cXAxfyeaHwUFHeuEPdI0tcKkLU=;
        b=BVcPo0a7HtMZes+DyeFQ5xnCwqK3Y4co9LyUJE++51IijUXtsj9y8CrKCjzMooLGlt
         j0f5XhReSfU6j0aDgFSNwik6JHSrWgwSCS1FZy8V7qnuVKwCjB1FbItylmN7WG4XlfMM
         M+UEcDv8m8o0f4Y5eD3BxHMQWV4VCryuqVVlbgTm2I88tBwlIBGvm8sOGYaUqtw+yEWo
         Cp9x8mPFuJ5uzhOmy3SwwSt9Y5ApglIsEJYPmv9hIWfnb2N3RU1aSXGBOlsjMz1u/wTa
         VPsNmha2HgWRHo31hFe9XKSZo4FaqIviTlYcwa7KFJwuKsBoTYTpjqsbq8WcbKqIbwGS
         txkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719258070; x=1719862870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6B3HNmy01Oxg3r108cXAxfyeaHwUFHeuEPdI0tcKkLU=;
        b=qBEf1pJLFeA3ixA4hRGk7k7lXFsVSdJNgz4XSOPbWwPlVvORWkONOeBKI2ZeCYxX7t
         94JUmFXdnqqJpwJlfOhQ/KoG5OXUp9OH+AFkXrsKRurKfkRNONH+G9eQvI6HAdnHYfNG
         u1jEC+a4ESRakmmx73clomrjpkoJABmE5VnD4x3DwhdVVPZbdOSN7/ddNSBqBHDABe43
         C6AAPvLW4XFcf4Qjaz076tTe6SIPAfdGMTwrKXVFYZq58E6jA6RlYCz00Tw4lru5laAN
         sJq2IdrU/8BE5tqz7OghtIinSh5q9WhDRpTeFTGx5PRWguJ2VV3io+f3TG4t0fVfDApq
         k42A==
X-Gm-Message-State: AOJu0Yw+XDYcaV+WNIFrB9/ia7s7EePRUi5N7++tZxhH/JwS0hwXnLug
	z0DMFX1kS+nzaygSGiiSn4Bthz1mgTQcp3/BFvkUMVBWZu9YTFQrPnYeANmL7W3AypOZKueCun8
	l
X-Google-Smtp-Source: AGHT+IGpbYdNxBm5FoJaH9VzK0libR+U9HJFAHMKBSWVMsDRY11vQBLNK9Jp1vqMBrPPc2CAK0mJ/w==
X-Received: by 2002:a05:6122:786:b0:4ec:f8b1:a34b with SMTP id 71dfb90a1353d-4ef663953b9mr4741911e0c.8.1719258070331;
        Mon, 24 Jun 2024 12:41:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef6e795sm36594946d6.141.2024.06.24.12.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:41:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 4/4] sefltests: extend the statmount test for mount options
Date: Mon, 24 Jun 2024 15:40:53 -0400
Message-ID: <cabe09f0933d9c522da6e7b6cc160254f4f6c3b9.1719257716.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719257716.git.josef@toxicpanda.com>
References: <cover.1719257716.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support exporting mount options, via statmount(), add a test
to validate that it works.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../filesystems/statmount/statmount_test.c    | 131 +++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index 4f7023c2de77..96696183d27b 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -64,6 +64,20 @@ static struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mask, unsigne
 	return buf;
 }
 
+static void read_file(const char *path, void *buf, size_t len)
+{
+	int fd = open(path, O_RDONLY);
+	ssize_t ret;
+
+	if (fd < 0)
+		ksft_exit_fail_msg("opening %s for read: %s\n", path, strerror(errno));
+
+	ret = read(fd, buf, len);
+	if (ret < 0)
+		ksft_exit_fail_msg("reading from %s: %s\n", path, strerror(errno));
+	close(fd);
+}
+
 static void write_file(const char *path, const char *val)
 {
 	int fd = open(path, O_WRONLY);
@@ -107,6 +121,8 @@ static char root_mntpoint[] = "/tmp/statmount_test_root.XXXXXX";
 static int orig_root;
 static uint64_t root_id, parent_id;
 static uint32_t old_root_id, old_parent_id;
+static char proc_mounts_buf[4096];
+static char proc_mountinfo_buf[4096];
 
 static void cleanup_namespace(void)
 {
@@ -134,6 +150,11 @@ static void setup_namespace(void)
 	sprintf(buf, "0 %d 1", gid);
 	write_file("/proc/self/gid_map", buf);
 
+	memset(proc_mounts_buf, 0, 4096);
+	memset(proc_mountinfo_buf, 0, 4096);
+	read_file("/proc/self/mounts", proc_mounts_buf, 4095);
+	read_file("/proc/self/mountinfo", proc_mountinfo_buf, 4095);
+
 	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 	if (ret == -1)
 		ksft_exit_fail_msg("making mount tree private: %s\n",
@@ -435,6 +456,113 @@ static void test_statmount_fs_type(void)
 	free(sm);
 }
 
+/* Search proc_mountinfo_buf for our mount point. */
+static char *find_mnt_point(void)
+{
+	char buf[256];
+	char *cur, *end;
+
+	snprintf(buf, 256, "%llu", (unsigned long long)old_parent_id);
+	cur = strstr(proc_mountinfo_buf, buf);
+	if (!cur)
+		ksft_exit_fail_msg("couldn't find %llu in /proc/self/mountinfo\n",
+				   (unsigned long long)old_parent_id);
+
+	/*
+	 * The format is
+	 *
+	 * <mnt id> <parent mnt id> <device> <parent mnt point> <mnt point>
+	 *
+	 * We are currently at <mnt id>, we must skip the next 4 columns.
+	 */
+	for (int i = 0; i < 4; i++) {
+		cur = strchr(cur, ' ');
+		if (!cur)
+			ksft_exit_fail_msg("/proc/self/mountinfo isn't formatted as expected\n");
+		cur++;
+	}
+
+	/*
+	 * We are now positioned right at <mnt point>, find the next space and
+	 * \0 it out so we have the mount point isolated.
+	 */
+	end = strchr(cur, ' ');
+	if (!end)
+		ksft_exit_fail_msg("/proc/self/mountinfo isn't formatted as expected\n");
+	*end = '\0';
+	return cur;
+}
+
+static void test_statmount_mnt_opts(void)
+{
+	struct statmount *sm;
+	char search_buf[256];
+	const char *opts;
+	const char *statmount_opts;
+	const char *mntpoint;
+	char *end;
+
+	sm = statmount_alloc(root_id, STATMOUNT_MNT_OPTS, 0);
+	if (!sm) {
+		ksft_test_result_fail("statmount mnt opts: %s\n",
+				      strerror(errno));
+		return;
+	}
+
+	mntpoint = find_mnt_point();
+	snprintf(search_buf, 256, " %s ", mntpoint);
+
+	/*
+	 * This fun bit of string parsing is to extract out the mount options
+	 * for our root id.  Normally it would be the first entry but we don't
+	 * want to rely on on that, so we're going to search for the path
+	 * manually.  The format is
+	 *
+	 * <device> <mnt point> <fs type> <mnt options> ...
+	 *
+	 * We start by searching for <mnt point> and then advancing along until
+	 * we get the <mnt options> field.
+	 */
+
+	/* Look for the root entry. */
+	opts = strstr(proc_mounts_buf, search_buf);
+	if (!opts)
+		ksft_exit_fail_msg("no mount entry for / in /proc/mounts\n");
+
+	/* Now advance us past that chunk, and into the fstype. */
+	opts += strlen(search_buf);
+
+	/* Now find the next space. */
+	opts = strchr(opts, ' ');
+	if (!opts)
+		ksft_exit_fail_msg("/proc/mounts isn't formatted as expected\n");
+
+	/* Now advance one to the start of where the mount options should be. */
+	opts++;
+
+	/*
+	 * Now we go all the way to the end of opts and set that value to \0 so
+	 * we can easily strcmp what we got from statmount().
+	 *
+	 * If the mount options have a space in them this will mess up the test,
+	 * but I don't know if that happens anywhere.  If this fails on that
+	 * then we need to update the test to handle that, but for now I'm going
+	 * to pretend lik that never happens.
+	 */
+	end = strchr(opts, ' ');
+	if (!end)
+		ksft_exit_fail_msg("/proc/mounts isn't formatted as expected\n");
+	*end = '\0';
+
+	statmount_opts = sm->str + sm->mnt_opts;
+	if (strcmp(statmount_opts, opts) != 0)
+		ksft_test_result_fail("unexpected mount options: '%s' != '%s'\n",
+				      statmount_opts, opts);
+	else
+		ksft_test_result_pass("statmount mount options\n");
+	free(sm);
+}
+
 static void test_statmount_string(uint64_t mask, size_t off, const char *name)
 {
 	struct statmount *sm;
@@ -561,7 +689,7 @@ int main(void)
 
 	setup_namespace();
 
-	ksft_set_plan(14);
+	ksft_set_plan(15);
 	test_listmount_empty_root();
 	test_statmount_zero_mask();
 	test_statmount_mnt_basic();
@@ -569,6 +697,7 @@ int main(void)
 	test_statmount_mnt_root();
 	test_statmount_mnt_point();
 	test_statmount_fs_type();
+	test_statmount_mnt_opts();
 	test_statmount_string(STATMOUNT_MNT_ROOT, str_off(mnt_root), "mount root");
 	test_statmount_string(STATMOUNT_MNT_POINT, str_off(mnt_point), "mount point");
 	test_statmount_string(STATMOUNT_FS_TYPE, str_off(fs_type), "fs type");
-- 
2.43.0


