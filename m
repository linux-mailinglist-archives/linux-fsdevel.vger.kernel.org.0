Return-Path: <linux-fsdevel+bounces-76525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INbLC1ZvhWnqBQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:34:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32EFA1EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC6A23028AEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 04:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321212E3B15;
	Fri,  6 Feb 2026 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KypOMUyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6032E173B;
	Fri,  6 Feb 2026 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351922; cv=none; b=ln8HKlgR4ZC0tmIiYv2VXtxQrTbq2dOCv7RJEruBlm2E5LkhHYAew6/9zczpQPHMGPtjhXm88rCWQ2PT1lVqyqs9Hvn3gIU6OUhb823vsw4JqdpaAPHF0yX1mKA2PFVEchMfNvNqIfVnbnXPAhQLPXEA30/4qRE2hKRNBosnng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351922; c=relaxed/simple;
	bh=Wm9+BlkCTQ2Hsus4ED9Nyd/A2Bk5ttOxKWG9RDJLmgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj+RgISebKhF9qLs78183/MrOmtw+rQW2UBKYC/9pACfXmzA/ikPJToAIvMk/gt41iFyhngrH8KP2BLvs6XAO8k6GwXkPyrF+xBsVTjFXnlYft3hb2aF3Plrdu48vFLVizGWWgKEiEVw3+zETmB6aHxfWnXjuqb7KZybOS8Wgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KypOMUyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39341C116C6;
	Fri,  6 Feb 2026 04:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770351922;
	bh=Wm9+BlkCTQ2Hsus4ED9Nyd/A2Bk5ttOxKWG9RDJLmgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KypOMUyp7F0dRw8/gcUOJXsBvAWsWe+/uyCcpHsfQzeWcUrHyTb6Pq0jqbOGZ/Dfy
	 9KkGl0uO1bn2iZeUN1dezadrICcAz8XOYB4PU+KrFhzyj2L+yCU4W4r+dbpYw172/U
	 5FQmwdosWSD6cbDFjtfoqpG0g3bL3FANhdwDvARZljSBZ1n9RxuJR1PzAKL3CBOxxJ
	 zaxyW1iM7ktSFlx0kqY4MBf5AKhqVMNrCb05ZLRTbJ4HP7RfgrpvtoK0hpTgv8RYsC
	 dgPmUj7I8OkjR6MyZ0HHCN+WDcPhfrerIES3kavDOT3Hm2J8AvPLb6X4G46EqKN85t
	 ATHPkc6GL/yeA==
Date: Thu, 5 Feb 2026 20:25:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 29/31] fuse: disable direct reclaim for any fuse server
 that uses iomap
Message-ID: <20260206042521.GJ7686@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810980.1424854.10557015500766654898.stgit@frogsfrogsfrogs>
 <20260205185842.1833542-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205185842.1833542-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76525-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E32EFA1EC
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:57:15AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Any fuse server that uses iomap can create a substantial amount of dirty
> > pages in the pagecache because we don't write dirty stuff until reclaim
> > or fsync.  Therefore, memory reclaim on any fuse iomap server musn't
> > ever recurse back into the same filesystem.  We must also never throttle
> > the fuse server writes to a bdi because that will just slow down
> > metadata operations.
> 
> Hi everyone,
> 
> I'm trying out my AI review prompts on a few more trees, and I ran it
> on the fuse-iomap-cache branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
> 
> This was the latest email lore could find, apologies if I grabbed the wrong one.
> 
> Hopefully the review below is useful, please let me know if there are places it
> has gone wildly wrong.  I kept the header to make it obvious exactly which
> commit I'd run through:
> 
> commit 3bdd586d6fa00e067dbc3676642ac75e54ec3031
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse: disable direct reclaim for any fuse server that uses iomap
> 
> Any fuse server that uses iomap can create a substantial amount of dirty
> pages in the pagecache because we don't write dirty stuff until reclaim
> or fsync. Therefore, memory reclaim on any fuse iomap server must avoid
> recursing back into the same filesystem and throttling the fuse server.
> 
> > diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> > --- a/fs/fuse/fuse_iomap.c
> > +++ b/fs/fuse/fuse_iomap.c
> > @@ -1019,6 +1019,12 @@ static void fuse_iomap_config_reply(struct fuse_mount *fm,
> >  	 */
> >  	fc->sync_fs = true;
> >
> > +	/*
> > +	 * We could be on the hook for a substantial amount of writeback, so
> > +	 * prohibit reclaim from recursing into fuse or the kernel from
> > +	 * throttling any bdis that the fuse server might write to.
> > +	 */
> > +	current->flags |= PF_MEMALLOC_NOFS | PF_LOCAL_THROTTLE;
> 
> Are these process flags being set on the correct process? Looking at the
> call chain:
> 
> Sync path:
>   fuse_fill_super() -> fuse_iomap_mount() -> fuse_iomap_config_reply()
> 
> Async path:
>   fuse_request_end() -> args->end() -> fuse_iomap_config_reply()
> 
> In the sync path, current points to the mount(2) process which exits
> after mounting completes. In the async path, current points to whichever
> process writes the reply to /dev/fuse (the fuse daemon thread) or a
> kernel worker thread for virtio-fs.
> 
> The commit message states the goal is to prohibit reclaim from recursing
> into the fuse server, but the fuse server is a separate userspace process.
> Setting flags on the mount process (which exits) or on a random fuse
> daemon thread (only once during init) doesn't protect the fuse server
> threads that actually perform I/O operations.
> 
> Should the flags be set on the correct process context? Or if they need
> to be set here, should they follow the pattern used in fs/nfsd/vfs.c and
> fs/nfs/localio.c which save and restore the flags?
> 
> Looking at fs/nfsd/vfs.c:1438-1509:
> 
>   unsigned long old_flags = current->flags;
>   current->flags |= PF_LOCAL_THROTTLE;
>   ...
>   current_restore_flags(pflags, PF_LOCAL_THROTTLE);
> 
> and fs/nfs/localio.c:824-828:
> 
>   unsigned long old_flags = current->flags;
>   current->flags |= PF_LOCAL_THROTTLE;
>   ...
>   current_restore_flags(old_flags, PF_LOCAL_THROTTLE);
> 
> Without saving and restoring, the flags permanently alter the process
> state. For the mount process this is wasted when it exits, and for fuse
> daemon threads this causes permanent behavior changes.

Hrmm.  Normally the fuse server itself calls mount(2) via libfuse to set
up the mount point, so this does (AFAICT) set PF_ flags on the fuse
server itself.

However, any fuse setup that doesn't handle things this way would indeed
set the PF_ flags on the wrong process.  There are (a) other fuse
libraries out there, and (b) the fuse service architecture mentioned
downthread has a mount helper that starts up a fuse server on the other
end of a unix socket, passes it resources including /dev/fuse to start
up, and then calls mount(2) itself instead of the fuse server doing
that.

That part's broken, and I'll have to think about how to solve that.
Or maybe someone else will tell me this is all undesirable and I'll just
drop this patch. :)

--D

