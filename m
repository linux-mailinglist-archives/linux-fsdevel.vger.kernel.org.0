Return-Path: <linux-fsdevel+bounces-49791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D3BAC2953
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 20:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6A316D411
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA60298CD1;
	Fri, 23 May 2025 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="Ga68A5tI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uf0BgXVR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C72295D85;
	Fri, 23 May 2025 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023900; cv=none; b=Rj0Bz8SiTe8KtHtQjhC7x40DXS+zLtLNnxyKC5qiHb10u8qzMaIMrkLfu1tRnV9d/aMMGwPxg0r3fgF806hyPod3jlsRRhYTSdNEQkkN8P2eTdRJizrkCEg5eRCVSBdGwl83VEoc8yZp2OFCSYBsHnIVbn0XSHBXAvNiEhkhGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023900; c=relaxed/simple;
	bh=ujUiJfjJpbMw9Scy41se/iJuPUb+kVD4G/l6MK//UlA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MI5+u2BFGm/+oS5d2S02KbWYhIzGyR3c6lMgFY4+NG5aMUELKGjWZ1iNcs5UuwKt5oL+Yt7oPeCr/RVsoA8xfW7FvO/yl0kcZpkIn1C2JzIFbNwtKEDTd/0rfB5T3A81BNRQxKvN8ACs6RSEsUOJe6eQBY4oSbpcgcjHcG53nlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=Ga68A5tI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uf0BgXVR; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CDDA51140134;
	Fri, 23 May 2025 14:11:36 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-06.internal (MEProxy); Fri, 23 May 2025 14:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1748023896;
	 x=1748110296; bh=I1Ry+DzYaey7ox3+x/+Vl50lQ2rZHg2Y0pOqWX1DwGE=; b=
	Ga68A5tILdV2gvGpUlU1Gvsn5owkboMx9MDlKsC8rw3m5GVo+vqezzJTCqu70omN
	MQrlDd3pC43Lmo+4lKckYQKdKGwYRfYMkAIxHjKfB6cTHU1HGdwA7zXaxc0lHNns
	NqrWw0A2cwhl3XPGLVxNyMf9akpeFqK0hc1IPfKBjedREY3qecfoHETmHQ2hidVW
	0syRpAPha2ZTUzn6wOGPLEjUsPjia5QbUkSQucqrxiHK2M9qVgHU9XodjSIKHcT8
	7JKSD7h5YVyCPThGE1zSiqzFoyCHtNe8YjViwySEgqJq02bMSnRdhBX0D2p6pcZz
	uejP3kxqIlvYg8ye1w30RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748023896; x=
	1748110296; bh=I1Ry+DzYaey7ox3+x/+Vl50lQ2rZHg2Y0pOqWX1DwGE=; b=U
	f0BgXVRjQR9xBPKmMSnIWlnoXgppoMDHblRfgOWdnGdw8zI14gUvK08srz78jZ90
	2OPcAAmP4uM/eA2+AJuUGftHfeM2+66zmfXrNRygw9nC3bI7a1WVmr5uWBd2EMno
	SYk8ovusRkQKok++/omwlanDAfWYcgPD/6aFkp2IirlLZCBsX7f418tCe/DsO1hc
	Y5QDO9aq7hVHHZaPPvOEYsq7OVQS+AjEWe6VxrHXtRA4AD6F5mZ+zO8yzd5hjT6R
	Zr9DmBtwINpJYh4GgQvFgV5vnPJ/2M6VTDSysIVKFRiVyALxBsVPZZ/XbKhDEoKW
	ettn8En0C9p6mL4j8tUYg==
X-ME-Sender: <xms:V7owaPqH6sb0LvmBzGHDkoBFb9DuPlpDKyoTSUgoOQC1UJqg3OGNlA>
    <xme:V7owaJqddNYJCDM6JZoKlzjbKDz8OzjoXEt8J3MQ5eSwNTO1tXIa3iZqcUAw2Bxbw
    I2rnnIgRem0fOWgmcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelheefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtqhertdertdejnecuhfhrohhmpedfkggrtghkucghvghinhgsvghrghdfuc
    eoiigrtghksehofihlfhholhhiohdrohhrgheqnecuggftrfgrthhtvghrnhepffffleei
    hfekfeetheeiieelueffleegvdejgffhhffhheehgfethfegjeduueehnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiigrtghksehofihlfhho
    lhhiohdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprghlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrlhhirghssehlihgstgdrohhrghdprh
    gtphhtthhopehlihgstgdqrghlphhhrgesshhouhhrtggvfigrrhgvrdhorhhgpdhrtghp
    thhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqrghpihesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhinhgtvghnthesvhhinh
    gtudejrdhnvghtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhg
    rdhukh
