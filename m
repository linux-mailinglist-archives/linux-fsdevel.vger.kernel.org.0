Return-Path: <linux-fsdevel+bounces-10403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF69184AB64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 02:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C481C23A0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2635A4A3E;
	Tue,  6 Feb 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuBnNS2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF094A02
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181774; cv=none; b=HeGGaH1FMWsH0xHD9jSepAJwm9LU/rcqFN+N/QxPWS41/zZU/fLsXwUftc3etovHkVh6swhtAfcyw+HFuzd+/esw6arUCEjR7dAIOBz85EzalRdYFmO4CQL3Dj8YOC3bFejMVSf1FfwMQGcSAPw3dWjvBmr3PPqOp4MarVk+NS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181774; c=relaxed/simple;
	bh=GdHdniQnbMOXtlmLfBAIzFnjtasDR34ui/wEy9tYr8s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VguWZVE5xi/y81Ud5BQ0LlWU3rbDPdSxGEEnTFGK9AlTEVPlY15I3U6N3Vwq8IoliXH0uw58OuVcj2UTqHWPRk0HZBkcELTWsAmFBQTXjhhSBd1GR2YI5Qj3K2G0RSgykr1tgrTLOWoBzMkuh12gua0ISF1IY2qdUSuaF5XrHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vuBnNS2D; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6c47cf679so8831915276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 17:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707181772; x=1707786572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFHBvxcNZW2HfjsGIsVhZk87PaG1v642sbVGsClWfxY=;
        b=vuBnNS2DuUXlqVJ15g75711OjVR9EqNrUnrFoy4+vDmz1KxfJipACqokd3EEMtYFOB
         M5L949iLtPgfaTpdv/s6ybOCrPn63NCdgkj+WRLJwKB1WYaDFtJVdmnuW8WH/t7BMv5v
         wDARcLSIRKiiZCCUo0BDJP0mRe44kv9PWKi4BGvd6K4KqOQhZ82UYdHzRG0iuabDfHsN
         qDbk7B4YVgqfffm2iYoqbngLvu94GKcw5lBcHffBzaeJlO4ciKgs9QkrsC5nuWPnBIif
         j1JrnSnQXzTU1ugBJx5Qr5QQdONZPI7M0+q5M47CrT8bVd3raBNa6NGigsEyaXNmo5B9
         SyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181772; x=1707786572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFHBvxcNZW2HfjsGIsVhZk87PaG1v642sbVGsClWfxY=;
        b=aRSeJiZyERyU9Q9NbFFctEEv1eyN3hvcQI+vDtbPQJzTK3nULl6OnwFVoDdNrzAkhA
         GwMKvIlh8iWdNnLE993eZdCtESxkTd2KJjqmVBA37IotdwHDTVNppvhDxYwri17RxBaU
         clhAtCkrKCuUEwRQPGTlOCzdv+NkDVAYriqY0xTB1+QdHTFg8cl6gYKi+/XtFSPN3acd
         W6luwpcYYDrnJWR1/bef7kQm+uzBc/MVFQBIo47GOA+BrZio9vW9U3vlrRGb3TPoZLhR
         Ej0MUX+fZUDdynaA38vuDqK9IfZBrDc2WQ5X9fGkr04OH3AP2tTR5hSHQCjWe02oJbkW
         deKw==
X-Gm-Message-State: AOJu0YxdynLHyLKce1XhSFsdqJ7RkgLwENgu+6zdNfEkg1Yrmxf+UKn8
	LYKYvZ9vA68p/faTjGjzgWvoOYWNdoqmD93CmY9j9VUyS2MzqcZCqkl4xnfFmjLNQmcuZKACw93
	w+Ov6q/KI2TFbhLgPaeO8Vw==
X-Google-Smtp-Source: AGHT+IH1RhvmxdMgiLN/uYEOr6sr5Ko2uXZynT5hRnaY5hwDi5R6HBD+SHyb78d2LA94Xo7Ale0nQeBJWCfcO1Y4yQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:713:bb2c:e0e8:becb])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:2842:b0:dc6:519b:5425 with
 SMTP id ee2-20020a056902284200b00dc6519b5425mr38783ybb.11.1707181772174; Mon,
 05 Feb 2024 17:09:32 -0800 (PST)
Date: Mon,  5 Feb 2024 17:09:16 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206010919.1109005-1-lokeshgidra@google.com>
Subject: [PATCH v3 0/3] per-vma locks in userfaultfd
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"

Performing userfaultfd operations (like copy/move etc.) in critical
section of mmap_lock (read-mode) causes significant contention on the
lock when operations requiring the lock in write-mode are taking place
concurrently. We can use per-vma locks instead to significantly reduce
the contention issue.

Android runtime's Garbage Collector uses userfaultfd for concurrent
compaction. mmap-lock contention during compaction potentially causes
jittery experience for the user. During one such reproducible scenario,
we observed the following improvements with this patch-set:

- Wall clock time of compaction phase came down from ~3s to <500ms
- Uninterruptible sleep time (across all threads in the process) was
  ~10ms (none in mmap_lock) during compaction, instead of >20s


Changes since v2 [2]:
- Implement and use lock_vma() which uses mmap_lock critical section
  to lock the VMA using per-vma lock if lock_vma_under_rcu() fails,
  per Liam R. Howlett. This helps simplify the code and also avoids
  performing the entire userfaultfd operation under mmap_lock.

Changes since v1 [1]:
- rebase patches on 'mm-unstable' branch

[1] https://lore.kernel.org/all/20240126182647.2748949-1-lokeshgidra@google.com/
[2] https://lore.kernel.org/all/20240129193512.123145-1-lokeshgidra@google.com/

Lokesh Gidra (3):
  userfaultfd: move userfaultfd_ctx struct to header file
  userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
  userfaultfd: use per-vma locks in userfaultfd operations

 fs/userfaultfd.c              |  86 +++-------
 include/linux/mm.h            |  16 ++
 include/linux/userfaultfd_k.h |  75 +++++++--
 mm/memory.c                   |  48 ++++++
 mm/userfaultfd.c              | 300 +++++++++++++++++++++-------------
 5 files changed, 331 insertions(+), 194 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


