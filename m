Return-Path: <linux-fsdevel+bounces-78406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML8WHYZ5n2nScAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:36:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702219E5A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8FEA30B2224
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEAF33BBAA;
	Wed, 25 Feb 2026 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRyqgEis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5633C18C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058865; cv=none; b=PKi79gfiOyc3HSsp9QnDIqqK/ZNrrwEoASM12SBoMNuL/1gjsbLUvTxq2UgSC7Ky0vldwpjMwWKugjjqkRhwxm3LRvGe880RTxxIGwl6hHmY7OdjQCGZVfvZBtv9Hrcgm7LRosrU0/Nzk2ckanggECxWra7CjNZMN346Tg0W0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058865; c=relaxed/simple;
	bh=ymKrZvnn1wXoX3MO7tLDPSCDvegTjqhP4f2VwqTSGPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NtUmPWJfznllei6hK7yhD0qTgnr9GBLxnf2dzM3v/tPXqe1G0WXBOaXojkEeAFOugI9BvEUOwpta1B0KXOcgZxFD/TkECqHZHZg9hRR3/m44dkFzuZfnm0Zt/Ay19Zpbq8yBkQsRTyrA/Vwew9UV7AP454wIw3tbj4GFwQl3zA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRyqgEis; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2add59d1a5aso997395ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 14:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772058860; x=1772663660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLezOUj++5KtU+iy76kNFYSHOIOxW3z9n/oglLgyr0s=;
        b=fRyqgEis2xyUjaczHDwUma1EDA4AN3QlAcp39p2ElDW4QdhH0DTLDPCl7rTl5rsZfh
         Y/ck5cCTlHbNLSolchZLjwn9VSuHY3NZZ1siS5e/dTqtYxfDTWYgaUqQ9RbV42/Dx2lp
         5aJsid0eP1DXY4+W6icRzkGWD8wx1Qmv4uRhPoUzdIKx7wwtLVb1iW5xHv0trPMR3qDo
         4oOanaN7QY1I2kSkutdShCw1hportGfjNSeQH6lxleyityFGAjNU91i7EA+eyop34/e0
         R5REy3LkQFB3KGJRT274Er5i19oVizrit3USMZ0IZxf6EZgXh0+M7llGlnj5nVMB5zlM
         118g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058860; x=1772663660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLezOUj++5KtU+iy76kNFYSHOIOxW3z9n/oglLgyr0s=;
        b=eL2J1a/Tkkmm9NIsAfRuLKgP6BT/2CN9UtDaoo67PelLdO9IfB0h/1A9FSZIcfzkPT
         T2HrHyR2hCtXt9hHs+lfhQqdhhZvFwncq6C+P3zYKDeUMcdlXj88n/DBtjqXfYOzec/m
         Bwof6PA+VDV1ZuhDZ5vdaeNDwr3qWjjvaER9T02ZmfcSlYeefwbV7hXNXi7uo0xNvdCj
         /uL3Aj+x5tmC23rMOc8VfideF1zDgMLfhq7L46AD2CUKNCe5Igw1aQDKZAiG8lQFSgqw
         uWdTLXMJSOstkkyEef11xVFBBPLZgqltfAcIpAG2KEHQw7/xFCLQYEoqFt41GX67tN+h
         zOnw==
X-Forwarded-Encrypted: i=1; AJvYcCU74PJcg1trJbrVl0IbgH1yHbbhAp0oLTPjx4p3GqMtDo3OnoufGJ2W1KXYGqSrnz77T/7igRDyk/quinQn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6Vi/s2FFivT50/66qWx2lnsv0ZZHXws8ULdnosu2jhMhf4nu
	Q2JTNGFmMSAODPEEbBKdX5WjEHq+vkq4u4POzHEIOg3az6QSPb+LWUC2YAQa1rJvhuVELonAsk8
	PejOsA7013d3UGtwVMw==
X-Received: from plbld14.prod.google.com ([2002:a17:902:face:b0:2a7:7822:9011])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b48:b0:2a0:bb05:df55 with SMTP id d9443c01a7336-2ae034613a3mr358175ad.21.1772058859947;
 Wed, 25 Feb 2026 14:34:19 -0800 (PST)
Date: Wed, 25 Feb 2026 14:34:04 -0800
In-Reply-To: <20260225223404.783173-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225223404.783173-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225223404.783173-4-tjmercier@google.com>
Subject: [PATCH v5 3/3] selftests: memcg: Add tests for IN_DELETE_SELF and IN_IGNORED
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78406-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1702219E5A3
X-Rspamd-Action: no action

Add two new tests that verify inotify events are sent when memcg files
or directories are removed with rmdir.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 4e1647568c5b..57726bc82757 100644
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
@@ -1625,6 +1626,115 @@ static int test_memcg_oom_group_score_events(const char *root)
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
+static int test_memcg_inotify_delete_dir(const char *root)
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
+	wd = inotify_add_watch(fd, memcg, IN_DELETE_SELF);
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
@@ -1644,6 +1754,8 @@ struct memcg_test {
 	T(test_memcg_oom_group_leaf_events),
 	T(test_memcg_oom_group_parent_events),
 	T(test_memcg_oom_group_score_events),
+	T(test_memcg_inotify_delete_file),
+	T(test_memcg_inotify_delete_dir),
 };
 #undef T
 
-- 
2.53.0.414.gf7e9f6c205-goog


