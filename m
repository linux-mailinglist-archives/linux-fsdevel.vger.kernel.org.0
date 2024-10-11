Return-Path: <linux-fsdevel+bounces-31788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7021199AEB7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 00:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF57284261
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 22:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4EF1D27B8;
	Fri, 11 Oct 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY7osqVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1A1CEE86
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686228; cv=none; b=PVsCojvLSWM8R/R2zx1f/BN0NL2EPjwJ6ut9YOYKiO0NRW4vAORfcwJ6KXeQi/9JfBQ/Vejsa05WUTyWeaD1J0cFrP1V4v6E6ZjpVqOH2MceMDGNGrPMI1SsoLEd7YEUYZvT3beNRnhyiM+CMO6CqcueXq+P9NgClhO9xC5bDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686228; c=relaxed/simple;
	bh=TGSgt74YF4uTLLDOYGT8DToNUvJPKtcFi5QSsqN18Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7y9TAaWj4/Gle4A7hBvZaweCoyshDExHxFp2BoJ7kdMI5Rz/OqZUb92F7S5gta2MRJOIdgLZC/OCPgaEACDABktjn6hVFKGHEmexUhmYxuvMJU4sxJeg1h2v1Sb3QO0WE8ZmTd+ZiMcV326U7stZ+JkeUeihVdpb1QYF2DgOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY7osqVp; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e29327636f3so266149276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728686226; x=1729291026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GckUEeUkGJ/MXaNICUW/EN8rJNPMFxf0v5zONX3nnpg=;
        b=BY7osqVpi7SqJ/hMw1UrkEF0aHWxEHGagNRAI9zw5NAmUpwub3kW1zJuSh3FQoc6Gi
         RdJMaMd87etSgOqjye4dvAXRPPl54VyINAdPxGnR9IbUwQWOrlZ2YCWZAzMrKuvOozqY
         cfPXNB2mO5qhMULeyTlIVhWnndHWheAeKCGLHGlTR4jet822kDXygHIAYMl4RQL21++w
         dl6+8nvLsj9PBtOMbAAFF57RWP516rPnckrJnAZZGPJp7XhruJnFZSAq6eB43gzBovaO
         W/+uGBJbmGkZhxbZBaQ5qZOhO9vD8jQCWN0vErLqJrEYNJaYPcL/SRQNpUhP+wNDY+wX
         puBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728686226; x=1729291026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GckUEeUkGJ/MXaNICUW/EN8rJNPMFxf0v5zONX3nnpg=;
        b=Ashe4BJLELZzWu/WQoauXQ7q+NhgUUr3iDtWq7lW4+fUv7SG+h0hG7r5rmE9PxIv9F
         G7Sx1QYZu7MrsFXRzBcRdzrywvxEJxFMgll5iDo998POwrofTtrz1/UxKYCuOYj7obis
         UzlmcFAqDHfy+m3V4o8OCoROVafZjEIehXYZ4GHQqHSsA8gfgS6MopXHD30CPjQsldfn
         iQQYyWyLSE5E+/gxsl7DQszAfylp4hr6NHmYrzNvNqrC9UIR152US1/v/SCgL0DroLDj
         grc1GJs3KeT5W/rjAAIn7zYZ2wzi0lsjhoKGUhXCd9rKZZ4xm2iM4KdqFHqhKoLfuWRm
         2ydw==
X-Forwarded-Encrypted: i=1; AJvYcCVlHV/7F616qX/JNcMfu+XJHTb/T0SKi8kcM2pUF48gUg1gaBzVdSUBwMwckpp9kzgNdlwD/XFs1Gt9Jo07@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76cDUA4xXP0BwwjcDSQbwo3Sz56zCVdfaiP0AwmP3GH1beR5Z
	sAFmidI85aZGQ/rB2CH+amMiCwtw+EGoQ/W8Glq5Sf+z5VIBE5AN
X-Google-Smtp-Source: AGHT+IG2sFQdjWeH9vJvJDAyO5XNnPVbYOMSEpEREKhf1EN18EbBSHjKmnEC6BXy8I5GKdKTJ+LvQA==
X-Received: by 2002:a05:690c:3586:b0:683:37a8:cd77 with SMTP id 00721157ae682-6e3644c023amr10213517b3.29.1728686225953;
        Fri, 11 Oct 2024 15:37:05 -0700 (PDT)
Received: from localhost (fwdproxy-nha-001.fbsv.net. [2a03:2880:25ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b6199dsm7744117b3.1.2024.10.11.15.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:37:05 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH 0/2] fuse: remove extra page copies in writeback
Date: Fri, 11 Oct 2024 15:34:32 -0700
Message-ID: <20241011223434.1307300-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when we handle writeback in fuse, we allocate and copy data
to a temporary folio in order to mitigate the following deadlock scenario
that may arise if reclaim waits on writeback to complete:
* single-threaded FUSE server is in the middle of handling a request
  that needs a memory allocation
* memory allocation triggers direct reclaim
* direct reclaim waits on a folio under writeback
* the FUSE server can't write back the folio since it's stuck in
  direct reclaim
(more details can be found here [1])

The first patch adds an ASOP_NO_RECLAIM_IN_WRITEBACK flag to the struct
address_space_operations to indicate that reclaim when in writeback should
be skipped for filesystems with this flag set. More details can be found in
the commit message of the first patch, but this only actually affects the
case of legacy cgroupv1 when it encounters a folio that already has the
reclaim flag set (in the other cases, we already skip reclaim when in
writeback). Doing so allows us to get rid of needing to allocate and copy over
pages to a temporary folio when handling writeback in fuse (2nd patch).
Benchmarks can be found in commit message of the 2nd patch.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com/

Joanne Koong (2):
  mm: skip reclaiming folios in writeback contexts that may trigger
    deadlock
  fuse: remove tmp folio for writebacks and internal rb tree

 fs/fuse/file.c     | 321 ++++-----------------------------------------
 include/linux/fs.h |  14 ++
 mm/vmscan.c        |   6 +-
 3 files changed, 45 insertions(+), 296 deletions(-)

-- 
2.43.5


