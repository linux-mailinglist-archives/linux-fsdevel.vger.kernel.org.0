Return-Path: <linux-fsdevel+bounces-53360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99EBAEDE5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43C21893090
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB242BF3F4;
	Mon, 30 Jun 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbJOTRpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D62BEC28
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288506; cv=none; b=R8wH+k1onrDy6ES+C2Scr/H4lkHwUeugvrDIt87S4mM0Rr4+ZYFXypUXGP4eo14wb6lc2ZVovqeuYZ9h+sPoXTQb6WTKJdzlSky3FGvHYdHZNzcw55+vqkf8sbGkw49Uw1gbtzTJKhKgIeXywDxZ015ws3QJNiI/C44sRogxruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288506; c=relaxed/simple;
	bh=UE0+puqslU6Vod0/Tnuw7OVCa6Yv44yCJDBwHPhWm7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVLYL6M8qBFKb6cAXvpHaI5p4jNRoflBuWhQttjJLrxug++LfrzHy9vCdYUr/zHBLJVh0rrneVWtDK3PFG7vVTXHL/kfQQvRiBxUqz2Q5vtEHQREXjtbcOWm1fzye49ieX1Buj3ioWHt5pvKqZGAG7V1rWOWtRGXaMUndJ3+Lhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbJOTRpt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zjoj4LwixqS2sGyUbKyFkbKZVx00WcQgc8KQk63N+Nk=;
	b=LbJOTRptKUAeQUh/bC0BeZjUQ4KnGdcswgDSVR5He0oON9SBVx21/1AqJaebdVVJnPPlet
	c95vRgsgiUK9qaoLiKGgsInaDTyfMY+cpQ4JPBFAR7tQU6qS1b4hTQaTXgYRuLgLSZK0jz
	TxsXdwrRru37FeO6AYkZd+Tun5fPsoo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-kggrM_3BOlWIcPNQFicGVw-1; Mon, 30 Jun 2025 09:01:38 -0400
X-MC-Unique: kggrM_3BOlWIcPNQFicGVw-1
X-Mimecast-MFC-AGG-ID: kggrM_3BOlWIcPNQFicGVw_1751288497
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso1530390f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288497; x=1751893297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjoj4LwixqS2sGyUbKyFkbKZVx00WcQgc8KQk63N+Nk=;
        b=GccxrIVm7vepnAHqqczHs9BxPnHGPdOFrJN2Dj2XGNIpgkEN1oF3W/doyqjoSAKwnO
         CuVjMPX9sthc9IzciAnPWJ1Eo85JnBtXf3MeM7mqde4eTFs1Hdc2tb9Y0clr9KAXij7A
         V5Dww0AWyy13UJVTEnqW1Mme23MW5clI4esDKXFohTglgD8Di+/GerFshS7rNbhGTNI6
         CdU2nCv+YHmlRSsnAWp7uow9jkyglQ4uxv2ERC02BpY3t1z58VaOuuDYeAmtjnyx1j7C
         fouFPpMIiu0lvG+NWWX3oFKqDm7lugICXesrlMvfQBRxmAPXxe4RvPaqNRXARuJpSId4
         1TGA==
X-Forwarded-Encrypted: i=1; AJvYcCUO2ALesNRx8Hf6chLy2A/SsfUh4KYeKiUtoXWIMYsJAmvoC45O38f6JkskD/kk1ux1ZMjkE3MKni+yrXNS@vger.kernel.org
X-Gm-Message-State: AOJu0YwqW1INOyTfIjGAYE1NOFffYsm8k34abOZ60ZDt4lTuL0z9fh2l
	qpTd8RsQ751XBKwZHGCI6GeoTZkFkHTvLXZ7BNmIJm+9hRMM6e4pEs4dCXhLTlgLsTMaeXZw9Mu
	1Cnqw/apdOZQXgFyAkkZUYoFece3zO2O74s2ALSDpC6f8RpghVUX58t8gs1MsgPMXYGi65wDa8q
	7l2Q==
