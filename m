Return-Path: <linux-fsdevel+bounces-48893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD894AB55D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEFD173131
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B513128F946;
	Tue, 13 May 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpCelK0Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BiZmf9dZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpCelK0Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BiZmf9dZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4628F532
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142299; cv=none; b=TxbQU5R1E9CoisSNmdIFQmASpybvItsbjPebLP88EFrQuFkb/sCW44PfWWscws6Vwbcx0l4UyDzsQVxV0CWX9shxwo+hwfTubLmlz4ihm+Bq0g0JLvMXX621/hdxUosvteYBmZ4YvxnRaWqATv8m8dlmKfY56gyh6OL0jdZHUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142299; c=relaxed/simple;
	bh=A6NWfGM+4OQsAaMc0q5sdZE4bBElnWXoW2szyoTV73g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUyypwyMViC5yotVI390yfcv78QTbYT/hdhFjg9V6MpuuUOZ9KsYUZ5MDuWz2UUrLczYICJBpS30n10riepUG1tEtW7LKMp8a43xD5jY3NBNy0zt7ByMvQ39MiC3wyqqiJRac6c5RQpjAnqLiJVuRw+Yow5xL8VgZRys2EWo3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpCelK0Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BiZmf9dZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpCelK0Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BiZmf9dZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 707FD21207;
	Tue, 13 May 2025 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747142294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JJMEGH7c5EYuw2SjPyvg89o8HWXUXIv3i7Y9l8LPlGc=;
	b=rpCelK0YsydQLLVDSKZekIXItuilSjRF/ZfagKmo1l77rqQm9G5jpcYdnb4ZGVZixsaoDC
	HKeN/ntH4fx5kK7bZw/wQDXoqhpCg9/S5SZj+uD7Zxc1+FmFCV3KyVXyj3ad8rrl+Hy0Yz
	CV4dNvUp6Euf+iUCqWVRKR92SdddsSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747142294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JJMEGH7c5EYuw2SjPyvg89o8HWXUXIv3i7Y9l8LPlGc=;
	b=BiZmf9dZ3wPtHg00ZnEewwlh/y6fdJZ5H0VW15+aRvIE4iXso6sjKGqc7GQ2uE9todcjX2
	eQKU1JAehYILkjBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rpCelK0Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BiZmf9dZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747142294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JJMEGH7c5EYuw2SjPyvg89o8HWXUXIv3i7Y9l8LPlGc=;
	b=rpCelK0YsydQLLVDSKZekIXItuilSjRF/ZfagKmo1l77rqQm9G5jpcYdnb4ZGVZixsaoDC
	HKeN/ntH4fx5kK7bZw/wQDXoqhpCg9/S5SZj+uD7Zxc1+FmFCV3KyVXyj3ad8rrl+Hy0Yz
	CV4dNvUp6Euf+iUCqWVRKR92SdddsSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747142294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JJMEGH7c5EYuw2SjPyvg89o8HWXUXIv3i7Y9l8LPlGc=;
	b=BiZmf9dZ3wPtHg00ZnEewwlh/y6fdJZ5H0VW15+aRvIE4iXso6sjKGqc7GQ2uE9todcjX2
	eQKU1JAehYILkjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6234E1365D;
	Tue, 13 May 2025 13:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 91v3F5ZGI2j2VwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 13 May 2025 13:18:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1CC75A0A60; Tue, 13 May 2025 15:18:14 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fanotify: Drop use of flex array in fanotify_fh
