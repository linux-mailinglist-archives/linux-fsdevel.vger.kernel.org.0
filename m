Return-Path: <linux-fsdevel+bounces-77656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBC9NSpclmkdeQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 01:41:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AAE15B373
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 01:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1B41301AA8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3A322AE65;
	Thu, 19 Feb 2026 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwJshFPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64335977
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461668; cv=none; b=OQW8ZjdqLRgF1fTYL/Ub+XXA42zIcocYS+21aIIfG418DK7v45h7AGvLmAxrZkI/dz1j4GojouX4/Y5dKAgVmeDs6RN0TeT9zLTcK7BEjt96iXiQdrhm9evm6cG/Hf2hNgITZVHs5DemzoS+i00Fi+Y15CDkq7pOQTxg/RSBir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461668; c=relaxed/simple;
	bh=ZRL1SXWnWjPLQ/VrkAl6SWiHznrRctO6R7yh+olBTL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbPs7QLFcQ3J/pZyYlvNDi9+Ee++wb+CwaxYhJu+Xslv38zEJCphiT1XnXUoeplRIJpqqvPGXq/P8TyiYWIWxE54g2w3cnrJpf2XaNmuSgVnB32NGWW/xDchuGLaZbkLA2fitxwhTRZK7NEGdVwV+eLXJHNbEJ+bGKSdiFGgbv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwJshFPA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8220bd582ddso158822b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 16:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771461666; x=1772066466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NAf2L+vziVfUUbGjJ+gAe6Z0Ze+h/IVnKOfn57mX2c=;
        b=LwJshFPAm/DprO9AulkyaZ3rNGcBZOj5WpZTb2lOHHrnazJUVSS4gjSwMxfrcsCrxz
         n2Z3PY8nERBK4/hMzEn9NoO+smCVFxjWrWSioO517BpjERLwrZxS7CgnE/hyYB6kf3Bv
         4ucxT4Hmu7R7p7SFOaMZJWkRu1Nxzp8k3q6TbNJgKXPj5PvwzCsgLkhXfDO3KODLGwhK
         G1qLdBFGM4NpC2cBTR+MCG9l+S+hxsimiJM/KsOEBdjQVOhRWull6osgAz3zW3nq+Kef
         uoKZo/186q5CKiJ0rdYdOZakkRQmwFibUY8FwjLHYT13LnpcmaIS14jdRlNYzChLip/t
         Rv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771461666; x=1772066466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1NAf2L+vziVfUUbGjJ+gAe6Z0Ze+h/IVnKOfn57mX2c=;
        b=wYAB0B8v0sNZlasiZV+bFuA9O3vWj+q4FeGR+vebB4ypXJbaBTnZBNKErRhHo55SwR
         2yTJnLkutXIn/J15qnfWm8xzQrszof95K3nmZLC48A4eqCyHi55/Hhq3hJ6ATuwHcbfY
         fPZW/qiy4+a3+xborqryfblFTwDHqN+646YgzuWsCBbYMl2f9hFh/jLfu9wt8s72aV6f
         K4BwkYNR7CQzfrHFeMFg1SgEz7T9ZljJH8C/+XxTH8XkNMVw5yH4ma4Vxx7tQi7ZdUJk
         1D2+ba2PcvlaJz281dXLdUpYpFndnfWY33laUK5NinXKpTRsKkZwocE2vT1YYZXWcJ5B
         9vUw==
X-Forwarded-Encrypted: i=1; AJvYcCWL/qNSFiTXiUCrkiVKGo57SJW5KThqYhClP2WL0vahhW57idji2QvUiIpoKnYO25NvSQE29arA+qyye65e@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgBwH+6+VoIJN1EunubcXrY1PvRjIFNax+zlF0xfyHXDTiIiO
	ci4FYjbgZmfcTt38wKUNOBbJyc1Q9jyxrpw2lY62tcL6RSAc2MgJObje
X-Gm-Gg: AZuq6aLOsx9tUrRmYAZov/a4nCOulACsx+QHq82ViCZep/utDMy9eYVvdKpjoELHpzz
	e/Jhankz9UDXrhezIf1MVYnuQS7gozn3FUb9z8l/m8OnBHUAoQfOLzohficHOWlhXmLg4oUgVrA
	YixnJjtxdU8DEqeINVlnY/A8MMEtEIQiXCaPHevLbdWMYAeoiiAEOYwTJkzleDnbIxg54AQYBkh
	M5GuuYxdaxDplIv93Lr9Q1uLctkdtvIr84XQ72ddst6rCaDA/AkmNFiKw6N1bxhyhU6JS903tqK
	NiZVPYMpWxspE8TRGXQMb/HAkAI+zlnd9lY4jp18CCTn8ffCsIPtMfITJRtNg4ENfRM239vL1Cz
	8r28QmXV7mwfQ6Ou0udc6JHih+vq+F+mRDzgNmBfn9mo9vdm/9ibMhr12+feld5T9/MfUeJJGtz
	2eLaIaiFcf3RyROFhMwDVYKIy3AyM=
X-Received: by 2002:a05:6a00:a20e:b0:824:9451:c1e1 with SMTP id d2e1a72fcca58-825275ee977mr3128570b3a.58.1771461666157;
        Wed, 18 Feb 2026 16:41:06 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69ba2sm18441039b3a.38.2026.02.18.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 16:41:05 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	wegao@suse.com,
	sashal@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/1] iomap: don't mark folio uptodate if read IO has bytes pending
Date: Wed, 18 Feb 2026 16:39:11 -0800
Message-ID: <20260219003911.344478-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219003911.344478-1-joannelkoong@gmail.com>
References: <20260219003911.344478-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77656-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 40AAE15B373
X-Rspamd-Action: no action

If a folio has ifs metadata attached to it and the folio is partially
read in through an async IO helper with the rest of it then being read
in through post-EOF zeroing or as inline data, and the helper
successfully finishes the read first, then post-EOF zeroing / reading
inline will mark the folio as uptodate in iomap_set_range_uptodate().

This is a problem because when the read completion path later calls
iomap_read_end(), it will call folio_end_read(), which sets the uptodate
bit using XOR semantics. Calling folio_end_read() on a folio that was
already marked uptodate clears the uptodate bit.

Fix this by not marking the folio as uptodate if the read IO has bytes
pending. The folio uptodate state will be set in the read completion
path through iomap_end_read() -> folio_end_read().

Reported-by: Wei Gao <wegao@suse.com>
Suggested-by: Sasha Levin <sashal@kernel.org>
Tested-by: Wei Gao <wegao@suse.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
---
 fs/iomap/buffered-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 58887513b894..4fc5ce963feb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -80,18 +80,27 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 {
 	struct iomap_folio_state *ifs = folio->private;
 	unsigned long flags;
-	bool uptodate = true;
+	bool mark_uptodate = true;
 
 	if (folio_test_uptodate(folio))
 		return;
 
 	if (ifs) {
 		spin_lock_irqsave(&ifs->state_lock, flags);
-		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		/*
+		 * If a read with bytes pending is in progress, we must not call
+		 * folio_mark_uptodate(). The read completion path
+		 * (iomap_read_end()) will call folio_end_read(), which uses XOR
+		 * semantics to set the uptodate bit. If we set it here, the XOR
+		 * in folio_end_read() will clear it, leaving the folio not
+		 * uptodate.
+		 */
+		mark_uptodate = ifs_set_range_uptodate(folio, ifs, off, len) &&
+				!ifs->read_bytes_pending;
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (uptodate)
+	if (mark_uptodate)
 		folio_mark_uptodate(folio);
 }
 
-- 
2.47.3


