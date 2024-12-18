Return-Path: <linux-fsdevel+bounces-37764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C859F7000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 23:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97FD1893DE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 22:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E791FC0FD;
	Wed, 18 Dec 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXkF0tu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AAA17A586
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560847; cv=none; b=SqlJUv/yL6u2MchF6lvGsdDIyQIuDyVI4adDycSPc5axWToZ/VnIwX0wM7Msmu4qbaqvC31X52ED/PjAbHNKECv5tc4N7n2x6JHaIYt4UEWXGeiTf1MtPwBDr/BRfU5iPEpIG7B5yRJH8D9KeEgpu3HOnxxrkYMXu50DLlcPLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560847; c=relaxed/simple;
	bh=nx+yejOYgcpSw4WjDaYBQqVMF35nLkYEBH/etolgGaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrBZNNt61D3qZsEZIuPhNkyl5sWyFrL02nFxAWAaKJKyjdekhjVDnkdwMqkwniJEGGa5io79dW/VfaypgrJzMWb77r4bdtnTs+mQ6Fe1fDRBEMsCFCmhpwHu7Cmf3MVX8S/sDGuxNC5W92KIyvICKNWCuLc/n2q0l0TZSgl9T8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXkF0tu1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef7f8d4f30so1522827b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734560845; x=1735165645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sskphQRThzH7Nxf9mA3J8awZUDlJNMzgtMneijRVsNA=;
        b=VXkF0tu1hKc/DX4ZOHypMaSbKNK9kulrQQV463m5tg7Xd3ze48ZO8fCN1xoB+9XqWL
         xcSV9gR88a6l2pP3A3D/hEwVys9ug8MLAzpnq0QWWfjTSupOpnxWoKTCzU/NCG7rZ4p1
         0crfXaB+8mZdqn+i4uUxFkvNG9pOh4FFrJUzJOCiCT7iK9kBQ6622rDTM0OgJ5+UvAo3
         r/FYUoP3fSIBzqHP6MAuXsjnp2Jhh0a9PeMxN1aZIN1YSzNsqKWXWyVlujGi5zIwvzww
         F7JV+Mk6WnMx/nSLnPilZHLbb3QwFTm55HS33tWtGe4J+q3B6zi0/Y5S6ejeXbwd8YOG
         ponQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734560845; x=1735165645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sskphQRThzH7Nxf9mA3J8awZUDlJNMzgtMneijRVsNA=;
        b=DAQuvvq6YhcG+pNehGSfy7D6nrsdXTUYMjgidNK1XniIausVP0wyI1oT34NutIcy22
         U+aPlze+NZjwBQ9Baym4alJ1esD0ywT6A2G0oOxOIvEBEmsVk020LjOz3xEO3lbM+Tnv
         2EKtomyQRX7pDjPXK8CU7LczDc53xYKP1/yZMaljDMy8/3uI+JRH+fRnNP9JJmaVS3Mh
         ch25XTbQaUswQS50pXOBGzXyyz4MIo2IdtgaT6PoWUuVgHqFaoTq2t09VjN4UNW8Cp4C
         Eb9LXiKBhwenA1jGahbe0ZNZhmtINlNS/HQ/N9ZlYFdbdi8GWiaMFFCV4V7CoHAXvOIn
         cuxg==
X-Forwarded-Encrypted: i=1; AJvYcCWoHWgx/MLleuZ8QKg9H8pvOLxTdrYtx1XhPeGZIVd24ZO2zmPdmbKQNGYbcdGzycXdxI1eLaP0wc1ipHS2@vger.kernel.org
X-Gm-Message-State: AOJu0YxoiTgdU9ITnc92oAtz+wNGMUtvexuAUB5Iz3eriB53CTWH4fVW
	JsIzdrmGeClLskvgbmxzOEU74iC25OG8411HRUFn75tCM6D5gyEp
X-Gm-Gg: ASbGncvrT5DslzkF8pfk3ypIl4iDKmYCyLnd8AIwzeGpzoPlAZGRwPDudNTN4oQVXj+
	LktEcp7ZuaNd+ODuomxvOyLPCgekPJT2w99WAATsV+hWTKlZzM0GcwIxJzjOUdc/yB/You8HovR
	0SmQ+bJ6H4QMPDvxSbLrqOphVQAGpPJcoYH2Ldh33Kwf22rso7u0eWVYAjae7jNbHJ6XnJ2cpTr
	GrZZVmBz43AqpVF5lMaZggFppYN2oj7BDUmjDXCNlTCMSuZRU9La9Y=
X-Google-Smtp-Source: AGHT+IFAOKo/MKrZZR3JzMIQF8b7pXsxJ+yCQ8R3gK2Ojup53n10Pj7C7QJwzzmeVDlZ94WTz5X0JA==
X-Received: by 2002:a05:690c:6308:b0:6ef:8451:dd99 with SMTP id 00721157ae682-6f3e1b81cd3mr17431947b3.24.1734560844711;
        Wed, 18 Dec 2024 14:27:24 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f2891ef11csm26025897b3.111.2024.12.18.14.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 14:27:24 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	jlayton@kernel.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	bgeffon@google.com,
	etmartin4313@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v11 0/2] fuse: add kernel-enforced request timeout option
Date: Wed, 18 Dec 2024 14:26:28 -0800
Message-ID: <20241218222630.99920-1-joannelkoong@gmail.com>
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

v10:
https://lore.kernel.org/linux-fsdevel/20241214022827.1773071-1-joannelkoong@gmail.com/
Changes from v10 -> v11:
* Refactor check for request expiration (Sergey)
* Move workqueue cancellation to earlier in function (Jeff)
* Check fc->num_waiting as a shortcut in workqueue job (Etienne)

v9:
https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joannelkoong@gmail.com/
Changes from v9 -> v10:
* Use delayed workqueues instead of timers (Sergey and Jeff)
* Change granularity to seconds instead of minutes (Sergey and Jeff)
* Use time_after() api for checking jiffies expiration (Sergey)
* Change timer check to run every 15 secs instead of every min
* Update documentation wording to be more clear

v8:
https://lore.kernel.org/linux-fsdevel/20241011191320.91592-1-joannelkoong@gmail.com/
Changes from v8 -> v9:
* Fix comment for u16 fs_parse_result, ULONG_MAX instead of U32_MAX, fix
  spacing (Bernd)

v7:
https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-1-joannelkoong@gmail.com/
Changes from v7 -> v8:
* Use existing lists for checking expirations (Miklos)

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

Joanne Koong (2):
  fuse: add kernel-enforced timeout option for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst | 25 ++++++++
 fs/fuse/dev.c                           | 85 +++++++++++++++++++++++++
 fs/fuse/fuse_i.h                        | 32 ++++++++++
 fs/fuse/inode.c                         | 35 ++++++++++
 fs/fuse/sysctl.c                        | 14 ++++
 5 files changed, 191 insertions(+)

-- 
2.43.5


