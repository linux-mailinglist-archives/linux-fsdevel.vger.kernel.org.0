Return-Path: <linux-fsdevel+bounces-43041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6B0A4D37F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757FB17311E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4AF1F4E5D;
	Tue,  4 Mar 2025 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uYVYDwvo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QHiqrz6M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uYVYDwvo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QHiqrz6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1F1F473A
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068661; cv=none; b=sbB1mw/UGAtuRe4IB6tg3zeURE1HwFoNBObDGujLZpu3CqNvX/bqVpjhIrnnimxNK8Nv5zwEEhdKlwPYpF7xSI60b/4K1JQDvzjMnb73W8dFoMOyYMisuqVAhYRNxdE9qLocRhk+FY9MSyipJoannqOGSjupi4nx2uyzZoUuDZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068661; c=relaxed/simple;
	bh=OxVCPBDVHwlv+DQrIFfwywlzxqJ6ZshhZgKcEGfGk88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st0z6CU6Fmb/mDnWAtS8wjoowJl4YpcIxLaCMcAWNLpdZ+4uBRigwvQ4asizk8yWz5PtnMOAivD6+OEEldU2HAe3mYJnWAnTzRjZg34nhN17mjHMbFUxubhH1QB8GMoRq/A5i50yzSDHMuqTwztOZsNXoSfIxef7isTwGXpBEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uYVYDwvo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QHiqrz6M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uYVYDwvo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QHiqrz6M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CB331F74A;
	Tue,  4 Mar 2025 06:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NybDqcMH4iwP2OSDbcuX3AOpTQ8MRyAWQJkqxCJurY=;
	b=uYVYDwvoQCsDFOvgZAlhNis8JrbQ3DcVJwSaJbtNPqId9kaQC1NeiYd4bmQnl7gv1rzG5V
	fvDtHO04Wxk7UJPo+kZLELwZSD9cEkR6j71G2mxp/iugEbxeMKih2qfMebVUy2y6xS7FZC
	jUwpmDgtD8skLngVOMur1tIqVlPD61Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NybDqcMH4iwP2OSDbcuX3AOpTQ8MRyAWQJkqxCJurY=;
	b=QHiqrz6MUuYH+Nr2/hp2PjYAVREofjAL4N+po7YTvv95qnK4jOoAMENKlepIqvf8arudfx
	+/DHaslkd1M++jDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NybDqcMH4iwP2OSDbcuX3AOpTQ8MRyAWQJkqxCJurY=;
	b=uYVYDwvoQCsDFOvgZAlhNis8JrbQ3DcVJwSaJbtNPqId9kaQC1NeiYd4bmQnl7gv1rzG5V
	fvDtHO04Wxk7UJPo+kZLELwZSD9cEkR6j71G2mxp/iugEbxeMKih2qfMebVUy2y6xS7FZC
	jUwpmDgtD8skLngVOMur1tIqVlPD61Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NybDqcMH4iwP2OSDbcuX3AOpTQ8MRyAWQJkqxCJurY=;
	b=QHiqrz6MUuYH+Nr2/hp2PjYAVREofjAL4N+po7YTvv95qnK4jOoAMENKlepIqvf8arudfx
	+/DHaslkd1M++jDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57CB81393C;
	Tue,  4 Mar 2025 06:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CEZnBF+ZxmfADQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Mar 2025 06:10:39 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 3/8] vsprintf: add simple_strntoul
Date: Tue,  4 Mar 2025 16:57:46 +1100
Message-ID: <20250304061020.9815-4-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304061020.9815-1-ddiss@suse.de>
References: <20250304061020.9815-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

cpio extraction currently does a memcpy to ensure that the archive hex
fields are null terminated for simple_strtoul(). simple_strntoul() will
allow us to avoid the memcpy.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 include/linux/kstrtox.h | 1 +
 lib/vsprintf.c          | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 7fcf29a4e0de4..6ea897222af1d 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -143,6 +143,7 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  */
 
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
+extern unsigned long simple_strntoul(const char *,char **,unsigned int,size_t);
 extern long simple_strtol(const char *,char **,unsigned int);
 extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
 extern long long simple_strtoll(const char *,char **,unsigned int);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 56fe963192926..734bd70c8b9b3 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -114,6 +114,13 @@ unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
 }
 EXPORT_SYMBOL(simple_strtoul);
 
+unsigned long simple_strntoul(const char *cp, char **endp, unsigned int base,
+			      size_t max_chars)
+{
+	return simple_strntoull(cp, endp, base, max_chars);
+}
+EXPORT_SYMBOL(simple_strntoul);
+
 /**
  * simple_strtol - convert a string to a signed long
  * @cp: The start of the string
-- 
2.43.0


