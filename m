Return-Path: <linux-fsdevel+bounces-44049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B9A61E45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96958178854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7381C8630;
	Fri, 14 Mar 2025 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0ymh87i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A88130AC8
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988301; cv=none; b=uLBUmFvXS2HRHvCOrC5JFA4v2s9S/5x3QwItLpyaadTWLVSJlCaO/GB+C3/FQ1C/sheER1GzWiri2FT6/woCH+V2QT/+KtRmYnCX6JdXzxrusAH1hXWk0p9X2gAsqx7dWAR7rVnlOOz2M7/xNmT1qWFbyGOGRAsJWK+cEXqhyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988301; c=relaxed/simple;
	bh=wUKSvD8vwF3thpgoejutr15OJKzXA/OuDmMmmBeuNF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMIWMmKPSesj5Bw4SnDjVV9xrui79oeac8YsxhmXmFSyPIsS00CYDcGOiajExq325su3t66QQWNMZGwpXiLA/EDh8Vl2WdwwZWutAA7x8EiJAXQyh4ryG6ok48VE7AEfyUs/+BE9uJXIQ6auuTlB1KfSB7hIZU4uZxM2IKkYxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0ymh87i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741988298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x8R8SnT0xlNk6NOCsego5+xxOFgcolEZepoyw3FUxJU=;
	b=O0ymh87ixnRcTnnAJ2TTi4/4cPMQznJ9zk2zxwhdTUHEKciMmYir4IiC85tA6YJhUvXucP
	niGVhaLgpESBtDXBWjGSQtQHazoVQkw5SpZLJX294uHhsmsBUjBdRv07c/6WhCp9QEW1aa
	Phut0DfzksvKTowNCFOuxs8VTrOxxpU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-Z7N13xufNW6XUwaNZpccyg-1; Fri,
 14 Mar 2025 17:38:15 -0400
X-MC-Unique: Z7N13xufNW6XUwaNZpccyg-1
X-Mimecast-MFC-AGG-ID: Z7N13xufNW6XUwaNZpccyg_1741988292
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 898481800258;
	Fri, 14 Mar 2025 21:38:11 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20D901944E42;
	Fri, 14 Mar 2025 21:38:03 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: alexander.atanasov@virtuozzo.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	mhocko@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	mst@redhat.com,
	david@redhat.com,
	yosry.ahmed@linux.dev,
	hannes@cmpxchg.org,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	kanchana.p.sridhar@intel.com,
	llong@redhat.com,
	shakeel.butt@linux.dev
Subject: [PATCH v2 0/4] track memory used by balloon drivers
Date: Fri, 14 Mar 2025 15:37:53 -0600
Message-ID: <20250314213757.244258-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series introduces a way to track memory used by balloon drivers.

Add a NR_BALLOON_PAGES counter to track how many pages are reclaimed by the
balloon drivers. First add the accounting, then updates the balloon drivers
(virtio, Hyper-V, VMware, Pseries-cmm, and Xen) to maintain this counter. The
virtio, Vmware, and pseries-cmm balloon drivers utilize the balloon_compaction
interface to allocate and free balloon pages. Other balloon drivers will have to
maintain this counter manually.

This makes the information visible in memory reporting interfaces like
/proc/meminfo, show_mem, and OOM reporting.

This provides admins visibility into their VM balloon sizes without
requiring different virtualization tooling. Furthermore, this information
is helpful when debugging an OOM inside a VM.

V2 changes:
- Add counter to the balloon_compaction interface
- Dropped patches for virtio and VMware as they use balloon_compaction interface

Tested: virtio_balloon, run stress-ng, inflate balloon, oom prints
Signed-off-by: Nico Pache <npache@redhat.com>

Nico Pache (4):
  meminfo: add a per node counter for balloon drivers
  balloon_compaction: update the NR_BALLOON_PAGES state
  hv_balloon: update the NR_BALLOON_PAGES state
  xen: balloon: update the NR_BALLOON_PAGES state

 drivers/hv/hv_balloon.c | 2 ++
 drivers/xen/balloon.c   | 4 ++++
 fs/proc/meminfo.c       | 2 ++
 include/linux/mmzone.h  | 1 +
 mm/balloon_compaction.c | 2 ++
 mm/show_mem.c           | 4 +++-
 mm/vmstat.c             | 1 +
 7 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.48.1


