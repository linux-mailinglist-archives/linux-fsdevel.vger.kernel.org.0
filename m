Return-Path: <linux-fsdevel+bounces-11926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A650859327
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 23:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F7D1F21EF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D21F7BAE7;
	Sat, 17 Feb 2024 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DKSJtTBA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E47B3EA;
	Sat, 17 Feb 2024 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708209100; cv=none; b=Ce30GfuBKOaoey96h3qbU6Nd8fEnF1z/R+Rm4HMIgHaTwxXNS5T4Q0v33kJEaRlIo8KogohQ/ti2S8sFHSeRygbzvWUsoMFhBkRD5dKZpLs+Tk4EYOr1UzwT16cmvsNTYZxuqCmuVt4M10PQsulhxlPxEyoRQCDoYIFzvxagUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708209100; c=relaxed/simple;
	bh=ybGYd3rkq0s1hALMfpQk6n3C/edebolky5vSvPyxlIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuUXCXCs5VHIXPeywqYB3LGIT2cik8b38b84l+ECRATm+4Qv3C1V7fr8wOJfQsgUlj0DOL3bzHS1ayvBVuCzp/MfXVfysTSSTH33o6SUGvef3ZIcGwV6YtJtZJzI8qQyBhufV3nQRYvwDuJRLDROrVmy+5dl4FCnM5n/k6eQtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DKSJtTBA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1L5+v7OBH94VXAhT9gGEjSneA+Vgh7K9gZNcifYCc80=; b=DKSJtTBAkswcEe7Kk2lO3rR4Lk
	WQWPIevzHKMWJSC7wA9zx3XPh45lG/eo55hW87G0yTnqR/UxCam5NdReiafiYJatVdUeQVsWe1/g5
	aQLjvRXAzE8IDhVRImnDXZLzyMxv+DgPAPLn7L/S5p6GblfXsBl0t9JlzQ9pmMISCoVGUYk7f9cWb
	GSnzl8uX7Wxc/4GUJx/nKssfxIzN4JF1TYoVh8tfYG/V4hBafyLRhb/9UE5faVMREqSUw6VxBOM5o
	hfeSr6FuL9hLBBz3yBlQri83nyhnjARgvfOIpmXOx13lNNio/ERDs8OW7RD4vFxSIC0krR5cR+3/k
	usUPrjgA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbTDV-00000008YDo-44mW;
	Sat, 17 Feb 2024 22:31:30 +0000
Date: Sat, 17 Feb 2024 22:31:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <ZdEzwTrJV-aQ1CqV@casper.infradead.org>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>

On Sat, Feb 17, 2024 at 03:56:40PM -0500, Kent Overstreet wrote:
> AKA - integer identifiers considered harmful

Sure, but how far are you willing to take this?  You've recently been
complaining about inode numbers:
https://lore.kernel.org/linux-fsdevel/20231211233231.oiazgkqs7yahruuw@moria.home.lan/

> The solution (originally from plan9, of course) is - UIDs shouldn't be
> numbers, they should be strings; and additionally, the strings should be
> paths.
> 
> Then, if 'alice' is a user, 'alice.foo' and 'alice.bar' would be
> subusers, created by alice without any privileged operations or mucking
> with outside system state, and 'alice' would be superuser w.r.t.
> 'alice.foo' and 'alice.bar'.

Waitwaitwait.  You start out saying "they are paths" and then you use
'.' as the path separator.  I mean, I come from a tradition that *does*
use '.' as the path separator (RISC OS, from Acorn DFS, which I believe
was influenced by the Phoenix command interpreter), but Unix tends to
use / as the separator.

One of the critical things about plan9 that means you have to think
hard before transposing its ideas to Linux is that it doesn't have suid
programs.  So if I create willy/root, it's essential that a program
which is suid only becomes suid with respect to other programs inside
willy's domain.  And it doesn't just apply to filesystem things, but
"can I send signals" and dozens of other things.  So there's a lot
to be fleshed out here.

