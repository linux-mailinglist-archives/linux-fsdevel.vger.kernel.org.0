Return-Path: <linux-fsdevel+bounces-41707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE1A35726
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 07:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEB73AD98C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39220370C;
	Fri, 14 Feb 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TiUxrkqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D890201027;
	Fri, 14 Feb 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514790; cv=none; b=Sl3QJ9xGHTy6Cqd9ixSKUq0Khu1+Y6Kxv2ahJ0VK8g2lQ93O88MDjbRa3PKjRpN6JDJJJw9nTB8sOvqdCCPNgGAl7n2/0OIkso1FFODfkH/NVNShEvyda8MQMGlmZsteCSD5LcxNd5EQcJ9TZSCdpMLi9SCtkydJK+ECFuEpnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514790; c=relaxed/simple;
	bh=hVCD2rakAAB+o2t0oLvJfPKeC7Lmf1tkRkZ3Y9RnOn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkXcrW05uTSYAVJ68P0c1iNe4/05oluOofODoFMFZTSfYKnaCW5FcwjQlBA4C6uX0h3U31iWQZEmHKX4Wr5uhXkKfyzx3ZNCyI2ka5ehvYslcMD1kRDGOnoahqT3EtOEPtMmwWf9CmB2XRKzmVfMTRk73/Sjc5iTLmjN3W8lWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TiUxrkqm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kLNIJIGtAonH6TQ7Xn1xNKUdo34Iyv7JaZahEgvr29E=; b=TiUxrkqmOqjnPch01VAvC6YpVN
	wtHhKJ7km4Ah8MRFIKcLqCm36sTuJNx0DHMKQ94Bt9IMNZGvec7GAJ1Rw5b9UJcGZDdgDoMk1dV3Z
	LqshzPzd6OX4o+J6yhQKu6kENAnz2XvwP9ZAVV82Y1SPOzg7VhqYIkHyClkdYgx2II4/4Fr89+NX2
	pC50LkPLnKuRoMVSSi4F/f7CgnLhwqZp19D2bgkSL9WqyvDjal5k+5/pblPrD0Sbr2Z1J1fjOmqoh
	5IoCgr4/C420V7mC+/K6UJBA+HYtDpsmggz/YzIzRFCwEyw1gM7gMglshR5eDSeWMNJfu/BY7gH/t
	7CciF5/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tipG6-0000000DRTU-1edj;
	Fri, 14 Feb 2025 06:33:06 +0000
Date: Fri, 14 Feb 2025 06:33:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3} Change ->mkdir() and vfs_mkdir() to return a dentry
Message-ID: <20250214063306.GD1977892@ZenIV>
References: <20250214052204.3105610-1-neilb@suse.de>
 <20250214060039.GB1977892@ZenIV>
 <20250214061355.GC1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061355.GC1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 14, 2025 at 06:13:55AM +0000, Al Viro wrote:
> On Fri, Feb 14, 2025 at 06:00:39AM +0000, Al Viro wrote:
> 
> > 3) I'm pretty sure that NFS is *not* the only filesystem that returns
> > unhashed negative in some success cases; will need to go over the instances
> > to verify that, though.
> 
> Definitely so: in cifs_mkdir() we have
>         if ((server->ops->posix_mkdir) && (tcon->posix_extensions)) {
>                 rc = server->ops->posix_mkdir(xid, inode, mode, tcon, full_path,
>                                               cifs_sb);
>                 d_drop(direntry); /* for time being always refresh inode info */
>                 goto mkdir_out;
>         }
> There might be other cases.  hostfs is definitely like that, I'm pretty
> sure that kernfs is as well...

kernfs is actually playing fast and loose with the calling conventions there;
it does not bother with unhashing and relies upon its ->d_revalidate()
noticing and unhashing the sucker.

Another variant that would work (and follow the calling conventions)
is to have ->lookup() that leaves negatives unhashed and ->mkdir()
not bothering to hash or instantiate.

It really needs a review instance by instance.

And yes, it does look like ->lookup()-like calling conventions end up better,
especially if we make an instance return d_splice_alias() result...

