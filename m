Return-Path: <linux-fsdevel+bounces-31236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87DD993542
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FCF1C22033
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA061DDC1C;
	Mon,  7 Oct 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wlLhyKNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0421DDA0B
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323043; cv=none; b=DFVbWt5b98Ije7EKvRPMXsKQHfxTI49LEBoglOb3pbZlIUk/B8Rne3JEdQanPXAjWIstM6Q873SI84jaRvHf6Jzp20DFbr/Emo4aY2+g4cpogOXjPoMRVzw8CO7HQ66I9sueeCrUgLTz5wGGaG9fXatzSzM3VGfstWgFIkqDjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323043; c=relaxed/simple;
	bh=qmfmQu1Gq8BBan0oid0dS3Y+yZJZHeJr6Hlfw6IHBZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otFx5OT6CsQ2xMiWkZDa7tKbYiKCRueahgv7Oai/8IVBb/XEjYSHf/9KlBlniydaIelrzx/x3PHLVgCunzK82UQH2v00qBjnE5kD3R1rfrtGRYmAJm457/ooXE5kY+QSY7Rb0sR7KQ19btBalMtzFP8PSKYne4p46lyeNcHUtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wlLhyKNo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9B+7mvKNqzTplwbxwy8BRSnc7c3lLHUm9Wu9OdaSG0w=; b=wlLhyKNoP8F42tkv9iZ+bUzfvi
	cZBsIkQziwFd3S5wheSiEdP/BKAj6KyVdJr5HJMiTFGoG5SDWQuFZDl88sjuKoo9ZF9SBaryps6ks
	x0rYC/0pE0I0x8NZOZ/bM69mlbpoGN8ff0daHokZQFjy5jsQQoC7rKQWL7S488t55libEyUMQi0vk
	QrkNoh2/5Lj03GB5bUp9e00mgr8qfhFEYFW6GvyFWVyUzkUqSvan0uFHJOm3il5Xd3mf0LyRsmfDN
	vIJ7lgUkWOMqih64lvIuEJjOgDZcv4KMcgRNBSh0+3PsDNf/tTwFNoHYGIjthGoy2o3J8KNN5PsUy
	0ZyRiNUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrm3-00000001f37-0Hw2;
	Mon, 07 Oct 2024 17:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH v3 03/11] close_files(): don't bother with xchg()
Date: Mon,  7 Oct 2024 18:43:50 +0100
Message-ID: <20241007174358.396114-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007174358.396114-1-viro@zeniv.linux.org.uk>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

At that point nobody else has references to the victim files_struct;
as the matter of fact, the caller will free it immediately after
close_files() returns, with no RCU delays or anything of that sort.

That's why we are not protecting against fdtable reallocation on
expansion, not cleaning the bitmaps, etc.  There's no point
zeroing the pointers in ->fd[] either, let alone make that an
atomic operation.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 991860ee7848..8770010170c5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -413,7 +413,7 @@ static struct fdtable *close_files(struct files_struct * files)
 		set = fdt->open_fds[j++];
 		while (set) {
 			if (set & 1) {
-				struct file * file = xchg(&fdt->fd[i], NULL);
+				struct file *file = fdt->fd[i];
 				if (file) {
 					filp_close(file, files);
 					cond_resched();
-- 
2.39.5


