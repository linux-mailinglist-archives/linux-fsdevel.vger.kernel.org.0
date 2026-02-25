Return-Path: <linux-fsdevel+bounces-78402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPyRNs92n2nScAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:25:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEEC19E3FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9E70302DAAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3B330654;
	Wed, 25 Feb 2026 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjhj+aem"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6832EACF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058315; cv=none; b=uluQSmIDC0MjDOUP5JqSVtZ6PyfXcFaKvxdzQYK+9QER9nicx03BcPxfnCiJwa8SKCtv0BwC5rnaoFah/VEn8Z0aKL1fVJeGoTBDm4JxSECtO7g3h+4k36NV70XNJ85dVSK9uYBm021AoqOUgJb+Ek65QEr7ENky2XS64b8EzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058315; c=relaxed/simple;
	bh=SDcDYk56vSzLpnVonbCSc5DsGoX55CWSFB0SpTZnEAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmJefE/8Q90VyRSWszd4ZLqLtpZ+jWSlQkUM6bq62wRDtd9DSVTgB/mL+ZvpwfDIg5mD4yCZ48rfk/OB+fKDYMlhTAQDwRvwARDZeUObTLt+qh9dZgG07J7PinF4p0CHaGRxH/5h1RVQfyRGVUoet5t+e1GWaI1V8Db/hN++6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjhj+aem; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7986a347d4bso1877097b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 14:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772058313; x=1772663113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvvULsvPu1X90l0TH4lOXBcqCmc3q2PIWwDNbIUTe30=;
        b=Jjhj+aem+9oG0ScvtxMw1OFlfTpB2QGT6H9ZbpyrrPWMYpZWjVDF2ay8uBYHchCB/9
         RXDaLqgGn+VBUIwIbKdtSKW+yqYn2FfS1ele4PwSQDNwpnIigqLFNWvQb/cJwwRg53Y6
         ZjpzaNj/KJxJoPZofT5OcL2Tnh+VdYhJTg3S7GeenoDaAHlT+/Z0bfIGgKLm1fHiHcNg
         NsiS//F7NuHMwKI+TVQ4JMBZLmlwHjYdwm+Ezx7aLbjTs3CE4jT+idsHcPFxXIjUNoEi
         pLvcT9EKLRgp6WriGugJ0mDh4RpMN5llVlY880sGQA8E6RzEb5MXoy6K9jPY5zK3V5jz
         xvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058313; x=1772663113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvvULsvPu1X90l0TH4lOXBcqCmc3q2PIWwDNbIUTe30=;
        b=VJ1R9hxczWdqjg/sM+wJwp5neeFgnXMUAUGzfgC5HpwkRinSLcM7bgB0ax4evmRtCf
         Er4YWK/+0gDd3WRhncerh1xAWZPQ06S2/pTw/qG3zTLxr8zaRsRKAd67+gBpZESn1g/S
         EqtPstJ9sVIHPG/NLwu+/jTVMQgcaf4UKxKwyq08Re59kwBIti2a34mQNLIFsWzSToOy
         t+mlxyrjymXUBeO4ZNurC7JCtM10BJcTUD5x2BmVnRsNeyOfBdHZIsudjl99npmtmLqs
         vBrZq7JQDF1CjCb1kf/mQNZegrnfEbqwsgw4NqrYvl1fyJiOEzp4rmJ0vFuREPtJu5BP
         JM7A==
X-Gm-Message-State: AOJu0YwR8HRfurs68lETCX8EXTl2JRWNW0usWACu0zMK8Xgoq6I0WkPA
	wLXYPdoFlaPUZLno8eXZYG7n67cpnEtajzXLIKk16X/8QqvGvunCH/eq
X-Gm-Gg: ATEYQzzxmUFsH4coii9MSVFlQRkQeSVhm08iUCiIHGd/xJgDkB1HZTPFKzz2sft87mV
	01Axkxe6+yUQVp5hVbXtIpGYzKsD8oKfmQPlOuJ3uZj6OSZ1npGU3rSinVTpyDFyNgXCw7DTf1L
	kWw4AQHvYDrQrvaFY5z/6TrehRWnPJTKg/fTkUWqx7Qycezovlx7obo2OvCAmmE2NT2NCprMXU1
	Fg5x2KDMFaCH+WP9WXoBQejuIAyfM9KB7y39nr+PRbCJgqhXM1hs6CdrwIiIabbWQBQNxzYltwD
	Og7S8ijGfCrHmN82mp215tIT01jbPAbkuDKsSy7VJwJEOBCFiHfP6paoRjHq8vU7lvmbOzSwUjE
	BN40ZCi8QxyQ7Mx3ge4NJ+5Udk4hwSw972Bdjy6i6sWATazSYvs2g5NOuGyNmr64KWlKqEyyUQS
	4jN9id1AAj/OTthfAdLh0zyzmLSx9BjL1GGXn/JhLnwpqhYn5xOZFjmoxnutlJrONJbvEzSd64b
	NXI9mMrsbijvHy+CUJb0pED
X-Received: by 2002:a05:690c:386:b0:798:6a6b:5ad7 with SMTP id 00721157ae682-79876c82b04mr1771977b3.29.1772058312756;
        Wed, 25 Feb 2026 14:25:12 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876c992b9sm771817b3.50.2026.02.25.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:25:12 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] ntfs: Fix null pointer dereference
Date: Wed, 25 Feb 2026 16:24:53 -0600
Message-ID: <20260225222453.1962678-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78402-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CEEC19E3FE
X-Rspamd-Action: no action

The variable ctx can be null and once confirmed to be null in its error
path goes to label err_out. Once there it can be immediately dereferenced
by the function ntfs_attr_put_search_ctx() which has no null pointer check.

Detected by Smatch:
fs/ntfs/ea.c:687 ntfs_new_attr_flags() error: 
we previously assumed 'ctx' could be null (see line 577)

Add null pointer check before running  ntfs_attr_put_search_ctx() in 
error path.

Fixes: fc053f05ca282 ("ntfs: add reparse and ea operations")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/ntfs/ea.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 82ad9b61ec64..b2b0a9a043a9 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -684,7 +684,8 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	a->flags = new_aflags;
 	mark_mft_record_dirty(ctx->ntfs_ino);
 err_out:
-	ntfs_attr_put_search_ctx(ctx);
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
 	return err;
 }
-- 
2.53.0


