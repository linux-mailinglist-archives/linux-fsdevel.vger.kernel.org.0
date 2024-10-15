Return-Path: <linux-fsdevel+bounces-31982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061E999ED88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7CB1F212FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F81AF0AF;
	Tue, 15 Oct 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fqLZqUds";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fg6zJk2D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3Glv2v6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8Pl2yyvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5A14EC47
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999032; cv=none; b=BPBZfJ7A7O/wLK+c/J01si815650gNFJK0X7kNGuE2HDQzC0cdFmfo6o5sYARozocnOscxwZmBfvraEhMA5KIHj2K717M+vLkkGzhN9R3FvMA5FQZBfkTp/sXD5ALWD5j6Yxgz29lEZNv7C6BN2M9wxK9VFOZ3NwfL3XpYIWgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999032; c=relaxed/simple;
	bh=kin+740lwCcp0CyjC81Xi4YNGVv3eLKrz5FJ9ljjtow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmbAMcEWuKmpQ8L39cEVSboQJTmek+vf50X52jRQK3EwS86QOyeDVzjXFlH4YMzdRLRM1LDAhiifqfwTe+Lo10ZYOcL6eEFq/0uc2Ql61DGVnWvwfAiWsgiNGsLu79oV/hO+QPPI3TgZQW1/FfCFKq+0fY7cT7HijSKzIf/+DFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fqLZqUds; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fg6zJk2D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3Glv2v6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8Pl2yyvT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB0371FE44;
	Tue, 15 Oct 2024 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEG6935H9x4NKordwMC2IWMDILAy9SobUxfDfYQ3qnE=;
	b=fqLZqUdsgmsE4z0isWVgv1jFHsvishQGJBjpYHpfl1lmb6yfGAm5OgmfC4cgx2z7BSGyAn
	rGLEfm5BuR1OmAtrzw3bQoVS6XyMr/EPH5qz0uZrBnPsabgQwBNMu6gHyBWA8WUaj1WFHz
	FkS0O77L3Wjedav2svmq2YSj/0weXkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEG6935H9x4NKordwMC2IWMDILAy9SobUxfDfYQ3qnE=;
	b=Fg6zJk2DTfLXTDTUbQ4yypy54SMi48xHAUtIp57TD3Z1Rk0mAV9kPl4kW3ZuTxLvhVRWc8
	UZKp1suNWoFCfECg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEG6935H9x4NKordwMC2IWMDILAy9SobUxfDfYQ3qnE=;
	b=u3Glv2v6ixg/QlP2u2MV681c2m0DNRhAWTeaOyGoPqrQvt2oWBIoTFrfKeo/dr1eUi0U/k
	Cew8CTBbM1nmYwf8a5gQxuXjQWnYwtVYUS+SMH2ffpv9fk02EtPPebjsb3m2/I18wnd/Df
	tJ8FdNWDb87JxEybrAGIrJVptoniDgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEG6935H9x4NKordwMC2IWMDILAy9SobUxfDfYQ3qnE=;
	b=8Pl2yyvTPbJzCKUjK+oq1I2nG66BfjANvVXamqCghntmh4LJKMv8dOZrEpqE9quZaCI6PX
	5H/t5Hfr/HEjKdAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AEC513A42;
	Tue, 15 Oct 2024 13:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GGbyL3JuDmcvcgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 15 Oct 2024 13:30:26 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 1/6] vsprintf: add simple_strntoul
Date: Tue, 15 Oct 2024 13:11:58 +0000
Message-ID: <20241015133016.23468-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015133016.23468-1-ddiss@suse.de>
References: <20241015133016.23468-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

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


