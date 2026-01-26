Return-Path: <linux-fsdevel+bounces-75554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKqUMwP/d2lqnAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:55:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 749CF8E5BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358B9301E3EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC99311C3B;
	Mon, 26 Jan 2026 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUThVlpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30C233722;
	Mon, 26 Jan 2026 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471732; cv=none; b=J9YIPKvM0Ix1GWWvrDuBwWb/S7DS2jtFZEbcLx5p0tNqZg8GPaLJksxOrd0C0wv9bkB0dLB3HqtDHM3ABOW6Y42fxgBd1UacG8VHD1m6sg9NB735QzvUpZTdrXSPnYt9jlJixKwW2z8yjNdOBEoBgX16JEYJMqq//dw54T+AjeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471732; c=relaxed/simple;
	bh=wxHLHGDukhIN3MuGLKC/OQoXjYMNqEUddgvGxd7pxg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7mVHP3QG1TDExoV8+wXM+CtS/QV6dDGDziXLxi+lOKpwimCfsoBCts3cB+hZuU+j6+e8luA3s7H+lXJrUjXTAgyiIg9WkCa3p+WcT09IUmE3c9+gESVMfePsDDYKqitqrFSVI2qwNEIP6AAPnMxemQYCjCXbLCCKmdcrLbqczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUThVlpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF82C116C6;
	Mon, 26 Jan 2026 23:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769471731;
	bh=wxHLHGDukhIN3MuGLKC/OQoXjYMNqEUddgvGxd7pxg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUThVlpaqJ+VyTezDyLkIxfCq7zLRWSrNaM1Gs5yf4wJBOALMe9ybI+viyD/N+i8u
	 t1Ada7jyUg6MGrOZKws/8QtqBg0oFmnh6o8aLxetNqQnKZu0MVQcGm07+taJtOKo3/
	 XjMfSF0SR8o4h4He78e+PKcG4DYd8VqxQKp8pMY2QXtnCGZnMS5bYy9mMyZtNjwtBA
	 MyZWMGLarcDA/b4c6vLclhlPRmjjmxten9qLM8BSy/rgr9u0nnZXdKB08qtUT/RipZ
	 ths4eO9580pYWq7kXWXqK3Ygxgjscqv5FdDjgwnjiAeRdiCtS4t9ngfGunugQ5jJ+Y
	 yJPnohkZ4qLeg==
Date: Mon, 26 Jan 2026 15:55:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/31] fuse: use an unrestricted backing device with
 iomap pagecache io
Message-ID: <20260126235531.GE5900@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810721.1424854.6150447623894591900.stgit@frogsfrogsfrogs>
 <CAJnrk1ZDz5pQUtyiphuqtyAJtpx23x1BcdPUDBRJRfJaguzrhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZDz5pQUtyiphuqtyAJtpx23x1BcdPUDBRJRfJaguzrhQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75554-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 749CF8E5BD
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 02:03:35PM -0800, Joanne Koong wrote:
> On Tue, Oct 28, 2025 at 5:49 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > With iomap support turned on for the pagecache, the kernel issues
> > writeback to directly to block devices and we no longer have to push all
> > those pages through the fuse device to userspace.  Therefore, we don't
> > need the tight dirty limits (~1M) that are used for regular fuse.  This
> > dramatically increases the performance of fuse's pagecache IO.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/file_iomap.c |   21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> >
> > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > index 0bae356045638b..a9bacaa0991afa 100644
> > --- a/fs/fuse/file_iomap.c
> > +++ b/fs/fuse/file_iomap.c
> > @@ -713,6 +713,27 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
> >  void fuse_iomap_mount(struct fuse_mount *fm)
> >  {
> >         struct fuse_conn *fc = fm->fc;
> > +       struct super_block *sb = fm->sb;
> > +       struct backing_dev_info *old_bdi = sb->s_bdi;
> > +       char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
> > +       int res;
> > +
> > +       /*
> > +        * sb->s_bdi points to the initial private bdi.  However, we want to
> > +        * redirect it to a new private bdi with default dirty and readahead
> > +        * settings because iomap writeback won't be pushing a ton of dirty
> > +        * data through the fuse device.  If this fails we fall back to the
> > +        * initial fuse bdi.
> > +        */
> > +       sb->s_bdi = &noop_backing_dev_info;
> > +       res = super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
> > +                                  MINOR(fc->dev), suffix);
> > +       if (res) {
> > +               sb->s_bdi = old_bdi;
> > +       } else {
> > +               bdi_unregister(old_bdi);
> > +               bdi_put(old_bdi);
> > +       }
> 
> Maybe I'm missing something here, but isn't sb->s_bdi already set to
> noop_backing_dev_info when fuse_iomap_mount() is called?
> fuse_fill_super() -> fuse_fill_super_common() -> fuse_bdi_init() does
> this already before the fuse_iomap_mount() call, afaict.

Right.

> I think what we need to do is just unset BDI_CAP_STRICTLIMIT and
> adjust the bdi max ratio?

That's sufficient to undo the effects of fuse_bdi_init, yes.  However
the BDI gets created with the name "$major:$minor{-fuseblk}" and there
are "management" scripts that try to tweak fuse BDIs for better
performance.

I don't want some dumb script to mismanage a fuse-iomap filesystem
because it can't tell the difference, so I create a new bdi with the
name "$major:$minor.iomap" to make it obvious.  But super_setup_bdi_name
gets cranky if s_bdi isn't set to noop and we don't want to fail a mount
here due to ENOMEM so ... I implemented this weird switcheroo code.

> This is more of a nit, but I think it'd also be nice if we
> swapped the ordering of this patch with the previous one enabling
> large folios, so that large folios gets enabled only when all the bdi
> stuff for it is ready.

Will do, thanks for reading these patches!

Also note that I've changed this part of the patchset quite a lot since
this posting; iomap configuration is now a completely separate fuse
command that gets triggered after the FUSE_INIT reply is received.

--D

> Thanks,
> Joanne
> 
> >
> >         /*
> >          * Enable syncfs for iomap fuse servers so that we can send a final
> >
> 

