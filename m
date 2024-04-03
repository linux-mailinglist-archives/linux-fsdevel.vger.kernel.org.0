Return-Path: <linux-fsdevel+bounces-16030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F1B8971EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 16:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0397E1F28FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C714900C;
	Wed,  3 Apr 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B6KC+At7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25F14882F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153093; cv=none; b=Svp6BUhjLAd0BomRusjg4qpvcFG4xaevL9cNoS15kMTatjysSIKDGLfBeB2+9Jq1HCVJjrGU6W/Ek9AJhU44TGoQGsm2Wiczbayff0ZGNv7Wu2+P3EPU1pdNVGe2HersqBW87VsTvIWkZJx9fl55iV6vwluNO70MQmFBTz90LsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153093; c=relaxed/simple;
	bh=9bR9uidFJljssUBEjRj7U4HEyVV6DCBDCUm4+7Tk/SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViGotHOcZJ9FW7JDDh91jthFD7THUjlepRlGRdZ1E7sypztgt1zqd2LpqPcHmtLom9SkGwUUPZmSMVkMpJPde/zA0raVv+DjRXYy9U/EDkViglx0m0Z3a5EjmveLVOFfL/m3BdgL/I3v/J0pHLlvGeXUU14CXKbMlJx1y23BdnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B6KC+At7; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d341631262so21023439f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712153090; x=1712757890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=60D2dsRaBW+2mEAkcXZIgJC7Rr7l0v2bYCjZOQO3Yxc=;
        b=B6KC+At7WF3OJYZKD5L4LqM9GCBQCJAZ7c9gcn0fHiffiJw2S0oT0xgIXd24gnpFyK
         +MaxDfKGYLviqGtoQGd/BOU2pMuh/hvjVEoyqHrBXxmFZ9dGU7tAq3fgC0xwzdagws5+
         D00u1Elv3rOgZOisvudoVllEt8i6/FHTEflvZL8nDTyl6xifRY50WO4i2y3dciusNi2i
         6i7lVocnnwmGwczdCDWg83kBS2MuQ6TFeho0m5uFsTQOKL+ka1kWgo5wRFyghHvIO2mX
         onr1ta5QBPni7FvP9soqjTG0isJTzb1IGVV+eeyGwax1x8SL9ltpvQjXxpI9sarkcQqQ
         ysOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153090; x=1712757890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60D2dsRaBW+2mEAkcXZIgJC7Rr7l0v2bYCjZOQO3Yxc=;
        b=jkfMirOCsxBbqyP/BUX2qCq3HJgu2tQwCbU/l42Wh+gA/83S+Tiz5++45jj4xNNkz2
         iLVmgWiP7xk09KTbJmKdILzinZuOAahL7NoztZImg9/9zEQYTmV2SBK6k3qTutMW22Jp
         7pB+YaWAhXTLhu81kq2kuKepSQT8RbRUPUG2ggJFVArIvzu/Z6nwC29Z0VbnDlvlidyp
         KAjCw+dqeK+lZ0DxU95EUUrbO3fxMs/9AD58whOmk5q53rsvQcCrbQBE0H4JMujJEN9h
         UGNixuZ/JIpFGhoYvHiU3z+4qk2vzBtVAQjnS0fc68lpWxPC516nZMsYYzyKFXBruKD+
         v8wA==
X-Gm-Message-State: AOJu0YxbsPK1RYXrc46EHzaVhkjjXLDsX7ojal1p4tcgOxY8I/5UAtDC
	HRIYTV4nPXHOreCOIfOwB/cE6X/JxTEt84Dr0b+pcWr9E/YpaUye0LOwk8rDb08Uzg+1peU+1Zg
	u
X-Google-Smtp-Source: AGHT+IFgJ/+EiGZcRaKBxWwIWI7fnIcJtk2PXn3ayYcARmzBtHy0Hs+SNVDALrGNmm4YHf2VTf3zxg==
X-Received: by 2002:a92:6503:0:b0:368:8d92:3262 with SMTP id z3-20020a926503000000b003688d923262mr14486682ilb.2.1712153089710;
        Wed, 03 Apr 2024 07:04:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a3-20020a056638164300b0047ef3ea2bdfsm2027098jat.78.2024.04.03.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:04:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 0/3] Convert fs drivers to ->read_iter()
Date: Wed,  3 Apr 2024 08:02:51 -0600
Message-ID: <20240403140446.1623931-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

There are still a few users of fops->read() in the core parts of the
fs stack. Which is a shame, since it'd be nice to get rid of the
non-iterator parts of down the line, and reclaim that part of the
file_operations struct.

Outside of moving in that direction as a cleanup, using ->read_iter()
enables us to mark them with FMODE_NOWAIT. This is important for users
like io_uring, where per-IO nonblocking hints make a difference in how
efficiently IO can be done.

Those two things are my main motivation for starting this work, with
hopefully more to come down the line.

All patches have been booted and tested, and the corresponding test
cases been run. The timerfd one was sent separately previously, figured
I'd do a few more and make a smaller series out of it.

Since v1:
- Include uio.h in userfaultfd, or it fails to see iov_iter_count()
  on some configs
- Drop (now) unused siginfo pointer in signalfd and the incrementing of
  it, we don't use it anymore
- Add missing put_unused_fd() for userfaultfd error path

 fs/signalfd.c    | 46 ++++++++++++++++++++++++++++------------------
 fs/timerfd.c     | 31 ++++++++++++++++++++++---------
 fs/userfaultfd.c | 44 ++++++++++++++++++++++++++++----------------
 3 files changed, 78 insertions(+), 43 deletions(-)

-- 
Jens Axboe


