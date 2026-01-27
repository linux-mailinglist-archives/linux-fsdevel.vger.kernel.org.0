Return-Path: <linux-fsdevel+bounces-75564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGcCOvUeeGkKoQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 03:12:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D68EEB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 03:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31AAD303C81D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 02:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055582C028C;
	Tue, 27 Jan 2026 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3Of+E40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375F139D;
	Tue, 27 Jan 2026 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479785; cv=none; b=GArwxOKC53TgKiIsvx7/fZzh3krFWl2fgRBDuQSifFW36heuIUNG6gpSIv69BZyV587dNCBruSBFoEOxYhKVzkzD+MpRSUHfxeUZWZRAVA7jg0eAzV2n209IZH694yFCH3sBJ0TWe9xVGrXbAeYq96l7MZ5qgoxqy5ocf/WzDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479785; c=relaxed/simple;
	bh=O3CaH0TDC8xAXxftELWF900O1DrkVgWpAPOV4js38eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfVBvIklRO8cnIWsomEYntSp1QYtBPa4RiQ6VhV8b6kTveoiAeHFB/8bKEv+6846+lS+N96Os5KABy2dGabtoL1l/ZIkD6siEh1T3PdQj7PVE0PQPYyMjwIIlu1XhGmsIRwvFk4KklTiMz+ulcrEPhVcSwE8iZvzJFGQFyBAo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3Of+E40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE62C116C6;
	Tue, 27 Jan 2026 02:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769479785;
	bh=O3CaH0TDC8xAXxftELWF900O1DrkVgWpAPOV4js38eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3Of+E40KLjmt2x6EfGM7py+k4yAauFccwNIj/JL/o+BWjV5OMvYPdpzxQifU7+hz
	 MBIwITWyWpkQSSzxqsHKZSTWKRz5iz2nEKsVB9Z/yy8JpzgNJXWiK+NnSU/xuA9FIH
	 iFwLIDNmWYXDrgh4yABOzVGhPjBnUa7Vj8emYld6vvqeoct1W4H4I5dxTEI4mvVdgm
	 5Gpu80jGmqTGVF5YLs+g+Vki4++QdJaHselN7b4Ds5WuU3XHvW7D3IKgxAfSpRCpOL
	 AqPKVpOvFsoqjkMG8vOlqqfpEvvoja4B7tA9JwG7KXtwSy+RMYGsCMmKRpzuNxu1zr
	 Vjog4rxlERWgA==
Date: Mon, 26 Jan 2026 18:09:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/31] fuse: use an unrestricted backing device with
 iomap pagecache io
