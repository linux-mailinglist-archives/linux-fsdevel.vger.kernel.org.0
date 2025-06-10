Return-Path: <linux-fsdevel+bounces-51121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16893AD300A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2983B53DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA4281524;
	Tue, 10 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vVgu5JDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16830215F72
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543712; cv=none; b=CFmEczieRdumkUkCmb5MubkFdnNx26h/sIFe/3HAXo17OYBcgNehGGa/e1b8VctWwHEiEihfAmhiKe+pAdLxHaa438v96DUcl0s/a5ZdCmYy4KdbUrTBCjB1OpBRL4ugS/8w0zQhlqxbrChMApaa6tPIXjmRyTj161MgAmaDqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543712; c=relaxed/simple;
	bh=d67veaL4nG6LCmT5bhf7dWODFYgQN7sInXABaWrm4QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNY6TRIMhzlqGuaYFHlRWDF7xIE64I+8A7YLvOGvs3b1CSUZeFYaUt/m2bPsDQGRJoV0JMYlR7JG1ZK3X0KHJvzc8Rvdiur0lTcuREMRp3ZYlJrkEtJsu170Ug3CTNPe1K7tjRs2z6vDr0hcatQ6HqCVUi3kwPYkCaNMbHt8I1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vVgu5JDJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N7eexFrzU4rDItJ7YDahEvV3IooeTR7HzOiRtP6PHrs=; b=vVgu5JDJyL8Dp6YiusQQ19nMGP
	CYwzMNYyco3tzMerPbcNrDPqkwwENCet8lcf5i3BKh916rAaWOco306bXqyoPAAZFn9ifNACBO68y
	T3wS5lX9nxC5OqNBQnjeH42aFXRZRI5G7SFI90L7URELpacdipihkjqFkB2yqceCyB2hY5XD7FwEx
	B0oL/VUMi+zTEG+XY83dqgA88bRyuupps2JPdH5GzCgJuJQzr65Wbixh2+aH9Fo5a1PPUbku6CxA3
	cBxHK5U/hStWye7WURzZ7WovUPlf9qrg6Yz4trDMK8c60BF1eE1X7haCh/84P3XYuXdowERln2XHY
	oBwwP6/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEv-00000004jKX-1i42;
	Tue, 10 Jun 2025 08:21:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 02/26] constify mnt_has_parent()
Date: Tue, 10 Jun 2025 09:21:24 +0100
Message-ID: <20250610082148.1127550-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mount.h b/fs/mount.h
index ad7173037924..02e5d7b34d43 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -101,7 +101,7 @@ static inline struct mount *real_mount(struct vfsmount *mnt)
 	return container_of(mnt, struct mount, mnt);
 }
 
-static inline int mnt_has_parent(struct mount *mnt)
+static inline int mnt_has_parent(const struct mount *mnt)
 {
 	return mnt != mnt->mnt_parent;
 }
-- 
2.39.5


