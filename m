Return-Path: <linux-fsdevel+bounces-24083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCC69391D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5754B1F21CFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A5F16E88B;
	Mon, 22 Jul 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udibmumu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F58C2FD;
	Mon, 22 Jul 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662227; cv=none; b=p8FN06doOpvaxjdxpphp8fwlG6O/IxIkn/c6iJut3nFZAdgI6JLcbN31k7Y7LGuB9e6rGetoRLOOFZ0XA+fw6eYX1bBDGkh/GX/ogb1olU8GjJH3YxHTRAevCspNEA2rRXEY18BgZxJhq7SbdbAHc6uD7sDz4hvmwJMMhRjvHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662227; c=relaxed/simple;
	bh=qeOMl00DgHVITw+FjVR23dUDZQ0dZ2F3RbfRASJShYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjkMXh2+Ieay6zEP/Wtr7UfLo4dPHN+SxoK+rirZ2t1ex+JnC55HDr6cbUYB1+fi2PG5vJbSfoVOEjouIdw5x3auBu+UTCH4DCINZW0o3Q1rJEKmmzQmC68U8fmVKQwRIG23RtRnQS68NBQquvB2ECLv2EB5xaeWPedWaQ83mLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udibmumu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F691C116B1;
	Mon, 22 Jul 2024 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721662227;
	bh=qeOMl00DgHVITw+FjVR23dUDZQ0dZ2F3RbfRASJShYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Udibmumu7SLzxEKxqIecKZDLnygO3K9IPmsYRL3I6hL5eYqNIVWX7mLjSpajAEdtJ
	 +34Wwg7S23Sx/TsNHnSCLXzlaT8K9BzSvT0TpzDZp4qpSIexecgt4YBIFxTyDVKdR4
	 zoGjpH6i7DCAVXe/q3qIV7BqGL/VhVJeejTJZQ5AjoBDa5DUQ2nz2ml/skzftzqSlC
	 5qNp9evMwxpnZuVl0mgCMoNVIFBdte25OlWnbcPfa0aHZjnWFch12yFrsCVCKAOuGg
	 mqnhjXYfz2YA35SyHO1xRH0Y7C6QIOmi+MTocaJsucU4+99bRjM3aqFDZEN/X/Fw9k
	 bZ6cWyiYCD1kA==
Date: Mon, 22 Jul 2024 17:30:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R <chandan.babu@oracle.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
	Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 0/9] fs: multigrain timestamp redux
Message-ID: <20240722-festmachen-lehrstellen-f86d1bd28997@brauner>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240716-zerlegen-haudegen-ba86a22f4322@brauner>
 <60af7cff6b1cf00388e932804c81ed368fcc9f02.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60af7cff6b1cf00388e932804c81ed368fcc9f02.camel@kernel.org>

On Tue, Jul 16, 2024 at 08:45:16AM GMT, Jeff Layton wrote:
> On Tue, 2024-07-16 at 09:37 +0200, Christian Brauner wrote:
> > On Mon, Jul 15, 2024 at 08:48:51AM GMT, Jeff Layton wrote:
> > > I think this is pretty much ready for linux-next now. Since the latest
> > > changes are pretty minimal, I've left the Reviewed-by's intact. It would
> > > be nice to have acks or reviews from maintainers for ext4 and tmpfs too.
> > > 
> > > I did try to plumb this into bcachefs too, but the way it handles
> > > timestamps makes that pretty difficult. It keeps the active copies in an
> > > internal representation of the on-disk inode and periodically copies
> > > them to struct inode. This is backward from the way most blockdev
> > > filesystems do this.
> > > 
> > > Christian, would you be willing to pick these up  with an eye toward
> > > v6.12 after the merge window settles?
> > 
> > Yup. About to queue it up. I'll try to find some time to go through it
> > so I might have some replies later but that shouldn't hold up linux-next
> > at all.
> 
> Great!
> 
> There is one minor update to the percpu counter patch to compile those
> out when debugfs isn't enabled, so it may be best to pick the series
> from the "mgtime" branch in my public git tree. Let me know if you'd

I did that now and pushed to vfs.mgtime. Please take a look as I rebased
onto current master and resolved conflicts in xfs and btrfs. Thanks!

