Return-Path: <linux-fsdevel+bounces-9433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E8841395
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1FB265BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA76F09C;
	Mon, 29 Jan 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmdf6gNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD684E1BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556923; cv=none; b=QA8TryDHYcF+s2WCpJkfGFVQCCkf8GiEQnp/Q5zhWpIGilsDKvNfZORnVKgWmSZYvi6X7Lt9BO+2kTTNE7ux1nvK6ImGgsuEPSyou85amy2Do42AZKR33Jd3PT8VFnkwMm1pNBYjzJQeAGDBYqaRUJoAicgud0NcbvCiCq4+WWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556923; c=relaxed/simple;
	bh=q+KxZnv5oof9XIDGvhACsh+/6ErV1CKpfDTSXHD8Zwg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kQZcjDx3LjPSPXQ4V+9jX0A8rIux8A18a/1ts1RRnqBNpY/a6iE+0i03Pm1ZB+sH6nL2DVSPSb83BfkCUwUrNXHGk6+BT81Nkh4KcNBIGdvkor9nZxEWx19kLVg19MgTxwKPaSR9qh+MAsOScugeluHJJ1uN/QP2OAIbkuAU8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fmdf6gNZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc691f0f3b9so1139995276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 11:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706556920; x=1707161720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y47b8IapUuQ52NiyXedK/xqkWWUKqV6XNeLrQIpcJlU=;
        b=fmdf6gNZHX7z0Kc7CKU6VCNGXOPXl47CUTZNGuw7r3jdBbxiLAjYQ6vf1qNqOoby4v
         QRuvEZyIJELteL5xl01G8+KvfBmjBwwDFEDDaIiIzzHiWXrsQcvBxnWaJb0TbW4/+5EO
         a3ZbEoDvUUPYJwv/7YBSjzLUoTRlbh9EV9bQBN0xTkhV85qH2oAp44AO9awf+QkCR6Sf
         MZPW8D12Wml+WUe6hSv3Wcm9loIg2d2rgQ6jzXZ/iegS6Dy/c4gSNIW/yQIfzXulSylw
         pQr6X/mN3md9LmPX8RwXkfepcYbpcr17HrMCh/wt2Rldy18fIyKre1q+osPcQG+ZuL56
         +LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556920; x=1707161720;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y47b8IapUuQ52NiyXedK/xqkWWUKqV6XNeLrQIpcJlU=;
        b=Y241rUcCx3hY4jQ83/sc9gvQHuwQsDf20dwQ78tsYQZlcMSMfXh6qIBCwvRectHdpw
         BTXeaK3FsxOw1wwEhBpzMfeYQ6LdvTNdyxX3Du2k1jAPExKB3hED634fTn6LEMztsPLA
         M8Ix6hiQ1O9uktPDpoyfOHLI5vee9W/zaOryZVdB1MPK57QdKVuMJW0/IGAOWwniKwPV
         MuRHrmsCyg6Xj3XVxcvFJXyIKcZm6AXGYwLiYNnPcBXhZh6SwaZv5VXvAOOxLdAelFgR
         XFR9U4SMbelFfUHFP4l94WuBhnvX7apdW9Y+5QYHNgFX9zoWXHPn96uWFXO4DpDo+gWS
         oTKQ==
X-Gm-Message-State: AOJu0YzSRpMadXF+DS86seEFy1E8w5Eq5+a0pr6OEbrp1bBOxWc70hf7
	T51QY7AFo/D+QYM80D2ozNub/Jslh9eV/3hwMtBn3M7EByped4DtRoSypGM+VPUH8WhzAftsOcd
	nXfpQ4k5qWIplFQoYLHwcgw==
X-Google-Smtp-Source: AGHT+IFpUlsNWwzEIDjzWN6N56lWLkRvPKg+4gqK1HK7WRmXRpoMLHM95bZ5V0i0zZbH36vyMnKU3/xtEdcui8mBFg==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:9b1d:f1ee:f750:93f1])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:2604:b0:dc2:23db:1bc8 with
 SMTP id dw4-20020a056902260400b00dc223db1bc8mr443578ybb.3.1706556920762; Mon,
 29 Jan 2024 11:35:20 -0800 (PST)
Date: Mon, 29 Jan 2024 11:35:09 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129193512.123145-1-lokeshgidra@google.com>
Subject: [PATCH v2 0/3] per-vma locks in userfaultfd
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Performing userfaultfd operations (like copy/move etc.) in critical
section of mmap_lock (read-mode) causes significant contention on the
lock when operations requiring the lock in write-mode are taking place
concurrently. We can use per-vma locks instead to significantly reduce
the contention issue.

Changes since v1 [1]:
- rebase patches on 'mm-unstable' branch

[1] https://lore.kernel.org/all/20240126182647.2748949-1-lokeshgidra@google.com/

Lokesh Gidra (3):
  userfaultfd: move userfaultfd_ctx struct to header file
  userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
  userfaultfd: use per-vma locks in userfaultfd operations

 fs/userfaultfd.c              |  86 ++++---------
 include/linux/userfaultfd_k.h |  75 ++++++++---
 mm/userfaultfd.c              | 229 ++++++++++++++++++++++------------
 3 files changed, 229 insertions(+), 161 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


