Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A91380EDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhENRZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 13:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235163AbhENRZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 13:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621013049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulvwg2ZaPIw7oToA7TTsrb85Bhlj+6R6HqazJ1k8M40=;
        b=TvrjppwLh/ASw0HT5iQ+Ne5yOuXZdhKxsmS4gxXWCyHuHFh2LI6ZhIGzh0PxfX6L/QO6XF
        MT1o3qldzDD31BLLMtjltCEwDcKp8JHM+4To19namYrekmj7WmzW/E8+Axc33VlGifzjdV
        7vCRFmwEhl5EPOz6OXpwtXGLiso+EHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-OcdPAodxOoS1AkW-8Jin5A-1; Fri, 14 May 2021 13:24:06 -0400
X-MC-Unique: OcdPAodxOoS1AkW-8Jin5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D179B8015DB;
        Fri, 14 May 2021 17:24:03 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F07801971B;
        Fri, 14 May 2021 17:23:54 +0000 (UTC)
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
Subject: [PATCH v2 6/6] fs/proc/kcore: use page_offline_(freeze|thaw)
Date:   Fri, 14 May 2021 19:22:47 +0200
Message-Id: <20210514172247.176750-7-david@redhat.com>
In-Reply-To: <20210514172247.176750-1-david@redhat.com>
References: <20210514172247.176750-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's properly synchronize with drivers that set PageOffline().
Unfreeze/thaw every now and then, so drivers that want to set PageOffline()
can make progress.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 92ff1e4436cb..982e694aae77 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -313,6 +313,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 {
 	char *buf = file->private_data;
 	size_t phdrs_offset, notes_offset, data_offset;
+	size_t page_offline_frozen = 1;
 	size_t phdrs_len, notes_len;
 	struct kcore_list *m;
 	size_t tsz;
@@ -322,6 +323,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	int ret = 0;
 
 	down_read(&kclist_lock);
+	/*
+	 * Don't race against drivers that set PageOffline() and expect no
+	 * further page access.
+	 */
+	page_offline_freeze();
 
 	get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
 	phdrs_offset = sizeof(struct elfhdr);
@@ -480,6 +486,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			}
 		}
 
+		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES == 0) {
+			page_offline_thaw();
+			cond_resched();
+			page_offline_freeze();
+		}
+
 		if (&m->list == &kclist_head) {
 			if (clear_user(buffer, tsz)) {
 				ret = -EFAULT;
@@ -565,6 +577,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	}
 
 out:
+	page_offline_thaw();
 	up_read(&kclist_lock);
 	if (ret)
 		return ret;
-- 
2.31.1

