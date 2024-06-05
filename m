Return-Path: <linux-fsdevel+bounces-21072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17B8FD6CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 21:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AE0281CA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF646154C02;
	Wed,  5 Jun 2024 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BMOKeQjy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21605154452
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617247; cv=none; b=CPVdVwHYNc0VmKs4U5mMFFkVks/doNlGr8Hw4iWPlk2sEsch3r37UH7MvRN790rX4QYVezQxvQGe56cz4qRWT0sQynKnphmEGk2wOTRz8V9SEFcpqatZE5udbx67LwDy4UtMk3r5a2g3lQKob9kc/j16efHRckzlxUX03Y+kpfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617247; c=relaxed/simple;
	bh=oaFESPvdSIlaeOmjnqE+nNEYBLO39VWYp4b0lIL5+Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVyUY0oHtOVyWu3tp3/HYrXOQwyC3ot9vbPbRGhOPj2u2AHfjTjBe16r7HxkHCWTpdGPB9vt9lslJe5o/u/oQTfoRLsg+4pbwdxJd4aHWJoOgqWGD8+oUe3gJqIZLYcAF7R5uVQXsXOj9vUG0p3ALCu9Wb8BrCj4xZTxzOBtuBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=BMOKeQjy; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (unn-149-40-50-37.datapacket.com [149.40.50.37] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 455Jrlii017243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 15:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1717617232; bh=Mhq1gsPwuAUKIN3VJiuU77ZguDk0dNt9OtH7I3Vum4k=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=BMOKeQjyFJFy5jstuHPgFOA5OLBXbhWlrcfL6tn1NuOnaElCPAAkoBuRmYRN/AVSV
	 JT68mgUx6ceFIbeRhjigQdZ4k5ahaZl8LXpSSezBU/n21PNFs+SfUaJLd7bNHzx7sD
	 bXVKf6H70LP2VFn79Qpm/SUwYFshNAA+8FZBDB/Z7o7T3tdFppFcFHYbNymoYggLvJ
	 ZK5qwKc8+cOUlifLeK+aA1drzg1tB9vv2YJz20t5Mdhz1glK8xkEyFIEpIwjfhXCmE
	 P6nvPBrGUszf8K4ROYsfAda9WSoLq4AiEdA2WJjhHDHSNz1QOWHXtg23DknVdUHEaQ
	 MUD7D+Af7qfYg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 4FAD934162F; Wed, 05 Jun 2024 21:53:46 +0200 (CEST)
Date: Wed, 5 Jun 2024 21:53:46 +0200
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: JunChao Sun <sunjunchao2870@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Is is reasonable to support quota in fuse?
Message-ID: <20240605195346.GC4182@mit.edu>
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
 <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com>
 <20240604092757.k5kkc67j3ssnc6um@quack3>
 <CAHB1NahP14FAMj04D-T-bWs7JAn_mXfmXSeKUEkRbALZrLeqAA@mail.gmail.com>
 <20240605102945.q4nu67xpdwfziiqd@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605102945.q4nu67xpdwfziiqd@quack3>

On Wed, Jun 05, 2024 at 12:29:45PM +0200, Jan Kara wrote:
> 
> But that's why I'm asking for usecases. For some usecases it may be fine
> that in case of unclean shutdown you run quotacheck program to update quota
> information based on current usage - non-journalling filesystems use this
> method. So where do you want to use quotas on a FUSE filesystem?

Something else to consider is whether you want to allow the user to
query the current quota information (e.g., the "quota" command), and
whether you want the system administrator to be able to set quota
limits, and whether you expect that when the soft quota limits are
exceeded that warnings get written to the user's tty.  All of this
would mean that the kernel fuse driver would need changes, and the
kernel<->userspae FUSE protocol would need to be extended as well.
And at that pointm you really want to get the FUSE maintainer
involved, since the FUSE protocol is somethign which is used on other
OS's (e.g., Windows, MacOS, etc.)

As Jan put it, it's all in the use cases that you expect to be able to
support.  If you just want quota to be tracked, and for certain writes
to return EDQUOT, that's one thing.  If you want the full Linux quota
user experience, that's quite another.

Cheers,

						- Ted

