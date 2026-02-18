Return-Path: <linux-fsdevel+bounces-77493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F7VI6swlWmeMwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:23:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4674D152D35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7A9C3054B98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 03:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA732E7F39;
	Wed, 18 Feb 2026 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwsBFT7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C92DC33B
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 03:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771384980; cv=none; b=UZiYbkw+t7O29S2mkfQ4ME1VjvQWR60iHEkqRUyQKVXl2n43u7rdkxi9cNCRb5H0LfQa2CURbjOf7t/E5v8t7TXZNyqxzHwe8AAh6WHhY4Q08nkCvaj7SL8VzKv2M9YFp1taVEqyaWAFtUy8bTxRBGmqEYZ7RRI1G6rcyrWtJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771384980; c=relaxed/simple;
	bh=amJ6sTsdRzljNmWNFyyNWbH0+wmhpkN9l7CXsUdsmJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t0CCWBq4sK8Y4HUnXlUv9mEqSl+0swy0pOJP1gdb/tImDly3AN5RUOwg6GRkW2l7Oe5SNPkZ3+E9VAqr5zHKocXJZG8EWx6tkAHWRkfT+/TN0EMW8Y0nRNCvOaPcrOpzNeMCaxm4f3WfnrindGEamxt8Wv4e9036LlXMKR5R6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KwsBFT7J; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8243ae83898so2139082b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 19:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771384979; x=1771989779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fK/D1opWbvNOOx0YfmI5FNRjOmnqGdMEH8VMO81NrfE=;
        b=KwsBFT7J4jYlacwY5b6LXwNUxYhroxASeKKBDpzY0RzrPypElBwUwIGQJ/QwymGZs6
         1s2pVOf4ZhbLymL73iZPExX2c5la+7uM3+8u7XEXT226z4K+PEN8ef6CnjvfHQ7m9/FB
         WoUFR+8AUVWz668Gi2+zF5M71r2XjvdKFz3ZwqFRWWyNUTBGv5hEJkxkBJtam9mBiBsq
         Ul7blxHCa1rWPMF3aFfbQNSWD9JhwjX0w1O15f7CJf59JP61L4TF6FFoDz5HUnTd2YP+
         AMMcU29tcw9fCiFgoOcKlFKP9gvqkyCjReeT9ZOTOHB7x7diTbkbKNynsbRdyyETqLrY
         95Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771384979; x=1771989779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK/D1opWbvNOOx0YfmI5FNRjOmnqGdMEH8VMO81NrfE=;
        b=qGW82rewHFn1PGtxWBYfItNyW2gpLzbWtYAZnniYKRSWQQUKwQCWL8qYsOBjfm3uNX
         nvYR+Z6tZqNfKRqgtlJq9EmP1l/bGY+57twkuv1KJXs9NS+KhqRTzfhRZJNvx3fCe63L
         Embd2anuX2FgDODlHx9oiYvVEFqdi3FmLjeq/lnh2xqdk6FXjMpLvqu4h4oSnQy5GKwn
         730Wk/UCx9oglAnrAFfqkn2uNqH4in/W6kYXB0x9vnQ715Ccccb6AfFyl0yjYIaV4l2f
         udvdRn1SJBq/DIrQWXQBHQom2P9d2pEunBG482BC0glbi8xspxSC4XHGDZAzNA3SQUdU
         F+nw==
X-Forwarded-Encrypted: i=1; AJvYcCWYKbMg0UjgYfmjw4l6HE0tzGF4geyRQPDrQ5ytEPnD8Lp8UY/DrOG+25A86zcb9EGhW/RXmP9JShzMJqWo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Qyz+Jmai63bCiXx+0XxWkgcwt7DZJhsK8ZFf+gJYUxEtcPVX
	b78lAlQ/BTWIN/JNeMG31TdqwgCuRxOVbRRM/tWMcseOLb4xb+bs89eHdp6AHJXC4b/WmDRKv7I
	nGISkLhggDjPIZuuO/w==
