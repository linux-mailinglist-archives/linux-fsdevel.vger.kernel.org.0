Return-Path: <linux-fsdevel+bounces-39998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19EA1AA79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 20:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B8816AADA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573EE1B6CE4;
	Thu, 23 Jan 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7a7t2oz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A71741D2
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661276; cv=none; b=HzIkaXK+kGueQCTSIpb6caMVsUqTxb8RbAS4bVgFcY8roysFeShkNQC+RfpwcokjL3k6wq0mgGztp9zKTTGfI81vg/BtOH1qj+iD8vzE84RwgD+aB+HQIT8NtAowzlFRBcEFul9a3PHe90DTWbEiuTsSWC+9D6HNSdVZ8l2e8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661276; c=relaxed/simple;
	bh=crfRQrn6rJNEgnAzDpUaAC4avkLkEg1kUUwBWVgapks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsM+hQZj0yHAon1e7d9H5zBGkx0JKrU4QkZ02TBQtDws8ny0A1qt0UsepBahn/MNbyABAv9P7zNH6duE5mdsZEih39duRYTHVL8NGR03pMAuzc9PO/jV7rUPUK/QNgVzRAr9R4M6JJkmDaKtsW81ufcqmlwXhWNGJB6gQDHYUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7a7t2oz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737661273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pMjEfd15YaPnS3m1kK+tJc0UvrQqQ2bQdv285PmS/eo=;
	b=Y7a7t2ozYru9bezcyLQ2gfJN6hp716PIdA57zBFp3iN1ISzYMCn9AJEATo+JK4U+u4nGnw
	1pwZ8rlVBNGn1vfvcTNTNcx5FjQn4Yz+Vi2j/jiJvWjvW9yPvSOKFKwc3HBUUMIvQ0Cc2s
	1sJ+39oidOMHYC93bRO6LKho7ord69E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-xbo4OwR4MUO1QeHG1Akxcg-1; Thu, 23 Jan 2025 14:41:12 -0500
X-MC-Unique: xbo4OwR4MUO1QeHG1Akxcg-1
X-Mimecast-MFC-AGG-ID: xbo4OwR4MUO1QeHG1Akxcg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436289a570eso9520375e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 11:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661271; x=1738266071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMjEfd15YaPnS3m1kK+tJc0UvrQqQ2bQdv285PmS/eo=;
        b=g5YPEr93EhSB+JsYxMJxs2+M0JOAkHAEjNzlsUkpM3mjjcD9Q4tSPukD/0TSV2wupK
         5mY2s06ck3almY/N8b9fyy4ynU4z+8e1CAkfOzPacFNt09hJbMb1/fCfpS5V4AOktMz8
         zPwRFeLsqaWa0rYnUOJLwKGxALCO4737PpmWVcidY1sPYVgSlNJeN2VFz+0icE9NytQw
         x3xhEfJqz28lUaGZ7f2q5Jse6d1zL9PGQsSUSSjJ+HFtBvWIM2y2IRAeOwYgGOgLkYXD
         jG2ANO+q1goQFm5U8YNLRWJkn8dk8UKbyHvjl7dlgP/S1lRWRBSKuZMiQIl67DUiRNcV
         tCuA==
X-Gm-Message-State: AOJu0Ywt19ewPFC67yxWwPlSmjmdOmSNBjj1SLzSY2c1cjTmlvVIgXdI
	nG8Wi0chwFXZQ2lgh3xhjtDHg2fUPQ+pfo3rup9fsUzpnbERSWmy854FVl8gvjdnoq3Y4GK0jRc
	jOug26x1yyQBudRUgtwGYLDRDQi1RFEKqwa1LfF93AZszKSy97hTg4Rlg2TX65CJEAYE5kYSIXN
	MUx6BvvCtsAiaSH758ds0CaN7jIxMDEhsYrLZFoNpBgSKJ1+4b3g==
