Return-Path: <linux-fsdevel+bounces-44463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C26A695A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 18:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439B9882CF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0E1E1E13;
	Wed, 19 Mar 2025 17:00:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039A1E22E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403600; cv=none; b=P+S2mI5gSclg5L5ob1RUlqutBKsvPH3nQ24uq9yEcNwVCm+9qQoPNsX+sO7bVy6zXj5eJk/PeLJ9xTmJO7qMXgfxJrL4o8uJDg1EJY5GZJm39ABqroXuYlQA7lQblY2QTEaq7VMh3D0Q/HigwpmWmxhArqjjG0YriBIJAO5uYG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403600; c=relaxed/simple;
	bh=BXq1QOWw/7VgVsJrNZFj5k8jfNhbMlnp19P3R1b+ios=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAT9a89JWLCmey/slwJDigB5RDOCqAggWr2euHdJmT+ECOKvxBf9ngwQKXmHGX3LpFDpIqM1kKtFFWQ81dcIpb5cFlxHt97okC5n7xu4cnWCuEvciGr307uzyZZtFn015RmwXhL/nUzzIW5e2xEPPYNhPgjNwV4Pi2PrDZjHI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52JGxWYl023358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:59:32 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F20252E010B; Wed, 19 Mar 2025 12:59:31 -0400 (EDT)
Date: Wed, 19 Mar 2025 12:59:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
        gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mic@digikod.net,
        Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <20250319165931.GD1061595@mit.edu>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
 <Z9kC7MKTGS_RB-2Q@dread.disaster.area>
 <Z9rbDdLr0ai-UFE_@itl-email>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rbDdLr0ai-UFE_@itl-email>

On Wed, Mar 19, 2025 at 10:55:39AM -0400, Demi Marie Obenour wrote:
> What kind of performance do the existing solutions (libguestfs, lklfuse)
> have?

For most of the use cases that I'm aware of, which is to support
occasional file transfers through crappy USB thumb drives (the kind
which a nation state actor would to scatter in the parking lot of
their target), the performance doesn't really matter.  Certainly these
are the ones which apply for the Android and ChromeOS use cases.

I suppose there is the use case of people who are running Adobe
Lightroom Classic on their Macbook Air where they are using an
external SSD because Apple's storage pricing is highway robbery, but
(a) it's MacOS, not Linux, and (b) this is arguably a much smaller
percentage of the use case cases in terms of millions and millions of
Android and Chrome Users.  Most of the more naive Mac users probably
just pay $$$ to Apple and don't use external storage anyway.  :-)

> There are other options, like "run the filesystem in a tightly sandboxed
> userspace process, especially compiled through WebAssembly".  The
> difficulty is making them sufficiently performant for distributions to
> actually use them.

I suspect that using a kernel file system running in a guest VM and
then making it available via 9pfs would be far more performant than
something involving FUSE.  But the details would all be in the
implementation, and the skill level of the engineer doing the work.

I'll also note that since you are mentioning Chrome OS and Android a
lot, there seems to be a lot of interest in using VM's as a security
boundary (see CrosVM[1] which is a Rust-based VMM).  So it's likely
that this infrastructure would be available to you if you are doing
work in this area.

[1] https://github.com/google/crosvm

Cheers,

					- Ted

