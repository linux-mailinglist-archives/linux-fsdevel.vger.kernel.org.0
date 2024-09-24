Return-Path: <linux-fsdevel+bounces-29991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEAF984B4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 20:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07442849D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188FD1AC890;
	Tue, 24 Sep 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Rnk4WXG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC291AB6D7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203583; cv=none; b=XwFCOY3eXJkhUApYDPcG7oGP75MkbKkVp1MPjZaxJNek6dDhwUpsbo7BEduVSIn6+p7JTPa0Uyj42LUWPT9wDwqqbMAemq2hzl9b9wm4lkt4bZRRKOdbhodVhfrfsDZy5pFDHQ7IjVD2sE5W4Fa/s7PH8k5o4g3AwZ29/zUbkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203583; c=relaxed/simple;
	bh=4zTURsD618AgoG6t/isN4W59/+vRidVolbh8d2HcSOA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AqwUZxbs+1oYs7oAkz3HWibhVrs0ydzc8z/bfivCYYgePI9VDJlx2feKFli/bvrBQY/lDzeFVBK3VS75XGzMJrL5DTDJKDBsn7rLVY8n8OLrSqOaCZNs9S+CZyJht19llzjqA60gNjYhhmVGJdaNolm2Ea8xWUDPu247TjIb8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Rnk4WXG/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f761461150so71298491fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727203578; x=1727808378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w+2ijwfyAktudbI1oUk1hoKjUwo0kDL+a1M5XynenAw=;
        b=Rnk4WXG/dNXIlDA0clDbV9OsdSPUTI6dWU95tKYh2vPnpT722ITuuCXhcZBzem2eS8
         sCPWgLHLTd0F22OfIln5BudUSgCJ0qCoCksALcdUT2YNYWa176WS7+Yxninqen1G70NM
         d5CeZsY50C/7wStVgOizvl7ck2c7Xp9bC7X8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203578; x=1727808378;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+2ijwfyAktudbI1oUk1hoKjUwo0kDL+a1M5XynenAw=;
        b=jown5neQJynWNs10PK+F+GDnnqQ2nX/S+QIpIbAPYZ1YonYPIt9L+eXhXcNaQBx7BR
         TDhBHFknE7lXYEtKGVV1txYnd0C/iApa2j6h12EFA1uX3Pv40F9xikI+6VWzz49WXY1H
         Q4EcGuztTDynRico8NO8VdeXVb8yfFgeR+H8BoI+8eCvMES0RzorN2mtU8L2ZGsbzk51
         AhaoSf3e3V46CW7hYVHBS/SpGdDQyGpnEOVU4j7EtTyU5zSdOuj+1itQmbdH+8Uy5PVS
         HfkF5uFqOkbiFeJQGJwKDLM+ed6Ke/bAdecO2uBb4gznByQFydMXAeEaegtJbwvcL2I8
         qRdg==
X-Gm-Message-State: AOJu0Yz1TWtnzz+k5ieLEHkwR/6JzmWCFzRpinRaTkt5YUmAxaEqAlGn
	7uwGV8arq7CUdBdRtYcBW6gcr5slhegM48BI7cXBsqF/ZNjCsqrlMNLQ3tADRiI67CcTBa8brr4
	B5M85QU4/HF8WKKdJliEnyvvyJq5wd7HRqbhgPQ==
X-Google-Smtp-Source: AGHT+IFZq5pmeLzBNvGYoeUhMYMN7j+WNSzM0rqWc5RFwobBX6a9/eU/mhQf7AG7w2lytgvAVfQuJ6AXMfAN5iwhKIk=
X-Received: by 2002:a2e:bc07:0:b0:2f7:7fe7:ca94 with SMTP id
 38308e7fff4ca-2f9156370famr2897421fa.1.1727203578071; Tue, 24 Sep 2024
 11:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Sep 2024 20:46:05 +0200
Message-ID: <CAJfpegu_-v_qA62+VZQmi+HvfYZSaxjpKtUt0P=_PTpiugoNaQ@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.12

- Add support for idmapped fuse mounts (Alexander Mikhalitsyn).  This
touches some non-fuse files, these have been reviewed by Christian.

- Add optimization when checking for writeback (yangyun).

- Add tracepoints (Josef Bacik).

- Clean up writeback code (Joanne Koong).

- Clean up request queuing (me).

- Misc fixes.

Thanks,
Miklos

---
Alexander Mikhalitsyn (19):
      namespace: introduce SB_I_NOIDMAP flag
      fuse: add basic infrastructure to support idmappings
      fuse: add an idmap argument to fuse_simple_request
      fuse: support idmapped FUSE_EXT_GROUPS
      fuse: support idmap for mkdir/mknod/symlink/create/tmpfile
      fuse: support idmapped getattr inode op
      fuse: support idmapped ->permission inode op
      fuse: support idmapped ->setattr op
      fuse: drop idmap argument from __fuse_get_acl
      fuse: support idmapped ->set_acl
      fuse: support idmapped ->rename op
      fuse: handle idmappings properly in ->write_iter()
      fuse: warn if fuse_access is called when idmapped mounts are allowed
      fuse: allow idmapped mounts
      virtio_fs: allow idmapped mounts
      fs/fuse: fix null-ptr-deref when checking SB_I_NOIDMAP flag
      fs/fuse: introduce and use fuse_simple_idmap_request() helper
      fs/mnt_idmapping: introduce an invalid_mnt_idmap
      fs/fuse: convert to use invalid_mnt_idmap

Aurelien Aptel (1):
      fuse: use correct name fuse_conn_list in docstring

Joanne Koong (6):
      fuse: drop unused fuse_mount arg in fuse_writepage_finish()
      fuse: refactor finished writeback stats updates into helper function
      fuse: move initialization of fuse_file to fuse_writepages()
instead of in callback
      fuse: convert fuse_writepages_fill() to use a folio for its tmp page
      fuse: move fuse file initialization to wpa allocation time
      fuse: refactor out shared logic in fuse_writepages_fill() and
fuse_writepage_locked()

Josef Bacik (1):
      fuse: add simple request tracepoints

Miklos Szeredi (3):
      fuse: cleanup request queuing towards virtiofs
      fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN
      fuse: clear FR_PENDING if abort is detected when sending request

yangyun (2):
      fuse: add fast path for fuse_range_is_writeback
      fuse: use exclusive lock when FUSE_I_CACHE_IO_MODE is set

---
 fs/fuse/Makefile              |   3 +
 fs/fuse/acl.c                 |  10 +-
 fs/fuse/dev.c                 | 214 ++++++++++++++++++++++++++----------------
 fs/fuse/dir.c                 | 152 ++++++++++++++++++------------
 fs/fuse/file.c                | 184 ++++++++++++++++++------------------
 fs/fuse/fuse_i.h              |  42 +++++----
 fs/fuse/fuse_trace.h          | 132 ++++++++++++++++++++++++++
 fs/fuse/inode.c               |  13 ++-
 fs/fuse/passthrough.c         |   7 +-
 fs/fuse/virtio_fs.c           |  42 +++------
 fs/mnt_idmapping.c            |  22 ++++-
 fs/namespace.c                |   4 +
 include/linux/fs.h            |   1 +
 include/linux/mnt_idmapping.h |   1 +
 include/uapi/linux/fuse.h     |  22 ++++-
 15 files changed, 552 insertions(+), 297 deletions(-)
 create mode 100644 fs/fuse/fuse_trace.h

