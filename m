Return-Path: <linux-fsdevel+bounces-4248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA507FE124
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE90A1C20A2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1CA5DF14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3kWDWeF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC910C2
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:07:17 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9c149848fso2548141fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701288435; x=1701893235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNYPruCeaKegi265EGmgQjzxktpfpzEZ17u0pYmLZtM=;
        b=A3kWDWeFn55miIQUJeBaYLDiNXh6T7GAX7L04xKFkChSHireTSkRTLfjbbZ/u3EpXA
         mBUZWnkFjaNVzrQ2z1G8tawth8130QBDNXGocEOipmmnoPKp+AX8cbrislx9iHA1hjqH
         Zp8TdHztnu0XdSkhpMCpKwMFO0/12jPLu8gedJIJwx9qoMPO0QJy0+6K/aLjhRvplsbi
         ezeDgjQhjjfmOPw6ut4KuP6uOZz5LFzcs+2MgBkPXnbyC3ddi66uNoJ5lBR84NN2gLqp
         4zYtJGE9xuBlyCYHZxs3mjxKWYQyJx6apGLkxzBVVI4mByXTBy77lbBKy/FEAtgHKFJs
         VERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288435; x=1701893235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNYPruCeaKegi265EGmgQjzxktpfpzEZ17u0pYmLZtM=;
        b=GtNjwDSZFpmWz9Xy8zkY9xnk+UcNbyUuDyIkMcm6wueShLtWXbSGHnuk+yy47Yv+FN
         usScvamDaLDzFrg2Z7HJ015slWecSv64K/rPijX2O+C4hHgXYVwuDMMtdSMCkgF0TVQ4
         H61kPN+6Rj8a1eZvXBl/U5Fd+pt4cUBNNiM0jfQdc4y1LL20sWG9guYNfqB1slD/JeUW
         x9wBPqzCJWF3iF7yNCN7IlCeo+xh19itcwRT52QVAaVrchZzbGkjlTsNEpbXpgcn6Er7
         myv24y3fYTYoKHdBMq6B8MZ2Bso/JBqhWlIKShOiQ8f/YFB6AHvSlWq1sJu6eCiZkCPU
         saTw==
X-Gm-Message-State: AOJu0YxuK7lCSkHWTSzYjqpmXRpA4qoGksVOCqQlCcY+wCeX9DULHLxW
	v4W0L+9Xyq9mFjAMoL5UBMaFQIlPF5M=
X-Google-Smtp-Source: AGHT+IHFtk980Gi+GbST8cEJpXElbruR27Gx8mzfCoFDDDkseUKx7MkoaVkfxpF4xRohMWv+YufwQQ==
X-Received: by 2002:a2e:9048:0:b0:2c9:bc36:89c4 with SMTP id n8-20020a2e9048000000b002c9bc3689c4mr2322232ljg.0.1701288435275;
        Wed, 29 Nov 2023 12:07:15 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a8-20020adffb88000000b00333083a20e5sm7412719wrr.113.2023.11.29.12.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:07:14 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Avert possible deadlock with splice() and fanotify
Date: Wed, 29 Nov 2023 22:07:07 +0200
Message-Id: <20231129200709.3154370-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

Josef has helped me see the light and figure out how to avoid the
possible deadlock, which involves:
- splice() from source file in a loop mounted fs to dest file in
  a host fs, where the loop image file is
- fsfreeze on host fs
- write to host fs in context of fanotify permission event handler
  (FAN_ACCESS_PERM) on the splice source file

The first patch should not be changing any logic.
I only build tested the ceph patch, so hoping to get an
Acked-by/Tested-by from Jeff.

The second patch rids us of the deadlock by not holding
file_start_write() while reading from splice source file.

The patches apply and tested on top of vfs.rw branch.

Thanks,
Amir.

Amir Goldstein (2):
  fs: fork do_splice_copy_file_range() from do_splice_direct()
  fs: move file_start_write() into direct_splice_actor()

 fs/ceph/file.c         |  9 +++--
 fs/overlayfs/copy_up.c |  2 -
 fs/read_write.c        |  8 +---
 fs/splice.c            | 88 +++++++++++++++++++++++++++++++-----------
 include/linux/fs.h     |  2 -
 include/linux/splice.h | 13 ++++---
 6 files changed, 81 insertions(+), 41 deletions(-)

-- 
2.34.1


