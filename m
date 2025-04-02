Return-Path: <linux-fsdevel+bounces-45496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31138A7890C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 09:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE33A7D20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36E23373F;
	Wed,  2 Apr 2025 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJhyOYiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBC1F5FD;
	Wed,  2 Apr 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579876; cv=none; b=ai4UpWcvHOPyO22cQyyKcKx0cs1tdDQycGV2ckoZmgQ3D0qpUPeK/HdyFK8JDUltUZoD8aOrQAIRAlMnM/YVu8hZwOPMuzeENdAVclULFaCc5OyQh1SONnY/WDG2yfbWivoZjCcrwuUG/H8Uo9IQrPGkDW6JczPBmaMp57WglE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579876; c=relaxed/simple;
	bh=if4iE8GFLeEYqgEtWU6I3zan7yFQRGDKoOSGy9WjE9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMqY8T1yDSIHViJBq2uf9umsUjlbWPnp9hIM2IYemqB5YbZatp8+Iaanml9wslOoFDWuilHAs3+zaxEY4PSqu+pPeD0KNmEa2vcy91DpBqUUnzNii4B74djyAt0Tton9T+FNNyXpYqR2xhI70DdP5kZfmqurUl/kcBuw/AU5RVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJhyOYiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E909CC4CEDD;
	Wed,  2 Apr 2025 07:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743579876;
	bh=if4iE8GFLeEYqgEtWU6I3zan7yFQRGDKoOSGy9WjE9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJhyOYiERbr+4ebkXx6NUFTktH6jMb2BQeMIqDWCLsx1yhBE6ebiUYIGut/pXpjS6
	 pyTKPwxDI8nGvMuN9MT62yv9VDOEI16yiHhLFu1n9yoSnqHsRJHReIWTPDHlUUkgfd
	 8GK8OLTFRatCMNbb4qaijP3BbeEYI4JMgoZczdJwsSdbMgY9UJmnjmkFYDVC+qoqOe
	 6qNnqEIT94ru47W/ugSjMEpPAWCtfWzC7+CIi+m6rDSS7vdQbAuI7E5TRt30lO/uyr
	 gTohv0DTQVXOoKnmTkIIon/HBDWi508fhmckLDHHNzOekDGrTi10a1Vi9Hhy/My/wM
	 UvJkRFVUFeOeA==
Date: Wed, 2 Apr 2025 09:44:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 2/2] efivarfs: support freeze/thaw
Message-ID: <20250402-dilemma-korallen-0757411aa8fe@brauner>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250331-work-freeze-v1-2-6dfbe8253b9f@kernel.org>
 <dc292375744c121218510580e617c7a2791ea2f5.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc292375744c121218510580e617c7a2791ea2f5.camel@HansenPartnership.com>

On Tue, Apr 01, 2025 at 03:31:13PM -0400, James Bottomley wrote:
> On Mon, 2025-03-31 at 14:42 +0200, Christian Brauner wrote:
> [...]
> > +	pr_info("efivarfs: resyncing variable state\n");
> > +	for (;;) {
> > +		int err;
> > +		size_t size;
> > +		struct inode *inode;
> > +		struct efivar_entry *entry;
> > +
> > +		child = find_next_child(sb->s_root, child);
> > +		if (!child)
> > +			break;
> > +
> > +		inode = d_inode(child);
> > +		entry = efivar_entry(inode);
> > +
> > +		err = efivar_entry_size(entry, &size);
> > +		if (err)
> > +			size = 0;
> > +		else
> > +			size += sizeof(__u32);
> > +
> > +		inode_lock(inode);
> > +		i_size_write(inode, size);
> > +		inode_unlock(inode);
> > +
> > +		if (!err)
> > +			continue;
> > +
> > +		/* The variable doesn't exist anymore, delete it. */
> 
> The message that should be here got deleted.  We now only print
> messages about variables we add not variables we remove.  I get that
> the code is a bit chatty here, but it should either print both the
> removing and adding messages or print neither, I think.

Ok, I added the deletion printk line back.

