Return-Path: <linux-fsdevel+bounces-17656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401AC8B1177
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B151C242E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD616D4F5;
	Wed, 24 Apr 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="mF8Y3dzK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622616D4E2;
	Wed, 24 Apr 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981043; cv=none; b=A2aoLh9t0Bfv+/lpkoFerxUe4+dBhonwREWxSDglXqmYtaaGlXdNf7lEBsDWAeR9bA9dGyKhPcBYifsSdti54pCIPv33XZ16lBOaRyUA0FxV+sSuSFSpYUbXCF9lzdOeHiYz08Ociq3kd6P6CDY2ZgkECsa2dAV5vFUEC9aq380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981043; c=relaxed/simple;
	bh=o8jKNpnbE9BafJeDbh3SGBlwwtmgAmcgcxUn8SzIL/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UowArBdePEH3qJY+mTANqrwmostS0d3QMWUaqLpqmpHum2SpGWKZDTPWlE3eMeyGePLOuKzz/w+iL7gZqzi37NLPF91669C7vcmTS8qF8ZxSbLgrWl2Rqw00beVK2RZ3C4Y57sCqOJIFwFT+bo5yrIrvOtj4ioI6bi5Cxxazrgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=mF8Y3dzK; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:2a02:0:640:77d9:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id F043C61C52;
	Wed, 24 Apr 2024 20:50:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UoPFOVO1PCg0-scmYXfpm;
	Wed, 24 Apr 2024 20:50:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713981032; bh=FsAH7dX/dutCxtwW5Qi7X0NyAfR1DP1iFwg1kpXF4So=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=mF8Y3dzKtk7GK8J2sNnlE4Ivnl6zPyjuyzrw7qLAGwIiaDFmPt3X6XMM1uGPpxVWb
	 pJlLAzBXp4ymZ5B4NWCAkjLw/IOQ83M8d+7eTp00hwnSLVoJSFSbin2UGCbMkdAUSO
	 Z+Jsd21zqLRQV3Y2G1EwnzJHpLVYlJpZSKIN/0X0=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <6b46528a-965f-410a-9e6f-9654c5e9dba2@yandex.ru>
Date: Wed, 24 Apr 2024 20:50:30 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] implement OA2_INHERIT_CRED flag for openat2()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Alexander Aring
 <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240424105248.189032-1-stsp2@yandex.ru>
 <20240424-schummeln-zitieren-9821df7cbd49@brauner>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20240424-schummeln-zitieren-9821df7cbd49@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

24.04.2024 19:09, Christian Brauner пишет:
> This smells ripe enough to serve as an attack vector in non-obvious
> ways. And in general this has the potential to confuse the hell out
> unsuspecting userspace.

Unsuspecting user-space will simply
not use this flag. What do you mean?


>   They can now suddenly get sent such
> special-sauce files

There are no any special files.
This flag helps you to open a file on
which you currently have no perms
to open, but had those in the past.


>   such as this that they have no way of recognizing as
> there's neither an FMODE_* flag nor is the OA2_* flag recorded so it's
> not available in F_GETFL.
>
> There's not even a way to restrict that new flag because no LSM ever
> sees it. So that behavior might break LSM assumptions as well.
>
> And it is effectively usable to steal credentials. If process A opens a
> directory with uid/gid 0 then sends that directory fd via AF_UNIX or
> something to process B then process B can inherit the uid/gid of process

No, it doesn't inherit anything.
The inheritance happens only for
a duration of an open() call, helping
open() to succeed. The creds are
reverted when open() completed.

The only theoretically possible attack
would be to open some file you'd never
intended to open. Also note that a
very minimal sed of creds is overridden:
fsuid, fsgid, groupinfo.

> A by specifying OA2_* with no way for process A to prevent this - not
> even through an LSM.

If process B doesn't use that flag, it
inherits nothing, no matter what process
A did or passed via a socket.
So an unaware process that doesn't
use that flag, is completely unaffected.

> The permission checking model that we have right now is already baroque.
> I see zero reason to add more complexity for the sake of "lightweight
> sandboxing". We have LSMs and namespaces for stuff like this.
>
> NAK.

I don't think it is fair to say NAK
without actually reading the patch
or asking its author for clarifications.
Even though you didn't ask, I provided
my clarifications above, as I find that
a polite action.


