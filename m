Return-Path: <linux-fsdevel+bounces-70090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8DBC906ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D588350DD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC82214812;
	Fri, 28 Nov 2025 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0VuyIM0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CC20FAB2
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764289727; cv=none; b=Ffy0+vtoF6+btGK1WoMY37BNx4T2pual7dwqmoWrQl/yACzJ5edap3r5Jl+fA5ngJ52clC0IwVSSUJteVT5ETLWyysJo9T6dP/jw0bH5H6B4+RuzReY3ykfaPq1kgtaKwLH5EJGEkytKZA6u2TfxS2rufZdZGM64nU/dolA02NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764289727; c=relaxed/simple;
	bh=NrC8Jsx+JD5HTvP7Uo3oMEGs4MLFuHiBnlbiezoPIb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rh2XxS+7oMLYn+P93wn9lPdLG72NenBhAxYNy0MIaJ7YKr4+5gNgg11cNgpVuJBsrnh7dgEJuHrOXmXXrUcMx/5mqIAoLFeWLhSQu1sCr57xqiXrJy3OJzmJL7GGi7e4gZ15lWbOFTYRAtdV/SnAf35P1tuvNL1HwfSvRUmNeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0VuyIM0M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0L51b+nKkUZ3xMlJQYaif52xOw7sfN/Rv7oaSTrAfIs=; b=0VuyIM0M6gZsEw9OLPYL7HuKji
	J4xjbiHJGc8LA3Jytmff/MQGYAljRwUvGEmo6+AMUk4/PkjaWRJpOFCIStkPhEbQTn8qRoMNvZyME
	hu14jYvCKLYI2A0PaH40gx3nLculrm3zCzk171J+de8kywMP3YAmw293bAAXbLL+19Z9VN9N05Bh8
	SnXggbUQNLzNhz+rd3gLw1aH5Zi5gY1S7ZbvASIsCdhIt49aLsgb0XAUTqDuiq0+xK9FLlewMxwVl
	GQlkDmPNXPU3l4ucyl0v5da/dLk7GS1eXnDDv6GKAgXSccPZAHuQMUcxM+xfbIFD4gCescZXH9ePV
	1rYs3oJQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOmLp-0000000HLbo-3tjp;
	Fri, 28 Nov 2025 00:28:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neil@brown.name>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] VFS: namei: fix __start_dirop() kernel-doc warnings
Date: Thu, 27 Nov 2025 16:28:41 -0800
Message-ID: <20251128002841.487891-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function name and add description for the @state
parameter to avoid these kernel-doc warnings:

Warning: fs/namei.c:2853 function parameter 'state' not described
 in '__start_dirop'
WARNING: fs/namei.c:2853 expecting prototype for start_dirop().
 Prototype was for __start_dirop() instead

Fixes: ff7c4ea11a05 ("VFS: add start_creating_killable() and start_removing_killable()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
---
 fs/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20251127.orig/fs/namei.c
+++ linux-next-20251127/fs/namei.c
@@ -2836,10 +2836,11 @@ static int filename_parentat(int dfd, st
 }
 
 /**
- * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * __start_dirop - begin a create or remove dirop, performing locking and lookup
  * @parent:       the dentry of the parent in which the operation will occur
  * @name:         a qstr holding the name within that parent
  * @lookup_flags: intent and other lookup flags.
+ * @state:        target task state
  *
  * The lookup is performed and necessary locks are taken so that, on success,
  * the returned dentry can be operated on safely.

