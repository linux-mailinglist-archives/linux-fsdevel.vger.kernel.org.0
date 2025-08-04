Return-Path: <linux-fsdevel+bounces-56678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269AFB1A8A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAECA3B0E4F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D421CC59;
	Mon,  4 Aug 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLTw7Gfy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40F1C5F23
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328754; cv=none; b=t0TnbNy7OH0722BG7thta6Kaza/keWXG789sg6cjnsZVz7scEAx15RszPtRKAVqf9QqVyk3kJp9zp2gAu1y/vbEUjzixakBVjqecvFh0Vh7KTXONCi1zGagqSdA5JO7IjvVFCgXF9A5K+LYbnMOvWYjWjB1wwerXTXAPiU/GIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328754; c=relaxed/simple;
	bh=6omrky32C6lrFTbeVuU07023mfEqWFh51fbWb7R4jZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gKfLaunlj9aiQeALx6wV3OXQNJKznFHzZCXFIqVwa66muFktplRL1xgbaQcfgPoODyDU3Wlcwa+bZQSyp3eREFiF/tz1r3u7r6tsYLLPaTYvJzs5pf/cKWiTkfRNXAUNF2vV4y/J0vc14V+Sw+bXVZq6ne7IEjF57NItBQqSxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLTw7Gfy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so3128934a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754328753; x=1754933553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1hbEV+wQKYZ91CYnEdmqqYZVyEmSUGWyP+ffm9T6J8=;
        b=vLTw7GfyD04va9AtoMAVTpxnn37hBwzX+zVKGRNAJleioTa5pYfgN8DsvYJ6M7HbvY
         e08ST6di7CvjTGt6ZOu8CkOVDQgxyc9lIQOxWQli0YCMMlInkdfTsgjs3eJ45w9tGIMN
         YOjCXl4OfOeem5detjjxPz0g2t+lMg3ja+JR4N7lEnDg4IdtJh8Ai5CqOG/yJJ3fj9Sr
         H43jvBoNZFwWtV19b2m+FoX4EJIOGXv2glEnzHyTTDlsDts60A9Vn7DPMs5I1fpr4/AG
         QGvKpxoyXsThIeQG/fq9IAyReEQZrHZH1TXyHepXX4rB2Fx9PbfUrhvwN5g/3jC9oHZ5
         BM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328753; x=1754933553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1hbEV+wQKYZ91CYnEdmqqYZVyEmSUGWyP+ffm9T6J8=;
        b=i2ID1l9/ilpt73sfx+qQQF2vfBAUmF1uCoV4gw+jVDIsx45cSFITV/XIrPf0vgWISV
         UGsZ+1nenm1FbVocZlqHoLJIihBjsr8xu+ZNJi+GrhJAVV4USL061N5/Un6Zk2usEcf6
         O02J2qbWLRF/7IOTiPWAW5PCkkKD6oxtnDMw5D4VBO6DvzU3ZkLj1tqivuVNap0eV5Xz
         f3SwgfPIN3ogL3+z5CB7N6HXdYBO6B+5JSmR1QXvg1ORUi2VOIrWw/t70P/4wNGhQdsb
         5WeKnw6nLPEVBNLrZnzRkU5KXkWtyKp1DansfuumgkfyUjro80Y7eEI/HQknxOzsQz5e
         hg/g==
X-Forwarded-Encrypted: i=1; AJvYcCV1jDGg5/BqJ3ZfQfZeQoY2yOvcTivzVlBHpGv/1y7uTguiQMOJXVyPoEXv4EHnkrZUsEMuT816xccKfV1K@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEt01plzUawMxssU5v8lxeCCnttr7eQzSEM44JRLyntwwZVlU
	LZZyW7P+1Dfx0wo6YGriZjWIhn/ON2D4SWFS9rv4/b6DC/smrqKRvYdnFmch0kKXo0TdPlRwCH3
	2yYra3R5y92SQeJUg3e3ztNIIk6t9vQ==
X-Google-Smtp-Source: AGHT+IG1Pt6ujaMG+SQxGxkhlNtNdzUak3p7dhUL29RUZrlLA0K8t6YWgUS3XDJz7oEgP1LT/PGOceeopw4/IKy7z2c=
X-Received: from pfblm18.prod.google.com ([2002:a05:6a00:3c92:b0:746:1931:952a])
 (user=paullawrence job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3297:b0:23d:dad9:50d1 with SMTP id adf61e73a8af0-23df8f94a3cmr15663166637.7.1754328752641;
 Mon, 04 Aug 2025 10:32:32 -0700 (PDT)
Date: Mon,  4 Aug 2025 10:32:26 -0700
In-Reply-To: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804173228.1990317-1-paullawrence@google.com>
Subject: [PATCH 0/2] RFC: Set backing file at lookup
From: Paul Lawrence <paullawrence@google.com>
To: amir73il@gmail.com
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, paullawrence@google.com
Content-Type: text/plain; charset="UTF-8"

Based on our discussion, I put together two simple patches.

The first adds an optional extra parameter to FUSE_LOOKUP outargs. This allows
the daemon to set a backing file at lookup time on a successful lookup.

I then looked at which opcodes do not require a file handle. The simplest seem
to be FUSE_MKDIR and FUSE_RMDIR. So I implemented passthrough handling for these
opcodes in the second patch.

Both patches sit on top of Amir's tree at:

https://github.com/amir73il/linux/commit/ceaf7f16452f6aaf7993279b1c10e727d6bf6a32

Thoughts?

Paul

Paul Lawrence (2):
  fuse: Allow backing file to be set at lookup (WIP)
  fuse: Add passthrough for mkdir and rmdir (WIP)

 fs/fuse/dir.c             | 31 +++++++++++++---
 fs/fuse/fuse_i.h          | 14 ++++++-
 fs/fuse/iomode.c          | 41 ++++++++++++++++++--
 fs/fuse/passthrough.c     | 78 ++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/fuse.h |  6 +++
 5 files changed, 150 insertions(+), 20 deletions(-)

-- 
2.50.1.565.gc32cd1483b-goog


