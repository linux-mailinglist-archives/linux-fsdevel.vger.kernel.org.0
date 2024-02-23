Return-Path: <linux-fsdevel+bounces-12617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12032861B2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 19:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF32D289F9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB613790F;
	Fri, 23 Feb 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGj1hUj1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8312D758;
	Fri, 23 Feb 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711655; cv=none; b=nqzSIIsoqJAB6iCyGw3KxTHuKj0J7p8d+QEihWC8jc/snMEye36P5DLyQHZxJCJMWSW/ISnyaBKaCgW+oDgnKLvg3CAxiOTMGLembOgZidGZejk5hTXNfK3ihexA29ZwhwGCz9qcNdTEzQy8Pu5e710IAC5f+gVj+JPG1X8JFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711655; c=relaxed/simple;
	bh=vfeVB48gdtqrsvVrbDfcT+9eG6Xn1VGWQxvlysbiRW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWBoD+HAst5DoBxfyNrKy/94yaBwtp8ARNr6mSY/J+PH/w4T04GpKU/iJUp8F5RNXdSQsc8bcrsZW2UqBpQwayefQsZjyTKNsTPb+L9cC7ouGfaBaw+UfN04ObAhBmgWkpCPwz68tOgG1OY2vNCBKXLzeWxFmog4edxYt2NJVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGj1hUj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68813C433C7;
	Fri, 23 Feb 2024 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708711654;
	bh=vfeVB48gdtqrsvVrbDfcT+9eG6Xn1VGWQxvlysbiRW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGj1hUj1PhddLmkbFmTZdqN8xtyd8J+MQ1JNum0CJep6KsbsU8T10kw60IpF6jO7u
	 Ki/OTCnk63nhdcDiVA58FwJ1SGA3OJ74FboHd9pa6vsL+GJrEYxc4bHLTKFhUMDU69
	 Kr2yaO2HJos5PfJ7sOyeGu3qSNXoR9Op6ZD8gHk/kis7kVKwRiMKUszjnxuM8PdIBn
	 RtBn6dTLvpOHPttwTE8Mooxdhd57axgxxmH90sfAYMEP+4gxKhJWbpJY91KlBwYWsO
	 FBj5BltEIu7VOYf+f4ozIIRt5Av1hVhp/lugxd0/WZDI68wAPkgoUO6akeQyioW5dI
	 2wyUXHIH6HP7Q==
Date: Fri, 23 Feb 2024 10:07:32 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v4 07/25] fsverity: support block-based Merkle tree
 caching
Message-ID: <20240223180732.GC1112@sol.localdomain>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-8-aalbersh@redhat.com>
 <20240223052459.GC25631@sol.localdomain>
 <qojmht7l3lgx5hy7sqh5tru7u3uuowl5siszzcj3futgyqtbtv@pth44gm7ueog>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qojmht7l3lgx5hy7sqh5tru7u3uuowl5siszzcj3futgyqtbtv@pth44gm7ueog>

On Fri, Feb 23, 2024 at 05:02:45PM +0100, Andrey Albershteyn wrote:
> > > +void fsverity_drop_block(struct inode *inode,
> > > +		struct fsverity_blockbuf *block)
> > > +{
> > > +	if (inode->i_sb->s_vop->drop_block)
> > > +		inode->i_sb->s_vop->drop_block(block);
> > > +	else {
> > > +		struct page *page = (struct page *)block->context;
> > > +
> > > +		/* Merkle tree block size == PAGE_SIZE; */
> > > +		if (block->verified)
> > > +			SetPageChecked(page);
> > > +
> > > +		kunmap_local(block->kaddr);
> > > +		put_page(page);
> > > +	}
> > > +}
> > 
> > I don't think this is the logical place for the call to SetPageChecked().
> > verity_data_block() currently does:
> > 
> >         if (vi->hash_block_verified)
> >                 set_bit(hblock_idx, vi->hash_block_verified);
> >         else
> >                 SetPageChecked(page);
> > 
> > You're proposing moving the SetPageChecked() to fsverity_drop_block().  Why?  We
> > should try to do things in a consistent place.
> > 
> > Similarly, I don't see why is_hash_block_verified() shouldn't keep the
> > PageChecked().
> > 
> > If we just keep PG_checked be get and set in the same places it currently is,
> > then adding fsverity_blockbuf::verified wouldn't be necessary.
> > 
> > Maybe you intended to move the awareness of PG_checked out of fs/verity/ and
> > into the filesystems?
> 
> yes
> 
> > Your change in how PG_checked is get and set is sort of a
> > step towards that, but it doesn't complete it.  It doesn't make sense to leave
> > in this half-finished state.
> 
> What do you think is missing? I didn't want to make too many changes
> to fs which already use fs-verity and completely change the
> interface, just to shift page handling stuff to middle layer
> functions. So yeah kinda "step towards" only :)

In your patchset, PG_checked is get and set by fsverity_drop_block() and
fsverity_read_merkle_tree_block(), which are located in fs/verity/ and called by
other code in fs/verity/.  I don't see this as being a separate layer from the
rest of fs/verity/.  If it was done by the individual filesystems (e.g.
fs/ext4/) that would be different, but it's not.  I think keeping fs/verity/
aware of PG_checked is the right call, and it's not necessary to do the half-way
move that sort of moves it to a different place in the stack but not really.

- Eric

