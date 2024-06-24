Return-Path: <linux-fsdevel+bounces-22246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CE79152DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7CF2820F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5730D19D094;
	Mon, 24 Jun 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fCCqbUDK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543ED1D53C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244241; cv=none; b=pTLzLUwONt6G3hm0vTb2Q2SekQ1uf1Or5g4qu6xw4J6JCyqxD2/VN/yZP+o0t3SNIt6tCp7+ZRyo7Ij/wyuSg6+JrcwuGFTSpMpnFdzmJ+PLvCK50ogxdz5z/tBc0Ss9yEhl3Oa/6GF3xv+cA8FKFJhXvuUJwrGoqOQNy8vbUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244241; c=relaxed/simple;
	bh=AcXSgJviOfnpFMYrB7qa+YYutwJU73uTBASPD7sbCYk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mwjJ27+YCJ3wtRPdjvtyjJNynm01v6xvbZ6cQsEr6oHR4bxWv2PrLg/tlVmHSmzuXc0n6FV4HPVcjEkh0fxxsGoPdHjsGUVwB1MxHUYVaYfrMVx2X5sk5hdGSHM/N3t66KyVxfWu9oi+20uW0c/Qf/P78o5EOMpPD4t0YTOnA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fCCqbUDK; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e02bda4aba3so4613770276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719244239; x=1719849039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLgQK881bMd+8UR0jrCVA/izBGZlf9yBdyaqSchEtrQ=;
        b=fCCqbUDKyIUAmrXuJVbRB6TYSZr2hcUVMux7yMA8rFULwxROTd1QASdN1YY0ULtgKG
         +6CIXHT93PQJ2cStChVtS3zkij2WsdGeAre/ylFK4QSY6zINPrZoeSxtalMK/3tRyT0o
         xGpc4CX+mx1c2yHULtmTuqdinDUyrXMqq2C3GQ4RgXpoLK+PxptyR0PTRPGTkftOdBIf
         HFRGD6qWEsNTTox7hG6RgMVqQveI0uQr0HnXb1BwDTSLHeQ8iXh6o6uwnnL03ZIacZCz
         lSePRr2PL4em4mgfpAWf2civVeO/66vzIg5nez2DiT3CDglKWbtZE6BgEM2vMrjKk+6C
         JHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244239; x=1719849039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLgQK881bMd+8UR0jrCVA/izBGZlf9yBdyaqSchEtrQ=;
        b=cY0ZuTrJpUyQFgee6JRdEEMHwfADNixbm2KyNDlbKiZShwAJHkQOtH6MLBOGCY16+S
         msNZjX3acgSoAIw9F3yjucgeyMxkTvYDTKEnOVjNd4UvAAFWxhBusS9RHyt0mf8cTOCL
         tVvgIQ3yYIZJUTOavEtaIhjZdLG+4yAQFt+SbojlH5YQM7LkQjufVKMfkOb8sk44oliF
         aoE+I+fb8QxcDIB47s78lXrte6W0PYL8ucngiyUXFMvMS3YYRpRvSgYAb0tTJr7x4qj4
         lXDYvhYiB1Uih/1jOs/YrFElgy5FlbmziE9nv/z1GeW3nYLSQ2bty7lQfsYWeKN+L6uv
         w+AA==
X-Gm-Message-State: AOJu0YwpRB86MJNzVyGkPwbYMDqFZUQIxXdEG/BlCwspni+R6FmA096+
	6rW/0/DFwxp+14nrXZap55e0vO+PnY2uwwtsQVnYNWlS5z0IbrKH3b+RAdaWVm1AAyB779hTrkU
	W
X-Google-Smtp-Source: AGHT+IGvmR9uyRorstnYlvohFuzDppOOmsHAviPndD2XaUQ91OkyrEYLCAZRpveSEhdKIolwNL4rgw==
X-Received: by 2002:a25:cec8:0:b0:dfd:be95:f305 with SMTP id 3f1490d57ef6-e0303f2ab11mr4473561276.5.1719244239097;
        Mon, 24 Jun 2024 08:50:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02e65e0149sm3306191276.57.2024.06.24.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:50:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/8] Support foreign mount namespace with statmount/listmount
Date: Mon, 24 Jun 2024 11:49:43 -0400
Message-ID: <cover.1719243756.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Currently the only way to iterate over mount entries in mount namespaces that
aren't your own is to trawl through /proc in order to find /proc/$PID/mountinfo
for the mount namespace that you want.  This is hugely inefficient, so extend
both statmount() and listmount() to allow specifying a mount namespace id in
order to get to mounts in other mount namespaces.

There are a few components to this

1. Having a global index of the mount namespace based on the ->seq value in the
   mount namespace.  This gives us a unique identifier that isn't re-used.
2. Support looking up mount namespaces based on that unique identifier, and
   validating the user has permission to access the given mount namespace.
3. Provide a new ioctl() on nsfs in order to extract the unique identifier we
   can use for statmount() and listmount().

The code is relatively straightforward, and there is a selftest provided to
validate everything works properly.

This is based on vfs.all as of last week, so must be applied onto a tree that
has Christians error handling rework in this area.  If you wish you can pull the
tree directly here

https://github.com/josefbacik/linux/tree/listmount.combined

Christian and I collaborated on this series, which is why there's patches from
both of us in this series.

Josef

Christian Brauner (4):
  fs: relax permissions for listmount()
  fs: relax permissions for statmount()
  fs: Allow listmount() in foreign mount namespace
  fs: Allow statmount() in foreign mount namespace

Josef Bacik (4):
  fs: keep an index of current mount namespaces
  fs: export the mount ns id via statmount
  fs: add an ioctl to get the mnt ns id from nsfs
  selftests: add a test for the foreign mnt ns extensions

 fs/mount.h                                    |   2 +
 fs/namespace.c                                | 240 ++++++++++--
 fs/nsfs.c                                     |  14 +
 include/uapi/linux/mount.h                    |   6 +-
 include/uapi/linux/nsfs.h                     |   2 +
 .../selftests/filesystems/statmount/Makefile  |   2 +-
 .../filesystems/statmount/statmount.h         |  46 +++
 .../filesystems/statmount/statmount_test.c    |  53 +--
 .../filesystems/statmount/statmount_test_ns.c | 360 ++++++++++++++++++
 9 files changed, 659 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/statmount/statmount.h
 create mode 100644 tools/testing/selftests/filesystems/statmount/statmount_test_ns.c

-- 
2.43.0


