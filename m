Return-Path: <linux-fsdevel+bounces-30380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1A098A6E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DF72829E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAC11917C9;
	Mon, 30 Sep 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="w9ynys3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F62CA5;
	Mon, 30 Sep 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706111; cv=none; b=GP0Zu5v57bUGiVIXs4fXLfMzGJGiSnT+jRjRMb5W7AiKcdFW3NsLEpMCOeF5Kuw7lyYdqp6O/Os0R/OaWZgok0CKko6PslggGKxl9qGeEltiEctItCcO7KFFFI9Jh5lt7l1+Kp+u/AJ/erIHW9FgzjtAmqIa1pO86DU2aPdfmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706111; c=relaxed/simple;
	bh=3/yRJEQ92EpQSzsipntMFR1scWRGwYAoXb2wempQSaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8Pev4YHWY0BBC7iK4Ewe+JEZvNqTrT8EY73sIbEKVAPEcX2Jf0eMJ3krvKERNKoTeu7C/VEzKVTq1qsIXPGM+NcFDW6SwSr9l5cEnqwd5i3r2wpUryJZqtdxVuT21jNscU2QyxUSPfHQKOwLcH5Hv4P5zsvzEBsin36LwyNXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=w9ynys3f; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XHNYN2m3Jz9sPn;
	Mon, 30 Sep 2024 16:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1727706104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbDlpohMGyKbU24tJpU7s9PNV5HIsnEIUJ337YJEe0E=;
	b=w9ynys3f5TGtKkd8kaUSuPTTOef++CqXfd5FlZGlDnB6B/xA6kPvZEcSaIl8ntCz/49z6O
	wZdzkCWh8n7l156xTCAMsWG2dBluZVnuG1OCVy25ckbImIvH94K9GDJCXWUAA/0/XNDUcV
	JLwKDNq6CetEYGIUNqER0yZoDtdsJ1YIrcy08Hx0MxzfHGez3VNox2cZLqrc6FuyBICJdX
	JSA8vqb0v6pHlHxFxORqoiCUcfXVkPE6bbkMUPNkJ3D9u8m1P4qCa0Y3yxs1eCpKpciO3o
	zzTF/gqG2PTE3ASWFngVEo/E0dk5lBcFXzvnLi7sJO8H73LcyPTAO3ob9sbYrQ==
Date: Mon, 30 Sep 2024 16:21:23 +0200
From: Aleksa Sarai <cyphar@cyphar.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Florian Weimer <fweimer@redhat.com>, Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] introduce PIDFD_SELF
Message-ID: <20240930.141721-salted.birth.growing.forges-5Z29YNO700C@cyphar.com>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
 <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
 <42df57ac-d89c-4111-a04d-290dd2197573@lucifer.local>
 <20240930-verbiegen-zinspolitik-cafb730c3c84@brauner>
 <cdd24e6d-4300-4afe-b2ef-1b8ee528bccc@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6a2j2i22ruyltnqf"
Content-Disposition: inline
In-Reply-To: <cdd24e6d-4300-4afe-b2ef-1b8ee528bccc@lucifer.local>


