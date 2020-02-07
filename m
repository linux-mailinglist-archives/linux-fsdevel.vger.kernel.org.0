Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4415513D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 04:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgBGDhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 22:37:40 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13343 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgBGDhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:37:39 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3cdb680002>; Thu, 06 Feb 2020 19:37:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 19:37:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Feb 2020 19:37:37 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 03:37:36 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Feb 2020 03:37:36 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3cdb800005>; Thu, 06 Feb 2020 19:37:36 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v5 04/12] mm: introduce page_ref_sub_return()
Date:   Thu, 6 Feb 2020 19:37:27 -0800
Message-ID: <20200207033735.308000-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207033735.308000-1-jhubbard@nvidia.com>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581046632; bh=DhMMWR0L+su36XhWVkaUTT8AIpyvoaCJ7tCBpQiPc3M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=qCL7wJvyuAIwVgPSCBkxszuO0dlj80eWg/EDbClYxweQTRNHL+GTW+zK5ITf9LNig
         uRb9r+NQmOvLYXjHpxOGosNBSj7qAFzD1Gp/gXOyn3l/7Eqt4KN7cqUq1efOgufStl
         7Bea1KDIgNa9pQWBFdc/LdEPKGUGmPWbDZMoxCXH+5lY5tU5TD64FzekAlyXNuUnXd
         Myo9xS52/un25I1eAeSv6b3cg81SSkeMiPJec39TyWWzQLsEdozMVBZqphrxjT7MNM
         jkW3BmWsPJ7q587TT4lIOdnmBBkxgFCDUucq88TsdGmsVVI9cKN0B+bb69YA/DJtdV
         8Nhet+MSTrAig==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An upcoming patch requires subtracting a large chunk of refcounts from
a page, and checking what the resulting refcount is. This is a little
different than the usual "check for zero refcount" that many of the
page ref functions already do. However, it is similar to a few other
routines that (like this one) are generally useful for things such as
1-based refcounting.

Add page_ref_sub_return(), that subtracts a chunk of refcounts
atomically, and returns an atomic snapshot of the result.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/page_ref.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 14d14beb1f7f..d27701199a4d 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -102,6 +102,15 @@ static inline void page_ref_sub(struct page *page, int=
 nr)
 		__page_ref_mod(page, -nr);
 }
=20
+static inline int page_ref_sub_return(struct page *page, int nr)
+{
+	int ret =3D atomic_sub_return(nr, &page->_refcount);
+
+	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, -nr, ret);
+	return ret;
+}
+
 static inline void page_ref_inc(struct page *page)
 {
 	atomic_inc(&page->_refcount);
--=20
2.25.0

