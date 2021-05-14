Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2737380ECD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhENRYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 13:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235100AbhENRYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 13:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621013011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeyyYgXMaIv1KkLK2Mxpk2s8iuflkxKOKdYcMCECEco=;
        b=h7nEeqQwCW1ub5i6tGx6CMyORlkPCSg5gZ/ffOeJbSh9XV8urXK7UAJJEQHvggCgErcJjj
        RmUZIlDQrX/7B4In2kZawJH/7TX/dayYceRkNq0opemoK1/AnRp0hXqkQ+jOPKzh95lGAv
        Y8GNx3nosTjUjGOXhmLR7Mjl7J4ZfnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-DoFLkz1YPr-E5fxCEaU49Q-1; Fri, 14 May 2021 13:23:29 -0400
X-MC-Unique: DoFLkz1YPr-E5fxCEaU49Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BFDA107ACCA;
        Fri, 14 May 2021 17:23:26 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 671681A868;
        Fri, 14 May 2021 17:23:11 +0000 (UTC)
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
Subject: [PATCH v2 2/6] fs/proc/kcore: pfn_is_ram check only applies to KCORE_RAM
Date:   Fri, 14 May 2021 19:22:43 +0200
Message-Id: <20210514172247.176750-3-david@redhat.com>
In-Reply-To: <20210514172247.176750-1-david@redhat.com>
References: <20210514172247.176750-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's resturcture the code, using switch-case, and checking pfn_is_ram()
only when we are dealing with KCORE_RAM.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 09f77d3c6e15..ed6fbb3bd50c 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -483,25 +483,36 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				goto out;
 			}
 			m = NULL;	/* skip the list anchor */
-		} else if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
-			if (clear_user(buffer, tsz)) {
-				ret = -EFAULT;
-				goto out;
-			}
-		} else if (m->type == KCORE_VMALLOC) {
+			goto skip;
+		}
+
+		switch (m->type) {
+		case KCORE_VMALLOC:
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
 			if (copy_to_user(buffer, buf, tsz)) {
 				ret = -EFAULT;
 				goto out;
 			}
-		} else if (m->type == KCORE_USER) {
+			break;
+		case KCORE_USER:
 			/* User page is handled prior to normal kernel page: */
 			if (copy_to_user(buffer, (char *)start, tsz)) {
 				ret = -EFAULT;
 				goto out;
 			}
-		} else {
+			break;
+		case KCORE_RAM:
+			if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
+				if (clear_user(buffer, tsz)) {
+					ret = -EFAULT;
+					goto out;
+				}
+				break;
+			}
+			fallthrough;
+		case KCORE_VMEMMAP:
+		case KCORE_TEXT:
 			if (kern_addr_valid(start)) {
 				/*
 				 * Using bounce buffer to bypass the
@@ -525,7 +536,15 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 					goto out;
 				}
 			}
+			break;
+		default:
+			pr_warn_once("Unhandled KCORE type: %d\n", m->type);
+			if (clear_user(buffer, tsz)) {
+				ret = -EFAULT;
+				goto out;
+			}
 		}
+skip:
 		buflen -= tsz;
 		*fpos += tsz;
 		buffer += tsz;
-- 
2.31.1

