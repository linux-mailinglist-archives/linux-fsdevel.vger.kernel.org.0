Return-Path: <linux-fsdevel+bounces-53333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F005CAEDDCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105B73A407A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B828A1DA;
	Mon, 30 Jun 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZF3n42DA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E2285042
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288424; cv=none; b=XULxJTitof7oF04uxI7b+V5dDFfRViUQAE/vDyI9jOYe90AsaS4Hb8mk5awVQesbx00LdFhRQJpX1aEt5rgkgmXmD7WwtVcH/XhBnB23yXKDMjJGJtV9l4bpZpFefv+MGD77/FMu70jUOPF47QhnqkeHJNKKVtiCe+AOOygmZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288424; c=relaxed/simple;
	bh=RPaleElAAsDd8ZXcp7V7mHwwcGHXNcadS42UzjFFaPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJxqUJZC3LQO9TRh5nZZx56c69bYM/uQFfSzfiHp8vfz3oPpGenei399IdITZR9atefxcp2yzajFQ0fkK/u3/r1Ov7ANN7vyJhgvVCLnbQIKMaScdHIUQ35tNs6c+So5EKqKrM5awMgYHxIEcJkVbzOgZltskuHPFxaN3Z5Ib2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZF3n42DA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLYHGg19bG0clXk7rQPjR4hvYWmeZvg7QKQ5c0snrQE=;
	b=ZF3n42DAs+TP32PNJLPigt4Wf9gxCs8swd0rqi12+tSqZHapluNdI7KX4HWHVUKZzVqoVO
	+LDNqZRuCVF/5y5KB/aHgwTrszr/nNvy2anjvdM7dK0LCKYkP6Mzkr6ef3wKoeJoBYPAGh
	hkBLCq9UJzTtlldZqj4h4KAGeqjq8dM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Je-CC6CLM7-E1uvj002Rmw-1; Mon, 30 Jun 2025 09:00:20 -0400
X-MC-Unique: Je-CC6CLM7-E1uvj002Rmw-1
X-Mimecast-MFC-AGG-ID: Je-CC6CLM7-E1uvj002Rmw_1751288418
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4532514dee8so28313015e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288418; x=1751893218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLYHGg19bG0clXk7rQPjR4hvYWmeZvg7QKQ5c0snrQE=;
        b=c9uyvM1Mdj60iKB92mbDdgMA8MHZTVX6ErimXnZL0KKh7l0pXvtoipbuLO6GDMglYi
         0BClAKRzd9mnM4KGRz+LibApp6ceGb3MwXx9pJb5oHDlDA//3KJ9yxNHr8swrVGqEbPz
         MdfmgqoGwkhZBRMWbNeFvY0tVQ3Txk9IiLRP3kZ/w2X5mgdMJMjwBkFtOG+YwpfeA/4u
         VVvVoMfEXLI23H8nYsHo9bNjHPB58XoaVHyBtKsG0yLkHRWwVtu75/Nn44rYjDgWsiF8
         RLEQSr5Gn0gv8BoyS0alZUPU2s8lk8HmYnOFayUZOPllAAK+JboZJAFgWZ6jRr3T8MO9
         jArA==
X-Forwarded-Encrypted: i=1; AJvYcCXPg85i8mUPIsCZCtp/QfuliWZlo6Qo8DeOiDVV361+5hEwxkBP1UEpyiV90cwwjVf9x4W8lTgQ0up1GkU5@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQjYxBKWbBhDeHhRXpanTLlrniOoJV7MEnJm1iAFgbbX0ifEe
	VGUKrcKsimSqx8KgmuTl3znSJl7GhpYNnRVx5gb4CrCSOUk1leyY50EqStPlmLSAXrWXWLdBk9X
	q++z24HTGKXnWzitHRg7e4oVrlWSLVIpLrUxXOHtbFTC+KXDvH8/FvMdT4sR4L4efEjU=
X-Gm-Gg: ASbGncsxYRitJ/Sml8eQO07TPU7mlYi/QXbwQhPLo0LgJtJPTSE53jHqs0eRADM+mr+
	XMRq6hB+N2E+Wml0wyFqjlwABE/jsrVu4Mf1MV4ZiTVT+MxFelrHrl54sruD9379ZcMLeKMwOcX
	w4kpZID+Zm23Cg0EIVFkw5ZDrUpw8BF+okuVajnt7+0zZqySsJ76UAp4id9lSshM8icfiolWjIj
	8QEhURxCG/rgk78SZ0bsTOPrKjsZaFRQTUxtlDbQ4ousrHAVigBJ637gzsy9kJgU+YFuBd1tKY6
	vwu9Pt5QKC+4lBbKtlwMvzF/YtT7sZml6RJeYpCoRlMXXi1JZ5t/ic59qmoVOZIorwkYW+aKafE
	3Ly5g9Ko=
X-Received: by 2002:a05:600c:35c9:b0:453:608:a18b with SMTP id 5b1f17b1804b1-453947d8ff2mr103853315e9.9.1751288417727;
        Mon, 30 Jun 2025 06:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb/NAxjgNou29rgmmNKmV3zZO0Mb6cYoPiX5R9Zf8/khrmrYWUc/XyFqJpcvry+rGAxO8smA==
X-Received: by 2002:a05:600c:35c9:b0:453:608:a18b with SMTP id 5b1f17b1804b1-453947d8ff2mr103852575e9.9.1751288417169;
        Mon, 30 Jun 2025 06:00:17 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e59659sm10376420f8f.77.2025.06.30.06.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:16 -0700 (PDT)
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
Subject: [PATCH v1 01/29] mm/balloon_compaction: we cannot have isolated pages in the balloon list
Date: Mon, 30 Jun 2025 14:59:42 +0200
Message-ID: <20250630130011.330477-2-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core will set PG_isolated only after mops->isolate_page() was
called. In case of the balloon, that is where we will remove it from
the balloon list. So we cannot have isolated pages in the balloon list.

Let's drop this unnecessary check.

Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/balloon_compaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index d3e00731e2628..fcb60233aa35d 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -94,12 +94,6 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 		if (!trylock_page(page))
 			continue;
 
-		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
-		    PageIsolated(page)) {
-			/* raced with isolation */
-			unlock_page(page);
-			continue;
-		}
 		balloon_page_delete(page);
 		__count_vm_event(BALLOON_DEFLATE);
 		list_add(&page->lru, pages);
-- 
2.49.0


