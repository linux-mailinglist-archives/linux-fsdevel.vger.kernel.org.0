Return-Path: <linux-fsdevel+bounces-10785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF42784E653
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B02E28D07B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C982D76;
	Thu,  8 Feb 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+v95nX5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E98823B8
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412035; cv=none; b=tFtn9mh5pmdPpEXSQY3fuSdfcxkoxQ1UgZG/NQD4eZf8OXKlIpU5nL5H754JqhjQBGZua3w3i4Px/aA4YNdEcfPtcJEr677Cr2pgMUTHPq6mLivyCdVU7ITc3Tv5iuGa7I9v+vrImyaEFbfpCJiES417ZJfNik0Xn+hl74dnrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412035; c=relaxed/simple;
	bh=AvV8/fJ3qhrmjpgSTr1rG5jqoYlWuN0Iu/nsUJH5D5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hi/Lt3QtvuEPpkkDWPESMu7mxhQv/c+Jqmppw9EDHzV4raSOoL0ixIZ8PPwxgv8FoX5llba984qnUmRnByBPeh7fRALpSVEhkR2a7WMjMA0l+Y7bSpUa4qvDphx4el/bE7/e29pQIqv1bZLc1dVndxBnKFtQjD4XEXBT40QcxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+v95nX5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-511689cc22aso26440e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412032; x=1708016832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2GVCjBhDTbeHaveHTVE6c7gIqsVXKkQTEo8084mo/o=;
        b=D+v95nX5YSyPxBlS8vzvM4uE2L5jIg+TyGHDKd0Q7TPeS0EF9NFrY9UkdtYFv0Gt+5
         XK2szza/In+jNNhqIoakRpE2vrea8eUP+6kt/VHwAja/belqlDZWJNT72ft9WTmJoWg3
         j4IWp9Wb5H2Jxfoz0IwGbSQsijupJ8w7kznrcVwi88QrOb3xnxgIZMtEitgD5+14/58d
         tRHqGoLOD6wSy+TsMY7CmM+VlVJ11tXZYDzNc/B7hBUqRKkDsFiO74SEbVPsmVR6TP6Y
         9a9/+p1BH3nQDOJSYOXC8Lkn2qWtqBJ2LI29x1GLLmmyxmHAKtiqNT9alNB5We2pUasz
         o5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412032; x=1708016832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2GVCjBhDTbeHaveHTVE6c7gIqsVXKkQTEo8084mo/o=;
        b=MQk60xd1VamTQv2hyDcW3uh0FGrIk/6ttOIecDeqkXOjHW4ZSTL7eyeG1Qu5eTp+Gj
         KO8p5QdA6316sthJYor4XrEipJnjwTnGLI95JmjLZldf98ua9NURPsUyXxg/E+Wy2WCR
         oeOapUoVNQ8iaacYHRwTYTDr44/R7w37GSiaKaLV1YKUCBIrMne/x3X/kuH5C4+/6v24
         xtoqeKupbd00IbzJGhOm6MRSVVO8Y0QSRZ8SCWmjAM9FSA+CH4LUvYoAzVKjq3qnib2C
         JSxUs4LAfvVOrAJMyOOG14+NJVgHxgZ1k2gx/4XREEvJtdZbiJNEgbkNhB9wTomzmjzd
         Kvjw==
X-Forwarded-Encrypted: i=1; AJvYcCW+AEaTfChMxDEwDE2ad5nUVke+eSt6OXUeI/9b5BTd6QWFTmaUAtboaV588pEYuqytCRBDia2bsUuYnDZG+u2s9jTgKZjLH11s6ItRCw==
X-Gm-Message-State: AOJu0YzCQ1ToYu4w4Dh8b7lW54o82Gx1kA5Gr5m90RfOLMQqne5vX2pY
	GVPEmoEDGVUfbiqQ41LPnufnBcbzI7+UllzzQ7qakf8f0qNTZlV3
X-Google-Smtp-Source: AGHT+IGYJPf8dID4ttQkDkL3XDxJQ53JhMxVQMYEiJC5Bsugyrmdo6lnd/h53HPvb8ZYPTfS6DeDLg==
X-Received: by 2002:ac2:5e9b:0:b0:511:484a:dacf with SMTP id b27-20020ac25e9b000000b00511484adacfmr5885524lfq.30.1707412031589;
        Thu, 08 Feb 2024 09:07:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjInHpSHSivuOvBvRqySp1lNXHFkmslvGekNT6Ju5Jj22mupSAw8AsBv/jSR3dvAQS05PpvKwKjZlB1emu3uoyZK8lFAhyE4Po/FagNg==
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:06:19 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/9] fuse: inode IO modes and mmap + parallel dio
Date: Thu,  8 Feb 2024 19:05:54 +0200
Message-Id: <20240208170603.2078871-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miklos,

FUSE passthrough patches v15 [1] are based on this series, so I am
posting it to the list for completion.

This v3 addresses most of your review comments on v2 posted by Bernd [2].
I added all the cleanup patches that you requested and addressed the
review comments related to my io modes patch.

I've also split it up the io modes infrastructure patch from Bernd's
change to wait for parallel dio in mmap and caching open.

The one thing I did not address is that I left the FOPEN_CACHE_IO flag
as an internal flag as a way to signal "this dio file holds an iocachectr
refcount". I wasn't sure that you are ok with it, but I wanted you to
consider how the entire work looks after adding FOPEN_PASSTHROUGH.

Bernd did not have much review comments to address so he has tested
my branch and asked me to post it.

Thanks,
Amir.

Changes since v2:
- Split "wait for parallel dio" from "io modes" patch
- FOPEN_CACHE_IO reserved flag cannot set set by server
- O_DIRECT without FOPEN_DIRECT_IO opens in caching mode
  in anticipation for O_DIRECT flag change via fcntl()
- FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO
- Moved io mode helpers to iomode.c
- Change return type of fuse_inode_*_io_cache() helpers
- Separate fuse_dir_open() to not take the io open route at all
- Remove the need for isdir arg to fuse_file_put()
- Avoid post truncate attribute handling after atomic_open()

[1] https://lore.kernel.org/linux-fsdevel/20240206142453.1906268-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20240131230827.207552-1-bschubert@ddn.com/

Amir Goldstein (6):
  fuse: factor out helper fuse_truncate_update_attr()
  fuse: allocate ff->release_args only if release is needed
  fuse: break up fuse_open_common()
  fuse: prepare for failing open response
  fuse: introduce inode io modes
  fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP

Bernd Schubert (3):
  fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
  fuse: Create helper function if DIO write needs exclusive lock
  fuse: Add fuse_dio_lock/unlock helper functions

 fs/fuse/Makefile          |   1 +
 fs/fuse/dir.c             |  36 ++++-
 fs/fuse/file.c            | 280 ++++++++++++++++++++++++--------------
 fs/fuse/fuse_i.h          |  30 +++-
 fs/fuse/iomode.c          | 245 +++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   2 +
 6 files changed, 482 insertions(+), 112 deletions(-)
 create mode 100644 fs/fuse/iomode.c

-- 
2.34.1