Message-ID: <20260127020944.GF5900@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810721.1424854.6150447623894591900.stgit@frogsfrogsfrogs>
 <CAJnrk1ZDz5pQUtyiphuqtyAJtpx23x1BcdPUDBRJRfJaguzrhQ@mail.gmail.com>
 <20260126235531.GE5900@frogsfrogsfrogs>
 <CAJnrk1ZYF7MG0mBZ4GRdKfmSiEEx3vXxgiH3oYdMS-neWSA2mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZYF7MG0mBZ4GRdKfmSiEEx3vXxgiH3oYdMS-neWSA2mw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75564-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 645D68EEB1
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:35:05PM -0800, Joanne Koong wrote:
> On Mon, Jan 26, 2026 at 3:55 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Jan 26, 2026 at 02:03:35PM -0800, Joanne Koong wrote:
> > > On Tue, Oct 28, 2025 at 5:49 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > With iomap support turned on for the pagecache, the kernel issues
> > > > writeback to directly to block devices and we no longer have to push all
> > > > those pages through the fuse device to userspace.  Therefore, we don't
> > > > need the tight dirty limits (~1M) that are used for regular fuse.  This
> > > > dramatically increases the performance of fuse's pagecache IO.
> > > >
> > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  fs/fuse/file_iomap.c |   21 +++++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > >
> > > >
> > > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > > index 0bae356045638b..a9bacaa0991afa 100644
> > > > --- a/fs/fuse/file_iomap.c
> > > > +++ b/fs/fuse/file_iomap.c
> > > > @@ -713,6 +713,27 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
> > > >  void fuse_iomap_mount(struct fuse_mount *fm)
> > > >  {
> > > >         struct fuse_conn *fc = fm->fc;
> > > > +       struct super_block *sb = fm->sb;
> > > > +       struct backing_dev_info *old_bdi = sb->s_bdi;
> > > > +       char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
> > > > +       int res;
> > > > +
> > > > +       /*
> > > > +        * sb->s_bdi points to the initial private bdi.  However, we want to
> > > > +        * redirect it to a new private bdi with default dirty and readahead
> > > > +        * settings because iomap writeback won't be pushing a ton of dirty
> > > > +        * data through the fuse device.  If this fails we fall back to the
> > > > +        * initial fuse bdi.
> > > > +        */
> > > > +       sb->s_bdi = &noop_backing_dev_info;
> > > > +       res = super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
> > > > +                                  MINOR(fc->dev), suffix);
> > > > +       if (res) {
> > > > +               sb->s_bdi = old_bdi;
> > > > +       } else {
> > > > +               bdi_unregister(old_bdi);
> > > > +               bdi_put(old_bdi);
> > > > +       }
> > >
> > > Maybe I'm missing something here, but isn't sb->s_bdi already set to
> > > noop_backing_dev_info when fuse_iomap_mount() is called?
> > > fuse_fill_super() -> fuse_fill_super_common() -> fuse_bdi_init() does
> > > this already before the fuse_iomap_mount() call, afaict.
> >
> > Right.
> >
> > > I think what we need to do is just unset BDI_CAP_STRICTLIMIT and
> > > adjust the bdi max ratio?
> >
> > That's sufficient to undo the effects of fuse_bdi_init, yes.  However
> > the BDI gets created with the name "$major:$minor{-fuseblk}" and there
> > are "management" scripts that try to tweak fuse BDIs for better
> > performance.
> >
> > I don't want some dumb script to mismanage a fuse-iomap filesystem
> > because it can't tell the difference, so I create a new bdi with the
> > name "$major:$minor.iomap" to make it obvious.  But super_setup_bdi_name
> > gets cranky if s_bdi isn't set to noop and we don't want to fail a mount
> > here due to ENOMEM so ... I implemented this weird switcheroo code.
> 
> I see. It might be useful to copy/paste this into the commit message
> just for added context. I don't see a better way of doing it than what
> you have in this patch then since we rely on the init reply to know
> whether iomap should be used or not...

I'll do that.  I will also add that as soon as any BDI is created, it
will be exposed to userspace in sysfs.  That means that running the code
from fuse_bdi_init in reverse will not necessarily produce the same
results as a freshly created BDI.

> If the new bdi setup fails, I wonder if the mount should just fail
> entirely then. That seems better to me than letting it succeed with

Err, which new bdi setup?  If fuse-iomap can't create a new BDI, it will
set s_bdi back to the old one and move on.  You'll get degraded
performance, but that's not the end of the world.

> strictlimiting enforced, especially since large folios will be enabled
> for fuse iomap. [1] has some numbers for the performance degradations
> I saw for writes with strictlimiting on and large folios enabled.

If fuse_bdi_init can't set up a bdi it will fail the mount.

That said... from reading [1], if strictlimiting is enabled with large
folios, then can we figure out what is the effective max folio size and
lower it to that?

> Speaking of strictlimiting though, from a policy standpoint if we
> think strictlimiting is needed in general in fuse (there's a thread
> from last year [1] about removing strict limiting), then I think that

(did you mean [2] here?)

> would need to apply to iomap as well, at least for unprivileged
> servers.

iomap requires a privileged server, FWIW.

> [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com/
> [2] https://lore.kernel.org/linux-fsdevel/20251010150113.GC6174@frogsfrogsfrogs/T/#ma34ff5ae338a83f8b2e946d7e5332ea835fa0ff6
> 
> >
> > > This is more of a nit, but I think it'd also be nice if we
> > > swapped the ordering of this patch with the previous one enabling
> > > large folios, so that large folios gets enabled only when all the bdi
> > > stuff for it is ready.
> >
> > Will do, thanks for reading these patches!
> >
> > Also note that I've changed this part of the patchset quite a lot since
> > this posting; iomap configuration is now a completely separate fuse
> > command that gets triggered after the FUSE_INIT reply is received.
> 
> Great, I'll look at your upstream tree then for this part.

Ok.

--D

> Thanks,
> Joanne
> 
> >
> > --D
> >
> > > Thanks,
> > > Joanne
> > >
> > > >
> > > >         /*
> > > >          * Enable syncfs for iomap fuse servers so that we can send a final
> > > >
> > >
> 

