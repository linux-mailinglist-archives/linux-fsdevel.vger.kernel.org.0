Return-Path: <linux-fsdevel+bounces-76347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMJ5EEChg2kLqQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 20:42:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F5AEC2A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 20:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B22053071818
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56473428824;
	Wed,  4 Feb 2026 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px0JRhMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D509E34FF41;
	Wed,  4 Feb 2026 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233879; cv=none; b=jvvaE1h3f9u3a7oZvsecVmUxbmiTD5MeKNuTvSZP9Kn/8kOAUXf6AsYS6FzpODmIdc760gRs2ofzhIWNJpFlOhbNpho6u2B9IAonpSS7XVPPfZDp5PBUXl95J7h3shUJ/ofK6OwTVU7Piba+f3G5z7wVg/H0sf6SUJisOB4w1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233879; c=relaxed/simple;
	bh=kyjQMwBA5XAF2Mj6r8AAUCzZzpsC581dYFsmNNFzZZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0G+jl2aA6oy3R7GgBV9vSqePVeOs9oE26dsu+3pRy+RiFugoxr+x7EDYS12ljbuEh2w/pV/oYlmc4FdMzaHxIRh5uU2T54SZ2CIKt6XfzFuRBEmN/d9UhLeVOguYMtC+yX5Ws8laShumVjT+DRVg910vcMfib8yBgQfsHFgweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px0JRhMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9D3C4CEF7;
	Wed,  4 Feb 2026 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770233879;
	bh=kyjQMwBA5XAF2Mj6r8AAUCzZzpsC581dYFsmNNFzZZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=px0JRhMbubuDAlbbU9kHpvQ9OnJd8hfxJgw0/Xa8qU5Cv/wjcRzjvB5WY6FQLroWB
	 RQ0W5XzwgpLf19sgMeTrrzQ9IyvDIK3VHBVM1b6z/AfencfcWXCUWyOjGIipHfLjwq
	 O35AQaMtYo8vAKTJrVYuOUHxB/X03l53A3H2tfg/LI/94SUYv0KWbeYRKQlpPgc4/Y
	 WD0uS87AmlXmsD82B7fe7ylDJhB3jRDI6ugyPirHCOvFWGgtq1/hsJmFHRYKan2Lf/
	 U3QRUg+4783Djq+QWiIX+WIngxuXAfL4HnSfcR6i4c3XCitmW+qAzzWKa0AUFvgt3u
	 lpQxZP6c6gXzw==
Date: Wed, 4 Feb 2026 11:37:22 -0800
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
Message-ID: <20260204193722.GB2193@sol>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202211423.GB4838@quark>
 <aYNdmk1EE5etfUYE@casper.infradead.org>
 <20260204190218.GA2193@sol>
 <aYOZdUTrvIjq82AE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYOZdUTrvIjq82AE@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76347-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4F5AEC2A8
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 07:09:41PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 04, 2026 at 11:02:18AM -0800, Eric Biggers wrote:
> > Aligning to the opening bracket is the usual style as agreed on by the
> > kernel community.
> 
> Says who?  I've been part of the kernel community since 1997.  I've
> never heard of such a thing.
> 
> > It's 2026.  We generally shouldn't be formatting code manually.  We have
> > better things to do.
> 
> I agree!  Stop changing it unnecessarily.
> 
> > If you're going to insist on ad-hoc formatting of argument lists, you'll
> > need to be more specific about where and how you want it to be done.  It
> 
> Two tabs.  That's it.

I've changed ext4_mpage_readpages() and f2fs_mpage_readpages() to use
your requested ad-hoc formatting.  What else you want, I'm not sure.  In
the code I maintain I just do it the standard way.

- Eric

