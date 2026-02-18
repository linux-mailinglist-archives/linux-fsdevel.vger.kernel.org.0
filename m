Return-Path: <linux-fsdevel+bounces-77490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCJbGY0wlWmeMwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:22:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E9152D00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E89E3032673
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 03:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAA62116F6;
	Wed, 18 Feb 2026 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B70JCOX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE8327FD45
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771384966; cv=none; b=LiRUNgkvkvPCstmAAx7s3m9jiHc+C5GlkWbmPBuBvGChNAPE5mt10TeQS2QZk32bnnhha+l/Ke18XTh+obnWRW6Z3FDjwxJYSbF78TjRXItLOTgs//N1y/oNArt0lj1ciOevxACHaRLBdfSXil/qYyDTcFvJcR1g3oZpWZYMvpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771384966; c=relaxed/simple;
	bh=32HF38AOD/I/0DWJn1DNDyTIUijzlwxnIPrqmmhrMEc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IC6RLbexy/AkEsbyLdiG6JTxUYPlXlAdDdOveZAL6nQM/RQB+Sh48IR1ScC99Jffm6dIQKnU18e4RZ/g5OBTtTAsazN278rk6iRUGoE6rHoqzms39PEFijwX4movnmhU51AFtaH+VEl8AO7pOlXP93F9xYC8qPNVVKZhI/zC5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B70JCOX/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354bf10ec2aso4234435a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 19:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771384965; x=1771989765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5oh2GGuUIGHttG6QQKJrDgyvg+KF11aDAOaopsiwdo=;
        b=B70JCOX/inNG3gWIiBSuXhyja6cGFpC1aqa5uh1cKSsJ9zoSgkTsWo/Yfa7Ncf2IuQ
         MG+Z5IrLg6kPKGIdW6rdcb+29+6nENjqskyAwVrTluMDZEhpSizkMAF8Ug31mHW+MJBf
         om2pSwH1L7Eiei4ttENGh0gzq4BcYbqLxAhkiDmyt1MtshNulEWqDp84URURMTbnEUqt
         HHq6vG0Ptp7un0tyWN701U+CzWzYLOCjRzHKaeCAdnyVjiv0hKTuxobucFLIr2AHTVK4
         X7+j+wsIsD0eqbKo4tqO+DBEkEmvx47piB+uSLzmzLbja/2at0kHpb2ni7etIZrqXm4e
         R5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771384965; x=1771989765;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5oh2GGuUIGHttG6QQKJrDgyvg+KF11aDAOaopsiwdo=;
        b=WadMdadCP1RoBX3+E071Rhzw+Kdc5FVUSOWW8LiJ8ZnHFFliWj64fHYTpCb0JkZ1lx
         XXhc49IrbIdHoDp65uH5oypXbInWy6w7UedqXwnxihtg5oZAa9Oe+kYj5Y4YCkrOQW5G
         Pt7aUwUYp1AjzeKBi4xt81AJD1bkMZ3purAHPbAQ4OZBH3Ft0x7IOjiuQ5aH0XgWUxr+
         wyWB2iz2UDgXBkYfNeZWNh++0qLJGD2cxIRndm1Lvby5Zlx3Av8a0eDP4b/oHkIr+LYC
         mYwl1fbwjHZFQ3A8KiKnNxGIFuOXtcSxCn2Cd7sQpc7uT1yYGYy2zOa9ZZzzFCu0LyCU
         T+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKevkk6rRvFoHKn6Vg0PknQ2HBvDHuTJ5ZSTF8eyTmFXWPqJm2UbSGeiq5JEkS+o5sFoybYBxXakbFGZly@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0JqmjC9Cy9mMnkYtdzdIGyJVEcujEUpoF+k7Mkm8GP0fyKN/
	91HF9Uc0sSu+QNxPmvAm45V3rcj/bIMTyFMeN5K/hl4vDKo5rRb8hBSVjdQOIzeDFtUszpboCch
	xN7WUSAEJFnTveVfzPQ==
X-Received: from pjal2.prod.google.com ([2002:a17:90a:1502:b0:34a:bebf:c162])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c08:b0:34a:e9b:26b1 with SMTP id 98e67ed59e1d1-35889194a48mr474071a91.26.1771384964802;
 Tue, 17 Feb 2026 19:22:44 -0800 (PST)
Date: Tue, 17 Feb 2026 19:22:29 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260218032232.4049467-1-tjmercier@google.com>
Subject: [PATCH v3 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
 for files
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77490-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B00E9152D00
X-Rspamd-Action: no action

This series adds support for IN_DELETE_SELF and IN_IGNORED inotify
events to kernfs files.

Currently, kernfs (used by cgroup and others) supports IN_MODIFY events
but fails to notify watchers when the file is removed (e.g. during
cgroup destruction). This forces userspace monitors to maintain resource
intensive side-channels like pidfds, procfs polling, or redundant
directory watches to detect when a cgroup dies and a watched file is
removed.

By generating IN_DELETE_SELF events on destruction, we allow watchers to
rely on a single watch descriptor for the entire lifecycle of the
monitored file, reducing resource usage (file descriptors, CPU cycles)
and complexity in userspace.

The series is structured as follows:
Patch 1 refactors kernfs_elem_attr to support arbitrary event types.
Patch 2 implements the logic to generate DELETE_SELF and IGNORED events
        on file removal.
Patch 3 adds selftests to verify the new behavior.

---
Changes in v3:
Remove parent IN_DELETE notification per Amir.
  Refactored kernfs_notify_workfn to avoid grabbing parent when
  unnecessary for DELETE events as a result.
Use notify_event for fsnotify_inode call per Amir
Initialize memcg pointers to NULL in selftests
Add Amir's Ack
Add Tejun's Acks to the series

Changes in v2:
Remove unused variables from new selftests per kernel test robot
Fix kernfs_type argument per Tejun
Inline checks for FS_MODIFY, FS_DELETE in kernfs_notify_workfn per Tejun

T.J. Mercier (3):
  kernfs: allow passing fsnotify event types
  kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
  selftests: memcg: Add tests IN_DELETE_SELF and IN_IGNORED on
    memory.events

 fs/kernfs/dir.c                               |  21 +++
 fs/kernfs/file.c                              |  49 ++++---
 fs/kernfs/kernfs-internal.h                   |   3 +
 include/linux/kernfs.h                        |   1 +
 .../selftests/cgroup/test_memcontrol.c        | 122 ++++++++++++++++++
 5 files changed, 175 insertions(+), 21 deletions(-)


base-commit: ba268514ea14b44570030e8ed2aef92a38679e85
-- 
2.53.0.310.g728cabbaf7-goog


