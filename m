Return-Path: <linux-fsdevel+bounces-22261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFA91544C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 18:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FEB1F23995
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03F19F47B;
	Mon, 24 Jun 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKA9rFeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A519DFBB;
	Mon, 24 Jun 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247072; cv=none; b=D8xGBNQpeGzUv3QzvD7ZUkpIXSw+Nsbgcy1mv+QwjZorUnwBSdRIK6TdXtM1TE6JdhJxIQSdsnnNG9yH0sA9WXfuet/SXG5ZfvnhbxTAL9bnuH5SlbYFBfB4ZltdgvFYEmhDKwtPRT53D34FRNoXdpc7V2ykhoicWlzTG22wY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247072; c=relaxed/simple;
	bh=uXEcxQ1FBzwRpqEeAQBWAem52gb/DEAY3efxRFChZrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEIzC7tHT+vuWqdKODWXqUYaoRLyczr2x0sEZO4jJcR6K7kT0hpfvR4Be8cxLhho1DnG5SFDwNsUKZ0/RkNFARjpXPOvw0IhOjELaedYfxep3+ptYWvF7o3oPCRUV434f1yGzeShHpLu6jJhgM1EqyYg2NYmkBzDEsfJttTjerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKA9rFeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95776C32786;
	Mon, 24 Jun 2024 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247072;
	bh=uXEcxQ1FBzwRpqEeAQBWAem52gb/DEAY3efxRFChZrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKA9rFeojnOnVeQRY2swQuXdfxFb6A/vAU6OCW+E2IRVfnnxSk2zg1FkmlLzg8TXa
	 PyQJ0kdyvqQSLjFrtIjLVt0Nj0zEQq5oExHbukLIX7ZrVCcTZttZVzIoJ2O8MqYyX2
	 k2Y0GGI6r89CtrF4hV5ZOTh/HATRebuGBw2pScM1PnHNsJiWglHD8Y1uAz/skNPzTP
	 Dc/t0CtHfJSMdr0UtzyUqYCHvo1UleTmR1UWNGYszEVz9r/w76G92ED0CkmKNeCPgS
	 S0UNZ0G1s8WMo/Snu6rdLlaNPRDcOKaomFXMIgbhlD/hVkX387ybj3RcQ8X/e0qcUb
	 kcoerCtPfPCUw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	libc-alpha@sourceware.org,
	musl@lists.openwall.com
Subject: [PATCH v2 05/13] parisc: use correct compat recv/recvfrom syscalls
Date: Mon, 24 Jun 2024 18:37:03 +0200
Message-Id: <20240624163707.299494-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624163707.299494-1-arnd@kernel.org>
References: <20240624163707.299494-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Johannes missed parisc back when he introduced the compat version
of these syscalls, so receiving cmsg messages that require a compat
conversion is still broken.

Use the correct calls like the other architectures do.

Fixes: 1dacc76d0014 ("net/compat/wext: send different messages to compat tasks")
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/kernel/syscalls/syscall.tbl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index b13c21373974..39e67fab7515 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -108,7 +108,7 @@
 95	common	fchown			sys_fchown
 96	common	getpriority		sys_getpriority
 97	common	setpriority		sys_setpriority
-98	common	recv			sys_recv
+98	common	recv			sys_recv			compat_sys_recv
 99	common	statfs			sys_statfs			compat_sys_statfs
 100	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
 101	common	stat64			sys_stat64
@@ -135,7 +135,7 @@
 120	common	clone			sys_clone_wrapper
 121	common	setdomainname		sys_setdomainname
 122	common	sendfile		sys_sendfile			compat_sys_sendfile
-123	common	recvfrom		sys_recvfrom
+123	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 124	32	adjtimex		sys_adjtimex_time32
 124	64	adjtimex		sys_adjtimex
 125	common	mprotect		sys_mprotect
-- 
2.39.2


