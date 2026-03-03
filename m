Return-Path: <linux-fsdevel+bounces-79296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC9ZL21wp2kEhgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 00:36:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FDF1F86A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 00:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C1C30FAC0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 23:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED73537E5;
	Tue,  3 Mar 2026 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX7c+Onv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598A35CB6C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580941; cv=none; b=n7HbjF2KrLIYo81v51GPo8ahcg6ZREtxbuHO0Mae8bFGxiqBwsEiIh3Y9azN14EP0sAC72rxUF0A0KRffiky2pEJQX6cbc7DaG6RvZUrPuIVtZ1L9PrPs1nLQCDFjqp4onuir/vaUjq2cgwjZsUxU+z/cIPD7EiQby7F6BaUYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580941; c=relaxed/simple;
	bh=jkrHDNgM25d59kJT571jsnGyvqtlao7ohHl2wkdYRY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skVoShff21/F9AUa/u+c+ixBf9yFYH8scRHc4HmLwe+GkwYNw1jMDkbXbZDSiBYuXxa8sXDl1DHaoz6yYFBwOuOECUezoBQKDye4i01Hg6Me6Qh/M/Rt0j+JVlE7e2E/YqP44ZPgjUdaRRypTadBiuvUw+HeoiaW56dT2w0uE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX7c+Onv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae43042ea7so35907005ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 15:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580940; x=1773185740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obiQ76qiUJNFcjhp64R+cgHHcte5lFLkqq9i5N4t7sU=;
        b=YX7c+OnvhyNMzk8gdQRX/X1slGQ1cyv/Rs+IolRFbjcAToi+gpnWuZ5i/ajfHXT435
         Wm4kEtDHoMjgWnIGuYM5fZFnl2VrUKiJULhXQJKAw6xAuhJl5MEooXyG4OQ9IckFxSGL
         MUlsM7zjcJ+Sadifs7DkMFk4kwu1pPuNycPmVW5oa1Y+mpKW1La3IjHMp6S4U4Kp4U/Q
         kPEGxHLoEv0/VDOs5OsScofad0plVYoDsUJhwZ17WYJPKuX8Jy+MzMRJTupeevoq0P0Z
         wNwzC6TPJDe03jsS1P+vnFcCsaZWke4i2yI3QGx9xmEWGElZKC9h78l2X2E/bDbcbcq5
         JXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580940; x=1773185740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obiQ76qiUJNFcjhp64R+cgHHcte5lFLkqq9i5N4t7sU=;
        b=DVNn/86kXazrwpJ0sir6IEMRBkBH1CvdC+4qvv0btyPY66bE/KTrJ7DynEOj3PSweZ
         YQyroRMbYi12KvSK6V876snv7tTns7tTEGsVXsW+Vr1LCCdTnucjmUAkWhZLoWJDHIFx
         JtHB7+ZqEtCOUE4UPQsEBmxdFdIfrUcMGV8qCXF5GHeB3jAXDOz/Zr+ZwV5MeDbZGvLa
         /FinKvigsWcgr0YlozXmjYKLUgeq0Hd+EPo60yWjTAi+muDoQIIqfhGsHjn1cNTkNpU8
         TP7wtlYdOUlm0T3kGeahmPtce0Xykpa+kRWiH23Ki2f/BG45dXP2LW9m7QRK24ycVBDh
         tHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1irwhhXW8tMYAtPOaDs4iIL4AkaK3x01aUWuWdUW6B+/gutoUPZVNekhCdz/mO0hcpH+qZc+ECJGv0K0v@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0cGA5bkvKtmVbAXlL8aKWxSBGpB9ZH/sN45e6bH74a15iqGr/
	+Z7pN5fEuGVSFzSuRUtMazP3TTQIiAzHwFBRNczDZ5RIYiHMdVI2mjTM
X-Gm-Gg: ATEYQzzguQxSrxY/AxF89T71ISLQ2Q+D5L+RI9JBgD849YkCB2z6F8KGKNcAtL2agks
	AQxmsOj4D5bfgqFQCFK+J2tp16OW8rpNxC/D5GogNCtk1Lf5l/4MmaDOcZOUWHUjXtNcmrp9GA/
	pdyR+q8jv0URfCTz7Chz5x2aPrUK2MfM9bSyl1rSM00oGaDiNGYwEQpNoJ+4WpGC2iNslIOnwFC
	OKjmNP/o2i/Kw20FSZnxKZAvFb4Mafp0yfrI88APgCU4vYOs8aah7APOUDkeJp4uoDrjiBjv+CQ
	DflVvB14541UNgc+hlmp7eqVGPbYvmhSHXWTsBNc32VCtMajHxtfqaPyJ0cK0t9RDAP0FTvGP2u
	J1QU4B/E+gyVyZ11U3KH01po6RQykuzoUZMsdfb6qV9ib3GBncRdUOJFN4xrhOXBYLU7HQAQLwR
	mHHeuLc+OTfi792tuMGw==
X-Received: by 2002:a17:902:ccd0:b0:2ae:3f72:fdc5 with SMTP id d9443c01a7336-2ae6aaae6camr1189365ad.26.1772580939922;
        Tue, 03 Mar 2026 15:35:39 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45e07626sm107308075ad.39.2026.03.03.15.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:35:39 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	willy@infradead.org,
	wegao@suse.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/1] iomap: don't mark folio uptodate if read IO has bytes pending
Date: Tue,  3 Mar 2026 15:34:20 -0800
Message-ID: <20260303233420.874231-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260303233420.874231-1-joannelkoong@gmail.com>
References: <20260303233420.874231-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69FDF1F86A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79296-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email]
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Cc: <stable@vger.kernel.org> # v6.19
Link: https://lore.kernel.org/linux-fsdevel/aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org/
Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bc82083e420a..00f0efaf12b2 100644
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


