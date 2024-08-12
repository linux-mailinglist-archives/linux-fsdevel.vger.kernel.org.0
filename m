Return-Path: <linux-fsdevel+bounces-25635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A430F94E700
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E471C21CF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF641537D6;
	Mon, 12 Aug 2024 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lbr55Pss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487814D42C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445070; cv=none; b=LpQ0dtEiOyKr1bAhAbbeAbDwJibL1fWrwJg0Djp8WdsHIhOHINm7KGe4o1gcn8efIZk69qprVj3Mw0aDDRWyzfiKTMr8lZbz6kEivDsiOhum/kKVz2eieMPi3d6+cSZEUFNgI9uenGjm86tG6UqkgtIo1JvNcYnnzHK/44suTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445070; c=relaxed/simple;
	bh=W4i8DrNlAD+0853nsB7Tg7xS6Y36waP1iK/++G3HTnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMhkR9s/V1B4S82Svh83t9SCfWRI9B0zLGy6NbeFb/mITmNBvILGn3SOOZRLlrXh0TMevsrNpmSe9j6FTIwdEKI2VJQDZnHFRldUw7IC+S8o4gVNjnOWAvRdA+MRLIalK6HhrjP3iL4Vw6gofFvzSjgswoBBbeClBEEtCxANBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lbr55Pss; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9FaAMy0SP7shTdetxWl6ggiRlTf8l5arjYn+o56LbKk=; b=lbr55Pssv5zRvu/kmLyG7md0NF
	YYeit1A29oOk0H4F4ueGQS7D43JpyV5SN1zwUbL7WAg6oQOrNfDdYpkZRJa57XZTEEtJGaT6O1+HO
	WM48hIFLqlPUUWAwQMhAgm9yLsORdaWqxdzLkdDfGqrHT2xFr5+XiJzEIZ7DbQxyGOyhG2UBtQNAW
	lHH0kU7FoGMUkuqAKCEHy/vi2O3ViYCXEP6ROL7JQXUu6kMBuj6Vw0tbhkTf8e5hev2R4XQB66TzU
	gggluHJetHDlUaeGIXAO+g2ABViA25rQ67rY8bf2coU5Xjb/S6Rx9ATtnYst24D+6Vr74FoiwU9pe
	7knNI5CA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn5-000000010UI-2vy1;
	Mon, 12 Aug 2024 06:44:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/11] close_files(): don't bother with xchg()
Date: Mon, 12 Aug 2024 07:44:19 +0100
Message-ID: <20240812064427.240190-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812064427.240190-1-viro@zeniv.linux.org.uk>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
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
index ac9e04e97e4b..313cfb860941 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -428,7 +428,7 @@ static struct fdtable *close_files(struct files_struct * files)
 		set = fdt->open_fds[j++];
 		while (set) {
 			if (set & 1) {
-				struct file * file = xchg(&fdt->fd[i], NULL);
+				struct file *file = fdt->fd[i];
 				if (file) {
 					filp_close(file, files);
 					cond_resched();
-- 
2.39.2


