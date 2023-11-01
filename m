Return-Path: <linux-fsdevel+bounces-1761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8C7DE58F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 18:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2F7B2124C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0286918E3C;
	Wed,  1 Nov 2023 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fZfUCUm4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIiAq//S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CEC18630
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 17:43:36 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54657111;
	Wed,  1 Nov 2023 10:43:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B87B821A40;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698860606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+7Wpp/E2EdiZofVxhh2+hzQImgeg1xdtRejCKkMdy0=;
	b=fZfUCUm4xM5dJrCz+vcQLBI5c2/W8KX6Ldl0KACQbef+PgyVMxVxZq6EJ+hQ3CGQiFuhbA
	IOhJv9/cpQxd9egVJxnj0Qom1eJW/IkVPuPgXvkk4dup6+Kpl+uyIaNgsUSV/tDVSXFcLA
	WzvudiTgSdGb6uqQF51MZgnEiAMeWag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698860606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+7Wpp/E2EdiZofVxhh2+hzQImgeg1xdtRejCKkMdy0=;
	b=IIiAq//S5YNMXLq/G4VScKDLNn9KndjS3FmVu8IYFB9R3YS00y0p7zCYYcaVJASuq0MtYH
	93BdKwVQOc3I0ZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA76513A92;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id l2+ZKT6OQmUvYQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 17:43:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB968A07C3; Wed,  1 Nov 2023 18:43:25 +0100 (CET)
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
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 6/7] xfs: Block writes to log device
Date: Wed,  1 Nov 2023 18:43:11 +0100
Message-Id: <20231101174325.10596-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231101173542.23597-1-jack@suse.cz>
References: <20231101173542.23597-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=jack@suse.cz; h=from:subject; bh=0ohImTI7LWBrWprfMwJTEIQpEG4d+p/gxEPGWo26suU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlQo4vhDMGgCebAqMpWVpQbE0zs5AajPPDCxCP+6JG cQYw/H6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZUKOLwAKCRCcnaoHP2RA2YEVCA DeHIHP2RD6bzLKIacMsYkpyVlZBCEV1xHudpKCL+HY3v7+/D2leHGekabtfj8pop2aBJ+vTGppmD7Z kQs2+mpgkW9xBzrE7NCJHi1JvgW+/48bivCd7iAh8uxRqMy797/nbqC3D7aPq4S54WNtcTqdo6PgUj 0ARxSXgu/hVWx772qTLM6pH8xcU9ay5s5YXpyA5F03lQk8IiXB0pKlIpDlBPEfMZVONnvrOHHamTIq /mzhCUB6oSYClZU5MNQWWHEiv1hxtbIwYKnFqtkmlvbpL05kY3Q04LIaet4cB4ggA4zxkHzII3RVad hI+FZpmAE5SThz0plXx+FmunZjadcJ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit

Ask block layer to not allow other writers to open block devices used
for xfs log and realtime devices.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 84107d162e41..2f29a6810e6a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -365,8 +365,9 @@ xfs_blkdev_get(
 {
 	int			error = 0;
 
-	*handlep = bdev_open_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				     mp->m_super, &fs_holder_ops);
+	*handlep = bdev_open_by_path(name,
+		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
+		mp->m_super, &fs_holder_ops);
 	if (IS_ERR(*handlep)) {
 		error = PTR_ERR(*handlep);
 		*handlep = NULL;
-- 
2.35.3


