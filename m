Return-Path: <linux-fsdevel+bounces-8353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA38334EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 14:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A0A28259F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E37FC08;
	Sat, 20 Jan 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTHsXU1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE7FBF7;
	Sat, 20 Jan 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705759070; cv=none; b=kdJqXO/F4KSjACQxdImvY6m/UxMYNSJNSUq6W7Ju/Oje3ij56xFfsGap3kgtOJS8kYaqaZjhmsVk+RYecWYZzRN9k/CCKlCcIealSMQYz49PGJXITdGtqaHrt9A+eZDLrIiIrcKA95k4ewsHwDhppF+FqlZzTe7RgRmreyGuHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705759070; c=relaxed/simple;
	bh=njgAYOxcx65hbWFTX/KkuLpHKR6dOEM5YQJjufCzuRo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIDDsDrteP4/3K3OoGerp5ZwvhlJcvuCR1oJWMtiLT+MYtJR2qU5xj7KtJz6xsvGfVpRaGroNX3uVOi2RPlDB/dghfEYjGZlxpmleLDUhxEhD0Reym8tWJJrIB02m7NVfiAX+3UsPu7kZT048er9qb2s8OMQ+M4qXShLU8nkXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTHsXU1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55ACC433F1;
	Sat, 20 Jan 2024 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705759069;
	bh=njgAYOxcx65hbWFTX/KkuLpHKR6dOEM5YQJjufCzuRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kTHsXU1H3T9yaqM8oj4clW09BxPFiahKG6My1EdJRZPvOWqlDzk+U+lMX/jBH0XDZ
	 SRjvrneEe8+r0Jq96IrQVL9m41z/iwYLx2khmtBk1IQgo+jlmba52OFXdTXQEaTStn
	 9Y3KwV87hyranBe0P+sCAIFQlpBjxLKm//fQFSQ54HrC6WKk2g8rFvffBgdegEyyJY
	 on/v2rQA88JT4Rne6sp0cgOJ3rTO4K2TUmOsBDVg4RS4WyRryOIhKeWcR+S2UwVxT+
	 EkuN8XoFFqZKkcqIZdH8CO+5/V5tiuZEtiABFAB2UyAX6SPfIofYY94FrvCOpQT4aF
	 9CWh7OHbtpFLA==
Subject: [PATCH v5 1/2] exportfs: fix the fallback implementation of the
 get_name export operation
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: trondmy@hammerspace.com, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Date: Sat, 20 Jan 2024 08:57:47 -0500
Message-ID: 
 <170575906779.22911.13338927955869627361.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170575895658.22911.11462120546862746092.stgit@klimt.1015granger.net>
References: 
 <170575895658.22911.11462120546862746092.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The fallback implementation for the get_name export operation uses
readdir() to try to match the inode number to a filename. That filename
is then used together with lookup_one() to produce a dentry.
A problem arises when we match the '.' or '..' entries, since that
causes lookup_one() to fail. This has sometimes been seen to occur for
filesystems that violate POSIX requirements around uniqueness of inode
numbers, something that is common for snapshot directories.

This patch just ensures that we skip '.' and '..' rather than allowing a
match.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/linux-nfs/CAOQ4uxiOZobN76OKB-VBNXWeFKVwLW_eK5QtthGyYzWU9mjb7Q@mail.gmail.com/
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/exportfs/expfs.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 3ae0154c5680..dcf7d86c2ce4 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -244,6 +244,16 @@ struct getdents_callback {
 	int sequence;		/* sequence counter */
 };
 
+/* Copied from lookup_one_common() */
+static inline bool is_dot_dotdot(const char *name, size_t len)
+{
+	if (unlikely(name[0] == '.')) {
+		if (len < 2 || (len == 2 && name[1] == '.'))
+			return true;
+	}
+	return false;
+}
+
 /*
  * A rather strange filldir function to capture
  * the name matching the specified inode number.
@@ -255,7 +265,7 @@ static bool filldir_one(struct dir_context *ctx, const char *name, int len,
 		container_of(ctx, struct getdents_callback, ctx);
 
 	buf->sequence++;
-	if (buf->ino == ino && len <= NAME_MAX) {
+	if (buf->ino == ino && len <= NAME_MAX && !is_dot_dotdot(name, len)) {
 		memcpy(buf->name, name, len);
 		buf->name[len] = '\0';
 		buf->found = 1;



