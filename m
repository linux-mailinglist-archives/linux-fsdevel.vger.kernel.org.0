Return-Path: <linux-fsdevel+bounces-47099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D379A98E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 16:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FB97A6F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60153280A5B;
	Wed, 23 Apr 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g78qYIYi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3D18DB17;
	Wed, 23 Apr 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420034; cv=none; b=cM2alSHBFWM7eUNldPHu78CcViMRCxpR1pQdzwq/PUnLBoLFv2dubpHm49vmBhy37hQfNklDumTUNHOa53xvNMlo/XoIeH5upzUdJmSRWWAhJUAdXdVrwNJBCoC467FM79hSvYHV5JK3a1XPZ9biV7OkDdyeD7oAskwLcM9LXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420034; c=relaxed/simple;
	bh=WUcb1wgsCsDQUCHQW+xnzIj+1l0qgA5o4uNMx5f63MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjfmAPM4zCOMAns48Fzh1fqH8L990LhEAiwIs64WJrFkdJTf4Cq5K3BPZ/5gbGJNnfd8IlUmX0NuOfy/YLnaRz/EkDQ7ay//p425tnfhTVUXc/ccUccejHC2RUV7Rv64qlk7tgL6sSjsYwcTs8UM8EeKx0CSi8RPwdx9ar5S8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g78qYIYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC69C4CEE2;
	Wed, 23 Apr 2025 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420033;
	bh=WUcb1wgsCsDQUCHQW+xnzIj+1l0qgA5o4uNMx5f63MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g78qYIYiFDx8egynq2Hs1ZkD5E38gAYAzKPhxTVa5iNrvZhXIAsrW9Fwl5ZKtGgtY
	 YpfIb2rbdgmTyp1pCUcT+b3PIkQbigRF7aeZjjoR+txEKGy91vAIwN1dF8ufq8sTw9
	 ziExqxgKYB30uRtnMi/UX2NGF1g192BZbAASIEXSxdNYJuYjY6KILBAad217UKiUvb
	 RNxCZH6omu2dBAwwaWdXqDLQvVvJZl1uQ5l+r+0En4zKn1/vYQv+XmIaB3T2/jcU+T
	 fKZViLWQmI5MRq43U01EKltdIyfVjCPOSB22MI634UVI1KnbDLW7Nysk21E18unNrY
	 dMxDD0OMAFtiw==
Date: Wed, 23 Apr 2025 07:53:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250423145352.GZ25675@frogsfrogsfrogs>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
 <20250421040002.GU25675@frogsfrogsfrogs>
 <2467484b-382b-47c2-ae70-4a41d63cf4fc@oracle.com>
 <20250421164241.GD25700@frogsfrogsfrogs>
 <20250423054251.GA23087@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423054251.GA23087@lst.de>

On Wed, Apr 23, 2025 at 07:42:51AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 21, 2025 at 09:42:41AM -0700, Darrick J. Wong wrote:
> > Well it turns out that was a stupid question -- zoned=1 can't be enabled
> > with reflink, which means there's no cow fallback so atomic writes just
> > plain don't work:
> 
> Exactly.  It is still on my todo list to support it, but there are a
> few higher priority items on it as well, in addition to constant
> interruptions for patch reviews :)

Heheh I'll try to go dig through all the stuff you've sent to the list
yesterday, though I've got an hour of paperwork ahead of me that has to
get done asap. :/

--D

> > I /think/ all you'd have to do is create an xfs_zoned_end_atomic_io
> > function that does what xfs_zoned_end_io but with a single
> > tr_atomic_ioend transaction; figure out how to convey "this is an
> > atomic out of place write" to xfs_end_ioend so that it knows to call
> > xfs_zoned_end_atomic_io; and then update the xfs_get_atomic_write*
> > helpers.
> 
> Roughly, yes.
> 
> 

