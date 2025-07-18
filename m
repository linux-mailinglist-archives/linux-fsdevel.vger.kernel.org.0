Return-Path: <linux-fsdevel+bounces-55412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C661B09E83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2235D1C4638F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA52949E5;
	Fri, 18 Jul 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ5080bn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258A10A1E;
	Fri, 18 Jul 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829135; cv=none; b=mhgWMYNapBWqJkY9lPk3xBPCgqZyhorcgRkc6pGyo+BYYng0gEzi815Xw2Su5UpCEY2tc2V6B4FL+xx0TKxbbaXS2Imo1Z1evLvph7wK2kfIEXG9ZYiu8CrqBrXE5Dh5fz9Nrn2rnYuZRnklzezQ1PdCucHOckjetFffT27xJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829135; c=relaxed/simple;
	bh=d54BYXdU7kW1KeZKmSpEIlgiJLdADXZI7neQyNFC5wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HptThgfn6CIWb1J/oBsqi1Qw8Na0pZDQzGXZSFUv2KIlq5aL7sqwv5rjvDiph6jI0044hEH/ZxjeBqf1Vlt8S/pL7htlVqyc8OBy2ET/ksxUuCQc414frPhLZdioylGbPLkQr6MRcS4g3zdk4vQbYSiQxwYJI9a1yTSrzQ3ChEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ5080bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D24C4CEEB;
	Fri, 18 Jul 2025 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752829135;
	bh=d54BYXdU7kW1KeZKmSpEIlgiJLdADXZI7neQyNFC5wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQ5080bnf21h6iQiWwFN6T+tTnivyhZo99crGvCzsIVtoyd/jtKtV5mdnX2Q/avLC
	 pqCdnD2tj165YXRZhGiXDMB4mRuPR53345CjICGd+zZ8ywyjfmaXRhOjnKS5Bnr80F
	 bKyomPS9p7d9vd5nqgBl3qtD4OAsN3jHGNIEZxYZv4pJa4nbv9QQrZlo7he6Kor+XD
	 TR/xubAb2/fg/Aph0TElkwKo1/tqfZuXLH5bK4+Y+BJXMlWd79Voo4ILE4lRN19EGh
	 1sc709O2GJFxfNnEsbpKfqkTJFBxXxDrVgwiUh9f1cXUD0Gjki/jISPsEP7hwA/qkl
	 bmYy05XPuUlWA==
Date: Fri, 18 Jul 2025 10:58:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, fsverity@lists.linux.dev
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250718-infotag-morsen-d9e7d9961889@brauner>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250716112149.GA29673@lst.de>
 <20250716-unwahr-dumpf-835be7215e4c@brauner>
 <q4uhf6gprnmhbinn7z6bxpjmdgjod5o7utij7hmn6hcvagmyzj@v5nhnkgrwfm5>
 <20250718-funkkontakt-gehrock-c78ddcf4e009@brauner>
 <20250718083206.GA23501@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250718083206.GA23501@lst.de>

On Fri, Jul 18, 2025 at 10:32:06AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 18, 2025 at 10:24:47AM +0200, Christian Brauner wrote:
> > We can't just keep accumulating more and more stuff in our core
> > structures. The bpf people are breathing down our neck to put more
> > things in struct inode and I'm sure the next thingamabob is already in
> > the works and we need a way to push such stuff out of core struct inode.
> 
> Agreed.  And as mentioned I'like to think even further and avoid
> having these optional bits in the fs inode unconditionally if there
> isn't a good reason for that.  I mentioned quotas before, but an even
> more extreme case is fsverity.  If I understand the fsverity use case
> correctly it is usually used for a very small number of files in the
> system only, and you'd usually do bulk reads from them.  So instead of
> bloating the inode, be that the generic one or that of the file systems
> that use it, why not have a global rhastable index by the inode address
> to look it up?  Compared to the actual hash generation and verification
> a lockless hashlookup is complete noise, but we'll save a lot of
> memory.

My plan is to just push fsverity and fscrypt out via offsets. If someone
wants to wade through the pain of then adding an rhashtable and getting
rid of the offset, then fine by me. But I don't want the removal of
verity and crypt to be gated on that. And I didn't understand you as
wanting that either, I hope?

For anything new pushing for alternative lookup structures is fine.

