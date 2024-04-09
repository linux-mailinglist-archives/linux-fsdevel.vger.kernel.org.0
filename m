Return-Path: <linux-fsdevel+bounces-16484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E4889E37C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2480A1F24041
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7E8158D6F;
	Tue,  9 Apr 2024 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aso5oJJ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7737157E8E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690777; cv=none; b=PXakUTX8S8sVA2TPW9VAaF58BjxKuzq5y6OAfyNFmaTg5VCyXufWsn7rIkz331iOmJhYuE3jrG/iHX0xMtNr5zsoB4Dz6NnYDK5yYoNESQ36ZMpzxohEwQ2dt+XXEBns8yGw32B1YbyAJpIGSwZSOzVX6pWxCo5XKysczU1BzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690777; c=relaxed/simple;
	bh=omqhDgTrChEETgeMiUUkVBBhOlzU6W6WQjgKatIId+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqssmUFOEMfA4rYGGKSf8iFiu96PUgnYwnxx/PoAOO1mhfacjWYBSJ9oL2WC/RFKAuXDmfcFnHArWmQC8m1hLY/RCkT/wv1LyO1s88iyzlNfWMtDeqCr0KnTwlV6clrWBJxLR1KVfkAQDbNVBxKBRYA0WyG1D9SUKYJEcDRqw3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aso5oJJ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z56f15PtBl+UvHHvSB3Qx1+Za4NemO81qqaBL/Rijfc=;
	b=aso5oJJ6oAQm5N4KHjTiaJiXDbY1WyU1AaAnmAFMBV44XUQMEGzVdfBInPTF6xfTsBKP1s
	4heRTHPdGrhocSTQu5Law6h+jDEvkMpzaTIjhoKCWWUCq9xXQOmSXE6HoSXJh5slBAljTo
	OW2wa4oOJS8xTni83zWXLUhsQStMhvY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-Ea0Nh1k0ME2JTUIPiSiprg-1; Tue,
 09 Apr 2024 15:26:09 -0400
X-MC-Unique: Ea0Nh1k0ME2JTUIPiSiprg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DD5B3C3D0CD;
	Tue,  9 Apr 2024 19:26:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B0B440C6DAE;
	Tue,  9 Apr 2024 19:25:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 13/18] mm/filemap: use folio_mapcount() in filemap_unaccount_folio()
Date: Tue,  9 Apr 2024 21:22:56 +0200
Message-ID: <20240409192301.907377-14-david@redhat.com>
In-Reply-To: <20240409192301.907377-1-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

We want to limit the use of page_mapcount() to the places where it is
absolutely necessary.

Let's use folio_mapcount() instead of filemap_unaccount_folio().

No functional change intended, because we're only dealing with small
folios.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c668e11cd6ef..d4aa82ad5b59 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -168,7 +168,7 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 		if (mapping_exiting(mapping) && !folio_test_large(folio)) {
-			int mapcount = page_mapcount(&folio->page);
+			int mapcount = folio_mapcount(folio);
 
 			if (folio_ref_count(folio) >= mapcount + 2) {
 				/*
-- 
2.44.0


