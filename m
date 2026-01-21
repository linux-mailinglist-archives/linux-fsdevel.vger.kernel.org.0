Return-Path: <linux-fsdevel+bounces-74782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPYEH8NycGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:31:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E100D52146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 015E04EDF7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90DB449EA6;
	Wed, 21 Jan 2026 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eATw6xKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBA42EEBB
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977079; cv=none; b=q3foqh1Tx+7F6HMYpVgYp49eIasHtnCIPGtVoiulsLb0WF96bGMW96TthQYm6pTwjdS0RS9ZMvQObQCSWnvbK7S13d8pL7St4Ua8J5yNmWy6Zj7S3YnHxguCw66pE/7SaJbz2idZQJfPTgXv5+PXrjp1f3V8vF54hlwoEOrPlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977079; c=relaxed/simple;
	bh=10IIxeBpOmbtDtny4F9jlFEYN9gHuP7Hs3r2Spr9jDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8q7XXtwUB0qdYbEp+Du9sdPAT5/ZhmsqR2E/jP1cKjZgos9kWGF/PY9kTmb7Tlop0zmQekWzUGnSDf4rGbQL4SmHAMLmudAaiRvFWa5txUuUsqekNvItCLFeal/Bvmwt7XXV68FNB7QfVfhltsSsYmNZLBRqf8PmIAljSAzSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eATw6xKN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f30233d8aso41031385ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768977076; x=1769581876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzWJlQOGK7PP500ykt7DBzIMtyiEntcVzChvAEYBZDg=;
        b=eATw6xKNatEeVYy/rPMLfSdOs1IFIOdcTGvpsGK/6fMsbx47iQN30NjBXKssxuEol8
         da7NkOv5Kq4sYLvuFqUmWTquVWW8EgYeHI/d4z2rXld+fNIy+lnbo+Nsw6Pud9ztAgGe
         xh/ipnz+sU+Rp4YdTQsc82BtIy+M34vBij+ZEqmvbc6cDzI9olUqPD3o1yVMvK50RhBC
         Z95AESZ17nxH4yMmFgsTAcRK8X2pCZnBNP3qRpVCjKaATFY8HOPAS7gMcX3KuMgeT8w5
         QYoWC9Qm7WjnhMIaMLHasp8aIY033moGRq30m+xP8YAcMk+kuCeAafVv/4JRtjvnwyY1
         SddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768977077; x=1769581877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzWJlQOGK7PP500ykt7DBzIMtyiEntcVzChvAEYBZDg=;
        b=kQeWXC2KV+72YbvPGCI8whjjpmzcpLrtynh2E57ZaliGUW9jSE/cjilyrLHRwkhOgt
         7kKefFs1nm8ncqgieOx4CdmAgRiAl9H6XZlvRAWgXscWrY5An6fgY/grmMrYP6gDdenW
         5evBig4jTuE+bXTALMSeJbfCwolxSKs5Z5iYOQvN/7UjTdHQSOr3GCO+g0WspjninVrr
         FYSIxv4WZZpemgGKcEtY5D+ygt/WTo3qwISIxuPMwnEczyM8dX9RVoY3Ig5PDGVe7GXf
         y9S9Jqx2as5Wkj8ZKZcu01vyi1YtW1+DIRHqrRr2/Q6HHekK7cZU178HDzGLWLm/HXPl
         Psbw==
X-Gm-Message-State: AOJu0Yx4m3dA9TZG7ufE3CYJO45H6ZH6/7f/5FYWvS0IM0WvrvUU4h5q
	WtkS/1IWfVJ1koiWuMef9g87fr9fHx41OlCwRbYXecYlVof0r6D+Iy17
X-Gm-Gg: AZuq6aKTeQThGMFbwG2xpthwJ2i6moZwWvJT6clX1DXedU0PBqVCzIE24XTGZ4qQyHs
	ivv6+FWEBCWj9/gZaNnnFWz7ly4Vluu5brZ2RojspZpbfrPgSc8JNW9XrvE/GRuYyqgrgSMh3gN
	iRb/fIgQ1amOYBm+oCKQpLerenpxhkGMpPS9Yd0GQkMPVrXTdqVZ0LVADiSROkeG9nuSn2EsSvI
	eNeyTZITPQ0oGxGYXxg0j01O8mLS9P3HjDtkp2lvCzidcTPROz500hfgaREgdKyRhQKcF5QBQ4r
	MALpTlNLD91mfrByMMTm+JzuwTPCzhFqA14oMg/hC5cTLatIm0IYOZOyF+2nKQnpeWpeBBJrP83
	CRj6r817Q4YFprXeUZd9gf77Cb7n1W6eqPqUCzehEkSQSNfKLTLh4JjF6eaG1Ym0JuDGhcYqMKd
	FcUWcjxy4TSedyjUuUk0tFRpigF0+qXHBwn0SDx70ziYh1iu1L+xOA7iOoMirt62rAhw==
X-Received: by 2002:a17:903:17c3:b0:2a0:fe9f:1884 with SMTP id d9443c01a7336-2a718973282mr149691925ad.55.1768977076504;
        Tue, 20 Jan 2026 22:31:16 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:efe:9255:b6ce:79ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a718f79f40sm142007965ad.0.2026.01.20.22.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 22:31:15 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Subject: [PATCH v2] hfsplus: fix uninit-value in hfsplus_strcasecmp
Date: Wed, 21 Jan 2026 12:01:09 +0530
Message-ID: <20260121063109.1830263-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74782-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E100D52146
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Syzbot reported a KMSAN uninit-value issue in hfsplus_strcasecmp() during
filesystem mount operations. The root cause is that hfsplus_find_cat()
declares a local hfsplus_cat_entry variable without initialization before
passing it to hfs_brec_read().

When the filesystem image is corrupted or malformed (as syzbot fuzzes),
hfs_brec_read() may read less data than sizeof(hfsplus_cat_entry). In such
cases, the tmp.thread.nodeName.unicode array may only be partially filled,
leaving remaining bytes uninitialized.

hfsplus_cat_build_key_uni() then copies from this array based on
nodeName.length. If the on-disk length field is corrupted or the array
wasn't fully written by hfs_brec_read(), uninitialized stack data gets
copied into the search key. When hfsplus_strcasecmp() subsequently reads
these uninitialized bytes and uses them in case_fold() as an array index
into hfsplus_case_fold_table, KMSAN detects the use of uninitialized values.

Fix this by initializing tmp to zero, ensuring that even with corrupted
filesystem images, no uninitialized data is propagated.

Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d80abb5b890d39261e72
Tested-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/all/20260120051114.1281285-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Use structure initialization (= {0}) instead of memset() as suggested
  by Viacheslav Dubeyko
- Improved commit message to clarify how uninitialized data is used
---
 fs/hfsplus/catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 02c1eee4a4b8..56a53d2d437e 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -194,7 +194,7 @@ static int hfsplus_fill_cat_thread(struct super_block *sb,
 int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 		     struct hfs_find_data *fd)
 {
-	hfsplus_cat_entry tmp;
+	hfsplus_cat_entry tmp = {0};
 	int err;
 	u16 type;
 
-- 
2.43.0


