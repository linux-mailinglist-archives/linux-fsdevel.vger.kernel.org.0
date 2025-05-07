Return-Path: <linux-fsdevel+bounces-48418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90547AAED2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 22:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E277B7B0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49728F94B;
	Wed,  7 May 2025 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl3/fkV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69628C2B3
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650590; cv=none; b=OikIoHf47qhXJcBuz6Avku6mnlzuQoVISwJlPo7iBzBlz0YnQTg7HF24TQsjsoGEtBbvDJHwovYLI49B7hS5dSngmHnOIgaZBZYcNnp7Yyg/r+Yg/Gu+3JYHLuNoLN807BkX0/yfaf+41EXjUfbIXbQXxFH2dHXFFGbux7O/7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650590; c=relaxed/simple;
	bh=Lr3GjZakdaEFkgK2/YRakskOA26h8R7T8UzGxPhj2Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5ML1KONXKRVmnAzxv4Z9PCOcxmF7MQQyBIti1gsaRnYldBozCJHoCETqjKMt0IuOAK+7gTeT2wqgk7XfjKmJh1QTClxHai+e4IAIfZgb6BcRfR9uyzeAAOrr8oI17AQeU0TGOrXCZIPnIlZbq0xKS8DW7y3fRv58xvm+mzI/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl3/fkV0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fbf52aad74so1839326a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746650587; x=1747255387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+sv5LlKdMwlLkzIf1iqOBkuaQzUFOXwvIit5DWo+y8=;
        b=Jl3/fkV0YImAiwpEGFS3OfQoUE/7aTY4UkXqPviJij3Ow9ntM5JN2Pfpdygi0+lFEu
         ZI4bZQgxgdHJfLQH5OAeV+N50gZstW/Jkhhzf3ymGYxZR4X51fggswWZykxrFRQ8SiAs
         Llawa922dm03Kfbm5NvEmMYuzD1Jjb8t5p9C7RcNzB5CZaqmSXwlzSNymTY7WkZgDdjW
         ySgJkC7ZHkhA5VhC6/q5yP6lsxvp6DyFfQyd1AJKcAmrQx7/u9R55RX9SVnMOGE9pFTG
         QM4xYv5WjEwdkebheVc4yQfPZ82W1M3OxwMuFg7i7bWiiMDAU4kYRqzyD5nkSrSZlac1
         gBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650587; x=1747255387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+sv5LlKdMwlLkzIf1iqOBkuaQzUFOXwvIit5DWo+y8=;
        b=HXe4uihdS63VDNoXmXG10wtwz3rHwpjZlG+nMRRLMRL03f0F9d7iHZQW8XMs7BX69h
         Foci8mjheo6WJuySYEPqXc9yht9rKieO3bAaM43RL1WKqnvxTtTUVxDc1cDEFkJEyrD+
         NXMiwnVLUWbvibkZAvwPzmCee+A7V2U1ZF/aIGURQanZqSDcLb+dXYLm4hew5gJiUeFe
         iHOgGb4bd+Jb1hM52Strs91o8VGIPxQMReRH/OR2HUFJHuhO80rBGdDG0D2h1NLM3DCP
         DBMyWtfXLELntmRivv8zrt+L5XjKK/a0UFr40bIqDtgmp0qtJWkw4gX0wA7GJ6tV3Ns+
         /QdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1s5ejpygKMghm2n+I2lKF99x6mbKsGD1hu6whi1yV+mTgNDPdkrz5Z3H93twKQMKLXLQR79WvhibkzRWc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6WLV8IgR4DF44vjCgY2tKBySV92h3MiEqs1nmqrfUYidiTJrz
	QvfNKEpBazekm66JhAwyPevOidMj7/hD1bgHyVY6ww31yRTaiWf0
