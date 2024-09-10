Return-Path: <linux-fsdevel+bounces-29011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC597302D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 11:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E731C20D52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B5E14D431;
	Tue, 10 Sep 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+ksN+ZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927B17BEAE;
	Tue, 10 Sep 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962301; cv=none; b=bsqoHgxKNwRGkpWb0jclu/6HkXPzYAOhQBupDl2Umad2ALKy07ILh8xEw/oef4gY39AY184KIAk3rNJlTYWNwcn7xu2DLVxeW9PiRo51w+CTXnc+JE/Dam6Aaj2sfiLLNdpJ+sp9R4K/r4ZW/CMx61oub03p1hpO2slqi4SfTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962301; c=relaxed/simple;
	bh=AJPoBcw23VNzAXCIiEEQNEeHjlkcIqc5VzJ3ifWhQhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkPN38w/8l3cTDSY0ongdnLx0URqrzOf60MrL71LrK9ofA1/CIJB/0Z59hsrM2FHvoNzjkZwgEFjGOfXGJmW5L0bxKWY/LQs3H4qN2XMwvx1Yipisyzjp6uyHRfVQJ4eeL/0E9/1Ii0mr12zILU1pfP93sIBDRf9a2GyGANRQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+ksN+ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101CFC4CEC3;
	Tue, 10 Sep 2024 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962301;
	bh=AJPoBcw23VNzAXCIiEEQNEeHjlkcIqc5VzJ3ifWhQhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+ksN+ZWC0yH4Y/gQrj+gV4A5M7kg/gh3oHuzCRKdVcNCOrASLcq47/xGVXPlnXek
	 6PDiLq/qqE5mEDA1WlqRWdcsQwUvhlZ3iGxoPK9faFVkg4z0nIHuJ/zg1j9MTErFVM
	 lAOf5sOQDkEajzVtFjIFqwmjHgvXWiKkGyopQoP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 363/375] cifs: Fix zero_point init on inode initialisation
Date: Tue, 10 Sep 2024 11:32:40 +0200
Message-ID: <20240910092634.816997553@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 517b58c1f9242a6b4ac9443d95569dee58bf6b8b ]

Fix cifs_fattr_to_inode() such that the ->zero_point tracking variable
is initialised when the inode is initialised.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index dd0afa23734c..73e2e6c230b7 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -172,6 +172,8 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 		CIFS_I(inode)->time = 0; /* force reval */
 		return -ESTALE;
 	}
+	if (inode->i_state & I_NEW)
+		CIFS_I(inode)->netfs.zero_point = fattr->cf_eof;
 
 	cifs_revalidate_cache(inode, fattr);
 
-- 
2.43.0




