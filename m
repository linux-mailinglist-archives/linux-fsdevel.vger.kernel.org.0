Return-Path: <linux-fsdevel+bounces-53924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D205AF8FF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81815A1DB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B170A2EF9C8;
	Fri,  4 Jul 2025 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLwT/EmT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9A2EA72F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624734; cv=none; b=iryjgadkbzPz2qI63UimKDXO80fqSe8Jfi5exhseglLRYbpIDXDeVC4Gx/SFHIrf2tvV7PbAAqyppMq5xv8Ej0/CPpn63zOJssZhfeHhT99TM+flQtw6++nRUiiPMD5zSfWVbPtSwIyCR/KKYqRjQRZnEzhl0d9FdAgC28M8ba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624734; c=relaxed/simple;
	bh=pEUtySM2KTJFulIMAqjkelFZDkcz60ibvb+CB6Fbeyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fgRgKazgXgGg9LhOfGc1ZYlSLO4Lp/7Shqit254F4XJYWs2wbyHqFbSjiy3MwsuvLngC7cyLtzWAqnmPoI5+L1DmsoTRu3H6yVdQpHIePCLAqYiBcEY3Y5WDrCJp3iXJGu5DMW5Oj58GhiHWlDiWJG09KExqd0EobexskcgmGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLwT/EmT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sro688HYIitAmPcvBgChCRtb9/I9qH1hXgFepSE52NI=;
	b=eLwT/EmT7HWj0rRQfIwe+GHkBKXwyBzFk73+LECboajAXih4jvUvIAHT66sLrsMlKhQJ3U
	+MQQhaPr+iGGqcnM2ukBisGI8Ob9YdmFJFLREX/y4hIV9RVf1FvRX82yGreLroSdwjoDAf
	MHsJhjQZRmp2xmGq42yKdJpeOcC+eXw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-M-eCB9SwMS6nRjmbFYV4pg-1; Fri, 04 Jul 2025 06:25:29 -0400
X-MC-Unique: M-eCB9SwMS6nRjmbFYV4pg-1
X-Mimecast-MFC-AGG-ID: M-eCB9SwMS6nRjmbFYV4pg_1751624729
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so467251f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624729; x=1752229529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sro688HYIitAmPcvBgChCRtb9/I9qH1hXgFepSE52NI=;
        b=dJpEejn01fos4ZZorpJkpziFTuek1BoZAnjCs/YFH1r0nzXImVjUBVIpKdDQIwd3Ff
         IuBy0Llb2VW3zZFMtnu+XZFUvPNC11E6+BQEHvHkS/Ezsg0+9ZktM6qSRzGamBDoHqg+
         YZOFzb1DThPFGTy14vsdgiIT+2/V0V3SuSLWARLoSiw9Yn9rhqYiRx6kVyr7be3dBah/
         v9ruOP5X9kqNVJOLz18EHEKOgDGJUFKHf9Mb89OZBSSbu9pZsdAKgt0STVjsFilIT9Ad
         XTVlZMc6+mqVI82jRsNQrGIWvUrjjjF7qhSMfQs51Y50dh5hy7aL3/A6D4z6TRN5eNms
         T8xg==
X-Forwarded-Encrypted: i=1; AJvYcCUiHJQxhpvuoWV5BBa9PZD9NM/BTwqmp9WNah6+5PosZUjCWlWBmUlZnG+vIZtnZV+ns4Hg+JDPlYkmHGEA@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLtD8fxQ47ss5/uT9VVuVH4FvG3oJP3kJ+5l37gLGVjjbRYq8
	Nmz18iq5zeC8TprA8zX7Dh8pOz2eSwNUUYmiE+6QJNWrR5d+qFROKjeX3jrqtfgFz9K4rQCBiyz
	eMNAtOG2mvZU2YdGYFgA8uKDKvn281so9WgCFL/24Od8bKg5d8htZuNh1KgrE/RmH1UA=
