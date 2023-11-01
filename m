Return-Path: <linux-fsdevel+bounces-1760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6877DE58D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 18:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB561C20DF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68D18E22;
	Wed,  1 Nov 2023 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qfnzs8DT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qNX80e5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22A18656
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 17:43:37 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFC115;
	Wed,  1 Nov 2023 10:43:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B881A21A41;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698860606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsxXilB8VtCWD9uJ48g6IisnMmSxhnqquY6XcPZlAKQ=;
	b=qfnzs8DT7yNoCyRCiEfgwweelCcCNnhDKYjy65J8od5FjaRZYtuQ+qQJhVUCDKTN3Ky0kS
	UhI8vabTpxc8luwHCzWIUJCnps+IwZP9QtTy5BDSSldLovGbrXcHaGu3Kf97dp+LDqjFD2
	D4mtr1ewM2NojGSIJlu+zDox8YodfSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698860606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsxXilB8VtCWD9uJ48g6IisnMmSxhnqquY6XcPZlAKQ=;
	b=qNX80e5RN09U7lmTJyabsszy6iJuhCmAGejuFXQWPv9qncGkn6WSRUk3YoTtlkdm5lnPIT
	ozEvR31D4EutLUCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9C821348D;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id d8FuKT6OQmUuYQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 17:43:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E3E89A076D; Wed,  1 Nov 2023 18:43:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>,
	<linux-xfs@vger.kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5/7] fs: Block writes to mounted block devices
Date: Wed,  1 Nov 2023 18:43:10 +0100
Message-Id: <20231101174325.10596-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231101173542.23597-1-jack@suse.cz>
References: <20231101173542.23597-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=744; i=jack@suse.cz; h=from:subject; bh=T/eItSVb7GcAYjznkgJHNYn7HD+3ITlTRTvdImRwJ2E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlQo4ubiwBwif8qp1536oKopFx3GfrPsJ5t7c/7aOj 1jG1waqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZUKOLgAKCRCcnaoHP2RA2TkYCA DrJ56qaR1IQHLAf07UimuEs8suyyRufEgDz9zttWEJ7ZIIN0LmxsFinrw7ZJWHbbV/DrKpB0oeX/Uh xE8r6AHulGkMbasTJNABoZDxovW6HqZ8QEWh+1/RdG5p6NloxvvMCdDHILjDQwJtQN6eDfdGuAVjSI q3WTHOfnkh6x6cpuQWEUwTLQWm8FBAOb2sKa3PQaN2Qnus+ukMGqF0JZhX9JpkO46S9ielqaiW3ZUi xuyR4j/7LyNTtjxEDWuQwZT62dkwA3JgaNu6tr1+Gvc1svvBjzwVgf/8pldrHC3dC5i+lmG53BCZTx wzY85qVmI3fqOg587aQp0FyMKTd0oh
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit

Ask block layer to block writes to block devices mounted by filesystems.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0e0c0186aa32..9f6c3373f9fc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1494,7 +1494,8 @@ extern const struct blk_holder_ops fs_holder_ops;
  * as stored in sb->s_flags.
  */
 #define sb_open_mode(flags) \
-	(BLK_OPEN_READ | (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
+	(BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES | \
+	 (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
 struct bdev_handle {
 	struct block_device *bdev;
-- 
2.35.3


