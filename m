Return-Path: <linux-fsdevel+bounces-10947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA3B84F51C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE6D1F22A7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD133CD0;
	Fri,  9 Feb 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI3qlvOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1131A89
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481175; cv=none; b=Irbz7r/Q++ZcMpEeIi8YX49VOPABvxyLYz3VDjmbZ2ydQo9nmAdS5kkK86YshU0vXViSJELSAsDpJYfOKP1VxVkSqLqPUujuHCxtGoOyB6dFk46vqMIPcOQGBh8ACKZqkjpkUs5o2b4nIftjqQYafh7vj8Ei5xlROE/U5ICe50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481175; c=relaxed/simple;
	bh=pPsXR4LXERir+3yl7dR7PIdmPZ/niX/68c9RkRA7nKk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uCoiCboSCgKawXIzdhiTbNlBQ0zEO0eksuHd/LGP/JDYBRXWIu/fpnKu1BP27Hiv/f2MeS8YEXqY7N7CQ6Y9Q1eM6fma4sztNabwzrNdxW7tJ1F9AesAjcSbwUWx9Ad+8HA+1+YTKFDg+kzqQiQ5y0XK7PTB5TMw1olSXZjwjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TI3qlvOt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707481172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kq0zPAaOeR38KDlLclahoCBb6eOWgUuY4y6kUGHll4k=;
	b=TI3qlvOtJZkQ3xaIxorKNxej5+JQA3KQ6P9r6q6EFD6gKUup5ycTWSKvzJnKD6Lth53O/l
	nY7Xxy3dN6juKvIzROhITZWZz9018UfVAmWgXGzUyGHue40DYXfSPcBn91Sxuue6svYUh4
	rZR1osfQ9ncfHfO0IFGzTSzAYfX8HNc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-7hnOAlfoO5OqSyOkG43TkQ-1; Fri,
 09 Feb 2024 07:19:28 -0500
X-MC-Unique: 7hnOAlfoO5OqSyOkG43TkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8309D29AB442;
	Fri,  9 Feb 2024 12:19:28 +0000 (UTC)
Received: from localhost (unknown [10.39.193.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0CDCB492BE2;
	Fri,  9 Feb 2024 12:19:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,
	gmaglione@redhat.com,
	Greg KH <gregkh@linuxfoundation.org>,
	virtio-fs@lists.linux.dev,
	vgoyal@redhat.com,
	Alyssa Ross <hi@alyssa.is>,
	mzxreary@0pointer.de,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 0/3] virtiofs: export filesystem tags through sysfs
Date: Fri,  9 Feb 2024 07:18:17 -0500
Message-ID: <20240209121820.755722-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

v3:
- Use dev_dbg() to avoid spamming logs [Greg]
- Fix 644 mode on "tag" attr and use __ATTR_RO() [Greg]
- Use kset_uevent_ops and eliminate explicit KOBJ_REMOVE [Greg]
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

 fs/fuse/virtio_fs.c                         | 135 +++++++++++++++++---
 Documentation/ABI/testing/sysfs-fs-virtiofs |  11 ++
 2 files changed, 125 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs

-- 
2.43.0


