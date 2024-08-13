Return-Path: <linux-fsdevel+bounces-25840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F010F951078
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF362848B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69161ABEA4;
	Tue, 13 Aug 2024 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2SwWYDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913A16DEA9
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591439; cv=none; b=QaSJagy4D1yqKh7wuQ+KjDxp6PHMvGsbc2Cfk3nL43Euc6UKcUT9h/IksMlyDxcsk32lj6shOi8ejRh2AxSRFB1RaCZi7PbgX0WwLaImdRo4ZNSJjGkZ/abnTyAb6Vy6zx9DgpqabAPkZOJocHq4ZpwLAFVN+sv8O3L1Q/xYiBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591439; c=relaxed/simple;
	bh=+JHOT/7PUYfNlduTgywOuFYZmuXjfoL+K4tVCoU/8To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hW8wthIM7I4scsi0UsPJfVAAyjmpNsmL48znoQN4eDPCEH20DZ5yB5GbiGXmumXJGRI17k/lG/Goid/a6Q9NQrCZmrvfzMicoJhzlPAu76Dk6lZWoB3WIY0cs6IhT+s2mdYIg+9NQ+AW1hZbJviJBDoVR88DQfZqt6tIMZ9K0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2SwWYDI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6694b50a937so66586007b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 16:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723591437; x=1724196237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=okuUCIw5bih8fgq5YQ3DxLw3RcugbrMd3NL1ct61fy8=;
        b=X2SwWYDITBwUlC7wE+z+okYb25U+1O1puv06RQFRxLY1rNlHgwMoGeHo5tn9ubj38N
         Us2WVGHu4Urqa1c9v4fLTnXXgupPmM4ew4okbdWidTYx/w5v8EyP2fK3Pj4qibDwvHst
         YZYs10raGndL8IjwtT/sFpR3ZRXGjHVisSO90DMvPizZqRJCiGcwDzWEMyXt/nCBm+HX
         3itOxm42i2J998TyJHwhGj2FnFMMt1mxJ9Fq4ViNbywRUXmrQQ9t2myrTnfhNsAaia7p
         ZVUDAcoT5ndsocviq2Ea/Zz/khdbRj6xq1jM3Sd2WFrg9QRVikBe41W3K+kWZhksvP7F
         IpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723591437; x=1724196237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okuUCIw5bih8fgq5YQ3DxLw3RcugbrMd3NL1ct61fy8=;
        b=h/jZ0x9LV/P8JJSwrZcJiutBcEa0bIsWcPqHohAGDs13ifNf0XHCfZ6oX5gH6Sp86U
         IE/3Yqw/4O78sv3FQs42w3IxhEIwXHumj66g4AwrJEV0lv8+FP2S4+UUpHt2DOY2RBCr
         nI9KiM3f0kXgG9yfLs7f5ify6/ZMoEoc/iUqy8ymi/sxOdWx6foLIk0zLfRNuO7iczqI
         fuQBB5+ZtSm9/RLqeVlJcP0i+jYuGpwz7wnCbiFnNhqZjFYAAie/Jcsno6RAnBHM20Xi
         nNG91UhvfoO4ZPfE84YBu8nehJc1C1Wtg7Lqrl5ZunyvP+6614teOrrf56IxY7FWxJTS
         akag==
X-Forwarded-Encrypted: i=1; AJvYcCWobaN53QVRYJWYYMyeoGLyx/mctUE+VRz2nV6bi3OySQp3u8hQFguJCra9H1g53dpnyh6uE+5NbLveoIRQkl1TcuzWOyyp6aZADVUNOA==
X-Gm-Message-State: AOJu0YxEExVbos+bmmop3MhPV6a1v2HWgEBtHs4nkpJLBJGU79vps5bx
	zB8fzr4CgxpHKxL4tgd8tEalEt+oWBCdjhCuNG2ngZhra3KIt5wf
X-Google-Smtp-Source: AGHT+IEIUIRQ4UuPTwkhZO+vfYf6kiQb1XJZSeNNPTd2akS8wSQ2ZaQqYLgbXYUsMAhsKLSTw42vKQ==
X-Received: by 2002:a05:6902:2305:b0:e0e:900c:946b with SMTP id 3f1490d57ef6-e1155a426fbmr1361923276.1.1723591436822;
        Tue, 13 Aug 2024 16:23:56 -0700 (PDT)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8be7610sm1670188276.24.2024.08.13.16.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:23:56 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v4 0/2] fuse: add timeout option for requests
Date: Tue, 13 Aug 2024 16:22:39 -0700
Message-ID: <20240813232241.2369855-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or take
too long to reply to a request. Currently there is no upper bound on
how long a request may take, which may be frustrating to users who get
stuck waiting for a request to complete.

This patchset adds a timeout option for requests and two dynamically
configurable fuse sysctls "default_request_timeout" and "max_request_timeout"
for controlling/enforcing timeout behavior system-wide.

Existing fuse servers will not be affected unless they explicitly opt into the
timeout.

v3: https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoong@gmail.com/
Changes from v3 -> v4:
- Fix wording on some comments to make it more clear
- Use simpler logic for timer (eg remove extra if checks, use mod timer API) (Josef)
- Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
- Fix comment for "processing queue", add req->fpq = NULL safeguard  (Bernd)

v2: https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoong@gmail.com/
Changes from v2 -> v3:
- Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
- Disarm timer in error handling for fatal interrupt (Yafang)
- Clean up do_fuse_request_end (Jingbo)
- Add timer for notify retrieve requests 
- Fix kernel test robot errors for #define no-op functions

v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong@gmail.com/
Changes from v1 -> v2:
- Add timeout for background requests
- Handle resend race condition
- Add sysctls

Joanne Koong (2):
  fuse: add optional kernel-enforced timeout for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst |  17 +++
 fs/fuse/Makefile                        |   2 +-
 fs/fuse/dev.c                           | 192 +++++++++++++++++++++++-
 fs/fuse/fuse_i.h                        |  30 ++++
 fs/fuse/inode.c                         |  24 +++
 fs/fuse/sysctl.c                        |  42 ++++++
 6 files changed, 298 insertions(+), 9 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

-- 
2.43.5


