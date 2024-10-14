Return-Path: <linux-fsdevel+bounces-31912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3D899D664
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 20:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D05C282C74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 18:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AC51C876F;
	Mon, 14 Oct 2024 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKAnHLde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D11FAA
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930229; cv=none; b=PgLceUGmVEMm4A6mo9qSkq7Uw0c5y3J+fziOBcolwDg1o0ZAGsAz1MdEStqR7/w5mq8gcmGXUQqOzqgZ3/0QKkn8+WXqskNK52E+j0z+9PShcdQYC8sLNVSF0UklZD1zNn49vgfD/jAYNuGnl8BNZPWx4BR6jTDL/UPYtXsv0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930229; c=relaxed/simple;
	bh=MXOfuRNOrAVdDjYsh+L2MRf5e6HmB1qE92mlQK460nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDjPZAQw7ytNLy4LSQ+5MlVU/zMkLGYdAO2KP0Mtcfdw0vmKDkAVh0dceC0t/S9JbUgg0b8iVXjeBwZrojyY26Thc4fpH2LwPW0CO+Tv2qqidTA6NuRohzIUe99zhLLhHEFVlY+trU6zoaos0JFTAlu1FIZl5d5Fqkg15D65cds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKAnHLde; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2e4d16c2fso38992407b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728930227; x=1729535027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUW0W3ZYpo5yrkhIlDPyYy/jLNeC+OiB6o3xInhHHd4=;
        b=kKAnHLdeqLrciJ5dC0kwiUSrF3dyPWN6OeYg6RSGd+ffpInoxXEq2gYRn2634EvW+4
         zrJ2HhmH19XFP/Az+e10l1GHUAmOiqyATT6p6AEre+HWbINsLcIH1Dbh1EqsDDhroMLR
         nOfY940rEXmcNNAZMRTtrpwCOi7ZQSj3xonAY+3oBbUq7xpSUCWT0VZoWDxTz5xmqR6V
         238gqh1JzSu5kgbwBlHD6oxnASPvst1znT9oM1Gh5RTy62WPeh9P6yAsJlyEUxZxT4GX
         kiuI0XoNrRB5y564Cqda7YmAIHtQ5Bd7IJcB2ry48tAF0czsRimZiFtUJNPdn9Lk6KLD
         RGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930227; x=1729535027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUW0W3ZYpo5yrkhIlDPyYy/jLNeC+OiB6o3xInhHHd4=;
        b=EhckWrwSZYsQNw/FbUlyOwnIXSvmIov/oxlMtVGLQCvFTNnAoPt67Klx7y4LeszSPj
         EKtbbVznWJKkESFGnssspU9K+8VLddC6zxscLkx0K8eXn5QYKvot3OnKu5BgymzKXHze
         90jdPgWdrsTEiu5xiMIAsMQs4nrGj37Y8ak9quOyvWNX29pskWoROHr7taG0RKAL1pAI
         4XMQCCV8ra6cf9hHQ6fEfJ4+8s7G3ntlAB+Z6zDPYz7Lbf3QGQQ7ImeG0WIN/mpn5Jb9
         AWNKX5Ll5CEml8g7hFTNVQFlJ3XZGjn1SE9iza7ZKFdZX6vsSCwXO37+AZphMhxqHVNE
         T8fw==
X-Forwarded-Encrypted: i=1; AJvYcCUtm+4FhXTDTegz4MnQTDGfiSmKE0NI82sxLwCljRze4y6YSGhX3PhUfRSxx0JdsTPf28ZZSdVCe8Jo3mp2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6Pues+WmoQxotjEWmQxo1rXXqfcvbE+VKN5sOCX0v4wSQwYf
	VO39ul8G2x1vEfX2n0+ZYDaleVo+5Z3KEo1fZFpbzDXifelQCQvp
X-Google-Smtp-Source: AGHT+IE672zZjQ5ddWW1IuDHcJ2WYACurGMsHxdrpv7sze3pdWJuvgaUDJHKCdZVmSKnEkkiVq0n1Q==
X-Received: by 2002:a05:690c:680a:b0:6e3:1537:3d54 with SMTP id 00721157ae682-6e3644cbcfcmr61465727b3.45.1728930227226;
        Mon, 14 Oct 2024 11:23:47 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b618absm16108177b3.22.2024.10.14.11.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:23:46 -0700 (PDT)
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
Subject: [PATCH v2 0/2] fuse: remove extra page copies in writeback
Date: Mon, 14 Oct 2024 11:22:26 -0700
Message-ID: <20241014182228.1941246-1-joannelkoong@gmail.com>
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

The first patch adds a AS_NO_WRITEBACK_RECLAIM flag to "enum mapping_flags"
to indicate that reclaim when in writeback should be skipped for filesystems
with this flag set. More details can be found in the commit message of the
first patch, but this only actually affects the case of legacy cgroupv1 when
it encounters a folio that already has the reclaim flag set (in the other
cases, we already skip reclaim when in writeback). Doing so allows us to
get rid of needing to allocate and copy over pages to a temporary folio when
handling writeback in fuse (2nd patch). Benchmarks can be found in commit
message of the 2nd patch.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com/

v1: https://lore.kernel.org/linux-fsdevel/20241011223434.1307300-1-joannelkoong@gmail.com/T/#t
Changes from v1 -> v2:
* Have flag in "enum mapping_flags" instead of creating asop_flags (Shakeel)
* Set fuse inodes to use AS_NO_WRITEBACK_RECLAIM (Shakeel)

Joanne Koong (2):
  mm: skip reclaiming folios in writeback contexts that may trigger
    deadlock
  fuse: remove tmp folio for writebacks and internal rb tree

 fs/fuse/file.c          | 322 ++++------------------------------------
 include/linux/pagemap.h |  11 ++
 mm/vmscan.c             |   6 +-
 3 files changed, 43 insertions(+), 296 deletions(-)

-- 
2.43.5


