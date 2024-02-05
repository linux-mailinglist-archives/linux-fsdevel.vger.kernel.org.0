Return-Path: <linux-fsdevel+bounces-10299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614F849A14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C48728388E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB491BC43;
	Mon,  5 Feb 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bAyrvno8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIEz8VUb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zA1i7F8I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="44SRWKkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851621BC3A
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136001; cv=none; b=oi3hwN/VUCl8rzxLrhyAtencdLZo+ryxzGgcg5cc9Rd6Z+b5uRJmsbvEJZFOFqevXZ9vdP72IdF65oKPXHwl2GRXM62XMSq1aU4bZFKcDRj3gqtWo1XBf//LjPv+z18tWTb4xt3Sqng8aVc6TiMroG7pBMNXD7h7z9UD7tcSEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136001; c=relaxed/simple;
	bh=oqQ3E1/YqlkS2mTvWbPI0IsZ4GwyYfXl1135/otQR5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AWDSw6y1zT6lKFNOBEkbxayvprH04H3Q53il32ZGuXCBvItxIM7SB6K7XFD9zl2M2Hx4pLm5jzCQqf2a7mfU9ECtl6jJKMhQOg3PCCEXYNJfhRLE3aUCAspvDyHnveNOAzzp1zWw/PU9j8Vtx6a6T3wPLnBqorltdHzR2mvZ0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bAyrvno8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIEz8VUb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zA1i7F8I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=44SRWKkO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B96C6220F4;
	Mon,  5 Feb 2024 12:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707135997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gfl8GYqzUY3EqB+LDYvsNuVOD2jktFjnACn9wWcIamw=;
	b=bAyrvno8PKxbnSnyefaErIAlP5gTyoYkUuDvPT/crycp1zV4a+H1Z9SZUO+LwhmSWQiqgB
	T2yOqp/tLqYMSBWxIDGueE6CgfJdM6j0WUKTXqeu9HHxrku6fMLNsujpQbKzqVlKMJBxxx
	AnTP/v9EDs+E+3BnX+Hptr88xaBC8ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707135997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gfl8GYqzUY3EqB+LDYvsNuVOD2jktFjnACn9wWcIamw=;
	b=uIEz8VUbxxPKeoSmrfRdFc/mXBgs0T04RS+FhGYA66+E0ndZrZ6qhSFw567DDpcHOicVqq
	nhtPpub9tlGpG1DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707135995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gfl8GYqzUY3EqB+LDYvsNuVOD2jktFjnACn9wWcIamw=;
	b=zA1i7F8ImuPjLnh+Ae7+MPKZHopp2OHA6hsJYyYC0tVT5XX7MmL9bBGkqKUTqUyYkp7eWG
	S6CF369ZyvW9eDlFvW0kl1LWHQCFtQV1dUefwd5mg5/cfnE0ioxG9nWsRhkyF7R6rABgkm
	+72+xf9x97E5+suUAs8F4lmidoEoodI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707135995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gfl8GYqzUY3EqB+LDYvsNuVOD2jktFjnACn9wWcIamw=;
	b=44SRWKkOo2KZJPJe6L1S92ay0iAMrwIRZa/wteKAQe9O9QLTyk5glD01on5tJAfiKd3F2H
	gdcgnGZB/Z0OYqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE8C513707;
	Mon,  5 Feb 2024 12:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sz6YKvvTwGWSTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 12:26:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4F54DA0809; Mon,  5 Feb 2024 13:26:31 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com
Subject: [PATCH] fat: Fix uninitialized field in nostale filehandles
Date: Mon,  5 Feb 2024 13:26:26 +0100
Message-Id: <20240205122626.13701-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=jack@suse.cz; h=from:subject; bh=oqQ3E1/YqlkS2mTvWbPI0IsZ4GwyYfXl1135/otQR5Q=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlwNPs/xU4BfdGbB/ntd3dx3TNJWXGnPzrpNIAKYhI tnspdeeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcDT7AAKCRCcnaoHP2RA2baqCA Ci8ClsLWT2/SMmaITIdNs5671/ZQZEzyHGCFy2mwGExo4SP9fusBYqI13fDq2QY/cJNJ7TxukkAw4b 3vUNkxKssP/lV3CludoAdJCyH5vlvZRQktlW71DmVDl7zH3cHXzP/dq/HRWWW0jcTdvxlfafOOE61i EuidyR9227As5UmRgkC7DcLliwUNudqXXNMkCGg2DwXvO6rsDTpkQJ3eZWA3pk1jl+V4FSB5CePDSf uAszbb4FnENjYOM1qelPGk1dmmXxR8awano9vpZdliaczTpuzhrd0Y2HA510/Z86mN1yUwQBDwV9NK w1CvkA9dflMiYIGvSsK0vmc/9q0DZp
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zA1i7F8I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=44SRWKkO
X-Spamd-Result: default: False [6.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[3ce5dea5b1539ff36769];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.cz:dkim,suse.cz:email];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.cz,syzkaller.appspotmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 6.19
X-Rspamd-Queue-Id: B96C6220F4
X-Spam-Level: ******
X-Spam-Flag: NO
X-Spamd-Bar: ++++++

When fat_encode_fh_nostale() encodes file handle without a parent it
stores only first 10 bytes of the file handle. However the length of the
file handle must be a multiple of 4 so the file handle is actually 12
bytes long and the last two bytes remain uninitialized. This is not
great at we potentially leak uninitialized information with the handle
to userspace. Properly initialize the full handle length.

Reported-by: syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com
Fixes: ea3983ace6b7 ("fat: restructure export_operations")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fat/nfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index c52e63e10d35..509eea96a457 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -130,6 +130,12 @@ fat_encode_fh_nostale(struct inode *inode, __u32 *fh, int *lenp,
 		fid->parent_i_gen = parent->i_generation;
 		type = FILEID_FAT_WITH_PARENT;
 		*lenp = FAT_FID_SIZE_WITH_PARENT;
+	} else {
+		/*
+		 * We need to initialize this field because the fh is actually
+		 * 12 bytes long
+		 */
+		fid->parent_i_pos_hi = 0;
 	}
 
 	return type;
-- 
2.35.3


