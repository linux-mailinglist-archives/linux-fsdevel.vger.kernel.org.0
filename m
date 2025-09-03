Return-Path: <linux-fsdevel+bounces-60104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EFFB41402
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026E56818E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6ED2DAFD8;
	Wed,  3 Sep 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VCYfazEF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703762D8DB5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875354; cv=none; b=nXVraCWVleU1pHQKf6iQhV3eKk/rDNO7HDalKVFhVWEU9e/xomrPzjUrQkYC1SI8jRsyXGYW6qdizOWE+rfMcF1j7fUDP+PjMAiqzbv8Y1BytFwNqMg9uiTaXM8UCWCpF1qqWXJEhh4O1qr95HSWtQ+2Kft9ObZPh4Ff0RuJfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875354; c=relaxed/simple;
	bh=AjVeoBdLmkD9+TURXtWATV29zyTwhukqUTTEwCO1/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUCyhs3rBtJEK72nbjAC8z7JZTg2FpMwDZhoHDsuM06oI+MJ4kcJmwaKgpSJse0fx7RekzrCXc6rGa0AykDKCRsjUyS+NXLy3oO0R8bNZ1s7D21I9Cx7/bDg3xlgR+xiMIBiTe2PG2uKIpSt+76POh7+Hm/koWrXL6hJQMsw7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VCYfazEF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hcW2+ZkpUNXHa//jzUf98RzmEsM5GtIPK9Nt4xuTHbU=; b=VCYfazEFK1Fy85oLQZacrcXWHZ
	GW/PfjuHc1S7PIphVXCib7ej0qXVQyL39ZrLWHMOGaJTrbEHh+XXUShKBvy72sJxPklf8KfMXdD1Z
	vYalyboWvtE5gZmvMXwYQp0VEQAN67/rVvTYJ7hIxp6d3GbDwncwXD9DBpi390syzW1qOzqkJtXtY
	5+4d26GuXJ8KEN2AkjhP4pryj11iY4VS4drXfSmrdti5jYpRHvRqEvgGz7qeDn6FyMqMdGUvUMqzy
	87X6f4NLX4yvFaTGsfX7Kj1+Y170VYzGO8I75JmudcLqN19RrJEGXlOKK/6QUqv47N+z+L9Uzj1TX
	EsnfPejw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXC-0000000ApIN-44Q8;
	Wed, 03 Sep 2025 04:55:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 57/63] copy_mnt_ns(): use the regular mechanism for freeing empty mnt_ns on failure
Date: Wed,  3 Sep 2025 05:55:22 +0100
Message-ID: <20250903045537.2579614-61-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Now that free_mnt_ns() works prior to mnt_ns_tree_add(), there's no need for
an open-coded analogue free_mnt_ns() there - yes, we do avoid one call_rcu()
use per failing call of clone() or unshare(), if they fail due to OOM in that
particular spot, but it's not really worth bothering.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index daa72292ea58..a418555586ef 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4190,10 +4190,8 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		copy_flags |= CL_SLAVE;
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
+		emptied_ns = new_ns;
 		namespace_unlock();
-		ns_free_inum(&new_ns->ns);
-		dec_mnt_namespaces(new_ns->ucounts);
-		mnt_ns_release(new_ns);
 		return ERR_CAST(new);
 	}
 	if (user_ns != ns->user_ns) {
-- 
2.47.2


