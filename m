Return-Path: <linux-fsdevel+bounces-18035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405618B4F22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E441C21396
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 01:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853AEC3;
	Mon, 29 Apr 2024 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="i8bCA03Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA57F;
	Mon, 29 Apr 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714353181; cv=none; b=qnLIdcBUi9tesTL2EmCtyVnRzQrIePerBGqsaISNGY+h3dF3/yslJD7NLae/P0ebBHXZG2AnDzkiwS/O7GYEyPVHJM9rABdlptGdw4ILpOjBVRN6KuuwuxvpvVSdero4lTKr8BJg1Tdf8JFxQMpPCjrmNmPKYktqgfqfDk1NRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714353181; c=relaxed/simple;
	bh=atZTjMvbp/J9uFNSUp7SmwuYN/0G1ObO2MY7u9rDM18=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dqN3ueeFofg3TGR1uEd57ElmXWLG/1VdGaBdPTHKul1j2N6OhpxEEL0rTP9Fze/dmbzcCQDGHfovTNHHRTBYVcdNxXcys7+OzI8uJKlaYulaiLz3dJJkY93/i8/gs4ElgN6aZWxOzrunHUoF6uHI+HwWarZXs5guOnipvWT7Q2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=i8bCA03Z; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:570c:0:640:ca74:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 0DBA160E11;
	Mon, 29 Apr 2024 04:12:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pCESEr1uC0U0-N8n5dLns;
	Mon, 29 Apr 2024 04:12:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714353172; bh=JbpFPDnYYOMMsam7KnZq1vujrIs611gr9o5FFJ/T4I4=;
	h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
	b=i8bCA03ZOoqiZUGgIkgPsnsvM6PQg7Off+6jOkXlfLqxgqxmeruErexcs9PZkwcEG
	 kdvOD6IvUfUGvCdvMUmSlRoMfPrdbJctP6VymDRBj1N2nkTF0L53s4hhJjdk87yLic
	 c5d8Y34wJv11ocOSdzo+fEOVYGJz27d92wTxsFmw=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <35f7149a-728d-47a8-8884-347d87d5680e@yandex.ru>
Date: Mon, 29 Apr 2024 04:12:50 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Aleksa Sarai <cyphar@cyphar.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240426133310.1159976-1-stsp2@yandex.ru>
 <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <8e186307-bed2-4b5c-9bc6-bdc70171cc93@yandex.ru>
 <CALCETrVioWt0HUt9K1vzzuxo=Hs89AjLDUjz823s4Lwn_Y0dJw@mail.gmail.com>
 <33bbaf98-db4f-4ea6-9f34-d1bebf06c0aa@yandex.ru>
 <CALCETrXPgabERgWAru7PNz6A5rc6BTG9k2RRmjU71kQs4rSsPQ@mail.gmail.com>
 <eae8e7e6-9c03-4c8e-ab61-cf7060d74d6d@yandex.ru>
In-Reply-To: <eae8e7e6-9c03-4c8e-ab61-cf7060d74d6d@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

29.04.2024 01:12, stsp пишет:
> freely pass device nodes around, then
> perhaps the ability to pass an r/o dir fd
> that can suddenly give creds, is probably
> not something new...
Actually there is probably something
new anyway. The process knows to close
all sensitive files before dropping privs.
But this may not be the case with dirs,
because dir_fd pretty much invalidates
itself when you drop privs: you'll get
EPERM from openat() if you no longer
have rights to open the file, and dir_fd
doesn't help.
Which is why someone may neglect
to close dir_fd before dropping privs,
but with O_CRED_ALLOW that would
be a mistake.

Or what about this scenario: receiver
gets this fd thinking its some useful and
harmless file fd that would be needed
even after priv drop. So he makes sure
with F_GETFL that this fd is O_RDONLY
and doesn't close it. But it appears to be
malicious O_CRED_ALLOW dir_fd, which
basically exposes many files for a write.

So I am concerned about the cases where
an fd was not closed before a priv drop,
because the process didn't realize the threat.

> But if the*whole point*  of opening the fd was to capture privileges
> and preserve them across a privilege drop, and the program loads
> malicious code after dropping privs, then that's a risk that's taken
> intentionally.
If you opened an fd yourself, then yes.
You know what have you opened, and
you care to close sensitive fds before
dropping privs, or you take the risk.
But if you requested something from
another process and got some fd as
the result, the kernel doesn't guarantee
you got an fd to what you have requested.
You can get a malicious fd, which is not
"so" possible when you open an fd yourself.
So if you want to keep such an fd open,
you will probably at least make sure its
read-only, its not a device node (with fstat)
and so on.
All checks pass, and oops, O_CRED_ALLOW...

So why my patch makes O_CRED_ALLOW
non-passable? Because the receiver has
no way to see the potential harm within
such fd. So if he intended to keep an fd
open after some basic safety checks, he
will be tricked.
So while I think its a rather bad idea to
leave the received fds open after priv drop,
I don't completely exclude the possibility
that someone did that, together with a few
safety checks which would be tricked by
O_CRED_ALLOW.

