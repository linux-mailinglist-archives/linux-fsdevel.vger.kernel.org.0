Return-Path: <linux-fsdevel+bounces-37095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C9F9ED803
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A81188B770
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8423A18D;
	Wed, 11 Dec 2024 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+9avloG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB223FD3C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950700; cv=none; b=E6j7MZFLAYltK3+amA5CXZnKSuzG7XoVCCneF0DPfX7/W4zbLWIXDq+4tm8LHcya8JjvL8sLxPEmfCWMzmJ+RUa/C3H7mBRx6wFbw//ECrRliFZ6nDn/JfI5SaBeE1/T4v8/skoXl9tjHv9rAeTXDIKRjt61R1j33qnTaVTJ+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950700; c=relaxed/simple;
	bh=lj8bMC2/TXRkS7vAbjVC7CB24U+zcoBk+O2aILjo13Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVhuuIv0S92JC2RRchKq6oQ4tBIuWGQ8hu0dJPLz5ItlZVbHn66GqHdoWRlpKh+ZYyR7+zUKnaAzNPhoChrzVlJuM6VG7wMTiqPFrf8Crqy5dCg3lFC97BQp3SzonW0WwEdSxSEo6z+/sEHHaxkkP4Hpfgzrtf2EEthhkEhHx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+9avloG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef7640e484so85024017b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 12:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733950696; x=1734555496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1y3Be+ng9RK/e7qRABoT+Vl4eStRlPxQTCcl/meiG8s=;
        b=g+9avloGP1m/dgDXuhy1B0IwQMF0DAphwmbkqF4mH8Nw6dczpYYV2OXxFuqmOAWt/T
         uCXU7wTVmtkv5F9g9l0F/Bb8ZC162UtX8XlTUqdatRwgWD6lXcKRRkwhHQLPIxTPiA6Q
         lWqp/6kzg69xpNtLbGfFteYu8oEsfz46nLf1guu45L6CmvJByhII9f+ym6vT8Sv01q7f
         1duMfhhvp7tJV0JAC1+QV7s7QAfO8tFdqPvVVD+97LxeYpvE0U0EVSWNGJT0WErd1i40
         iCSDktzBQdGIR9zNO1WVWG+8BU/j4PBdnQyanYlyaBPES9Ggz3PzhTLuQhWUVRfC5cKr
         co5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950696; x=1734555496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1y3Be+ng9RK/e7qRABoT+Vl4eStRlPxQTCcl/meiG8s=;
        b=Oo21g/t2XmvKjUKEqiybOjlfqKhlDIfrNMZHlXC7pWWZLSd5hxwcuhFFfYQGyO7fY7
         O+98SSHdtWN4PfJNg8lh6oMAUIcstJxijMN2LUfPL02tXpQgZ6NVd0XwCi9+shcLN/mn
         S9OzuUbggrBuizuWwoDrp8FLgw1Ed42d+DkWjEyh6poNd+qvr9pE8p4vVWXkccDR4tjo
         nO66USBw5mT9yXGEU4b2I/Eh1KfpdS5ddFLK1ob0BnRWUF+/poqHR/hMG308e1UcXbRD
         2SK07Fd00wGoWhfuK1cnLKEJlyMoQGdddxcZCqi835Th7iW+wisUoThpHLN8WkNw4Ya3
         MaGA==
X-Forwarded-Encrypted: i=1; AJvYcCXQJiMeLt5uDybeerRJ/1WCcQIPbWRWgOa12aLM1ezJVB6Wv5WfKK1AbeyhfWJXzCbqwZ0rNAU2kA8y88r+@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVYLLHFH0AC0jNalVCfEvheDI5tnzBo2vjZ1ZwLajEb1YbTDK
	gZ3HhygtXWA4BVENuC2TOiySWqc+sXsVhwnuBbzBWAwklMQkBRns
X-Gm-Gg: ASbGncusj4yX6LMeZOxZa6jTbEUfnLvigULmjov0tCdsvElcEF2qs2+CbWfyVKkijji
	/s0yDJfG+OXJ4PieiYUIyqqDDVmqWM/tYWB1nGruW4VIDeISwq/K8KdokUID45gPQc7uB21JP6k
	IG8ImIFQue8tS5c9j3uHIyEgzbBM7zu1fnViL5TTL74ZhsSAvNqr5YYf/Xy8xZ8QnvDvieQVufK
	v0PvhYSgQ3QxU3vSdq/zO7GAokpEkZrGzgQ7zgbxZ7fiS9ND60nSVahZ6IM+FOEPd9CdedOQECT
	2y3L6HwZLkc6
X-Google-Smtp-Source: AGHT+IFefAdIrUx/dGbLZWrwnWDmXE1CAy3REkeLJWYjJN9+3MMvI/z/kASbdyglU/lG0fc6jfML0Q==
X-Received: by 2002:a05:690c:6189:b0:6ef:5097:5daa with SMTP id 00721157ae682-6f19e85e0ddmr10454587b3.34.1733950696622;
        Wed, 11 Dec 2024 12:58:16 -0800 (PST)
Received: from localhost (fwdproxy-nha-001.fbsv.net. [2a03:2880:25ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cc84261sm4164347b3.20.2024.12.11.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:58:16 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	malte.schroeder@tnxip.de,
	willy@infradead.org,
	kent.overstreet@linux.dev,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH 0/1] fuse: fix direct io folio offset and length calculation
Date: Wed, 11 Dec 2024 12:55:55 -0800
Message-ID: <20241211205556.1754646-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Malte noted in [1], there is an issue with commit 3b97c3652d91 ("fuse:
convert direct io to use folios"). This commit mistakenly assumed that all
folios encountered in fuse are one page size, but this is not true for the
direct io case.

This problem was found when running bcachefs as the rootfs on an Arch VM, and
installing FreeCAD with "flatpak install flathub org.freecad.FreeCAD".

Before this fix, the checksum was corrupted and installation fails:
 error: Failed to install org.kde.Platform: Error pulling from repo:
 While pulling runtime/org.kde.Platform/x86_64/6.7 from remote flathub:
 fsck content object
 886fd60617b81e81475db5e62beda5846d3e85fe77562eae536d2dd2a7af5b33:
 Corrupted file object; checksum
 expected='886fd60617b81e81475db5e62beda5846d3e85fe77562eae536d2dd2a7af5b33'
 actual='67f5a60d19f7a65e1ee272d455fed138b864be73399816ad18fa71319614a418'

After this fix, the installation succeeds.

A test case will be added for this (eg userspace opting into huge pages and
using O_DIRECT) as well, in a separate patchset.

[1] https://lore.kernel.org/linux-fsdevel/p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw/

Joanne Koong (1):
  fuse: fix direct io folio offset and length calculation

 fs/fuse/file.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

-- 
2.43.5


