Return-Path: <linux-fsdevel+bounces-16489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B549189E394
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9011C2141E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65513157495;
	Tue,  9 Apr 2024 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qqjlc9uO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F573157A6F
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690838; cv=none; b=FPQkuxx+EaK7O5iCawKcqxIXIsImzMKfv488c5zSno1jVQZOxs5GWkS1ZdAzCnjkhIoFbCxc+s3f+MSsCm9MwlNy9GYCCPshQ8R4qErlsu4hLUAkBqsq5dHDd8ttxiRqKP7lEgYfd7M8aBXstl67FMF8R4il8wZFbg/dR+fx+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690838; c=relaxed/simple;
	bh=zq0eZo/dQN8kHyMpocUFZ1dZ9OgFSNipiTHPXkCAd8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0UYeNzJfbuyvBrGBMa+JiuCHQq1fTDMwBJ5ENiO+Ivg9upfZ30cox+z5yPgT/Y3wx7qqKPmczuy7lx5qsO9ZYMRtTj6fs7cAHsT9vg43q1aNZf6CxX5bS0WqFXhCY0VG8CEaG9+8oAf0qS9DO643CHKNql9wTXj0PyAVgDjgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qqjlc9uO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIAPKUbl/14adNwXxGFYrjBvnjcRb79R1asl7bmu1AM=;
	b=Qqjlc9uObVNDoVp2u6r+lUync36ccKEqh+xcuZOBYebclTK1KYnBehoEZMccJ+P2VfxXzl
	pMD4GFLcfYxurKUzQeUpiXEkDN5n1iPiOOaotWKUnkgBz9FMgCHCVKsxVnsSPXKGhW9XkW
	0Duh/kZN0COpjIvtwKZDEL0bFnkYps8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-cPzfINHFMa2e8lR0ggInCw-1; Tue, 09 Apr 2024 15:27:12 -0400
X-MC-Unique: cPzfINHFMa2e8lR0ggInCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A5CC830E7B;
	Tue,  9 Apr 2024 19:27:11 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9D8740B4980;
	Tue,  9 Apr 2024 19:26:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 18/18] Documentation/admin-guide/cgroup-v1/memory.rst: don't reference page_mapcount()
Date: Tue,  9 Apr 2024 21:23:01 +0200
Message-ID: <20240409192301.907377-19-david@redhat.com>
In-Reply-To: <20240409192301.907377-1-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Let's stop talking about page_mapcount().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 46110e6a31bb..9cde26d33843 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -802,8 +802,8 @@ a page or a swap can be moved only when it is charged to the task's current
 |   | anonymous pages, file pages (and swaps) in the range mmapped by the task |
 |   | will be moved even if the task hasn't done page fault, i.e. they might   |
 |   | not be the task's "RSS", but other task's "RSS" that maps the same file. |
-|   | And mapcount of the page is ignored (the page can be moved even if       |
-|   | page_mapcount(page) > 1). You must enable Swap Extension (see 2.4) to    |
+|   | The mapcount of the page is ignored (the page can be moved independent   |
+|   | of the mapcount). You must enable Swap Extension (see 2.4) to            |
 |   | enable move of swap charges.                                             |
 +---+--------------------------------------------------------------------------+
 
-- 
2.44.0