Date: Tue, 13 May 2025 15:17:46 +0200
Message-ID: <20250513131745.2808-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; i=jack@suse.cz; h=from:subject; bh=A6NWfGM+4OQsAaMc0q5sdZE4bBElnWXoW2szyoTV73g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBoI0Z561gL6olV+HOub1KNd0g3xbCbDEVRdBkaYtkW rhuvgUiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaCNGeQAKCRCcnaoHP2RA2Uz+CA CfcOff+0rQDW4pxehTIPqAhl4f4eQi/Yo5TgEcxlRKC248mQCWL2HUnjUSWREvNaWrr9YLbDbG6w9e yQk8ONsP7hDBoovzycN2FQb9ZoGzg1uFEUbcCZkZxRwBpPZSmjfBEcHCFQ+/0yjGvjdcMDhwBAJRpj W6YYohxcGSf+4szoUgG8F0urF0XWRsgmIFbGPGrTqs++Hx30kHbChYBVJlSF9B46p00lcJ+ciwMPE1 fBR1HBr4iyC/aGGe1ZTIZn0zbO4AXYZzl3apbO6YNa8GMrTtDgPpa4bmI5Oy/JjjqfD9+9HKwobGK/ QLNgS5HuDtU+ANAznA0WAO+vLkVcWv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 707FD21207
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,embeddedor.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action

We use flex array 'buf' in fanotify_fh to contain the file handle
content. However the buffer is not a proper flex array. It has a
preconfigured fixed size. Furthermore if fixed size is not big enough,
we use external separately allocated buffer. Hence don't pretend buf is
a flex array since we have to use special accessors anyway and instead
just modify the accessors to do the pointer math without flex array.
This fixes warnings that flex array is not the last struct member in
fanotify_fid_event or fanotify_error_event.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify.c | 2 +-
 fs/notify/fanotify/fanotify.h | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

Amir, how about this solution for the flex array warnings?

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6d386080faf2..7bc5580a91dc 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -415,7 +415,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 {
 	int dwords, type = 0;
 	char *ext_buf = NULL;
-	void *buf = fh->buf;
+	void *buf = fh + 1;
 	int err;
 
 	fh->type = FILEID_ROOT;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index b44e70e44be6..b78308975082 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -25,7 +25,7 @@ enum {
  * stored in either the first or last 2 dwords.
  */
 #define FANOTIFY_INLINE_FH_LEN	(3 << 2)
-#define FANOTIFY_FH_HDR_LEN	offsetof(struct fanotify_fh, buf)
+#define FANOTIFY_FH_HDR_LEN	sizeof(struct fanotify_fh)
 
 /* Fixed size struct for file handle */
 struct fanotify_fh {
@@ -34,7 +34,6 @@ struct fanotify_fh {
 #define FANOTIFY_FH_FLAG_EXT_BUF 1
 	u8 flags;
 	u8 pad;
-	unsigned char buf[];
 } __aligned(4);
 
 /* Variable size struct for dir file handle + child file handle + name */
@@ -92,7 +91,7 @@ static inline char **fanotify_fh_ext_buf_ptr(struct fanotify_fh *fh)
 	BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN % 4);
 	BUILD_BUG_ON(__alignof__(char *) - 4 + sizeof(char *) >
 		     FANOTIFY_INLINE_FH_LEN);
-	return (char **)ALIGN((unsigned long)(fh->buf), __alignof__(char *));
+	return (char **)ALIGN((unsigned long)(fh + 1), __alignof__(char *));
 }
 
 static inline void *fanotify_fh_ext_buf(struct fanotify_fh *fh)
@@ -102,7 +101,7 @@ static inline void *fanotify_fh_ext_buf(struct fanotify_fh *fh)
 
 static inline void *fanotify_fh_buf(struct fanotify_fh *fh)
 {
-	return fanotify_fh_has_ext_buf(fh) ? fanotify_fh_ext_buf(fh) : fh->buf;
+	return fanotify_fh_has_ext_buf(fh) ? fanotify_fh_ext_buf(fh) : fh + 1;
 }
 
 static inline int fanotify_info_dir_fh_len(struct fanotify_info *info)
@@ -278,7 +277,7 @@ static inline void fanotify_init_event(struct fanotify_event *event,
 #define FANOTIFY_INLINE_FH(name, size)					\
 struct {								\
 	struct fanotify_fh name;					\
-	/* Space for object_fh.buf[] - access with fanotify_fh_buf() */	\
+	/* Space for filehandle - access with fanotify_fh_buf() */	\
 	unsigned char _inline_fh_buf[size];				\
 }
 
-- 
2.43.0


