Return-Path: <linux-fsdevel+bounces-5750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED5E80F9BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F8A1F21795
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9964CC9;
	Tue, 12 Dec 2023 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHuBGdEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79E65A98
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 21:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95D0C433C8;
	Tue, 12 Dec 2023 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702417705;
	bh=wVW4B4dpDL0SVJV6h8hwO86hfQnu7Dv3P3WCPwRyals=;
	h=From:To:Cc:Subject:Date:From;
	b=dHuBGdEkvGgWZiAVBXqaCQtFzOWV7PsCszdXbNCNkEUvgKH8OVVjrYnWfaVAxhVXH
	 nxl1ZdNew2m2TsOP5tA7cLqvsJ5J8dqSUyUKPJm8wn4d7tjLbXT3iC+93GoFvOYsyY
	 HJUiu8QPgOeXlFOZluNyO0Sf5PpyVqldWe2Bci+UwgkJRzQAjtJzLJVfEf3gQKymX0
	 kYk4qwKeKsaTyCueQKXHGgDIiL6Son3oeM/n7Mc8fVqBnx9ejiWwALrrNbGPW3i9Wj
	 yAnerwoiQCcNHhiwIjqpbJkxkPeafpbWQeDnFr/LfKLIDTNOVUYelIzMFhUHPYgcRh
	 5dq9/NoIxKdIg==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Ian Kent <raven@themaw.net>,
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] statmount: reduce runtime stack usage
Date: Tue, 12 Dec 2023 22:48:13 +0100
Message-Id: <20231212214819.247611-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

prepare_kstatmount() constructs a copy of 'struct kstatmount' on the stack
and copies it into the local variable on the stack of its caller. Because
of the size of this structure, this ends up overflowing the limit for
a single function's stack frame when prepare_kstatmount() gets inlined
and both copies are on the same frame without the compiler being able
to collapse them into one:

fs/namespace.c:4995:1: error: stack frame size (1536) exceeds limit (1024) in '__se_sys_statmount' [-Werror,-Wframe-larger-than]
 4995 | SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,

Mark the inner function as noinline_for_stack so the second copy is
freed before calling do_statmount() enters filesystem specific code.
The extra copy of the structure is a bit inefficient, but this
system call should not be performance critical.

Fixes: 49889374ab92 ("statmount: simplify string option retrieval")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d036196f949c..e22fb5c4a9bb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4950,7 +4950,8 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 	return true;
 }
 
-static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
+static int noinline_for_stack
+prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
 			      size_t seq_size)
 {
-- 
2.39.2


