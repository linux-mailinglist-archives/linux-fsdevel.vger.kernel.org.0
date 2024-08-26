Return-Path: <linux-fsdevel+bounces-27241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6630195FB8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BE81C21BD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21938189500;
	Mon, 26 Aug 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1k7Gwm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC98881E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707202; cv=none; b=FQCW8vUuC3OhjGosll0lWU5QKUlNhy6Uu0W9iATaTH3SUgmwztoxPZQPNsVz/+GEPAxz1g6l4mx4v+OvrQZVCvfEJrSY/1RknUdYsPETvN8LAV9Yv78adKlflM/yYJXt0WfEu8oK0HDGwCwHWWS9b8GIaoZzM2n4Ez2VrX2NQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707202; c=relaxed/simple;
	bh=v5nidNbhRUSt5upFxqIVRK7gv9s0YSfomEnYbErO5m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCnKUK40JosEgkhMXDVOpxp+m0d936JUHamuyxYmzUOGvuqI1oRyTOL/t975jnIR8ZH3SPgH5XFME5OaAU4tyQT9K41m9uSMq4Sbn76nsu/a+N4pYdRxvtQXWbDbo6+hoXUFh8WALcJqqCycXond1ZVHKEUniU33SiX08Xz7ZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1k7Gwm3; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6bd3407a12aso44946247b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 14:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707200; x=1725312000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qD7THDjTDIU2AjIylt04B4Gu7qWJZDOizaR6D8TTkYc=;
        b=e1k7Gwm3G7atjJBgJMCT4ybj0rZ5jYSpKq3n6MlcMz3unWnMvKnPPC0NcflzggTBlw
         7X65WO1V5Q1uKHFLWY5BGu2UO/YmJMwSKO3WozVXZTguwoUTq1qURNCh3wR9eRPWjRDV
         MFFG3epPZCAfHXMYww/v29y1YpjFZAdsqqq8Bl8D4QufqkCb+s3ozuKc7kh8JvVe/Qmi
         Pg/16B1NNydu6MVFA1t3Lbo/QFeo0pKqYCGLS/gS2yoAE3/akw7NqejGscwRaLIqGIFN
         0ZCkUTNw3A6VuVfEp22kh8mWdXGn+H61pHRRm+cK3SFh8ZXdYyHvzmuMA2SRCp92fVD2
         Kw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707200; x=1725312000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qD7THDjTDIU2AjIylt04B4Gu7qWJZDOizaR6D8TTkYc=;
        b=oir8Yvkz4r8AYVd7zMUDh/v6JMFBPyUTMuih2ra6kWhDt3d0BAIys5eY5oC8j48AYx
         4IjhewhNJs6qwKdhfLxaxlerm4iHsxVARAn6jPVFR/Pg46yoXho/C409WIRg3vbksRQV
         gXKbwYklwDCGNnc06GPLrMhabvY5HeTV2WeY5upYw9FjV3H2yyScqDDu8XN6TuHC2Lmf
         2wYDDNcKQ00ruNmF3a6ahsKPx2nj9IaeqRyAAGE0rwcLVHudfsUgQhZmsbVI0ExOFmK2
         1REt1qkSfXp8idAQGK0OS/q9BdMttlrlUElJAfjcUpTfN7+4fCJGs+XC63UbcaK6vPw4
         D/eA==
X-Forwarded-Encrypted: i=1; AJvYcCXVgTb0evgiBjd6RBZIDp3eV4grrOB+nSsD9MRpnmV78WEv5g8Yn122y2hV+XNm/3YLJZ6QepH4bl9ohnIM@vger.kernel.org
X-Gm-Message-State: AOJu0YxqfRyThvIONvO2KjfNO410v5yuG8GNg71iKfID3pFoypiNNkUp
	jhq7AaldLdjWAA6+3J60zhK0Xs3LprJUDr3yAgMN/x+QmvQ6UzQH
X-Google-Smtp-Source: AGHT+IFmjaxxzK2z4YSUKa50R9EUSPFRZm3qubNXFVnqS3XzjIknEIYEIZnHTU+EoAGpWHJu0tez2g==
X-Received: by 2002:a05:690c:2b02:b0:6ad:ba92:1731 with SMTP id 00721157ae682-6c6288aa596mr95830297b3.41.1724707199957;
        Mon, 26 Aug 2024 14:19:59 -0700 (PDT)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c399cb5020sm16975427b3.26.2024.08.26.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:19:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 0/7] fuse: writeback clean up / refactoring
Date: Mon, 26 Aug 2024 14:19:01 -0700
Message-ID: <20240826211908.75190-1-joannelkoong@gmail.com>
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
./libfuse/build/example/passthrough_ll -o cache=always -o writeback -o
source=~/fstests ~/tmp_mount
fio --name=test --ioengine=psync --iodepth=1 --rw=randwrite --bs=1M --direct=0
--size=2G --numjobs=2 --directory=/home/user/tmp_mount

and (suggested by Miklos) fsx test -
sudo HOST_OPTIONS=fuse.config ./check -fuse generic/616
generic/616 (soak buffered fsx test) without the -U (io_uring) flag
(verified this uses the fuse_writepages_fill path)

v3:
https://lore.kernel.org/linux-fsdevel/20240823162730.521499-1-joannelkoong@gmail.com/
Changes from v3 -> v4:
* Merge v3's 4/9 and 5/9 into 1 patch (Josef)
* Merge v3's 7/9 and 9/9 into 1 patch

v2:
https://lore.kernel.org/linux-fsdevel/20240821232241.3573997-1-joannelkoong@gmail.com/
Changes from v2 -> v3:
* Drop v2 9/9 (Miklos)
* Split v2 8/9 into 2 patches (v3 8/9 and 9/9) to make review easier
* Change error pattern usage (Miklos)

v1:
https://lore.kernel.org/linux-fsdevel/20240819182417.504672-1-joannelkoong@gmail.com/
Changes from v1 -> v2:
* Added patches 2 and 4-9
* Add commit message to patch 1 (Jingbo)

Joanne Koong (7):
  fuse: drop unused fuse_mount arg in fuse_writepage_finish()
  fuse: refactor finished writeback stats updates into helper function
  fuse: update stats for pages in dropped aux writeback list
  fuse: move initialization of fuse_file to fuse_writepages() instead of
    in callback
  fuse: convert fuse_writepages_fill() to use a folio for its tmp page
  fuse: move fuse file initialization to wpa allocation time
  fuse: refactor out shared logic in fuse_writepages_fill() and
    fuse_writepage_locked()

 fs/fuse/file.c | 167 +++++++++++++++++++++++++------------------------
 1 file changed, 86 insertions(+), 81 deletions(-)

-- 
2.43.5


