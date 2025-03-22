Return-Path: <linux-fsdevel+bounces-44748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B0A6C6AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 01:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96DB4663F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A95234;
	Sat, 22 Mar 2025 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k7JFItGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E12E3395;
	Sat, 22 Mar 2025 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742603386; cv=none; b=Pv0RkvLiOxiX/wOkHBfdGEL0q/OG5c3E7uhcyJCWdboV6TnlhesTSIbeO4HCsekNE//ZauAgu/1NZqGjto7vfiZK81vsN4dzZU4LmCsBW6Dr6XePHTyVYzEtHG5SDVm00jN43asifvZvqPsI/GdYGVhJ8UjhSky9BuoiWm5+mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742603386; c=relaxed/simple;
	bh=1wO3VeLyZAR6O8DUGa6X8aEykK/vkscIWslchaJETFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9nY5FSuIKuf4Kss3RYHVmhZbqIVXgWzZi1u35uS3EGuxpNLP7PdJfMZqboQ+3T35pEC18mBPTURDMaJSXQ9sgqQiXk1U0hUE7Gkqy0w2iRG5iCzWUUUjBb72E88ZhJwXvPEiUwSPNrCCMYXdQ5PxBe5TjgCdMFTE7ZWa8lWiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k7JFItGY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UvCrbP//p64mKyH3s7VBxWHRURwL3UQJG85ZRT/1T7M=; b=k7JFItGY5lzJm16iqbqZQ5dL+S
	lI5ddTvklKQseSWVhVNiA9mmlqW1DTT+2ISKsF3SAFLIxocEHHEZOpRzoy3xTP6iKU3VRRI6boxQs
	MIc+05JckoMJyvWvi0JC9Q+WuXSb5eLsmp9QCco8PHfSfCrp2nJ7VNedj+bHGfLMxIGycaTi3nfgQ
	FVGpPpDBoCfcP4KT6FrjTTEyHtPqED7CUbuf6xDu+pEtQ0Jryu1LgSMXiDiIz4opnzqlgD7okmNdI
	plXpuxslUDfOAK3Z5Me9izYifOxjNdlr0CtT18daVTGabtWOHBPZRhiI/5GLXw0kEwFKqfJ4Hz/5K
	K2gXE67A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tvmk9-0000000BBpN-1NqU;
	Sat, 22 Mar 2025 00:29:41 +0000
Date: Sat, 22 Mar 2025 00:29:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
Message-ID: <20250322002941.GD2023217@ZenIV>
References: <20250319031545.2999807-2-neil@brown.name>
 <20250319031545.2999807-1-neil@brown.name>
 <3170778.1742479489@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3170778.1742479489@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Mar 20, 2025 at 02:04:49PM +0000, David Howells wrote:
> NeilBrown <neil@brown.name> wrote:
> 
> > Also the path component name is passed as "name" and "len" which are
> > (confusingly?) separate by the "base".  In some cases the len in simply
> > "strlen" and so passing a qstr using QSTR() would make the calling
> > clearer.
> > Other callers do pass separate name and len which are stored in a
> > struct.  Sometimes these are already stored in a qstr, other times it
> > easily could be.
> > 
> > So this patch changes these three functions to receive a 'struct qstr',
> > and improves the documentation.
> 
> You did want 'struct qstr' not 'struct qstr *' right?  I think there are
> arches where this will cause the compiler to skip a register argument or two
> if it's the second argument or third argument - i386 for example.  Plus you
> have an 8-byte alignment requirement because of the u64 in it that may suck if
> passed through several layers of function.

Not just that - you end up with *two* struct qstr instances for no good reason,
copying from the one passed by value field-by-field into the other one, then
passing the *address* of the copy to the functions that do actual work.

