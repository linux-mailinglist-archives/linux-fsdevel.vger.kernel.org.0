Return-Path: <linux-fsdevel+bounces-10827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E784E8FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F41F2220D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF4B383B0;
	Thu,  8 Feb 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2dMUWum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF3383B1
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420845; cv=none; b=MKMI8APSTB1zgwMFMEtaqTpNm/awcmJQWSwUpVNwy7ROPKxOlgIxiqokRsKNxKc7CeLVvq4/hQJD8fxAN4ay2mHzYD7wpqCZxHRmdV+qIQ7F5Qe13b3ehStStxj5zrieJfh4RfCYN1SK6Ok1UoZu065SPQumrnLRE2IZT+Qlphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420845; c=relaxed/simple;
	bh=gIYe1G2D5czXLxBwjohuKB4A+4yKGd/4oBCUNojNndE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ciDoteUdDzvtLFod0tOItI70dZSUPmu0y5y0RsrdtWpvPrfL+SUHZwYcZEbKgbMNkMRyuYwPPQLzKjqXztL6WNBYp52do3rUVIepHWxuPACsRYiOlFMT7pbHLVgTgEtie0m17PStshXykaVbsGt+p5vVeib9gxsxtL9Ys0U+yaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2dMUWum; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707420842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B5DAQZFX3akFCHabnQKTMIcW//WJ3thDgfeNbjmdQfE=;
	b=V2dMUWumleZa4opBKc5KN0CZ7okooeQ3iAoRO8jk2ZodZT43/+33SapN4hxkJlIBz8rY9n
	BSGVghsvI2Zn9upaICt7hYQTf72RmT3Bez6KsXp0ot+hv5kZGy4FMGT2rpGNqVA87SYn2k
	mklYWAYzEZLL8YJV22wxrZQIRnTDb9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-0vhgBgLjPX22OLWp2_Nu4g-1; Thu, 08 Feb 2024 14:34:00 -0500
X-MC-Unique: 0vhgBgLjPX22OLWp2_Nu4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56A1C85A589;
	Thu,  8 Feb 2024 19:34:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD956AC17;
	Thu,  8 Feb 2024 19:33:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Alyssa Ross <hi@alyssa.is>,
	gmaglione@redhat.com,
	virtio-fs@lists.linux.dev,
	vgoyal@redhat.com,
	mzxreary@0pointer.de,
	Greg KH <gregkh@linuxfoundation.org>,
	miklos@szeredi.hu,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/3] virtiofs: export filesystem tags through sysfs
Date: Thu,  8 Feb 2024 14:32:08 -0500
Message-ID: <20240208193212.731978-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

v2:
- Vivek mentioned that he didn't have time to work on this patch series
  recently so I gave it a shot.
- Information is now exposed in /sys/fs/virtiofs/ whereas before it was part of
  the generic virtio device kobject, which didn't really fit.

Userspace needs a way to enumerate available virtiofs filesystems and detect
when they are hotplugged or unplugged. This would allow systemd to wait for a
virtiofs filesystem during boot, for example.

This patch series adds the following in sysfs:

  /sys/fs/virtiofs/<n>/tag    - unique identifier for mount(8)
  /sys/fs/virtiofs/<n>/device - symlink to virtio device

A uevent is emitted when virtiofs devices are hotplugged or unplugged:

  KERNEL[111.113221] add      /fs/virtiofs/2 (virtiofs)
  ACTION=add
  DEVPATH=/fs/virtiofs/2
  SUBSYSTEM=virtiofs
  TAG=test

  KERNEL[165.527167] remove   /fs/virtiofs/2 (virtiofs)
  ACTION=remove
  DEVPATH=/fs/virtiofs/2
  SUBSYSTEM=virtiofs
  TAG=test

Stefan Hajnoczi (3):
  virtiofs: forbid newlines in tags
  virtiofs: export filesystem tags through sysfs
  virtiofs: emit uevents on filesystem events

 fs/fuse/virtio_fs.c                         | 138 +++++++++++++++++---
 Documentation/ABI/testing/sysfs-fs-virtiofs |  11 ++
 2 files changed, 128 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs

-- 
2.43.0


