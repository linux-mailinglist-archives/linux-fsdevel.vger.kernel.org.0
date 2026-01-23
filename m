Return-Path: <linux-fsdevel+bounces-75181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOAIMD/CcmnvpAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:35:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 694A76ECEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66F78300825C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49389231829;
	Fri, 23 Jan 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="CGzKwC+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNc2bl/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87526E173;
	Fri, 23 Jan 2026 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128503; cv=none; b=k6WBfzgh5aZMcMtE8bQ1I6nmnrlmfH6QC3B7gyy9veH8j4weJV5P7rxaYiqS3kVbxzUSb2fBvrRbGuOW9Vm1FTzImey6raRLa/ByeSCnP+r2kI1sMwR0Sxf7c2f21aZwdgIoA4D6MtYnPtp/qvP0pJHxjbdj64E7AFUNJn8dS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128503; c=relaxed/simple;
	bh=mnO3LD59zrxvOcyrokC4eduN8dSsCJOYTEgOvOuBVsM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DJcrEEYrmlUje05nOynHMpbw3XCVR5yFuGzX0N6bgiuOrOOfBZIOXk5g9kkm1BsRflmhCBfKKaZo10R6sxVhGeWOdSIUGR2VPKvlI7mDc69EFIAtv7zrWnxyu+vuAq6qS8za0XIcAPJ4Ra6r4Oa9jnqmY9gDHQnonrna8kXdz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=CGzKwC+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNc2bl/e; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96DCC1400B5D;
	Thu, 22 Jan 2026 19:34:54 -0500 (EST)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-01.internal (MEProxy); Thu, 22 Jan 2026 19:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769128494;
	 x=1769214894; bh=//0rcQ2fJYfXekxAakcn/a0ff2AWmu5rl7gw6xPDD9Y=; b=
	CGzKwC+t+9HIe69fyHZnEYDmySMgdKse2rCBV47rBmHuD21Exd1GT5jWfxWEemwP
	/uNdw4exijADLtXIzbJkuCw4McC5FG5FFMk7B9b5EoS6ZzhL7dYohVIUgZ0vklWR
	LfsNkM2pfZTggi6AQRfL4vDreLeEhEgt2hvO+R9gCzuYEJSkB+wW4bAlDIkopWCW
	KApB0d1UozwOMHmL1kifnNkC+TOtVtbsU7oqc3RFpZ3rH/rR7Jb4qD/mzFFpt/G8
	+9sK7TxaI0b8WX2th4yUENshyHg59OIvrYRZ+JbmiqD/Zabi3wrtOI2dHNhuPFZA
	dRI5uqoTmcZIUd5m9ggyzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769128494; x=
	1769214894; bh=//0rcQ2fJYfXekxAakcn/a0ff2AWmu5rl7gw6xPDD9Y=; b=e
	Nc2bl/efsjvvuAIuwFkLW/qkLRd82jSzRCA8emVjGC4KJ96R6GPhx+B0/WBGC47F
	CJbiX9E7Q1sHUMXlQW1xfYBvVy60PEIUW7NOAlu5e2ItI8CHBv6TLvujDQLTLVc4
	XdSdFICzQ50ueiN2+n4Z9UrSUKFsNKMPhxiwJnVcKGoR9Q4TrvOHk74CMX8v/TVD
	8I3Gd5Q9VlIRcK5XPYr4OgNihQXKj/Y+gglTzrfL2LdG5DFBPaT7UyoxPMFD9f9W
	z4a9U67G4ljunJSU+fkAB4GfqTylVUJ6rcmi23pwCra3VhtNLr8hVjJRqI7WT7AE
	oKJPKrN8/a9/yww48j/fw==
X-ME-Sender: <xms:LsJyaT9vbWgm_4VCtH3JlUVYxHrxp324w6S8br6pbzjuuZjMZRCQ0w>
    <xme:LsJyaajLLdSV-L6xMC62qwy22n_ayoGfgoPanXZ_rpXP36r1D3uD-UF_7hMZVcSri
    qN-zuq5ecrIfwooFXJVrmgtZqIU3UWm5Msmi0ZKhHXCAySLASbG0xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfkggrtghk
    ucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholhhiohdrohhrgheqnecuggftrf
    grthhtvghrnhepffffleeihfekfeetheeiieelueffleegvdejgffhhffhheehgfethfeg
    jeduueehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epiigrtghksehofihlfhholhhiohdrohhrghdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghlgieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrlhhirghs
    sehlihgstgdrohhrghdprhgtphhtthhopehlihgstgdqrghlphhhrgesshhouhhrtggvfi
    grrhgvrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohep
    lhhinhhugidqrghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vhhinhgtvghnthesvhhinhgtudejrdhnvghtpdhrtghpthhtohepvhhirhhoseiivghnih
    hvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:LsJyafdpdqU5san-xYEyx9E_4sX4NsWOb2-3cNNm3vzVsri82fGaFw>
    <xmx:LsJyaYQJyOjDp5yKFt-39Z6SHyz4QpmWvXkY8k1wxR3tHeNR2SdFrw>
    <xmx:LsJyaTJ9hm911QyZcwPTANuqOAcM9bJ69tJdO9SUune0MfwUQt0rYw>
    <xmx:LsJyadKx2O-0BlTjvpm-x6hGv4_AoW6IvqQ-XfsAuC8VerYxtxMr5g>
    <xmx:LsJyaZOJtK_jULYvTRxG64pLYSXyF-JE_3U9TerZpqKyrTS1aHohrV-z>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1A20CC4006E; Thu, 22 Jan 2026 19:34:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANFeMez8yEXZ
