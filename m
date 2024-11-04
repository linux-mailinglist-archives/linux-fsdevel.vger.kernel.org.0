Return-Path: <linux-fsdevel+bounces-33605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BBD9BB765
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE091C23A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39CD13B2A5;
	Mon,  4 Nov 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1ZqL7pYa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AR3zQnAv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1ZqL7pYa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AR3zQnAv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F264502B
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729897; cv=none; b=k57FqQjz635ARy8teNp+ZyWtkKSEW6B79H9C0LuHHHxZLAD9yKNXowfGhFsHSnOdqlUGhslopGN3pQ2RoKNPU1Y7NzJgTtvSCqfnMSSxMOKHUgFxfKFKLq7Wd7mz1opsgsxL0G5yt0scD38d+zGBEhCkekyf33K3QQ1upmXWyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729897; c=relaxed/simple;
	bh=kin+740lwCcp0CyjC81Xi4YNGVv3eLKrz5FJ9ljjtow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bp6/p5aVL87cJwOF8w4C7A7O6NHmNe03RtADJPoFgUF1MX7vOVHUiYmLTww+OPC1z2Yd2F9fM/qV2nIIu3Nk1J7X25QYKBUb6fpiET46SyjDmngKjFJmDUr0qzggho1CQlH1K60FEDukowOmO1MsjFSwRBFIPru5yLdZlUTU+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1ZqL7pYa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AR3zQnAv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1ZqL7pYa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AR3zQnAv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6127721B76;
	Mon,  4 Nov 2024 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEG6935H9x4NKordwMC2IWMDILAy9SobUxfDfYQ3qnE=;
	b=1ZqL7pYaizAvgoVBXkS9W4fT1vHz43/kt83lDh6ocgCsXT8XgK8oFQrYzw2zfZNKz3HcEm
	y/LswvmaiYNw3ZloaxHPaktrvjD+0C267IZO4/pFhyG9R5gptJlc6a3rcRS0dCv5rmNLM+
	9vkVqqey5mAAro6sAPTsejiIKsWZ/dY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEG6935H9x4NKordwMC2IWMDILAy9SobUxfDfYQ3qnE=;
	b=AR3zQnAvuh8kvHa5HCgvdPwik71DQuRx7V1uhRf9tsbD3xCQsf/v3G3KyIFG0sFngvux/W
	dB3BkPy6IlvhHuCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEG6935H9x4NKordwMC2IWMDILAy9SobUxfDfYQ3qnE=;
	b=1ZqL7pYaizAvgoVBXkS9W4fT1vHz43/kt83lDh6ocgCsXT8XgK8oFQrYzw2zfZNKz3HcEm
	y/LswvmaiYNw3ZloaxHPaktrvjD+0C267IZO4/pFhyG9R5gptJlc6a3rcRS0dCv5rmNLM+
	9vkVqqey5mAAro6sAPTsejiIKsWZ/dY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEG6935H9x4NKordwMC2IWMDILAy9SobUxfDfYQ3qnE=;
	b=AR3zQnAvuh8kvHa5HCgvdPwik71DQuRx7V1uhRf9tsbD3xCQsf/v3G3KyIFG0sFngvux/W
	dB3BkPy6IlvhHuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ED961373E;
	Mon,  4 Nov 2024 14:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aIkgEaHXKGfGfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 04 Nov 2024 14:18:09 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 3/9] vsprintf: add simple_strntoul
Date: Tue,  5 Nov 2024 01:14:42 +1100
Message-ID: <20241104141750.16119-4-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104141750.16119-1-ddiss@suse.de>
References: <20241104141750.16119-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
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
index c5e2ec9303c5d..32eacaae97990 100644
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


