Return-Path: <linux-fsdevel+bounces-51675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2500ADA068
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 02:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018583B6193
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 00:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8872117BA6;
	Sun, 15 Jun 2025 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MqYF6rKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0835223
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749947540; cv=none; b=poLvhN6Ucb2G9C/V+inHOMniRz2jEReAc6nNDnxuR7nQOAjJUBdQO1RFWVu9n6P4WK8moOAsi22UdXD6BYaI0BGqVMlWieNfmikc2aXm1Vk2wfOb9ZvohKj4RAO8fn+CoFzYKFSSDWmMPpAK+pfUkdy6tRg7CtdYmDnwuJrwb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749947540; c=relaxed/simple;
	bh=urX3TmT2vfjpMO1bQyvB+2hyEA+JzIhFGQh8xkEnNDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCzL+dzanNMvmwqO9PqeDg8Dgix8YkvZCYC/roydb96uTUL1htZ5zt7QmoZQTrMLvUVzjG/NqnFdOTprWQD5u+lxEmxLJsBt4iLDXc49yLVg9FvdArxshH3T7AG+ItBvsnetX8CiIaFuVcq7SEkui4qQNenZmUsurTGBP9OgJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MqYF6rKz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=au+/j+IKd03GMYfN6RUjAJgxK2b6znpp5MY3ElFLVSQ=; b=MqYF6rKzr8aX4fy8hFBAfOULbP
	njtKJAFg9GVSd43L24DN5jTAiZZMOU4umuKkDUjIJaNBurSp6eobWV6e0R+P1znQ8AeqMXOlborTU
	ErnDF9neHk2bDLUcOQ9YXguLWf/newrP10o2VwcCf0uR1Z+nBsDC7aQC7GZeicOlvgbevSlqDAqx+
	HOS5JNd6DaT6tV/PUiaMe+I9fsFbkq2jJXIDb0OpGJcINvt95uTTcrlXk7kxw3y53Bj9Hf4Kctkf8
	L/afaWL5y6a3TYNNLQw0VHKhOccx65351yjKJFXCYhmTEr9d6oSy5HkwSnIS9tfa2dJbWCw3ZoaD1
	zw3h4p3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQbIG-0000000CeVo-3OQ0;
	Sun, 15 Jun 2025 00:32:16 +0000
Date: Sun, 15 Jun 2025 01:32:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH] don't duplicate vfs_open() in kernel_file_open()
Message-ID: <20250615003216.GB3011112@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615003110.GA3011112@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[don't really care which tree that goes through; right now it's
in viro/vfs.git #work.misc, but if somebody prefers to grab it
through a different tree, just say so]
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/open.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 7828234a7caa..b29d1e077164 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1204,14 +1204,11 @@ struct file *kernel_file_open(const struct path *path, int flags,
 	if (IS_ERR(f))
 		return f;
 
-	f->f_path = *path;
-	error = do_dentry_open(f, NULL);
+	error = vfs_open(path, f);
 	if (error) {
 		fput(f);
 		return ERR_PTR(error);
 	}
-
-	fsnotify_open(f);
 	return f;
 }
 EXPORT_SYMBOL_GPL(kernel_file_open);
-- 
2.39.5


