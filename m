Return-Path: <linux-fsdevel+bounces-21993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CACD910C59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062781F21EB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048B41B29B9;
	Thu, 20 Jun 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkyRLylM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09B1B29BD;
	Thu, 20 Jun 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900643; cv=none; b=QKl7IbRCEsUUtkvHDI8xFpl2vOia59BaqvUpAM7435EGhq88Rpu+zyGwakkaTSfx/dY9M4/JIUO2L4qSUcobwTMOovjl0RCsbMr2Tdtsq/W7wIRjZLaVz9T+tTQt1jqNN0jycIvsqmFclIipqkQp4tin1EhZzBLFi2QFSXmVnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900643; c=relaxed/simple;
	bh=cJPHgO7rC0lwgzSVqzH0rTJpOL4kkIXZCXlrSaP+FJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uW9QqobvpxvNF2h/6AJxUE4A7ycTzifJNNDn0/I/lAnCLZILh/5HbqcV5Vh1xBuxYaFoBT06cRof2g7dfNEJ9/QMcJts9y+kKr9DOp9dSYlh4r6z4JrbQapmcwIT/GQPQ+/m3cLRJ/W3z+R1FGYOXJU3q4MW9pa/V8YeeCG23xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkyRLylM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFD4C32786;
	Thu, 20 Jun 2024 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900643;
	bh=cJPHgO7rC0lwgzSVqzH0rTJpOL4kkIXZCXlrSaP+FJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkyRLylMnXyv0WsxD8QL8vKVPSKro4BwCxwyewRoTfPdeRVcm1oChn7k8vYspR3wd
	 yQW8rnIE0bv8kkbtAqaKqgPnepA6DcOCp3JMdTlAnT8RlKjsKi5K+r9OqT4HoFonmG
	 f3kHhl3ZWTZMo4GtaggxJcXmFVjVUSUkiC4DBTES3UPVTq0B2sYkBQsRdANXLL6bIL
	 SCHzW2/7J9RmI1gl2ED3xynQG4CCaaemzF9kz+POcz6T4kzugSs3WAtC5cl5ThjNaj
	 oq/eswLVYZeUNXhiqyKfNJrn1nns2jlf4JSkYv7RCQh4XBBytNYAFCKzeahkxjiU8J
	 nnR+Jle+gafYw==
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
	musl@lists.openwall.com,
	ltp@lists.linux.it
Subject: [PATCH 04/15] sparc: fix old compat_sys_select()
Date: Thu, 20 Jun 2024 18:23:05 +0200
Message-Id: <20240620162316.3674955-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620162316.3674955-1-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
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


