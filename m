Return-Path: <linux-fsdevel+bounces-59792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE24B3E11E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E49616F15B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4194F3148BF;
	Mon,  1 Sep 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z5c+ySOp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="90sQNf+E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z5c+ySOp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="90sQNf+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342DB313E02
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724955; cv=none; b=YN0tP2Wwhs+cfKQE0OQMiHberPK6p3nAXIUaYlCEU0AoEyExFGtxDiapeFsFupL0dg/dIeTKWOUz2kci5IUn6FJQow1qBfhfRodAXpj6zPN0oZI/ZX0hu055WDzzu7kyAgIg1x5UpQoRWKV9J0Fbau3to+KILLeUBmnQhN0fXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724955; c=relaxed/simple;
	bh=HkdnpY/4D0YR705Z4sr6/18J6w2LIasvhwkCf88MmGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3/EB63K87MkVIprAINRxgq1bX7AdDFY8B5+m7iQA+W+0ERZ1daobBawk71EkrHwdXQbtvlmmkMa/yhP7CVsmHK/mDU2SA/zSxJP9QdH+RMR9vFuL9O/gR2BxMQezW6QIMh0tg8feh0O9ls5QLeih1iMdoHUAHM7MTksEZQtNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z5c+ySOp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=90sQNf+E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z5c+ySOp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=90sQNf+E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91D421F38A;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jt4x7IV34QbOESa72I6EsO7Rh0wlySwqCcuJjlcUiJ0=;
	b=Z5c+ySOpAZmhexw/+8cxAtn6gqTZddJRBvPDlb9TZPBBLg0KYg3kCb9HKFMI0KboUKPxIg
	YceR05iAiJD5o8y0wKlxvKnpZtb95s833EhLWKzJXSqMUSiAJacgfoMWb/5forB+JHGNXe
	iUGGsgJCI4ydnAzni+0OfsSccBtz/ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jt4x7IV34QbOESa72I6EsO7Rh0wlySwqCcuJjlcUiJ0=;
	b=90sQNf+EB0SvmEXrjKaFlLcDyjlJQIeqr3bT4vCRuyB12ePlNmbp1s7GH2e7QPpFKPT2/Q
	iwZmvuD61HWZ1TBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jt4x7IV34QbOESa72I6EsO7Rh0wlySwqCcuJjlcUiJ0=;
	b=Z5c+ySOpAZmhexw/+8cxAtn6gqTZddJRBvPDlb9TZPBBLg0KYg3kCb9HKFMI0KboUKPxIg
	YceR05iAiJD5o8y0wKlxvKnpZtb95s833EhLWKzJXSqMUSiAJacgfoMWb/5forB+JHGNXe
	iUGGsgJCI4ydnAzni+0OfsSccBtz/ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jt4x7IV34QbOESa72I6EsO7Rh0wlySwqCcuJjlcUiJ0=;
	b=90sQNf+EB0SvmEXrjKaFlLcDyjlJQIeqr3bT4vCRuyB12ePlNmbp1s7GH2e7QPpFKPT2/Q
	iwZmvuD61HWZ1TBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 710861378C;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJlQG8V+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:08:55 +0200
Subject: [PATCH 05/12] tools/testing/vma: Implement vm_refcnt reset
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-5-d6a1166b53f2@suse.cz>
References: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
In-Reply-To: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, 
 Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Add the reset of the ref count in vma_lock_init().  This is needed if
the vma memory is not zeroed on allocation.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/vma/vma_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 09732eff8dd84555563b3d485805ebab7b204584..972ab2686e0a3654cef611ce9f3409bc0c38dc80 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1326,8 +1326,8 @@ static inline void ksm_exit(struct mm_struct *mm)
 
 static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 {
-	(void)vma;
-	(void)reset_refcnt;
+	if (reset_refcnt)
+		refcount_set(&vma->vm_refcnt, 0);
 }
 
 static inline void vma_numab_state_init(struct vm_area_struct *vma)

-- 
2.51.0


