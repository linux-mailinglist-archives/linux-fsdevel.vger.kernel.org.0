Return-Path: <linux-fsdevel+bounces-31248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8959199366F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4887628488C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5FB1DE2BA;
	Mon,  7 Oct 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmBI+95W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9191D357B
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326636; cv=none; b=WWjbH1CXBjr2HOrnRx44jUuEqtwuHceXCwgnFGSEovJRKgOtQXAFRbLzWhsDAUVWvYmgC++KYyJsiCybsnVIEhrEBUMuzggXCPLlkmubjRO8qQa6vgnonX/bXX+ZmK3E8B2MAgOl7b0G78QDe4c+TfaTcdij/11YganXAlPsd4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326636; c=relaxed/simple;
	bh=ohFhoOkxiuDsrMKoFf/H/ERE5j8juCA++FmT4G1FXrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BP4a7A+pJisl3Wb9tUS+K0xwZlSaC7FyBxq0hVmaNx+Z6xugIEAQedJKbO8EpkGWsGL5q3nhGZ8O1axXcFAFpS+rwWO6FfO13e5pKo++sNXOWC7D6uYzUvsEFyjNXMi8cJssbiM55YMuZ0IfHDUhsXH5zjlMn1HK85DaEJTjz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmBI+95W; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e30ee678a6so556587b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326634; x=1728931434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Beg3yoJlDPUBy+F/X04MqkXohiOPCS7tMVKL3NdERsQ=;
        b=TmBI+95Wu9lvI9zBxGenev2TtZMi9APyl0v0XY6w/lRIuD/hZUHmgcW4c1tCAGTjdJ
         QfbU4NwNZEWUkk3pslbGYeVi+MsE5VCmb+vgmdFZQtOfuGVAB/NPcRzJ5haEbK+Cd/Zg
         IZGnM/rJKpViNkdCVgrNsf9mslmYAyZvCnfB9gM8G1yZJEBz+CcnCLMgVUjCKbNZak53
         cX4Y15Fz9OD60wQO+JQupGGdNrvmPhw7UJslgZN9GHA+6qqW+pYeCkgOk/PiTDVTOvbK
         Wx1Lmak5JJOjmBsCN5I9QDgUMIjWFv+ws/k65IUAWP58Uz74aj3oSI22A4ZT+REuf/0W
         bsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326634; x=1728931434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Beg3yoJlDPUBy+F/X04MqkXohiOPCS7tMVKL3NdERsQ=;
        b=XZwEaZIvXe4eA7/1WZ5dKm98UJqJ6ah7DcJU+syAzpYbooaVC+2WW3es6GODT2wo+I
         /2icz6eaZbcpWks2F1TE0vhl+hNno9YoRztlJX/rSdOj+qI0XCVXphFiCUPgWflp6ptz
         BLmLBEKECw0ewwI8pdG8nLBHBdtsCI9y2zFbbpuhtYrn+GKa89RaSDNeQFhyK4dG46SZ
         NRHfDkkgCrGxRanI55zwBTBtQmBQ8hr83wXguOLlvTe6A3/lhuzcZfMy2YCJoFC1TBoO
         ZCHxy12v+NcPpO/YfXBgpK/PqvO2uS5QqkWjYhYwXoQOR0Vve2EWKu1bmVHjrXLFw4Fq
         JPLA==
X-Forwarded-Encrypted: i=1; AJvYcCVGPOQYr4wKHyM9AP3dyd/m8b5D5Xts8y25zDK2FtcfNzvqvtO0T3jwaecvo+XS7+KuguHIfZMak9Zd92Tn@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGi/3uJ21TScTuMjDAsYP8ubWI7+yR0rTTh99UCZ/SEKn022w
	dxd+v5HdTZeweYVPTtSZ7mY0bGnyEOrGRvq4gGl4Khitip9d6jaO
X-Google-Smtp-Source: AGHT+IFO2Aew21yRjPj8a+gnSSHeM9DlVQMkntX9vFfKhyqzaYWqTYtVRvyHzLligcoUkcWU3EkypA==
X-Received: by 2002:a05:690c:7287:b0:6e2:2684:7f62 with SMTP id 00721157ae682-6e30dec2916mr6144597b3.8.1728326634056;
        Mon, 07 Oct 2024 11:43:54 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d927f546sm11376897b3.40.2024.10.07.11.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:43:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v7 0/3] fuse: add kernel-enforced request timeout option
Date: Mon,  7 Oct 2024 11:42:55 -0700
Message-ID: <20241007184258.2837492-1-joannelkoong@gmail.com>
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

This patchset adds a timeout option where if the server does not reply to a
request by the time the timeout elapses, the connection will be aborted.
This patchset also adds two dynamically configurable fuse sysctls
"default_request_timeout" and "max_request_timeout" for controlling/enforcing
timeout behavior system-wide.

Existing systems running fuse servers will not be affected unless they
explicitly opt into the timeout.

v6:
https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelkoong@gmail.com/
Changes from v6 -> v7:
- Make timer per-connection instead of per-request (Miklos)
- Make default granularity of time minutes instead of seconds
- Removed the reviewed-bys since the interface of this has changed (now
  minutes, instead of seconds)

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

Joanne Koong (3):
  fs_parser: add fsparam_u16 helper
  fuse: add optional kernel-enforced timeout for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++++
 fs/fs_parser.c                          | 14 ++++++
 fs/fuse/dev.c                           | 63 ++++++++++++++++++++++++-
 fs/fuse/fuse_i.h                        | 55 +++++++++++++++++++++
 fs/fuse/inode.c                         | 34 +++++++++++++
 fs/fuse/sysctl.c                        | 20 ++++++++
 include/linux/fs_parser.h               |  9 ++--
 7 files changed, 218 insertions(+), 4 deletions(-)

-- 
2.43.5


