Return-Path: <linux-fsdevel+bounces-50628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3BACE1F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354943A8CB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB11AA1D5;
	Wed,  4 Jun 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf7l7YhS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E24C7C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053366; cv=none; b=hEmjEj9JF65MwhflMXYFB++yCtR7egh+z9hxCYBkHmd2VE2b3iJGFSLw7BOEI2Sz5PHYQ2NFUXoAIOCqtaiRGrPO3u5QTTj04RCiFYq4+kGnaSwrzr8xp0D/AWjkK15JwXmhEv+pREcIkXQMNgNvTawweHwt8Y/8nIBXgkCp5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053366; c=relaxed/simple;
	bh=VGXhj0xXuS0J3esoCyopd2jP6DJH+1knU6lzjtUTl88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OVNNbGfVLJWaURQX4cg/m42TWkApLGgt01whKIW8lLvz22ctsf79ZYDiNHsJGxmcgmGOJ1BrMTR1nngCnUCyYuPqyVKQTsLrOhFYb4O1t/TJCHkNuBjVgHBviI8qBiW+k42rG0ZCHVFl/vIo2IrlXdreMdBoA4328QYKFJEURMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf7l7YhS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451e24dfe1aso24996215e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749053362; x=1749658162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjQa+PXamKEYevWfOsK4PTinA5hjOR0JjBvI58LuRgk=;
        b=Jf7l7YhSEAuycciGR4d5S53pzhe72X6JF4CUlzdvkN7KP0ABbGgfj1wtE4fIbCX4T2
         2/UzHZ2t+BSZe4FoxfViZAlkZ3NaVRgjTce04EOHx/9b2r/0glLNe0lbaPjJfXmlPMF1
         peIbooL4sg7yXpPrEcxkOBC7Q6Gw+/awkU53W/W2IzLm20IbladCZgrKJRtXASQNo6M+
         KOd5NTm21UnbyfspcV+Zcn9Rpzaioro2YqFSQG1xplnSHaC/VQOO4xprc2c1Yg+2WVAU
         VKCV/bm/gpj0MekqxOv+C+F+TfA0EfCm+bsffnJSMmloQwQIaEQppdnIsNMd/ESoootq
         9jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749053362; x=1749658162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjQa+PXamKEYevWfOsK4PTinA5hjOR0JjBvI58LuRgk=;
        b=N6SSABbB09BrOCOf9BVPs3YTZ7hRAawAk+2Zq46XwCyfFro6zbNynIuu2S+pRna7Ly
         LD82vz3hWLmDFvW1uHFDLY8z/Pu2HzqILMdIOgQewCBHwDZ+F0O+x9b8YHtct5KKVDpU
         /lwINMyn2JFZ4q6srW8CA6F7M3LPt7HWvVR52QYUdb9VF5aksgBonVfKpEvdWKxOimGR
         DQWEAvDPuilAW3FGa7CcrvVTXUa1pm1F28KW9a3bfS7zf+PZVSaznsVajk+REtr/dTZK
         jYavVBh3XQtcDsEqt6BO9HmYxxFteddPurwNbRbel8GIYdCssuPe4IhiKIUiRiyOq3CC
         Cq7w==
X-Forwarded-Encrypted: i=1; AJvYcCWIXcoXh25/kS1KHpffATVb6NdpNn6i612d9tUsEJuq8kRxeA+ZYx/4Atb84ZRWCYS2PJccE4f8BmyplX2z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw87dyWM22HOwwIOk+KxCL6ADgBnK2N86CUuXISTGvQycCM+WaE
	AT/sa7Ev0FFmHn7qNSnwcoHLVmFrxCN6fqXyFMujp71UNt7GYBsQQHd8Cr+CHAx9
X-Gm-Gg: ASbGnctkqxA2tHG7QUuuE+nNRcMV10OifvZugXvr+EAYH9p2/ilCDyO6ue8S16MGIVm
	xrHxUXGcrE3qopu4cbBfhJb1sbqpad4oodnbDVz97k6sLCvDDkawiEbJZWGuD/wTergDlE6CnGn
	b4ajNtWE1iVjZX2//IG1jXFE6X/ES+ZPvEJDcfXWx/XACDm8kq15B2ruaKewNDVuvkja6ekHqpQ
	dvou+LGwHbCmXeX4SmC5PBfrTytQltkphpIfzd6XdTQkGm73moRg148UzBCvnZLmTNF1MMYWy/A
	nhoVWEyoZJD4gNO5/2CoLdJceUOocwx7sU5mzb9UGypJDVsA5eypM+/bi0NTp0IAoWVTqqrwA8n
	VoKcDxxUwd479Z/1jGClTad1WXy/XHjZnQsiv69udzme3+pLe
