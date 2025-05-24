Return-Path: <linux-fsdevel+bounces-49810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81501AC3129
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 21:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498F517CAB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C426989A;
	Sat, 24 May 2025 19:31:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cygnus.enyo.de (cygnus.enyo.de [79.140.189.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770526658A;
	Sat, 24 May 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.140.189.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748115094; cv=none; b=HQBXwV7E4PwluXBLhM8Fyih3NMd6+kgxVH3H3rL4smQDVeDPjidZ3xqwik/B4UXoBiO8I/HZKk3U8/uonujaxhtq8uJznYskLJhYAqt9VV31pJAY2jdNQ+EfJaPPcyWrW2TCl+0DG2DeAmBKC2d0zB3lsoA/zI5JVTwGk7k72lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748115094; c=relaxed/simple;
	bh=+iFrhdG7q+UGLNW1pIi/jwLdvqDtlgid8fhW2F8SLNc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gwZpLftGh+8gf1mQ6lafd0/spfacngP90bMxvbIo5s/L3B96wBixK3dmkYOuGnLA6cOC4CNlTc6iVeTgjlCuMZmZEeJG0YL7OtjovUE0NEDHUUltuMTnB0eiawIdqs8f1YSqD9zJdj9HHeZTSt4WjMHeVJnsPU2e+W12TtdcWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de; spf=pass smtp.mailfrom=deneb.enyo.de; arc=none smtp.client-ip=79.140.189.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deneb.enyo.de
Received: from [172.17.203.2] (port=46509 helo=deneb.enyo.de)
	by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1uIuUV-003bxP-37;
	Sat, 24 May 2025 19:25:07 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.96)
	(envelope-from <fw@deneb.enyo.de>)
	id 1uIuUV-002abJ-2k;
	Sat, 24 May 2025 21:25:07 +0200
From: Florian Weimer <fw@deneb.enyo.de>
To: "Zack Weinberg" <zack@owlfolio.org>
Cc: "Alejandro Colomar" <alx@kernel.org>,  "Rich Felker" <dalias@libc.org>,
  "Vincent Lefevre" <vincent@vinc17.net>,  "Jan Kara" <jack@suse.cz>,
  "Alexander Viro" <viro@zeniv.linux.org.uk>,  "Christian Brauner"
 <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  "GNU libc development"
 <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
	<efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
	<20250516130547.GV1509@brightrain.aerifal.cx>
	<20250516143957.GB5388@qaa.vinc17.org>
	<20250517133251.GY1509@brightrain.aerifal.cx>
	<5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
	<8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
Date: Sat, 24 May 2025 21:25:07 +0200
In-Reply-To: <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com> (Zack
	Weinberg's message of "Fri, 23 May 2025 14:10:57 -0400")
Message-ID: <871psdlsks.fsf@mid.deneb.enyo.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

* Zack Weinberg:

> BUGS
>     Prior to POSIX.1-2024, there was no official guarantee that
>     close() would always close the file descriptor, even on error.
>     Linux has always closed the file descriptor, even on error,
>     but other implementations might not have.
>
>     The only such implementation we have heard of is HP-UX; at least
>     some versions of HP-UX=E2=80=99s man page for close() said it should =
be
>     retried if it returned -1 with errno set to EINTR.  (If you know
>     exactly which versions of HP-UX are affected, or of any other
>     Unix where close() doesn=E2=80=99t always close the file descriptor,
>     please contact us about it.)

The AIX documentation also says this:

| The success of the close subroutine is undetermined if the following
| is true:
|=09
| EINTR The state of the FileDescriptor is undetermined. Retry the
|       close routine to ensure that the FileDescriptor is closed.

<https://www.ibm.com/docs/en/aix/7.2.0?topic=3Dc-close-subroutine>

So it's not just HP-UX.

For z/OS, it looks like some other errors leave the descriptor open:

| EAGAIN
|
|   The call did not complete because the specified socket descriptor
|   is currently being used by another thread in the same process.
|
|    For example, in a multithreaded environment, close() fails and
|    returns EAGAIN when the following sequence of events occurs (1)
|    thread is blocked in a read() or select() call on a given file or
|    socket descriptor and (2) another thread issues a simultaneous
|    close() call for the same descriptor.
| [=E2=80=A6]
| EBADF
|    fildes is not a valid open file descriptor, or the socket
|    parameter is not a valid socket descriptor.

<https://www.ibm.com/docs/en/zos/2.1.0?topic=3Dfunctions-close-close-file>