X-Gm-Gg: ASbGncsLLDSM+anYWEQFL53lSgmr7LIusgCC5guSxuzHWKUMUPFdt5nJ9TkXX0MShkH
	W/X5I8oU8L6qYF4sdR00ecvz4U5ALm292+OJV0VHjn5d083KQV0L9Ba3uI2+jxWIOmNM189D73T
	uLj13h514skK5zPTqQMXQNntD7pRUzxT6gvFfky1mXVHKsViJxUbw0IoBOlLAIOmlNbZUwgZ06R
	XY6pJJAIUhqTq/2V4Ga5TSZLefRPar0D3WIgiFujtJ6PtZV18CihnUZGo++ymoc0YzqCqm16g8O
	2nWpQGKzp4d+ci+AJOpp9KS4xk99doLmE6USx05HQ6MledswvvUR6jVfbNYSotnQKcykLotP99B
	7hYcEkgl7zFYr1NDFbiAYL96+A3+ppx9N0scphw==
X-Google-Smtp-Source: AGHT+IGDsd56t49Qn3brxhIy+rJLACFudusXO7U9ALOtTlR1OSqnW/aWemZsnMNgbTy+p5yHRna4hA==
X-Received: by 2002:a05:6402:2750:b0:5e4:d52b:78a2 with SMTP id 4fb4d7f45d1cf-5fc356f503fmr817207a12.15.1746650587251;
        Wed, 07 May 2025 13:43:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbfbe5c5bfsm965615a12.9.2025.05.07.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] filesystems selftests cleanups
Date: Wed,  7 May 2025 22:42:57 +0200
Message-Id: <20250507204302.460913-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

I was cleaning up my test env today to prepare for the test
of fanotify mount ns notifications inside userns and tried to
disolve the headers_install depenency.

These patches got rid of the dependency for my kvm setup for the
affected filesystems tests.

Building with TOOLS_INCLUDES dir was recommended by John Hubbard [1].

NOTE #1: these patches are based on a merge of vfs-6.16.mount
(changes wrappers.h) into v6.15-rc5 (changes mount-notify_test.c),
so if this cleanup is acceptable, we should probably setup a stable
branch for 6.16, so that I can base my fanotify patches on it.

NOTE #2: some of the defines in wrappers.h are only left for
mount_setattr, which was not converted to use TOOLS_INCLUDES.
I did not want to mess with it.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com/

Amir Goldstein (5):
  selftests/filesystems: move wrapper.h out of overlayfs subdir
  selftests/fs/statmount: build with tools include dir
  selftests/fs/mount-notify: build with tools include dir
  selftests/filesystems: create get_unique_mnt_id() helper
  selftests/filesystems: create setup_userns() helper

 tools/include/uapi/linux/fanotify.h           | 274 ++++++++++++++++++
 tools/include/uapi/linux/mount.h              | 235 +++++++++++++++
 tools/include/uapi/linux/nsfs.h               |  45 +++
 .../filesystems/mount-notify/Makefile         |   6 +-
 .../mount-notify/mount-notify_test.c          |  38 +--
 .../selftests/filesystems/overlayfs/Makefile  |   2 +-
 .../filesystems/overlayfs/dev_in_maps.c       |   2 +-
 .../overlayfs/set_layers_via_fds.c            |   2 +-
 .../selftests/filesystems/statmount/Makefile  |   6 +-
 .../filesystems/statmount/statmount.h         |  12 +
 .../filesystems/statmount/statmount_test_ns.c |  88 +-----
 tools/testing/selftests/filesystems/utils.c   |  85 ++++++
 tools/testing/selftests/filesystems/utils.h   |   3 +
 .../filesystems/{overlayfs => }/wrappers.h    |   0
 .../testing/selftests/mount_setattr/Makefile  |   2 +
 .../mount_setattr/mount_setattr_test.c        |   2 +-
 16 files changed, 684 insertions(+), 118 deletions(-)
 create mode 100644 tools/include/uapi/linux/fanotify.h
 create mode 100644 tools/include/uapi/linux/mount.h
 create mode 100644 tools/include/uapi/linux/nsfs.h
 rename tools/testing/selftests/filesystems/{overlayfs => }/wrappers.h (100%)

-- 
2.34.1


