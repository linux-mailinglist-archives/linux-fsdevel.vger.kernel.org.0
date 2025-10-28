Return-Path: <linux-fsdevel+bounces-65936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A7CC15A4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923561B2624B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A0A3081B8;
	Tue, 28 Oct 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OPEqap7k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SARXk4Ru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104332206AC;
	Tue, 28 Oct 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666837; cv=none; b=DaQ9YuI+iEPNnLSl3o5HQgthnPINkCsnJokAzFZsi66XpqBBv/mURpUTgoE3puAM+toLoUAbR3mR4KnJ8GqH+0dRZIs5RY3TLAOFjqXNzuCmh01Qnv1jj0F5e9gy140trZzP1d0FsmpbDQyz1qwcEGjRowfypJlCveu4/B0sNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666837; c=relaxed/simple;
	bh=f4zqaxnTfdsmOAaU/dOER4HmKdQr+aQAlMmp/tNTu1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rlq1ACdKVbXw9cIBMiOAKKPOKeQydqTrmDUQvRZ33j7O3WWVSg66QDf1pcrHFZIO3ECXJNp4aaaRh0HzFe3zwUljzKccupseoW6G+ZlKVq55yKs6+wFbofHI8OZE6auVgUVH9kl+mp/2p6X+Y1QwyJibZHxC+mr+8ZSIioCVjSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OPEqap7k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SARXk4Ru; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761666833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KXDwBRP2WCWSb38HDbtSfBbdxVUxx52nxz6bCHrlpw=;
	b=OPEqap7k08VJelhy9WBQ/aL5T/8oowjEW/Fj5ejEzvuFUOJdHdYO+nY9g3zwtVd8QWDf1F
	3OycYZl/mXIIkjDEJbYqJn/3lZONlfMLSSkvOIeF5euOmDzhBeb9eL4MDJ07aVD52j+vc3
	2Ki2E0N97eFYWZ8+a5iDKRlRRUgRRS/Cia0Rk/IX+jL/+Yov9CCKMTIDCIZkBPTMJtSuC6
	TlGUy15ZD9OqxHiszUngKkX1GB7hr2PiWfv/E9vY6vQ531cTPrIrUUZLo9u4YJwZ5ShkEp
	MXYPHAOozI3S6XnQsFcoK8zfWpgofXu0Rlf3rxgsiAc0s0ZysVI8vQGLdVgzig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761666833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KXDwBRP2WCWSb38HDbtSfBbdxVUxx52nxz6bCHrlpw=;
	b=SARXk4Ruf1xEZbt1pBhbOZgPe7j89e4OCU0if/0OgDMjDi4dxReWkPtapI3fZt2x6xbwVl
	0zokLNUUHORNRdCg==
To: Yann Ylavic <ylavic.dev@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>, Darren
 Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?=
 Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V5 02/12] uaccess: Provide ASM GOTO safe wrappers for
 unsafe_*_user()
In-Reply-To: <CAKQ1sVO9YmWqo2uzk7NbssgWuwnQ-o4Yf2+bCP8UmHAU3u8KmQ@mail.gmail.com>
References: <20251027083700.573016505@linutronix.de>
 <20251027083745.231716098@linutronix.de>
 <CAKQ1sVO9YmWqo2uzk7NbssgWuwnQ-o4Yf2+bCP8UmHAU3u8KmQ@mail.gmail.com>
Date: Tue, 28 Oct 2025 16:53:52 +0100
Message-ID: <87jz0fuinj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28 2025 at 15:04, Yann Ylavic wrote:
> On Tue, Oct 28, 2025 at 10:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>> +
>> +#define __put_kernel_nofault(dst, src, type, label)            \
>> +do {                                                           \
>> +       __label__ local_label;                                  \
>> +       arch_get_kernel_nofault(dst, src, type, local_label);   \
>
> Probably arch_put_kernel_nofault() instead?

Duh. Indeed

