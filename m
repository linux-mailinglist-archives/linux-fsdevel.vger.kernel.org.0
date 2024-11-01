Return-Path: <linux-fsdevel+bounces-33391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD69B8879
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1EAB222F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9250E132103;
	Fri,  1 Nov 2024 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s8KW2knD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56262171
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 01:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424486; cv=none; b=cwfR9vyhJdDUKZZCL3AckLExfHY/ML5IDPBZcnGtwZ+jM4aKJWGiJ06PZpmfHFXWEIzJYsaSDYghhSu9r/LmEJmhmw5RJlpu3hd1nBgw5v7FBgf5SUFW0EAP6g2dKmnq+NHrZ0wvLJGYrAXhGpEDze1PE2YhAL6U65ImZsQgkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424486; c=relaxed/simple;
	bh=cjzeSCSeAhDdw3242MgPmQWmUOqXelWc+JhEZAtcyxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMUr1LrTr6hhZKLnMBfg9kzpoMVsEfVzPdfNYqlAIi9qsZQKyjNgr2xXy1sKtt03696xKOYYfRLlXtoX58dZ0xb7zabUWX607tK1D6dVRaa9aLlANJv8pMSb6voHcVuo6mWPQBKaLbB0EUYZiC6vaQJLKelxyA5JFBdpFzM+eQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s8KW2knD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QkZHzINJsI++VALBL9KJ72moftSAqxJIRL0oZfjhnrw=; b=s8KW2knDiGm7+rgnSgDYBtlBjY
	2R6p7jeJyzk7weCaVj9NmTL7Y3KNS4RGSAvgwU0mmw8IEnDyRBFLqZACcxA9iLAwWeZCF4GMw/b/h
	G1OHHSMqv1/g0I/rPrBGYGo/J4y1F4APyzzqFfT8r/EVISy/15yAcOaAI9mm3S8ai8IpeUqQSd9r9
	H00XpRQa3VThyhtz87MljFGQ7NW+9bk5dl1hqngLiBZqzVAdTzwnvJ6HNuuRLfXBQqkPQ8Z8cnc18
	EcgXp1BHS9m8tY1PDyh3yujOzMuOPXco8evxMpoII6DlvI+uF94qUlAG7NI+cG+TGwvRt9aaBVjH1
	Yo9KqxaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6gSD-00000009wTh-0JTc;
	Fri, 01 Nov 2024 01:27:57 +0000
Date: Fri, 1 Nov 2024 01:27:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20241101012757.GO1350452@ZenIV>
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031060507.GJ1350452@ZenIV>
 <CAHk-=wh-Bom_pGKK+-=6FAnJXNZapNnd334bVcEsK2FSFKthhg@mail.gmail.com>
 <CAHk-=wj16HKdgiBJyDnuHvTbiU-uROc3A26wdBnNSrMkde5u0w@mail.gmail.com>
 <20241031222837.GM1350452@ZenIV>
 <CAHk-=wisMQcFUC5F1_NNPm+nTfBo__P9MwQ5jcGAer7vjz+WzQ@mail.gmail.com>
 <CAHk-=wgXEoAOFRkDg+grxs+p1U+QjWXLixRGmYEfd=vG+OBuFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgXEoAOFRkDg+grxs+p1U+QjWXLixRGmYEfd=vG+OBuFw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 31, 2024 at 03:17:18PM -1000, Linus Torvalds wrote:
> On Thu, 31 Oct 2024 at 12:34, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So I'd rather start with just the cheap inode-only "ACL is clearly not
> > there" check, and later if we find that the ACL_NOT_CACHED case is
> > problematic do we look at that.
> 
> Actually, if I switch the tests around so that I do the permission bit
> check first, it becomes very natural to just check IS_POSIXACL() at
> the end (where we're about to go to the slow case, which will be
> touching i_sb anyway).
> 
> Plus I can actually improve code generation by not shifting the mode
> bits down into the low bits, but instead spreading the requested
> permission bits around.
> 
> The "spread bits around" becomes a simple constant multiplication with
> just three bits set, and the compiler will actually generate much
> better code (you can do it with two consecutive 'lea' instructions).
> 
> The expression for this ends up looking a bit like line noise, so a
> comment explaining each step is a good idea.
> 
> IOW, here's a rewritten patch that does it that way around, and thus
> deals with IS_POSIXACL() very naturally and seems to generate quite
> good code for me.

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

