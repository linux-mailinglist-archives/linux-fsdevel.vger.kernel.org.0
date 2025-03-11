Return-Path: <linux-fsdevel+bounces-43697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A0A5BF69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC9F175F11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5FE2356CA;
	Tue, 11 Mar 2025 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvAlBG9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754021EB9F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693322; cv=none; b=FAKrivAso41RGrqs9IRynefFe3RvlVMp39CxjweFwaubVOabzFz00ikj3S5We0ABiEMGh2tEckTHbtyahBUDs++1XAxc3Bp13WAnBm8ztk2djbTKix8ud7sXblaOW/1GJh7maeVnb4fgZMK45yK5Ww5li56ElzIcZMQy1rSaoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693322; c=relaxed/simple;
	bh=qOQbrDxah4hbCUuonNEXpzzF5ft11CsPcOE/jbncLRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NBPzCxlfmx0Tkwf0KBKrywGlVAINalvtw6YKGXVuNkzU2Ly0sNMOWwHK1OV5mz38po2ylZxlw3ZaMZEJTCuWbKQQk4ovnG1Nsd46e0jFbaK9D9VNF/rU+k5Kts1KBlMHtsZh8sAi+/1hDZHwa/OS94VF+Bl50ThR/QcT3pdbZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvAlBG9u; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948021a45so45683745e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 04:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741693319; x=1742298119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kffzu/SEBzvG3f/tZnmDzw7t9VG8Hfw/rkb4wwS79BM=;
        b=QvAlBG9u2z4zb8Oq1MhRa6F2AT7Q3L7RmZDZe3Sg9O598DpSiloBqHveHEjXjxCfD/
         94ohmyll5N9D9YHSaW+vP4/76nT9T/mRUHzfkTVO1ZJLEr+o4W+gzQB4RjsUQdhU9Rz6
         fFzQfbUk3DOi6nmVVPENoyYjNzzYQqqxZKGkzPWYpg8cz0Lri5umn4NJWm/p40pBnl6a
         JxjKlzW3Bm6dfHeHOdw5+todmM5teV4Vp6x/10KQJ5XOQR1CZIK3FQkivPswD1xpf/D+
         q8vGn3a/XeIK+1R7jqFxsokBTfTkAw0TMOadEDwlNTvwbo1BV3igFD4XAWTets5S6e8a
         AMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693319; x=1742298119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kffzu/SEBzvG3f/tZnmDzw7t9VG8Hfw/rkb4wwS79BM=;
        b=DUVsJidR80FCSuPtHLaZSPvyEsHwsbThBIEucj6E6auK+f+3Sh5H/uxXB0sUWK7dq/
         Ne0vXE2dEF9iRQ3hKyoPp3b/84tRyrnYibo/dzeZBXvT0RUmu4ewXzgg1Zf1TVqjEE2e
         SBocc3dDdnuIyaWq7wi5pMURrfbds22RZL8s/FKP4lqrzMEGPeyPHZY4r65So5PCRjOd
         H/71UdHYTEnGPlqgCth5Ni5Ml8C83qrZA5iUWmzJCuci8pFaqA+xYlqQrCxOWwb1+XBV
         OK75Ui8pc5+nCZFWSJDnCd+nRoiIhjWbDLDynCXR6JyiAGmVn3AJYgju0r1nAVv8bJ8m
         QloA==
X-Forwarded-Encrypted: i=1; AJvYcCU73Ye+VreX9ns2cBNBjnyINZUfhvwkomKbBZyjZhA/FgBUlSk5dVjalBXVgR2hU5WVT2GOuZo18IIufKip@vger.kernel.org
X-Gm-Message-State: AOJu0YyDf3kcAEiEhkHvQUnY7wblv54jLUedbCWkLBvyaz22842H18D6
	Tffoc2q/mi7dw9TV8z1zUjIUOJLmUoego2UfGvmVQ9n7k4DOBlli
X-Gm-Gg: ASbGnctL2m862jqKX6+B7u2LhGB+erymfyM6eDk1sL2PlnB1DnytZoylUAyTOm064+d
	3fohhKTiI5jAANKxv32ezGi7UE2O9L3x6zX/WtTgIL86hLXcRnzCULuPu+/El+WdaAdTMkRwWn+
	J/mCrXVobNWKLLgBSwBVstKyQEkw8pPhgoSosugUvUgNvyL2uiAbq6MZRBdeA6xfsWwwTzgp5dO
	1LgCmGUMxGZ14WU3EyxwieVor+OZCLc7zH7PlHkjZzAUPCvEFFsELXQ0uEFfRhgqC/dOWGS63J8
	YcS0WXBE3JeitKPztzkSAOzl4hjUeF5lmlSJe0PVLj809xrxO8O6rXODmVqZbvnrZ/jU0m2lz5w
	y4JVOEG28dBriPBBcaFJqkq9D5gRiuIyrjMUEHwpJrQ==
X-Google-Smtp-Source: AGHT+IFn1nN3gCF6eHKYSWOGazTnted0XKEgw30kYXd4XdGWxa5QEosQweeFa+OnMKZr56ei1LOopg==
X-Received: by 2002:a05:600c:1c0d:b0:43c:ebc4:36a5 with SMTP id 5b1f17b1804b1-43cebc45152mr101689705e9.7.1741693318362;
        Tue, 11 Mar 2025 04:41:58 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea8076fcsm111297525e9.15.2025.03.11.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:41:57 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Fix for potential deadlock in pre-content event
Date: Tue, 11 Mar 2025 12:41:51 +0100
Message-Id: <20250311114153.1763176-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

This is the alternative solution proposed by Josef to solve the
deadlock.

I've added test coverage to mmap() pre-content events and verified
no pre-content events on page fault [1].

I went back and forward about allowing pre-content events on page fault
for __FMODE_EXEC and I have actually tested this variant, but because I
do not have test coverage for Josef's large executables use case and
because it is late in the rc cycle, I decided to disable pre-content
hooks in page faults temporarily, but leave the code in to allow Josef
the opportunity to re-enable the hooks for __FMODE_EXEC with a separate
patch after more testing.

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fan_hsm/


Amir Goldstein (2):
  fsnotify: add pre-content hooks on mmap()
  fsnotify: avoid pre-content events when faulting in user pages

 include/linux/fsnotify.h | 11 ++++++++---
 mm/filemap.c             |  3 +--
 mm/mmap.c                | 12 ++++++++++++
 mm/util.c                |  7 +++++++
 4 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.34.1


