Return-Path: <linux-fsdevel+bounces-49017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695A4AB78B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 00:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089883B1F56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA5231821;
	Wed, 14 May 2025 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4VW0Ubv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D6221296;
	Wed, 14 May 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260274; cv=none; b=sbpta92qKF7gy4iVab+HwUGrruVdEc+oYhX25BiiOssbavs66YFGqhkUsc9QvgZ2jqN+jgMds/YHeXCnLUPAXvL4RqPAXF3bhwROy8jNV1lEPXVaHMooQn6GKasgEHj972RhD/uUsJVMB+zEiAwabFDTEoTi+s7py9Uw3weZ5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260274; c=relaxed/simple;
	bh=GofPJKcSMTqtWvKIscS1eZ3G1JH+s1zbLWmsYPBuvtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTo1F81qPNF5ldPshU3Ur8jOpi9OOVAWWiCr/7xc4WcLyXbHK1iWuyjHvF+hp2uyXu19QABix+i5VsgH6Yb1m41so93apGq3UE7Ka/pXDkXbvJxKDHLMNpYGaSxohwS3hq/SB664UgFxuvikvLpcVhCntLnfj1TvyURK29+aNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4VW0Ubv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0C0C4CEEF;
	Wed, 14 May 2025 22:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747260274;
	bh=GofPJKcSMTqtWvKIscS1eZ3G1JH+s1zbLWmsYPBuvtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b4VW0UbvM1foRVLyhSsYkbutkTtNDGp86d3vZb+EscZ4wdISAFS98lQCq3NzaXiay
	 ZhP0tDP5ZmZ2TC/v97vaS1rvTe++YT0MyFwONocFzQClXNc+fP0gIxz6IpKOjMAdfv
	 Q8K2F5B0m0Wzjt4JFqc+BxmDyzJpkGoDoH+TtN8Cv7tbXaPPn9bE6rxA0L1tSlbEg1
	 jhCCuNLdGg+fX6Qq9OGJyk+95DUiV3EjaKqxqJdZ+5RhVCPAkx+uwSyjGxDrRu5bD7
	 itPolyZ6dd+7cXX2Dpb0amdwS9g6WqbrcfcKO4pZLDRvXKYi/J2rZk++3gaUrLiC1b
	 tQK9tYAoQ+dGA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 15 May 2025 00:03:40 +0200
Subject: [PATCH v7 7/9] coredump: validate socket name as it is written
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-work-coredump-socket-v7-7-0a1329496c31@kernel.org>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GofPJKcSMTqtWvKIscS1eZ3G1JH+s1zbLWmsYPBuvtI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoCntci0xSrJ0wQfNh4ZtD9w89yM3Y/Vzq4yu1Zd+Fn
 ScaLDsa1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRC/0M/z0rNt7Jif9xcMfP
 WRxXnty4Jm2QLnnrxqdXf7et8pe6cXAhw//84jeTOLYqfTnxO3jRbI5pc+aUr2E2WGrwtW+mg1r
 8FlduAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In contrast to other parameters written into
/proc/sys/kernel/core_pattern that never fail we can validate enabling
the new AF_UNIX support. This is obviously racy as hell but it's always
been that way.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 6ee38e3da108..d4ff08ef03e5 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1228,13 +1228,44 @@ void validate_coredump_safety(void)
 	}
 }
 
+static inline bool check_coredump_socket(void)
+{
+	if (core_pattern[0] != '@')
+		return true;
+
+	/*
+	 * Coredump socket must be located in the initial mount
+	 * namespace. Don't give the that impression anything else is
+	 * supported right now.
+	 */
+	if (current->nsproxy->mnt_ns != init_task.nsproxy->mnt_ns)
+		return false;
+
+	/* Must be an absolute path. */
+	if (*(core_pattern + 1) != '/')
+		return false;
+
+	return true;
+}
+
 static int proc_dostring_coredump(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int error = proc_dostring(table, write, buffer, lenp, ppos);
+	int error;
+	ssize_t retval;
+	char old_core_pattern[CORENAME_MAX_SIZE];
+
+	retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
+
+	error = proc_dostring(table, write, buffer, lenp, ppos);
+	if (error)
+		return error;
+	if (!check_coredump_socket()) {
+		strscpy(core_pattern, old_core_pattern, retval + 1);
+		return -EINVAL;
+	}
 
-	if (!error)
-		validate_coredump_safety();
+	validate_coredump_safety();
 	return error;
 }
 

-- 
2.47.2