X-Received: from pfbhc6.prod.google.com ([2002:a05:6a00:6506:b0:823:c4bd:60eb])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:f8f:b0:81d:a1b1:731b with SMTP id d2e1a72fcca58-824d951b02dmr12246190b3a.19.1771384978430;
 Tue, 17 Feb 2026 19:22:58 -0800 (PST)
Date: Tue, 17 Feb 2026 19:22:32 -0800
In-Reply-To: <20260218032232.4049467-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260218032232.4049467-4-tjmercier@google.com>
Subject: [PATCH v3 3/3] selftests: memcg: Add tests IN_DELETE_SELF and
 IN_IGNORED on memory.events
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77493-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4674D152D35
X-Rspamd-Action: no action

Add two new tests that verify inotify events are sent when memcg files
are removed.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 .../selftests/cgroup/test_memcontrol.c        | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 4e1647568c5b..2b065d03b730 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -10,6 +10,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <sys/inotify.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
 #include <arpa/inet.h>
@@ -1625,6 +1626,125 @@ static int test_memcg_oom_group_score_events(const char *root)
 	return ret;
 }
 
+static int read_event(int inotify_fd, int expected_event, int expected_wd)
+{
+	struct inotify_event event;
+	ssize_t len = 0;
+
+	len = read(inotify_fd, &event, sizeof(event));
+	if (len < (ssize_t)sizeof(event))
+		return -1;
+
+	if (event.mask != expected_event || event.wd != expected_wd) {
+		fprintf(stderr,
+			"event does not match expected values: mask %d (expected %d) wd %d (expected %d)\n",
+			event.mask, expected_event, event.wd, expected_wd);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int test_memcg_inotify_delete_file(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg = NULL, *child_memcg = NULL;
+	int fd, wd;
+
+	memcg = cg_name(root, "memcg_test_0");
+
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_write(memcg, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	child_memcg = cg_name(memcg, "child");
+	if (!child_memcg)
+		goto cleanup;
+
+	if (cg_create(child_memcg))
+		goto cleanup;
+
+	fd = inotify_init1(0);
+	if (fd == -1)
+		goto cleanup;
+
+	wd = inotify_add_watch(fd, cg_control(child_memcg, "memory.events"), IN_DELETE_SELF);
+	if (wd == -1)
+		goto cleanup;
+
+	cg_write(memcg, "cgroup.subtree_control", "-memory");
+
+	if (read_event(fd, IN_DELETE_SELF, wd))
+		goto cleanup;
+
+	if (read_event(fd, IN_IGNORED, wd))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	if (child_memcg)
+		cg_destroy(child_memcg);
+	free(child_memcg);
+	if (memcg)
+		cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+static int test_memcg_inotify_delete_rmdir(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg = NULL;
+	int fd, wd;
+
+	memcg = cg_name(root, "memcg_test_0");
+
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	fd = inotify_init1(0);
+	if (fd == -1)
+		goto cleanup;
+
+	wd = inotify_add_watch(fd, cg_control(memcg, "memory.events"), IN_DELETE_SELF);
+	if (wd == -1)
+		goto cleanup;
+
+	if (cg_destroy(memcg))
+		goto cleanup;
+	free(memcg);
+	memcg = NULL;
+
+	if (read_event(fd, IN_DELETE_SELF, wd))
+		goto cleanup;
+
+	if (read_event(fd, IN_IGNORED, wd))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	if (memcg)
+		cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct memcg_test {
 	int (*fn)(const char *root);
@@ -1644,6 +1764,8 @@ struct memcg_test {
 	T(test_memcg_oom_group_leaf_events),
 	T(test_memcg_oom_group_parent_events),
 	T(test_memcg_oom_group_score_events),
+	T(test_memcg_inotify_delete_file),
+	T(test_memcg_inotify_delete_rmdir),
 };
 #undef T
 
-- 
2.53.0.310.g728cabbaf7-goog


