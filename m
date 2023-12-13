Return-Path: <linux-fsdevel+bounces-5819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF09B810CDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0BD1C2081F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8291EB47;
	Wed, 13 Dec 2023 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRMKY1Cj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD21EB3C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 09:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71122C433C9;
	Wed, 13 Dec 2023 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702458021;
	bh=KYg70uTTMCVbbybOUe4N/VTYl2TBfccDvrHX9QOYSpI=;
	h=From:To:Cc:Subject:Date:From;
	b=QRMKY1CjqdvbZ0fbr2tBAwGIzwJ4uuPaNCuYkelu9eHILPcC0WvZTScIzOI0dNK6V
	 p1zR4KyknBgnnd5nC0szCG01DrkV10nVXhXEHNpRgKjg6a7oiP96Z57Ac5xlStWol6
	 NVYSF2Rjf0QHrI7WipJ/iT1qYwm5S7kVASmGKI9t0uZifTt31XCU1DFiWWkMMO6pBo
	 un3hUZCgfnLgjKqP9Bhj6on6scYXyuwRyLSPZKGkH7na7rgPBgSx7s4aeZUv65A7kH
	 eJgltZHbSlNr5p2rGIBgU9stsuQBnnQXq21MW1fKdlqy4KK3mgRuurRBFCKEoqMB66
	 f/f8r09VGOqxQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] statmount: reduce runtime stack usage
Date: Wed, 13 Dec 2023 10:00:03 +0100
Message-Id: <20231213090015.518044-1-arnd@kernel.org>
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

Replace the assignment with an in-place memset() plus assignment that
should always be more efficient for both stack usage and runtime cost.

Fixes: 49889374ab92 ("statmount: simplify string option retrieval")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d036196f949c..159f1df379fc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4957,15 +4957,12 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 	if (!access_ok(buf, bufsize))
 		return -EFAULT;
 
-	*ks = (struct kstatmount){
-		.mask		= kreq->param,
-		.buf		= buf,
-		.bufsize	= bufsize,
-		.seq = {
-			.size	= seq_size,
-			.buf	= kvmalloc(seq_size, GFP_KERNEL_ACCOUNT),
-		},
-	};
+	memset(ks, 0, sizeof(*ks));
+	ks->mask = kreq->param;
+	ks->buf = buf;
+	ks->bufsize = bufsize;
+	ks->seq.size = seq_size;
+	ks->seq.buf = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);
 	if (!ks->seq.buf)
 		return -ENOMEM;
 	return 0;
-- 
2.39.2


