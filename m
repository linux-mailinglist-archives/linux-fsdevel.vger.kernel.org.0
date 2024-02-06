Return-Path: <linux-fsdevel+bounces-10474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D4284B7BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5333A1F2771E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B013246C;
	Tue,  6 Feb 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB2KY8O/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D3132466
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229502; cv=none; b=E3zYIxr2WlCmwexGQvhUcrzK1hwkQSbxAQgfhRlPlT5XWF6ccihiTdLq/emWbbVQKaRYHVh79TrxKJMyXddh7/MagI3nx1gDolsk/d/Ma2Sc+SMCREcLPwf888yYBotVQ7Ky2UgaUTmYIIE8fDyQpTyHqjcaPkbUMKk+h+7BrXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229502; c=relaxed/simple;
	bh=hF2ZJy1IQlMiKIThHtqCMY/BAIINODtt9fGqeAWStn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SuJbNo/HyW3JfW23rccCDTYDv8pS8Apu7HTQxr5RxOSAbeelYQMIaMM2qa3aeYst3O+CQL95SE16hxFGXG33u6MCm2IxUCl241tymroOsNTZrwQN+GXRN5/ZOHk5OuS+3kR0mzYLXaVhMRg11f1U5lVb2jUZOmPWS03m0xrVxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB2KY8O/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso9946485e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229499; x=1707834299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pxzYGjW0kD9Q3cHecop/jWuVLp2sQled/T/uagWapcU=;
        b=ZB2KY8O/4+o5EJVVVtuIUwLFVstcYxrzg7Hy8Cwnb5Q1YzxV0ut6mkTbKrJ7mjrjF9
         uf+o3WT8J3J45i4ViLgoII0BkkV2t12DjkunFzZkIcKVvF+ojOAFSyohpI8fXImRwpVw
         T2ziERUaEX0WS7w1lNI9R9J1e5AwlftVav7XO8Y768rRJhmC/74+lXzCV7Zqohaqa2/8
         +Fk5yoH9baLcCC0WLelkfHQOyDYmHnCVbumf0V4V36j4FqIcQJ7a+oEOHe5zMBsjK8pC
         PqXBu0QpD9eieB/bW5s43d+DHGRMpmsgJvRvQYXLWxr0tq6o4zO2Idb7lSVSLsaDiTYS
         7yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229499; x=1707834299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxzYGjW0kD9Q3cHecop/jWuVLp2sQled/T/uagWapcU=;
        b=bNSO1sStLR+Qf8LZPUppcb56x/s4Eqa3Yst6QRocVEyOu8HJJec/oXSPnmW1kdsQ26
         jVtj6zkaA9Rk/XOukzhUfbObAoycMHZtEltK9aEOPOPZnwYbqa1q8MJxluN5ylwt9UWx
         PSBjObu7tap2j8N2gI4wVPNTqvQ9/1yKODegkWSCRyoKCQTvhC0F/pq65YUdEOcN94mO
         1TEj0y9Sfw0PEgxbJBxgshtGXGMyuVX54WhLOACOmeY2m46XdmxTdzuzokk8w2Sl++S2
         J4n9LhHPBCWTEIXC6VAkXW+XU1ZNesMvrNlaPFtMaJmQFdbhUmG9yi1zSVcxR1Ef/PoV
         fS8A==
X-Gm-Message-State: AOJu0YwWEBZ1GOzkUNIEvFUw6VfXBeEt/QkPV/zvLfNd/WCVNfWs5Gvv
	CT6ETuDWCbOdRGeDrjjd7mdSPGMFuQYZvY8NUUCwtAtLyUvJLNMWBj7Aaddj
X-Google-Smtp-Source: AGHT+IElz2etMLjKvcAQMohQRSGa3VGsd9m3HwPj0MRKNVQjRPweL4WGkoEGyPbYg9S3U76bkb5qKA==
X-Received: by 2002:a05:600c:35ce:b0:40f:d280:612f with SMTP id r14-20020a05600c35ce00b0040fd280612fmr2047304wmq.30.1707229498902;
        Tue, 06 Feb 2024 06:24:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVG/eh0lPxZDV2tDz3aez79v0OEsRqEPY56V7l6CWso2nThOjPY0UfapyR56E8wWBIh4viVzoeG/Mew2q5CGkpVHHo9HJ23vN/ufTM8Vg==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:24:58 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 0/9] FUSE passthrough for file io
Date: Tue,  6 Feb 2024 16:24:44 +0200
Message-Id: <20240206142453.1906268-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miklos,

The fuse passthrough code of v14 patches [1] was failing some tests
that did mmaped write and failed due to stale attribute cache.

To resolve that issue and to clarify semantics, I worked together with
Bernd to implement inode io modes [2].

When a FUSE inode is open in passthrough mode, it cannot be opened
in caching mode and that inode has an associated backing file, which
is like an O_PATH file to hold a reference to the backing inode.

That backing inode is used by the last patch to auto-invalidate inode
attributes in passthrough mode to fix the failing tests.
In theory, the backing inode could be used to copy the attributes to
FUSE inode (overlayfs style), but the code leaves GETATTR in the hands
of the server, in case backing inode and FUSE inode attributes differ.

These patches are based on my latest fuse_io_mode branch [3], where
I have addressed your comments on my patch in Bernd's v2 patches,
including all requested cleanups.

I was going to wait for Bernd to test and re-post the io mode patches,
but since you said that you really hope we can get fuse-backing-fd [4]
into shape for the next merge window, I decided to post the patches.

Thanks,
Amir.

Changes since v14:
- backing_file helpers already merged
- Remove readdir passthrough
- Associate backing file to inode
- Use io modes to prevent open of inode in conflicting modes
- Prevent open of inodes with conflicting backing files
- Auto-invalidate inode attributes in passthrough mode

[1] https://lore.kernel.org/linux-fsdevel/20231016160902.2316986-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20240131230827.207552-1-bschubert@ddn.com/
[3] https://github.com/amir73il/linux/commits/fuse_io_mode-060224
[4] https://github.com/amir73il/linux/commits/fuse-backing-fd-v15

Amir Goldstein (9):
  fuse: factor out helper for FUSE_DEV_IOC_CLONE
  fuse: introduce FUSE_PASSTHROUGH capability
  fuse: implement ioctls to manage backing files
  fuse: prepare for opening file in passthrough mode
  fuse: implement open in passthrough mode
  fuse: implement read/write passthrough
  fuse: implement splice read/write passthrough
  fuse: implement passthrough for mmap
  fuse: auto-invalidate inode attributes in passthrough mode

 fs/fuse/Kconfig           |  11 +
 fs/fuse/Makefile          |   1 +
 fs/fuse/dev.c             |  98 ++++++---
 fs/fuse/dir.c             |  16 +-
 fs/fuse/file.c            |  99 ++++++---
 fs/fuse/fuse_i.h          | 118 ++++++++++-
 fs/fuse/inode.c           |  35 ++++
 fs/fuse/iomode.c          | 105 ++++++++--
 fs/fuse/passthrough.c     | 410 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  23 ++-
 10 files changed, 838 insertions(+), 78 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

-- 
2.34.1


