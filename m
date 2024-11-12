Return-Path: <linux-fsdevel+bounces-34379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7229C4D60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CFD1F22E8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 03:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7F220A5D6;
	Tue, 12 Nov 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fax1j6SJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC81209666
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382558; cv=none; b=thzQ1GtOQmm+d9Z9YGdda81ZOZ+XNIi+mh20b0c5/CJRLG8YJoWzo4Bo3NiTok2k+bPX5yO2g4oaXdW3w6HpBNlLHhQfzbiswmSr4Y1sTPV4l/sWMYCDK3ldlzRGQNms3dQstCaOLh2uYhYsD8yolbIdUXL629T+FGs7p9Hk0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382558; c=relaxed/simple;
	bh=rMKVb2jYqK4+2nWP2Qbm3ywRPZNJXPBb6FTHkg8yT/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCkunkynyvQrfutdXD2JsZdCwqhnhq4L0KCpgqBi54nleW/3TGZ+wYpq69q+AuVlH+DJpEt2kT1f3kiyGoWCXnRLt+DDB8RTtI0ME2L6o8QthIwrKZs4hOepxhAGr+FKCjwRtLSctO6IGjmFgc68qRjICRGX1YPqf6HLbbEf0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fax1j6SJ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731382549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8bQ4oXcfUZgRe4pWvThGLlk+ybo3RbZlCSpCy3qXQsU=;
	b=fax1j6SJTNACLXkQBpb3O6g42X0wRkDzI0TOecd89p6RGzitDPK1BnLbevoeBAnVZshQno
	lYq/aiWcoW0Uvtvn1/CDc9ngdVsnQPgYljCKAy2unXxCS3hdM2CNCojoWAMMb2pRVukRW7
	Cf4WXt66xZEP1Z3aoqH8LyvS+8CCSJ0=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	sforshee@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: [PATCH 0/3] io path options + reflink (mild security implications)
Date: Mon, 11 Nov 2024 22:35:32 -0500
Message-ID: <20241112033539.105989-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

so, I've been fleshing out various things at the intersection of io path
options + rebalance + reflink, and this is the last little bit

background: bcachefs has io path options that can be set filesystem
wide, or per inode, and when changed rebalance automatically picks them
up and does the right thing

reflink adds a wrinkle, which is that we'd like e.g. recursively setting
the foreground/background targets on some files to move them to the
appropriate device (or nr_replicas etc.), like other data - but if a
user did a reflink copy of some other user's data and then set
nr_replicas=1, that would be bad.

so this series adds a flag to reflink pointers for "may propagate option
changes", which can then be set at remap_file_range() time based on
vfs level permission checks.

so, question for everyone: is write access to the source file what we
want? or should it be stricter, i.e. ownership matches?

then, we're currently missing mnt_idmap plumbing to remap_file_range()
to do said permissions checks - do we want to do that? or is there an
easier way?

Kent Overstreet (3):
  bcachefs: BCH_SB_VERSION_INCOMPAT
  bcachefs: bcachefs_metadata_version_reflink_p_may_update_opts
  bcachefs: Option changes now get propagated to reflinked data

 fs/bcachefs/bcachefs.h        |  2 ++
 fs/bcachefs/bcachefs_format.h | 28 +++++++++++--------
 fs/bcachefs/fs-io.c           |  9 ++++++-
 fs/bcachefs/move.c            | 51 ++++++++++++++++++++++++++++++-----
 fs/bcachefs/recovery.c        | 27 ++++++++++++++++---
 fs/bcachefs/reflink.c         | 18 ++++++++++---
 fs/bcachefs/reflink.h         |  3 ++-
 fs/bcachefs/reflink_format.h  |  2 ++
 fs/bcachefs/super-io.c        | 48 ++++++++++++++++++++++++++++++---
 fs/bcachefs/super-io.h        | 18 ++++++++++---
 10 files changed, 172 insertions(+), 34 deletions(-)

-- 
2.45.2


