Return-Path: <linux-fsdevel+bounces-15225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99088AB63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DE71FA1F44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C5C5A0EA;
	Mon, 25 Mar 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVfZdiPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A90E42058;
	Mon, 25 Mar 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382788; cv=none; b=sJFrT+aXUayJxyHWLd/8iTwF0pm3Mvel61zwZN0ea53WY/7NWmCpZNaXmyA8P022fnIXSoLjHfNLtFcWO8ylD/C+jDJN1Ls4166OkzBNv7xbRdUR6a+axXZn10yr4B3zPg4NZAqwXAShbIyfUR5JsI4w3TpxnMwvpU7YP2UENi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382788; c=relaxed/simple;
	bh=1PB12qwX1m7ibvKTM38Q6edyBz/Zn9xgeMYGi1UalZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY3X/tNrP2ktAKfZ2pf9r8szIfTlUGgtVdaRWutr9ANfqwlpFdokT62L+8Aw4ZO+mjikN5BlNAUwQjxKsVepJg1Hjg1s13QO+m0re8RKjUiN78oRuPsPGAYDWIGcVoitVUWJL4EV2Th7PoRsD7okcGA7+qEhy/MitqLuI+ux/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVfZdiPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E5BC433F1;
	Mon, 25 Mar 2024 16:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382788;
	bh=1PB12qwX1m7ibvKTM38Q6edyBz/Zn9xgeMYGi1UalZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVfZdiPMmiCdovQqrgQl0y4VTUefn0+efhOIEy23YjeklTAIaxz2QyVeYn3xIvQ8V
	 crFQl6aO3LIaA1g91QX7ErXLxDeZBoZZcPpb9ZEz4qXLBsH4u5Q0bHOxb2wV0o/gR5
	 51aTA9O8xY8yr4CwNZrBczwQ79docEW2zvxtN8R4ZWDfbsA0Q2UPJij3mhKVW/ergS
	 6WNrdfQARy1iiVkPLXtcdvtSep9r5tzHsjPOr35+S0plnyso7q4bQC62FUtR9G1GB3
	 3mBjfdh5ZqoPeXbKy7zUkrxG0V4B9HtCwluV8jspZKKNYGAOttiItywQTjLvLoCjuf
	 juf0P4dlpSPKA==
Date: Mon, 25 Mar 2024 17:06:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@manguebit.com>, 
	Christian Brauner <christian@brauner.io>, Mimi Zohar <zohar@linux.ibm.com>, 
	Paul Moore <paul@paul-moore.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Subject: Re: kernel crash in mknod
Message-ID: <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3441a4a1140944f5b418b70f557bca72@huawei.com>

On Sun, Mar 24, 2024 at 04:50:24PM +0000, Roberto Sassu wrote:
> > From: Al Viro [mailto:viro@ftp.linux.org.uk] On Behalf Of Al Viro
> > Sent: Sunday, March 24, 2024 6:47 AM
> > On Sun, Mar 24, 2024 at 12:00:15AM -0500, Steve French wrote:
> > > Anyone else seeing this kernel crash in do_mknodat (I see it with a
> > > simple "mkfifo" on smb3 mount).  I started seeing this in 6.9-rc (did
> > > not see it in 6.8).   I did not see it with the 3/12/23 mainline
> > > (early in the 6.9-rc merge Window) but I do see it in the 3/22 build
> > > so it looks like the regression was introduced by:
> > 
> > 	FWIW, successful ->mknod() is allowed to return 0 and unhash
> > dentry, rather than bothering with lookups.  So commit in question
> > is bogus - lack of error does *NOT* mean that you have struct inode
> > existing, let alone attached to dentry.  That kind of behaviour
> > used to be common for network filesystems more than just for ->mknod(),
> > the theory being "if somebody wants to look at it, they can bloody
> > well pay the cost of lookup after dcache miss".
> > 
> > Said that, the language in D/f/vfs.rst is vague as hell and is very easy
> > to misread in direction of "you must instantiate".
> > 
> > Thankfully, there's no counterpart with mkdir - *there* it's not just
> > possible, it's inevitable in some cases for e.g. nfs.
> > 
> > What the hell is that hook doing in non-S_IFREG cases, anyway?  Move it
> > up and be done with it...
> 
> Hi Al
> 
> thanks for the patch. Indeed, it was like that before, when instead of
> an LSM hook there was an IMA call.

Could you please start adding lore links into your commit messages for
all messages that are sent to a mailing list? It really makes tracking
down the original thread a lot easier.

> However, I thought, since we were promoting it as an LSM hook,
> we should be as generic possible, and support more usages than
> what was needed for IMA.

I'm a bit confused now why this is taking a dentry. Nothing in IMA or
EVM cares about the dentry for these hooks so it really should have take
an inode in the first place?

And one minor other question I just realized. Why are some of the new
hooks called security_path_post_mknod() when they aren't actually taking
a path in contrast to say
security_path_{chown,chmod,mknod,chroot,truncate}() that do.

