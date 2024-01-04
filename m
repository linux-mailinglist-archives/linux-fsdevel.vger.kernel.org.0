Return-Path: <linux-fsdevel+bounces-7332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBCD823A6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC071C24B9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 01:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D81C27;
	Thu,  4 Jan 2024 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J8l+VDcL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B66184F;
	Thu,  4 Jan 2024 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=50vnkKqSI2ElofoXuNRHthO0fhpyNkEcJnzn+Vbbcqw=; b=J8l+VDcLQvSxw0Q3MJiAc8inTQ
	761LSOKKg5XjajP92QGlxT5f7n+nFoxCPNG3i0F4MDluSFy6WI757sNzY7Ud1fHFlTs7SAm9LjMbd
	dNwCUOhDvakGnnXJbxrDhNyf22tJOS96Li48c0YZAnDwL6CosLkeS9b+bl3tHQES3O1bwy70zjyAt
	G7Q6M2Ys4L54CFIK5C6UsydMpCAIzn1yNE1kXZdcSOuiHPs83eM+5zsSSHf9tuWz4lUJqfmEaBHT8
	evNYVPABm/iKjnBIBZPlul/tpU9JYaAvGmnEVnXKvqHYmOB94DHZumTDnMCDbNnvHAApzwR9uFqBZ
	gSl9xHqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rLD0o-0013z7-0o;
	Thu, 04 Jan 2024 01:59:10 +0000
Date: Thu, 4 Jan 2024 01:59:10 +0000
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
Message-ID: <20240104015910.GP1674809@ZenIV>
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

> +static struct inode *instance_inode(struct dentry *parent, struct inode *inode)
> +{
> +	struct tracefs_inode *ti;
> +	struct inode *root_inode;
> +
> +	root_inode = d_inode(inode->i_sb->s_root);
> +
> +	/* If parent is NULL then use root inode */
> +	if (!parent)
> +		return root_inode;
> +
> +	/* Find the inode that is flagged as an instance or the root inode */
> +	do {
> +		inode = d_inode(parent);
> +		if (inode == root_inode)
> +			return root_inode;
> +
> +		ti = get_tracefs(inode);
> +
> +		if (ti->flags & TRACEFS_INSTANCE_INODE)
> +			return inode;
> +	} while ((parent = parent->d_parent));

*blink*

This is equivalent to
		...
		parent = parent->d_parent;
	} while (true);

->d_parent is *never* NULL.  And what the hell is that loop supposed to do,
anyway?  Find the nearest ancestor tagged with TRACEFS_INSTANCE_INODE?

If root is not marked that way, I would suggest
	if (!parent)
		parent = inode->i_sb->s_root;
	while (!IS_ROOT(parent)) {
		struct tracefs_inode *ti = get_tracefs(parent->d_inode);
		if (ti->flags & TRACEFS_INSTANCE_INODE)
			break;
		parent = parent->d_parent;
	}
	return parent->d_inode;

