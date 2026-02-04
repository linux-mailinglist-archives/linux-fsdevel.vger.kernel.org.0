Return-Path: <linux-fsdevel+bounces-76344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NoQJEueXg2lnpwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 20:03:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F52EBCE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 20:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CA38300B466
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5471427A0C;
	Wed,  4 Feb 2026 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iofq7J9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA002DF707;
	Wed,  4 Feb 2026 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231775; cv=none; b=B3ubt/4F9GUsosQg20yEuhcYNymC7q0HU6nHqWos6QYMrgzZYpPGbUVI4uVKBExxx1Tz16TMRFiDeStIk58zuxKupTKWiGX+Hbdm7Q0d3wrv407PdgtDBlm/DugJK7yCIeSkOKYTneKUFPlanFBMtR+nTvgZb+U2MVRQmATb3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231775; c=relaxed/simple;
	bh=fvuVHItsYXpPWArU/0i6pDSN5I363ZzcoNvZNPppv2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s05oJA4DObHl4Sn9fBGfw2usZ2RtuT4r5ZHVIODr6GpEDqmFLYhppPpNOcs0cI+oqfc5rsxgZMuLjpqM/aU86vuLkbRvp8bfDABTn2dSC0E5PYmsv/qGIEmNxh2wvmn2xRo8v7Cz59f+ZFSv6xUUAFC5a8mtD2taru2Hfw+8ilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iofq7J9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF1DC4CEF7;
	Wed,  4 Feb 2026 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770231775;
	bh=fvuVHItsYXpPWArU/0i6pDSN5I363ZzcoNvZNPppv2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iofq7J9ZB5Q1dLAB7Qy2uln0MXvVcL8qlvWkKB9VOYrtveQA4p5R4JTmTGe9Gx4mC
	 Ly679d9E5LOL2n1FGUeWmohBZgFgVIkdBvw+55f1to50oLS5fY9G4zPv+d8uBnGhzo
	 LmRcgveKUt7s6aE5+Pbkm904SsxtQlB04KUAu9gbIY+U0c0q7pTnP7rUIE6DY7CvT7
	 AWNUxuB028+w9gFncQbilhM43+W4aUnf0kqw0ju5I8u+DZUqUGksc3l8vdRI8X2u9n
	 YEUuj8GIaw8EwBwmU7aB8JU/OP0avF4KzqkYdpw5Kzh4D/gZTea5d4fWopgA3+BMmk
	 oE3OICQWQ9TCg==
Date: Wed, 4 Feb 2026 11:02:18 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: fsverity speedup and memory usage optimization v5
Message-ID: <20260204190218.GA2193@sol>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202211423.GB4838@quark>
 <aYNdmk1EE5etfUYE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYNdmk1EE5etfUYE@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76344-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1F52EBCE8
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 02:54:18PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 02, 2026 at 01:14:23PM -0800, Eric Biggers wrote:
> > - Used the code formatting from 'git clang-format' in the cases where it
> >   looks better than the ad-hoc formatting
> 
> clang-format makes some bad choices.
> 
> >  static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
> > -		struct readahead_control *rac, struct folio *folio)
> > +				struct readahead_control *rac,
> > +				struct folio *folio)
> 
> Aligning to the opening bracket is one of them.  If anything changes
> in a subsequent patch (eg function name, whether or not it's static,
> adding a function attribute like __must_check, converting the return
> type from int to bool), you have to eitheer break the formatting or
> needlessly change the lines which have the subsequent arguments.
> 
> Also, you've consumed an extra line in this case.  Just leave the
> two tab indent, it's actually easier to read.

Aligning to the opening bracket is the usual style as agreed on by the
kernel community.  This should also be clear if you look at the existing
style in all the files this patchset touches.  It's not done exclusively
but is the more common way.  clang-format just follows that.

It's 2026.  We generally shouldn't be formatting code manually.  We have
better things to do.

If you're going to insist on ad-hoc formatting of argument lists, you'll
need to be more specific about where and how you want it to be done.  It
certainly doesn't make sense in files that are already using the normal
style exclusively, for example.

- Eric

