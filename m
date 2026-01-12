Return-Path: <linux-fsdevel+bounces-73217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DDCD1239D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5255305159A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF03563CA;
	Mon, 12 Jan 2026 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="gz8zYUrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB22BE7BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216692; cv=none; b=JYsq8jRIJ78OdXl9uYWk+bHugPWvdzmlbaNPW3i2/7tGvQ/jZ7HkPC8+JJTWOfJh+v2NRVJsmyNCiv/zOx/npUEpeduf4jbnEGvEHA+SWnpFJOlM2oCoUvK/sqBHNkMIgv2ss/d59ShdK4S63J6YpijS4AMF8L2VPFiIq1YfVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216692; c=relaxed/simple;
	bh=+lzNnO3EZoAX6937LfVXAUk38eYprgK6ZLoVn7TWovE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dn733oT4XOoKwsZoPCwnDanPDvNlKf+PTo3eOpLwMj5LVfoJzS6L9mr9wkOoPE7Q7qT1EWZLRwRQUnMS03gIViwGCBXPcZE2IHNUep1C8B98OZxo6ttxQxM22xWVci3OB9eCUFPbTZaF7r8RIKrL9dQNz/OrKprczP6qA2EoLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=gz8zYUrZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so38083235e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1768216689; x=1768821489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9T3d71YKL4EMfDR/cWS8mNsqGkj5jXmfI0Eur6XceY=;
        b=gz8zYUrZuW0PqzKDkayI00wCsS+qzZ0lR7jNXHjkBj/HOrBuJ5cvfYYtOo5XzPV/Pq
         4KDb9axtElo4JfmGtpLaDI5+On3t7YfWBzU3Wv782JSVbZPtkbjN9UWPsiAvCjz2HfcR
         MKtLjbkiMatSSkMw2h5aDcZT96t6IYYQLze4XD0EyeDN1ODoDZVMJegPuPeiiTCQ306H
         gTxFdw/U1qV1DpoMzLvuEPsByM5/y0pdv2fjuUDjc+Y8EgAPGd6fk8XjQz8W7FLhnGJF
         4A/uItsDyt/WR7P8LL6XOqkSIXbkt+Fdkq75NUaXB7OPimahaeIKxLkI6Wb4gLVtRv5l
         b5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768216689; x=1768821489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9T3d71YKL4EMfDR/cWS8mNsqGkj5jXmfI0Eur6XceY=;
        b=hbSK7KYQ1C7H9Mf9wB95xhcOJK0/Hdy3aiCySjZAI5wYBB3CJoRWbHMuhgaZ8ulVm7
         2pDh3eXrXv73kyQ23sYofopHpkZKq9zjBZlOX53Jc6tClJtx64HhwcdBxFcxucH8fwu/
         QQyjwMxZXh9wSpYKJU/L+/r9BEIn2KySzA7zgH9U+/le9sGllnZeS3QwUU1twgki632r
         92XkJB4zLTwDeAeSYxEnZcE0f1FaoyWbEg7a1H9k7qCx4X8HFBW4r62T8aQXR4G4pdvd
         4Rt8sJTK7Y/pQm1VPqzlIEzm3kGFYA3CmlteZ/R5WWff9XES2G3JGVUx5i5sWyeodxxE
         vdEg==
X-Forwarded-Encrypted: i=1; AJvYcCWFHvRkiqFpHKrcEA/UMEcjpFpscZKzaIGTjgujA5aBZK15ImqXg4wVv+co/XTi4HY1jQOQzA4VZFb4CyyK@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKkJrptq6XMnMaDMBl4MjSTjj0ny7ZLxSdOtUWgVT4HvG3mXn
	nqFzhnjpkHZhf82xewfvyORsKdULwVpBab7qdZqfCUtTfqDjeCUhtn6Sp0GQPyIt7+A=
X-Gm-Gg: AY/fxX5qbUj4X6juBsCr891wP29s3pxJyg2A8Bz7MbgjKnAYd9Tw2wnoK8JZ9SCB4j7
	eVjVzCqIVInqcUPNNHIdle3UGhDAiFhg6DUurRYXVmQk9cnx6ng7Yh+ATuv5bME1rKradH2J2p8
	TadvaopBwbKvf5RAl269VdDTNPdaCsoCs9s1DDggs9Ibn4x7naTldzGzpoVs1/jP9fLsP33SiNo
	qp2hkHdGn7AY4ENIYt5vC8K6djxvM4JRS+LEPIZMN1+VbeWSfVBTb/KGJh6XSQ43FnbX0dpJlTy
	80Kv09/BowHvRaFDbIlu/ijAUK1fu8ghQaeEWjtH/5KZ47/eHwcaL9oHKa++IJ9kel7LiLXL48v
	kBoFBvbTJ44HutnoSr9QLIRgzZOMypmGJiOrl5BtoIMUqpJwP9gP5I5q/yzV81tcKqqvP8tr95/
	e8skiFEykxgd43+7+Ac5wOud7kPILmxreJauA=
X-Google-Smtp-Source: AGHT+IE8VvQD2h057zZTq10HWR7xOcvU+coYtUX2017x46qZjQsqBv/YBw6sYjaUyLmpStwwKSLG3A==
X-Received: by 2002:a05:600c:198e:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-47d84b2cf2dmr203924545e9.15.1768216688934;
        Mon, 12 Jan 2026 03:18:08 -0800 (PST)
Received: from matt-Precision-5490.. ([104.28.192.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5dfa07sm37852759f8f.25.2026.01.12.03.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 03:18:08 -0800 (PST)
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: [REGRESSION] 6.12: Workqueue lockups in inode_switch_wbs_work_fn (suspect commit 66c14dccd810)
Date: Mon, 12 Jan 2026 11:18:04 +0000
Message-ID: <20260112111804.3773280-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jan, it's me again :)

I’m writing to report a regression we are observing in our production
environment running kernel 6.12. We are seeing severe workqueue lockups that
appear to be triggered by high-volume cgroup destruction. We have isolated the
issue to 66c14dccd810 ("writeback: Avoid softlockup when switching many
inodes").

We're seeing stalled tasks in the inode_switch_wbs workqueue. The worker
appears to be CPU-bound within inode_switch_wbs_work_fn, leading to RCU stalls
and eventual system lockups.

Here is a representative trace from a stalled CPU-bound worker pool:

[1437023.584832][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[1437023.733923][    C0] pool 358:
[1437023.733924][    C0] task:kworker/89:0    state:R  running task     stack:0     pid:3136989 tgid:3136989 ppid:2      task_flags:0x4208060 flags:0x00004000
[1437023.733929][    C0] Workqueue: inode_switch_wbs inode_switch_wbs_work_fn
[1437023.733933][    C0] Call Trace:
[1437023.733934][    C0]  <TASK>
[1437023.733937][    C0]  __schedule+0x4fb/0xbf0
[1437023.733942][    C0]  __cond_resched+0x33/0x60
[1437023.733944][    C0]  inode_switch_wbs_work_fn+0x481/0x710
[1437023.733948][    C0]  process_one_work+0x17b/0x330
[1437023.733950][    C0]  worker_thread+0x2ce/0x3f0

Our environment makes heavy use of cgroup-based services. When these services
-- specifically our caching layer -- are shut down, they can trigger the
offlining of a massive number of inodes (approx. 200k-250k+ inodes per service).

We have verified that reverting 66c14dccd810 completely eliminates these
lockups in our production environment.

I am currently working on creating a synthetic reproduction case in the lab to
replicate the inode/cgroup density required to trigger this on demand. In the
meantime, I wanted to share these findings to see if you have any insights.

Thanks,
Matt

