Return-Path: <linux-fsdevel+bounces-19249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA288C1E20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 08:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330CC282F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98431311BA;
	Fri, 10 May 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o4C5hjbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305F1361;
	Fri, 10 May 2024 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322805; cv=none; b=pOyWhvtTabb0h2rlzerqffCc9J2ZIs4xtC+gbDGpTZOtke5rwQCPPg4r5hFSmh6jWE1xCbq3v3cPSjougbjLr9M9/0Fk2S9IU4uXoIgTyPAuQBbdthI+jbk3RCLW+Gg/j8r9IJKwS3sLe1OhbOV/CwcM9vj2MKpsz9uALUMBy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322805; c=relaxed/simple;
	bh=qdVy5lQR/hkHET0xFeljYrMZlyEIN4uWW3qGUTY1qr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF4nbbl4a8+PdC7avOTP7gsa17CeOqMZJmF2Mh9ZPjy2uDwbtoji/eo4Y4UWF6TJWRburMNoxsmVV2gbP38JPFWTD+k1AmUD/ZZBb/GwxalFIZZcHdvxG4Q2mAV4mWY+tP2F6hELfKMMrLhPrME1MgibSbSBgTyoMt8j4sZonAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o4C5hjbt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MKNeISn8K7vuJhQ8g5TvGG841WrKg3O3R8hz7bMsFas=; b=o4C5hjbtyaqXhEkAfrTLLtFIK6
	bimUmCocM02fBDgO7tK6Ktztj2cTyuH2d5gknANN4i9jY+sj1H1L3gOw4NNjdyUpc/5OxoLl4ieNH
	B8Vk+r19IZDaLJ89xwnL4yPDFD8EhEtqFe5SA0r8YbaLyMh3drUjZKZqVultnO9EWd1IECsHLVsVN
	kHgsEGevmmSAbT+DI/vuSh/JZduIJOyq6Wzhw8rZpGdqY0xNn99Adp+BiFPL3eDhX5i6qh3cPPcXp
	fGHcDgVlflp/1GKo7fQUFLkD7Do2kTbGAlkRWa0Hh29V4EnQbH00p3XjOsKnLVG1/efw86d9eGTna
	SDuIl6oQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5Joe-002ACy-2z;
	Fri, 10 May 2024 06:33:13 +0000
Date: Fri, 10 May 2024 07:33:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libfs: fix accidental overflow in offset calculation
Message-ID: <20240510063312.GX2118490@ZenIV>
References: <20240510-b4-sio-libfs-v1-1-e747affb1da7@google.com>
 <20240510004906.GU2118490@ZenIV>
 <20240510010451.GV2118490@ZenIV>
 <6oq7du4gkj3mvgzgnmqn7x44ccd3go2d22agay36chzvuv3zyt@4fktkazj4cvw>
 <20240510044805.GW2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510044805.GW2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 10, 2024 at 05:48:05AM +0100, Al Viro wrote:
> On Fri, May 10, 2024 at 03:26:08AM +0000, Justin Stitt wrote:
> 
> > This feels like a case of accidental correctness. You demonstrated that
> > even with overflow we end up going down a control path that returns an
> > error code so all is good.
> 
> No.  It's about a very simple arithmetical fact: the smallest number that
> wraps to 0 is 2^N, which is more than twice the maximal signed N-bit
> value.  So wraparound on adding a signed N-bit to non-negative signed N-bit
> will always end up with negative result.  That's *NOT* a hard math.  Really.
> 
> As for the rest... SEEK_CUR semantics is "seek to current position + offset";
> just about any ->llseek() instance will have that shape - calculate the
> position we want to get to, then forget about the difference between
> SEEK_SET and SEEK_CUR.  So noticing that wraparound ends with negative
> is enough - we reject straight SEEK_SET to negatives anyway, so no
> extra logics is needed.
> 
> > However, I think finding the solution
> > shouldn't require as much mental gymnastics. We clearly don't want our
> > file offsets to wraparound and a plain-and-simple check for that lets
> > readers of the code understand this.
> 
> No comments that would be suitable for any kind of polite company.

FWIW, exchange of nasty cracks aside, I believe that this kind of
whack-a-mole in ->llseek() instances is just plain wrong.  We have
80-odd instances in the tree.

Sure, a lot of them a wrappers for standard helpers, but that's
still way too many places to spill that stuff over.  And just
about every instance that supports SEEK_CUR has exact same kind
of logics.

As the matter of fact, it would be interesting to find out
which instances, if any, do *not* have that relationship
between SEEK_CUR and SEEK_SET.  If such are rare, it might
make sense to mark them as such in file_operations and
have vfs_llseek() check that - it would've killed a whole
lot of boilerplate.  And there it a careful handling of
overflow checks (or a clear comment explaining what's
going on) would make a lot more sense.

IF we know that an instance deals with SEEK_CUR as SEEK_SET to
offset + ->f_pos, we can translate SEEK_CUR into SEEK_SET
in the caller.

