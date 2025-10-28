Return-Path: <linux-fsdevel+bounces-65883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0E1C13978
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 185D44F7E00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C352D6608;
	Tue, 28 Oct 2025 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwWiK92n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464742D73A4;
	Tue, 28 Oct 2025 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641174; cv=none; b=BdjkTSS2QUmt1IMH185n7xlPrLIG5yAWAux3BlSRnBy19evfxwrh8axtGLiDeYJEPr0O311cWLpNcF/XRf4aozF451Gi+ywU+YGAVmcknsKoHHsYYWeayZEVCPzYF4Cw6L4N239xGkE8NBXW8YIg2UfDHvcbQ0ZCJc8UfoNoCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641174; c=relaxed/simple;
	bh=Q8nIJCP/MWRKfTorXwE5BdMuUQyCSfVb9hCE6/9Dt4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfY37rPmwUnuh37smAEE2EGdgcdKBdMel/3wf9qAVCXwwtv73v6zc1Mz3kP6kL5olScHmwJOoA5LGf3SUPnEOhsVe80uXUOkNO4tQJhnBdVoF1SFSwUI5qiPH1WDvYFaeFPmuj62PC9s9mciHuqm7l8ibBx2dmOYv/gdrdyWD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwWiK92n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66350C4CEFF;
	Tue, 28 Oct 2025 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641173;
	bh=Q8nIJCP/MWRKfTorXwE5BdMuUQyCSfVb9hCE6/9Dt4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PwWiK92nKxAiq2UBfl7HGnZpQa7iU9nsp6Nj0te6N0+tq0S/uGKtCWhspirfESJ/q
	 Rsh3+yjqN8IKDRitbMAKD/YuBfGv/lZhkqSylR4wYyDVpZXVVg8ZTDAuqQMKlx0XO+
	 jXEKunO5Ez2kCcog8P4B28WbCWcPDhh6cWV+a7PupiBJrfiLjlfcCEnC0TGDgiha5B
	 9MnaTTqATHr/wUaMMTqD0ZZ7eHAOv1HLcZOZOWj8GtkhVOnVwlZXnhUs5plsKF4Dng
	 Rg59sNj7EctpCWhryj9JFSkUldqHKF07Cq3gayLXmt1wZynCzJ6ycOKUzRKatMqWke
	 qhPMkAzWZwOhg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:48 +0100
Subject: [PATCH 03/22] pidfs: add missing PIDFD_INFO_SIZE_VER1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-3-ca449b7b7aa0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=732; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Q8nIJCP/MWRKfTorXwE5BdMuUQyCSfVb9hCE6/9Dt4c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB2c//vE9ImCLMsOxwopWAp1fOwpPseh09z0Ni5Wl
 /f1ByPZjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYSTMy9C1/bLlxJ2PdrdjE
 UOsjt0QTqm4c6TmYyHJP6r6AedMGWYb/IbvKLONjZkw0Tp7949+X6bmn2NUyQz7c0f8UXn1D57I
 bKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We grew struct pidfd_info not too long ago.

Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/pidfd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 957db425d459..6ccbabd9a68d 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -28,6 +28,7 @@
 #define PIDFD_INFO_COREDUMP		(1UL << 4) /* Only returned if requested. */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
+#define PIDFD_INFO_SIZE_VER1		72 /* sizeof second published struct */
 
 /*
  * Values for @coredump_mask in pidfd_info.

-- 
2.47.3