--6a2j2i22ruyltnqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-30, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> On Mon, Sep 30, 2024 at 02:34:33PM GMT, Christian Brauner wrote:
> > On Mon, Sep 30, 2024 at 11:39:49AM GMT, Lorenzo Stoakes wrote:
> > > On Mon, Sep 30, 2024 at 12:33:18PM GMT, Florian Weimer wrote:
> > > > * Lorenzo Stoakes:
> > > >
> > > > > If you wish to utilise a pidfd interface to refer to the current =
process
> > > > > (from the point of view of userland - from the kernel point of vi=
ew - the
> > > > > thread group leader), it is rather cumbersome, requiring somethin=
g like:
> > > > >
> > > > > 	int pidfd =3D pidfd_open(getpid(), 0);
> > > > >
> > > > > 	...
> > > > >
> > > > > 	close(pidfd);
> > > > >
> > > > > Or the equivalent call opening /proc/self. It is more convenient =
to use a
> > > > > sentinel value to indicate to an interface that accepts a pidfd t=
hat we
> > > > > simply wish to refer to the current process.
> > > >
> > > > The descriptor will refer to the current thread, not process, right?
> > >
> > > No it refers to the current process (i.e. thread group leader from ke=
rnel
> > > perspective). Unless you specify PIDFD_THREAD, this is the same if yo=
u did the above.
> > >
> > > >
> > > > The distinction matters for pidfd_getfd if a process contains multi=
ple
> > > > threads with different file descriptor tables, and probably for
> > > > pidfd_send_signal as well.
> > >
> > > You mean if you did a strange set of flags to clone()? Otherwise thes=
e are
> > > shared right?
> > >
> > > Again, we are explicitly looking at process not thread from userland
> > > perspective. A PIDFD_SELF_THREAD might be possible, but this series d=
oesn't try
> > > to implement that.
> >
> > Florian raises a good point. Currently we have:
> >
> > (1) int pidfd_tgid =3D pidfd_open(getpid(), 0);
> > (2) int pidfd_thread =3D pidfd_open(getpid(), PIDFD_THREAD);
> >
> > and this instructs:
> >
> > pidfd_send_signal()
> > pidfd_getfd()
> >
> > to do different things. For pidfd_send_signal() it's whether the
> > operation has thread-group scope or thread-scope for pidfd_send_signal()
> > and for pidfd_getfd() it determines the fdtable to use.
> >
> > The thing is that if you pass:
> >
> > pidfd_getfd(PDIFD_SELF)
> >
> > and you have:
> >
> > TGID
> >
> > T1 {
> >     clone(CLONE_THREAD)
> >     unshare(CLONE_FILES)
> > }
> >
> > T2 {
> >     clone(CLONE_THREAD)
> >     unshare(CLONE_FILES)
> > }
> >
> > You have 3 threads in the same thread-group that all have distinct file
> > descriptor tables from each other.
> >
> > So if T1 did:
> >
> > pidfd_getfd(PIDFD_SELF, ...)
> >
> > and we mirror the PIDTYPE_TGID behavior then T1 will very likely expect
> > to get the fd from its file descriptor table. IOW, its reasonable to
> > expect that T1 is interested in their very own resource, not someone
> > else's even if it is the thread-group leader.
> >
> > But what T1 will get in reality is an fd from TGID's file descriptor
> > table (and similar for T2).
> >
> > Iirc, yes that confusion exists already with /proc/self. But the
> > question is whether we should add the same confusion to the pidfd api or
> > whether we make PIDFD_SELF actually mean PIDTYPE_PID aka the actual
> > calling thread.
> >
> > My thinking is that if you have the reasonable suspicion that you're
> > multi-threaded and that you're interested in the thread-group resource
> > then you should be using:
> >
> > int pidfd =3D pidfd_open(getpid(), 0)
> >
> > and hand that thread-group leader pidfd around since you're interested
> > in another thread. But if you're really just interested in your own
> > resource then pidfd_open(getpid(), 0) makes no sense and you would want
> > PIDFD_SELF.
> >
> > Thoughts?
>=20
> I mean from my perspective, my aim is to get current->mm for
> process_madvise() so both work for me :) however you both raise a very go=
od
> point here (sorry Florian, perhaps I was a little too dismissive as to yo=
ur
> point, you're absolutely right).
>=20
> My intent was for PIDFD_SELF to simply mirror the pidfd_open(getpid(), 0)
> behaviour, but you and Florian make a strong case that you'd _probably_
> find this very confusing had you unshared in this fashion.
>=20
> I mean in general this confusion already exists, and is for what
> PIDFD_THREAD was created, but I suspect ideally if you could go back you
> might actually do this by default Christian + let the TGL behaviour be the
> optional thing?
>=20
> For most users this will not be an issue, but for those they'd get the sa=
me
> result whichever they used, but yes actually I think you're both right -
> PIDFD_SELF should in effect imply PIDFD_THREAD.

Funnily enough we ran into issues with this when running Go code in runc
that did precisely this -- /proc/self gave you the wrong fd table in
very specific circumstances that were annoying to debug. For languages
with green-threading you can't turn off (like Go) these kinds of issues
pop up surprisingly often.

> We can adjust the pidfd_send_signal() call to infer the correct scope
> (actually nicely we can do that without any change there, by having
> __pidfd_get_pid() set f_flags accordingly).
>=20
> So TL;DR: I agree, I will respin with PIDFD_SELF referring to the thread.
>=20
> My question in return here then is - should we introduce PIDFD_SELF_PROCE=
SS
> also (do advise if you feel this naming isn't quite right) - to provide
> thread group leader behaviour?

Sorry to bike-shed, but to match /proc/self and /proc/thread-self, maybe
they should be called PIDFD_SELF (for tgid) and PIDFD_THREAD_SELF (for
current's tid)? In principle I guess users might use PIDFD_SELF by
accident but if we mirror the naming with /proc/{,thread-}self that
might not be that big of an issue?

Just a thought.

>=20
> Thanks!
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--6a2j2i22ruyltnqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZvqz4wAKCRAol/rSt+lE
b7GGAQChOyMNzOC/RM56OVrgBcSbrRYTofZfidupfTSRne9UVAEArUjap0YYofOn
VdJnnofMreht73y08E5gdexZZ9eZmg4=
=CCUx
-----END PGP SIGNATURE-----

--6a2j2i22ruyltnqf--

