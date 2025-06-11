Return-Path: <linux-fsdevel+bounces-51378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C895AD63E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 01:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E68017E067
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 23:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BED2C325D;
	Wed, 11 Jun 2025 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C6Cj8bkW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B82063D2;
	Wed, 11 Jun 2025 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749684797; cv=none; b=t2efY9xPZZO/ml9ciS9IrJkzqHfQGYwxz9T7+SDlr8Z76HkPB/x/4j+pd3N1Nd48cyeVsn4TVILHg90virLqMKSkHrPGIyEQzLDGEpVyk3ftNitIkn/t8yHvLo1TFes5Yv7dkzHn/tt3UQtELp3R0VmgLRg/3JQAgzW5OTPtsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749684797; c=relaxed/simple;
	bh=KxDSgEHM4ioFOccU9g1WqhOEzXrb4amIpcHF7Ym5Zz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVHQEIYNRGsbh+V0wYwZ6iavU3/6hAnbMcJhdYclemGRSIh8hCTkuOT5FeuMDBl0Aai/ywKWMpEBrmhMR0OSInkYg9GrG1XwY6hMkPkg+aNhqi7uXCXzJL854fkawC0o/2TIPPq+bwDwLw+HVy6eOrSv338C4BAlPwefINwvR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=C6Cj8bkW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cet2GcpB4GwO674EqYvPDsp22UDjuD2QU2slqR1iU0o=; b=C6Cj8bkWnDXTpxo4VcCX8jFHrg
	7QRxXNhbRCpUZqIqv3/9L8FH6cqDK6ispvMtKh1h30Z5GaYMmcefM9DCEky+SHsQvbCQn4PVenYta
	q7AD2BBcnD/9mZ09Gvm4PmXRTWReVhtyVi+OfK+tMfKyVPNmvBkA/KGpwL3BalM2aKdLCy8e4gPGl
	cSUJHsfjVIGPpx5yATOVybyigEKJy2JfJ3Za8VXjN592KO9FsIVsz/u0sWD40iygXFkdMBaYWQqol
	+uT3t8+rVUNJp5CvDDkwcGOkP4lawwQ11jRlyo63u3BDi/nnyrrPVeqymlgePDJNJsBVNqgEJvUHc
	tXNOpsfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPUwM-00000007jzT-2QTq;
	Wed, 11 Jun 2025 23:33:06 +0000
Date: Thu, 12 Jun 2025 00:33:06 +0100
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
Subject: Re: [PATCH 2/2] fs/proc: take rcu_read_lock() in proc_sys_compare()
Message-ID: <20250611233306.GA1647736@ZenIV>
References: <20250611225848.1374929-1-neil@brown.name>
 <20250611225848.1374929-3-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611225848.1374929-3-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 12, 2025 at 08:57:03AM +1000, NeilBrown wrote:

> However there is no guarantee that this lock is held by d_same_name()
> (the caller of ->d_compare).  In particularly d_alloc_parallel() calls
> d_same_name() after rcu_read_unlock().

d_alloc_parallel() calls d_same_name() with dentry being pinned;
if it's positive, nothing's going to happen to its inode,
rcu_read_lock() or not.  It can go from negative to positive,
but that's it.

Why is it needed?  We do care about possibly NULL inode (basically,
when RCU dcache lookup runs into a dentry getting evicted right
under it), but that's not relevant here.

