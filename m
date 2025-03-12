Return-Path: <linux-fsdevel+bounces-43745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0AA5D378
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 01:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C00E3B292A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 00:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881A4C85;
	Wed, 12 Mar 2025 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8b/YNwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DAF4A01
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738058; cv=none; b=GJwQvuX51WD9jUGPUjrQ3WdSs2DqsaTn8hxr7zDBHDEDV0pZj+mBBZTCQdZl8cILynPvfhkO2hmam6flUIEg/fK6A/Y2cnBfrrqP+4Hl8ht+um0d7sqfbbb8dWEgCnkESSDTgTzChhUKG4ObLmUO1JJByf/KEO81LM5y+zTqNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738058; c=relaxed/simple;
	bh=ahoiaCICAThel6fGzAyXhFBeyWeKIoJcx5Q+1e5zZN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uV8i4sJqU0wuJ//xD6DqDCM5OZFTrsc7VGB2qp2suNwq/4SDLnvl7AUGr2OkeoGIIk7uohq4ToUjxkh46X/jB72s8FCrZQgwQbz/K55B4g/XeoOhc7OdUFGYbLBGj80tpOjRwBw3bzZGrkc+QEGLU8vccfySt164ppk/c+emj4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8b/YNwO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741738055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Jp3d8TwivY0inesFFsBMmfW4NNIDtSVjUkd3EkZcf4=;
	b=c8b/YNwOHP7J7drlwWoxoirX7EupAtG4LZTPFPSxOnJ3Gd9w5688d/Ng2yGtJ2reHkJBNY
	XAM9upSqu+yhuiDjAm5XRNpRWNwnZXgxAOmHc43nSYtqqh1kggCeIMUFEt5zwt3hqFM4wJ
	FWfp/so7rKASrR2EC584eW2VzOWQEt8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-tVpdxDOENfqjZCOHY5FruQ-1; Tue,
 11 Mar 2025 20:07:34 -0400
X-MC-Unique: tVpdxDOENfqjZCOHY5FruQ-1
X-Mimecast-MFC-AGG-ID: tVpdxDOENfqjZCOHY5FruQ_1741738051
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F07CE195608A;
	Wed, 12 Mar 2025 00:07:29 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20D971956094;
	Wed, 12 Mar 2025 00:07:20 +0000 (UTC)
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
Subject: [RFC 0/5] track memory used by balloon drivers
Date: Tue, 11 Mar 2025 18:06:55 -0600
Message-ID: <20250312000700.184573-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This series introduces a way to track memory used by balloon drivers.

Add a NR_BALLOON_PAGES counter to track how many pages are reclaimed by the
balloon drivers. First add the accounting, then updates the balloon drivers
(virtio, Hyper-V, VMware, and Xen) to maintain this counter.

This makes the information visible in memory reporting interfaces like
/proc/meminfo, show_mem, and OOM reporting.

This provides admins visibility into their VM balloon sizes without
requiring different virtualization tooling. Furthermore, this information
is helpful when debugging an OOM inside a VM.

Tested: virtio_balloon, run stress-ng, inflate balloon, oom prints
Signed-off-by: Nico Pache <npache@redhat.com>

Nico Pache (5):
  meminfo: add a per node counter for balloon drivers
  virtio_balloon: update the NR_BALLOON_PAGES state
  hv_balloon: update the NR_BALLOON_PAGES state
  vmx_balloon: update the NR_BALLOON_PAGES state
  xen: balloon: update the NR_BALLOON_PAGES state

 drivers/hv/hv_balloon.c         | 2 ++
 drivers/misc/vmw_balloon.c      | 5 ++++-
 drivers/virtio/virtio_balloon.c | 4 ++++
 drivers/xen/balloon.c           | 4 ++++
 fs/proc/meminfo.c               | 2 ++
 include/linux/mmzone.h          | 1 +
 mm/memcontrol.c                 | 1 +
 mm/show_mem.c                   | 4 +++-
 mm/vmstat.c                     | 1 +
 9 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.48.1