X-ME-Proxy: <xmx:V7owaMPOl-Jo3AlwCXRDr_OI2dLGjgssGyBOX4_BvdjviR6D4W9sgw>
    <xmx:V7owaC6nDdkspIcXe5UdTJC7XhBfRgEfW93F9MF9Kwxe649XlnU2dg>
    <xmx:V7owaO5Gr-23BSfF7YP_Y9XkuCAaihybHYpnruNdi1mdirVVIkLQjQ>
    <xmx:V7owaKijqfVhqKhKx0uA55TNNMt2S6k7wF6HpxHPIMcW5wIc3SwdhQ>
    <xmx:WLowaMZEAnmoh6hf1-LB8yFxsdMJigGlZY6WKK1ctvN6F0ulXowbPNHl>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A8FCE2CC0081; Fri, 23 May 2025 14:11:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T610a97abf27e3e29
Date: Fri, 23 May 2025 14:10:57 -0400
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Alejandro Colomar" <alx@kernel.org>, "Rich Felker" <dalias@libc.org>
Cc: "Vincent Lefevre" <vincent@vinc17.net>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, "GNU libc development" <libc-alpha@sourceware.org>
Message-Id: <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
In-Reply-To: 
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from POSIX.1-2024
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Taking everything said in this thread into account, I have attempted to
wordsmith new language for the close(2) manpage.  Please let me know
what you think, and please help me with the bits marked in square
brackets. I can make this into a proper patch for the manpages
when everyone is happy with it.

zw

---

DESCRIPTION
    ... existing text ...

    close() always succeeds.  That is, after it returns, _fd_ has
    always been disconnected from the open file it formerly referred
    to, and its number can be recycled to refer to some other file.
    Furthermore, if _fd_ was the last reference to the underlying
    open file description, the resources associated with the open file
    description will always have been scheduled to be released.

    However, close may report _delayed errors_ from a previous I/O
    operation.  Therefore, its return value should not be ignored.

RETURN VALUE
    close() returns zero if there are no delayed errors to report,
    or -1 if there _might_ be delayed errors.

    When close() returns -1, check _errno_ to see what the situation
    actually is.  Most, but not all, _errno_ codes indicate a delayed
    I/O error that should be reported to the user.  See ERRORS and
    NOTES for more detail.

    [QUERY: Is it ever possible to get delayed errors on close() from
    a file that was opened with O_RDONLY?  What about a file that was
    opened with O_RDWR but never actually written to?  If people only
    have to worry about delayed errors if the file was actually
    written to, we should say so at this point.

    It would also be good to mention whether it is possible to get a
    delayed error on close() even if a previous call to fsync() or
    fdatasync() succeeded and there haven=E2=80=99t been any more writes=
 to
    that file *description* (not necessarily via the fd being closed)
    since.]

ERRORS
    EBADF  _fd_ wasn=E2=80=99t open in the first place, or is outside the
           valid numeric range for file descriptors.

    EINPROGRESS
    EINTR
           There are no delayed errors to report, but the kernel is
           still doing some clean-up work in the background.  This
           situation should be treated the same as if close() had
           returned zero.  Do not retry the close(), and do not report
           an error to the user.

    EDQUOT
    EFBIG
    EIO
    ENOSPC
           These are the most common errno codes associated with
           delayed I/O errors.  They should be treated as a hard
           failure to write to the file that was formerly associated
           with _fd_, the same as if an earlier write(2) had failed
           with one of these codes.  The file has still been closed!
           Do not retry the close().  But do report an error to the user.

    Depending on the underlying file, close() may return other errno
    codes; these should generally also be treated as delayed I/O errors.

NOTES
  Dealing with error returns from close()

    As discussed above, close() always closes the file.  Except when
    errno is set to EBADF, EINPROGRESS, or EINTR, an error return from
    close() reports a _delayed I/O error_ from a previous write()
    operation.

    It is vital to report delayed I/O errors to the user; failing to
    check the return value of close() can cause _silent_ loss of data.
    The most common situations where this actually happens involve
    networked filesystems, where, in the name of throughput, write()
    often returns success before the server has actually confirmed a
    successful write.

    However, it is also vital to understand that _no matter what_
    close() returns, and _no matter what_ it sets errno to, when it
    returns, _the file descriptor passed to close() has been closed_,
    and its number is _immediately_ available for reuse by open(2),
    dup(2), etc.  Therefore, one should never retry a close(), not
    even if it set errno to a value that normally indicates the
    operation needs to be retried (e.g. EINTR).  Retrying a close()
    is a serious bug, particularly in a multithreaded program; if
    the file descriptor number has already been reused, _that file_
    will get closed out from under whatever other thread opened it.

    [Possibly something about fsync/fdatasync here?]

BUGS
    Prior to POSIX.1-2024, there was no official guarantee that
    close() would always close the file descriptor, even on error.
    Linux has always closed the file descriptor, even on error,
    but other implementations might not have.

    The only such implementation we have heard of is HP-UX; at least
    some versions of HP-UX=E2=80=99s man page for close() said it should=
 be
    retried if it returned -1 with errno set to EINTR.  (If you know
    exactly which versions of HP-UX are affected, or of any other
    Unix where close() doesn=E2=80=99t always close the file descriptor,
    please contact us about it.)

    Portable code should nonetheless never retry a failed close(); the
    consequences of a file descriptor leak are far less dangerous than
    the consequences of closing a file out from under another thread.

