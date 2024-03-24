Return-Path: <linux-fsdevel+bounces-15170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA3887BC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 06:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B141F21503
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 05:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27831426F;
	Sun, 24 Mar 2024 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FR1efPh+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FC1A38FF;
	Sun, 24 Mar 2024 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711259205; cv=none; b=buCWaf0BXw7U5AEP8/RuSH66g4MUKlJEfpX0kSB6lZnu375QFnE7pXLrmaCY5CSLUlirMGP/sXSrMKaHcu0tuq6+kS1mt8qwaZdbMldAdRHTneYy3zqzijSSi06i9Q621FtCS3jInSGVqIOzWQrNb8hUQeUULmDPgaVGXNAZtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711259205; c=relaxed/simple;
	bh=ZdMk2+QQU6WaQaTZwwrBGsmbnw7raeC1F7UhsPN3KUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3fpTJEIX4LBZaMRLQDI2Z2qcFwJA7cp59g/yTA3M/VhrkUSTQLOSiErV+DVMGS13BSDrUCOBoFW7bwgVO033iEfXiWehmcaJhsceJQrayvym0pcmPSSM4Xqy2qoNfFdQfgU2d8nKgYkETsW59RWwF0exPw4ERtsZ4gBBQCw51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FR1efPh+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O8CCWKw9gWzyR41X6fBvNpozhoGEljQYmnOirFrjEsQ=; b=FR1efPh+v2DmePoy0goXs9XQI7
	8/BNKVhBbYAnStkIPwQcGtPi9npwvkqkXEcsJ+amOp0iFTcwZ+HZjEhNreE8CxcU9Yz9OCLORp8sn
	LgiT7wwpw9ultvHUIWAIbvHPOMB53L5PjK2lNZz7dZUNA32F6vfb5Muq1fvVJvHKyM5iJvXra5TD7
	9igi9CRPD7l01+9/A7KK8dCYHYn2HhGPMayig6f4M8Wpr2n0pIFnd6xgw2k0vtKOQdf/QKtODkvat
	BddQMcrAxcOnb73mvP2F03P/PETJCmJ2XcCjeDzfDTqa1qVHWLDJRZSeaPn2x5bDU4AzWsJ7CEROc
	6gK0EnKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1roGgm-00Fd0I-38;
	Sun, 24 Mar 2024 05:46:37 +0000
Date: Sun, 24 Mar 2024 05:46:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steve French <smfrench@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	CIFS <linux-cifs@vger.kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: kernel crash in mknod
Message-ID: <20240324054636.GT538574@ZenIV>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Mar 24, 2024 at 12:00:15AM -0500, Steve French wrote:
> Anyone else seeing this kernel crash in do_mknodat (I see it with a
> simple "mkfifo" on smb3 mount).  I started seeing this in 6.9-rc (did
> not see it in 6.8).   I did not see it with the 3/12/23 mainline
> (early in the 6.9-rc merge Window) but I do see it in the 3/22 build
> so it looks like the regression was introduced by:

	FWIW, successful ->mknod() is allowed to return 0 and unhash
dentry, rather than bothering with lookups.  So commit in question
is bogus - lack of error does *NOT* mean that you have struct inode
existing, let alone attached to dentry.  That kind of behaviour
used to be common for network filesystems more than just for ->mknod(),
the theory being "if somebody wants to look at it, they can bloody
well pay the cost of lookup after dcache miss".

Said that, the language in D/f/vfs.rst is vague as hell and is very easy
to misread in direction of "you must instantiate".

Thankfully, there's no counterpart with mkdir - *there* it's not just
possible, it's inevitable in some cases for e.g. nfs.

What the hell is that hook doing in non-S_IFREG cases, anyway?  Move it
up and be done with it...

diff --git a/fs/namei.c b/fs/namei.c
index ceb9ddf8dfdd..821fe0e3f171 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4050,6 +4050,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 		case 0: case S_IFREG:
 			error = vfs_create(idmap, path.dentry->d_inode,
 					   dentry, mode, true);
+			if (!error)
+				error = security_path_post_mknod(idmap, dentry);
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
@@ -4061,10 +4063,6 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 			break;
 	}
 
-	if (error)
-		goto out2;
-
-	security_path_post_mknod(idmap, dentry);
 out2:
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {

