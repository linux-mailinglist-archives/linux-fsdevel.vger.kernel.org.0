Return-Path: <linux-fsdevel+bounces-65383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A9C03587
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 22:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1A65350999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74E2C11F8;
	Thu, 23 Oct 2025 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="c6LhWJ8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0895EEB3
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250718; cv=none; b=iEbFXV/oNN8lx31XyYreX0MCbdYDC8C0DZgtgg7V+RAdp9IW9IFatIcaXcRGX+ToTYku331/E8LqFIEbrcoe30Dilmn2U2JA1Uhy7KhU9qLSHwX/QwO8RUS32bF2+QyqS++R/TXRYrjIscabjUY+QYx+EkxbZSJ8pDQ7pQ/OH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250718; c=relaxed/simple;
	bh=MNaW/Qmo6FwgmkLQqa0PKYjlcqHuOYgu3MksfCpQ4MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRmlZjzR8/QV7ACT+jxHchP1d3yvMWkCtt6/HkbujFX9rNbFeJ7HW23Gd2BfUznBHfzw1hfznBN/fVLP0ND8OZW/+Q7Ei1bMKGXxIlPo3YsNRJZiAO9TJJVjPpzr5Mj0+6uBJXV/Imqwd0xNyoqJm9q28IEGnx2FEq0g1DgaAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=c6LhWJ8Q; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-b6d3aaa150eso20413166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250715; x=1761855515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cz0mQMPnFRMldaxGN9MCesCYr4t4w4JLIICl6X3LGRg=;
        b=c6LhWJ8Qe9UcznFArqbRWsOQ9aHKKotymYnnEk+I6HYUpGXcm+p2Q2vFNGTC1ha5UQ
         fupBDOD2xiTRww3vIabFbLCqqbt4v5O1tIiXzBjoHxwH78uwRoe922w5TxFsmPy7hvhw
         dKZay05aUFU5O2LOS6SGthy/B8PVTPXCuNAmQFHrtEFPFHYA60KQ1x+jwTvg4erbQdmC
         hA6MNEQj7V2yDyDxNMCIZtUn7mSKYaJxRLtWVeHEP2b+aneeOx3KSRXu02fIQrsGe3py
         sNoCzGq2AQxv6+xL6Z9qNoS/fNiHmu8VP2agrf3Ty5hvJah7d+C0zZas1Yjd1cNdjCSN
         qgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250715; x=1761855515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cz0mQMPnFRMldaxGN9MCesCYr4t4w4JLIICl6X3LGRg=;
        b=uFVjaJfum6UNJ7P8nc+XlzGOXZeHFswZHfbR0jO+z76NBR0oMnVuB0cZ/Qw/kpPtqV
         FJ8RLiUV147LyI83nxZT5coWRS2UHYQ25qETRT4zr9bmQxD2TSrKnoJl3jQ92ag698W3
         LL93dEMutN9NHtb6whpO4U0cuXGn8nf2cXB5B2cw/scuKwjUYVIPvPnDFV0z6INPQYT4
         xfH6rWWGtkMJJDZ1WNjk9oWqs2IgZVR02UB64N/wfzmCH/K7eCbjxsjA6y97lIxRWrxF
         9/YwOyPR+Bv17Mm69uIz4wAukl0bJ8KSr9gczeyIPGWlZ6vv6mLIu0S0bF0vUehS5h0g
         8vKg==
X-Forwarded-Encrypted: i=1; AJvYcCWtOI5UP0Q8zCUclUd4fPuAJQku7sE4pvpj1va9N69A+Qkz4aZRjbWrObwK8+XWtnnKLM1DV+Fl312haPKd@vger.kernel.org
X-Gm-Message-State: AOJu0YyQm7axolY8/YZn/42oYF9l/9oVmoRN2fIQ+NppvOn21yO1oLek
	XW7yESlT/MaSi3K7psGBt5RZROXSo8tiI3k9yIAk/MPG5DjNQcLoF4Ifr4rrz0SqnQ4FOCsJD8q
	sWPPPnT6cDM08sZeeQQ/Jurw34khurZJ7JEg8gVVYpE6/rRiwFmNu
X-Gm-Gg: ASbGncsWau94jAIKInRUYl7R42YCXOEJl9skgngHjkUt9uMtr9Uakkh6EFFKWFyAb0E
	RldK4LqexWmPAeqhdCBcoTtMSradwWxW+g9E0FLC9fNQQv3Zu03Sc2PeMWL9OuL2ifD0tvIYWwK
	uoXNrxAbKNJm/GBIjuOmN+/9LLsnc2jfNbMHY8KVraDIz6y0x2nXcrk4OEhyQnlr0OlQy9IHLA/
	4GLVSQl+otztl/nYbary0Uvy2Z2O9x8HLT+8bz/ZYy0V/1ndH47TdjsVsLqrxyprN+fnf/xGH+k
	donG7uJeREa+Di0qIfsv8H9MWrCsyvo2Td5CQNMmZpJZl9Kr+8Bp0lpKvifE8uoWyIh1fIJUcTC
	JGkr4hNS5TaP3TV6z
X-Google-Smtp-Source: AGHT+IHXhL/uv6eUeaN2ZVLtqNjngQKnmQcL5o8MgXl81NLPuCh85qOP68iyVWTyOMVTjHd4V9x4RLM8fwMs
X-Received: by 2002:a17:907:9803:b0:b2d:a873:37d with SMTP id a640c23a62f3a-b6c722312e2mr832720966b.0.1761250715011;
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d5141d9dcsm15476066b.54.2025.10.23.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9317F340384;
	Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8CBBFE41B1D; Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Thu, 23 Oct 2025 14:18:27 -0600
Message-ID: <20251023201830.3109805-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define uring_cmd implementation callback functions to have the
io_req_tw_func_t signature to avoid the additional indirect call and
save 8 bytes in struct io_uring_cmd. Additionally avoid the 
io_should_terminate_tw() computation in callbacks that don't need it.

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (3):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  4 +++-
 drivers/block/ublk_drv.c       | 15 +++++++++------
 drivers/nvme/host/ioctl.c      |  5 +++--
 fs/btrfs/ioctl.c               |  4 +++-
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring.h       | 14 ++++++++++++++
 include/linux/io_uring/cmd.h   | 23 +++++++++++++----------
 include/linux/io_uring_types.h |  1 -
 io_uring/io_uring.h            | 13 -------------
 io_uring/uring_cmd.c           | 17 ++---------------
 10 files changed, 51 insertions(+), 52 deletions(-)

-- 
2.45.2


