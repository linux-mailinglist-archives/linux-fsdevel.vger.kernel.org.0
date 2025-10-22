Return-Path: <linux-fsdevel+bounces-65184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CDFBFD602
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FA53B2DBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3480833DECC;
	Wed, 22 Oct 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7XU/sVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E947382865;
	Wed, 22 Oct 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149464; cv=none; b=V44g1c7/I3gP6SPgfSiPgcpwL7wHP3EHYoz4CPA6x61WkH94KXQzTm5stkMceGiTSjPbIPorQfpe5739QCEe3N4xUvxQgm+p9mk3Ju+jgACf11NNOw5S8h2DOQy4BdG23iJI2d67IKagXSqINTpJw3KIXJUQVa2esohronvzllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149464; c=relaxed/simple;
	bh=ufWjPwiVFUvMc1yUrgMdzg/t00J0XDkru7okPfPAtyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onBz+9DeHJeqOB3yfVs4NSaoic3DuGpUZgAQvBv2e3ElgiSYaSHduIQV118D24Nlvg+iwEbxEQdbfnHdrmKa1jB3Qqdr7uT3oKPlOwmARlKN/P/S70m6UU3XJdRb8iMPVaUxn+5GE/SL2sRkjFTU+P7AWpddSBvAu3nUrfFqtMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7XU/sVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F30EC4CEFD;
	Wed, 22 Oct 2025 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149464;
	bh=ufWjPwiVFUvMc1yUrgMdzg/t00J0XDkru7okPfPAtyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n7XU/sVaIYqM0xGtka3zmyCDO/RnWLcgBOSjQvF9DL2clSpBoTCjkSJk0xfOmNFml
	 Hd6YgdSSXVvjT+GYTfhQeK9magtak62q0fb8/GQlPz96yJ84f039H2mIjiFiK/6jSi
	 pq0OcH++X43g5QOvJnP16aqlcc4I6qqt+ERNHe/Bw6WvFOwP06YVUb90rydUvte6U2
	 +teBWDKL5BkkKGG1DDfzS0R37k4swXCW+GCRTKhsPRsKQIQpaqLdBGmUtW0YFfvsqO
	 Bizh32o4u8sWJiu/RSPmXdC/qsl0jaUN+C6Diuc0E1uBTfu5HQ3BTrrq5mKUYsT8gt
	 NEiWAsZXObdHw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:34 +0200
Subject: [PATCH v2 56/63] selftests/namespaces: fifth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-56-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ufWjPwiVFUvMc1yUrgMdzg/t00J0XDkru7okPfPAtyE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHg+b3lyQM0OvdZWtWliia/Z7u8Syzy5+EfiRR0jO
 bFLp/b6d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE6xgjwyPOVYp6/x5y/Tu1
 opHrxduTeU6cwcm161erzlCWEj4RXMfIsPHzMtmQcxOWTjx5K9x/md3zqh1e3GeTBY+UzVvCUsL
 5iQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test SIOCGSKNS fails on non-socket file descriptors.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 3aed6e3d60a3..4134a13c2f74 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -308,4 +308,30 @@ TEST(siocgskns_across_setns)
 	close(netns_a_fd);
 }
 
+/*
+ * Test SIOCGSKNS fails on non-socket file descriptors.
+ */
+TEST(siocgskns_non_socket)
+{
+	int fd;
+	int pipefd[2];
+
+	/* Test on regular file */
+	fd = open("/dev/null", O_RDONLY);
+	ASSERT_GE(fd, 0);
+
+	ASSERT_LT(ioctl(fd, SIOCGSKNS), 0);
+	ASSERT_TRUE(errno == ENOTTY || errno == EINVAL);
+	close(fd);
+
+	/* Test on pipe */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	ASSERT_LT(ioctl(pipefd[0], SIOCGSKNS), 0);
+	ASSERT_TRUE(errno == ENOTTY || errno == EINVAL);
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


