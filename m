Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2528A3913B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhEZJch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 05:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233356AbhEZJch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 05:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622021466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/osWbHv9H+D8jMkXYe0YG4c0I4+JjXX9FiaLxBUqIoc=;
        b=h2WdEny7QWf0X6bBsQZpBkA1zQ6d7c4tKYGcdHfgUER8gjtItSMiDzFIve7LY539cd8Zlf
        zGRPUs0CEisnX6OfmUeVFyLHatwX1TDTP/ZrXXkQ47whaXnlqKn6au0P+PVgQRdz22Q/AY
        BJh4CDVCsX5bnN3GS4FHbRY/hZqTqDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-Fk8f-plUN86vXtXK6gxEqw-1; Wed, 26 May 2021 05:31:04 -0400
X-MC-Unique: Fk8f-plUN86vXtXK6gxEqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4833879EC1;
        Wed, 26 May 2021 09:31:01 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-99.ams2.redhat.com [10.36.113.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 174745D9CC;
        Wed, 26 May 2021 09:30:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v3 1/6] fs/proc/kcore: drop KCORE_REMAP and KCORE_OTHER
Date:   Wed, 26 May 2021 11:30:36 +0200
Message-Id: <20210526093041.8800-2-david@redhat.com>
In-Reply-To: <20210526093041.8800-1-david@redhat.com>
References: <20210526093041.8800-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit db779ef67ffe ("proc/kcore: Remove unused kclist_add_remap()")
removed the last user of KCORE_REMAP.

Commit 595dd46ebfc1 ("vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when
dumping vsyscall user page") removed the last user of KCORE_OTHER.

Let's drop both types. While at it, also drop vaddr in "struct
kcore_list", used by KCORE_REMAP only.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c       | 7 ++-----
 include/linux/kcore.h | 3 ---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 4d2e64e9016c..09f77d3c6e15 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -380,11 +380,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			phdr->p_type = PT_LOAD;
 			phdr->p_flags = PF_R | PF_W | PF_X;
 			phdr->p_offset = kc_vaddr_to_offset(m->addr) + data_offset;
-			if (m->type == KCORE_REMAP)
-				phdr->p_vaddr = (size_t)m->vaddr;
-			else
-				phdr->p_vaddr = (size_t)m->addr;
-			if (m->type == KCORE_RAM || m->type == KCORE_REMAP)
+			phdr->p_vaddr = (size_t)m->addr;
+			if (m->type == KCORE_RAM)
 				phdr->p_paddr = __pa(m->addr);
 			else if (m->type == KCORE_TEXT)
 				phdr->p_paddr = __pa_symbol(m->addr);
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index da676cdbd727..86c0f1d18998 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -11,14 +11,11 @@ enum kcore_type {
 	KCORE_RAM,
 	KCORE_VMEMMAP,
 	KCORE_USER,
-	KCORE_OTHER,
-	KCORE_REMAP,
 };
 
 struct kcore_list {
 	struct list_head list;
 	unsigned long addr;
-	unsigned long vaddr;
 	size_t size;
 	int type;
 };
-- 
2.31.1

