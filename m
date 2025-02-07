Return-Path: <linux-fsdevel+bounces-41235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C836A2CA4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2450116B244
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7719DF64;
	Fri,  7 Feb 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GdtCE5ve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881419597F
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949805; cv=none; b=iDOfptIBtDiBvrPHFbMW0ti5fdB2H1g2Xw2i0fGa5CXd0EKQDOStvZGjmRnenSqUPYJjb5duhzTvH5G1OlVMVm5mlNe7fL0RVV4XPRU8SyqIcHmAjdO2QtKjld33w+3etYe7YEbWGya/Xr0Mg1ldhFU1vG68uGuUtumlf6tHRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949805; c=relaxed/simple;
	bh=jVs61PierNiTqkPVDmWFETbkY75KDTUSaQwXKjPn3YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCrTXirpHWaByZ4IeVig9t53Q84U2Qb6y6+GUuOPG9kB5UBZlw+8hsQu70tx6eSimPpuJnlv4CmOQQ/lyUcFPmrWPToo+ekscmobIQ0r/oVv7/tCnh6cvQu+qF59f2lcKOmnh8n2eeuwWqKsmWng5EzsSl0VVEJ/9RS6K/PIDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GdtCE5ve; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-854a68f5aeeso51929539f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738949802; x=1739554602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSoBBvU7ywT3hNwAq6aMomh4rrzpxK+7oT/RYGwDXko=;
        b=GdtCE5veo5XwRdl1mJLWMxm7qQ/o8Y59FkJjgZHNOinTD3OpWKkvy4JdCFUm9Rxk0n
         mjIKpIfdpT0q8nNm4AmzYHFTaNxR7+xykxBv0DjZReXv3EIWRV0hsoa3PUnivKciXFM3
         tIa0zXmI/zILvHcOrKDz25/cjvSJ1p5MWl9JOOovPVrfH3pj/lf0TANtyDmAUqLswZa3
         KnA8GDu4Vjk3JhAaqFuucO5Sp9JmDVmLn6k2WRxqf8yqHSrw8+KkrUCT8NK1KKwBn/gb
         7AuhDAO+/Njv3PDR/BoVlY8KtfctGnXLVVEKDMEPQjZdNSWQUaBnQdCoVgsGU8PRIzjc
         1DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949802; x=1739554602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSoBBvU7ywT3hNwAq6aMomh4rrzpxK+7oT/RYGwDXko=;
        b=aQwH7fJNSk5I+8IaK9P38QO0l86yQd1QMTSD486LKr2sZZVevfkExj8O6+PbSios0+
         lrXrAojDk/2B184GBJD0KvLqzs7S+jBt/yon48QAzh8VDwTHamKRQtNgW6siEZYDaiqq
         HLLLzE+lptDwu9SbY7YkoanSGCTVTzS8zvVjbEvT1h+wluIYmHdUfaXogvpArfmuQStq
         hREbcUGNOefOGyck5nA6Jg+BHFiZ7zvHbVPSjvsH6gfJRulRflPsEK+o7Fe/UTmDbH7X
         4gMBB7fTWCS7XrYDh7bV5RD5GkWuqdOh+ZeT/PpjclGj/N6wdBu3ZM52HbEgVE6YoFXz
         72Ug==
X-Gm-Message-State: AOJu0Yx+Dprj/38/29AnrjB0HzV8bC1Sy/Ck7A4F2NURy3j0YrMykPE4
	hri7z9BM5TUh5+KVroJGhWovK11Jsa6TTnALJ4ZN5xzxwqrqaQnTNFNzpQo8cT/ephbwKddTtxR
	5
X-Gm-Gg: ASbGncsAlufy1p7Do4coRH8kToaQ1Mu2/7MKJo/LTbj31KYPDL9ijp0eDxXuV1X2cHT
	BERGWP9KEtPkCIgcbRTfcTR6fdCqRUGZANLILCtaHS+NSSnCyV/zowjzkyIQftiJhGlyCu4Ff+E
	xh2sZOt4KHh2v0wUG5noVf3COAahnMRevW1BLF7fJHD29smtC4NSGbPtuzNxBhSPu6gxbenRR/d
	eYHsI/i4DTPSPNnpiTv+nzDfIt/xsH+XY4AauI29CJjtIjpUOHd5hb3d4y0FxL9qXD7/nEBsbnD
	0kerr/u6zJvqMTkHjXA=
X-Google-Smtp-Source: AGHT+IFq+mH/6dEEvBq3HtXFg8OdM2MrA6SkJsi8ng/OZobuons/ZhuSKJfrOFUmuS7Iw8azo1/gIA==
X-Received: by 2002:a05:6e02:1a23:b0:3cf:cd3c:bdfd with SMTP id e9e14a558f8ab-3d13dd3f2c2mr32658215ab.12.1738949802326;
        Fri, 07 Feb 2025 09:36:42 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ece0186151sm206241173.111.2025.02.07.09.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:36:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCHSET v3 0/7] io_uring epoll wait support
Date: Fri,  7 Feb 2025 10:32:23 -0700
Message-ID: <20250207173639.884745-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

One issue people consistently run into when converting legacy epoll
event loops with io_uring is that parts of the event loop still needs to
use epoll. And since event loops generally need to wait in one spot,
they add the io_uring fd to the epoll set and continue to use
epoll_wait(2) to wait on events. This is suboptimal on the io_uring
front as there's now an active poller on the ring, and it's suboptimal
as it doesn't give the application the batch waiting (with fine grained
timeouts) that io_uring provides.

This patchset adds support for IORING_OP_EPOLL_WAIT, which does an async
epoll_wait() operation. No sleeping or thread offload is involved, it
relies on the wait_queue_entry callback for retries. With that, then
the above event loops can continue to use epoll for certain parts, but
bundle it all under waiting on the ring itself rather than add the ring
fd to the epoll set.

Patches 1..2 are just prep patches, and patch 3 adds the epoll change
to allow io_uring to queue a callback, if no events are available.
Patches 5..6 are just prep patches on the io_uring side, and patch 7
finally adds IORING_OP_EPOLL_WAIT support

Patches can also be found here:

https://git.kernel.dk/cgit/linux/log/?h=io_uring-epoll-wait

and are against 6.14-rc1 + already pending io_uring patches.

Since v2:
- Drop multishot support, to keep the initial version much simpler
- Drop provided buffers support, not required without multishot
- Cleanup epoll bits, notably adding a separate helper for queueing and
  checking for events
- Various other fixes and cleanups

-- 
Jens Axboe


