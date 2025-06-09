Return-Path: <linux-fsdevel+bounces-50977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37CDAD185E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDCB1685B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5559280333;
	Mon,  9 Jun 2025 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gpi8SoMr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4DC17BD3;
	Mon,  9 Jun 2025 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749447294; cv=none; b=mZ977pmNzMBUgriYI8/WVnYzOaxFIKNpROQB58ZwDBe6Cg0rHZDil4m/id1cOtZ1g8j0BNcA/NiwKPtpEBnbt0LMxZPIw1+8l6KXyyOhY5Ki1ak9Gh22M4qSqTVaF8LSkogBeJXoRhSinwYcFeWbq0Tei6kAHTcVwM4MVmVWWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749447294; c=relaxed/simple;
	bh=uwxa5npzdokndbCpN5yU7uplXOuCnvLiH5v8BmUtBz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLiiCgVoOii1WySFKTB/qOy3/p7HKWn+8VdAJ2q+ie56r63h1BVbtfjTPwvI9RNFFwKPZzXM1caYrvQXeQtOa99jXO+X+3QP685W6sHtUzCIzev169+a8jMzSuZS6aDGcbImGqCV8C6p5V3RArs4ayjXwfA8eD75xZUcgktppMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Gpi8SoMr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dkLL/eLFQ+sNI47KAXAvlP2XsLUmCy2MqXXx7+2KD6I=; b=Gpi8SoMrJAabIz21fHEErY778Y
	1XnDwty0mXeTZmvRbqate1rLoP8K9aaYl4ZgGfTZasMRHyJwzdVFKqx/OSj3D8r5w2xHaR3/v3CDP
	Wzf84eJ4XASt8QVP65M/0cEtArCvO27ap2Jbx73sjTEEKGOZNbx60WrMMtqNN9glE7LP8LqrMUDsu
	mIXK9TEJn3RNquJBBfjDjp+aULXXwDebU1Xjub6J3ON8LN/uJSr5lbwRO9xeDmbosyKb1y9SIapdQ
	COUWwVMFrAohO8ls9FQAeRhy54fPYrls/pxkbo1fdxN8ztPQyGQIki/7WwF/JUsRagCgLCDpoTs4s
	ze6p+h3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOV9e-00000008Whi-3LPI;
	Mon, 09 Jun 2025 05:34:42 +0000
Date: Mon, 9 Jun 2025 06:34:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Change vfs_mkdir() to unlock on failure.
Message-ID: <20250609053442.GC299672@ZenIV>
References: <>
 <20250609005009.GB299672@ZenIV>
 <174944652013.608730.3439111222517126345@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174944652013.608730.3439111222517126345@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 09, 2025 at 03:22:00PM +1000, NeilBrown wrote:
> On Mon, 09 Jun 2025, Al Viro wrote:
> > On Mon, Jun 09, 2025 at 09:09:37AM +1000, NeilBrown wrote:
> > > Proposed changes to directory-op locking will lock the dentry rather
> > > than the whole directory.  So the dentry will need to be unlocked.
> > 
> > Please, repost your current proposal _before_ that one goes anywhere.
> > 
> 
> I've posted my proposal for the new API.  This makes the value of the
> vfs_mkdir() change clear (I hope).
> 
> Would you also like me to post the patches which introduce the new
> locking scheme?

Yes, seeing that the rest does not make much sense without that.

I would really like a description of that locking scheme as well,
TBH, but if you prefer to start with the patches, then so be it.

I can't promise a response tonight - going down in an hour or so
and I'd like to do enough reordering of #work.mount to be able
to post the initial variant of at least some of that in the
morning...

