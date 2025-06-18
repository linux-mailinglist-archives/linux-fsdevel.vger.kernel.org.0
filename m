Return-Path: <linux-fsdevel+bounces-52080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB7ADF4C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49214A2E51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C262FC017;
	Wed, 18 Jun 2025 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLP3Bdbl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3BC2FBFFD
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268493; cv=none; b=KHuWONH7eluBRCsycbts7gFqJn/MmkB4L3OAyQ2sJjp/j9PiiQiNAU4wRDLT/JAM87dDW+44kYRPyUiQYMdS3/gp196ppN9CPFz5cwRuuPLoYWkOj/xu+ENB/lUYXYLh6Mge8frFg86kSmaGNR14ZSpv81w2PmNHGbtjtNfe+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268493; c=relaxed/simple;
	bh=klS5wctUdaGGEO0GDFp0U+oLqOtRx0jqeVG9P2Se0qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKb9jfIe4c9N6OB/dSz/IDz6lQwBeI2rS+tUWzPvIRnR5LGwZcbCPGYC0xd+Ew3dfBuhOXcRvZ1xVIx6jSbQDeC0aQ8qi6p5uLG0IFZYEETSx7E2SwKH4NH5V8m++Sn6WLSsHurMzOOnc29ap9FdB01QPSGoqN/VzK69++Q2htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLP3Bdbl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnwUSh7o+5ZmaRZCKb6UInkhBSWZlCwshIxY9Qz5Cgk=;
	b=TLP3Bdbl24A+KEJrZv6x7QtuvYOgh5W6/Q71S3A7UgkGBXpZ7v9nWtbTXsE+Ep43lcYuZ2
	LH6MNDY0h8GBXsv2+4PWn+96KcUSQ4hceQ4LyS3vEkmi/ktm6RN0yfOT7ZLKyVIhK0G4QN
	ZHyQwsjnau55BXp5FOSsV9REYbYYppk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-GYeO0drvMD-R6_6Blwzqlg-1; Wed, 18 Jun 2025 13:41:27 -0400
X-MC-Unique: GYeO0drvMD-R6_6Blwzqlg-1
X-Mimecast-MFC-AGG-ID: GYeO0drvMD-R6_6Blwzqlg_1750268485
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4530c186394so32133795e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268485; x=1750873285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnwUSh7o+5ZmaRZCKb6UInkhBSWZlCwshIxY9Qz5Cgk=;
        b=dZ+1Mg++vygncgjrX34rTQuRAvpMlK0lCnLhvq+8+24g/0Dy6Dfi5Ys5NNKwnCsbDm
         9N7vJdehq/886/bzGA2JzRedb4hCQtAOPiY+fzZFeXBsa7UnOhZJ9d2Jq3PLV1Ste3Lt
         0X3CsgFUJzxaiTl/toaobx6Th9uAlcIcaIaeE9hj8SmyEujjoOHdP2ulGBmSdbmvwUSk
         v+fdoYjTlYglxpouFs2EVz9wJE6/u/JSvirTWc3S5AqkFJABlzmfbqls7JuHTlOJ2IdD
         jwgTFHCBC4/Bazm3zqLQl5cFm8ICkhRxR/gYEeu6TbrY18r9Dt9yMuNOqqNRSd8HGmEo
         VvqA==
X-Forwarded-Encrypted: i=1; AJvYcCUavElX5fxZuJ5M4OpZcDDWYrnEh9QfrDWp+BAb3t/3+fpOOh0IFgN/itmdIyIvOocT/g45o+WuEI6aWGD4@vger.kernel.org
X-Gm-Message-State: AOJu0YwdBAdCIJnHU+yyHhRKGKjUxgk7BGoWFXwfFDQvEGhehAejmQuo
	KlyDPCjtv18FiqMsSKYZ4G8vvNDpDPWmX6hlSi2OyVdvq4r91rnME0jK2JluOKOOS2iYzB2gFqK
	9avcG8yEmu3eHUkr7sDqdVeNfyVxJsw0dcYPMNSU9NGMC6bvdmbXIa30oGKnrUVJDqyE=
X-Gm-Gg: ASbGncvpNFfPjD/7vsAePygsljVLmUn5wiyiQLjQ5T3iRXyrG0dmHlKaJahxwSy5CUa
	Omt21TJF/3550sLIeoEELiS3DPnMWbyDygT82No/51PCEpBX5GV8hhCx0nAQKy2IMVaU2u2jAQ0
	u4p5nQ5FeUiD6mUzksDadsPv+Ci57/g/f0I65F9DxcXRtGQH7AcV3vn2tA+0RG7OGrB6IuAz27G
	7T7+sXWQxG6IwqU+gz7wdZyCutDu+cHYqeyyAAhH1hKQX0Q1uZYivPJ50jDTAQDnvCynJ/eoZ9d
	sjPKy8yaZB6Z/qOK/J2d+MkqoJTptWhqEqd8TCWODO8eLdomVYM6bEFCHQtbIK/jhM+VdBHrXYY
	T84Epjw==
X-Received: by 2002:a05:600d:1:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-4535a04bc8amr21842945e9.26.1750268485369;
        Wed, 18 Jun 2025 10:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv5K+zuY4+JCApu2tViRQi8tnrUP4BMaDADA459jpWP1i37cwdJ2pp4j+WJZa019DgSPcT4A==
X-Received: by 2002:a05:600d:1:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-4535a04bc8amr21842675e9.26.1750268484986;
        Wed, 18 Jun 2025 10:41:24 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535ebced8asm3463925e9.40.2025.06.18.10.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:24 -0700 (PDT)
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
Subject: [PATCH RFC 25/29] mm: simplify folio_expected_ref_count()
Date: Wed, 18 Jun 2025 19:40:08 +0200
Message-ID: <20250618174014.1168640-26-david@redhat.com>
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

Now that PAGE_MAPPING_MOVABLE is gone, we can simplify and rely on the
folio_test_anon() test only.

... but staring at the users, this function should never even have been
called on movable_ops pages. E.g.,
* __buffer_migrate_folio() does not make sense for them
* folio_migrate_mapping() does not make sense for them
* migrate_huge_page_move_mapping() does not make sense for them
* __migrate_folio() does not make sense for them
* ... and khugepaged should never stumble over them

Let's simply refuse typed pages (which includes slab) except hugetlb,
and WARN.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 98a606908307b..61da588dda892 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2167,13 +2167,13 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	const int order = folio_order(folio);
 	int ref_count = 0;
 
-	if (WARN_ON_ONCE(folio_test_slab(folio)))
+	if (WARN_ON_ONCE(page_has_type(&folio->page) && !folio_test_hugetlb(folio)))
 		return 0;
 
 	if (folio_test_anon(folio)) {
 		/* One reference per page from the swapcache. */
 		ref_count += folio_test_swapcache(folio) << order;
-	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
+	} else {
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
 		/* One reference from PG_private. */
-- 
2.49.0


