Return-Path: <linux-fsdevel+bounces-71082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F83CB415F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 22:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B54F301411C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 21:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F729BDB3;
	Wed, 10 Dec 2025 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tlVw1/mo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C9329E72;
	Wed, 10 Dec 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765403231; cv=none; b=sgOWCxSzZ0UAKoBOFcIxBM0qk7ces2p26v0WAwrk2dAjH7gfUh9a/foBowcnD1fXf3w2JSdEBSQMiitBl6/XPLb7td5ZWLVk99ZEwpEy1lrP8s/X0T6aLhqmDqOxM8LDQzUJpNHIaJmN/pFZlFL7vtIVEx0ePKuiW6bWlFPDO3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765403231; c=relaxed/simple;
	bh=Mn0QQylbwgYZgBQs1Z6Ip9GVsFBe6nxF0U9w9YzJjrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBwAmJOIHUHn+FpvdPj8oYsKbjrIRDn99T/mxqeYJrGZMa3Q0DHuRRx2cUq40nsOrBz79AMCQ28vR3EFn3YzUljUqQZsfcyaS38syhTuPYfch8Cd3V7jEj4c8J9DdGH2trZV/HcqbqCzmnTgZqW6SHgfaAKL6F3DOMaCb1hy2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tlVw1/mo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oCr3KP9P89iTxtR8p/UYhPZIvn3lJtBNdjNYl+iPC+k=; b=tlVw1/mo6orUbCZ757BfmgcgC5
	CsjI5aKcZy8nkjQ0JQTPDLwWS9TtVmyud/3m0anObSz5U+/4magoHNixXja7GvvnTSpDJwZzelcSU
	Cnf7yIJJmDq4l/Id5qL5UH61/MG0B6Y25XqRTnoOK4gPS1b9Tj7ptjAiBllY/2eDmAh0a2zIbcnfj
	/RhvZiKbpJqXOAP9cOeiw8L9Se26UKqEGP2zuHKS/QeS4XoEtHZP8DakbggIVhWx/avvW7SoghZkd
	GXWGZnInUPvfppK9Q7M1mYPkbYfOai00hq4uJ65PXoqOohexvo5nddFajc85WLVl2XhRhm8KPhwk7
	/AZfICVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vTS1y-000000083oh-0BxS;
	Wed, 10 Dec 2025 21:47:30 +0000
Date: Wed, 10 Dec 2025 21:47:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>,
	brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mark@fasheh.com, ocfs2-devel@lists.linux.dev,
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
Message-ID: <20251210214730.GC1712166@ZenIV>
References: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>
 <ff7k3zlpiueyyykotdpfcaoxn2tukceoqcbmfdwjfolndy4sen@3f5r362sg67g>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff7k3zlpiueyyykotdpfcaoxn2tukceoqcbmfdwjfolndy4sen@3f5r362sg67g>
Sender: Al Viro <viro@ftp.linux.org.uk>

#syz test
 
commit 9c7d3d572d0a67484e9cbe178184cfd9a89aa430
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed Dec 10 16:44:53 2025 -0500

    Revert "ocfs2: mark inode bad upon validation failure during read"
    
    This reverts commit 58b6fcd2ab34399258dc509f701d0986a8e0bcaa.
    
    You can't use make_bad_inode() on live inodes.

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 8340525e5589..53d649436017 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1708,8 +1708,6 @@ int ocfs2_read_inode_block_full(struct inode *inode, struct buffer_head **bh,
 	rc = ocfs2_read_blocks(INODE_CACHE(inode), OCFS2_I(inode)->ip_blkno,
 			       1, &tmp, flags, ocfs2_validate_inode_block);
 
-	if (rc < 0)
-		make_bad_inode(inode);
 	/* If ocfs2_read_blocks() got us a new bh, pass it up. */
 	if (!rc && !*bh)
 		*bh = tmp;

