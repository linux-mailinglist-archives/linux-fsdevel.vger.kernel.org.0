Return-Path: <linux-fsdevel+bounces-52065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153FCADF474
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42FB165B5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD12FE303;
	Wed, 18 Jun 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzKhr2mW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF32FCFCF
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268453; cv=none; b=GjwJsVHtsp+32VqzmoVEnfSgXYsANouDAb6QVldNo6snfhNULja7JHJcFkI0AzP89M43DttGPhaofTkA+eTrlw639pr/u9X8zGcCeKGPWzbZvPVlHffHJ5wbcyGHDChPzCQ69AIMbEtlch1rmB8xZjqPF5tOS+m9Igyh4cNr8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268453; c=relaxed/simple;
	bh=4i7IUlR1GYEmR6zjKB+4nkWLQlvD9f6ku5JrjlUDoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZG11Pu0phpXrpHSm7jRJCvSaGUhRfwg99v/R0B6qb5Q+X+a3DIr6GNldh5+g7JG0/ruJi9a+LlljfBN0kWqyvYLBAQQAcotm9ZfOy6NkljiOvbHVqsf3UTVBW9kyjO2EdFAr6o5HAIUPEwQSdpC3OuzQisZ75IH0YA6pmvTgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzKhr2mW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwm1uiBUBcXGnja63XmY2QjIjVtNliVfN8dAKrOXwFc=;
	b=OzKhr2mW0C3VZaN3pKFEDZXtF49sL9eT7aPlwfAlz+uSwd+2BeGNLSFxudntRbOaALGi2z
	LON1oA7CcLCAeAAAN4/Qcrj/rfHH6KYwtoh59Ty+2BNQ9g+8jZg+drWUF4fkAfL4dXg/mD
	q3mTgl0VgAZjBYvL8gRdX8Fi04rVekE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-NTjAk_jnO3G1TG-nRYReTg-1; Wed, 18 Jun 2025 13:40:45 -0400
X-MC-Unique: NTjAk_jnO3G1TG-nRYReTg-1
X-Mimecast-MFC-AGG-ID: NTjAk_jnO3G1TG-nRYReTg_1750268444
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so4232732f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268444; x=1750873244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwm1uiBUBcXGnja63XmY2QjIjVtNliVfN8dAKrOXwFc=;
        b=WqAaU7Fr86zSCcY0pdNiGQEqPRnqvj3kg7Yt2GMOaRITZHfOoGbuRZxoEVlrK05cGK
         030AugbeTI0jcyoofFQxcaxKEYFoQ/YElQxcioMnccs33SpFMb9nQvOxK73YAk4jal3+
         u29YYVYD+E/iQmytevnGnyM9e1ip4sanLv8dS+gTUhutCiDL0dNl79hwj0bc/7Dt+lkT
         g4GIDGBe5pWhRgu43h6JVL0U1qCXnXcemEXmrH6wmPzcgeXmpSoCePzldhbEmK5zJlYi
         dg/xz9lEsNqMlck8xaueI9ZHkk80/cNxdZjOhjDdgsIzB20okkVTR9psWOfVBCmUCYOs
         bmqA==
X-Forwarded-Encrypted: i=1; AJvYcCU+MzdfaSIXINwgPPy39DbKRLKLvbkXsNluxA+sH7tIJUkJKwiMc1H1159pMyShGV7yEViidzNRfv1aVfLz@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+eaotin0vReJ20EJo73CKSi+97lx3NWI4Q2kXV6lz2Yw5qaU
	VKgm7rzaYqOJpQleO9j5RulHiVXS+O5xIXUlvmFZMeHp3L23klmxmRCpTe5F36mjq/ziOMcHfGY
	7ijFJflr5s5iHWHbB6R+KFbQ6okjbRTuQbCQqYLNVp5qLnkUzr0bkRbGgG6cUe258eH8=
X-Gm-Gg: ASbGncvSWGryfDcVuGrJpykYoqS/WWVxod1xXO9E1nui6t+nsQMDGGH+WDgcODlyiVi
	Gm5werwBoyuphh1sY/ipRwPCD2w/cIqNOqvULT81kqLr/OUpaMuezZ4qCzh5PadtlWt8tzKyhss
	fE9LSZjJow8CKIiIFWJgykRyTVjpGpmVihJyR1dvCGC3H3AGPyJ/kRFPN1OoZHuU4uAt2Ler0FI
	KEwKPOLyxCPjXqHnv3pAYa5wA50SfI5GMLVmHesJzlPg/4dPZ8PTO2J3d82ivbu0oYzsGlFfpx8
	UzVMtwSyt5iWd+43UgQ1w32sLgxGCpVSI6b9N1ng+Y75Ga128vVqASFuFKMgiO/WMduYMOxyc7L
	ftGAdQg==
X-Received: by 2002:a05:6000:71c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a572367afbmr15684693f8f.4.1750268443740;
        Wed, 18 Jun 2025 10:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEywSnKMkZlpTz2OAMYD8vOZkvPdDtLDDWrsPSDJX8ViTkX0laZRXIHvaFqn8ElXQBewjN+xg==
X-Received: by 2002:a05:6000:71c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a572367afbmr15684628f8f.4.1750268443292;
        Wed, 18 Jun 2025 10:40:43 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a54b7asm17688084f8f.16.2025.06.18.10.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:42 -0700 (PDT)
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
Subject: [PATCH RFC 10/29] mm/migrate: remove folio_test_movable() and folio_movable_ops()
Date: Wed, 18 Jun 2025 19:39:53 +0200
Message-ID: <20250618174014.1168640-11-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Folios will have nothing to do with movable_ops page migration. These
functions are now unused, so let's remove them.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c0ec7422837bd..c99a00d4ca27d 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -118,20 +118,6 @@ static inline void __ClearPageMovable(struct page *page)
 }
 #endif
 
-static inline bool folio_test_movable(struct folio *folio)
-{
-	return PageMovable(&folio->page);
-}
-
-static inline
-const struct movable_operations *folio_movable_ops(struct folio *folio)
-{
-	VM_BUG_ON(!__folio_test_movable(folio));
-
-	return (const struct movable_operations *)
-		((unsigned long)folio->mapping - PAGE_MAPPING_MOVABLE);
-}
-
 static inline
 const struct movable_operations *page_movable_ops(struct page *page)
 {
-- 
2.49.0


