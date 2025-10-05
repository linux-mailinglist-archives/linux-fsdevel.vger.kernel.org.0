Return-Path: <linux-fsdevel+bounces-63443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B659BB9A49
	for <lists+linux-fsdevel@lfdr.de>; Sun, 05 Oct 2025 19:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C7B04E667C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Oct 2025 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3912B1B4224;
	Sun,  5 Oct 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="fb6rMpC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE81A0BF1;
	Sun,  5 Oct 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686123; cv=none; b=VC+QWGVmb08AwR8sCauoD2cw1wdaMX7r4qkLZZboS3sYTfZhjPTggVC1N3JpPwNgR1VzDL9uIHqjXdzqWysRZZ2jjkQ2gccsIJ0uBYcJORs7a5NSBTVH5eovtzsl/mb5cxLazAuN1NZqLiufamcIustkfIns8ZibZtdgKmFp6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686123; c=relaxed/simple;
	bh=U9YZJCh701mHZrCDuiXPvnGd1GKQaSrniSbzzi4JuLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sG/x84ayfCYM4z3tRRb6QoKI5L68i5TWGN3YWH/7GTeUjZUyXXoR5vebF46gKA8JJvu2Pj0m73p4o5E4Dyn3tLyNDZAImlyaxawlANVNVKx16P62oaq0xS5s0vQ8fHpDscieod8UxV15293RUdgAP8728Uvzi9jPhoYWCr2ywFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=fb6rMpC1; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cfqTW2Cc5zB0X5;
	Sun,  5 Oct 2025 19:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759686111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4afsKMgpdir61D2meXQMLBHW4HISvDZMs7EQHCVsI=;
	b=fb6rMpC14nhvtDU0jlgR4YIPc1AGuRD/N+PDVw23U71N1DLka+7Fu3wG5huOg/en5GlDMN
	VA7NU3xL7xOK8aV8y4W+HTWNzvPXPyqvCJqdlnm7R8M3173fAYr/5aj49/WsI1gaEutMo+
	KGaj5SjVfTz9gTk3Ur4CagMKIP3HFuWwn4Pp38RQJF+VXcjg6HsG3l3YKjk/4tJAO7tjwZ
	BO1eRtn0sABSf+xYsejR0bO9XMf/tRRv8Wr1MhR6VwoKkYX0GvL8CL8iMkOUwFVRCzupnf
	jJgRKdj50lIOv+sKMeAM06if6UFTqQ2aNM9cpW/x1K0/MXookDK0xH+OOT0Ogw==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,
  linux-kernel@vger.kernel.org,  jack@suse.cz
Subject: Re: [PATCH] fs: Use a cleanup attribute in copy_fdtable()
In-Reply-To: <20251005090152.GE2441659@ZenIV> (Al Viro's message of "Sun, 5
	Oct 2025 10:01:52 +0100")
References: <20251004210340.193748-1-mssola@mssola.com>
	<20251004211908.GD2441659@ZenIV> <20251005090152.GE2441659@ZenIV>
Date: Sun, 05 Oct 2025 19:41:47 +0200
Message-ID: <87y0pp455w.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Al Viro @ 2025-10-05 10:01 +01:

> On Sun, Oct 05, 2025 at 07:37:50AM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> Al Viro @ 2025-10-04 22:19 +01:
>>
>> > On Sat, Oct 04, 2025 at 11:03:40PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0=
 wrote:
>> >> This is a small cleanup in which by using the __free(kfree) cleanup
>> >> attribute we can avoid three labels to go to, and the code turns to be
>> >> more concise and easier to follow.
>> >
>> > Have you tried to build and boot that?
>>
>> Yes, and it worked on my machine...
>
> Unfortunately, it ends up calling that kfree() on success as well as on f=
ailure.
> Idiomatic way to avoid that would be
> 	return no_free_ptr(fdt);
> but you've left bare
> 	return fdt;
> in there, ending up with returning dangling pointers to the caller.  So as
> soon as you get more than BITS_PER_LONG descriptors used by a process,
> you'll get trouble.  In particular, bash(1) running as an interactive she=
ll
> would hit that - it has descriptor 255 opened...

Ugh, this is just silly from my end...

You are absolutely right. I don't know what the hell I was doing while
testing that prevented me from realizing this before, but as you say
it's quite obvious and I was just blind or something.

Sorry for the noise and thanks for your patience...

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjirdsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZQRhD/4oVdh7E9IgzRXIcY7MyZdmeGG0MzOOvbOF9ZXrdrFHdmLAHnPt1UFn/JGi
BrgE0UE0w7wQupgO+TwcczWCGN7twfVxreyn5uF8UmaMcFMId3KbdDlS5QnaItTx
pwzBrJQQTEKGppVXh+8giKrL5fLiVzoRTilvFvR5mthqBxIlg1AE+z8HgDjf4foB
zOMFxgEZ98mT4YkV32sRxcbfqiXFwgASKI2gVEsHwNbJ9vneqhyQIfBlVJxt3RlP
dBmb4iuzUDcBMvVH9LtU3Jtns2qVkl9Qwn9/1jNb0DRML5hlRM0h82x9882Dt/nt
2S4gbcX0aa1xHnQwIB1F+yUWFzsiX07qWNmjyyR7pHSxZ2z1f6jopWU/5j0lONZc
Pcw6J3j/iCY9rppExwbIfpmmwhGPEsbGaHySSN6l/hPqJ+RmlljsaKeZX+JcRXji
IdvX63BC/PHL0CiXYXSn/ysUxwplB/lnwngtOtV+bZTmfb8mR29fY0lS9uW3V8Z0
8Cof8XeMs1CMhwoDLd/U/WwvCWpttKhAnHwVLP+Z069xD1frRyoGe8tCCgFCEpNH
2c6mh1szw0am4G/mSMxsxiIDVVJYdjOb0/iDIB3uLRdzrpEhhshd5980sEViWR8z
4YW2lkQyAaTA9NP519k0yYVhxN1OrEVEj8+gFGwuApPgAKZISw==
=JOJu
-----END PGP SIGNATURE-----
--=-=-=--

