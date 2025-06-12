Return-Path: <linux-fsdevel+bounces-51509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB7AD7804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776E51888626
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C462BDC00;
	Thu, 12 Jun 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3yRNl9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4A29AB09;
	Thu, 12 Jun 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744732; cv=none; b=OlL1CNqUKG1BSlugDMGYPR/crJOU1WyUbHqlNpAHje/s5dN2THaTqOxeOzxj2KHUTQeRmkop3A301KJIqBUfO8sYm8DnMrxl1HTu9cbrsmRPVOsOO3gZk86thBcN1qge4ehcOGDsfddbwSMFG1KhccHE7BaGsIVmfXXPnuGSFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744732; c=relaxed/simple;
	bh=FSA3tiw9gewwK5LBaaWrec3fha2fNeVi5ofPGkDW/kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS9htWBFSvLgAItdmP2sPibKFaBe9h3HBfUdNccicw1ZtN/82peLmY7aLiq9ynHj+W9Nju/mGdMAAroAmt2WddWgIqIhUBD6qGL98qt4WFleraIZudPAvY9S3YFTCe0a4XIXv5A2USFR9H0Bg/UMieLnh3QqcyQgexC7ZRwrD3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3yRNl9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDE7C4CEEA;
	Thu, 12 Jun 2025 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749744731;
	bh=FSA3tiw9gewwK5LBaaWrec3fha2fNeVi5ofPGkDW/kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3yRNl9J9xBoZR3cBB8aAm+uqPxAT7QvfIEQ0aITxswlh7EeUeb68K5hGizKd2M0m
	 kdR0giDUjagSv/9NRlm2CaX/UrGtWLbWQFCPVvtY2Zp0oJ/PqRda4tMlBXHqSK3x1g
	 n1dc7T8Y2wXUk/BepBX1y5nGZH3kudbQto9Ia4aMdyqkxKxRSl9pOD0YBMVQJIyl10
	 zmw3mLD8Y+D3ygRLHHnSQFCKYx0fn+UyMU1bn5plgAl8IBtGa4ZGC4JMG0m4BVfzmn
	 cAtxAskzETYnv1/il1FWTHcj1GcxONMRni0MCQID+tj82r4ZmpItSa69kszuyM8rCZ
	 Rx2QW6ISINVmw==
Date: Thu, 12 Jun 2025 12:12:10 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aEr8WrzJsU6XTyki@kernel.org>
References: <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <5D9EA89B-A65F-40A1-B78F-547A42734FC2@redhat.com>
 <aEr4rAbQiT1yGMsI@kernel.org>
 <04acd698-a065-4e87-b321-65881c2f036d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04acd698-a065-4e87-b321-65881c2f036d@oracle.com>

On Thu, Jun 12, 2025 at 11:58:27AM -0400, Chuck Lever wrote:
> On 6/12/25 11:56 AM, Mike Snitzer wrote:
> > On Thu, Jun 12, 2025 at 10:17:22AM -0400, Benjamin Coddington wrote:
> >>
> >> What's already been mentioned elsewhere, but not yet here:
> >>
> >> The transmitter could always just tell the receiver where the data is, we'd
> >> need an NFS v3.1 and an extension for v4.2?
> >>
> >> Pot Stirred,
> >> Ben
> > 
> > Yeah, forgot to mention giving serious consideration to extending
> > specs to make this happen easier.  Pros and cons to doing so.
> > 
> > Thanks for raising it.
> > 
> > Mike
> 
> NFS/RDMA does this already. Let's not re-invent the wheel.

TCP is ubiquitous, I know you seem to really not want us to seriously
pursue fixing/improving things to allow for the WRITE payload to be
stored in an aligned buffer that allows zero-copy but... the value of
not requiring any RDMA hardware or client changes is too compelling to
ignore.

RDMA either requires specialized hardware or software (soft-iwarp or
soft-roce). 

Imposing those as requirements isn't going to be viable for a large
portion of existing deployments.

