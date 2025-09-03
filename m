Return-Path: <linux-fsdevel+bounces-60184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FD8B42858
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3882C7A9212
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E6032ED5D;
	Wed,  3 Sep 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNZ6mIzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46C273810
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921878; cv=none; b=F/xMi3Nd5F4ihjpZrYLspABH6caCOM+uaEGs3BqxqT53DyUuRbr5+WcVfKuZxkM0YZw9ni0o5CxXsrgUjQ75EjsE1hdTNy9y04v63kmo7Jx5MRbtyExAaRIlIK+gBSGxDRYcYXFuhvTJn6taFzKVhtGbnn7LJnHG7sUGZN8U8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921878; c=relaxed/simple;
	bh=6px41JMGDpX/QsZi7y/+UBTvGe84+Z9kDy8x0vWkBSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWr29EhV0i18Ssq0kxtulJyx+e2536j1TpyQm0pY0ZF7SCEThIDWE7yL9kv3avkuVbCdlgs9zbO8V4P3hsxzIJvDyXdpCh96DkEURxcXV/V2Ltwb7grHjX4TUC6cSr64aERq6SwR0hsconT/MDi2QcB6+XH0NFZTCD5chCl+EY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNZ6mIzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B66C4CEE7;
	Wed,  3 Sep 2025 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756921875;
	bh=6px41JMGDpX/QsZi7y/+UBTvGe84+Z9kDy8x0vWkBSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNZ6mIzGwKueSRmxrEUqp8JO1KwkNPZ9HQqPMxkbsyxooay9PCx9aEY3wBQCwH+bY
	 H5uJNgLwyGKCFWFpnlH2fzAV1RpX2Eub0Z7pWU9KYmISEMyaA/GgsE2VVC7J+UPP9Q
	 gTGdxbrpdI3rHMTijbT/iCH6hdOvrBa6YUrs+8SZRU+c44Xv4Rmv5SCBcdQpJoaP68
	 MpiPpg/ptz273XXpL8mq1dA4i9avk31h53uY/d0R5P5HG2vA/XjL/eO5I5+Oqo1YIH
	 6v8/oDYoJNoByxDJu1AZRvCC3x3rK+N81UW/WFXgmdkBQTy7NmqSz3+OvBoTF9ys21
	 7XrP2lJaznZ+Q==
Date: Wed, 3 Sep 2025 10:51:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 5/7] fuse: update file mode when updating acls
Message-ID: <20250903175114.GG1587915@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708651.15537.17340709280148279543.stgit@frogsfrogsfrogs>
 <CAJfpegtz01gBmGAEaO3cO-HLg+QwFegx2euBrzG=TKViZgzGCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtz01gBmGAEaO3cO-HLg+QwFegx2euBrzG=TKViZgzGCQ@mail.gmail.com>

On Wed, Sep 03, 2025 at 06:01:00PM +0200, Miklos Szeredi wrote:
> On Thu, 21 Aug 2025 at 02:51, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > If someone sets ACLs on a file that can be expressed fully as Unix DAC
> > mode bits, most filesystems will then update the mode bits and drop the
> > ACL xattr to reduce inefficiency in the file access paths.  Let's do
> > that too.  Note that means that we can setacl and end up with no ACL
> > xattrs, so we also need to tolerate ENODATA returns from
> > fuse_removexattr.
> 
> This goes against the model of leaving this sort of task to the
> server.  I understand your desire to do it in the kernel, since that
> simplifies your server.   But fuse is often used in passthrough mode,
> where this will be done by the kernel, just one layer down the stack.
> In that case splitting a setxattr into a removexattr + chmod makes
> little sense.

Ah, right.  I temporarily forgot about network/cluster filesystems where
the local kernel isn't necessarily in charge of the file metadata and
permissions.

> Maybe extend the meaning of fc->default_permissions to mean: userspace
> doesn't want to deal with any mode related stuff.   Thoughts?

As suggested in the thread for the next patch, maybe I should just hide
this new acl behavior behind (fc->iomap || sb->s_bdev != NULL)?

--D

> Thanks,
> Miklos
> 