X-Gm-Gg: ASbGncvBJyVyO6EdLILTX+eqbzD6X5Rx9OUgAUB5F9vBR05u5EFqVLaTlZeld4najcg
	BKDw0OPKkttsnKdf+6xuOYK1GJXW+ShQpP08RlKQCQtXSp0PwjDbgyxZL49FiBJbzzLKNv1x5eA
	kT1YTxJvlSmVWaE3t2rLCHRqKrw2+fQN6dAPaWF0oRgK1mv+iM5THiKb3JUqkTtx/3krpea5LWI
	MFmlgzq/g8GtlRgzsWYJsE5WQpBJ8hbBqva0HBLyVSpQCnpi94w8r2J+FhxsSC+fFp6wQ7lMkgw
	77h8Q6Q4VqtNlgTN04pX0ejYCuDxNDQA6UMXRjHR2kLtp+96uXMqaqwWveW/or1OP09D7vN280a
	b9IQ7RQ==
X-Received: by 2002:a05:6000:2dc7:b0:3a5:75a6:73b9 with SMTP id ffacd0b85a97d-3b4964f4d95mr1608836f8f.11.1751624728269;
        Fri, 04 Jul 2025 03:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCjrfOCujVRy/tLPuq2vX5bnaQezkrR11WICwCcdt0ejgdnjfY6QZ4FsoDRZ4Yte6IkVy/1Q==
X-Received: by 2002:a05:6000:2dc7:b0:3a5:75a6:73b9 with SMTP id ffacd0b85a97d-3b4964f4d95mr1608748f8f.11.1751624727474;
        Fri, 04 Jul 2025 03:25:27 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b4708d094csm2102185f8f.28.2025.07.04.03.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:26 -0700 (PDT)
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
Subject: [PATCH v2 00/29] mm/migration: rework movable_ops page migration (part 1)
Date: Fri,  4 Jul 2025 12:24:54 +0200
Message-ID: <20250704102524.326966-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Based on mm/mm-new.

In the future, as we decouple "struct page" from "struct folio", pages
that support "non-lru page migration" -- movable_ops page migration
such as memory balloons and zsmalloc -- will no longer be folios. They
will not have ->mapping, ->lru, and likely no refcount and no
page lock. But they will have a type and flags 🙂

This is the first part (other parts not written yet) of decoupling
movable_ops page migration from folio migration.

In this series, we get rid of the ->mapping usage, and start cleaning up
the code + separating it from folio migration.

Migration core will have to be further reworked to not treat movable_ops
pages like folios. This is the first step into that direction.

Heavily tested with virtio-balloon and lightly tested with zsmalloc
on x86-64. Cross-compile-tested.

v1 -> v2:
* "mm/balloon_compaction: convert balloon_page_delete() to
   balloon_page_finalize()"
 -> Extended patch description
* "mm/page_alloc: let page freeing clear any set page type"
 -> Add comment
* "mm/zsmalloc: make PageZsmalloc() sticky until the page is freed"
 -> Add comment
* "mm/migrate: factor out movable_ops page handling into
   migrate_movable_ops_page()"
 -> Extended patch description
* "mm/migrate: remove folio_test_movable() and folio_movable_ops()"
 -> Extended patch description
* "mm/zsmalloc: stop using __ClearPageMovable()"
 -> Clarify+extend comment
* "mm/migration: remove PageMovable()"
 -> Adjust patch description
* "mm: rename __PageMovable() to page_has_movable_ops()"
 -> Update comment in scan_movable_pages()
* "mm: convert "movable" flag in page->mapping to a page flag"
 -> Updated+extended patch description
 -> Use TESTPAGEFLAG+SETPAGEFLAG only
 -> Adjust comments for #else + #endif
* "mm/page-alloc: remove PageMappingFlags()"
 -> Extend patch description
* "docs/mm: convert from "Non-LRU page migration" to "movable_ops page
   migration""
 -> Fixup usage of page_movable_ops()
* Smaller patch description changes
* Collect RBs+Acks (thanks everybody!)

