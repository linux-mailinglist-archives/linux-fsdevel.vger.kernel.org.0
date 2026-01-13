Return-Path: <linux-fsdevel+bounces-73399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 859FDD179E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 033893037296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD938B7D8;
	Tue, 13 Jan 2026 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRKCVzmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E738A9DC;
	Tue, 13 Jan 2026 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296075; cv=none; b=soiR96W+a0aBlzHtWBPHXT+NOiipRewja+tFavbgoTeQTBoBfzGWQ8fFCb4Y73Orwhiy+k3B4vILHeNIBEetBRpUc3ro42H8zbJqjKVc4kEX4SfRQLpiUf44NqB47Im7HqUSbjQp3JEJIxaumzHeTt40duloqnI8wsMjp3LVN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296075; c=relaxed/simple;
	bh=PavkAtGzRbaSgNEDLK6uow9gBM/kII3UVi2ZmzfRCT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7YjYwDICifE0OsxRsGu/Q1Zga9QxbQlK/BRr27zh9IwYzP41cmf10+VK34kfG7oL3qa8Kr3Q7hbBKxHGy0L5G3EAq05UtMHQEy8QgRYZG8tYbQkldbCiyDh3d0o+KBEGc7S86n+k11n/vXUaQGsjpinTSnoQ+cbX4GcyLjI9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRKCVzmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A3C19423;
	Tue, 13 Jan 2026 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296073;
	bh=PavkAtGzRbaSgNEDLK6uow9gBM/kII3UVi2ZmzfRCT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRKCVzmf1euGZ7ZNDRXuahc+Y+sINTE8gd69z3BGCmrlkmYJwed2sn6UiasmwhkNt
	 CsTfOZl5uROd96ps89eXXd6dFDu3d6XBm5mAalFdWBxmXLynJS5vY5rX0WSjx9x8ja
	 AhWTYzGAr50TLq+5zyB/eSzWq4MwF4iX65RC48DEtJCY+X/Ugc8pJ4fp2sYApzbXQf
	 oO5gFnFLhpLLlIXjRanKRDH1tvIUke9S1nCEf0Ar4tfvhB/IUy4ok2OK3r/dh3MAB6
	 28HvX8+DEVga+8rvMqlObER4qwKwoKH2b9ognl/ttcXrUyLGXT8ryKek1oFhkmwXmu
	 A9IIwJUssBFKw==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	containers@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/5] docs: proc: add documentation about mount restrictions
Date: Tue, 13 Jan 2026 10:20:33 +0100
Message-ID: <654e021422520a7b25df0cc8591b7643519585fa.1768295900.git.legion@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768295900.git.legion@kernel.org>
References: <20251213050639.735940-1-danilklishch@gmail.com> <cover.1768295900.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

procfs has a number of mounting restrictions that are not documented
anywhere.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 Documentation/filesystems/proc.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8256e857e2d7..c8864fcbdec7 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -52,6 +52,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
 
   4	Configuring procfs
   4.1	Mount options
+  4.2	Mount restrictions
 
   5	Filesystem behavior
 
@@ -2410,6 +2411,19 @@ will use the calling process's active pid namespace. Note that the pid
 namespace of an existing procfs instance cannot be modified (attempting to do
 so will give an `-EBUSY` error).
 
+4.2	Mount restrictions
+--------------------------
+
+If user namespaces are in use, the kernel additionally checks the instances of
+procfs available to the mounter and will not allow procfs to be mounted if:
+
+  1. This mount is not fully visible.
+
+     a. It's root directory is not the root directory of the filesystem.
+     b. If any file or non-empty procfs directory is hidden by another mount.
+
+  2. A new mount overrides the readonly option or any option from atime familty.
+
 Chapter 5: Filesystem behavior
 ==============================
 
-- 
2.52.0


