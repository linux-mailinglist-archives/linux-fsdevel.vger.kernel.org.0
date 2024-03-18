Return-Path: <linux-fsdevel+bounces-14773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD487F1B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 22:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C2A1F224D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 21:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FC58138;
	Mon, 18 Mar 2024 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO0xu0R0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103F59140;
	Mon, 18 Mar 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795852; cv=none; b=XiUnNvBeOqan/fyy4bzuppEkXFzlcBEPGrPVLk1mFwQS6t8ut18YK2AXune36z5TIMZ3tF1tmP7+038e2rTLlMFcgdd38GJFBPacN6kwnQuj9OPcM0eee1iWpTyfNMDNSxwrveyPuBQZ9qf65bVqiKzb+7pzonZbMnqVtsBBlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795852; c=relaxed/simple;
	bh=QT/ehi740JNvXD0Kk69zsxeQiWTWYJhR3CX98vGF494=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbihepjwxjfa5bqlFELqDQXP5fZqfNKJ+qhFEYjgzMiASfDEU/ogrwzagqcoGpMeZP3JSp1LPJ5XjxI1DEDcg9PzfT4rmz3+0Zm+hkBhrOBUDbrp7eXT3YKkIYGqZjHt09veux1qviSu7PtSZ2l8GIqG/u6nI3zOapgBJDR5Rbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO0xu0R0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BCBC433C7;
	Mon, 18 Mar 2024 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710795852;
	bh=QT/ehi740JNvXD0Kk69zsxeQiWTWYJhR3CX98vGF494=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AO0xu0R08RT5Eefaw+orL+W6OP77jJ6FjwjOS8n4pvT5ssPGS7SbepGDzOOiqrNO4
	 JIUpTiwCIFQ1gPMdvFHHKb3kud5jTH1tlmw446JGf7SFf8glBViU2/PoANjG3atbf5
	 Gb1Ud+UWrPVoR7DfbcK5/IAXsSiMyDHMw5X+7K6XGSPFUdUmwH/R3XejhWEWc7wUKv
	 /PkDNvyabWh5VwgDReL+vq/z1zoEszNEVJ98g0OHZqMGUH/2ReDiskTspH1/hQBrMM
	 ntpP+m9rGpdk9Gd0vzfgQb7MXR6uFmQc9PKLyQ5r7S15TJ3KR2uSGQ9fr4cTHUdKcU
	 HasQDXpxbOOFg==
Date: Mon, 18 Mar 2024 14:04:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 16/40] fsverity: pass the zero-hash value to the
 implementation
Message-ID: <20240318210411.GE6226@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246170.2684506.16175333193381403848.stgit@frogsfrogsfrogs>
 <20240318163847.GC1185@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318163847.GC1185@sol.localdomain>

On Mon, Mar 18, 2024 at 09:38:47AM -0700, Eric Biggers wrote:
> On Sun, Mar 17, 2024 at 09:27:34AM -0700, Darrick J. Wong wrote:
> > diff --git a/fs/verity/open.c b/fs/verity/open.c
> > index 7a86407732c4..433a70eeca55 100644
> > --- a/fs/verity/open.c
> > +++ b/fs/verity/open.c
> > @@ -144,6 +144,13 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
> >  		goto out_err;
> >  	}
> >  
> > +	err = fsverity_hash_buffer(params->hash_alg, page_address(ZERO_PAGE(0)),
> > +				   i_blocksize(inode), params->zero_digest);
> > +	if (err) {
> > +		fsverity_err(inode, "Error %d computing zero digest", err);
> > +		goto out_err;
> > +	}
> 
> This doesn't take the salt into account.  Also it's using the wrong block size
> (filesystem block size instead of Merkle tree block size).
> 
> How about using fsverity_hash_block()?

/me looks at build_merkle_tree again, realizes that it calls
hash_one_block on params->block_size bytes of file data.

IOWs, fsverity_hash_block is indeed the correct function to call here.
Thanks for the correction!

--D

> - Eric

