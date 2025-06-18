Return-Path: <linux-fsdevel+bounces-52061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56FCADF453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D393188A50B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABFD2FE376;
	Wed, 18 Jun 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLaAO7s6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894822F49E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268441; cv=none; b=m9toAr9V0EHnLLsxOvAzKnt2hZfTuLdmMQJKQQb9/Okvj7YnvA+N1Ewx1w+hBOvjE1hJsq45KHbq4Ugsva+hG6rmRaez1oJoxYe8S5GOf6ym2RxqtJZwdf8IBDl0FgoD8YAVp6dnsRZBOvSYfH79I50U/60eAdGVNt6TVxJ3nzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268441; c=relaxed/simple;
	bh=qK/hSpqxPHXWhlFplYYMa5g7zmr2Q/EzGHQmEAB7ZSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdYh11AAESsv+vkxEmxuJ7T8c5bp32/LXv4KXZWxSgy/5N+43qsMIAOAxV65vfMaHBgX5uUkPnlB0R88lUnKa/u2Xb9O0V6Rsx5M4xSgGoyOaEF+dF6kwjixa+icagMl6lEyie0Ht0RCdO8mGPKq83kvGntIAbJEgQeJT73K1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLaAO7s6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkYbA0acVo3UX9Us91PPuYxLoMCXI95NEZ07wm0hikY=;
	b=MLaAO7s62Qx+uKwVO+fXEakwd3NHdyOwxRoVprS/QLvHvlJLhBiprjlSOC4hgpOsPDzNvU
	21Yba7k7sil8A0qqAIqacsrO9Ru9jtcX2CEEFydjd4O1CNotdzD81Fd2tad3P8sc3FW4qb
	kuREePUPyv+nD44k7TGScCM8jt9KoGA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-tQ6sm7oSPZ6ob3le8aAp-Q-1; Wed, 18 Jun 2025 13:40:32 -0400
X-MC-Unique: tQ6sm7oSPZ6ob3le8aAp-Q-1
X-Mimecast-MFC-AGG-ID: tQ6sm7oSPZ6ob3le8aAp-Q_1750268430
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso3281470f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268430; x=1750873230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkYbA0acVo3UX9Us91PPuYxLoMCXI95NEZ07wm0hikY=;
        b=F9XRVi7yntL0ghvy8Wb1UKmkhK/l7NGcrdPOd4SgiDveqtz9rwEsPc5f5C0zdtFY7X
         +4dK7BGMrUPBv5RAx+Le6x55DL/dvk4KduVnyUcqp97Tbv2ZiFt1/wCZ37uT0ziBSLkP
         XK/dFPb6YvngGlvafIw7Vf61AcpYfrGh6TMKX/kbWaONlAhCSzI+pUEuJUl4+tczDINz
         2hMEykje2LDfjnDSZl0LctkAimCtZQPKFPX+aCULB41XuspExSMitOPnHSn/oHg2gY3b
         O3Aj9aKqfUx1tE1NMzD/HnoS+LKwXVWB2r0s/n+Z0JJNkIyrIwlGksPlOV4NvVCKxUcG
         Y61w==
X-Forwarded-Encrypted: i=1; AJvYcCXgwgD444TnRfVbJ+gTeyp7wnY5r1HyV6cIItSPaQAz/5kZM1vzcygAsIGxq8AgAI1ibxoEzPQ6VwIdP7UW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1A23EdhmwPFKXbKg150YGBUPOg7s7HnbowOoZPcg4SNNQkwPr
	YjPLQyfHDmIdUbmevVo+W9F726g7X6RTz3XBwCbT3qVOyJwT7VS41KWg6VlDzzwtHuDn6Ylfj1L
	rqXBKTAYyMBjvLkkFyPXueio4jOyVm2m+MK6iETCbL1ZG7qf/nr4+3qV93VX8hOdlLLA=
X-Gm-Gg: ASbGnctkOWHDGxDtq3TWh6NU7Zcle09dBqHmLObkyXSpq9LEldl0FvGfqobh096Bhn/
	vFvLHw2/sGoDdz3DbWBv8tEy9pXQ/xUtH3x/8+hT1fnSgjqdeiWfA1lNzOmdEOCNbDsFb9hTfjX
	4SH8wpifreBYkcMWJr0zTMqMHn977cTcyd2r2k0UMwCsduk0aRQ9di8VCAtGJec+um0kyrNU612
	kfcLldTu0Gg17PD9DeblTXnTscwAhwskS+LoiRBWM24Th9Ov6qxNMMe4fgYNQJVHBT5Yx0t8f/m
	n2oDj5gB6+nPhD9QZDfO2gIh330jLhsnaDdTtjhn7KGa2KytCLwNwgqMgpYkzaozzxYb1yOal3N
	mGVHiBQ==
X-Received: by 2002:a05:6000:71c:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a572367972mr13745213f8f.1.1750268430449;
        Wed, 18 Jun 2025 10:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzzxL/ng01qs/lSRwaNlZPiY9y2+iVmfz3gXJp3VGo7LunL2znQ2yg0q95yDx7nL6kngLoWg==
X-Received: by 2002:a05:6000:71c:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a572367972mr13745179f8f.1.1750268430076;
        Wed, 18 Jun 2025 10:40:30 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b62ba7sm17864640f8f.91.2025.06.18.10.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:29 -0700 (PDT)
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
Subject: [PATCH RFC 05/29] mm/balloon_compaction: make PageOffline sticky
Date: Wed, 18 Jun 2025 19:39:48 +0200
Message-ID: <20250618174014.1168640-6-david@redhat.com>
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

Let the buddy handle clearing the type.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index b9f19da37b089..bfc6e50bd004b 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -140,7 +140,7 @@ static inline void balloon_page_finalize(struct page *page)
 		__ClearPageMovable(page);
 		set_page_private(page, 0);
 	}
-	__ClearPageOffline(page);
+	/* PageOffline is sticky until the page is freed to the buddy. */
 }
 
 /*
-- 
2.49.0


