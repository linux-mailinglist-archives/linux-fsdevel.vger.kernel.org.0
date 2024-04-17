Return-Path: <linux-fsdevel+bounces-17112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D98A7F8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 11:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F2281A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DCE12F362;
	Wed, 17 Apr 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGU9TyIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF446128369
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345807; cv=none; b=jkYlm3l1E2/IK1KsJDIXUFbQZTB28O+WtReZCw+O24gqpZQh21Ip6NcXceD5fr+6tPmiXL/suVAX7PNhWZ9k8v+TaA8tu8XNXVWqXIQo5Hr39QanTa8y0B1nRDheYFcKaot4vx/fQXeOK3rXAxKLvvHR9uhjSDBLxseKNLRa2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345807; c=relaxed/simple;
	bh=ifRF7MXrQq10i+uw8Rl4fho6IifyZNHb6ek51KO9eBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XiUcTVZDMZUAo36eYJ8RRAeSLsEidZxXrRj0Df52gvJjkrpRlkcaM3bwVtgL+8K6Zm1294X6y7TMe1EXrcS9B8BLTGyD6DGDxFDzRNj/S7fIUtXauy1rC91/vyA990Uh1GNB/cQnMPG0eqrXZnVcLpBqTUi2yOlRi2Kq4Efg6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGU9TyIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713345804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wRALUHhCTPk5aVMKCZs8Z/x2U++tzqWFRV8+xLfn/RM=;
	b=WGU9TyIOsDRqBq/QWpD3PmSktU2UVEYZrcZOm00ounwKX3FBOdIJV3v3lvz8L8SMK/ULgM
	fLxeCkNEsVXF1+OyX6JbJ3nrJZmQHwYO2aDrlQSES+iu6SEtDBQhfWtXzKuyvpSCplJmLA
	uB0PyVG2KTOGWktWvY9VwjP+I7jPRqw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-q5abbk0-MmOAKfyrO-Ikcg-1; Wed, 17 Apr 2024 05:23:21 -0400
X-MC-Unique: q5abbk0-MmOAKfyrO-Ikcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DF4A830E91;
	Wed, 17 Apr 2024 09:23:20 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C105B2166B31;
	Wed, 17 Apr 2024 09:23:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 0/2] fs/proc/task_mmu: convert hugetlb functions to work on folis
Date: Wed, 17 Apr 2024 11:23:11 +0200
Message-ID: <20240417092313.753919-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Let's convert two more functions, getting rid of two more page_mapcount()
calls.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>

David Hildenbrand (2):
  fs/proc/task_mmu: convert pagemap_hugetlb_range() to work on folios
  fs/proc/task_mmu: convert smaps_hugetlb_range() to work on folios

 fs/proc/task_mmu.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.44.0


