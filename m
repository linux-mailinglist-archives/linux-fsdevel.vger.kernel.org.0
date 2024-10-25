Return-Path: <linux-fsdevel+bounces-32904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B109B07FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA209283280
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493E1F76A9;
	Fri, 25 Oct 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFhg8LRD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A221A4BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869523; cv=none; b=KYX1u8vy6vnB96P/cbdQlg5kwUVGYLnrHGjMYF6zSWnb3O1p2c0hWBoWy7Q24TEovTSNKNgIFDhmLt8z8VPYkNUfNmWmtZe/ntO6uKtWt2v2wC5hr47jL8w8+YjjosUCb4G7XGX+yY/J1PFmZaasZaaPyRanVrOpcgKVFEnOi9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869523; c=relaxed/simple;
	bh=BeEXV28irBZzHBjDKgKUNZwmW90+xp5SZ1oSfEXepIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odiKPF3laDWrNWnuvhFWDoysKTPeerAIQ/yknpXsb/e4kwinzf6lHpRw4HDgOSHoA7ZTEt4SXvDV+nH2dxWZbfqK1hbt8iuVWfFntKyXc0dFpm//LzmwXEuafQeL7Dd0vxGXQUxUjkZWtW+FsoU6vQqvdMQzaZckp3eYygvQvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFhg8LRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344DCC4CEC3;
	Fri, 25 Oct 2024 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729869522;
	bh=BeEXV28irBZzHBjDKgKUNZwmW90+xp5SZ1oSfEXepIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFhg8LRDWF62tuSZ0C5GETLILU8t3gpQfa8HueEzgX6xjh8T2zMrkjZVtmObyIbvd
	 coZBw1GXzvITvMrnOwWwJXDFbnHGTyr177CKwCtx50Dgr8y/3rKq4x+aV2Ipbn/8Id
	 WQ7tjlgiAh5UoeFSvkVmf52/mXjcB6Wm3SinNZDYRXcZhG60kS/sSZAPx+Aq5A8Qxd
	 ZRJhCy7uxG5IKnVMzKwKCkdwdpDQTRZe9HD6WHjBc4uRDPjvRV+k46n/P2tXDhKJFA
	 IgWIIiS2t5O2YD0TR0T5NAs8JWIfzMGeHbeE/xfnpimPgWpToHXN+ac84XmB33gUS1
	 aOe9fxIc7ZmFA==
Date: Fri, 25 Oct 2024 17:18:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>
Cc: Theodore Ts'o <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>, 
	sunjunchao2870@gmail.com, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>
Subject: Re: [REGRESSION] generic/564 is failing in fs-next
Message-ID: <20241025-siegen-botanik-46606fef0098@brauner>
References: <20241018162837.GA3307207@mit.edu>
 <20241019161601.GJ21836@frogsfrogsfrogs>
 <20241021-anstecken-fortfahren-4dd7b79a5f45@brauner>
 <20241023194253.GH3204734@mit.edu>
 <20241024090611.0cff2423@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024090611.0cff2423@canb.auug.org.au>

On Thu, Oct 24, 2024 at 09:06:11AM +1100, Stephen Rothwell wrote:
> Hi Ted,
> 
> On Wed, 23 Oct 2024 15:42:53 -0400 "Theodore Ts'o" <tytso@mit.edu> wrote:
> >
> > On Mon, Oct 21, 2024 at 02:49:54PM +0200, Christian Brauner wrote:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/read_write.c?h=fs-next&id=0f0f217df68fd72d91d2de6e85a6dd80fa1f5c95
> > > > 
> > > > To Mr. Sun: did you see these regressions when you tested this patch?  
> > > 
> > > So we should drop this patch for now.  
> > 
> > My most recent fs-next testing is still showing this failure, and
> > looking at the most recent fs-next branch, 
> > 
> >     vfs: Fix implicit conversion problem when testing overflow case
> > 
> > still appears to be in the tree.  Can we please get this dropped?
> > Thanks!!
> 
> I have reverted that commit from the fs-next and linux-next trees for
> today.

I'm still recovering from the flu so I'm a bit behind. We actually need
to drop two commits. I had done that already yesterday though.

