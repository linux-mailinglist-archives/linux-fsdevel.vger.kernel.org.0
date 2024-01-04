Return-Path: <linux-fsdevel+bounces-7326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE0E823A55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9121288064
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 01:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D91C27;
	Thu,  4 Jan 2024 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="csehxxbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E201849;
	Thu,  4 Jan 2024 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z2pAVgWlAJ8tkGS/VnuzeBYZcCyen7flzxJt+0I1PG0=; b=csehxxbiUXX1KIbA9ZMsrg6t3t
	TNCSY5LykujCNzDU9sYwdoJBtpx6su8fmxy90j7Xs2qfgdVR9xVfgZLMJ0D7ph0IslBS/1yRUCrm5
	3leeJBsCIogosyQ0ui0YFC12kuIpfSgcnSPupGnuWcLxPxonHzoD5Jm8Z9faLB6Ru4cKZjJJLEc9k
	Wfpm0/YW6aNvf6vqkbzlC+aaf4iqNjRTm2LP0quWlICk2wZSceXVJ48y+RC4FleMomvlvdhdFSNZo
	B/oeZc6wHI9fvGDew9sRLEWj2DHc2lHyVkRYOwd5lZHDcX48FgyPgJJDLwHs2Sjqz9foy3syBtPrq
	8tyb3j1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rLCqb-0013HX-2t;
	Thu, 04 Jan 2024 01:48:38 +0000
Date: Thu, 4 Jan 2024 01:48:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240104014837.GO1674809@ZenIV>
References: <20240103203246.115732ec@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103203246.115732ec@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 03, 2024 at 08:32:46PM -0500, Steven Rostedt wrote:

> +	/* Get the tracefs root from the parent */
> +	inode = d_inode(dentry->d_parent);
> +	inode = d_inode(inode->i_sb->s_root);

That makes no sense.  First of all, for any positive dentry we have
dentry->d_sb == dentry->d_inode->i_sb.  And it's the same for all
dentries on given superblock.  So what's the point of that dance?
If you want the root inode, just go for d_inode(dentry->d_sb->s_root)
and be done with that...

