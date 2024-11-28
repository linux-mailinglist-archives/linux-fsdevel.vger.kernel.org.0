Return-Path: <linux-fsdevel+bounces-36110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E59DBCB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 20:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0AAB216E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB051C1F14;
	Thu, 28 Nov 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NviNW3cH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8067A13A
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732823864; cv=none; b=knmuyjprPjTVsnodcZfL4Q395LomAqOnD0eESAvNz2ZMtXtlpRkNFYvx3zG/oXfXxgUTmHI6odVpvjh63aauQnfa4mBv8Fdl0csUCZY/lZory77jtul7T3iI9rIEh1aSNLAoumKnVWYGFVxsTZbQYwTveK4t523NbxZkEznyj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732823864; c=relaxed/simple;
	bh=E6UR72UU6vkSpe/Kn4lEVAvSmx9mpMtAPK5lt/a7TZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUWr363qxCjIoP0rtDDCeUBQjl11ULcCVYUrCMJVVy/ze6wr7cMzYd/UmzKriS64Y6Qov01iA6S5Gp5aTy1LBkBUl72WdMINSJt2ftRoKaI1DR7111+4ma7fmfsnxh2BPkrVM+ZbOx+ZIcJC8B/QxndaSJ0Tnsd+MOfOStVzDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NviNW3cH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hzCfcqOJQOUcQxvykhJEPHdHsBK4FzhrKYvRrKLLlWM=; b=NviNW3cHQov+9xJixfSdrHVVxM
	tpvGhw94yK5zQ3aafbWlO/RIPa6g9US2hmjtMyhmpFA+CUozyB9UTNK+hvjCi2/QRQlKkS3iUywPr
	GgxNqWwaB4Kr2GwbP7FJ/9v4fvsm7l9/KXaEyeC+cuujDuQY9F69WuWYjtKTmhrwMTeKJTbrIA9BS
	6sNVjlKhRoGJ59YFjZ8B4JvXeQEUteC7PtA6nw6FmDJCLNQgRcWEOcL8dHRTTteFlBaAls99QDbGY
	sOtFHcf79Lg7H5eZ4coqpHoX7DMd7VWyiyYYBj8LoQK27uKIBQOP4EfazQQB+9Cnsrxz2fxJPuuZK
	1TcOfUoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGkdu-00000002sQ2-2cM8;
	Thu, 28 Nov 2024 19:57:38 +0000
Date: Thu, 28 Nov 2024 19:57:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
Message-ID: <20241128195738.GG3387508@ZenIV>
References: <20241128144002.42121-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128144002.42121-1-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 28, 2024 at 03:39:59PM +0100, Miklos Szeredi wrote:

> Prior to this patch mount namespace changes could be monitored by polling
> /proc/self/mountinfo, which did not convey any information about what
> changed.
> 
> To monitor an entire mount namespace with this new interface, watches need
> to be added to all existing mounts.  This can be done by performing
> listmount()/statmount() recursively at startup and when a new mount is
> added.

First impression is that it's bloody awful, TBH.  You are calling fsnotify()
under mount_lock; in effect, *ANY* path_init() call done during that time
will be spinning in __read_seqcount_begin() until you are done with that
shite.

And it's _very_ easy to generate a lot of such events with a single syscall;
that doesn't even need sroot - a root in container will suffice.

So... why is it not a DoS?

