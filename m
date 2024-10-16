Return-Path: <linux-fsdevel+bounces-32058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534299FD6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 02:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8767D1C22165
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6A4879B;
	Wed, 16 Oct 2024 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaqrnVhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AE3B1AF;
	Wed, 16 Oct 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039922; cv=none; b=GEfMRKNh0jR91QnfdOP0wplTy8crCVLxdriRtdOicQRFMj3rt7qjV7FtYEOcNK4XjaVzkBUYTuvOfKKx6nGPaYMKxUxB7fRPqGGQpo3j+f25nQo6jVO2+QEVPvdXjTU/N0ZKKmo5xWZU8gbLSuWVQ0EHdlwqhCsVq5F7ocTV0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039922; c=relaxed/simple;
	bh=Bx/dFlbKzH10Je0iK3Rb4Fy5a5F7DDy4gj4hZJOTdTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxTkq9WRwxhxYjk4ImhGMQDlQJK6TBNCKltuJOyEjjeWjlvVK2q8Iia26+R8K44TTDfr7m4SDt+0XWI3SRhgsf5Gu8gTajdY7g4nXgFSiX+/ED7Bn/o+6IScmcMG2bqE2NgOLCUqWw6kHKwo/aUicNNpj0KPw8QB8T+W8poEeKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaqrnVhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506CAC4CECD;
	Wed, 16 Oct 2024 00:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729039922;
	bh=Bx/dFlbKzH10Je0iK3Rb4Fy5a5F7DDy4gj4hZJOTdTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaqrnVhnhESaXVBIKzWMfLPyKquNczQJ7PzExRn42zw9+dgbiq8qx8uwILmNzk1UW
	 8Bd0aW4NAPxaPaGTm623pMyCrxc3jseEv+YTfFldZa1qdBRZ5VDvarAlN8PUt0Yge2
	 qMHW9JXDdTeSdeq0fwBo/R9rByna0/qfCBh7VLkyJ5W4PvtLhcox0bAfO6rOPBukHz
	 LJF1QbuRRfMUAv71xqPmkdk8p1x803S2qm4FN2RwqZu8u1qAulkTCMrXa248hOy6JK
	 DtP205u1obmFlmj9hVqGFNk0i13tKJ1LVkLp66zhK0dy69f1hRzVDTWR987Ca/KvxB
	 F5NOgY4Bin5Lw==
Date: Tue, 15 Oct 2024 17:52:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
	cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v7 5/8] xfs: Support FS_XFLAG_ATOMICWRITES
Message-ID: <20241016005201.GH21836@frogsfrogsfrogs>
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
 <20241004092254.3759210-6-john.g.garry@oracle.com>
 <20241004123520.GB19295@lst.de>
 <f4d2180a-8baa-4636-a0a1-36e474fcd157@oracle.com>
 <20241007054229.GA307@lst.de>
 <f0febabf-25ee-4fbe-9dfe-77a240cc29db@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0febabf-25ee-4fbe-9dfe-77a240cc29db@oracle.com>

On Sun, Oct 13, 2024 at 10:06:04PM +0100, John Garry wrote:
> On 07/10/2024 06:42, Christoph Hellwig wrote:
> > On Fri, Oct 04, 2024 at 02:07:05PM +0100, John Garry wrote:
> > > Sure, that is true (about being able to atomically write 1x FS block if the
> > > bdev support it).
> > > 
> > > But if we are going to add forcealign or similar later, then it would make
> > > sense (to me) to have FS_XFLAG_ATOMICWRITES (and its other flags) from the
> > > beginning. I mean, for example, if FS_XFLAG_FORCEALIGN were enabled and we
> > > want atomic writes, setting FS_XFLAG_ATOMICWRITES would be rejected if AG
> > > count is not aligned with extsize, or extsize is not a power-of-2, or
> > > extsize exceeds bdev limits. So FS_XFLAG_ATOMICWRITES could have some value
> > > there.
> > > 
> > > As such, it makes sense to have a consistent user experience and require
> > > FS_XFLAG_ATOMICWRITES from the beginning.
> > 
> > Well, even with forcealign we're not going to lose support for atomic
> > writes <= block size, are we?
> > 
> 
> forcealign would not be required for atomic writes <= FS block size.
> 
> How about this modified approach:
> 
> a. Drop FS_XFLAG_ATOMICWRITES support from this series, and so we can always
> atomic write 1x FS block (if the bdev supports it)
> 
> b. If we agree to support forcealign afterwards, then we can introduce 2x
> new flags:
> 	- FS_XFLAG_FORCEALIGN - as before
> 	- FS_XFLAG_BIG_ATOMICWRITES - this depends on  FS_XFLAG_FORCEALIGN being
> enabled per inode, and allows us to atomically write > 1 FS block
> 
> c. Later support writing < 1 FS block
> 	- this would not depend on forcealign
> 	- would require a real user, and I don't know one yet
> 
> better?

Sounds fine to /me/, but that's just my opinion. :)

--D

