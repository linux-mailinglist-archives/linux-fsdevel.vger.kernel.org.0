Return-Path: <linux-fsdevel+bounces-33849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5B79BFAB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA769B22415
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0F6FBF;
	Thu,  7 Nov 2024 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZvggoE1q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W48oh6DM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZvggoE1q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W48oh6DM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E13D515;
	Thu,  7 Nov 2024 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938930; cv=none; b=UvgBO9CIYZkChpPLUHDt6T1vlYra5DahQLTHs8TjpbH2zCG4GY8zJFXXQ8VeQ9De0r/Xt1InLUy27gp+KJ3Aa5MB/Twh04KXxMyRmeBHBHCtPntOZc3TqiDrrbA1CL1SjqXHxtYMAma10ygyaqVYGswX5k/HEEuSSzlSjhTdk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938930; c=relaxed/simple;
	bh=KtCvMQnoTAGnjG8Y+Sk2AzwfZ4BixyKP/vWn/8eLMoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2xVkrDPsolqkS5pbP5YEDId5YnaeJxCzV16x/g9uyGnt/IMbwZ+iRvlm0qWzK/e1aQAWAnMOJhWE14ESrZXPuo82szC0mFtG6O6p92pj0wxGsrvxB+kZTROsbs6w5kFj1G0j2yfR+yS+VdhKKClhRN9H12ROTkwDzm1lX4NjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZvggoE1q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W48oh6DM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZvggoE1q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W48oh6DM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9F491FD41;
	Thu,  7 Nov 2024 00:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXGzLqa7ndw2VlNeIeFuPasg/cAnz8Fj/bNSm06DPsg=;
	b=ZvggoE1qOBP+3lRiwzvFGeEQH7bj6JUA9TEHhAKnThMzlhad7odfFVwHukWe1n0vnWcLYJ
	zoxmonHRqsn+HtxOsDfMxPCRw5HkttVRVUeEutFCQgiy8Z22Zq0fb6mbuANueb6dIXFhMu
	sT+DQGrO74Zm0WV7C+2v03ZUacCT0xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXGzLqa7ndw2VlNeIeFuPasg/cAnz8Fj/bNSm06DPsg=;
	b=W48oh6DMmaAildRhyCEy7KvkzxLkkwRpeWntzO4bYAn+CogU+4R44pndoUCpVWvym3WA+2
	gcKRQd2YQlAeMxDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXGzLqa7ndw2VlNeIeFuPasg/cAnz8Fj/bNSm06DPsg=;
	b=ZvggoE1qOBP+3lRiwzvFGeEQH7bj6JUA9TEHhAKnThMzlhad7odfFVwHukWe1n0vnWcLYJ
	zoxmonHRqsn+HtxOsDfMxPCRw5HkttVRVUeEutFCQgiy8Z22Zq0fb6mbuANueb6dIXFhMu
	sT+DQGrO74Zm0WV7C+2v03ZUacCT0xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXGzLqa7ndw2VlNeIeFuPasg/cAnz8Fj/bNSm06DPsg=;
	b=W48oh6DMmaAildRhyCEy7KvkzxLkkwRpeWntzO4bYAn+CogU+4R44pndoUCpVWvym3WA+2
	gcKRQd2YQlAeMxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B5C01394A;
	Thu,  7 Nov 2024 00:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AKH/EywILGfWYgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Nov 2024 00:22:04 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 7/9] initramfs: reuse name_len for dir mtime tracking
Date: Thu,  7 Nov 2024 11:17:26 +1100
Message-ID: <20241107002044.16477-9-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107002044.16477-1-ddiss@suse.de>
References: <20241107002044.16477-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.956];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

We already have a nulterm-inclusive, checked name_len for the directory
name, so use that instead of calling strlen().

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 4e2506a4bc76f..c264f136c5281 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -144,9 +144,8 @@ struct dir_entry {
 	char name[];
 };
 
-static void __init dir_add(const char *name, time64_t mtime)
+static void __init dir_add(const char *name, size_t nlen, time64_t mtime)
 {
-	size_t nlen = strlen(name) + 1;
 	struct dir_entry *de;
 
 	de = kmalloc(sizeof(struct dir_entry) + nlen, GFP_KERNEL);
@@ -170,7 +169,7 @@ static void __init dir_utime(void)
 #else
 static void __init do_utime(char *filename, time64_t mtime) {}
 static void __init do_utime_path(const struct path *path, time64_t mtime) {}
-static void __init dir_add(const char *name, time64_t mtime) {}
+static void __init dir_add(const char *name, size_t nlen, time64_t mtime) {}
 static void __init dir_utime(void) {}
 #endif
 
@@ -394,7 +393,7 @@ static int __init do_name(void)
 		init_mkdir(collected, mode);
 		init_chown(collected, uid, gid, 0);
 		init_chmod(collected, mode);
-		dir_add(collected, mtime);
+		dir_add(collected, name_len, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
-- 
2.43.0


