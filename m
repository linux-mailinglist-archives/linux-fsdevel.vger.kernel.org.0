Return-Path: <linux-fsdevel+bounces-73488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDCCD1ACC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E026D30402D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37281322B61;
	Tue, 13 Jan 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqG7ZMVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DF1FC110;
	Tue, 13 Jan 2026 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327734; cv=none; b=PCKn+QDHs5ZiSiGNKX+SDYO8+zJ1KETvr4GRTWrN1V15EYC3kCOmJityP6ZZMPXkoCnU1HUUgrayi8hnt2PklQReSWKHOtyEpYXFDq7ZxwiHJr8Hp907P4cU0yhOb5tMJ8TdnsMBTjRrl6WTMDWMZwrtf2vN54aMnmrjzBmqv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327734; c=relaxed/simple;
	bh=Z7UFeJxH9fAu0zwJC/E6Z0wszNyDx4E5zPTxEkKMBnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kN1zFKeKne12xgMkVd2RNYi32atqEjYwZyxRez68j+uoXLpARmiRQy77egPxeuwbePNg9X20uLTZP6hANQAq/fy3AYAZ77V9Cqzu3r76xE7PZBlF2KKfpDY6v7ik4UDnphu+yYTSU8h70QnLn19ypcC40ukydW8V5hvbO4BX0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqG7ZMVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413A1C116C6;
	Tue, 13 Jan 2026 18:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768327734;
	bh=Z7UFeJxH9fAu0zwJC/E6Z0wszNyDx4E5zPTxEkKMBnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqG7ZMVWRlROjpw2vDnWsG5+VCxvCwEyM+f8R+asXvoByf73fFiXXUIjPMb1AZc1E
	 BS2p00QB8ufXUNCR38H46pTtJMsEMyaUgh1OlpyhXGNg/Aea1BofwH2M/iWDv6T9MN
	 XQDwGsqS6skiOK32x/lB0ZUY4LVEU5zM6N1DnXtDglAk54D3uFiDurOpYFJohNZRPO
	 /rrFz4SsnGC0G1BxR4cinSclqCEBatsuIQVAvFpUKJDoRPn5Ir7DGATyqBJkxA0xhh
	 nxFl9D3T1/FSMa2+wZsqt4FlJCuB0BJ+HbNQpgrnKRISK7jWEy8Rqo4R+uUtnCcSYX
	 9SQxOBPIj7egQ==
Date: Tue, 13 Jan 2026 10:08:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: wait for batched folios to be stable in
 __iomap_get_folio
Message-ID: <20260113180853.GZ15551@frogsfrogsfrogs>
References: <20260113153943.3323869-1-hch@lst.de>
 <20260113154855.GH15583@frogsfrogsfrogs>
 <20260113155805.GA3726@lst.de>
 <aWZu0TxyoyHFTqXi@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWZu0TxyoyHFTqXi@bfoster>

On Tue, Jan 13, 2026 at 11:12:01AM -0500, Brian Foster wrote:
> On Tue, Jan 13, 2026 at 04:58:05PM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 13, 2026 at 07:48:55AM -0800, Darrick J. Wong wrote:
> > > I wonder if we ought to have a filemap_fbatch_next() that would take
> > > care of the relocking, revalidation, and stabilization... but this spot
> > > fix is good as-is.
> > 
> > Let's wait until we have another user or two.  Premature refactoring
> > tends to backfire.
> > 
> 
> I agree on not being too aggressive on that... I do like the idea
> though, so I'll try to keep it in mind if this happens to expand down
> the road. Thanks for the fix.

<nod> Making the second user do the refactoring is ok with me. :)

--D

> Brian
> 
> 

