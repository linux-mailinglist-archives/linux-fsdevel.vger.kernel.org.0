Return-Path: <linux-fsdevel+bounces-76538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEFeDYGDhWmqCwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:00:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D92FFA831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2AE6300698E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A52F6174;
	Fri,  6 Feb 2026 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXZjmq3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4056288C30
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357627; cv=none; b=prjZc88rsIr1ygRt84/uZRGmAoKVfbEj7ih08XSFo1NwVZv6nMKjhBH0waUlTePvTLZupcJBfqpz4U911shC24ypL2BxFTv4kALMocFwEPdgJKpQkFq2B98+Ia3XdmRKQeQ6DoOgmdFvRVl91cQhFCeIhi5zmjyloNGy/JqILw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357627; c=relaxed/simple;
	bh=jBI6HT3dHVlMON1n1A+XOBIqCR7gFdqkGMxDCRYAsQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqL2Cfj8vcy8VQHDIG/0MChaCvgdTdpzvyyLB6S36eG8WxsgEJOy/ZZmuklTqMm7SUaTxJhoIuV9tqiRAR4GVmK3KUjLqDlkpdOIH3PLUHKZmC8vWhqO+gwlel/6CB3YBbuDRfcR23u1Lu1VfmHtwY9c6XEGRt1+ElRqCDzWVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXZjmq3z; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43596062728so1959656f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 22:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770357625; x=1770962425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OyN61TH23iCLAYiwVdUL99gnCl6r1b7F5YSnzJ7pNI=;
        b=XXZjmq3zPUMrIBm5sDdL0QNT1PWavNbYXgeNfQPCc8JSTTdymUmme0fCpYUXuBeoV2
         mLbH/mhWGg9xgbZzhdT7tSs4oGsO6kQxXn1+rBd+oJj4LDI3n/eR3lNc+H1Sikt1DA/7
         gHePNmJn8oOsT7jZJg4S6fFylXjlcXg5rOK0y+ZKdCAKKxnZeMZ+HRJrz/M+Hw/Wlmkz
         4UdlJRKp9fjx6PpfkImY869Y+KRrdrRJgeBwNYd2kkavrC9PXsX94wDVyNc/CGCEZDPN
         wa2RnfEUWut49VOni9QvUvpPzKild6fOxNhpfeEYSXtGqfq7Xgu8l0hZJsBds3fFMyKA
         3tEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770357625; x=1770962425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/OyN61TH23iCLAYiwVdUL99gnCl6r1b7F5YSnzJ7pNI=;
        b=gkUxIkrwXrvKduWZG75/X00LqxwxX4gBzh5Us2wHgj6oTW5JgDdnXHni1KfY6/Os85
         mzi058XrBEVZu3PGmf1e57MIVekKsW5sEuHgbc58dmjIqYgnjNr1T2lDK+Q58NHs0tgO
         dd/8zDrSptiznZTdpcK00g3rzTXhdRoZkciLyKycu9HSa8xcwu4nQxM6jljs/puzOjrj
         KAzLSXXYeasmbvjtN3jyCfhGva/kIXzRkYU5G6ibJDazdyFYnzECA5ERI1uIR96OKkDq
         vpjkUe6QWGHMiAU/HWoCZlqouErn+ZnH/kggg2z5bDzbGk0w63KOg0y6N41ZSGXuEdRf
         KpLw==
X-Gm-Message-State: AOJu0YzTipdQGBkeS+ruPCxlMgMFjGqhDPKfFrcet8MY/sfeZGhov15S
	hF/dIjESpIBbb4l6ILz2GOEW862ugP0aMZbcYK9K9F5helaBgfJQVAzT
X-Gm-Gg: AZuq6aJJZGnbWKX07wVPwI2NPXDjq8vml0+07bd9IVIsUL1G3kB0Nqu3SDWy9hjLl3Q
	KKqI6aU9cmkU1tKJTBUsK2ZCeg8fAIhm+NcroX8S8Mun3BWq28C5sjW3Bsdp3+RKAzy561cOtKi
	QjNxaNmgaJv0POfsfiyyHNtAUHvohGWRBSYMQmN4jvjfGKyMEQCRBhOF5i3O09LiQlP6gjWCkeK
	/7jXyrEGqNDFBWa8HTIVeRngtxgPKmox3eIhR/Qivcfaj3ChEoHzKngoVKAPJfnohf1I46t9k5T
	JXzlY7Mxh2BHFsJqgl2DEzHeLyVt3W8j//Y5y3LMro7Ediiq+gCBrvCKpsTYwyW9W4PaJRKykxi
	yKWHxALZpMpruu1j7BELjnNMHlJMVNG9AtUa1ttYbzUp8e8bSV2goUEYs1k5GgJiVM87H/9mSI/
	HHfGiaOfmkH/gDfWuW3Tm8d6JrJO6fXcLWOJq8Iw==
X-Received: by 2002:a05:6000:2404:b0:435:953e:5897 with SMTP id ffacd0b85a97d-436209c998cmr8437900f8f.25.1770357624959;
        Thu, 05 Feb 2026 22:00:24 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd3fdsm3256873f8f.16.2026.02.05.22.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 22:00:24 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] KMSAN: uninit-value in fuse_fileattr_get
Date: Fri,  6 Feb 2026 14:00:17 +0800
Message-Id: <20260206060017.1208322-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <698561f9.a00a0220.34fa92.0022.GAE@google.com>
References: <698561f9.a00a0220.34fa92.0022.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76538-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,7c31755f2cea07838b0c];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5D92FFA831
X-Rspamd-Action: no action

#syz test

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e94..8b5565cbccb0 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -377,7 +377,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	struct filename *name __free(putname) = NULL;
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);


