Return-Path: <linux-fsdevel+bounces-42331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F6A4058F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 05:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81841748F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 04:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF54B201259;
	Sat, 22 Feb 2025 04:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ISd9hrzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4913B58A;
	Sat, 22 Feb 2025 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740200207; cv=none; b=t7lUtyjP76gYDZMuTo/KHrn7IduCGplWxrTIJtAMYLcMggtxTKguOVVMUbdDUzuUBqlwafQWyQ0BRJv3VHCuk401SD0dbNVxH84jY17zpNQP8XGmSdONQ4rh0o2qdJcvnwOHjBXQrpq8zae4r8mwNzzoTiOZC3OksY2C+eQG42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740200207; c=relaxed/simple;
	bh=OOhrnSxoUgAKIMfjUUYFxd8ZK7oaj2BSOj8MQe2HJMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL/+dQkkHkZal+T9Myp5/VQ5AcNvQw8Ekij62lhzlLgTW3BSa0FmhWrL3HgsmqMcfZXgpe9RszX706UaiUd34MMQ0/yH9O69GQmIOebhkrISeCOpb6GshrNd7WZTHcNjUNKXd9p8YAvWgJCsfibB4Ls9TWDsE0dU4OvpBdhP87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ISd9hrzW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zK7Q2y4vb1Jl3/aS9MBSQWpnKf9/zrIOVxSewBZmwJg=; b=ISd9hrzWXrpL02sSPfl5grZm4N
	OJp0CAQv3yrKxnknEU7KGWDEVMlTfLGAtrH3qw+7n30pO5S0/ir++dmGoijujkkuoeIhyYF4X04sC
	UfdOwtYU5OilalGsqgrlhMFSWVxYOe09PBjkEoTCNy5e6n8eg0LtzKdhowS+D54SNwoua8/7LiWES
	eVmuM1YDiKrq8ZOlavxoxJ6xVZHIMonVRSWxz8A27L07vH+9cX1tFY16dhoRpHNc6BHQ6ScGmHA7O
	Yhd427npxUuD2zEax0QZsBpKkEzual4Xm7dvjxqFovlmK4Pi0pSdD2xzNJNtF+6UPZ6jqkzGmwGus
	Dmg0S1Wg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlhZ6-00000004fZs-15x8;
	Sat, 22 Feb 2025 04:56:36 +0000
Date: Sat, 22 Feb 2025 04:56:36 +0000
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
Message-ID: <20250222045636.GP1977892@ZenIV>
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

> Not all filesystems reliably result in a positive hashed dentry:
> 
> - NFS, cifs, hostfs will sometimes need to perform a lookup of
>   the name to get inode information.  Races could result in this
>   returning something different. Note that this lookup is
>   non-atomic which is what we are trying to avoid.  Placing the
>   lookup in filesystem code means it only happens when the filesystem
>   has no other option.

At least in case of cifs I don't see that lookup anywhere in your
series.  Have I missed it, or...?

