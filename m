Return-Path: <linux-fsdevel+bounces-1751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308167DE54F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 18:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0BD1C20DDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6A17758;
	Wed,  1 Nov 2023 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XcPIjDl8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2XoCXMBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502816409
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 17:27:59 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB611D;
	Wed,  1 Nov 2023 10:27:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54F8A21A40;
	Wed,  1 Nov 2023 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698859667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EeD6MyheOvOMKaTHDmPGr7/dKV5M5WhtYHJ6fivDVuE=;
	b=XcPIjDl83MPTFBFz5xer0np/Ys+j7Uzpsx8dHdLDTdZfzcAYTnjCpaJzWdP1Tu3iLbZBu6
	XA+N0db5B77Ewu4KmW6TZTXLOQbgzkfTJdwS2Prd/e+Yg13Q5tVfdNdc+7NDtzCZ0O3TGP
	hzxH9KtTAMNnA7u/7uZYBNnvLSQ518g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698859667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EeD6MyheOvOMKaTHDmPGr7/dKV5M5WhtYHJ6fivDVuE=;
	b=2XoCXMBy3RneEMuj2CC88wjcNLXeZin32BB1uoWECZhSn5V1xQrIKWWa7jHw2gWfD7NBPg
	FjcIhbwcwsZhJ6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D3281348D;
	Wed,  1 Nov 2023 17:27:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LPSFDZOKQmVmWgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 17:27:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE313A06E3; Wed,  1 Nov 2023 18:27:46 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: [PATCH] nilfs2: simplify device handling
Date: Wed,  1 Nov 2023 18:27:39 +0100
Message-Id: <20231101172739.8676-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=jack@suse.cz; h=from:subject; bh=7IopNN/k3gNX0K2pRjQVO3jTcQh+9ZPrhl91nV19/Rw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlQoqGNCqfSpTE27Yb7nYlcbMInQ2z0m4cVZQa+JSm /gY25jiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZUKKhgAKCRCcnaoHP2RA2ZPGCA Cg9yqthRkvlhMsH8966kdm/q/Gyoghg9+oA+qHq0g1uSNRmeH+XUuoovtQKBn6cWZfEz7AxoNhews9 yk6ykL2TGlHKkQZA5gr5pKlFmQGt8gOcJcetk+UNnvaBr3l2jI8MAultwwxJvUx/Kti1VHKdfiia4d 4g6Gfd+iqwyGo8ZhlmuIOyuNKZeQsSLc+TOz4Y62h2MQoBAJZqVM1N3Id32dF1UHT3mZmhYAUCrqbC QijRwNslQ2WQ2HG3tKQBU2PCWWs/8x1EogyaugnzkFBkWgFsProngEJHLP7TPjH0AE61P6JEB/oea+ 0bLrAL4phG3lj282ME7qHbvzmG8SH1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit

We removed all codepaths where s_umount is taken beneath open_mutex and
bd_holder_lock so don't make things more complicated than they need to
be and hold s_umount over block device opening.

CC: Ryusuke Konishi <konishi.ryusuke@gmail.com>
CC: linux-nilfs@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/nilfs2/super.c | 8 --------
 1 file changed, 8 deletions(-)

Hi Christian, I think you've missed this simplification in your cleanup
patches. Can you merge it please?

diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index a5d1fa4e7552..df8674173b22 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1314,15 +1314,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 		return ERR_CAST(s);
 
 	if (!s->s_root) {
-		/*
-		 * We drop s_umount here because we need to open the bdev and
-		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
-		 * __invalidate_device()). It is safe because we have active sb
-		 * reference and SB_BORN is not set yet.
-		 */
-		up_write(&s->s_umount);
 		err = setup_bdev_super(s, flags, NULL);
-		down_write(&s->s_umount);
 		if (!err)
 			err = nilfs_fill_super(s, data,
 					       flags & SB_SILENT ? 1 : 0);
-- 
2.35.3


