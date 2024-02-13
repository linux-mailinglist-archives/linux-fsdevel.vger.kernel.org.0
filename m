Return-Path: <linux-fsdevel+bounces-11258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F78522F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 01:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0356C1C233B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 00:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08276628;
	Tue, 13 Feb 2024 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiXeAfpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EE747C
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783205; cv=none; b=V/UP2na7ZOfE0lXOb3Q4IidyLno77jWLNRNCxH1cWHcLpyItQdiXAeuHezHThLnZu1lPd5QnjghLh23HebA0QXgGTAUOIyvN9zIqtNyni6MYGvqdEhVU33gJ7OZxLg730PuH+Yq0TnSpLrHztVNvAn8Is3xCh4IjcVh1VcU0YNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783205; c=relaxed/simple;
	bh=uG7X2juyBs8/evP+qSMvLYONBULdtXppcpbx1pWlfCg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R78YLGhwknLt8ayM1Zk+FB/tnYCLJ2pZV//3YZYvpkICcfLG1E/Vq/wlOm5ucPGjZurZ9taUynqUuGEcNj2nzhlmwxp7SHCK2WZi606+dIlyM0VqeiDvFDO2M2RExPwHPa83Q2S4yPVerbJS2qtg+qGxsHwYqKnc/nroMZNqg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiXeAfpx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707783202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3h90y90xD6rkixdPYBeiOIwz+WU4oX9ImrzHbagl3UM=;
	b=EiXeAfpxTg9FlU6NMU168zE86dno80eCDKxRR2jDbuZU/66BDNNGlKHC+urI3IwzlnfZH0
	+AtJH7FnWqwM/MmKQVbJ94ud6Wfx4+/YsBI6YaWUBDMYCuDvfZ/VDl/TcmuS2FHz0tWubL
	BficEZpcF6lFJEIDM1MJ4HvHHAGsclc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189--zYQ68a0PvSXwgqLi1iq2Q-1; Mon, 12 Feb 2024 19:13:19 -0500
X-MC-Unique: -zYQ68a0PvSXwgqLi1iq2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A16883B7E5;
	Tue, 13 Feb 2024 00:13:18 +0000 (UTC)
Received: from localhost (unknown [10.39.195.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A69C492BCC;
	Tue, 13 Feb 2024 00:13:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,
	Greg KH <gregkh@linuxfoundation.org>,
	Alyssa Ross <hi@alyssa.is>,
	mzxreary@0pointer.de,
	gmaglione@redhat.com,
	vgoyal@redhat.com,
	virtio-fs@lists.linux.dev,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v4 0/3] virtiofs: export filesystem tags through sysfs
Date: Mon, 12 Feb 2024 19:11:46 -0500
Message-ID: <20240213001149.904176-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

v4:
- Create kset before registering virtio driver because the kset needed in
  virtio_fs_probe(). Solves the empty /sys/fs/virtiofs bug. [Vivek]
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

 fs/fuse/virtio_fs.c                         | 137 ++++++++++++++++----
 Documentation/ABI/testing/sysfs-fs-virtiofs |  11 ++
 2 files changed, 126 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs

-- 
2.43.0


