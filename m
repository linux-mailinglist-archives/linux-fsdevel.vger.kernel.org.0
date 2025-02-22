Return-Path: <linux-fsdevel+bounces-42328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ABBA40570
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 05:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75DB427B93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 04:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7D720126B;
	Sat, 22 Feb 2025 04:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EHqfOfLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B332BA2D;
	Sat, 22 Feb 2025 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740197995; cv=none; b=LJGNvWI/k5IwIJXuRr2Nh7qfoMqhOfFj045qawniC54GvugHlibmIX1WnBHPiBVp5jnpm+hB2OC2x5yaKmeR3N4Hu4/qpMylJj60Noz+gm/xMD5HAKxVqznjS3SvV3uSjpw3IYmyJNjoXlTGKXZQ3yZOz+6k2wfuYmWhXhhdl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740197995; c=relaxed/simple;
	bh=tDY2pKsOd6hg0JuSzXsPAMcbWXEcTNcauXlC6e+36dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK2ZivlaUVzKqAbvcEWF2U2H8WV/ur5SOHrt4/gViMG42t6B5TDnuB8tPoHrxgsIvHv/AZEWzA61mPWGPRPWyKAhwUKOxUlFZ+GradV9GEJs0kwNBKRLUQJWqYGJ9vAaCp4mnyL2/1s4DXkCCKo8N95lSloGJYo+kzgvyJZ3CL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EHqfOfLP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qfUBrmsjEzlreUx4AXwJcqcuev0D4ASn1NvBbAj8CU0=; b=EHqfOfLP9VxWQT6m6l+8Kqb+8D
	Y/KlagZgn9RkQHu9FwnQ5H6MelwTA+wmY44O9vuFq41lY+jB0bC36GC1iMXRJBRN5nrcgug2Pki70
	kISTP+dD1MJozKroh0sH6AxxkYUketYRci+k66PXl7v7R/q58wlNyzcJeLqL7zbuhIYXf/csxKnN4
	VH5IkAClhhCxx5OMw2kXfDGs5prmq+kxor8YRBDndqLLzqeUYg4jelxYLnkQLVnHuc/ktsHneeuWG
	goVu6wB/tCfwmkMw8ROOkrtvNgMawXX1O5CyNh8VqurD56b+GRJheL0VZa2hI9FdXXK90vEbfwK6c
	uN4g9LKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlgzJ-00000004dod-0CaC;
	Sat, 22 Feb 2025 04:19:37 +0000
Date: Sat, 22 Feb 2025 04:19:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <20250222041937.GM1977892@ZenIV>
References: <20250220234630.983190-1-neilb@suse.de>
 <20250220234630.983190-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220234630.983190-2-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:

> +In general, filesystems which use d_instantiate_new() to install the new
> +inode can safely return NULL.  Filesystems which may not have an I_NEW inode
> +should use d_drop();d_splice_alias() and return the result of the latter.

IMO that's a bad pattern, _especially_ if you want to go for "in-update"
kind of stuff later.

That's pretty much the same thing as d_drop()/d_rehash() window.

We'd be better off dropping that BUG_ON() in d_splice_alias() and teaching
__d_add() to handle the "it's a hashed negative" case.

