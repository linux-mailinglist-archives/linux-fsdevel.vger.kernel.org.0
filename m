Return-Path: <linux-fsdevel+bounces-4110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ABD7FCB9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59237282C4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C5E184F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sL4WMb7+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tUaDAzUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F87C198;
	Tue, 28 Nov 2023 15:20:35 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DB5B2199B;
	Tue, 28 Nov 2023 23:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701213634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVc7UAyU6ZogJ6/vvG9iCqN5VRReOr8x/ACjsbRIczI=;
	b=sL4WMb7+P221LZPkPonZ5CZPIrEpBh5VG5bAGIh6rBiuKBoGkT/6dInIErUlXOIibnJdN+
	KldQUwNo8dGjXdI9S6HanlHGm1uGVKSlLrhj+xyOGzSIZryvbNju71wWro6gKWl9fFWKxA
	yrRtdXy8ctSNnUcZoxggY/srBHUsHBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701213634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVc7UAyU6ZogJ6/vvG9iCqN5VRReOr8x/ACjsbRIczI=;
	b=tUaDAzUYq9tRMCpXWzT7cCbLHYzoj36lQYak9w2AnNhc6CSl7m8+h57yU58/YNDMo37Brl
	ir+WcGswcaA08+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A76A313763;
	Tue, 28 Nov 2023 23:20:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3vbRFL91ZmUvVwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 28 Nov 2023 23:20:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
In-reply-to: <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>,
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>,
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>,
 <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>
Date: Wed, 29 Nov 2023 10:20:23 +1100
Message-id: <170121362397.7109.17858114692838122621@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.959];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.29

On Wed, 29 Nov 2023, Christian Brauner wrote:
> [Reusing the trimmed Cc]
>=20
> On Tue, Nov 28, 2023 at 11:16:06AM +1100, NeilBrown wrote:
> > On Tue, 28 Nov 2023, Chuck Lever wrote:
> > > On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> > > >=20
> > > > I have evidence from a customer site of 256 nfsd threads adding files=
 to
> > > > delayed_fput_lists nearly twice as fast they are retired by a single
> > > > work-queue thread running delayed_fput().  As you might imagine this
> > > > does not end well (20 million files in the queue at the time a snapsh=
ot
> > > > was taken for analysis).
> > > >=20
> > > > While this might point to a problem with the filesystem not handling =
the
> > > > final close efficiently, such problems should only hurt throughput, n=
ot
> > > > lead to memory exhaustion.
> > >=20
> > > I have this patch queued for v6.8:
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=
=3Dnfsd-next&id=3Dc42661ffa58acfeaf73b932dec1e6f04ce8a98c0
> > >=20
> >=20
> > Thanks....
> > I think that change is good, but I don't think it addresses the problem
> > mentioned in the description, and it is not directly relevant to the
> > problem I saw ... though it is complicated.
> >=20
> > The problem "workqueue ...  hogged cpu..." probably means that
> > nfsd_file_dispose_list() needs a cond_resched() call in the loop.
> > That will stop it from hogging the CPU whether it is tied to one CPU or
> > free to roam.
> >=20
> > Also that work is calling filp_close() which primarily calls
> > filp_flush().
> > It also calls fput() but that does minimal work.  If there is much work
> > to do then that is offloaded to another work-item.  *That* is the
> > workitem that I had problems with.
> >=20
> > The problem I saw was with an older kernel which didn't have the nfsd
> > file cache and so probably is calling filp_close more often.  So maybe
> > my patch isn't so important now.  Particularly as nfsd now isn't closing
> > most files in-task but instead offloads that to another task.  So the
> > final fput will not be handled by the nfsd task either.
> >=20
> > But I think there is room for improvement.  Gathering lots of files
> > together into a list and closing them sequentially is not going to be as
> > efficient as closing them in parallel.
> >=20
> > >=20
> > > > For normal threads, the thread that closes the file also calls the
> > > > final fput so there is natural rate limiting preventing excessive gro=
wth
> > > > in the list of delayed fputs.  For kernel threads, and particularly f=
or
> > > > nfsd, delayed in the final fput do not impose any throttling to preve=
nt
> > > > the thread from closing more files.
> > >=20
> > > I don't think we want to block nfsd threads waiting for files to
> > > close. Won't that be a potential denial of service?
> >=20
> > Not as much as the denial of service caused by memory exhaustion due to
> > an indefinitely growing list of files waiting to be closed by a single
> > thread of workqueue.
>=20
> It seems less likely that you run into memory exhausting than a DOS
> because nfsd() is busy closing fds. Especially because you default to
> single nfsd thread afaict.

An nfsd thread would not end up being busy closing fds any more than it
can already be busy reading data or busy syncing out changes or busying
renaming a file.
Which it is say: of course it can be busy doing this, but doing this sort
of thing is its whole purpose in life.

If an nfsd thread only completes the close that it initiated the close
on (which is what I am currently proposing) then there would be at most
one, or maybe 2, fds to close after handling each request.  While that
is certainly a non-zero burden, I can't see how it can realistically be
called a DOS.

>=20
> > I think it is perfectly reasonable that when handling an NFSv4 CLOSE,
> > the nfsd thread should completely handle that request including all the
> > flush and ->release etc.  If that causes any denial of service, then
> > simple increase the number of nfsd threads.
>=20
> But isn't that a significant behavioral change? So I would expect to
> make this at configurable via a module- or Kconfig option?

Not really.  Certainly not more than the change to introduce the
filecache to nfsd in v5.4.

>=20
> > For NFSv3 it is more complex.  On the kernel where I saw a problem the
> > filp_close happen after each READ or WRITE (though I think the customer
> > was using NFSv4...).  With the file cache there is no thread that is
> > obviously responsible for the close.
> > To get the sort of throttling that I think is need, we could possibly
> > have each "nfsd_open" check if there are pending closes, and to wait for
> > some small amount of progress.
> >=20
> > But don't think it is reasonable for the nfsd threads to take none of
> > the burden of closing files as that can result in imbalance.
>=20
> It feels that this really needs to be tested under a similar workload in
> question to see whether this is a viable solution.
>=20

Creating that workload might be a challenge.  I know it involved
accessing 10s of millions of files with a server that was somewhat
memory constrained.  I don't know anything about the access pattern.

Certainly I'll try to reproduce something similar by inserting delays in
suitable places.  This will help exercise the code, but won't really
replicate the actual workload.

Thanks,
NeilBrown

