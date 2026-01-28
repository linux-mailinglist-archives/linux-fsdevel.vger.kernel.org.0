Return-Path: <linux-fsdevel+bounces-75721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIsmLgAOemmS2AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:24:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9351FA2131
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 034093006015
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AB352FAC;
	Wed, 28 Jan 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7nt6ktY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95009352C48
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606652; cv=none; b=DUoYMpkIalQ9D5JGNP1WUNni8iqDzXUTozS9uQ2thz9EJvajtryRWNJv7/FMP6AvJA6l+toqgB9/pbZUTDoAq3rMS8Cpue07HJY5nVr4GUg0UK5DBcR8m79bKeau4EO98h2oGyiRgfH+W8Io197+JTEkYCBmQNqcIPZfrnRf344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606652; c=relaxed/simple;
	bh=by5c7OBWmvzWhVys6tF6T+VYllXJ1/+r8xSpNq3nuBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtdrvhDHjX1FuDb1TXSif5XewDwUxIhJz4W/lQlySG36naqg6w1yORajhlsEY7tTuwGSkyqtXjvk10aHQa2lomr3p6vbdI3/VNLHi6ZtM2AaMnAbmU07pBMj8KB0TNGqZJK5O/OZLwy7VH+5JlxmNbW6qIuYWY8bKSdh51OF1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7nt6ktY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-658b5e57584so1810884a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 05:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769606649; x=1770211449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxRM277namVFNLdkVHTNF4KV4lqJB7EgGMx8/qf8f94=;
        b=W7nt6ktYD1RiYz7pLN3PILLQbdb08/u009q6bRnAlNJiVOEJHRL0t1SR22otnk1NOC
         R2+KUUGfOWhX931UJKyosaYw2rNAzzXfb+Wfo+bxZWeW2FQRLcIlBfSOyaIPZqrGLKtY
         Y9CEKp+y3CrTHht6gaBKb/4cprKUfaF4iFMbIi1kXePlPeTgFgZbPZvTKwwSuVH14EyW
         hzNK5NDI5N/QoOoVjPlcgLd06+aFpLLNX1nmV2mcfqynHEKWf53Hpg+ilU8gPxVP7LBZ
         J747uuQqwoxIUG9shomO9o5KIt1eP1a4GFNZaJ59P+5blXfNNIc+V8ZEGoKVbdsD3Ifw
         eBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769606649; x=1770211449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kxRM277namVFNLdkVHTNF4KV4lqJB7EgGMx8/qf8f94=;
        b=I9Q15+vAnXoUoeIDNfaFvdPgvz/2mct9B1Sxzd4mVACJB8ZjEdicGH+ChMkpoaSiip
         GjgYlazrSY37oC36EjJ2+ZA/+TZyGhM0U5SSI6rnG35Q7leEaVj3sAky7Ly/uligxz6K
         Vp8nBkodE1hFiN7kye4cX44zz6+Jr8YWVnaNBeAc+4UeCEdM3n5jcOegoMf6ExJl+NP7
         9ToSUWpi4E/dQ7FSHh8IfC89VDkBArjDr96zwRnbOHnRlUimLsYZ3jsvsxoKL/YAySbv
         60QGASQ/83u8Wwy1AUgW+yQiVwFAizSuc2Volax82py77APzv9TrrHGGhGuGEdue/XG7
         jJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUggP1Y68HolpgCaDM/2OscPXnAdgLAPvGNjZrpTxZm0qvzgscLDTV6cnvheD15kNwJe7frqEseVVpM6aOz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CbRYsiNRqPuhdLhkWrbx+ONDsHaRpI2I94f6XHuKK3dVJH7z
	gE0Avra4eaLHDjPQGNErUdLw7PCW5x7qVQnmN/jdszosCib7j8AXObDt
X-Gm-Gg: AZuq6aLfnkQJrNajSMxycL9WcE2ZTmhXx86gS26Zd3fkYV5rb8GmAmh1qWhvfaqZDXi
	Vof5UTY4JzkwwQn9VwVx6k1QhKWiQv86CgnHWfsYdCNcoawkzuAz859Uj3UxQIyHs7S+eTAhM2k
	ebed1VnL1YJBOsyqOu1pmkq+e6E6d8HMbZL3ABKoLALFZrfzAiisj3mEX/GL88O46baHa7ItjBc
	g0Y3QNkyfPbtXQ08aqNxPl90klxD78Yh5IloSSwky/5WxcoDBeb0ZClTCwNeq1T36NryhLZcA5n
	UEbT8CiLcKok8Xj7CKmz+e6Umm0/MBSD2iPVhpaG8ijfQLbUTHqR/D2PVblz0qP/l/I8M+S3d7k
	DWaq7jFwh68jHXecmGp4ukCGQaWNS4i0KfH+OHMQkhZgDVCETBRCRrcPfRjftgTSBimRnFtHskk
	g43nYlsHhDkT+254ezSj/Dc8RG/cR7ElzPTT8VZFXSvQBuupmmwJUUTNb9G1sAg8GAgpJMBIVrF
	8jDML9xiBAEjmOnRLujxToVYmk=
X-Received: by 2002:a17:907:6d0a:b0:b87:1c74:a8c6 with SMTP id a640c23a62f3a-b8dab3f022dmr389917666b.57.1769606648807;
        Wed, 28 Jan 2026 05:24:08 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-c84e-f30e-bdab-df5a.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:c84e:f30e:bdab:df5a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf184343sm122306466b.33.2026.01.28.05.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:24:08 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: Qing Wang <wangqing7171@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	syzbot+d130f98b2c265fae5297@syzkaller.appspotmail.com
Subject: [PATCH 1/3] ovl: Fix uninit-value in ovl_fill_real
Date: Wed, 28 Jan 2026 14:24:04 +0100
Message-ID: <20260128132406.23768-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128132406.23768-1-amir73il@gmail.com>
References: <20260128132406.23768-1-amir73il@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-75721-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel,d130f98b2c265fae5297];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 9351FA2131
X-Rspamd-Action: no action

From: Qing Wang <wangqing7171@gmail.com>

Syzbot reported a KMSAN uninit-value issue in ovl_fill_real.

This iusse's call chain is:
__do_sys_getdents64()
    -> iterate_dir()
        ...
            -> ext4_readdir()
                -> fscrypt_fname_alloc_buffer() // alloc
                -> fscrypt_fname_disk_to_usr // write without tail '\0'
                -> dir_emit()
                    -> ovl_fill_real() // read by strcmp()

The string is used to store the decrypted directory entry name for an
encrypted inode. As shown in the call chain, fscrypt_fname_disk_to_usr()
write it without null-terminate. However, ovl_fill_real() uses strcmp() to
compare the name against "..", which assumes a null-terminated string and
may trigger a KMSAN uninit-value warning when the buffer tail contains
uninit data.

Reported-by: syzbot+d130f98b2c265fae5297@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d130f98b2c265fae5297
Fixes: 4edb83bb1041 ("ovl: constant d_ino for non-merge dirs")
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/readdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 160960bb0ad0b..724ec9d93fc82 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -755,7 +755,7 @@ static bool ovl_fill_real(struct dir_context *ctx, const char *name,
 	struct dir_context *orig_ctx = rdt->orig_ctx;
 	bool res;
 
-	if (rdt->parent_ino && strcmp(name, "..") == 0) {
+	if (rdt->parent_ino && namelen == 2 && !strncmp(name, "..", 2)) {
 		ino = rdt->parent_ino;
 	} else if (rdt->cache) {
 		struct ovl_cache_entry *p;
-- 
2.52.0


