Return-Path: <linux-fsdevel+bounces-76335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NKLLNt8g2nyngMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:07:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B718EACDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75A953033E60
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF81347FDF;
	Wed,  4 Feb 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7L7Efja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96932D7EC
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224689; cv=none; b=BmZx+SbeSxqO79cCgkcpKrCNiJxXwCZyzqQGR8CFhsNBooVKyvJzaxr8tKrjSxpAmhr9a6J7/++1AZPqeVfLec+anwjw18m3VPl/LUL8E1KssJqsZd5Gr1fjN8TcrpbmhaNfcBA8pnSz+YaemUnHiMdy8AAPzoXiaB9PzDX4S2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224689; c=relaxed/simple;
	bh=mS8ucGBIHUUezgKGb/Wwgx1gKfIn4MGKPBvztxbPqso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FpW4E5DBeJiP3KCK+q1YnxIhbU5BvGJ+YW8zdJNa6HAYhloLJoYWGHbDq1ee9aN4gTT9cZWki/gC0CtyE3DA6VZz486Puq5VP4hHTjWFZhrbF4nqeun4iv0RAokDU4EmJDhjJ+Rze6whzzXlbQ+pLmPziEnVSsZkX7wNNzInR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7L7Efja; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so99401a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 09:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770224689; x=1770829489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJXubc+4+ghfE0A3GdnWkOuxt7SnmFexVx7zQStwRMo=;
        b=S7L7EfjazHC7UTOXnPEHp384D6NgdJ5K9BRnV8gjhT8vM6dbIu9IvkGIVak6Uz2UBa
         6ZE/kDRZYCp7+OAKD44x1aKZjCiGvWZsrmftILN7iFUnSRzQnQWjC0cJe/7JMhAFwhIU
         XZF7KBMOBD7oE/ekO0hJg9DRHqVCWcKtrw9RBIVULui+Z4K04jjyxe9ATP9Iu+ypxH47
         FPX75Kx45c84uFb7amJJobw8aJQpvS/tTQETFwYS2ddK6phwOH4CJqgT4EyfW32WLEg+
         vbut+MxBQptlJgl8EUCGFLy5tbRlJMi4GZIPqho7ZVmZ+la1AKrnn40qGNrp1ZMl5J5O
         fnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224689; x=1770829489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJXubc+4+ghfE0A3GdnWkOuxt7SnmFexVx7zQStwRMo=;
        b=BhrI7VNXEH1Oh2VlYIc3AVqpjNNbi9jSJpNgbp0a2O2MqcdM5SHvq8XMZZQLjaJ6Rz
         TCK2fVFxCU5fmjyBGccMzsVmULH81z5THVIDVqvLVYT8Hst3mlMJpKAxyJEId38v8r9N
         dR+6SQluJtnID74vytK56p1lAMPB4fjWxZp0XPpKyCFg+5tS2bO9fj1FxVuqWdDQflbe
         3Q5rbkdTY9M1EtNpkd9k5tKc4aFZyaKQdZQDXBfDAfNNY3++7s5Fkc0ah2fbDV3lWK60
         Uxaslsa4lwzmNmM+lxPUbtNqkbe9u3+gchmg6e6bZm5RwJmwWyopLAFsDRL/gL50AvnH
         /AFA==
X-Forwarded-Encrypted: i=1; AJvYcCU63sGhQvZksm0J1dKPHkooRmH22J59SNyRoTcORLKrpXyHX3CYbllOw5//Kh+DtnlWYi2IWiHoDo1wq+lS@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwseywP5o4gq1E2PHiHq0uwjbt5e4ViBIDoKRcp1t11Ou8EeW
	ZnXU8BCXFMB2JuZkqNzOP8lU1NPktiOT0Z7T+DVyGsMHLpnQkfFl4ZX5
X-Gm-Gg: AZuq6aJnlDGDGkkS2rRZlYqrsJLgWS5AxjuuC2QU3lOfaeB2IALha9aUyhWkwFhXhcI
	qG0atmCKcfyxLQg/RioV6tLo+vz1mmQR18bBKaBuFCOasZg6Ygxrgf9FISeqAkPKJD6cKTiNjzz
	QtRfMNu88vzk57n2/ANOdkHJSaj+UVWN92ACbOp8Pn08xErCA81kliMq80kfoE2GC5VXcBOX5kp
	xDmVahPbrpJlhTfgtrLHTRVnQcsYzDnbYOhTqIqaZpBlnGqqBcd44//TINqGMTKuqbdwh7XLvQM
	Jr7V9iA+HFoxgH012lXK7pwgtg8PJreJZ6V11hgE8mhmTlupmYgJYz6cE+vtqLeOzz/lDj7NMcJ
	/gX1rkv9GNWdm0kLI/MAXchq7qngyEtv4f0GzJqKdAWOGaVaC4QqV64JEAh77HWbqDlhT4p0LTk
	sseW0VCn75cGg8cXYcigDx+dBri+RncBvmJBQN9HtytWlm6HpkaA==
X-Received: by 2002:a17:90b:5107:b0:354:7be4:a250 with SMTP id 98e67ed59e1d1-35487103011mr3417685a91.12.1770224688505;
        Wed, 04 Feb 2026 09:04:48 -0800 (PST)
Received: from Shardul.tailddf38c.ts.net ([223.185.43.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35485dc6b7asm3286397a91.5.2026.02.04.09.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:04:47 -0800 (PST)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	brauner@kernel.org,
	janak@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH] hfsplus: avoid double unload_nls() on mount failure
Date: Wed,  4 Feb 2026 22:34:40 +0530
Message-Id: <20260204170440.1337261-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4375f20e2b0d3507a0209f7129e00d360d3eb32c.camel@mpiricsoftware.com>
References: <4375f20e2b0d3507a0209f7129e00d360d3eb32c.camel@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76335-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,mpiricsoftware.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2B718EACDD
X-Rspamd-Action: no action

The recent commit "hfsplus: ensure sb->s_fs_info is always cleaned up"
[1] introduced a custom ->kill_sb() handler (hfsplus_kill_super) that
cleans up the s_fs_info structure (including the NLS table) on
superblock destruction.

However, the error handling path in hfsplus_fill_super() still calls
unload_nls() before returning an error. Since the VFS layer calls
->kill_sb() when fill_super fails, this results in unload_nls() being
called twice for the same sbi->nls pointer: once in hfsplus_fill_super()
and again in hfsplus_kill_super() (via delayed_free).

Remove the explicit unload_nls() call from the error path in
hfsplus_fill_super() to rely solely on the cleanup in ->kill_sb().

[1] https://lore.kernel.org/r/20251201222843.82310-3-mehdi.benhadjkhelifa@gmail.com/

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20260203043806.GF3183987@ZenIV/
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 829c8ac2639c..5ba26404f504 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -646,7 +646,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
 out_unload_nls:
-	unload_nls(sbi->nls);
 	unload_nls(nls);
 	return err;
 }
-- 
2.34.1


