Return-Path: <linux-fsdevel+bounces-60738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B6B50F97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D34E4875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0A23372C;
	Wed, 10 Sep 2025 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VLKVDt9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749330BF60;
	Wed, 10 Sep 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489836; cv=none; b=TXn7wJKuqBJSe6iPdOIbPPi6HRJJDcSl7eyDz4vZu2UHJgvwuyVowCvNA1o20yfMBVDU+FU4koGeXgav8sDErxnQj58yamsUtRRvldrfrSPVyUeTeGUcW6P59xaX134fKTWTfksPt0jGJC3ih0AZjWdQo6Y6bjdP8IFaFQIRp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489836; c=relaxed/simple;
	bh=bs5XQ7nxtzLKoIMy8Rf84HQaQKxz0EWAJenw1ZhSdHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4/o7TaJSYpX1bKhUIjRmnvGYH8R4nfF3t0Ri1/8VNDmWsoWWKwXAAnh5oR0YS5H0E0DvoA6kiCAGsv4TWIy0II+vie4ZQ/ETIA74IZ2356tIyQPM0yIIsGhu3yXA+Ft1JfWNdvydjvnP305faNnU8QNT4qeerGBwpCl+dALC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VLKVDt9y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fUNE/dmP1NHr/HEOexZTO49AD62nMtgceTpySJX3ABM=; b=VLKVDt9yA81zNNdaO21PD7kFbY
	WMllnLFKAMps719frCoEdGMNHYYMBPzW1euVMWvTxcrBIKe7BWINeCKvfRNWtOgMjS8iLUjGIsqAO
	mtwMRdwtcxMupdHeeT6jTNdtEE88kn/eg2xGgxxvGRfWpllpXr6HtrjFYt7KvkWIqeBUdwlfJsXcZ
	Fre3kb90UJ0S/cSJ1yWvU7yLlTZDuurHY/AWsFySyVbsY8wA29CB/laiPAHhtOqP9TDVyTZp4OAQ/
	CrOqSEHLvjWFKdr8JtVejHH/qGU/cVQIk7ujwhjZsjPiEPdsIKku/+7vEtl60hKf37M+e8zDCWjJM
	oLMu3QMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwFOB-0000000GWGS-3EFd;
	Wed, 10 Sep 2025 07:37:11 +0000
Date: Wed, 10 Sep 2025 08:37:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Use simple_start_creating() in various places.
Message-ID: <20250910073711.GS31600@ZenIV>
References: <>
 <20250909081949.GM31600@ZenIV>
 <175747330917.2850467.10031339002768914482@noble.neil.brown.name>
 <20250910041249.GP31600@ZenIV>
 <20250910041658.GQ31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910041658.GQ31600@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

> ... and see viro/vfs.git#work.persistency for the part of the queue that
> had order already settled down (I'm reshuffling the tail at the moment;
> hypfs commit is still in the leftovers pile - the whole thing used to
> have a really messy topology, with most of the prep work that used to
> be the cause of that topology already in mainline - e.g. rpc_pipefs
> series, securityfs one, etc.)

Speaking of which, nfsctl series contains the following and I'd like to
make sure that behaviour being fixed there *is* just an accident...
Could nfsd folks comment?

[PATCH] nfsctl: don't bump st_nlink of directory when creating a symlink in it
    
apparently blindly copied from mkdir...
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index bc6b776fc657..282b961d8788 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1181,7 +1181,6 @@ static int __nfsd_symlink(struct inode *dir, struct dentry *dentry,
 	inode->i_size = strlen(content);
 
 	d_add(dentry, inode);
-	inc_nlink(dir);
 	fsnotify_create(dir, dentry);
 	return 0;
 }

