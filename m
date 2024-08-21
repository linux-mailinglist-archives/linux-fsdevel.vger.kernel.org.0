Return-Path: <linux-fsdevel+bounces-26565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F495A81E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47CB1C21FCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CA3176AA5;
	Wed, 21 Aug 2024 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6crJZt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638526ACB
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282707; cv=none; b=DPlaFUIyY1tcHjqSjscuoACZRBGUNgn3/JnR/3HIsLQJH+HiduzaRVLSTJdHgRMsuBIyIKkdPbuqjWXYLD1RcB0bvWLUvcFPZzTfbjakANB1/4kWonec9U7Vy83TTo0EMPWZRSK1kJnpJr7MFqr32rZ6YdH9hiUvIj7q5f8TROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282707; c=relaxed/simple;
	bh=V0qP413ewLP+EloTSnMUyrGRt1DzEJlZMA9vUmknKu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9Xm+jV6BCOZUArnl250AgVxBYDdR/gRjOMEeYBMN7UrS5ZGPG9Dswz1IwEXssl5DTri/lwGLmYD3LpShqe8WDL5ahT4uImJWvp/KcRNR4IlpPLgNePwVGckCz/NfzsvO/I5/Vjg3lqcwQOtDvdZp1E2F7YmcUAq/Hirl79IfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6crJZt7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6b5c37a3138so2501157b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282705; x=1724887505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CyuApc9mYmmnNkCZOFZsxFAJOS0r3TiuX7DWMb9thm8=;
        b=X6crJZt7XR70psR+c8eY+NO5UDtLyfWsDO3mnUL0UgEP0MigUKhoSd6MRsjhEJ35nR
         IzrPIyvSgL+yKBZbTNck0uEPBMbGyZ8bS9ombopXPJ+d0HXtJflwdX3Y33gZb6pB3GtF
         kx6fAy91ACRRUs8S2BFofyrSpomqCghqhHSj7/ouzh4G74QCh4uEJoUGvfx162pnuOqq
         WL5A9Mdc+dEBSstkSdMt0nnajLif3GDMnolY4QW5yCw1807Xh0YiBDpNOP0428c2tvD4
         09K1T2T9A23YuUvBReF/8uWUQQ+mNOO1AtwtrjPLk/DwUw+FRtbwDDYUPUqatTP/A1GB
         TsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282705; x=1724887505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyuApc9mYmmnNkCZOFZsxFAJOS0r3TiuX7DWMb9thm8=;
        b=IPXyIlTWc6kJh5t6/SvmowEbwryJ/GoiTwrLzSReyCONF8K+IVEmS9l5hlaBKgChTx
         XTfFex+WvO4n4kwuyfuB3Ri10eULH48PhANR80ZHZWy6E5/smVY7YE1mnNc4XmL1KeP7
         ZVixWdaznBXwKXz559Ga07eGtf073UvEYA5YWnlWdaMGvJYdCeZ0tox9yFHFHauH9zCD
         6afV1SaRwV5EToepxFNr6RtmXawMXrPKxxV1KUTjjSBZP9F3iLKgMs6INS/aH8JdTwQ0
         KL7vZuQTb44oVObTxgEdhgN8mWd3theSLr/1DfnZW+dMBUcpZUBFV0KVWTocVFK62Y83
         eyZA==
X-Forwarded-Encrypted: i=1; AJvYcCVkw0fG43uw1gDWqBSeafF5MU06L3iCBnF9FlkvA9happ6rSxDL682Wf4MKhV4zr6lJrUaFPj43VNT6gms+@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5O3fED1W8a6k0sFA3OFTwkMFcCzCzqGw9S66ulzxPyW/2jsA
	xiKAy6zFgqtlLYg/cQESZZP5pbCVKaKgrhlOE7+frLUWGgn1kK+4cXaO3w==
X-Google-Smtp-Source: AGHT+IHu1DerUf9Fj18pj7DlD5rYBw2tK6cwi4aasG8/K1/is9JXcDuAwCaYPepGluGDpY4tDRqGTg==
X-Received: by 2002:a05:690c:5701:b0:6ad:b725:4418 with SMTP id 00721157ae682-6c3d62a337emr370547b3.41.1724282705152;
        Wed, 21 Aug 2024 16:25:05 -0700 (PDT)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39dd47b1bsm364407b3.104.2024.08.21.16.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 0/9] fuse: writeback clean up / refactoring
Date: Wed, 21 Aug 2024 16:22:32 -0700
Message-ID: <20240821232241.3573997-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains some minor clean up / refactoring for the fuse
writeback code.

As a sanity check, I ran fio to check against crashes -
./libfuse/build/example/passthrough_ll -o cache=always -o writeback -o source=~/fstests ~/tmp_mount
fio --name=test --ioengine=psync --iodepth=1 --rw=randwrite --bs=1M --direct=0 --size=2G --numjobs=2 --directory=/home/user/tmp_mount

v1: https://lore.kernel.org/linux-fsdevel/20240819182417.504672-1-joannelkoong@gmail.com/
Changes from v1 -> v2:
* Added patches 2 and 4-9
* Add commit message to patch 1 (Jingbo)

Joanne Koong (9):
  fuse: drop unused fuse_mount arg in fuse_writepage_finish()
  fuse: refactor finished writeback stats updates into helper function
  fuse: update stats for pages in dropped aux writeback list
  fuse: clean up error handling in fuse_writepages()
  fuse: move initialization of fuse_file to fuse_writepages() instead of
    in callback
  fuse: convert fuse_writepages_fill() to use a folio for its tmp page
  fuse: move folio_start_writeback to after the allocations in
    fuse_writepage_locked()
  fuse: refactor out shared logic in fuse_writepages_fill() and
    fuse_writepage_locked()
  fuse: tidy up error paths in fuse_writepages_fill() and
    fuse_writepage_locked()

 fs/fuse/file.c | 192 ++++++++++++++++++++++++++-----------------------
 1 file changed, 102 insertions(+), 90 deletions(-)

-- 
2.43.5


