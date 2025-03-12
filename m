Return-Path: <linux-fsdevel+bounces-43818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE65A5E152
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279AD3BBD62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F711BCA07;
	Wed, 12 Mar 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9yNkysk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06E3D81;
	Wed, 12 Mar 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795228; cv=none; b=n5R6iQoEAyJ7i62vYPHSEgNr2JGha8wbiTYsgAumfbRkfd1Sz1yg5ZaIqg1YcA6f2rfNRAn+jRkRXH4ry+kR34PAVqZ9LhAvZQcLYMxA137oVrIKkqyIWWwIfgGpP7VBYTz6b69koPbr+9vrdVt0c14VW4tUbMj+logbW6eWyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795228; c=relaxed/simple;
	bh=UDAhSVz9bbUM72gEhqkUroxkFdp6FR7RnbdsbIfL4+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvgHC1MdGRcur3iwU0w5ORVm7KTIkNmx0zQ7FFihngQGWsqKCQhl+gR6YwkfTWlpXsnZvM5rkEhRekfE5l0hH9OqyRwX/rKDBhX3Nv73sP1MIAtVlPFGbrCXUqiE9xTaCMVa0jzDZO2Tef5NdoQ6zk6B3caRVBw0/A1sGLdS6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9yNkysk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D44C4CEDD;
	Wed, 12 Mar 2025 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795228;
	bh=UDAhSVz9bbUM72gEhqkUroxkFdp6FR7RnbdsbIfL4+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9yNkysk5+h6unTvmjqkO6a84Cl0Yo+36z3J6RQ/ApWWsEeZovm319rsU7K3TXaip
	 dlu7bc/iib9O1Bo3XOrXjYVSB5UfqZrzEik0TQHuRijrwXtwDjB8xAMEmrQezerPLK
	 61XB5RPwcV5YntZ4glbpTYBQHuwWyUaRoEoOM9KW23wjUrVrkrrR9Xpui2TB+LkfD7
	 U9Rxo0tdg9rgKHq4fdDZf6tlIl4nfkGbsoNisn/X6evuIggupQYIxnhf7+UdZ7nVB1
	 3S70RUcw7tqAP9Bbt9pWQmjuUp7Vw9UyP7gWydbtaKHal2OFgPEw9IUeDI6Ip4nm2u
	 +DngfzQ7NEeBg==
Date: Wed, 12 Mar 2025 09:00:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 09/10] xfs: Allow block allocator to take an alignment
 hint
Message-ID: <20250312160027.GY2803749@frogsfrogsfrogs>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-10-john.g.garry@oracle.com>
 <Z9E679YhzP6grfDV@infradead.org>
 <4d9499e3-4698-4d0c-b7bb-104023b29f3a@oracle.com>
 <Z9GP6F_n2BR3XCn5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9GP6F_n2BR3XCn5@infradead.org>

On Wed, Mar 12, 2025 at 06:45:12AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 08:05:14AM +0000, John Garry wrote:
> > > Shouldn't we be doing this by default for any extent size hint
> > > based allocations?
> > 
> > I'm not sure.
> > 
> > I think that currently users just expect extszhint to hint at the
> > granularity only.

Yes, the current behavior is that extszhint only affects the granularity
of the file range that's passed into the allocator.  To align the actual
space, you have to set the raid stripe parameters.

I can see how that sorta made sense in the old days -- the fs could get
moved between raid arrays (or the raid array gets reconfigured), so you
want the actual allocations to be aligned to whatever the current
hardware config advertises.  The extent size hint is merely a means to
amortize the cost of allocation/second-guess the delalloc machinery.

> > Maybe users don't require alignment and adding an alignment requirement just
> > leads to more fragmentation.
> 
> But does it?  Once an extsize hint is set I'd expect that we keep
> getting more allocation with it.  And keeping the aligned is the concept
> of a buddy allocator which reduces fragmentation.  Because of that I
> wonder why we aren't doing that by default.

Histerical raisins?

We /could/ let extszhint influence allocation alignment by default, but
then anyone who had (say) a 8k hint on a 32k raid stripe might be
surprised when the allocator behavior changes.

What do you say about logic like this?

	if (software_atomic) {
		/*
		 * align things so we can use hw atomic on the next
		 * overwrite, no matter what hw says
		 */
		args->alignment = ip->i_extsize;
	} else if (raid_stripe) {
		/* otherwise try to align for better raid performance */
		args->alignment = mp->m_dalign;
	} else if (ip->i_extsize) {
		/* if no raid, align to the hint provided */
		args->alignment = ip->i_extsize;
	} else {
		args->alignment = 1;
	}

Hm?  (I'm probably forgetting something...)

--D

