Return-Path: <linux-fsdevel+bounces-75777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Oy9Kk9Cemmr4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:07:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A0A6898
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 839343015842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EAC311963;
	Wed, 28 Jan 2026 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="fBGTHIOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KViTMDzL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E9265CC2;
	Wed, 28 Jan 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619513; cv=none; b=gt60dbakVRPloLGguurVjhbx9FomzBQEaILkza35ZP1ugzpd8hsweIWGSJSs/BpN4dM0BgTdQuUqFbOfy+cWxg1+DojJvxGse74IIuDwUX9IfI8wmnoAWF/VYW2SP9WRz/iCMnHkOL/Pc4lOUA9vHKg9/osABzyIXhbvGJqYlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619513; c=relaxed/simple;
	bh=xR1Krxifpyg086yZHDGLmylUBf6UCzlZqS4eAl7Y74I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lqnoOME/n0AzPwsjmtj29E1oivgQvp8ykvpGAMwBW4H0uJpNu0LsuPGAeiwv4IpPkqHHl5er1KGPFFxCnYAe44Gtl2OyMOY1ZtyHI06Wnp5MmaLv8JosSTQf+NM5sE+7xx03eOfHS/9X2yGh4rD2/8W242ddGBgD02+Dt3YOrqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=fBGTHIOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KViTMDzL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C68F8140005B;
	Wed, 28 Jan 2026 11:58:28 -0500 (EST)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-01.internal (MEProxy); Wed, 28 Jan 2026 11:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769619508;
	 x=1769705908; bh=zFLSMhSBtSz/kqy2k31nrRV1RnwJeNNpaO0Z16KVnI4=; b=
	fBGTHIOQiy9yi+NVlY/c+8BHnraGEKL2lEVDamh3sO3O+vM86AyT9TKU1zseSy+o
	NgT4jxZGbB2HExY4mcp0yoY6Wx2EVJopJFH8F8PusFzV5QX+VokbTbICwtwQPiz2
	P9IYCs3FLmwCSDwNqgAhZosrjP880yTZzeSVd6v+FSzhGzcsOSXzXAdetiT76Tci
	x2762MBJoVX+p6Q8kr444MtHIM5VBl9UQsOtAV+9QV/gaCikzXfRitTbj7oIwusq
	U1xwECdbNu5sMteuf4eRd6VrzUVYYHgoE6Pu4O1r2Jw61gGGtd1DpW0898xLwe0n
	oJ9xIs1yM9uGKSLLmKNPgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769619508; x=
	1769705908; bh=zFLSMhSBtSz/kqy2k31nrRV1RnwJeNNpaO0Z16KVnI4=; b=K
	ViTMDzL5AJ6udO13ku+tRgTvtpLXCAyNX7uwHdZTCfmBXdXZ14U1PEsTI2YwAsXj
	6CUcG5eOkrbK9iJc1R3BFj76vdr1Fs2A8AIxFTPl6hXT86kGPdlJ1Bq2Ktz0dZCc
	soyp2zwvxlXNMEFQ/ineWPQBvsVLwBSXiVUBUdeur4G7b62gPr/Pl5tJouqcuwwI
	vFQKjYaQPDyQLApvANFIuWWfiUeABR02W3gWClTQqyaA0mcwVBWCefAjLN9Sfemu
	K7ArSwnChV4uDfw5v9pw1Z6EHwhpZr5UiY2aAXi78FNZTRlrQPrGC34M4H4sIE1G
	CGcfJ2t/pI48wMZtlcfog==
X-ME-Sender: <xms:NEB6aQ7Ktx72Oflm9nT77RvGKP97ruCq9mxYzGhFaFxpwUXd0C1puw>
    <xme:NEB6actvQHh8OItohKSPng2U9xaypTA44odnvBJUtxXNc6zP0UC-W4o1RcEuB7t1U
    o9R0xb_1qCft3ty9m-A3zeKN8DM3eFZHP4T57zU1E3oGP4uH56lmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfkggrtghk
    ucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholhhiohdrohhrgheqnecuggftrf
    grthhtvghrnhepffffleeihfekfeetheeiieelueffleegvdejgffhhffhheehgfethfeg
    jeduueehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epiigrtghksehofihlfhholhhiohdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkvghrnhgvlhesihhnfhhinhhithgvqdhsoh
    hurhgtvgdruggvpdhrtghpthhtoheprghlgieskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrlhhirghssehlihgstgdrohhrghdp
    rhgtphhtthhopehlihgstgdqrghlphhhrgesshhouhhrtggvfigrrhgvrdhorhhgpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhmghhrohhsshesuhhm
    ihgthhdrvgguuhdprhgtphhtthhopehlihhnuhigqdgrphhisehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:NEB6aRJGf4fTAe30aCnsaSZ6MFLjNugF_39DzUz5iT62LJEWm00lWg>
    <xmx:NEB6aTqhKqQaGjg14guVoWHUyyZSJ8EfZRULYmhaDXruxPFUEd8wEg>
    <xmx:NEB6aXvMYrmNvwz-RCxyHRt5yDDhMwKUoqXS8kimpB2lgEyjliM2ww>
    <xmx:NEB6aVLe1etySSCpQv15HGV29s2ymlEMxtaeGsqVT14KXUouEMjiSQ>
    <xmx:NEB6aSnQ-Ssy5vNoVfoHjTNbRDxKod9dLc62yysOynt_nuX-sMTWsK3k>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 03D2BC4006E; Wed, 28 Jan 2026 11:58:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANFeMez8yEXZ
