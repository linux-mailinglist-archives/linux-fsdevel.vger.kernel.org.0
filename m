Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B2236EA6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhD2M2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 08:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhD2M2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619699250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8j9mBor07Cs8M7oV014u0wi5MvoFT2r3E+Kj0uohzbw=;
        b=Q2ueY/bfihQWmJVU0cBapVR4RsBG7nHK9D0GbgdWNkPFnsWVzglmQpyvCIqsg8RPj9pC3B
        jFmoYxNjRIZG73BktbxPRvks+JVYeWGW0wHZ+tpFSIHo6UuamcCnL92t/6R9rRx5z0o44U
        YY/bgFDkagGsocpfcnnprkgHWeiar7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-mextiE51O4S-F0gnYD4sAg-1; Thu, 29 Apr 2021 08:27:26 -0400
X-MC-Unique: mextiE51O4S-F0gnYD4sAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 097B8108BD0C;
        Thu, 29 Apr 2021 12:27:22 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-50.ams2.redhat.com [10.36.114.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C62B318811;
        Thu, 29 Apr 2021 12:26:43 +0000 (UTC)
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
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 7/7] fs/proc/kcore: use page_offline_(freeze|unfreeze)
Date:   Thu, 29 Apr 2021 14:25:19 +0200
Message-Id: <20210429122519.15183-8-david@redhat.com>
In-Reply-To: <20210429122519.15183-1-david@redhat.com>
References: <20210429122519.15183-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's properly synchronize with drivers that set PageOffline(). Unfreeze
every now and then, so drivers that want to set PageOffline() can make
progress.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 92ff1e4436cb..3d7531f47389 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -311,6 +311,7 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
 static ssize_t
 read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 {
+	size_t page_offline_frozen = 0;
 	char *buf = file->private_data;
 	size_t phdrs_offset, notes_offset, data_offset;
 	size_t phdrs_len, notes_len;
@@ -509,6 +510,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			pfn = __pa(start) >> PAGE_SHIFT;
 			page = pfn_to_online_page(pfn);
 
+			/*
+			 * Don't race against drivers that set PageOffline()
+			 * and expect no further page access.
+			 */
+			if (page_offline_frozen == MAX_ORDER_NR_PAGES) {
+				page_offline_unfreeze();
+				page_offline_frozen = 0;
+				cond_resched();
+			}
+			if (!page_offline_frozen++)
+				page_offline_freeze();
+
 			/*
 			 * Don't read offline sections, logically offline pages
 			 * (e.g., inflated in a balloon), hwpoisoned pages,
@@ -565,6 +578,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	}
 
 out:
+	if (page_offline_frozen)
+		page_offline_unfreeze();
 	up_read(&kclist_lock);
 	if (ret)
 		return ret;
-- 
2.30.2

