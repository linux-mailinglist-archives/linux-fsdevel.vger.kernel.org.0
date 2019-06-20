Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA94DC0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 22:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfFTUyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 16:54:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726781AbfFTUyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:54:07 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5KKs4vu016291
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2019 13:54:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=z7orUW1w2AFawDH57ZTLvYALJSDsMI3HPUuppHQ+jCM=;
 b=BeRNQIsvId5MZwnRm+n67jDrBkFpk7yz6cY5yKEDzWJ+ysSw0utTe7k9FMC430P+EHCe
 a1CTKktxqjcwssvkSTMQLcXFTQ+xxxjN2vKph3qcgzz+FW2iXaPf/2yY8ZmZGFKh9HMo
 MIDVaXYbwzI5sX4PxhXVrqbPOq31dDgXG7Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2t7rtdd145-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2019 13:54:06 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Jun 2019 13:54:00 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 99C6262E2A35; Thu, 20 Jun 2019 13:53:58 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        <akpm@linux-foundation.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 2/6] filemap: update offset check in filemap_fault()
Date:   Thu, 20 Jun 2019 13:53:44 -0700
Message-ID: <20190620205348.3980213-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620205348.3980213-1-songliubraving@fb.com>
References: <20190620205348.3980213-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=811 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200150
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With THP, current check of offset:

    VM_BUG_ON_PAGE(page->index != offset, page);

is no longer accurate. Update it to:

    VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);

Acked-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f5b79a43946d..5f072a113535 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2522,7 +2522,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		put_page(page);
 		goto retry_find;
 	}
-	VM_BUG_ON_PAGE(page->index != offset, page);
+	VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);
 
 	/*
 	 * We have a locked page in the page cache, now we need to check
-- 
2.17.1

