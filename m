Return-Path: <linux-fsdevel+bounces-53928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955CAAF9014
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA55547883
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50BB2F4313;
	Fri,  4 Jul 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgdXXCQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729152F3656
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624746; cv=none; b=feGDC6fkiY+PhGsCk7CpHI7l1S0MRhyJEbQaoifBXkmyfB9M9VTq3jpoEXpfH6lIhT1YKjsfMSwzWNEpWed0+6C9su0eIPn5tT6ehT4UxzF12AzPNUEYgBL5bZ/6ORP7VjP2nWFqr8SMycz9ER7ncEt2kk8Adrxtj8f1qFRJd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624746; c=relaxed/simple;
	bh=AM3xYskqV1GdLk2CfAavrgvRU1Z8ivBgX0T2p7YhDTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnTmiTlNhGI/dN38qdW4RpBPfpBduzImECeXWOYLKc18mW9ndZFbKAVWm/p4ubGfGOrwMNEOtHl4tMaZ0DeN6VQJot5mMAzjt0QvZTTJkgew42/kccsdVgHZMAHB77VdVkGdYwc/QvRwmY2/YB82r19WNqAO/YZWheQDGDUU7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgdXXCQy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYTSovr6D54lprWegV/WfQaWtrhfAm9Hhj9zhgiC0NY=;
	b=VgdXXCQyenc3eKX0Ly6wac4gAQPGFg/vNM6gjkRCTAjIJPVAza11My/nf80RA0HyrZ6svR
	VdBceNcZhVkiL9H9UfasvytCcaFeX3wsC4DQoPf4Jf6kQKWuuHPBxV2hsNp7jzaQqatTtF
	qgx6RASnxONQm5jecUR9kc9LwPM3+oQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-sJMchk5xNI2TWZJpSeoo0w-1; Fri, 04 Jul 2025 06:25:42 -0400
X-MC-Unique: sJMchk5xNI2TWZJpSeoo0w-1
X-Mimecast-MFC-AGG-ID: sJMchk5xNI2TWZJpSeoo0w_1751624739
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450df53d461so6211415e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624739; x=1752229539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYTSovr6D54lprWegV/WfQaWtrhfAm9Hhj9zhgiC0NY=;
        b=RpV5FMdeAlPKaIxrbJqs1I/peSj8j9iwClBdal8zqeHY5rgDCMJQ6cAjJ5njFYp7pd
         VS7cSfZ+fkSkPTUwbjUnwD60cZKPbhaV08mUxEY/99RRtzeNYoyn3N9305qBdkcttsw1
         GVFoSuRgtZdjTw8F35qSkZ6VPnO/eMybnmRZm1KGWNBChqyrIwNMFHbj9p8KXPeIBwzK
         1rP7/Plr6u/8lMO18aIZn5RXWHuWNh4GeMQCYgKTHNb/0GjhIOu/ZLdWNFdU+IL+Ve1O
         QcdP4+BAnsnOex3SE5Uc0DGzWGfQi+SuohpRpCKOTYthZXDHw41fLTv7pP4FvrK79Gdu
         dzkA==
X-Forwarded-Encrypted: i=1; AJvYcCXErQeBR/WGkcASxpAmyGh9Xsp4VGQHz+ikJo6Nv/Hv6LAtdCTJ7onTNX9rpeCAnreCKHwbePlsQ8ejir8K@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBcV0mId/XlxAvMEBBsTtT5heJ/SsVyjrZg2ELCrLJAUW8BZI
	vIs2N1eo2tJSGbDIE1SGZaqb0NRUxdKzO6ye9QBQnt9/PojeIBaBLkFXWO+97QfJpMiYjGyfzEa
	SYW/WvAaao5iLJbwxru5l3hsKLamnxkG2czXCNdn//KP4mRzdVmidh2X6uqDeC05cAGg=
X-Gm-Gg: ASbGncu9GfNKg/iUVLsm62wGs1/Qs6WSISw6vXZ/DwZZTnSs2Rp6t0fBnMycCVF8OM+
	0cT9AzS1ITYBx3m3HaJWTRlGZ6ODe8YFisj3Ca9R7fOXkmkHNSC/5Kf94VBMaiDwQ7OCl5WtcZ2
	+5g8T0NMBOO3eFuXIl3QBouvRWobGxltjXwdnIGoWeON+3m4D6XKRciJzHDts40X9AuY8zYx9Hk
	ETXB5lMRuRrRtaHbM9Z+TcgVGL9PqLblWu/zSLwAMvjQ9pIi2uhVhRiX18MTeAWT/gAe95wjUD6
	sN6BXiU4OkrIFu9ec8VymRaim/mieeH/zKq9hieeDLc8sog4XhI7mDraofrCzyZTUv1KF6lJu/a
	oRB3Kng==
X-Received: by 2002:a05:600c:3e1a:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-454b30aff3dmr25066375e9.15.1751624739247;
        Fri, 04 Jul 2025 03:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEabPcFPa9J30O6qNf8/Kx6cfnBeZR0NWqXc94Uy+RT4akZprmrg4imDnBXRg/gEanMTx6ZJQ==
X-Received: by 2002:a05:600c:3e1a:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-454b30aff3dmr25065735e9.15.1751624738758;
        Fri, 04 Jul 2025 03:25:38 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47285d3c6sm2121167f8f.95.2025.07.04.03.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:38 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v2 04/29] mm/page_alloc: let page freeing clear any set page type
Date: Fri,  4 Jul 2025 12:24:58 +0200
Message-ID: <20250704102524.326966-5-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, any user of page types must clear that type before freeing
a page back to the buddy, otherwise we'll run into mapcount related
sanity checks (because the page type currently overlays the page
mapcount).

Let's allow for not clearing the page type by page type users by letting
the buddy handle it instead.

We'll focus on having a page type set on the first page of a larger
allocation only.

With this change, we can reliably identify typed folios even though
they might be in the process of getting freed, which will come in handy
in migration code (at least in the transition phase).

In the future we might want to warn on some page types. Instead of
having an "allow list", let's rather wait until we know about once that
should go on such a "disallow list".

Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 858bc17653af9..b825f224af01f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1380,6 +1380,10 @@ __always_inline bool free_pages_prepare(struct page *page,
 			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		page->mapping = NULL;
 	}
+	if (unlikely(page_has_type(page)))
+		/* Reset the page_type (which overlays _mapcount) */
+		page->page_type = UINT_MAX;
+
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
 			bad++;
-- 
2.49.0


