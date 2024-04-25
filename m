Return-Path: <linux-fsdevel+bounces-17694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD48B1846
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A950C1C21788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1845CA1;
	Thu, 25 Apr 2024 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hISv2gh8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9D4C62;
	Thu, 25 Apr 2024 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007087; cv=none; b=ghUfCM+OJ4CzqsVLzWHfnWbFayktpWKTpTRVXcr5SJJDSvMkIN71AS5d7no4JTzgkIBuhhuT0cZIawovPp15WQvHKE+O7Vtt5iaT2w6dbbXFoo6cku05MWlFX61Vmee1/yCDFOaLFWJEBU4engj2Q6/3ru/Kghj2xQhnQFrbAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007087; c=relaxed/simple;
	bh=J4fcZMWKH2oaxX8NGwkpXSqMuxdKMoHsiPTwav3+BK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2QOx8UOuA1fCEPAeQ1tDe7Htx7KdvCjUbLU0e/cpbkvnuJpfDGTla6lCTo7It6/oy/Sf99Ljr1HqYWP/g4+k2+pvkOXKPWMUZiaDLGSZFVNZg7uOTbEE3IyAEuiYGhUymdZ2eGYzMN7j7XEXkIFqi6qXk6Dm1NeMo4jzMesguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hISv2gh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E99C113CD;
	Thu, 25 Apr 2024 01:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714007086;
	bh=J4fcZMWKH2oaxX8NGwkpXSqMuxdKMoHsiPTwav3+BK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hISv2gh8DXSsY7OVQL7p6ubcKC1oBwz8etN9oo4Aoft8TZbvVMfSiLx4DDQFXSpKq
	 hx3OUE5bG6B5fxxG4PLrMFtQ50xbJ5ZNfvzDZ32mU+n4rt3FpWSy/8OVOOXWH19pr9
	 1ze49T07RNoXD0mk7UkPRThNAUGLoCYkf0KfvLMVYYPcz+uK0No56VA+lgV4qRbK8p
	 HLl9yKQe/nO9YxnUemTf7X+vuJmsX6KgLJRqkA8200NVpIKCRpszvjBEkTQk0bhw/8
	 /hmTuW3Vvd75eNfYp6IMzJ0KCRD5naMF9XvprEYoXJcGkhDKWvXGQsXR3RBLBsqIwd
	 BnVzDSwLdy7Vg==
Date: Thu, 25 Apr 2024 01:04:45 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 08/13] fsverity: expose merkle tree geometry to callers
Message-ID: <20240425010445.GF749176@google.com>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867998.1987804.8334701724660862039.stgit@frogsfrogsfrogs>
 <20240405025045.GF1958@quark.localdomain>
 <20240425004545.GU360919@frogsfrogsfrogs>
 <20240425004927.GE749176@google.com>
 <20240425010137.GX360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425010137.GX360919@frogsfrogsfrogs>

On Wed, Apr 24, 2024 at 06:01:37PM -0700, Darrick J. Wong wrote:
> On Thu, Apr 25, 2024 at 12:49:27AM +0000, Eric Biggers wrote:
> > On Wed, Apr 24, 2024 at 05:45:45PM -0700, Darrick J. Wong wrote:
> > > On Thu, Apr 04, 2024 at 10:50:45PM -0400, Eric Biggers wrote:
> > > > On Fri, Mar 29, 2024 at 05:34:45PM -0700, Darrick J. Wong wrote:
> > > > > +/**
> > > > > + * fsverity_merkle_tree_geometry() - return Merkle tree geometry
> > > > > + * @inode: the inode for which the Merkle tree is being built
> > > > 
> > > > This function is actually for inodes that already have fsverity enabled.  So the
> > > > above comment is misleading.
> > > 
> > > How about:
> > > 
> > > /**
> > >  * fsverity_merkle_tree_geometry() - return Merkle tree geometry
> > >  * @inode: the inode to query
> > >  * @block_size: size of a merkle tree block, in bytes
> > >  * @tree_size: size of the merkle tree, in bytes
> > >  *
> > >  * Callers are not required to have opened the file.
> > >  */
> > 
> > Looks okay, but it would be helpful to document that the two output parameters
> > are outputs, and to document the return value.
> 
> How about:
> 
>  * Callers are not required to have opened the file.  Returns 0 for success,
>  * -ENODATA if verity is not enabled, or any of the error codes that can result
>  * from loading verity information while opening a file.
> 

The wording sounds good, but since this is a kerneldoc-style comment the
information about the return value should be in a "Return:" section.

- Eric

