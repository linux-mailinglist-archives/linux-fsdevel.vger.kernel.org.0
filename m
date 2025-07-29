Return-Path: <linux-fsdevel+bounces-56277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA5BB1546D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90AE7B0D8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 20:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA6277CA9;
	Tue, 29 Jul 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="piBE9UQ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09033136348
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822293; cv=none; b=qirJ9sqhdCepbjJT7AxJbtVOmkSAQDbsBHhwHD2T5JQH/HydosoPwQXfX+hadrdv+DU0mPMdMF8b58t5rUyDrpYolBcEkl9AdAorzvvHW/g1SXOMGoF8jlaLYP0ZIu7iBlyLNv5cm8lFXW69I8P2GUX1MOy/LlDf4sC6ot764vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822293; c=relaxed/simple;
	bh=at7wv7dglQHSffUjEQ1SZQdJS8KUBIGGScGRZm65KvE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iGI31Cm43qRKfVtoMUR+U+u+IDDJJoa2igcfCIuRnWlAK/t/70lhTXigfK8mZaTJ6RsXxS7l/JqBE1VYyv3JdLyKAZimc9ZDCkKwGe9TRQTNIE8qzQ8C/FTf2pOEqlirLC+cXpdY7QVCivNURWeyZmJPaMXq5eQ5351MX656CEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=piBE9UQ7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so165347a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1753822291; x=1754427091; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=578jKP0hi0tqBVIjYWRvcUwNsc6+UhPS5TGkN9Mmbb8=;
        b=piBE9UQ75fyAfeS0FfO1eZ86mCGsBAcKPAFBcS4ZHmbmhh8cqVQ8TxVR4JhAetOzkd
         b8zLxwMgByuY90RRJylNeHc/7t/PMfGVmgisexmcyIZsB7rXTMhysdxp+LbzjnE7/i7m
         B/8gd0tCc/aIhfXq4rYsS6wGOxrklnubdSlKj9YeEkCnEzTSDbf7NhV9HnoB5PrKaG+V
         +N/a80GFeqHZyxoHPYKmu3hLKLlwVuFmNCCXkqmN9HNfeKBgvBueEoaivjzGGLNGGThR
         PkNMWkSIquSCVkbaMIyNQ+SCmBAXXOJFgOA6+OqzpODJU2mOIGInf6FQYUq0ZGK8Cvsq
         X3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753822291; x=1754427091;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=578jKP0hi0tqBVIjYWRvcUwNsc6+UhPS5TGkN9Mmbb8=;
        b=pQTkM6JoAte5hBrondeiWNJO7UaJ+WVQdNfaQzAcTcryHhrI+iqrdoCAucnCksgARw
         WjroImj7LaQbg4TFmHMzpI55xmFwLFneqefS+cYmwpBwFk+CYEIcaizLcgZ1IHHYoh4R
         LOqkhqjsCWRYAkCZIb6zy5dqlufq9EaXTZY6GFbTTVWsU5xNLGuGMRecZdod+Ro0n5Mk
         MM2qImigEhRs7J+LnGMnWmejYAuB6pWNlDpb3JzTuLkpbq+AN10QA25y7CnLtHoxyp2p
         9Siu4CYJB7wciYplPDTMK69xxGTMBdZ8A23dLcjq2Z/0Lsm/k7d/CnOraZQWHS2bRZwi
         NFgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOnQc4/D/pI59IaW9p+X4SBkAc/bCJN+uY9fnDhrpa8BlIl/pkTlzIyVhq7y9dUZKdA86s1L/4nUvZZOnF@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+fH7sE+Kklr/18SzSzpkiUYmeoXH1iCZbfhRP93mjqwmoHE5
	dFNsh+zXXJPUljBs1gT0rc8TXwYWkBkJIVJTtBDifcmLQ2Qgipj9nVRnMR7Fjq5sHnN50/WPRWZ
	EJqWHgAhlo5LqPW1CsGUF8PyP5FBkKxgQ0X1I+ZKR
X-Gm-Gg: ASbGncv8i2kKcXyT9QoTTgjL8QNNv1ErlIp+jaJZS94jP8R3HJ9tQgpWqerbfxe5pc/
	aCL/XTtXHJCvaB9URMhDLnu70NfeaDegQtSjk38tg66UK2KY7nWAAm3ql284nsbgk43RVERo81/
	pflKzAe1mACTkdmgev45UMJdOf9rJF8Udj1nqTFxLSeZHceq2jHOLVVhRkIktbNdzyv0uZFp+qj
	ss90FvLrnWQnrRsRvY=
X-Google-Smtp-Source: AGHT+IHFddi40TTm6cZBAA9PiJhIK2zNprWK8Gs1f+2BU0iJl2Rwr+HrzlAsoOff6zAq4E0jbc2qWg0bqp+nfvb0+MA=
X-Received: by 2002:a17:90b:4c8f:b0:312:f88d:25f9 with SMTP id
 98e67ed59e1d1-31f5dd8921dmr1025894a91.7.1753822291188; Tue, 29 Jul 2025
 13:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 29 Jul 2025 16:51:20 -0400
X-Gm-Features: Ac12FXyFxL81O0IrhpWsHbUNoJI2MevNbfRHash4HpouZZbd8DogRq_OxDQUOf0
Message-ID: <CAOg9mSSTTgDcyex2gGK5V+JmaNfdXJidWkSkR8XdM+i2SN8NXQ@mail.gmail.com>
Subject: [GIT PULL] orangefs fixes for 6.17
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.17-ofs1

for you to fetch changes up to 2138e89cb066b40386b1d9ddd61253347d356474:

  fs/orangefs: Allow 2 more characters in do_c_string() (2025-07-22
12:39:29 -0400)

----------------------------------------------------------------
orangefs: fixes for string handling in debugfs and sysfs

Change scnprintf to sysfs_emit in sysfs code.

Change sprintf to scnprintf in debugfs code.

Refactor debugfs mask-to-string code for readability and slightly
improved functionality.

----------------------------------------------------------------
Amir Mohammad Jahangirzad (1):
      fs/orangefs: use snprintf() instead of sprintf()

Dan Carpenter (1):
      fs/orangefs: Allow 2 more characters in do_c_string()

Shankari Anand (1):
      fs: orangefs: replace scnprintf() with sysfs_emit()

 fs/orangefs/orangefs-debugfs.c |  8 ++++----
 fs/orangefs/orangefs-sysfs.c   | 28 ++++++++++------------------
 2 files changed, 14 insertions(+), 22 deletions(-)

