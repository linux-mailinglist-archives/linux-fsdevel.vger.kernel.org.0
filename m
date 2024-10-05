Return-Path: <linux-fsdevel+bounces-31092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB35991B47
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4D11C20ECE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B594E165F05;
	Sat,  5 Oct 2024 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fWrfH4LK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4BB1591F0
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728168717; cv=none; b=lslvlwnssXNNi5+QXQmWbiD4X/RExLKUyyEac+0tlv2b3xMw0hPMya5VEc6xGBhauYn70NUw4XBZ9COpJ4vWZsmPmQUBN06g2sAOkFfRAACTea79mLaQAQClNcMFaDNwloU15+QF2cYutdV8mDWIDZFIGADIDU0jajGWIYvvyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728168717; c=relaxed/simple;
	bh=PWbPk/91BWSgD7U6SQp6I1sP5y5aeq55/EMAIshOnm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpChP9udLtV8dp7CQXsxTx+DvysKGOhQru2N2+56jzPMaUEOkn4mrYPYQKsaWhkuKCBkzTDDcndVbNgwX/5WLgxgKjZTceTq/CSL/bray61lGpl1LTrmhs83vWyfYIbELvu/3dQ3lvWF94JsyIrJQFG1z30gGa3212L/neZ7iA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fWrfH4LK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FcEL1bmO1UcL2fj8S/pd+T8y+wocj4zjI1UZe+Ju31Q=; b=fWrfH4LKiJ+CJ19HhMyNZMuNnz
	DBrtdUJzRxPEkqkJi093DUYQKlkIj8fhxsegyVEXdKVl5jhTL8A7kkaUtIrY6rV/WVp8cB8zhUyoX
	JmOenxsy6zsETUYFKZLjAXyaNZUO6kVrD3847z+iWUuqrnUias2QbbixT8isZMppY3EToV1XCi8Tt
	rFnEomVXgrALeqbDjdcrNekAqP/qfBR3RU4XX+bnVSpny/84agiVZ5DKn3z8H50dCoICQJy97HQYZ
	mt19ab71rpaU59ZREi1M8gK/HIfNyE441ikKOPmuMrBGSS0L/or4ZEQkNyRE6Z7a4szg8szEAc+6/
	NVZ3Wi0g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxDcu-00000001Bce-39zG;
	Sat, 05 Oct 2024 22:51:52 +0000
Date: Sat, 5 Oct 2024 23:51:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
Message-ID: <20241005225152.GC4017910@ZenIV>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
 <20241005220100.GA4017910@ZenIV>
 <CAHk-=whAwEqFKXjvYpnsq42JbE1GFoDR5LnmjjK_cOF4+nAhtg@mail.gmail.com>
 <20241005222836.GB4017910@ZenIV>
 <CAHk-=wgKmjuc8T_9mc7hWpBp1m_E+wkri-jFAD67AqkHZQjWPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKmjuc8T_9mc7hWpBp1m_E+wkri-jFAD67AqkHZQjWPQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 05, 2024 at 03:43:16PM -0700, Linus Torvalds wrote:

> Come on - the only possible reason for two billion files is a bad
> user. Do we care what error return an attacker gets? No. We're not
> talking about breaking existing programs.

Umm...  It can be a bad failure mode of a buggy program, really
unpleasant to debug if the pile of references kept growing on stdin
of that sucker, which just happens to be controlling tty of your
login session; fork(2) starting to fail for everything that has it
opened is not fun.

That's really nit-picking though, since

> So I don't think that's actually the important thing here. If we keep
> it a 'long', I won't lose any sleep over it.

... exactly.

> But using the rcuref code doesn't work (regardless of whether 32-bit
> or 'long' ref), because of the memory ordering issues.

*nod*

