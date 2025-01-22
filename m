Return-Path: <linux-fsdevel+bounces-39870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 241F7A19A91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAADF1888BB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 21:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473AE1C5F33;
	Wed, 22 Jan 2025 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My/5ZYLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9521C5D74
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583017; cv=none; b=qfdQsGI4+go7TWz6VwUZZF+fmjelMGErFHyI9EbAMx6wafbbVyAGIquYpfa/VxC/3+uWQ71/sMpWnv2OLUdjOxSJf4zXkWbZ5dVj4AGMK9NTb4SW1+vpUIkcA/e/Fox/MN05ZA0HuZ7SmcvfWEyq7EumrzW92cxG8GIyuLHHQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583017; c=relaxed/simple;
	bh=G076NmmC7qb/B8PvwAMQ/dGX0VsgHHYDJo3QhYX4r8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1edLeeq/2zOi8+DlYUFaQKyeO0tC3+VMs61EUXJm32KSxvZ8l+vqffqdcw8xeYE84obxC/7YGHuLgV4oJPdmKxERGkwXtdaIbT+rNU13dS8k67q2v+QX1r2OdRm6Zx+QD0Z5xEA8N5sZ06pwI+1plr+B4XXGpzgKEOnQW53zVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My/5ZYLm; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so336812276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737583015; x=1738187815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTwFk/H1ku4pWUvN2DEG8p+WS9Ya1DQUDVKu0pAI4zw=;
        b=My/5ZYLmot4bDVHqzcBid2WabwUGsTfzgP/iFoWgRDs0xnk0orBsXOiWLA9FCoR2BZ
         vfFjEtYz80MvHFJWW7Brz6gRsfB1rXJK7ntrYBwfes4XYyCS17//IGg8ADyJjRBN7onc
         AgqvH+p7Gg59wKEYmfHSPLZbq/EodynzDj4xp1zlbX7ucduGt7owxGGj8avhgZPYcdM4
         6gzlYW3oCKYaFIhAxYrV1lJG6y0xPkFa6RyqXrks6hPW8m6Ej8/Y66h+fDi1z8eItsLq
         COhl3YdfZB2xJJ4o1bWvAY6qBF78VqUPIn19Ys8T/Ry/BaIn7MIbdx4OBijEoQSJyxqT
         OONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737583015; x=1738187815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTwFk/H1ku4pWUvN2DEG8p+WS9Ya1DQUDVKu0pAI4zw=;
        b=s9XGbuUeJWPBkJlCfk3ynYkXyjNKlBb6Us/XXD2tsBuFgLpTuVYV0oZjvQDk8qsmuV
         rqnSqLF8SXD9FtkacDU4Vo1eN9huSSJwEd1I/SGyN/WDAZp7hobIgw3KwD5SmpUG4qjY
         gpVjCTTY2du6pj1JSAE8GAEfwwCH2mlXrSQL44Lwy0uwrHgbAxgdOfGoFzQBWpoGZQy1
         rQxW7mMvwZm++MgT4+XdiSOa+kRXBha/+//akj9fKrYjS3lvt9PIyGeFOnS/9m0IunLW
         lzx5kEwF5RaVH1bbBGrgeoaqNmZPUpINcAh7poMOnCD2+TxswE2ElUOfCun13YkBIyG+
         7zXg==
X-Forwarded-Encrypted: i=1; AJvYcCVngIlvQoUCL3jpGX0WvgMEQqYRmeJ7LcElI+PUIi6G+m6N/oDiMymwGxvZgSZHL0XrztpyAZ5Gq/0PW34Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfs6jz2UeTGpi4PGg2Yo1mdbMaiK9k7lJF/sncjbivbqLM0Hl
	gKO2QOCC/DzVio3pFouNjRzJ+4gm2Hvp5FqmYJ0cYDPOoTk0290U
X-Gm-Gg: ASbGncuI2f3R7eCTRg6hQ/WK2hCqxctRGMPwLp2uOwnhdj9n0tOGPnGhl8bp/JgNKzM
	7ugD9aWjKsFITFObuN76Y7hIfIq09TtjmTXajlSzkNadtUJ+3JYLz0bNIz9HFWxmkR5sTVAF0UC
	eaK4fzQKsD4lkrc7pykWI4LSdohkVWliMT7esHG6vrOyWU9HpAgtFPos4k6zDSYvipHBlWQUKtm
	FlG1kuIBk7Puox2o3eQYp9AXCnsZ66Azc322gaWpWrZnCpq3CFQa6lgK5awKjj44eo=
X-Google-Smtp-Source: AGHT+IGP3grY+2KqZyh41SLroqffKFY4FV6ohvdAWRctnp3GA/vb1DBN2VVrhOCC4Ao/rG15YOnNjQ==
X-Received: by 2002:a05:690c:23c5:b0:6e2:1527:446b with SMTP id 00721157ae682-6f6eb658b5amr185529167b3.3.1737583015039;
        Wed, 22 Jan 2025 13:56:55 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e6405690sm21730767b3.43.2025.01.22.13.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 13:56:54 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	jlayton@kernel.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	bgeffon@google.com,
	etmartin4313@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v12 0/2] fuse: add kernel-enforced request timeout option
Date: Wed, 22 Jan 2025 13:55:26 -0800
Message-ID: <20250122215528.1270478-1-joannelkoong@gmail.com>
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

v11:
https://lore.kernel.org/linux-fsdevel/20241218222630.99920-1-joannelkoong@gmail.com/
Changes from v11 -> v12:
* Pass request timeout through init instead of mount option (Miklos)
* Change sysctl upper bound to max u16 val
* Rebase on top of for-next, need to incorporate io-uring timeouts

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
- Change timeout behavior from aborting request to aborting connection (Miklos)
- Clarify wording for sysctl documentation (Jingbo)

v3:
https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoong@gmail.com/
Changes from v3 -> v4:
- Fix wording on some comments to make it more clear
- Use simpler logic for timer (eg remove extra if checks, use mod timer API) (Josef)
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

 Documentation/admin-guide/sysctl/fs.rst |  25 ++++++
 fs/fuse/dev.c                           | 101 ++++++++++++++++++++++++
 fs/fuse/dev_uring.c                     |  27 +++++++
 fs/fuse/dev_uring_i.h                   |   6 ++
 fs/fuse/fuse_dev_i.h                    |   3 +
 fs/fuse/fuse_i.h                        |  27 +++++++
 fs/fuse/inode.c                         |  41 +++++++++-
 fs/fuse/sysctl.c                        |  24 ++++++
 include/uapi/linux/fuse.h               |  10 ++-
 9 files changed, 261 insertions(+), 3 deletions(-)

-- 
2.43.5


