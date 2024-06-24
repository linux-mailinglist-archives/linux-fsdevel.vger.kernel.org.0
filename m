Return-Path: <linux-fsdevel+bounces-22259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 574D1915438
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36C0B23DD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C119EEA3;
	Mon, 24 Jun 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwn+jGCU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110FE19DF93;
	Mon, 24 Jun 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247060; cv=none; b=YFPAdAgR37rqHv8LFfGIv84NjX1Jq2QyrPH1RGqeL//Wr4SCDHEhOoR1Z4DFq8lzzDxNj1sSRUES73iUQxKWMJp6f0KvSgISA0HjZ2ji0yB0Wu32Spusyl2SSpC8nJxYG97htzmopCyIbfQ3yE7KE5rbfZbOwfdvnUSPYBrauf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247060; c=relaxed/simple;
	bh=cJPHgO7rC0lwgzSVqzH0rTJpOL4kkIXZCXlrSaP+FJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXjIOC0/MZmHucvkU5DTJUT/w2fkv9C/xPxA2lfhZAFmCnO89WOt6i8s+xjDXZ+ZK+VJ2AHsr9eCBYrkOP/dDBBiL8rh9v9cUwEV+E00V7vUyzrfZboZVDrIehdRWHBsfQsiS5TrKpSLdU8URKxXLAx7q1gCmFKEWNmnX7L8aTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwn+jGCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E363C32782;
	Mon, 24 Jun 2024 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247059;
	bh=cJPHgO7rC0lwgzSVqzH0rTJpOL4kkIXZCXlrSaP+FJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwn+jGCUC3yfeHdr61T+R7qdpp7FtgKCRvyBo2uwU9O8wKwov+G6fl9loxbYrfqug
	 0T6Js/X7H2q61DSlRIPr4w8OB38apm8CWjNpUWrRx79AQZShrNcEk27UBDHfmgWYb3
	 pRabFRMmRSwHdCpeJRda6lIYrtM6QwCtmL8VC1jUjN9o258tf3w+MQor+GkMrwKMPk
	 0O4uDPBeD8fo+0Dpfp87EEcbPVcLEkZLC9SRvqxt56F6WMn6+CkvBUe0dvtpcngVG3
	 AUsNbT19IslMHtlvnF4KXjzBPZgqO8HsGtTrZVqZbf2zNhu14tg3iGC1E8WDctygF+
	 xg8gIbf+mqW9A==
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
Subject: [PATCH v2 03/13] sparc: fix old compat_sys_select()
Date: Mon, 24 Jun 2024 18:37:01 +0200
Message-Id: <20240624163707.299494-4-arnd@kernel.org>
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

sparc has two identical select syscalls at numbers 93 and 230, respectively.
During the conversion to the modern syscall.tbl format, the older one of the
two broke in compat mode, and now refers to the native 64-bit syscall.

Restore the correct behavior. This has very little effect, as glibc has
been using the newer number anyway.

Fixes: 6ff645dd683a ("sparc: add system call table generation support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/syscalls/syscall.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index b354139b40be..5e55f73f9880 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -117,7 +117,7 @@
 90	common	dup2			sys_dup2
 91	32	setfsuid32		sys_setfsuid
 92	common	fcntl			sys_fcntl			compat_sys_fcntl
-93	common	select			sys_select
+93	common	select			sys_select			compat_sys_select
 94	32	setfsgid32		sys_setfsgid
 95	common	fsync			sys_fsync
 96	common	setpriority		sys_setpriority
-- 
2.39.2


