Return-Path: <linux-fsdevel+bounces-41304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B5A2D9AC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 00:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D553A76FB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FA5191F92;
	Sat,  8 Feb 2025 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gEWJxoTP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E7243365;
	Sat,  8 Feb 2025 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739057141; cv=none; b=eT33Mw0tr4PlEDUSxnTUZibfy1WsSzDFo4qGElv+Q7hXO6+r+INx63rCAZcaTlGLZwvVZXzuERwIF4h17RXpCilJN2PZF3c89bUHugjLH1cCQj18NQ07BEAfu2QK/SP9/6IAVSs7QAZ4TJsjJVcQRU2S5uIl4ZbTFATeKXZOWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739057141; c=relaxed/simple;
	bh=ZB70q5kI0+nTD9S9fVwNrnaQfAKOMOHgbuQVSy2Grqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0jBEE/PaHWWatYX6kTLuGw0/3+RvPDsCoq2BZU/EkIMdesbXjUNevWk6NjKSrnLU8FZMl1rLNZYA6e7aE8URoBBl7tzV62YIDQYUi3sBOvTELDVYQS+mlZzr0yiWhC7Zd+aKdhRXF+/NEqE++Sje4KqsNvLUkE+7xCkq0jZ0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gEWJxoTP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HOu5RQfF0uK6Wbo4bJOtLKp5NZLWCNR/4eetZQ/Aivk=; b=gEWJxoTPm96dRqPeyS7T1gYu+E
	iKFs94+yXUQMTvOri9ALJ5I6PeCd+9ltiSx2xvlg4Nz0Kk0yfVsx/6zXOAdd6MxdAho1I8FQlkPtk
	goc3EFhevXqBuvTHOVKOmFh8fBDolJKD6m414Llv8WwD1Qu/k38XJdn8V3EfNmR/KYBcb1Jonbe6t
	tA5AqHpcGTyQ5/ZPWPQnV4LE1d7rLTS/72IewH0DClwBDfmLpSBl+IAGWB2eUrb0XOqnosjOpDkQ6
	1Gxek1abtRUAMCkDi1XeVHZAU5bVhf2TEw84QPE1AJF9LYbbosd/G30Ql9LrqwMRq68dSAACNPuf+
	T8yBqmwg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tguCf-00000007ugd-0uHP;
	Sat, 08 Feb 2025 23:25:37 +0000
Date: Sat, 8 Feb 2025 23:25:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/19] VFS: Ensure no async updates happening in
 directory being removed.
Message-ID: <20250208232537.GS1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-15-neilb@suse.de>
 <20250207210658.GK1977892@ZenIV>
 <20250208220653.GQ1977892@ZenIV>
 <CAHk-=whEbj9p33Cn_P4PawBqkav8zQq5+WjtzqYCK0o621p1kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whEbj9p33Cn_P4PawBqkav8zQq5+WjtzqYCK0o621p1kw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Feb 08, 2025 at 02:30:39PM -0800, Linus Torvalds wrote:
> On Sat, 8 Feb 2025 at 14:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > OK, I realize that it compiles, but it should've raised all
> > > kinds of red flags for anyone reading that.
> 
> Well, it's literally just missing a ';' so, the "red flag" is "oops,
> nobody noticed the typo".

Sure - what I'm saying is that this is visually wrong; "red flag" as in
"WTF am I looking at here?" when scrolling through the patch.

