Return-Path: <linux-fsdevel+bounces-18276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF0C8B68F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02DA1C217DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8695A10A1E;
	Tue, 30 Apr 2024 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8aaF3B6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1612E63;
	Tue, 30 Apr 2024 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448167; cv=none; b=RBj0ZChn3vlGYXlhX6kAE1AipjSgHYcF/wdlW2iWaY3JxD8xzb+KFS8uzv1otf5pDGRGUY5BqW6PM3TAHUtMzV/QnkdbMlrwoJIyAPaWnJenzmGVW3WEr9Dw/Ls9Pe1UiQwLUBrwB1jJo5PKoMNApCSTsaPYlYU2b2HAHyMM+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448167; c=relaxed/simple;
	bh=WCpGGgLuO7lgQiaQWkkFpFeslLBF5xm7QClhWyeYNlc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2teCdbBUZFAhFRyBbJqzNKlZIjuTFRkyAVS9KD4QdZUSWOgStCv3tJr2xEU6dE+kTugUStFPH8MoaUX2yrGsv4bhAx0YE12DIwV+JsDIorj8N7lUiBcTE6Qvs4/w7mJaDZdNMP/Bb2rU5mOjzWP9JrNY9k80UVpr8mQ4bZc83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8aaF3B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03E1C116B1;
	Tue, 30 Apr 2024 03:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448166;
	bh=WCpGGgLuO7lgQiaQWkkFpFeslLBF5xm7QClhWyeYNlc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=a8aaF3B647NxYGr+v+dftcGGvMp2dTM37r5tA2L/pAla8lZOFxet24xa+EP3y9NvA
	 uYZO8ZX9TxPFPwnM1/JvMRevlnXevPKZy8B7byxU+SRUGXvquLRzKgAvZGN/LBa6Te
	 T2bjqgL3e6Q2u/HIitKJhHceLs+sTeYmFkudW/aC2+wnGLt6/MAqwczKu2dn7PcwEn
	 QcVKHHBVfVLWaehycY91LzWivsUZ+pnpI+81fR+nrE57PbqSyyw/jTHRJvVC9fUCFM
	 UAL6BJzWk465Y5PZ2+q7m0wEkSZPrvLFIViUtXTT7TfhNeNAdMnG4JPEDy+i0zxzFK
	 o91MgingZ+Z2Q==
Date: Mon, 29 Apr 2024 20:36:06 -0700
Subject: [PATCH 20/38] man: document attr_modify command
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: "Darrick J. Wong" <djwong@djwong.org>, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, fsverity@lists.linux.dev
Message-ID: <171444683418.960383.17800229768202275222.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@djwong.org>

Add some documentation for the new attr_modify command.  I'm not sure
all what this this supposed to do, but there needs to be /something/ to
satisfy the documentation tests.

Signed-off-by: Darrick J. Wong <djwong@djwong.org>
---
 man/man8/xfs_db.8 |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)


diff --git a/man/man8/xfs_db.8 b/man/man8/xfs_db.8
index 701035cb986d..2c5aed2cf38c 100644
--- a/man/man8/xfs_db.8
+++ b/man/man8/xfs_db.8
@@ -206,7 +206,45 @@ Displays the length, free block count, per-AG reservation size, and per-AG
 reservation usage for a given AG.
 If no argument is given, display information for all AGs.
 .TP
-.BI "attr_remove [\-p|\-r|\-u|\-s] [\-n] [\-N " namefile "|" name "] "
+.BI "attr_modify [\-p|\-r|\-u|\-s|\-f] [\-o n] [\-v n] [\-m n] name value
+Modifies an extended attribute on the current file with the given name.
+
+If the
+.B name
+is a string that can be converted into an integer value, it will be.
+.RS 1.0i
+.TP 0.4i
+.B \-p
+Sets the attribute in the parent namespace.
+Only one namespace option can be specified.
+.TP
+.B \-r
+Sets the attribute in the root namespace.
+Only one namespace option can be specified.
+.TP
+.B \-u
+Sets the attribute in the user namespace.
+Only one namespace option can be specified.
+.TP
+.B \-s
+Sets the attribute in the secure namespace.
+Only one namespace option can be specified.
+.TP
+.B \-f
+Sets the attribute in the verity namespace.
+Only one namespace option can be specified.
+.TP
+.B \-m
+Length of the attr name.
+.TP
+.B \-o
+Offset into the attr value to place the new contents.
+.TP
+.B \-v
+Length of the attr value.
+.RE
+.TP
+.BI "attr_remove [\-p|\-r|\-u|\-s|\-f] [\-n] [\-N " namefile "|" name "] "
 Remove the specified extended attribute from the current file.
 .RS 1.0i
 .TP 0.4i
@@ -233,7 +271,7 @@ Read the name from this file.
 Do not enable 'noattr2' mode on V4 filesystems.
 .RE
 .TP
-.BI "attr_set [\-p\-r|\-u|\-s] [\-n] [\-R|\-C] [\-v " valuelen "|\-V " valuefile "] [\-N " namefile "|" name "] "
+.BI "attr_set [\-p\-r|\-u|\-s|\-f] [\-n] [\-R|\-C] [\-v " valuelen "|\-V " valuefile "] [\-N " namefile "|" name "] "
 Sets an extended attribute on the current file with the given name.
 .RS 1.0i
 .TP 0.4i