Date: Wed, 28 Jan 2026 11:58:07 -0500
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Jeff Layton" <jlayton@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Jan Kara" <jack@suse.cz>, "The 8472" <kernel@infinite-source.de>
Cc: "Rich Felker" <dalias@libc.org>, "Alejandro Colomar" <alx@kernel.org>,
 "Vincent Lefevre" <vincent@vinc17.net>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, "GNU libc development" <libc-alpha@sourceware.org>
Message-Id: <037a7546-cbbf-4c00-bebd-57cee38785e1@app.fastmail.com>
In-Reply-To: <2d6276fca349357f56733268681424b0de5179f7.camel@kernel.org>
References: <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan> <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
 <20260124213934.GI6263@brightrain.aerifal.cx>
 <7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
 <de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com>
 <whaocgx6bopndbpag2wazn2ko4skxl4pe6owbavj3wblxjps4s@ntdfvzwggxv3>
 <c59361e4-ad50-4cdf-888e-3d9a4aa6f69b@infinite-source.de>
 <pt7hcmgnzwveyzxdfpxtrmz2bt5tki5wosu3kkboil7bjrolyr@hd4ctkpzzqzi>
 <72100ec4b1ec0e77623bfdb927746dddc77ed116.camel@kernel.org>
 <DFYW8O4499ZS.2L1ABA5T5XFF2@umich.edu>
 <2d6276fca349357f56733268681424b0de5179f7.camel@kernel.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from POSIX.1-2024
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[owlfolio.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[owlfolio.org:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75777-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack@owlfolio.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[owlfolio.org:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[owlfolio.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 3C0A0A6898
X-Rspamd-Action: no action

On Mon, Jan 26, 2026, at 7:49 PM, Jeff Layton wrote:
> On Mon, 2026-01-26 at 17:01 -0600, Trevor Gross wrote:
>> On Mon Jan 26, 2026 at 10:43 AM CST, Jeff Layton wrote:
>> > On Mon, 2026-01-26 at 16:56 +0100, Jan Kara wrote:
>> > > On Mon 26-01-26 14:53:12, The 8472 wrote:
>> > > > On 26/01/2026 13:15, Jan Kara wrote:
>> > > > > On Sun 25-01-26 10:37:01, Zack Weinberg wrote:
>> > > > > > On Sat, Jan 24, 2026, at 4:57 PM, The 8472 wrote:
...
>> > > > > > In particular, I really hope delayed errors *aren=E2=80=99t=
* ever reported
>> > > > > > when you close a file descriptor that *isn=E2=80=99t* the l=
ast reference
>> > > > > > to its open file description, because the thread-safe way t=
o close
>> > > > > > stdout without losing write errors[2] depends on that not h=
appening.
>> > > > >
>> > > > > So I've checked and in Linux ->flush callback for the file is=
 called
>> > > > > whenever you close a file descriptor (regardless whether ther=
e are other
>> > > > > file descriptors pointing to the same file description) so it=
's upto
>> > > > > filesystem implementation what it decides to do and which err=
or it will
>> > > > > return... Checking the implementations e.g. FUSE and NFS *wil=
l* return
>> > > > > delayed writeback errors on *first* descriptor close even if =
there are
>> > > > > other still open descriptors for the description AFAICS.
>> >
>> > ...and I really wish they _didn't_.
>> >
>> > Reporting a writeback error on close is not particularly useful. Mo=
st
>> > filesystems don't require you to write back all data on a close(). A
>> > successful close() on those just means that no error has happened y=
et.
>> >
>> > Any application that cares about writeback errors needs to fsync(),
>> > full stop.
>>
>> Is there a good middle ground solution here?
...
>> I was wondering if it could be worth a new fnctl that provides this k=
ind
>> of "best effort" error checking behavior without having the strict
>> requirements of fsync. In effect, to report the errors that you might
>> currently get at close() before actually calling close() and losing t=
he
>> fd.
...
> A new fcntl(..., F_CHECKERR, ...) command that does a
> file_check_and_advance_wb_err() on the fd and reports the result would
> be pretty straightforward.
>
> Would that be helpful for your use-case? This would be like a non-
> blocking fsync that just reports whether an error has occurred since
> the last F_CHECKERR or fsync().

I feel I need to point out that =E2=80=9Cshould the kernel report errors=
 on
close()=E2=80=9D and =E2=80=9Cshould the kernel add a new API to make li=
fe better for
programs that currently expect close() to report [some] errors=E2=80=9D =
and
=E2=80=9Cshould the Rust standard library propagate errors produced by c=
lose()
back up to the application=E2=80=9D and =E2=80=9Cwhat should the close(2=
) manpage say
about errors=E2=80=9D are four different conversation topics.

I am all in favor of moving toward a world where close() never fails
and there=E2=80=99s _something_ that reports write errors like fsync() w=
ithout
also kicking your application off a performance cliff.  But that=E2=80=99=
s not
the world we live in today, and this thread started as a conversation
about revising the close(2) manpage, and I=E2=80=99d kinda like to *fini=
sh*
revising the manpage in, like, the next couple weeks, not several
years from now :-)  So I=E2=80=99d like to refocus on that topic.

Given what Jan Kara said earlier...

> Checking the implementations e.g. FUSE and NFS *will* return delayed
> writeback errors on *first* descriptor close even if there are other
> still open descriptors for the description AFAICS.
...
> fsync(2) must make sure data is persistently stored and return error if
> it was not. Thus as a VFS person I'd consider it a filesystem bug if an
> error preveting reading data later was not returned from fsync(2). OTOH
> that doesn't necessarily mean that later close doesn't return an error=
 -
> e.g. FUSE does communicate with the server on close that can fail and
> error can be returned.
>
> With this in mind let me now try to answer your remaining questions:
>
>> >>         - The OFD was opened with O_RDONLY
>
> If the filesystem supports atime, close can in principle report that a=
time
> update failed.
>
>> >>         - The OFD was opened with O_RDWR but has never actually
>> >>           been written to
>
> The same as above but with inode mtime updates.
>
>> >>         - No data has been written to the OFD since the last call =
to
>> >>           fsync() for that OFD
>
> No writeback errors should happen in this case. As I wrote above I'd
> consider this a filesystem bug.
>
>> >>
>> >>         - No data has been written to the OFD since the last call =
to
>> >>           fdatasync() for that OFD
>
> Errors can happen because some inode metadata (in practice probably on=
ly
> inode time stamps) may still need to be written out.
>
> So in the cases described above (except for fsync()) you may get delay=
ed
> errors on close. But since in all those cases no data is lost, I don't
> think 99.9% of applications care at all...

... regrettably I think this does mean the close(3) manpage still needs
to tell people to watch out for errors, and should probably say that
errors _can_ happen even if the file wasn=E2=80=99t written to, but are =
much
less likely to be important in that case.

And my =E2=80=9Chow to close stdout in a thread-safe manner=E2=80=9D sam=
ple code is
wrong, because I was wrong to think that the error reporting only
happened on the _final_ close, when the OFD is destroyed.

... What happens if the close is implicit in a dup2() operation? Here=E2=
=80=99s
that erroneous =E2=80=9Chow to close stdout=E2=80=9D fragment, with comm=
ents
indicating what I thought could and could not fail at the time I wrote
it:

    // These allocate new fds, which can always fail, e.g. because
    // the program already has too many files open.
    int new_stdout =3D open("/dev/null", O_WRONLY);
    if (new_stdout =3D=3D -1) perror_exit("/dev/null");
    int old_stdout =3D dup(1);
    if (old_stdout =3D=3D -1) perror_exit("dup(1)");

    flockfile(stdout);
    if (fflush(stdout)) perror_exit("stdout: write error");
    dup2(new_stdout, 1); // cannot fail, atomically replaces fd 1
    funlockfile(stdout);

    // this close may receive delayed write errors from previous writes
    // to stdout
    if (close(old_stdout)) perror_exit("stdout: write error");

    // this close cannot fail, because it only drops an alternative
    // reference to the open file description now installed as fd 1
    close(new_stdout);

Note in particular that the first close _operation_ on fd 1 is in
consequence of dup2(new_stdout, 1).  The dup2() manpage specifically
says =E2=80=9Cthe close is performed silently (i.e. any errors during the
close are not reported by dup()=E2=80=9D but, if stdout points to a file=
 on
an NFS mount, are those errors _lost_, or will they actually be
reported by the subsequent close(old_stdout)?

Incidentally, the dup2() manpage has a very similar example in its
NOTES section, also presuming that close only reports errors on the
_final_ close, not when it =E2=80=9Cmerely=E2=80=9D drops reference >=3D=
2 to an OFD.

(I=E2=80=99m starting to think we need dup3(old, new, O_SWAP_FDS).  Or i=
s that
already a thing somehow?)

zw