X-Gm-Gg: ASbGnct9OJPAdCsN1SN+2+8gSHhOrRSAFllZYIeGJH+VnmVnyUzabXSTM33PwyPERIw
	1BypracXHVD6Ok37/JwQk8v0cztWTEMxmAQf+kHbv7HtAaT8C0cB4otxjuWV+wXbTK+tr1QAm5K
	sBIoEHVF+u4T47be72Mgf8jSUTmmqodCJMeOllgKOQuVz8VYcV6Hd49zIENxgbMQnV/uXlnYaZe
	H3SGBSD+OEUXWoAQaw0+AGhwT8gkpPKwadlUMQu5gx2sCaW70Sg4DdP19xLjPj1zQGRmkv/RBWr
	HPkXQ2BiM8Fqvv63xLqDXaj9xfPtOspNB2E2P25n0ZWpVj/cwvVhm35+l6kDmkG9Sm6zhOi3sU3
	Tea6TjJ0=
X-Received: by 2002:a05:6000:41f2:b0:3a4:efc0:c90b with SMTP id ffacd0b85a97d-3a8f482bd78mr11299137f8f.15.1751288496407;
        Mon, 30 Jun 2025 06:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUx6MnmvL38m+UjxsSHRmCnwJ9csff/jtPLhL/sKkb+ObakA6KxkyBM5ParmF0iwuWxCWprQ==
X-Received: by 2002:a05:6000:41f2:b0:3a4:efc0:c90b with SMTP id ffacd0b85a97d-3a8f482bd78mr11299087f8f.15.1751288495708;
        Mon, 30 Jun 2025 06:01:35 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ac6ee0d0b9sm4643102f8f.18.2025.06.30.06.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:35 -0700 (PDT)
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
Subject: [PATCH v1 27/29] docs/mm: convert from "Non-LRU page migration" to "movable_ops page migration"
Date: Mon, 30 Jun 2025 15:00:08 +0200
Message-ID: <20250630130011.330477-28-david@redhat.com>
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

Let's bring the docs up-to-date.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/page_migration.rst | 39 ++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/page_migration.rst b/Documentation/mm/page_migration.rst
index 519b35a4caf5b..d611bc21920d7 100644
--- a/Documentation/mm/page_migration.rst
+++ b/Documentation/mm/page_migration.rst
@@ -146,18 +146,33 @@ Steps:
 18. The new page is moved to the LRU and can be scanned by the swapper,
     etc. again.
 
-Non-LRU page migration
-======================
-
-Although migration originally aimed for reducing the latency of memory
-accesses for NUMA, compaction also uses migration to create high-order
-pages.  For compaction purposes, it is also useful to be able to move
-non-LRU pages, such as zsmalloc and virtio-balloon pages.
-
-If a driver wants to make its pages movable, it should define a struct
-movable_operations.  It then needs to call __SetPageMovable() on each
-page that it may be able to move.  This uses the ``page->mapping`` field,
-so this field is not available for the driver to use for other purposes.
+movable_ops page migration
+==========================
+
+Selected typed, non-folio pages (e.g., pages inflated in a memory balloon,
+zsmalloc pages) can be migrated using the movable_ops migration framework.
+
+The "struct movable_operations" provide callbacks specific to a page type
+for isolating, migrating and un-isolating (putback) these pages.
+
+Once a page is indicated as having movable_ops, that condition must not
+change until the page was freed back to the buddy. This includes not
+changing/clearing the page type and not changing/clearing the
+PG_movable_ops page flag.
+
+Arbitrary drivers cannot currently make use of this framework, as it
+requires:
+
+(a) a page type
+(b) indicating them as possibly having movable_ops in page_has_movable_ops()
+    based on the page type
+(c) returning the movable_ops from page_has_movable_ops() based on the page
+    type
+(d) not reusing the PG_movable_ops and PG_movable_ops_isolated page flags
+    for other purposes
+
+For example, balloon drivers can make use of this framework through the
+balloon-compaction infrastructure residing in the core kernel.
 
 Monitoring Migration
 =====================
-- 
2.49.0


