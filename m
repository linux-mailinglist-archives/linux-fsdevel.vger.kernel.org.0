Return-Path: <linux-fsdevel+bounces-17693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1768B1840
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B36D1C21375
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4785CA1;
	Thu, 25 Apr 2024 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnWyPmse"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49154C62;
	Thu, 25 Apr 2024 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006899; cv=none; b=sTl0GHk1q9ryc6d9mAn1jSxk0ItH+qj5lBwK6fOatbKZKVj3qHxqo+/Hsy/F0YlUF7INsdf/HiG3Ff2plL7kr7jsg+4n2hflATz/h6hJjov48+zIdkKuSTlNcesheojTSOKCfa0PdIamAJd8tYKMELNnBB2V6fwpKMkfhRvsaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006899; c=relaxed/simple;
	bh=708mQW1FyIApu6dt2VmNKRn/RMnqKxN1hVEPH8osoGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxjsF4V9qnaQ7rjdNCOaTMmfvFT7t1C3U4BJ4i8EWcB1FFj3j1YwG3QXQFYCnXfC+O9//PO9Nkk6OhL/oIcgvoSkdrzgUz9K4u0ZTQKC/qvR1SYr1WkCl+d28ypPSrLxO8l83USz2QbZ2l6fsW8unTlQVnWYQ5uG9f5W/O7XfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnWyPmse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603E1C113CD;
	Thu, 25 Apr 2024 01:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714006898;
	bh=708mQW1FyIApu6dt2VmNKRn/RMnqKxN1hVEPH8osoGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnWyPmseDg4tNWLywUaliBh5KPpDOQ6HLAkDhO9/RJ89eq1mj3b7FIme1/24ypTAY
	 j/Xnmyc3cHYQObpII+gTMJ5ck8W9+ku4n6kf+7JZ588YY5zbU8+ua7NeBqQeNr5FJg
	 oOFvkXQG2EtimU/PBu4QVO0lopdBS5+S2RDnAN8L2kqNKo0JLw/cpw76WtEB0P3A+5
	 uNxAMHl+yCEpC9nOEKz4XHRvNDsnJJ7F3gK3/n+9bkkCTwQVBPS+NXgjwbA2bOHXoW
	 BClWGJ12Vei1y/AgWQNW1z8vdMriaFk2N9PSz3khpzCb6aiK3O5pNrFBAvqkPbdXzf
	 Xm4AfuNSgyBdQ==
Date: Wed, 24 Apr 2024 18:01:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 08/13] fsverity: expose merkle tree geometry to callers
Message-ID: <20240425010137.GX360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867998.1987804.8334701724660862039.stgit@frogsfrogsfrogs>
 <20240405025045.GF1958@quark.localdomain>
 <20240425004545.GU360919@frogsfrogsfrogs>
 <20240425004927.GE749176@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425004927.GE749176@google.com>

On Thu, Apr 25, 2024 at 12:49:27AM +0000, Eric Biggers wrote:
> On Wed, Apr 24, 2024 at 05:45:45PM -0700, Darrick J. Wong wrote:
> > On Thu, Apr 04, 2024 at 10:50:45PM -0400, Eric Biggers wrote:
> > > On Fri, Mar 29, 2024 at 05:34:45PM -0700, Darrick J. Wong wrote:
> > > > +/**
> > > > + * fsverity_merkle_tree_geometry() - return Merkle tree geometry
> > > > + * @inode: the inode for which the Merkle tree is being built
> > > 
> > > This function is actually for inodes that already have fsverity enabled.  So the
> > > above comment is misleading.
> > 
> > How about:
> > 
> > /**
> >  * fsverity_merkle_tree_geometry() - return Merkle tree geometry
> >  * @inode: the inode to query
> >  * @block_size: size of a merkle tree block, in bytes
> >  * @tree_size: size of the merkle tree, in bytes
> >  *
> >  * Callers are not required to have opened the file.
> >  */
> 
> Looks okay, but it would be helpful to document that the two output parameters
> are outputs, and to document the return value.

How about:

 * Callers are not required to have opened the file.  Returns 0 for success,
 * -ENODATA if verity is not enabled, or any of the error codes that can result
 * from loading verity information while opening a file.

--D

> - Eric
> 

