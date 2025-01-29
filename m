Return-Path: <linux-fsdevel+bounces-40313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA40A2225F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274553A5C9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511361DFD9F;
	Wed, 29 Jan 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcLHLIHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C71DF747
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169891; cv=none; b=CX0cv2YycDbkQmhlrjfvc6R2xIbIEqYoRDmCM1wDuRPMJrF/5qnQWALrrBP1X3ZHlyVkjCzk2MpzoUkvew9tgSk8rfnwFzqv289ppI3hxOjeD1C+hQ5wkTcI9hZ3Es/XZIfDq1kesZG/yumjQzqhnDcPPsLacTBnjwmxBZtSKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169891; c=relaxed/simple;
	bh=JIWQ1QO7BCksiEGMetoA9lKc3PKsttFlXXgneRTjly4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwratQHUIJemqwx1Td+YSK64N2REwNI+wQVZPgeLkSZ/n2dctGP4xdcagkuOFVCwpTH9Na8YCRPSAyEBJKabwUbdEPfzkOo7ey3VYv/N3heAT50RqnONxEArAPDhFlmtnaLKFtFukcEh6YvFHp65lojcIB+8kVrzGdPZB0JMKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcLHLIHm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738169888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K47kaWwlvB0QgUEcbod96X79kXNV4c3e9UEBsXFBFcM=;
	b=VcLHLIHm5lfMO+QR4SMPAeVXPNw5aFFMh908Wd9VWLpBtp12pFno1Awp8RguddzW4b990V
	YpQinKmh514JEisy60m2IUPMZJxHbffjHNdHCzi/gjBQhDEfQjj9RXVexR7MloCHyRjInd
	pxOg1VXxo8P+2s0eYbrd8oT8A6ZxHH8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-5T1VHD9INCCoU0RKyhhKqA-1; Wed, 29 Jan 2025 11:58:07 -0500
X-MC-Unique: 5T1VHD9INCCoU0RKyhhKqA-1
X-Mimecast-MFC-AGG-ID: 5T1VHD9INCCoU0RKyhhKqA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab6d69317a3so84759066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 08:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169886; x=1738774686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K47kaWwlvB0QgUEcbod96X79kXNV4c3e9UEBsXFBFcM=;
        b=T8OHEMRJ2o1GqpjKViUTLSz23ccUriNFAeKAgIS8jFDQ4sWCyCClvVvxiW36Uj/BdJ
         pHs1SklFqmgG8zXfxKKt8RsSTKuIDWZK13EIMnl7WVTfjnzgA3LtI7KecqgyyLdfhQax
         wYqVake8MJjpYhUFdiF+koWaSAZMwsdRdYHm4+RHr/e2O4BykYmC6bPLddUgpAKktEib
         uEgUTUp6hiXZzpO91nsJ7lbTTNLBcsbf1UcMuK6P2whdF9SJXyjX2MPmjlSGY2oLoqvq
         CzFQb4fB2Xnh8OeB20t37BqE2x/IzlWYFLfGTdSkdccrNZOmQ1NVD+5Ttd0v4YtyNuBc
         Yd/g==
X-Gm-Message-State: AOJu0YyOuGopEcNELGkbF4oLW5JV0GgJvlvNNeK4uJSsenrRB66ByzIj
	B0uHlpwaxgjozOrFZGV5JSK8TGV4MrDcwDGEkl3X7JIvk9iP/gmLkajQfNzthk9sPsCH76eFR5p
	OFrkyI23QsLhfpjqrn5WD8NN0OD7ilk53CYPg6kwGXVVGFO0Y6bwmrlyl7oPuSCCXf8c33waiVW
	JBFGula0hPL1s0qnClT0t92rH2BtDzl+sc/w+VKOfvt2Y711Qd2A==
X-Gm-Gg: ASbGnctQOyo+kwRKSZYFvanQIO7e0auSPW4wlj8Lrlw+0W5zSB6Mm+f0rlODGCDEtIx
	AmxJSsia0KfoMGbsu77FjjoxekkrDrqX8LYggwszhkugRRyZtbIirG5ax3XPSrUBxbHiDjBqHBY
	OF0yaxsYH4ytkM4OA70c2MBH4WgsUDW58pmKhLBqFNq6nhocV++5rfUOZnBvapk/30htEicLZhB
	Tz3Hh6CPCJl+RI4p97CQgZM4VwE5fzVtXWmoQrb7qDqIrG6s57KCHyJj+Kv9gh8UN/aFV8JNc9d
	MbwZlG5TJO7WUAa0063mhP1/+BhQI7he8qgCmPpdtp/qgmheqeueOKFE
X-Received: by 2002:a17:907:971f:b0:aa6:a844:8791 with SMTP id a640c23a62f3a-ab6cfe120e9mr362631466b.45.1738169885922;
        Wed, 29 Jan 2025 08:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3fQki93wvSIZNI2gPgUJncSMHks44LgIjMTqpIUAYXOgBM3KZNLb1wrvEfXMxgDFWGdYD3g==
X-Received: by 2002:a17:907:971f:b0:aa6:a844:8791 with SMTP id a640c23a62f3a-ab6cfe120e9mr362628766b.45.1738169885491;
        Wed, 29 Jan 2025 08:58:05 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e653c6sm1002813366b.64.2025.01.29.08.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:58:04 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org
Subject: [PATCH v5 0/3] mount notification
Date: Wed, 29 Jan 2025 17:57:58 +0100
Message-ID: <20250129165803.72138-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should be ready for adding to the v6.15 queue.  I don't see the
SELinux discussion converging, so I took the simpler version out of the two
that were suggested.

Will work on adding selftests.

Thanks to everyone for the reviews!

Miklos

---
v5:
 - drop FS_MNT_CHANGE (Christian)
 - rebased on current mainline (Amir)
 - add FSNOTIFY_MNT_EVENTS (Amir)
 - change selinux permission check to FILE__WATCH_MOUNT (Paul)

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


Miklos Szeredi (3):
  fsnotify: add mount notification infrastructure
  fanotify: notify on mount attach and detach
  vfs: add notifications for mount attach and detach

 fs/mount.h                         | 26 +++++++++
 fs/namespace.c                     | 93 ++++++++++++++++++++++++++++--
 fs/notify/fanotify/fanotify.c      | 38 +++++++++++-
 fs/notify/fanotify/fanotify.h      | 18 ++++++
 fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++-----
 fs/notify/fdinfo.c                 |  5 ++
 fs/notify/fsnotify.c               | 47 ++++++++++++---
 fs/notify/fsnotify.h               | 11 ++++
 fs/notify/mark.c                   | 14 ++++-
 fs/pnode.c                         |  4 +-
 include/linux/fanotify.h           | 12 ++--
 include/linux/fsnotify.h           | 20 +++++++
 include/linux/fsnotify_backend.h   | 42 ++++++++++++++
 include/uapi/linux/fanotify.h      | 10 ++++
 security/selinux/hooks.c           |  4 ++
 15 files changed, 396 insertions(+), 35 deletions(-)

-- 
2.48.1


