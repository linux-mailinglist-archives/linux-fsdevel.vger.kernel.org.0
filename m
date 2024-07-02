Return-Path: <linux-fsdevel+bounces-22959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C9924371
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651351F2437E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845F31BD4FC;
	Tue,  2 Jul 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWe8+4vr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB615B11D;
	Tue,  2 Jul 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937146; cv=none; b=cLayFQonFoT0r5aV3qNq25Enrs6c0UqngtzbWhg4qUmnEaNcOorJWP9CgyRRe3gpnNUDNooWGm4myuJs0dRAEeow/foi4gVhDyrYVDXrdz2Npzt2ykxIgiNrYi2NWqUvHs67+wFrlFAml3bCqP5T90kQmt9XIKwYDXg7Ss8Nchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937146; c=relaxed/simple;
	bh=f/Lt6TGAChQhJDo1d9S1C9KYvC+2NSkWdhgXVkkdLDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEljVPxeReaao268QOPZbdgc3ZoiY1hmRDBA6GIKVJhDJq/lMLrmXbZaR7/iFna54t18AQrAsxcRybtuwExHGX+KYeFJXyNnaKsD/3lOnMNuDMAOk5BYKFPN71epdFWpnEXKNV/PbgHhGHvymCdygI6yZ4LW7eTwYTlmPE4A5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWe8+4vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47053C116B1;
	Tue,  2 Jul 2024 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937146;
	bh=f/Lt6TGAChQhJDo1d9S1C9KYvC+2NSkWdhgXVkkdLDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWe8+4vrZ82aLpFmQ/xxCaJvhq1zmz0VUCOjwx+pO4joEWaTNHfWjLRMGZoaPiVDt
	 budCT+VnEcgyoSf2Ab8MdsbVsBFm77eny8iEcIwJQ8JyEGL4+bTuUEjbENlNcYIpp/
	 gL3SnCOgO6dZZl8vgmgZ762DzwQodDtcRzBW6kItR6KjM163XwjU2Lgn7iM5pgI6/7
	 XBsh3uDkaMZxoYbbDoDEcrrpMrlrSldQO/fACxHAu6ntHbLUVC4HHK5mhcmY/NpEBF
	 XVA4ga3Rk7WIXoZ0aUPw+mEDsMkvhR1DhZmouNn2Tfi29hI2nY5C6cVQ0Pr5Mz7q2M
	 Il08gNdV6QXbQ==
Date: Tue, 2 Jul 2024 18:18:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	"Darrick J. Wong" <djwong@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R <chandan.babu@oracle.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Message-ID: <20240702-inwiefern-beraten-cc4b5efce8ef@brauner>
References: <20240701224941.GE612460@frogsfrogsfrogs>
 <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
 <ZoOuSxRlvEQ5rOqn@infradead.org>
 <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
 <20240702101902.qcx73xgae2sqoso7@quack3>
 <958080f6de517cf9d0a1994e3ca500f23599ca33.camel@kernel.org>
 <ZoPs0TfTEktPaCHo@infradead.org>
 <09ad82419eb78a2f81dda5dca9caae10663a2a19.camel@kernel.org>
 <ZoPvR39vGeluD5T2@infradead.org>
 <a11d84a3085c6a6920d086bf8fae1625ceff5764.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a11d84a3085c6a6920d086bf8fae1625ceff5764.camel@kernel.org>

On Tue, Jul 02, 2024 at 08:21:42AM GMT, Jeff Layton wrote:
> On Tue, 2024-07-02 at 05:15 -0700, Christoph Hellwig wrote:
> > On Tue, Jul 02, 2024 at 08:09:46AM -0400, Jeff Layton wrote:
> > > > > corrupt timestamps like this?
> > > > 
> > > > inode_set_ctime_to_ts should return an error if things are out of
> > > > range.
> > > 
> > > Currently it just returns the timespec64 we're setting it to (which
> > > makes it easy to do several assignments), so we'd need to change
> > > its
> > > prototype to handle this case, and fix up the callers to recognize
> > > the
> > > error.
> > > 
> > > Alternately it may be easier to just add in a test for when
> > > __i_ctime == KTIME_MAX in the appropriate callers and have them
> > > error
> > > out. I'll have a look and see what makes sense.
> > 
> > The seems like a more awkward interface vs one that explicitly
> > checks.
> > 
> 
> Many of the existing callers of inode_ctime_to_ts are in void return
> functions. They're just copying data from an internal representation to
> struct inode and assume it always succeeds. For those we'll probably
> have to catch bad ctime values earlier.
> 
> So, I think I'll probably have to roll bespoke error handling in all of
> the relevant filesystems if we go this route. There are also

Shudder, let's try and avoid that.

