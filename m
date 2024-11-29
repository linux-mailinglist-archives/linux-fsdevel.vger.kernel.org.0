Return-Path: <linux-fsdevel+bounces-36138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EF19DE6B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AC528150B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66E19D8AC;
	Fri, 29 Nov 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRRaMuCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3D158520
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884796; cv=none; b=tbDweDBC2+zFH5YQtrHW8n+4koIGKhG9FSZKxos7yoZb/LaLp8k10sEab/L7zLSX1uqz2hLtHj5QJ6VmxfU+ZAlA5atCbdvR3pCUL1Yg0qOKlCJnLJzZFPnZQtRO6pz57Hsod5BBxLoRQvP9jaqMwoEjG+7UNUv93iyllFmKdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884796; c=relaxed/simple;
	bh=KCTzvb4MPTMBmGDUdg10uRewJVPa+KzvV9gjvdi3MRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkAzU4y0fCaBeIDj2TRp/jssKABRn5RU4f9F3dAk83nrZB2f+qpnnaKbYcwwS8P/dUwkUc5g0fRDuJkopApAobO+H0mSmCHUkS/2JXCvYBZkyaDj82YPOfbbhsOxPkg3LmUj/Gr28T3unHwt3ffRzih1comYbJRXn/PChncGCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRRaMuCA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732884793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cv6PjLDvvuWVXJelC4ktF5aqEnDKzqyylUqBRpvzsJg=;
	b=TRRaMuCA7jYJFZS/kk11GFoIO+KXivU6MjzBiVX8jUMmsiXQI3S+LjyVvnPawKEif09m5A
	MvWxKXsA7EggPq4NcVfQGGitSt+kCThKFVS0LBxYoLY9i7KpwQuIuNpU0DeTBwY2QCzjgb
	GU29pqGmFQReRBWUavVAF2hDuTqdkcY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-GQ2_1JNLOROgSLH8GsROmA-1; Fri,
 29 Nov 2024 07:53:10 -0500
X-MC-Unique: GQ2_1JNLOROgSLH8GsROmA-1
X-Mimecast-MFC-AGG-ID: GQ2_1JNLOROgSLH8GsROmA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E4851955D4A;
	Fri, 29 Nov 2024 12:53:08 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.80.71])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA2391955F30;
	Fri, 29 Nov 2024 12:53:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Hillf Danton <hdanton@sina.com>
Subject: [PATCH v1] mm/filemap: don't call folio_test_locked() without a reference in next_uptodate_folio()
Date: Fri, 29 Nov 2024 13:53:03 +0100
Message-ID: <20241129125303.4033164-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The folio can get freed + buddy-merged + reallocated in the meantime,
resulting in us calling folio_test_locked() possibly on a tail page.

This makes const_folio_flags VM_BUG_ON_PGFLAGS() when stumbling over
the tail page.

Could this result in other issues? Doesn't look like it. False positives
and false negatives don't really matter, because this folio would get
skipped either way when detecting that they have been reallocated in
the meantime.

Fix it by performing the folio_test_locked() checked after grabbing a
reference. If this ever becomes a real problem, we could add a special
helper that racily checks if the bit is set even on tail pages ... but
let's hope that's not required so we can just handle it cleaner:
work on the folio after we hold a reference.

Do we really need the folio_test_locked() check if we are going to
trylock briefly after? Well, we can at least avoid a xas_reload().

It's a bit unclear which exact change introduced that issue. Likely,
ever since we made PG_locked obey to the PF_NO_TAIL policy it could have
been triggered in some way.

Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/674184c9.050a0220.1cc393.0001.GAE@google.com/
Fixes: 48c935ad88f5 ("page-flags: define PG_locked behavior on compound pages")
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hillf Danton <hdanton@sina.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7c76a123ba18b..f61cf51c22389 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3501,10 +3501,10 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 			continue;
 		if (xa_is_value(folio))
 			continue;
-		if (folio_test_locked(folio))
-			continue;
 		if (!folio_try_get(folio))
 			continue;
+		if (folio_test_locked(folio))
+			goto skip;
 		/* Has the page moved or been split? */
 		if (unlikely(folio != xas_reload(xas)))
 			goto skip;
-- 
2.47.1


