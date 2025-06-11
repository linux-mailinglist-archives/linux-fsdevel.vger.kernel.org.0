Return-Path: <linux-fsdevel+bounces-51379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F033AD63EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 01:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222E67A5C17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14942C326C;
	Wed, 11 Jun 2025 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SkOC0izJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820831EDA02;
	Wed, 11 Jun 2025 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749685130; cv=none; b=Tt9QRJ/L4qth7u1r7lbI8AUceaTfuoGtIsBV3WCtUyJ7bYZA2f3vVdbt+O5MW8OccMuXlS/FiHYAbkvoK2s+JaBszywaJzSrnvFHDvvjNrL3RejyfeRvF9sfdZm+kra9dG746B1Zt0ZcUTJO9J7w7MHhm7hIIjyudHMpnuK9NtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749685130; c=relaxed/simple;
	bh=uqIVC5lH/KYq5ZMQbr3eDBFaQXB3hBnr+NN6nQseTn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSJAoBJduYildjYvle/t8WIkGJGyDB1MQfdQYI3qRfx/JQsto6oP7PXsNvb/LXZN9KCc0Txaic5xdLNG/I02OrXzz25QFdAOl6vZpxwGJkHxwm/572PROlyO+Y+c91Bs9vJmSxpwYtDbOF/y+yBzR5b+mvizcxfyhvjBxIYABmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SkOC0izJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gLi4q1Pf3yDQ5vkEwYbNMTHh4i7xmaOkqjOyF6eoxyY=; b=SkOC0izJuVXFGh34DQzhYDj8zh
	QW74OV6eD0JNGnHnwPHRLcn4XY2IKgNhhCYpsjGEbqULwmSvXGMmmD03+SPscjR8dWURgpWETCk5T
	iC2NhXHfhXUW+1nAc6woomfmw1ogDuzFWOES4UBm5FPmVtLes2JL9j4EfMDxpyNsN1D8AaiX1NccH
	D4DD36XY0cEkv1fzSYaQX1Xs4XU2s/94sA+CkYvopDQA39sLvPlwJ08IVJ7XyA9guodDq0sdFCKcV
	3mjgVKeDlrVpasSeIaWn2LdNvdmRoaiJ1pFomuYxWWL59cg9c/UOSbpICGIj/z9p8y8HOBGIyITU2
	VHG2Wpxw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPV1m-00000007mdR-3qHi;
	Wed, 11 Jun 2025 23:38:42 +0000
Date: Thu, 12 Jun 2025 00:38:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
	ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change old_dir and new_dir in struct renamedata
 to dentrys
Message-ID: <20250611233842.GB1647736@ZenIV>
References: <20250611225848.1374929-1-neil@brown.name>
 <20250611225848.1374929-2-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611225848.1374929-2-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 12, 2025 at 08:57:02AM +1000, NeilBrown wrote:
> all users of 'struct renamedata' have the dentry for the old and new
> directories, and often have no use for the inode except to store it in
> the renamedata.
> 
> This patch changes struct renamedata to hold the dentry, rather than
> the inode, for the old and new directories, and changes callers to
> match.
> 
> This results in the removal of several local variables and several
> dereferences of ->d_inode at the cost of adding ->d_inode dereferences
> to vfs_rename().

Umm...  No objections, as long as overlayfs part is correct; it seems
to be, but I hadn't checked every chunk there...

