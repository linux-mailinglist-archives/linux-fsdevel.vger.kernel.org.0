Return-Path: <linux-fsdevel+bounces-78308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHLYErYCnmk6TAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:57:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8D18C3F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A73E8307F01D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26099330676;
	Tue, 24 Feb 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+7ajcfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300D1EB5E1;
	Tue, 24 Feb 2026 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963049; cv=none; b=DsEQG2MMg4XZTOoWpL7qLBJPcPbzVu8r9JcBbpUV7nYG6RJ7uwrVg3IO9SEGhF1V72K/tdVky7j80nspAV9K7hmLHp5QYEh6EDVn6+wMejXMka1xmdqa1Tqjep5frvRh1zNLLf2M8rQ4oeb99P6tcPGs1ZqEySdnK0mahyL78/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963049; c=relaxed/simple;
	bh=vHN4WiwsviYKGU7NPR3b69HaTRTDvpBQ07QmvThnpAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfHMNiz5/gCVP9d9InY2qsEGRjjMnlLO2e71XDLcgd2oPw5n/z3CEQlUH6jL/93sf1miILxv5fctotQwiTQ9RIM7sgxC8tN3ND7lqBp16/One0sTXfFBGCQUpx7OU69VHRabLFT95VASUn6sMh7V2QhGRmICAFgnCKf0RE2MVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+7ajcfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AC0C116D0;
	Tue, 24 Feb 2026 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771963049;
	bh=vHN4WiwsviYKGU7NPR3b69HaTRTDvpBQ07QmvThnpAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+7ajcfKPeAdtZqjljWMKQRIcZtVodygtnxrFsXO9w7mERyeSNn50Mk62H6xfe8zb
	 nYWZpTZVXcMhbhwEGX5Bu817mDX4qGUxkMKGkr6839G79GwCAokIh3QchN/pX8lwuC
	 xNVajxKqAs78UJvQGIBYZiAlddWrjS5lvgmJ+x8fyKwQHnc374dsPfYVbQfSN70omT
	 xohBzeUx0n7ltxEqrYtPzMMCWeQQV7O2Xx5wvmE5Jdr7g/mWF/psfeMxUPgKRs6V/t
	 jeJfvViXWXCButyktOXuXHjFEveoOvCCVzsbKShD3H2WoXzYC5CR3bgGj+RqIF6NrY
	 uaRu5x7sWu7wA==
Date: Tue, 24 Feb 2026 11:57:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bpf@vger.kernel.org, bernd@bsbernd.com,
	neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/5] fuse: flush pending FUSE_RELEASE requests before
 sending FUSE_DESTROY
Message-ID: <20260224195728.GE13829@frogsfrogsfrogs>
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
 <177188733133.3935219.4620873208351971726.stgit@frogsfrogsfrogs>
 <CAJnrk1ZZ=1jF4DUF-NyedLP-BJM_5d3s0zfD4oHGyR51PM9E7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZZ=1jF4DUF-NyedLP-BJM_5d3s0zfD4oHGyR51PM9E7Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78308-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8A8D18C3F0
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:33:12AM -0800, Joanne Koong wrote:
> On Mon, Feb 23, 2026 at 3:06 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > generic/488 fails with fuse2fs in the following fashion:
> >
> > generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
> > (see /var/tmp/fstests/generic/488.full for details)
> >
> > This test opens a large number of files, unlinks them (which really just
> > renames them to fuse hidden files), closes the program, unmounts the
> > filesystem, and runs fsck to check that there aren't any inconsistencies
> > in the filesystem.
> >
> > Unfortunately, the 488.full file shows that there are a lot of hidden
> > files left over in the filesystem, with incorrect link counts.  Tracing
> > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > commands that are queued up on behalf of the unlinked files at the time
> > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > aborted, the fuse server would have responded to the RELEASE commands by
> > removing the hidden files; instead they stick around.
> >
> > For upper-level fuse servers that don't use fuseblk mode this isn't a
> > problem because libfuse responds to the connection going down by pruning
> > its inode cache and calling the fuse server's ->release for any open
> > files before calling the server's ->destroy function.
> >
> > For fuseblk servers this is a problem, however, because the kernel sends
> > FUSE_DESTROY to the fuse server, and the fuse server has to write all of
> > its pending changes to the block device before replying to the DESTROY
> > request because the kernel releases its O_EXCL hold on the block device.
> > This means that the kernel must flush all pending FUSE_RELEASE requests
> > before issuing FUSE_DESTROY.
> >
> > For fuse-iomap servers this will also be a problem because iomap servers
> > are expected to release all exclusively-held resources before unmount
> > returns from the kernel.
> >
> > Create a function to push all the background requests to the queue
> > before sending FUSE_DESTROY.  That way, all the pending file release
> > events are processed by the fuse server before it tears itself down, and
> > we don't end up with a corrupt filesystem.
> >
> > Note that multithreaded fuse servers will need to track the number of
> > open files and defer a FUSE_DESTROY request until that number reaches
> > zero.  An earlier version of this patch made the kernel wait for the
> > RELEASE acknowledgements before sending DESTROY, but the kernel people
> > weren't comfortable with adding blocking waits to unmount.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> Overall LGTM, left a few comments below
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks!

