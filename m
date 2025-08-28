Return-Path: <linux-fsdevel+bounces-59567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA084B3AE2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2940B1C81675
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C552F8BCB;
	Thu, 28 Aug 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hk/iQpXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA02E54A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422496; cv=none; b=CIA1wShtKS/1ddT01Yc7oVeWrGNUKuZOlNeIKWIgZfBmlZ+9KB3JANWIaGlv3C1fFV3DYuo2P0WgmTdbIzo3O7EEFpfDQwLtmV6hUwoz3WKoyvvMfVrOj9RBJ7bfwBC9ySo82x8ToQ0ui8NzWZoVKQ3A7oNaX1mXhhbbj/TAbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422496; c=relaxed/simple;
	bh=cLnlwztLlzKbBLJlXfV6xqP3gJ6qzgUyJnq1m9rayOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ged9SnjChHu+k45VRkS+r4MakzpY1rOaBX7b1Q0gVN1zd7O1cba3yyrbnmAEH161UcYFIOSkf9ML9+uoiRu6XDxCpGdHx8Wd68CeVWiCknTukMrgSoV+76fM4VkGgLqjfpOufgS/gOoU1xTymn267aznS5W3nwHhoGJ/LoxZRu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hk/iQpXW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eFUQhPqxGB+W+sEH+++u+ncyJsTIs6I+bfRCSBVt8ms=; b=hk/iQpXWQ58lPD4d1vTDXhoess
	EUAvLNK2s/litPvmK/EV/DC3WKNHJaE0tndbssiv9YLS8Zzr5oETUK8DaujR0LdXT814DDvVzUGQh
	5bGq23yZ1x2LWmkhMaayzR1fJEooznRn7NB50/ilKOBdlJxasW/dcAhMUeSHQYrtT0uftK2nJybVC
	6qwJ1Ryqw4P3eeL9VrYjocpIjAa4KPhucvwvHgXs1QNJ9vSLl48LgCc37kmmTnz2W6de95xO2wzUI
	zjXJ0MmnkvJ9S5cLslQWXgt9Cr+ARbNoDXfqjrk1rj5fSLgAv2kfO3wJsSpRYCyylz7VLrIYrc5ce
	V9wgPWsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj1-0000000F26f-30oA;
	Thu, 28 Aug 2025 23:08:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 36/63] constify check_mnt()
Date: Fri, 29 Aug 2025 00:07:39 +0100
Message-ID: <20250828230806.3582485-36-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b77d2df606a1..de894f96d9c2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1010,7 +1010,7 @@ static void unpin_mountpoint(struct pinned_mountpoint *m)
 	}
 }
 
-static inline int check_mnt(struct mount *mnt)
+static inline int check_mnt(const struct mount *mnt)
 {
 	return mnt->mnt_ns == current->nsproxy->mnt_ns;
 }
-- 
2.47.2


