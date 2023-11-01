Return-Path: <linux-fsdevel+bounces-1756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9C7DE58A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 18:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479D22818BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7718C2A;
	Wed,  1 Nov 2023 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cGvBoQWo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="25+c9h+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9718025
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 17:43:36 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1710F;
	Wed,  1 Nov 2023 10:43:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C87EF1F750;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698860606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InyU6IkAENGRjX63BgJMYCZOVDU0Rjela/KjykemRY8=;
	b=cGvBoQWo6D5nEnFeGQgDTCi7QnT4wupD/QljAmbwDHbcZn1j72Fs027p3jgbph1PW1A1Ov
	4RGDW1H9TO1gKksQUlT2Dfv5TC1rlywu/rq+NpGM3uj8f/fWoVoq61jAxnpacxHmwRogtv
	9/Rwa1jVqfe7TEruhKZlCtnL88z5wrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698860606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InyU6IkAENGRjX63BgJMYCZOVDU0Rjela/KjykemRY8=;
	b=25+c9h+abDDuZy8BL0dq8HZ5e9TOM6rvIzab1fUAvdd5zInZqzbrBG7auy13t6iaXx6be+
	2t0bBScapqHCRUAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9C3F13ACD;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SEVWLT6OQmUxYQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 17:43:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F21E3A07C6; Wed,  1 Nov 2023 18:43:25 +0100 (CET)
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
Subject: [PATCH 7/7] ext4: Block writes to journal device
Date: Wed,  1 Nov 2023 18:43:12 +0100
Message-Id: <20231101174325.10596-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231101173542.23597-1-jack@suse.cz>
References: <20231101173542.23597-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=jack@suse.cz; h=from:subject; bh=HuGESsNPSj9Qv49kiHt3CDXd9GHUB2GbWU0FnD28gkY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlQo4wQ8aD+R/KnoCeojDhZLI5knNBhVsl/OjJ/o0Z +jjVtsuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZUKOMAAKCRCcnaoHP2RA2bkqCA DeV0ajP8MvFxfY0SoPVdnFN+Ci0WI0FX3TtMOzHvHlDPwzVSS295Td2GrHVubbNYSOWjLVrwpGyMA4 kcw2C27bO5IRVJk1QfgND8bVdjQoUJ86gkkHIqn3DR5rWR0DrOUTI3McIIB40TyiqgLwUbFPX8AECn bqxoM3P/HvtT4+6P5fo1hHxSwo4aV8skY99gz6jtizORzxzu5wSvbhaqpcH92xUAwjlu5D5BDDDhyE iQWsrne50JSw2iZaHLv8CaB2ofc2CUNj1TvxPr5vqbVXPG/AloXQaIwtcjesSinypusiMIepQzRzXz FU/ETjwNyO43qynz7or1O0fn6F1jO+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit

Ask block layer to not allow other writers to open block device used
for ext4 journal.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 439e37ac219b..f96398f8aac9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5855,8 +5855,9 @@ static struct bdev_handle *ext4_get_journal_blkdev(struct super_block *sb,
 	struct ext4_super_block *es;
 	int errno;
 
-	bdev_handle = bdev_open_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				       sb, &fs_holder_ops);
+	bdev_handle = bdev_open_by_dev(j_dev,
+		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
+		sb, &fs_holder_ops);
 	if (IS_ERR(bdev_handle)) {
 		ext4_msg(sb, KERN_ERR,
 			 "failed to open journal device unknown-block(%u,%u) %ld",
-- 
2.35.3


