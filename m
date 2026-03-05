Return-Path: <linux-fsdevel+bounces-79514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLGEBC7NqWl+FQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 19:36:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8AD21706E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 19:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A38310EE95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DA3BED57;
	Thu,  5 Mar 2026 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SiuCQrFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872D3D3314
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735708; cv=none; b=tgb3/pZykQutDGC7ITOrvMoH9PezeHmrzThubA/Q4IhrzmtJjRXJhYKzdDLJwxw6eVny3Om/DOaWsLvySuhjG7YKOov/KurtuFa19ahykCc5Dv3TQpZnjKB47BA6oWsygi2u2AWk0jkzvb54oqeYsb8Q2x9fpG4o5kluRLkNNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735708; c=relaxed/simple;
	bh=/Tc6td05PxTsXdusY4miqz4ecMa9kRLh1PTnOO3hpO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luYqyQ9V9JXFwZ8SPtFeoJyGIICA2SvNMfH/aU0IzIo1xb0PaH6H6h28eUuldfi6DiRODdi0Dv+06o/t7BOfkw5rk0vaIL+K454utBDTkQRtzCEt9MoY7ezS7kCE/5OeRsbeHqMILPuJxfD0wZOflUBHA/TJ9XO4Ogk+H2wYkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SiuCQrFd; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4638a18efc2so5598669b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 10:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772735706; x=1773340506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgAFxRCuIe2k8MVOR2tfsVRzGrubB49ONrVdiGmmwX0=;
        b=SiuCQrFdzkaGqzbzE4kpg3qEt0R8od87jnezudaYPPdv4u/5B9YjqEw3+D9uc4YkJ0
         IpT64bI+2GmulKsPsnCoixfeHB/f7zkMOC9ak3efcWpEVl/Lzr4DKbrDrHoqLg+6WEPM
         KjMFEyIZD/GUZiDrE2NTwekdbXFfkZ4Xy4pW8e9GG27KW1Xc/UiuDEz0S85BiUUqMH87
         d5tObFVI3kG/bSVAeC24Vacb8bQanWOvIB//dB/oEZqqoKfLoN8VP+Z3bhQUIDnFpunf
         YJ4LIDS21HIDbyFU8l7RZSqipIa9Yd0hVqzaTT8AqNuSJFidGth0Xr8RkFzScMDAO1YN
         QlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735706; x=1773340506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vgAFxRCuIe2k8MVOR2tfsVRzGrubB49ONrVdiGmmwX0=;
        b=KpSGjwLXuplrjNz5lN/g35Uq3MnWQ5neLykwViHVynqbdi+xtAer5fRKnYytdF1Ca5
         20KPUQULcNk1q6YoGuQFGFUc24dvqjhk30F75sAOSMZLTjvUQf1tyopkViR504/GbdhT
         fGZRmzmb5khVhqFKbSeqt6slVHJw4jE1QPYqFKBXfJo6J+GbC+6JVuFL99Fows8TANsv
         jTkSGL5XSWirklpp6zXXVyTrNvQFhllFk2RdPrZu8N7UVQCxbnPkDywz4tmKULWqwMLb
         WU2oMkYJhT1KQwFfJ+RGuSCCZPv8pRv4ZDu7yTM/tHffQJ+5z4GVGMXJqEzZbyGdsYtM
         IHgA==
X-Gm-Message-State: AOJu0YzPrsWhDdF+Q7PDm76q/USaM1C8nTvzWrY8/51FKlxJH2tZBwsw
	MIkxaVWzPy2NPXjJc9r6F7XPNVamuNUHUWHJ8a1oIUSazFVxvbPoWgMAtshF2NClvjY=
X-Gm-Gg: ATEYQzx5W7R1AIhpGErQAvZj8AJ08DgHkE9OSjOMQZFVxVdrOSASnguTn1SzxcqoEUV
	WPJ52qvx9DbrWhvVET5RICxCLm+oy3DF92Ar40AWh2CCMPhwPs4v/N62T1OpiRUXBeJGorjRZu4
	ZhHlWnirHhikB6JTHwWXt9e+VQACEtxICsrtogvjgz6VsbelztXCg83RZDDiW4xWvk/49Kdojrj
	RX++JhfZ6TGvRIuBDOxurJ9STpxkyB+iOs68EoxAHdcfB/QcZj+aBY4c2aog+u5WDlWQjL2oTlv
	ghshX7/XIDiignx404ZyGnXYjuKy+OUe1169DybYbgZs3uOxhfAL4tmkHfGTzfuejqwv9LGhUIn
	9uoGs82UraPAlC8Fsp8m0h2RwBy5M+SdNC0GfmkiJDcey9XjPK2rZOHE25i+TnJrkCQW18+sMf2
	ipqLqNaSoX
X-Received: by 2002:a05:6808:1308:b0:462:d09a:cdca with SMTP id 5614622812f47-466d865e866mr326534b6e.32.1772735705745;
        Thu, 05 Mar 2026 10:35:05 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm13913851b6e.10.2026.03.05.10.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:35:05 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	william.kucharski@oracle.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH RFC 1/1] mm/filemap: handle large folio split race in page cache lookups
Date: Thu,  5 Mar 2026 12:34:33 -0600
Message-ID: <20260305183438.1062312-2-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305183438.1062312-1-carges@cloudflare.com>
References: <20260305183438.1062312-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F8AD21706E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-79514-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

We have been hitting VM_BUG_ON_FOLIO(!folio_contains(folio, index)) in
production environments. These machines are using XFS with large folio
support enabled and are under high memory pressure.

From reading the code it seems plausible that folio splits due to memory
reclaim are racing with filemap_fault() serving mmap page faults.

The existing code checks for truncation (folio->mapping != mapping) and
retries, but there does not appear to be equivalent handling for the
split case. The result is:

  kernel BUG at mm/filemap.c:3519!
  VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio)

This RFC patch extends the existing truncation retry checks to also
cover the case where the folio no longer contains the target index.

Fixes: e292e6d644ce ("filemap: Convert filemap_fault to folio")
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 mm/filemap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6cd7974d4ada..334d3f700beb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1954,13 +1954,13 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 			folio_lock(folio);
 		}

-		/* Has the page been truncated? */
-		if (unlikely(folio->mapping != mapping)) {
+		/* Has the page been truncated or split? */
+		if (unlikely(folio->mapping != mapping) ||
+		    unlikely(!folio_contains(folio, index))) {
 			folio_unlock(folio);
 			folio_put(folio);
 			goto repeat;
 		}
-		VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
 	}

 	if (fgp_flags & FGP_ACCESSED)
@@ -2179,10 +2179,9 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 			if (!folio_trylock(folio))
 				goto put;
 			if (folio->mapping != mapping ||
-			    folio_test_writeback(folio))
+			    folio_test_writeback(folio) ||
+			    !folio_contains(folio, xas.xa_index))
 				goto unlock;
-			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
-					folio);
 		} else {
 			nr = 1 << xas_get_order(&xas);
 			base = xas.xa_index & ~(nr - 1);
@@ -3570,13 +3569,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
 		goto out_retry;

-	/* Did it get truncated? */
-	if (unlikely(folio->mapping != mapping)) {
+	/* Did it get truncated or split? */
+	if (unlikely(folio->mapping != mapping) ||
+	    unlikely(!folio_contains(folio, index))) {
 		folio_unlock(folio);
 		folio_put(folio);
 		goto retry_find;
 	}
-	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);

 	/*
 	 * We have a locked folio in the page cache, now we need to check
--
2.43.0


