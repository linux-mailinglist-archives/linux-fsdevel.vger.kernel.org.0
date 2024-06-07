Return-Path: <linux-fsdevel+bounces-21233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665C9007F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E48B255B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC7195F23;
	Fri,  7 Jun 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWRu2Hof"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9619597A
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772152; cv=none; b=jNWk0PsR7eqKOMWv8boDyF84Z3wvk/YGuPMeExhGXFwMXGOVN7S4dkflFkUhGc+Rh9M6rdCfzoge1nw5/xuTXX6KCwTNXu8xnjVdIZW2hObeVnBI6cQxEL45YWM88xt5rQ+ucJaSZSlN3BXbHq9hSkE9+FI7krlhqp7Gf9Xg3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772152; c=relaxed/simple;
	bh=G4aCjlE9IURpGJUOsHo59OqgM8YXyQZbszF0JFvPHMg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q6BUXit4SaDmwEEcmQJirGRTm1RPVyCtpsCScbElqZRi0BiAxdMYPrlivrpN+baNmeJxqxEHOG6Eytz+9KZZzY7ZQDu4uwvUZulAwDnAy9CjrHApSeAsaWAIP3VdwczrxsRwfe7MsyeRf6ymOP82K6TXE/6Umcdzect0xuUzQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWRu2Hof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADF1C2BBFC;
	Fri,  7 Jun 2024 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772152;
	bh=G4aCjlE9IURpGJUOsHo59OqgM8YXyQZbszF0JFvPHMg=;
	h=From:Subject:Date:To:Cc:From;
	b=EWRu2Hofno07qH4OY3igqLae8G4yFsqXTuLPQFQKbqEQMENhuGcq2qA/qZzeQyVb7
	 Q2efIkJMy2QOtnlPtyHMksBkhd6mCRRkAjSl30itiLTlLrvC1UvtFXkGkda5x2azdh
	 v/SJjv0b2mYbljAMw+YgMnNKOLfdZcYerlo+JpbuzlsAlBSgI5D/2TQiMWsoe5aJoM
	 Xxlcjuhl6Hhn3aZ9T238H1cOC7JOL4mwGH07TP7/9oy86vFf1DIdyDYiilWouIbHsJ
	 Fa34WXnXknOQGmfdAHpwXEK0Lx49++69nfjedVw2arbG5ep+X9reO/4iE6gwduflW/
	 PwZBEKHt/fkhA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/4] fs: allow listmount() with reversed ordering
Date: Fri, 07 Jun 2024 16:55:33 +0200
Message-Id: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGUfY2YC/z3M0QrCMAyF4VcZuTajlqrDV5FddGvqAtpJMocw9
 u7LRLz84ZxvASVhUrhWCwjNrDwWi+Ohgn6I5U7IyRq888Gd3QXnrPhgnZ7ju0xoFxIldPmUQmp
 8aIjAvi+hzJ+ve2utu2ijTmLph10zpP4j9Q+Bdd0AQLcTZY8AAAA=
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14-dev-2ee9f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G4aCjlE9IURpGJUOsHo59OqgM8YXyQZbszF0JFvPHMg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQly5cZ9WXO2fyL02Xq2bcnRAvmT4tWFlwdqMzwybBf3
 VjL+3xVRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETOljEyvPp7Ylb7KanO2piz
 X5r15rbucY6wfLTLLjb9UKzN6pgbsQz/HeJi7TZMnyyddlB29cEOTpHp547nP40znl9Z66cjtJ+
 LHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

util-linux is about to implement listmount() and statmount() support.
Karel requested the ability to scan the mount table in backwards order
because that's what libmount currently does in order to get the latest
mount first. We currently don't support this in listmount(). Add a new
LISTMOUNT_RESERVE flag to allow listing mounts in reverse order. For
example, listing all child mounts of /sys without LISTMOUNT_REVERSE
gives:

    /sys/kernel/security @ mnt_id: 4294968369
    /sys/fs/cgroup @ mnt_id: 4294968370
    /sys/firmware/efi/efivars @ mnt_id: 4294968371
    /sys/fs/bpf @ mnt_id: 4294968372
    /sys/kernel/tracing @ mnt_id: 4294968373
    /sys/kernel/debug @ mnt_id: 4294968374
    /sys/fs/fuse/connections @ mnt_id: 4294968375
    /sys/kernel/config @ mnt_id: 4294968376

whereas with LISTMOUNT_RESERVE it gives:

    /sys/kernel/config @ mnt_id: 4294968376
    /sys/fs/fuse/connections @ mnt_id: 4294968375
    /sys/kernel/debug @ mnt_id: 4294968374
    /sys/kernel/tracing @ mnt_id: 4294968373
    /sys/fs/bpf @ mnt_id: 4294968372
    /sys/firmware/efi/efivars @ mnt_id: 4294968371
    /sys/fs/cgroup @ mnt_id: 4294968370
    /sys/kernel/security @ mnt_id: 4294968369

A few smaller cleanups included in this series.

---
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240607-vfs-listmount-reverse-0f5d4d8248ee


