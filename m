Return-Path: <linux-fsdevel+bounces-65894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CF0C139CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973CA3B116B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC992E613A;
	Tue, 28 Oct 2025 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulgeOvI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF782DCF50;
	Tue, 28 Oct 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641224; cv=none; b=IGuVunpswkVDxIoAseQ4AOR7Wu5GFjPuHHmCjGPbK/I6Om0Ez4r5Qf3YIdTuT8m12sgJFDKxBF3++S45GxbxEF0SKxDrcKWLGQfAB/uLcJItTM9s/DUspb+ERPGqSeOlWzVO0bqIWdLBQFG0W+IIRrRRxIXaJIDdpYt0bGipTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641224; c=relaxed/simple;
	bh=3MpjOtfC3vFzMqWOcuWmTlVUTGIKdBVTAvwLW7DUofU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IofdwKv4Bkn2/nW998z7NnxeBctxYwnAx8qPdVTjrs4M2+y9oYkbRISaZdo7dBD5IR13D2dR/Us7Vw3MeUE83+WC43/NCYr1Uc9VQnZlI10PYvzq+peYo/m5QfobEcm2/Aqe8fJhzKb523dalatIxv4lrcQRruGrtS0wipFPon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulgeOvI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F24C4CEFF;
	Tue, 28 Oct 2025 08:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641224;
	bh=3MpjOtfC3vFzMqWOcuWmTlVUTGIKdBVTAvwLW7DUofU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ulgeOvI4oZAyDiF2rBuSBEEMn/5V/7esUSQX+db9gciYwkiv3e47N08kbT/ViOtYh
	 ve29nn7XiXK2DOFM1a4rnJddFOwZU8cY6s6ROANvjdmHUECbFjvoD7iL0lpYKK0pMg
	 Lr5YnD0UXDHJNqljaOEjFNaokk4D4SHLVb5o54kxTzoxLjlD9FqqLDvJlEY1ZZZRoK
	 +IKjc8JbdRvkHP6SKMtx918uD7iT3hqGElZWABp/jy1fgcutkVZJLVhqCsM/5k5dtV
	 hn+RlFzmxiuSP+mpB8uBgSM+N6IKY3I9wWtT/beN/klPJVpmBuzAjP4+RU0g3Zsctx
	 XAeosNYCSQ7bA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:59 +0100
Subject: [PATCH 14/22] selftests/coredump: fix userspace client detection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-14-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3MpjOtfC3vFzMqWOcuWmTlVUTGIKdBVTAvwLW7DUofU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB3awbXxssCbA6tE27Y8PFmRpL21b6uIysFCp1e7K
 nZdeymT0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRv+YM/yueLmO/nPb9Jmes
 bsDULXxPtX/JveEN2edkMOtgXsFKLVlGhl0vmdVeMz37nJR6hn36FX6edJOdcSea9S5NSkyZVnF
 2PRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We need to request PIDFD_INFO_COREDUMP in the first place.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_socket_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index d5ad0e696ab3..658f3966064f 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -188,7 +188,9 @@ TEST_F(coredump, socket_detect_userspace_client)
 	int pidfd, ret, status;
 	pid_t pid, pid_coredump_server;
 	struct stat st;
-	struct pidfd_info info = {};
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_COREDUMP,
+	};
 	int ipc_sockets[2];
 	char c;
 

-- 
2.47.3