> > ---
> >  fs/fuse/fuse_i.h |    5 +++++
> >  fs/fuse/dev.c    |   19 +++++++++++++++++++
> >  fs/fuse/inode.c  |   12 +++++++++++-
> >  3 files changed, 35 insertions(+), 1 deletion(-)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7f16049387d15e..1d4beca5c7018d 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1287,6 +1287,11 @@ void fuse_request_end(struct fuse_req *req);
> >  void fuse_abort_conn(struct fuse_conn *fc);
> >  void fuse_wait_aborted(struct fuse_conn *fc);
> >
> > +/**
> > + * Flush all pending requests but do not wait for them.
> > + */
> 
> nit: /*  */ comment style

I'm very confused by the comment style in this header file.  Some of
them look like kerneldoc comments (albeit not documenting the sole
parameter), but others are just regular C comments.

<shrug> I sorta dislike kerneldoc's fussiness so I'll change it to a C
comment so that I don't have to propagate this "@param fc fuse
connection" verbosity.

> > +void fuse_flush_requests(struct fuse_conn *fc);
> > +
> >  /* Check if any requests timed out */
> >  void fuse_check_timeout(struct work_struct *work);
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 0b0241f47170d4..ac9d7a7b3f5e68 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/splice.h>
> >  #include <linux/sched.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/nmi.h>
> 
> I don't think you meant to add this?

Yep, that was added for a previous iteration and can go away now.

> >
> >  #include "fuse_trace.h"
> >
> > @@ -2430,6 +2431,24 @@ static void end_polls(struct fuse_conn *fc)
> >         }
> >  }
> >
> > +/*
> > + * Flush all pending requests and wait for them.  Only call this function when
> 
> I think you meant "don't wait" for them?

Right.  Fixed.

> > + * it is no longer possible for other threads to add requests.
> > + */
> > +void fuse_flush_requests(struct fuse_conn *fc)
> > +{
> > +       spin_lock(&fc->lock);
> > +       spin_lock(&fc->bg_lock);
> > +       if (fc->connected) {
> > +               /* Push all the background requests to the queue. */
> > +               fc->blocked = 0;
> > +               fc->max_background = UINT_MAX;
> > +               flush_bg_queue(fc);
> > +       }
> > +       spin_unlock(&fc->bg_lock);
> > +       spin_unlock(&fc->lock);
> > +}
> > +
> >  /*
> >   * Abort all requests.
> >   *
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index e57b8af06be93e..58c3351b467221 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -2086,8 +2086,18 @@ void fuse_conn_destroy(struct fuse_mount *fm)
> >  {
> >         struct fuse_conn *fc = fm->fc;
> >
> > -       if (fc->destroy)
> > +       if (fc->destroy) {
> > +               /*
> > +                * Flush all pending requests (most of which will be
> > +                * FUSE_RELEASE) before sending FUSE_DESTROY, because the fuse
> > +                * server must close the filesystem before replying to the
> > +                * destroy message, because unmount is about to release its
> > +                * O_EXCL hold on the block device.  We don't wait, so libfuse
> > +                * has to do that for us.
> 
> nit: imo the "because the fuse server must close the filesystem before
> replying to the destroy message, because..." part is confusing. Even
> if that weren't true, the pending requests would still have to be sent
> before the destroy, no? i think it would be less confusing if that
> part of the paragraph was removed. I think it might be better to
> remove the "we don't wait, so libfuse has to do that for us" part too
> or rewording it to something like "flushed requests are sent before
> the FUSE_DESTROY. Userspace is responsible for ensuring flushed
> requests are handled before replying to the FUSE_DESTROY".

How about I simplify it to:

	/*
	 * Flush all pending requests before sending FUSE_DESTROY.  The
	 * fuse server must reply to the flushed requests before
	 * handling FUSE_DESTROY because unmount is about to release
	 * its O_EXCL hold on the block device.
	 */

--D

> 
> Thanks,
> Joanne
> 
> > +                */
> > +               fuse_flush_requests(fc);
> >                 fuse_send_destroy(fm);
> > +       }
> >
> >         fuse_abort_conn(fc);
> >         fuse_wait_aborted(fc);
> >
> 

