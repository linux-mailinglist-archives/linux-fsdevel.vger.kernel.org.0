Return-Path: <linux-fsdevel+bounces-19384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2868C4523
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 18:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A522825B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1D15AF6;
	Mon, 13 May 2024 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tHX0rcSR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CBC139B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618026; cv=none; b=CjDExyB894Rhf6h2Brh28CkJhEx+9BJzP2HZAdenq5VxDNZFpIt+J1oR9rsIl2FNmqne48VOjsiG0tID79ZkP0B0T6Br/CFzB0Jl3sxLjiilDIHY3TzQLAEQKk4vzRrRqzGeK6xDLnzOme8cibW7021I48HxWb3WFEgmYDmo83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618026; c=relaxed/simple;
	bh=cI9Y1jo+By77p+f6dEBjsqlpgeDcZXg5stXJEceM1JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQYyZqPhybuqoqirxx+wysplG7j8tpXP1qelq/EypJcoAcCdNErt8ptfMS2BAmjvPJhW6bffEDXjNXTiwJ/Mr8C30ldKbQ0EViFruxkbroNCjH39l5XwHUJE5usYY0p6pnI5mmxGBXYcHbTl8rW5jhV9hhvgWX6Eq44jS/UiSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tHX0rcSR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6afhmFjBMUexZipuewaB52mwOxW6oFI5HF/IOazywxc=; b=tHX0rcSREiz9LOKVXyF8FujsZb
	KizRdtcuVV2SOiriC3nR3/61RlE5kpRzoy42NF1v8A3ANPh94OtoOLhqabqHA9p5MM7sQJD+4BX8w
	g70vzmScBGijqJjKJwrJgd81gxHpByidEaZDYhCEYoX+3/8cyMrAx2PO8slc5w9Gn6llavi1GsDvS
	/c9dWxx9PkJNLlgd3dj5hpoR3h+V9nqngPO5nq37JvTkOhGvXE+AyntERdxkIww2xA3zTKfwySPlP
	M4E8cUxm2NTx0TeSO0rkTtZf8NkNNGxERU27EzR0KBfnB2h5rIFbU0thrLjrIk9IFPlCL2a2Ny+x5
	n+Cg6ZyA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s6YcG-005aaP-1G;
	Mon, 13 May 2024 16:33:32 +0000
Date: Mon, 13 May 2024 17:33:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org, longman@redhat.com,
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
Message-ID: <20240513163332.GK2118490@ZenIV>
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org>
 <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV>
 <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
 <20240512161640.GI2118490@ZenIV>
 <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
 <20240513053140.GJ2118490@ZenIV>
 <CAHk-=wgZU=TFEeiLoBjki1DJZEBWUb00oqJdddTCJxsMZrJUfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZU=TFEeiLoBjki1DJZEBWUb00oqJdddTCJxsMZrJUfQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 13, 2024 at 08:58:33AM -0700, Linus Torvalds wrote:
 
> We *could* strive for a hybrid approach, where we handle the common
> case ("not a ton of child dentries") differently, and just get rid of
> them synchronously, and handle the "millions of children" case by
> unhashing the directory and dealing with shrinking the children async.

try_to_shrink_children()?  Doable, and not even that hard to do, but
as for shrinking async...  We can easily move it out of inode_lock
on parent, but doing that really async would either need to be
tied into e.g. remount r/o logics or we'd get userland regressions.

I mean, "I have an opened unlinked file, can't remount r/o" is one
thing, but "I've done rm -rf ~luser, can't remount r/o for a while"
when all luser's processes had been killed and nothing is holding
any of that opened... ouch.

