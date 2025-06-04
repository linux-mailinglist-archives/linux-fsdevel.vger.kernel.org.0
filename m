Return-Path: <linux-fsdevel+bounces-50680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F0ACE60A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4083A6295
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6FC213E90;
	Wed,  4 Jun 2025 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EWj/Z51u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72511111BF;
	Wed,  4 Jun 2025 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749071514; cv=none; b=mTtV1Jd4G1NTeHjJtgUtwcwNpm1RN+3QN2Spwf/MntSvTPoUsnqJa2Xo4BCmYIlmDkH8mry9T7tZLWr5IfZhz2oWJi/oFyWr4tcbM7bgPiSgt6bFhOQaTYi7c1/DiOVAy72DPiJe7/PK5234cV7a3LcQAaDBUu9X7jen7LY/yH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749071514; c=relaxed/simple;
	bh=hLLxmyMhMOaQGxp9k0KLq1c/t6gV0P33NLDka6zpeiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npGhK7y5xd57LZc7LURFtUeZHkzuU5i9jSvfIsRuae8/tDP+Au75eloNByPuG7J1yEvE3ODfLecBafdmKakoTb5TCLdicOnpy/2bIlggBMIdqIYKVxfuBNBk7oX7d+KsrQUa725mBNUAei7PHETXa2dBf7pty2GU/GdcWKfSoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EWj/Z51u; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NBbcSq8GSGLJxMN7JRM3JgBCfklD0XZCUA2hYzChRtY=; b=EWj/Z51uEX8ppxEEgY3sAQm8mR
	7VB4v+2w7EWnMgLNTRAgpSKG88cFepcWBsckF0VnGbBXKzJFTzt3IGpeTrtVzeBNn38kLu0f7dpzH
	fJhMgYVyQRN0dm8EZiG+rC+GxmqUqlGj09rpaqnHIML/Ag/3MhkVylFrqdk6Kt2Z2R9fkpKRQYoQz
	HUe/RusS0ScBrR4K31+kc/A0QvEmrgUwgHHcEBKDviD9OEyjWVyiybvit8XctgSEXiZ4W8X0A75Wp
	QeLtBUYtK7n9OUnXcI5JTjM0m8coH56/bKg/uk+5wbsCoSLNT5xUCpX4Z74BJkNGJ8m26NC5aDxY+
	PSVSoQ1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMvOm-0000000BmCU-234o;
	Wed, 04 Jun 2025 21:11:48 +0000
Date: Wed, 4 Jun 2025 22:11:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luka <luka.2016.cs@gmail.com>
Subject: Re: [Bug] possible deadlock in vfs_rmdir in Linux kernel v6.12
Message-ID: <20250604211148.GJ299672@ZenIV>
References: <CALm_T+2FtCDm4R5y-7mGyrY71Ex9G_9guaHCkELyggVfUbs1=w@mail.gmail.com>
 <CALm_T+0j2FUr-tY5nvBqB6nvt=Dc8GBVfwzwchtrqOCoKw3rkQ@mail.gmail.com>
 <CALm_T+3H5axrkgFdpAt23mkUyEbOaPyehAbdXbhgwutpyfMB7w@mail.gmail.com>
 <20250604-quark-gastprofessor-9ac119a48aa1@brauner>
 <20250604-alluring-resourceful-salamander-6561ff@lemur>
 <bfyuxaa7cantq2fvrgizsawyclaciifxub3lortq5oox44vlsd@rxwrvg2avew7>
 <20250604-daft-nondescript-junglefowl-0abd5a@lemur>
 <aECu-D3Df28hYI9L@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aECu-D3Df28hYI9L@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 04, 2025 at 09:39:20PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 04, 2025 at 04:11:21PM -0400, Konstantin Ryabitsev wrote:
> > Yes, hence my question. I think it's just a bad medium. It's actually the kind
> > of thing that bugzilla is okay to use for -- create a bug with attachments and
> > report it to the list, so maybe the original author can use that instead of
> > pastebin sites?
> 
> The "author" looks to be a bot, frankly.  At best yet-another-incompetent
> user of "my modified version of syzkaller".  There's no signal here,
> would recommend just banning.

FWIW, I suspect that we ought to document that *anything* (bug reports,
patches, etc.) sent should be reachable without the need to run javascript
or any similar crap.  Not sure what would be the best place for that,
though...

Seriously, this is pretty much on the same level as "don't send me
a binary as reproducer - I'm not going to run it".  Folks on these
lists are fairly tempting as targets; betting on the sandbox quality
in chromium/firepox/whatnot...  sorry, no.

*IF* hastebin really produces crap that can't be accessed without
interpreter of some sort, just bounce any mail that contains such links
with the obvious explanation.

