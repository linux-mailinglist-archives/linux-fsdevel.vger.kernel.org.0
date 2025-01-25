Return-Path: <linux-fsdevel+bounces-40112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA521A1C45B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 17:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF03188543B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12FA45C18;
	Sat, 25 Jan 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="pxlUvHic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49135973
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737822757; cv=none; b=tdnYJlKa9CnnkAI17CcC5MhIKwTrjIe1PrGfY88Q1aA1mlXB2tH4rW17wGhs28L7/lnxlaCCzUpQQ0znHTUwf1bKjsAnDgasOMSnmZysUnW69S48JukRiUUo/Gc4xzYUiOTtXF284U5ofSMoG7rHykD1gV4hQ684hDXKvjAnNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737822757; c=relaxed/simple;
	bh=+icgcTO+S1udMBNfq5ehOwAdgM2oITqk2P+z6N+W1r8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=T15ANzga4nGsNquSx0L8ea1+/qgtMhrZD3t7AYxFebblyivXWPqihKa2tXXjf0RgzCVMm+NDLrEtqIlqZ43J49czWW9EFnbexKDD/7+yDo2UfJC1bLSHVLRTkAFc2jfBM+21Z+XaEmKiZgFUld+M/CHY3omMSpR13Y2w3OVf39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=pxlUvHic; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso4242122a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1737822755; x=1738427555; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8RWmB6Ep3bjiEwZP1/hvFukb7y8zZunDf0wQG6DUKAw=;
        b=pxlUvHicyTC+Nu+8YUcpR0WK/bW4zjx93iytJ1VWT4JVxtM+pVCPYxwZ5DPmoBALui
         QoZvmGDz92OJmPVwhtXBNOw94FcufUOFyMxeJ5MJPi9uMmWGfvgLwn89tSF/9f8/p5IS
         6NGKdkHzazI2jAoSIiV8eE+v5Vd3RY5zG67uZBwu+dPIbkK93fQtW+XtY6nuAoN3lUmX
         Ttta8UAtv5NTp58Fhs4yJSgSWj1c4n40/R1dpGWmPjQD4YRWJmzxdIeWCxp6pXIZO34z
         9VKTQkazZlyKy51VqcirRc1NC7simKow+dPYFtMOPrDehBvesfe7TRUU9s/yAkoUKBLt
         YRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737822755; x=1738427555;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RWmB6Ep3bjiEwZP1/hvFukb7y8zZunDf0wQG6DUKAw=;
        b=FdDsI6ZEurSgBR1jMJoRXkU795Zn3Mig6AnVo0Rb8IW5T9pEHGTflCP8XB4F0Lz3m9
         B/KalMwkRBNf/v1UW3sUFsqq9LlZjw5HWWtemyUyczkQ9C4cMaBEmQQCxqS1gEgIWT7a
         P5TRDYIi1SAHy4sjd3yYAg45fS8JKbcG40tw2I851pcWartM7rCtyW7G9G/3S0dsnPdB
         FL6nwCbaHEXf6RFoaCk8aVvk1XTxZOuZ7QJA0fATurj3qgVsPCwxQr6GGzNXc3/+DLOT
         cMq2OkCbEkBjynKQWvGPxSTgNMayaQRm/xTdzUT61KlFZYjzRuLFEJylDdNxWE6g0FCG
         Y6ow==
X-Forwarded-Encrypted: i=1; AJvYcCUDYugjJz5M5zNt1UKGz5xARC5kqYIPGhqM+EricT+q0eLwHu0bi8tD6wjhHt4ItawABHOE04UzhDR1VyCK@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ535o6+ziFeH6NDGfY2J9Eb2b73wDszmpK4i9eORd4inwvlIW
	KnvMprQcdd0jz4/YTHBd13l0JLrA3LTeTLzJ3sX6SXfOKD9M5BmsFaYEkvAbIwWizXcLDGwUJz7
	EZ6D89PTfTsQXbVXWe9SWZd7gvnw2LRaXiLdSRmDdKV6X3WKMaw==
X-Gm-Gg: ASbGnctkWXdLTMjxkLbTYXj1ROxagUvqzHL3LExbUg8JXEgm7eLGHx4i+m3jKxXRBr/
	iu7oCsmwebSZTZEwdtWgzaV9mJn0HhRHlJVS3xjshZvfVVkyMH7Mp6PRDzz187khT5oosPrCR7Q
	==
X-Google-Smtp-Source: AGHT+IHHx+u79GqM41GGCDsK3bZE3OyhWYdDbkoczE0Z9sh/LUDSFyqPR58M/uma5dUMdBbzqARpumYNL70Z//90NL8=
X-Received: by 2002:a17:90b:5245:b0:2ee:5691:774e with SMTP id
 98e67ed59e1d1-2f782c55044mr52425519a91.2.1737822755067; Sat, 25 Jan 2025
 08:32:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Sat, 25 Jan 2025 11:32:24 -0500
X-Gm-Features: AWEUYZmplvW4HGPQjGkiPtmgU_R8VxpWx1hy9DAyzBb3qZ8CZZ61h8tenWoUcD0
Message-ID: <CAOg9mSRXYtybVX7GSK0dMcdOXTshJjy4YL8CF6Ly0aSPQV7nEg@mail.gmail.com>
Subject: [GIT PULL] orangefs syzbot fix...
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.14-ofs1

for you to fetch changes up to f7c848431632598ff9bce57a659db6af60d75b39:

  orangefs: fix a oob in orangefs_debug_write (2025-01-08 14:35:59 -0500)

----------------------------------------------------------------
orangefs: fix a oob in orangefs_debug_write

I got a syzbot report: slab-out-of-bounds Read in
orangefs_debug_write... several people suggested fixes,
I tested Al Viro's suggestion and made this patch.

----------------------------------------------------------------
Mike Marshall (1):
      orangefs: fix a oob in orangefs_debug_write

 fs/orangefs/orangefs-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