RFC -> v1:
* Some smaller fixups + comment changes + subject/description updates
* Added ACKs/RBs (hope I didn't miss any)
* "mm/migrate: move movable_ops page handling out of move_to_new_folio()"
 -> Fix goto out; vs goto out_unlock_both;
* "mm: remove __folio_test_movable()"
 -> Fix page_has_movable_ops() checking wrong page

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>

David Hildenbrand (29):
  mm/balloon_compaction: we cannot have isolated pages in the balloon
    list
  mm/balloon_compaction: convert balloon_page_delete() to
    balloon_page_finalize()
  mm/zsmalloc: drop PageIsolated() related VM_BUG_ONs
  mm/page_alloc: let page freeing clear any set page type
  mm/balloon_compaction: make PageOffline sticky until the page is freed
  mm/zsmalloc: make PageZsmalloc() sticky until the page is freed
  mm/migrate: rename isolate_movable_page() to
    isolate_movable_ops_page()
  mm/migrate: rename putback_movable_folio() to
    putback_movable_ops_page()
  mm/migrate: factor out movable_ops page handling into
    migrate_movable_ops_page()
  mm/migrate: remove folio_test_movable() and folio_movable_ops()
  mm/migrate: move movable_ops page handling out of move_to_new_folio()
  mm/zsmalloc: stop using __ClearPageMovable()
  mm/balloon_compaction: stop using __ClearPageMovable()
  mm/migrate: remove __ClearPageMovable()
  mm/migration: remove PageMovable()
  mm: rename __PageMovable() to page_has_movable_ops()
  mm/page_isolation: drop __folio_test_movable() check for large folios
  mm: remove __folio_test_movable()
  mm: stop storing migration_ops in page->mapping
  mm: convert "movable" flag in page->mapping to a page flag
  mm: rename PG_isolated to PG_movable_ops_isolated
  mm/page-flags: rename PAGE_MAPPING_MOVABLE to PAGE_MAPPING_ANON_KSM
  mm/page-alloc: remove PageMappingFlags()
  mm/page-flags: remove folio_mapping_flags()
  mm: simplify folio_expected_ref_count()
  mm: rename PAGE_MAPPING_* to FOLIO_MAPPING_*
  docs/mm: convert from "Non-LRU page migration" to "movable_ops page
    migration"
  mm/balloon_compaction: "movable_ops" doc updates
  mm/balloon_compaction: provide single balloon_page_insert() and
    balloon_mapping_gfp_mask()

 Documentation/mm/page_migration.rst  |  39 ++--
 arch/powerpc/platforms/pseries/cmm.c |   2 +-
 drivers/misc/vmw_balloon.c           |   3 +-
 drivers/virtio/virtio_balloon.c      |   4 +-
 fs/proc/page.c                       |   4 +-
 include/linux/balloon_compaction.h   |  90 ++++-----
 include/linux/fs.h                   |   2 +-
 include/linux/migrate.h              |  46 +----
 include/linux/mm.h                   |   4 +-
 include/linux/mm_types.h             |   1 -
 include/linux/page-flags.h           | 106 +++++++----
 include/linux/pagemap.h              |   2 +-
 include/linux/zsmalloc.h             |   2 +
 mm/balloon_compaction.c              |  21 ++-
 mm/compaction.c                      |  44 +----
 mm/gup.c                             |   4 +-
 mm/internal.h                        |   2 +-
 mm/ksm.c                             |   4 +-
 mm/memory-failure.c                  |   4 +-
 mm/memory_hotplug.c                  |  10 +-
 mm/migrate.c                         | 271 ++++++++++++++++-----------
 mm/page_alloc.c                      |  13 +-
 mm/page_isolation.c                  |  12 +-
 mm/rmap.c                            |  16 +-
 mm/util.c                            |   6 +-
 mm/vmscan.c                          |   6 +-
 mm/zpdesc.h                          |  15 +-
 mm/zsmalloc.c                        |  33 ++--
 28 files changed, 373 insertions(+), 393 deletions(-)


base-commit: 31a2460cb90e6ac3604c72fb54e936b8129fec05
-- 
2.49.0


