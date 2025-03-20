Return-Path: <linux-fsdevel+bounces-44513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E1FA69FE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 07:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A513B37B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294EA1E98FB;
	Thu, 20 Mar 2025 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3UHfLraX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160EC29A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452787; cv=none; b=Bp4PU9X7zse3CE9Ijkc3VePoMDR0tQMFHbex6wTa8i73n5mecdKadpp8UCGu0EFgWoJ/SXqVZs4vJw6HRuW0cmGronPRQzVlR0pY+iI6HkXzHP3ghACrljNkVRUHojCLie9PGti/BddIMhXLRfa+ov2Ze4Zk9QkzNYEjfjVfcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452787; c=relaxed/simple;
	bh=lvHr0xBduL12ILHUgkyvTDkRAIc5TEt9QlLTMcKApCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J8nKB500orKDwXj+8fUYjkIdCUmy8H5ZYH0AnkppZOJhsOd3F7D1KSOb2cwCcwGnkrZfC3Wjgqy1uNFH963DhXz0IlKHaN0BbjjwY4uZZyhAQqy2lD0hzCJ62P/646zVwHQYOBAuvIrwJFzYaAvhl/cPLQxL1fQTu17LkhFF6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3UHfLraX; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3d43d3338d7so9315745ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742452785; x=1743057585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ZuKkdmfZDR1C+3icFeF962+7yJcOI589wOKKi/iF/w=;
        b=3UHfLraXEmNQRRJt+dSZjFQV+eZuZ3VyBV7NOM6LCKhmbBX9kfV592MnsT4SYRCx1/
         WTfPD4xzrTqOpQ0tLjKJ0wmwEFuWuE1hKvGwgdqr97NhxslNcuOMG0z2efLc2bthmkBN
         l03p2o3fb6k9evSwAGwo37tVLQIJyGH1aaoALs2iIwv6poYJpRo6kCfkaaks+5tWdM+Y
         4PlCYDJxTmxHTNamrDg9LEaBJBxcetn1mHT5P+aAs91iNoYjT5tew5AkZw11Yy9oBQ62
         j1RFcRPRtuYymtj+pGHozitDCaKWy14ObPGugGx88l6B2Ag+BQmafET3yKLOSYa9kbeG
         57cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742452785; x=1743057585;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZuKkdmfZDR1C+3icFeF962+7yJcOI589wOKKi/iF/w=;
        b=wU1HqGl5cpBZe9PwSGwQNsZlQeYqwWWOzJxQLn2T7t0zSxISdHTgYnJtLsqXCpv6Ik
         +5tsyj9C9jT6kGnNCfuPmFYenUtR/YEZODl9eHXeBGiOExBdHQb8QjRD6vIL9Q6/hMI+
         +8LTzasusLxDL3hZ4smKus+ljSyEg63XtasKS0gmJN9gsVvchofS4qEl861HyW817A/h
         I8xLyRUV5G4/2eEp5UOdAq5joKzH/d3/3kb6pw/CtkaY/Iusn777x4tjbIfruHx9eRkp
         CBDee1KCDmgeULRUK6mdi4Hkz7j2QGyLx5nBt2UxB9C9YrScikyEkCOoKz6XsWFe9HHG
         /ZXw==
X-Forwarded-Encrypted: i=1; AJvYcCV8p50vCiofsI+4qk2I+heQ31TAJeMtYjI0lt07VwvNcdghnbrkybBV0NjfNmEPIXZBS4lwE+5MhBz9pt0m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1NQ4zw8kRv7b0+O595UzzzZuCABJ2tR7U2Cuj8Or2HxBfE0us
	zPMw+72Ww7CgaARmFMZEGaOvZVQpBzQyevW7DTQF/nlsSTmnh6xAzb+jNq5/S2LsT1nQbwu2gZd
	Gvw==
X-Google-Smtp-Source: AGHT+IHWqodOqFQvUCGpVWIEl082LJUg7feyjPoyDn+FcJqgqu/vvy3kAQRePZCxSlpgiFrJVjN7q7Ot0j4=
X-Received: from ilbck17.prod.google.com ([2002:a05:6e02:3711:b0:3d5:8368:8284])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:1c0f:b0:3d0:237e:c29c
 with SMTP id e9e14a558f8ab-3d586b45206mr71026475ab.12.1742452785209; Wed, 19
 Mar 2025 23:39:45 -0700 (PDT)
Date: Thu, 20 Mar 2025 06:39:01 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320063903.2685882-1-avagin@google.com>
Subject: [PATCH 0/2] fs/proc: extend the PAGEMAP_SCAN ioctl to report
From: Andrei Vagin <avagin@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the PAGE_IS_GUARD flag in the PAGEMAP_SCAN ioctl to expose
information about guard regions. This allows userspace tools, such as
CRIU, to detect and handle guard regions.

This series should be applied on top of "[PATCH 0/2] fs/proc/task_mmu:
add guard region bit to pagemap":
https://lore.kernel.org/all/2025031926-engraved-footer-3e9b@gregkh/T/

The series includes updates to the documentation and selftests to
reflect the new functionality.

Andrei Vagin (2):
  fs/proc: extend the PAGEMAP_SCAN ioctl to report guard regions
  selftests/mm: add PAGEMAP_SCAN guard region test

 Documentation/admin-guide/mm/pagemap.rst   |  1 +
 fs/proc/task_mmu.c                         |  8 +++-
 include/uapi/linux/fs.h                    |  1 +
 tools/testing/selftests/mm/guard-regions.c | 53 ++++++++++++++++++++++
 4 files changed, 61 insertions(+), 2 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


