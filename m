Return-Path: <linux-fsdevel+bounces-14808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4200F87FBA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 11:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0472281D82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D978D7E101;
	Tue, 19 Mar 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="SAVt26NG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E24F7D40B
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843508; cv=none; b=DKZcBo9PBnfmiuK2a9B47JbKqCIauId+2KASDoF8ckeQSRMdLSsro0vv/vtgMbdQhgc/QzO1WbR7/i3O/RhyOdBHBWPgTjL8vrHC7NNOWmcM9oJ5uG3td06Nj09HnSts11oYBVOWZjkrBcwYAOmZHkaxj3Tc0OKpDJ6Kh6sZwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843508; c=relaxed/simple;
	bh=JQZMLijPAqdk/zouBBIhNjFbmM+dcBbxL2f7l4d0ge4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kMg49tKVWbUsYbrVcQA+dum0tv+hNjuTyh0wCs+4PBBnvwGy4PdMLxz5O45d8YlTunwL5s9GmphrCmbr5imYQw/IGfxtEHiYQOELi/jybhNfaeebVC7M/tfNZuSySOuqynqAgKEDtWLsq1BywJyzbxEHkz4pTbISdpqlialLp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=SAVt26NG; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id ADAA3240103
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 11:18:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710843502; bh=JQZMLijPAqdk/zouBBIhNjFbmM+dcBbxL2f7l4d0ge4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=SAVt26NGXgc5KlHubKGNBf5ptJyQZh2U/p/po/oZNe6Zm2IsZDQhm5JAgvIW3d6c8
	 UHrpxQMsPGiq4XFUwWmR4lJm7oCGbxFV5XwnIzh52BZkLspus2BYwC0jG/HGcrq+sI
	 +TxSX7j4AeUE9dP6V10kL2BPxkM25lvz2Bk7/fCMTM6T4CWG8s15pAJzisoU+L6LjI
	 AkhXG8UIRnCaBafJl0BA9GJ4AueLzruM4TpCWvPZucZP4bk0n05HlbBNATWhKF0W/u
	 GW4rncSLaCaaYUO28C3BDLxnkGjPDYNFgniPWNbWZD9FwRoCJVJyCyDvc9I5HY7cwo
	 02soYd5IXT4fg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TzSNX5hsMz6trs;
	Tue, 19 Mar 2024 11:18:20 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
Cc: asmadeus@codewreck.org,  ericvh@kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux_oss@crudebyte.com,  lucho@ionkov.net,
  syzkaller-bugs@googlegroups.com,  v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
In-Reply-To: <0000000000002750950613c53e72@google.com> (syzbot's message of
	"Sat, 16 Mar 2024 04:15:32 -0700")
References: <0000000000002750950613c53e72@google.com>
Date: Tue, 19 Mar 2024 10:18:19 +0000
Message-ID: <m27chy8qz8.fsf@Charalamposs-MacBook-Pro.local.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


please test uv in v9fs_evict_inode

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..5d046f63e5fa 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,8 @@ void v9fs_evict_inode(struct inode *inode)
 	filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+	if (v9fs_inode_cookie(v9inode))
+		fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
 }
 