Date: Thu, 22 Jan 2026 19:33:58 -0500
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Alejandro Colomar" <alx@kernel.org>
Cc: "Vincent Lefevre" <vincent@vinc17.net>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Rich Felker" <dalias@libc.org>,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 "GNU libc development" <libc-alpha@sourceware.org>
Message-Id: <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
In-Reply-To: <aW_olRn5s1lbbjdH@devuan>
References: 
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx> <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from POSIX.1-2024
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[owlfolio.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[owlfolio.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75181-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[owlfolio.org:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack@owlfolio.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[owlfolio.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 694A76ECEE
X-Rspamd-Action: no action

Alright, since it actually seems possible we might be having a
reasonable conversation about the close manpage now, I've done
another draft. I *think* this covers all the concerns expressed
so far.  I am feeling somewhat more charitable toward the Austin
Group after close-reading the current POSIX spec for close,
so there is no BUGS section after all.  In their shoes I would
still have disallowed EINTR returns from close altogether, but
I can see why they felt that was a step too far.

This is a full top-to-bottom rewrite of the manpage; please speak
up if you don't like any of my changes to any of it, not just the
new stuff about delayed errors.  It's written in freeform text for
ease of reading; I'll do proper troff markup after the text is
finalized.  (Alejandro, do you have a preference between -man
and -mdoc markup?)

Please note the [QUERY:] sections sprinkled throughout NOTES.
I would like to have answers to those questions for the final draft.

zw

NAME
       close - close a file descriptor

LIBRARY
       Standard C library (libc, -lc)

SYNOPSIS
       #include <unistd.h>

       int close(int fd);

DESCRIPTION
       close() closes a file descriptor, so that it no longer refers
       to any file and may be reused.

       When the last file descriptor referring to an underlying open
       file description (see open(2)) is closed, the resources
       associated with the open file description are freed.  If that
       open file description is the last reference to a file which has
       been removed using unlink(2), the file is deleted.

       When *any* file descriptor is closed, all record locks held by
       the *process*, on the file formerly referred to by that file
       descriptor, are released.  This happens even if the file is
       still open in the process via a different file descriptor.
       See fcntl(2) for discussion of the consequences, and for
       alternatives with less surprising semantics.

       close() may report a *delayed error* from previous I/O
       operations on a file.  When it does this, the file descriptor
       has still been closed, but the error needs to be handled.
       See RETURN VALUE, ERRORS, and NOTES for further discussion of
       what the errors reported by close mean, and how to handle them.

       Despite the possibility of delayed errors, a successful close()
       does *not* guarantee that all data written to the file has been
       successfully saved to persistent storage.  If you need such a
       guarantee, use fsync(2); see that page for details.

       The close-on-exec file descriptor flag can be used to ensure
       that a file descriptor is automatically closed upon a
       successful execve(2); see fcntl(2) for details.

RETURN VALUE
       close() returns zero if the descriptor has been closed and
       there were no delayed errors to report.

       It returns -1 if there was an error that prevented the
       file descriptor from being closed, *or* if the descriptor
       has successfully been closed but there was a delayed error
       to report.  The errno code can be used to distinguish them;
       see ERRORS and NOTES.

ERRORS
       EBADF  The fd argument was not a valid, open file descriptor.

       EINTR  The close() call was interrupted by a signal.
              The file descriptor *may or may not* have been closed,
              depending on the operating system.  See =E2=80=9CSignals a=
nd
              close(),=E2=80=9D below.

       EINPROGRESS
              [POSIX.1-2024 only] The close() call was interrupted by
              a signal, after the file descriptor number was released
              for reuse, but before all clean-up work had been
              completed.  The file descriptor has been closed,
              and a delayed error may have been lost.  See =E2=80=9CSign=
als
              and close(),=E2=80=9D below.

       EIO
       ESTALE
       EDQUOT
       EFBIG
       ENOSPC These error codes indicate a delayed error from a
              previous write(2) operation.  The file descriptor has
              been closed, but the error needs to be handled.
              See =E2=80=9CDelayed errors reported by close()=E2=80=9D, =
below.

       Depending on the underlying file and/or file system, close()
       may return with other errno codes besides those listed.
       All such codes also indicate delayed errors.

NOTES
   Multithreaded processes and close()

       In a multithreaded program, each thread must take care not to
       accidentally close file descriptors that are in use by other
       threads.  Because system calls that *open* files, sockets,
       etc. always allocate the lowest file descriptor number that=E2=80=
=99s
       not in use, file descriptor numbers are rapidly reused.
       Closing an fd that another thread is still using is therefore
       likely to cause data to be read or written to the wrong place.

       Sometimes programs *deliberately* close a file descriptor that
       is in use by another thread, intending to cancel any blocking
       I/O operation that the other thread is performing.  Whether
       this works depends on the operating system.  On Linux, it
       doesn=E2=80=99t work; a blocking I/O system call holds a direct
       reference to the underlying open file description that is the
       target of the I/O, and is unaffected by the program closing the
       file descriptor that was used to initiate the I/O operation.
       (See open(2) for a discussion of open file descriptions.)

   Delayed errors reported by close()

       In a variety of situations, most notably when writing to a file
       that is hosted on a network file server, write(2) operations may
       =E2=80=9Coptimistically=E2=80=9D return successfully as soon as t=
he write has
       been queued for processing.

       close(2) waits for confirmation that *most* of the processing
       for previous writes to a file has been completed, and reports
       any errors that the earlier write() calls *would have* reported,
       if they hadn=E2=80=99t returned optimistically.  Especially, clos=
e()
       will report =E2=80=9Cdisk full=E2=80=9D (ENOSPC) and =E2=80=9Cdis=
k quota exceeded=E2=80=9D
       (EDQUOT) errors that write() didn=E2=80=99t wait for.

       (To wait for *all* processing to complete, it is necessary to
       use fsync(2) as well.)

       Because of these delayed errors, it=E2=80=99s important to check =
the
       return value of close() and handle any errors it reports.
       Ignoring delayed errors can cause silent loss of data.

       However, when handling delayed errors, keep in mind that the
       close() call should *not* be repeated.  When close() has a
       delayed error to report, it still closes the file before
       returning.  The file descriptor number might already have been
       reused for some other file, especially in multithreaded
       programs.  To make another attempt at the failed writes, it=E2=80=
=99s
       necessary to reopen the file and start all over again.

    [QUERY: Do delayed errors ever happen in any of these situations?

       - The fd is not the last reference to the open file description

       - The OFD was opened with O_RDONLY

       - The OFD was opened with O_RDWR but has never actually
         been written to

       - No data has been written to the OFD since the last call to
         fsync() for that OFD

       - No data has been written to the OFD since the last call to
         fdatasync() for that OFD

       If we can give some guidance about when people don=E2=80=99t need=
 to
       worry about delayed errors, it would be helpful.]

    Signals and close()

       close() waits for various I/O operations to complete; it is a
       blocking system call, which can be interrupted by signals and
       thread cancellation.  As usual, when close() is interrupted
       by a signal, it returns -1 and sets errno to EINTR.

       Unlike most system calls that can be interrupted by signals,
       it is not safe to repeat an interrupted call to close().
       Prior to POSIX.1-2024, when a close() was interrupted by a
       signal, it was *unspecified* whether the file descriptor was
       still open afterward.  The authors of this manpage are aware
       of both systems where the file descriptor is guaranteed to
       still be open after an interrupted close(), e.g. HP-UX, and
       systems where it is guaranteed to be *closed* after an
       interrupted close(), e.g. Linux and FreeBSD.

       POSIX.1-2024 makes stricter requirements; operating systems
       should now return EINPROGRESS, rather than EINTR, when close()
       is interrupted before it=E2=80=99s completely done, but after the=
 file
       descriptor number is released for reuse.  As usual, though, it
       will be a a long time before portable code can safely assume
       all supported systems are compliant with this new requirement.

       Regardless of the error code, on systems where an interrupted
       close() cannot be retried, an interruption means that delayed
       errors may be lost, and in turn *that* means data might silently
       be lost.  Therefore, we strongly recommend that programmers
       avoid allowing close() to be interrupted by signals in the
       first place.  This can be done in all the usual ways=E2=80=94use =
only
       signal handlers installed by sigaction(2) with the SA_RESTART
       flag, keep signals blocked at all times except during calls
       to ppoll(2), dedicate a thread to signal handling, etc.

   [QUERY: Do we know if close() is allowed to block or report delayed
       errors when no data has been written to the OFD since the last
       completed fsync() or fdatasync() on that OFD?  If it isn=E2=80=99t
       allowed to block or report delayed errors in that case, another
       good recommendation would be to always use at least fdatasync()
       and let *that* be the thing that gets interrupted by signals.
       The POSIX.1-2024 RATIONALE section makes a very similar
       recommendation, but doesn=E2=80=99t appear to back that up with
       normative requirements on close().]

STANDARDS
       POSIX.1-2024.

HISTORY
       The close() system call was present in Unix V7.

       POSIX.1-2024 clarified the semantics of delayed errors; prior
       to that revision, it was unspecified whether a close() call
       that returned a delayed error would close the file descriptor.
       However, we are not aware of any systems where it didn=E2=80=99t.

SEE ALSO
       close_range(2), fcntl(2), fsync(2), fdatasync(2), shutdown(2),
       unlink(2), open(2), read(2), write(2), fopen(3), fclose(3)

