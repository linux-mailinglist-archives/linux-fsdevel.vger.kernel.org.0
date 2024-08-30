Return-Path: <linux-fsdevel+bounces-28077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F09666DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 18:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E0D1F22B23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF27F1BA281;
	Fri, 30 Aug 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCQ2XvD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985D199FCD
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035231; cv=none; b=g+hRekgJiVmdR9jM2GPX/3jGACTtrS3yh4QOdLV7ObJvgafLGqo71+vkuP4P0x7UaERm85Ausl9iPUl9lY4k6x159LiXFcgn4XWlw7ZTs7wlzvd0GXFxAyD+LubG1TNr/kVK/QiklcGLjg9qhVRCUghNQp6aVSvFIfxbIzjtnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035231; c=relaxed/simple;
	bh=a2FHIaSUCyw7RT40FM6PUQHnLsRxh2paMCelkUyKXrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dr9a7vuWEztwP+zdWcWG1XwNkgFG2BnZcw9VhRQDpCT7Kc/uUKY+4Iu6U/rpTqplNXpocqi1qOpH0+TZyxh6dJqlTOoiUlv5taY+uhbt4z+BtnX0CiiVDG0aORrnxzpg4owJaYKwLEEIwcXYlUHoqdhuigEfRJ0LnIP0V+Gmuy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCQ2XvD4; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-690e9001e01so18809517b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725035228; x=1725640028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ+j6dy36B9nVptHuE1TlpIgAJwmuSODLA/QfnHiijg=;
        b=NCQ2XvD4o4I0/gd7GVgQ7JDKY2Lq84BJixT8j4+Y1U/4p1aYN8sUsBdk1zbc0cnlZS
         0vs5ghhxzSVGrFXCuj7fzntmOk+tGieHmOj75wfLBVFYtM2DS0IfSUfc5jnlFDchFXm0
         xnmDP+OdujQgBt9as2tGd91koNUlqJyb3Mh0W7ScJvQDIytP2ZfJ/TFB/7I9Dq+a/eUy
         njIq89Mvofxf1tz2Yc1n6l7qgi23+S52z7GjBStpONHBrMkmytDocIlmB1WhUcYrVVdg
         Il+J818WpUC/yHhNHeWXMEs446xHNr0ex5ZYCw5m7kxQxCBBMZ7oOc8G3+nhpMjWMRR+
         JO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035228; x=1725640028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZ+j6dy36B9nVptHuE1TlpIgAJwmuSODLA/QfnHiijg=;
        b=qyof0ajXv/BxB2vjFht4cyd6dqgEyLPTkbptzr5u2WtA58rECSvBwnLi/aTWW20Trr
         IkSkA639l+HKMKQPeYbVjX+1hvuRa5AvLAW5o7dh8nZC9XUZDJMYw6Oa49bTjutTOURj
         jOoMQeGzgOC2q0N7x1mW+A02/XRlQKoqSGvSq+IaQABeM70Ocz40YfnBTzh3YJ1BmNJy
         L2ICBtG0Z6XsCUMRYtEwR44fwZv3LQP/NYAM3AQaaTQLNjo/hrhJLIkZQJ1OyJovq0IC
         asHI8yAWSKQBdSsnYO10S+T0kuRkiAKLiNYxNKmZEkNyS578VXTESybuaHNY1YYzpveX
         FerA==
X-Forwarded-Encrypted: i=1; AJvYcCXTv1uqj2KhV4m5fsKo64TS6NHc8sN/2wSkvVR85iarcsyOmWmuC+z2GY/+/NHFCF3W6U5fj7b6q6H6JAyE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8uDzM/bZ/I8lrCjIHAtwib0SUnd7ppAOxzaRG0NEgB7TILgk
	39NK8GLFjm+h+Xb1qq3iwkUjJzljU/L+fQDQnbbSpg+bH71EGy1q
X-Google-Smtp-Source: AGHT+IFoxezL1RWRln6MwW49yDV7BWxbFrGT2mCrVRZC1UYeiol0liRDdP59vFGTTzbnxLEvA8Hktw==
X-Received: by 2002:a05:690c:4c8a:b0:6d3:b708:7b1a with SMTP id 00721157ae682-6d411291171mr20853947b3.42.1725035228421;
        Fri, 30 Aug 2024 09:27:08 -0700 (PDT)
Received: from localhost (fwdproxy-nha-003.fbsv.net. [2a03:2880:25ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d3abe246sm6718347b3.1.2024.08.30.09.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:27:08 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v6 0/2] fuse: add timeout option for requests
Date: Fri, 30 Aug 2024 09:26:47 -0700
Message-ID: <20240830162649.3849586-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or
stuck, for example if the server is in a deadlock. Currently, there's
no good way to detect if a server is stuck and needs to be killed
manually.

This patchset adds a timeout option for requests where if the server does not
reply to the request by the time the timeout elapses, the connection will be
aborted. This patchset also adds two dynamically configurable fuse sysctls
"default_request_timeout" and "max_request_timeout" for controlling/enforcing
timeout behavior system-wide.

Existing systems running fuse servers will not be affected unless they
explicitly opt into the timeout.

v5:
https://lore.kernel.org/linux-fsdevel/20240826203234.4079338-1-joannelkoong@gmail.com/
Changes from v5 -> v6:
- Gate sysctl.o behind CONFIG_SYSCTL in makefile (kernel test robot)
- Reword/clarify last sentence in cover letter (Miklos)

v4:
https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoong@gmail.com/
Changes from v4 -> v5:
- Change timeout behavior from aborting request to aborting connection
  (Miklos)
- Clarify wording for sysctl documentation (Jingbo)

v3:
https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoong@gmail.com/
Changes from v3 -> v4:
- Fix wording on some comments to make it more clear
- Use simpler logic for timer (eg remove extra if checks, use mod timer API)
  (Josef)
- Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
- Fix comment for "processing queue", add req->fpq = NULL safeguard  (Bernd)

v2:
https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoong@gmail.com/
Changes from v2 -> v3:
- Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
- Disarm timer in error handling for fatal interrupt (Yafang)
- Clean up do_fuse_request_end (Jingbo)
- Add timer for notify retrieve requests 
- Fix kernel test robot errors for #define no-op functions

v1:
https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong@gmail.com/
Changes from v1 -> v2:
- Add timeout for background requests
- Handle resend race condition
- Add sysctls


Joanne Koong (2):
  fuse: add optional kernel-enforced timeout for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst | 31 ++++++++++++++++++
 fs/fuse/Makefile                        |  1 +
 fs/fuse/dev.c                           | 26 ++++++++++++++-
 fs/fuse/fuse_i.h                        | 24 ++++++++++++++
 fs/fuse/inode.c                         | 24 ++++++++++++++
 fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++++
 6 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 fs/fuse/sysctl.c

-- 
2.43.5


