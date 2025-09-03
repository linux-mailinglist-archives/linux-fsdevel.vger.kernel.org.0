Return-Path: <linux-fsdevel+bounces-60107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740DAB41403
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44F5543ADC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478032DCF5C;
	Wed,  3 Sep 2025 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Bs5aT2lI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CC2DC32E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875354; cv=none; b=DvRyzP42w1GWiPEKHlJgAYkRpMxuIo7TBBtBN6IfwPag/zqiJreLtRvjg/85jDFn1OkdRxdf+lXcg6643dw504TVlryPQh+xX1vA9Z/vRj9jhbawlRm0MotLRk0FTDaqpva4ZDxlh4xzAq0cNK01fB17kRPXgIkaQJ4dxkS/qgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875354; c=relaxed/simple;
	bh=Pk3PB1fk46JhUtXSkrDwMqg6t15TmBG0oGN7+cRh4ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4J1l91R8FJm4QiEVieXsogo+3Kx2ti/Zu2HaxYDJoqW9NnFSoxkw+BjvbW/xDnQtlwvXhqagIxOccCf3t5nR9CEs+vliUG3kxoQs3fbkk1b8v3hxCKkiIme9EASCenrN7Anz1zDiukJopmGrrRWvkc9c1WSeeLo7kkEp384AEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Bs5aT2lI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ILXkYgH2sp0r1vLI2RkHkvHiL//Mzf762w/E4BDiMA8=; b=Bs5aT2lIWik86nanLdXMWl3as3
	MlsxZamLQpFpzB4GNORVCXZtD4oxQxBPBZ/SR9YeMs5Q3vkYbvl0wE5jJWT0HiKhTgmHwMwISYBl5
	aIeGroaVVW58rCmFHafnmzcnym7oZMgFgsit7KNeut79wdg5yP0VnaC32LYplIkCBd+UCEWxKxHUG
	iG9OhsS+/w64y3gwn7YP4w1ORRGu8+ODoAgcB9fVNN03if6o8jIV7faydbHF6flDSmCwHkq5S+yDK
	i0lOhGVDQPEpr60BALyyqH1HTZfztNhDD90mblhuLUmQ1We+OriV1X375wadHRoPRum2aezvg/aCJ
	sAHoe8zg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXD-0000000ApJM-3OWW;
	Wed, 03 Sep 2025 04:55:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 58/65] copy_mnt_ns(): use the regular mechanism for freeing empty mnt_ns on failure
Date: Wed,  3 Sep 2025 05:55:25 +0100
Message-ID: <20250903045537.2579614-64-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c175536cc7b5..0cd62478ff36 100644
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