X-Google-Smtp-Source: AGHT+IHaoUh05ZB00ouEBIVYR/gqywjNVnlH8ErKBed8fp3tIKJyb9macGUO/P/szaZwk23bakmv+w==
X-Received: by 2002:a05:600c:828f:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-451f0faddd6mr38577575e9.30.1749053361865;
        Wed, 04 Jun 2025 09:09:21 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a1678sm22304306f8f.99.2025.06.04.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:09:21 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] fanotify HSM events for directories
Date: Wed,  4 Jun 2025 18:09:15 +0200
Message-Id: <20250604160918.2170961-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

In v1 there was only patch 1 [1] to allow FAN_PRE_ACCESS events
on readdir (with FAN_ONDIR).

Following your feedback on v1, v2 adds support for FAN_PATH_ACCESS
event so that a non-populated directory could be populted either on
first readdir or on first lookup.

I am still tagging this as RFC for two semi-related reasons:

1) In my original draft of man-page for FAN_PATH_ACCESS [2],
I had introduced a new class FAN_CLASS_PRE_PATH, which FAN_PATH_ACCESS
requires and is defined as:
"Unlike FAN_CLASS_PRE_CONTENT, this class can be used along with
 FAN_REPORT_DFID_NAME to report the names of the looked up files along
 with O_PATH file descriptos in the new path lookup events."

I am not sure if we really need FAN_CLASS_PRE_PATH, so wanted to ask
your opinion.

The basic HSM (as implemented in my POC) does not need to get the lookup
name in the event - it populates dir on first readdir or lookup access.
So I think that support for (FAN_CLASS_PRE_CONTENT | FAN_REPORT_DFID_NAME)
could be added later per demand.

2) Current code does not generate FAN_PRE_ACCESS from vfs internal
lookup helpers such as  lookup_one*() helpers from overalyfs and nfsd.
This is related to the API of reporting an O_PATH event->fd for
FAN_PATH_ACCESS event, which requires a mount.

If we decide that we want to support FAN_PATH_ACCESS from all the
path-less lookup_one*() helpers, then we need to support reporting
FAN_PATH_ACCESS event with directory fid.

If we allow FAN_PATH_ACCESS event from path-less vfs helpers, we still
have to allow setting FAN_PATH_ACCESS in a mount mark/ignore mask, because
we need to provide a way for HSM to opt-out of FAN_PATH_ACCESS events
on its "work" mount - the path via which directories are populated.

There may be a middle ground:
- Pass optional path arg to __lookup_slow() (i.e. from walk_component())
- Move fsnotify hook into __lookup_slow()
- fsnotify_lookup_perm() passes optional path data to fsnotify()
- fanotify_handle_event() returns -EPERM for FAN_PATH_ACCESS without
  path data

This way, if HSM is enabled on an sb and not ignored on specific dir
after it was populated, path lookup from syscall will trigger
FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lookup inside
non-populated directories.

Supporting populate events from overalyfs/nfsd could be implemented
later per demand by reporting directory fid instead of O_PATH fd.

If you think that is worth checking, I can prepare a patch for the above
so we can expose it to performance regression bots.

Better yet, if you have no issues with the implementation in this
patch set, maybe let it soak in for_next/for_testing as is to make
sure that it does not already introduce any performance regressions.

Thoughts?

Amir.

Changes since v1:
- Jan's rewrite of patch 1
- Add support for O_PATH event->fd
- Add FAN_PATH_ACCESS event

[1] https://lore.kernel.org/all/20250402062707.1637811-1-amir73il@gmail.com/
[2] https://github.com/amir73il/man-pages/commits/fan_pre_path
[3] https://github.com/amir73il/ltp/commits/fan_hsm/

Amir Goldstein (2):
  fanotify: allow O_PATH flag in event_f_flags
  fanotify: introduce FAN_PATH_ACCESS event

Jan Kara (1):
  fanotify: allow creating FAN_PRE_ACCESS events on directories

 fs/namei.c                         | 70 +++++++++++++++++++++++++++---
 fs/notify/fanotify/fanotify.c      | 11 +++--
 fs/notify/fanotify/fanotify_user.c | 11 +----
 fs/notify/fsnotify.c               |  2 +-
 fs/open.c                          |  4 +-
 include/linux/fanotify.h           |  2 +-
 include/linux/fs.h                 | 10 +++--
 include/linux/fsnotify.h           | 28 +++++++++++-
 include/linux/fsnotify_backend.h   |  4 +-
 include/linux/namei.h              |  3 ++
 include/uapi/linux/fanotify.h      |  2 +
 11 files changed, 116 insertions(+), 31 deletions(-)

-- 
2.34.1


