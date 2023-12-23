Return-Path: <linux-fsdevel+bounces-6836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB6F81D4E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD161C21397
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47EEFC0B;
	Sat, 23 Dec 2023 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc3P64ym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767BDF69;
	Sat, 23 Dec 2023 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d53297abbso885155e9.1;
        Sat, 23 Dec 2023 07:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703346252; x=1703951052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zMe1MEdDcbrphrdEikX4LAE8+g15DayBKKxfAYK+0M=;
        b=kc3P64ym3UFI/rwQKOjsWfHZaxzNoZ4JbxLC4vcD5G8TaXbVPKGJrqNDxVSY6Ht+pX
         zesyyrgrmosMxnBbOb//xdYsvvgAFonsyPRmKgiek6ScKOrZ81zN/RdFqUBAAotJ8Gtz
         xOiOlTBe4vExk4VZM8UGIjeRd8NeOUPM1t0FtyZ/HYOvcbDhWiXb+euj6/pER7nqvV/t
         R5wZjhVHaMu13diF6tu698cxWEWUUzQNmmgYkzzMK8z7QkWgU9vgUPWmxGgC5bxf73o6
         SYmYZA+deAcYUmSIa88pQScWbiVXXfPsI4GQ0iQ0HqWBPIA39foKkGd5tDlJM0vREAjj
         DsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703346252; x=1703951052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zMe1MEdDcbrphrdEikX4LAE8+g15DayBKKxfAYK+0M=;
        b=sk7siell36D8jOLS4zdatYHjqC4DkXrNrqx5cejsfo+gIysoX7C5JgAuM1maXDuN7N
         SpANi1+hwyLcwr/TKiAlQQ2Ej8EViXlOy5f68y+uOFn3YipZpK4yBKnViCRYYSNywKt0
         fn+HwdEntzpbYoThBufv9H5T9lpFGAU2ap8gDf0zyGbQIhDXZ1qucPqJ4wc4wB2OlPKF
         +LgtfqIk/A82uLN7iRWEr3uLiHFNGSxRrttuCcTX4yZL+1ko9uA8ex0//ZqjYEonYkw6
         /RyB5wxpYhIujjhdX8XNM84OayVLZgmJ1CaS0RY7jTMUE2HKH0CKTBLP+Jwn1PcFfDZc
         KaZQ==
X-Gm-Message-State: AOJu0YwfDz0zz9ZHY6T4sjAO2ZtOo2qWKM93jqQgLqC31B2L+yp9Uz+s
	c3vW7jpf6O/duGNBmQhVHUVswYaMeKg=
X-Google-Smtp-Source: AGHT+IF33nov2tYXsOTE4xXgQt1e0oIvc0vwBEWW1/QOhNPOpMv3JnWRHRgPahNRVrZJdWdhR+Gczw==
X-Received: by 2002:a05:600c:a083:b0:40c:31bb:6703 with SMTP id jh3-20020a05600ca08300b0040c31bb6703mr1247937wmb.75.1703346251418;
        Sat, 23 Dec 2023 07:44:11 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id u4-20020a05600c138400b0040c03c3289bsm10873965wmf.37.2023.12.23.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 07:44:11 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs backing file helpers for 6.8
Date: Sat, 23 Dec 2023 17:44:05 +0200
Message-Id: <20231223154405.941062-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

Please pull the overlayfs backing file helpers for 6.8.

The only change since the patches that you reviewed [1] is that I added
assertion to all the helpers that file is a backing_file as you requested.

This branch merges cleanly with master branch of the moment.

This branch depends on and is based on top of vfs.rw branch in your tree.
When test merging with vfs.all of the moment, there is a trivial conflict
in MAINTAINERS file with the vfs.netfs branch.

This branch is independent of the overlayfs-next branch.
It has gone through the usual overlayfs test routines, both with and
without a test merge with overlayfs-next branch.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20231221095410.801061-1-amir73il@gmail.com/

----------------------------------------------------------------
The following changes since commit d9e5d31084b024734e64307521414ef0ae1d5333:

  fsnotify: optionally pass access range in file permission hooks (2023-12-12 16:20:02 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-vfs-6.8

for you to fetch changes up to f567377e406c032fff0799bde4fdf4a977529b84:

  fs: factor out backing_file_mmap() helper (2023-12-23 16:35:09 +0200)

----------------------------------------------------------------
overlayfs backing file helpers for 6.8.

These helpers are going to be used by fuse passthrough patches.

----------------------------------------------------------------
Amir Goldstein (4):
      fs: prepare for stackable filesystems backing file helpers
      fs: factor out backing_file_{read,write}_iter() helpers
      fs: factor out backing_file_splice_{read,write}() helpers
      fs: factor out backing_file_mmap() helper

 MAINTAINERS                  |   9 ++
 fs/Kconfig                   |   4 +
 fs/Makefile                  |   1 +
 fs/backing-file.c            | 336 +++++++++++++++++++++++++++++++++++++++++++
 fs/open.c                    |  38 -----
 fs/overlayfs/Kconfig         |   1 +
 fs/overlayfs/file.c          | 245 +++++--------------------------
 fs/overlayfs/overlayfs.h     |   8 +-
 fs/overlayfs/super.c         |  11 +-
 include/linux/backing-file.h |  42 ++++++
 include/linux/fs.h           |   3 -
 11 files changed, 435 insertions(+), 263 deletions(-)
 create mode 100644 fs/backing-file.c
 create mode 100644 include/linux/backing-file.h

