Return-Path: <linux-fsdevel+bounces-64779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD442BF3CFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1B518979C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463032F1FED;
	Mon, 20 Oct 2025 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6rh+lwl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F722EF67A;
	Mon, 20 Oct 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997679; cv=none; b=KLqt5jShxZLiwOhVguBQCIXgQwiO5C3WimrtDcwzDLYjI+EKZY0u4QA8fkOokS4wQ4fyXee42qrhajfjZifz6nNu7ji1AJi9sQwJ0ht+uxpCgqy6EGDh0Tvx2r7zHs1enWp7OlHtB02eEu2oQZuZzndm/CzAY/PP+F26KDS2y8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997679; c=relaxed/simple;
	bh=6ooqboEeSC/M2BVGV1rj5vMoK7jclehBAHjVVTCFn4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNECF8iRljwD08sY8JarHo/vGWW7+iWisG/HAiNGp5YS11Cws2CxGBV5s4Pv6D22OG/o5WEI5/cuynjj2+T2lLWcgSjreMeERCPfp5tzAdb4QcgQs6sG7YvW+qEiUIvk4GfK05xbak4j3FZm+19vuurjjjFtU7S9YdZHTRGA2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6rh+lwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A7EC19422;
	Mon, 20 Oct 2025 22:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760997678;
	bh=6ooqboEeSC/M2BVGV1rj5vMoK7jclehBAHjVVTCFn4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6rh+lwlR7mlHL8QrmRRJrUqLPXobrHQxNTkAqLGKcZ76PCulxXUDXr71kg5oQqjD
	 OtflfYW+deT7q1mfPHlQSbdOJh8d8KiDWpKYQCbclAs0PnLPvZdwMS2JrDIXqJYjbK
	 Q5afeiUW3E2QU3ZjBP/WOXM5yP7CfRVhiVc+KQ4IaFBSFODP8wYzn5An6Y4ZKD1e8V
	 p7OiKdmC27vXkEGKTNi9leyi1ybAME5dfzCqNqMRlT5JwnrOpi+CfcOclexNfKkiMh
	 cZuY9iG9f9/9dFcw+izTUcqMVE5BLgrZeCOCVf3lyiDOEc92oOBPwfR4wOdqKy5v/w
	 OYlENfFCiUnEQ==
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Tamir Duberstein <tamird@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	kernel test robot <lkp@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Yafang Shao <laoar.shao@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Christopher Ferris <cferris@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] coredump: Use __counted_by_ptr for struct core_name::corename
Date: Mon, 20 Oct 2025 15:01:17 -0700
Message-Id: <20251020220118.1226740-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020220005.work.095-kees@kernel.org>
References: <20251020220005.work.095-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=kees@kernel.org; h=from:subject; bh=6ooqboEeSC/M2BVGV1rj5vMoK7jclehBAHjVVTCFn4k=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfNuqYTSg5uLShwczqrLnczJkftJk7S+Q45f7NyXjK/ fj0nmt8HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPxZGH4Z+Kjc/X/NVaGC/O6 pyxpkCruKDr1/6O8z7WNHGqfyi3mXmb4XzRFd7KO/fet1rnaL5laLWdsSE5N5PFNuWEU9MB0+ZY WDgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Use the __counted_by annotation now available for struct pointer
members, __counted_by_ptr(). Move assignments to immediately
after allocation.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>
---
 fs/coredump.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5c1c381ee380..876f1cdb756f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -92,7 +92,7 @@ enum coredump_type_t {
 };
 
 struct core_name {
-	char *corename;
+	char *corename __counted_by_ptr(size);
 	int used, size;
 	unsigned int core_pipe_limit;
 	bool core_dumped;
@@ -106,15 +106,15 @@ static int expand_corename(struct core_name *cn, int size)
 
 	size = kmalloc_size_roundup(size);
 	corename = krealloc(cn->corename, size, GFP_KERNEL);
-
 	if (!corename)
 		return -ENOMEM;
 
+	cn->corename = corename;
+	cn->size = size;
+
 	if (size > core_name_size) /* racy but harmless */
 		core_name_size = size;
 
-	cn->size = size;
-	cn->corename = corename;
 	return 0;
 }
 
-- 
2.34.1


