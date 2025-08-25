Return-Path: <linux-fsdevel+bounces-58936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B74B33586
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE893AE2AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B4284662;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U3XW4Zqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77D27F00A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097044; cv=none; b=XRXi2KVeD0JerD/sYBamdSlNeHmhlZJQIXJM3zfojydF1hDyt/NQ5SooQmDN7lmkRZxysBRA9g6/dJm3Ah8tuPFhO00CbW4KYFyQudkc23+oMlGtkWrssIkiJAms3PAH7gDht6HhYSuSe3DpXrhiiK/jWyITiKI35qKmsEvhGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097044; c=relaxed/simple;
	bh=a6ShBGM6GPXuFpZRUD5YXUg0ztuUtvovCinxmE7jzeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVlqJ8zv/fS1Nzk65WisFYWO0ikq/js72J5Zb28vVL940BHtI6AtDpXDx8OKMWNu24Fo01hl5Avjz2sqedfsVEmYREzc0ppcMvivx5yiV08CF5Q8InnoRHVWxv8Tg7EEG6IdhKMraiA2muAYu+oN04i2F+GYF3T3KXX8+bQjbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=U3XW4Zqj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ImAC068LsVtU8Y0k18wr3hJCIQqCyUdbX6Hd5qcnAzA=; b=U3XW4ZqjSxvZLfOSWzW1BkYCu2
	TOwNxdtCLWf49mL6Z/RNR5gaGM5nYLbTvL5iHFDVeWKLFP/Eti17WDHZ75yn6yB1/w3f8nRhuCaP8
	KnUfODPxb9EQAfjldrarEGem0HN78A1WO0fGAK6u4JWkhXTsZTBsW/OC2TUOJLjiCNRfVH2vEfshc
	0tOZ29ShkgGd9i0wckr0C7KtsdYAJMW7weoRFklqSvtsOqcmsev9v9QchwA8xkA8/xrwNv+zEZKWH
	dhWEZmheGwDGQ2jfGZu0XDKP3HJziJ3Egl+mE/9D20O5M7Lp7heeY8FmQqRVfFAjiUr9c0u4WlJpt
	lowohl+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3o-00000006TDw-2MoI;
	Mon, 25 Aug 2025 04:44:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 37/52] do_set_group(): constify path arguments
Date: Mon, 25 Aug 2025 05:43:40 +0100
Message-ID: <20250825044355.1541941-37-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2db9b006e37e..d61601fc97ca 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3360,7 +3360,7 @@ static inline int tree_contains_unbindable(struct mount *mnt)
 	return 0;
 }
 
-static int do_set_group(struct path *from_path, struct path *to_path)
+static int do_set_group(const struct path *from_path, const struct path *to_path)
 {
 	struct mount *from = real_mount(from_path->mnt);
 	struct mount *to = real_mount(to_path->mnt);
-- 
2.47.2


