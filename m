Return-Path: <linux-fsdevel+bounces-43750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD2A5D393
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 01:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910A23B4540
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 00:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997763D81;
	Wed, 12 Mar 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAXKzrVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D03F12E7F
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738098; cv=none; b=Jjsg+mITjVblbo37UhDeYwHWEsDcsIIYeci1GkeslWsu2wwwNFaC+eAjgFz87Q4DbW40LgdH83JEzAoyZh2NgdVCBtybr5aX9piwAs1kJ48Ufxyp9vSfj5srWFthx2u/0YVliIfJycXduv4bmD6ThrGM+2NO0SSS+NTB0WEmAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738098; c=relaxed/simple;
	bh=7JAKR1B2EJs5OMc3kDKDyMYaNnMBEQeVe+0pTH470+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmT3pFz8MUW2cHrBzg2BUsLJ5sl5mXmDfOahPkWMzZi1hkhNE82MIcDVGUZMHwhZsgzzEiJWhR1rpw/ksEVjIcoZRiX6BBEYZIHf/qE1nPR5iXABRZ4VT3igYigl/5LBrW8qtuRmAb+cbt2qIJ4bBzSO8fpUwHJZ7qnaIS7QrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAXKzrVa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741738095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGPxM9RdXtkX+Els8nvXOJm60GkYwZd/fztNUeVaxvI=;
	b=BAXKzrVa2UcUeyKCZ60+1DRsaTld9aBR8Qpq5KfsblfeaYGCE8RjDZTpHax+2gM57G9mlM
	SISiVEsYhVcPpbjqFECaXls9LejjtX6Jpp1Huwc3nMFdfX/bP1wnDHpXx+UGrKgtdFdKXV
	zQU9O7yKEE754tkHDlmc87rKkMa9ZeI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-a_RbZen0O8GYnddRn1Kahg-1; Tue,
 11 Mar 2025 20:08:11 -0400
X-MC-Unique: a_RbZen0O8GYnddRn1Kahg-1
X-Mimecast-MFC-AGG-ID: a_RbZen0O8GYnddRn1Kahg_1741738088
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 942B7180AF4C;
	Wed, 12 Mar 2025 00:08:07 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B44AA1955DDD;
	Wed, 12 Mar 2025 00:08:00 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com,
	alexander.atanasov@virtuozzo.com
Subject: [RFC 5/5] xen: balloon: update the NR_BALLOON_PAGES state
Date: Tue, 11 Mar 2025 18:07:00 -0600
Message-ID: <20250312000700.184573-6-npache@redhat.com>
In-Reply-To: <20250312000700.184573-1-npache@redhat.com>
References: <20250312000700.184573-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Update the NR_BALLOON_PAGES counter when pages are added to or
removed from the Xen balloon.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 drivers/xen/balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 163f7f1d70f1..65d4e7fa1eb8 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -157,6 +157,8 @@ static void balloon_append(struct page *page)
 		list_add(&page->lru, &ballooned_pages);
 		balloon_stats.balloon_low++;
 	}
+	inc_node_page_state(page, NR_BALLOON_PAGES);
+
 	wake_up(&balloon_wq);
 }
 
@@ -179,6 +181,8 @@ static struct page *balloon_retrieve(bool require_lowmem)
 		balloon_stats.balloon_low--;
 
 	__ClearPageOffline(page);
+	dec_node_page_state(page, NR_BALLOON_PAGES);
+
 	return page;
 }
 
-- 
2.48.1