X-Gm-Gg: ASbGncsgg2a3hzGxmrS6tIuyDikVxI0OjCXXfIm3OumJ90+z/WMbWn6jfdBpKfEQQfx
	7NvcKorrxfypLCQ+XNih1m+zhlfY9hjQucEp97+JlZoPSDHepbLg1GQHcBJgbkVC7hsR9X5RyZ9
	g6CsqrW2zUxRISUvmYRSIBKWL+xkx/L618vRWyvzQzJQQs+ssbnqN1ig7QxFD4HREwR6tUUDRNa
	MR2IS6uZUic6ap48L2gHZsZ0FQT3dB8cH1FsHSZFk1iY8NDhQFGvFlohLFwsYRCX6PFRRUmVK5N
	M75QmwzVmUoZgmlMKAySVxL6i+MVlsNfg7jvhTLPk9Yh2g==
X-Received: by 2002:a05:600c:1386:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-438913cf349mr240199995e9.9.1737661270806;
        Thu, 23 Jan 2025 11:41:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoz2j+PwNk/UXtmsGls7bCH6WnDcHXmR9rN/MaKVJjM3lXOBp6m6yVukwzhUxjrjYNsdB93A==
X-Received: by 2002:a05:600c:1386:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-438913cf349mr240199745e9.9.1737661270368;
        Thu, 23 Jan 2025 11:41:10 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e46sm1687245e9.21.2025.01.23.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:41:09 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v4 0/4] mount notification
Date: Thu, 23 Jan 2025 20:41:03 +0100
Message-ID: <20250123194108.1025273-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Addressed all comments, and split up patch into three pieces (fsnotify,
fanotify, namespace) and added a fourth patch for mount changes.

There's only one FIXME remaining in selinux_path_notify().  The path passed
to fanotify_mark() and subsequently to ->path_notify() is a namespace file,
and comes from nsfs (i.e. /proc/$$/ns/mnt).  Does this need to be handled
specially by selinux?

Paul, can you please review this change?

Thanks,
Miklos

---
v4:
  - add notification on attribute change
  - deal with two FIXMEs
  - move data and code to #ifdef CONFIG_FSNOTIFY regions
  - function renames for more consistentcy (Christian)
  - explanation comment in umount_tree() (Christian)
  - style cleanups in fanotify (Amir, Jan)
  - changed FAN_MNT_* values (Amir)

v3:
  - use a global list protected for temporarily storing (Christian)
  - move fsnotify_* calls to namespace_unlock() (Christian)
  - downgrade namespace_sem to read for fsnotify_* calls (Christian)
  - add notification for reparenting in propagate_umount (Christian)
  - require nsfs file (/proc/PID/ns/mnt) in fanotify_mark(2) (Christian)
  - cleaner check for fsnotify being initialized (Amir)
  - fix stub __fsnotify_mntns_delete (kernel test robot)
  - don't add FANOTIFY_MOUNT_EVENTS to FANOTIFY_FD_EVENTS (Amir)

v2:
  - notify for whole namespace as this seems to be what people prefer
  - move fsnotify() calls outside of mount_lock
  - only report mnt_id, not parent_id


Miklos Szeredi (4):
  fsnotify: add mount notification infrastructure
  fanotify: notify on mount attach and detach
  vfs: add notifications for mount attach and detach
  vfs: add notifications for mount attribute change

 fs/mount.h                         |  26 +++++++
 fs/namespace.c                     | 120 ++++++++++++++++++++++++++++-
 fs/notify/fanotify/fanotify.c      |  38 ++++++++-
 fs/notify/fanotify/fanotify.h      |  18 +++++
 fs/notify/fanotify/fanotify_user.c |  86 +++++++++++++++++----
 fs/notify/fdinfo.c                 |   5 ++
 fs/notify/fsnotify.c               |  47 +++++++++--
 fs/notify/fsnotify.h               |  11 +++
 fs/notify/mark.c                   |  14 +++-
 fs/pnode.c                         |   4 +-
 include/linux/fanotify.h           |  12 ++-
 include/linux/fsnotify.h           |  25 ++++++
 include/linux/fsnotify_backend.h   |  43 ++++++++++-
 include/uapi/linux/fanotify.h      |  11 +++
 security/selinux/hooks.c           |   4 +
 15 files changed, 428 insertions(+), 36 deletions(-)

-- 
2.47.1


