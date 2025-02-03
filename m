Return-Path: <linux-fsdevel+bounces-40626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B577A2600A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5FB166F78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E0F205AC4;
	Mon,  3 Feb 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zvIpyAAl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19020AF96
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600283; cv=none; b=jXMyEItTZOpFU2N6RROnVFhIE1pgMLC4nd4rIyqSpjDOURBs762Nk7j1NOFP0hmJvRYVBI+ALtEG6samkcPEvG7W/A/RUqTfbBV5dTkgxWP6ii2mfFAP3pWK3tB4m49MqECMuFBdvHmu+X9j6TkIiSJ2OPIuxJXesLqS6CsHVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600283; c=relaxed/simple;
	bh=Eh6CfL3J+9qLnJdQQhGZTvA/CkVpRXf3IKCC9/nBqpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ML+ipcjJ6hQxSLXu/XL0r/Ruin3w4TsXQFVAmCu4WLh4I8+L7QrDZMXhsGZJQ1Ywy9p4Eg9W3NA1lo3o72nfkWCJR9oEYssNVOUsX7T9kZoOdxk1Fphd6U3z3CeLPc+SkXvdSUhqJbqPigzjXlRbbBvH7Quq2VqfX2ksZnQh0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zvIpyAAl; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-851c4f1fb18so111214139f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 08:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738600280; x=1739205080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k24/p7Ed3v8fIumQR/wddI23Hx+LYk3RIMynCiodBpQ=;
        b=zvIpyAAlvHykQhtFESv4x2hdamPnmLVyyZ6TkoxmHzL7XYUZDPTYU3dJSPjUPMEFtO
         PJWNBeocYNBrqZ+F7oYovVqvcuvXXKafMU7EdhJDmDbP2mpuEUosJLmmAmjT22csIH4q
         HuA9jBUwAwzv47aHAmOE1sVE66VyIw6IFSpGOoD7qYsIfTkmPs+fKq21rYr7LE5dHAjN
         sLjLqHw2ZP9OG8o7iAUc4FjbyR3xg24ia0XciDJuRN/pbLDHPug+Z+QPJPY/mBwBEyTv
         YbdTG5T9RkCPYVn4lm4cPeijrZh0YJ062Ng17OJXBdApXSS7mdxFx4FE2GKeFlyNQyUo
         kuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600280; x=1739205080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k24/p7Ed3v8fIumQR/wddI23Hx+LYk3RIMynCiodBpQ=;
        b=YVgSAfmlNdSezVVZIll5Myy1Y4Ow/7Ubr0QaTRpQPdyGzhCZHFnBj7CJRPsReREnoh
         gxEkcbNOi2ZIQz+OdAXLonpMsDZcdZ1kcwJFOt6Lkd3akqycO1nFsymKaaQ0qm+sJiM9
         UWhuM64blncnZzPHoQnHcw5HBzSmbob6UBp/wBPcKthx73ewsjUTkP1YDddC0IwZxG9g
         iymDAB2II/xm1xm1DzqGMEZN8fYL0zDqTDEJJ9ZpayxCDxo9LiA2paqqZ52kR5qgXDIp
         t39neEOYvR+qiljeYhTIPgNeeZwMN+FhHW/aBYIvVSRepvSxMgU62UD6QLpdF+zESOXa
         RNPg==
X-Gm-Message-State: AOJu0YxJ6KAaCqK+QXsNRafLHD23joJ/cYBA1ic9Ok2gYBbIEDhmN3gd
	ZRHEqRo5SjGkjeBZ5vS+DvofFEDFIsWNTytUiv4rI4v/UEhk+0i/OalikJ0mMJCPY5XSflLAqBl
	XgZI=
X-Gm-Gg: ASbGncup10CasyCGtVybp0k0fa+6fRknpGFCMqAFb+a11wwTFLih7S11sRmIaU/hF12
	Bi/xUQ2hQLHA9mAp6fGRyQj99RMEk149wMrxxk/OZE7VHWNDJzqPBpiEPKBnlSJCJFldfQ4TTIc
	FRaDh4HNCRN0aX/ZIIB4DprlFYOETH3EpUEOfzFevwsRVDlumEUHOVoT6o4NDmGc1eBOM9yoxwc
	vO5fiHPB0Tvz+4XZRZ7NiLSHmlYPhoxZIqZOZ7+1AWAUr1CvGdOTN1jxc40ZOWq3Cmx/pyrTFud
	FBeaMqzFT2WfG6V4H1Y=
X-Google-Smtp-Source: AGHT+IFW8chk8bC7UMEsG0VLh3R2IxyUnD0gAxD0yd43K2TCZ7H+2jw5L8jhJWUscFc4AvHTldz/3Q==
X-Received: by 2002:a05:6602:1413:b0:844:cf31:622f with SMTP id ca18e2360f4ac-85411100b70mr1950021239f.2.1738600279966;
        Mon, 03 Feb 2025 08:31:19 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a16123c6sm243748139f.24.2025.02.03.08.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:31:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCHSET 0/9] io_uring epoll wait support
Date: Mon,  3 Feb 2025 09:23:38 -0700
Message-ID: <20250203163114.124077-1-axboe@kernel.dk>
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

Patches 1..4 are just prep patches, and patch 5 adds the epoll change
to allow io_uring to queue a callback, if no events are available.
Patches 6..7 are just prep patches on the io_uring side, and patch 8
finally adds IORING_OP_EPOLL_WAIT support. Patch 9 adds multishot
support, which further gets rid of repeated write_lock and list
manipulations on the struct eventpoll waitqueue head. This last bit
should be a nice win, having a persistent waitqueue entry rather
than needing to lock/add/unlock for each epoll_wait() equivalent
operation.

Patches can also be found here:

https://git.kernel.dk/cgit/linux/log/?h=io_uring-epoll-wait

and are against 6.14-rc1 + already pending io_uring patches.

 fs/eventpoll.c                 | 155 +++++++++++++++++++--------
 include/linux/eventpoll.h      |   8 ++
 include/linux/io_uring_types.h |   4 +
 include/uapi/linux/io_uring.h  |   7 ++
 io_uring/Makefile              |   9 +-
 io_uring/cancel.c              |   5 +
 io_uring/epoll.c               | 190 ++++++++++++++++++++++++++++++++-
 io_uring/epoll.h               |  22 ++++
 io_uring/io_uring.c            |   5 +
 io_uring/opdef.c               |  14 +++
 io_uring/poll.c                |  30 +-----
 io_uring/poll.h                |  31 ++++++
 12 files changed, 400 insertions(+), 80 deletions(-)

-- 
Jens Axboe


