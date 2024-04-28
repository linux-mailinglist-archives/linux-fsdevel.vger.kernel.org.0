Return-Path: <linux-fsdevel+bounces-18016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50218B4D48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7123B281590
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0565B73526;
	Sun, 28 Apr 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Tfu+By08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA073506;
	Sun, 28 Apr 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325967; cv=none; b=WjNEFZTUumwayA1NF7wzTRnLA2BXnuH7sljhcqwTe36IKPq3c3X+nFUftOvmMoTvbtMbQ+I4zAB2uXehYG3155455SZcdaabdJ2uDBf8EJr5XWQyGZL0JszubCUjZPHsqP7dmrB0GA0800QiIzp+0vGZ8z5NEl3tuRy7jxvEdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325967; c=relaxed/simple;
	bh=9vIlJGfggIMfPt+kTenoSp+mbnyzBRWNaGgd/qGD9jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRXVrLt/h0q9zC1HqLnzX1xTpKGii54iqLxHFX+7+vhK/I3NJkim85ENGwg5NjVqpSvPEbbx9N5+tCEhKKvE4EptU1ECeXBV1H/j+ttHrXNn2N+spi5ly+YwWvnESAy/DFfaBl6rfCYQAFCZZzXXNOfisVdIUt+We9maWt2SiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Tfu+By08; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:230c:0:640:f8e:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 32A8960ED8;
	Sun, 28 Apr 2024 20:39:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GdTtsTB1F0U0-lo6nDCcX;
	Sun, 28 Apr 2024 20:39:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714325958; bh=9vIlJGfggIMfPt+kTenoSp+mbnyzBRWNaGgd/qGD9jY=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Tfu+By08UfkKGhVPTYhVI6BnA1Wju3hpF4QtM5GMyJHs87pOGnq9ahyKkfaSFOBYd
	 PuZNm7p1jJK6yGWp1W8xCE+fwRghzwRyBYV8iPO+bqdHVPRX2Gfs9nmNmrkCL1/p3C
	 rdQ5IkGjX1fUJW878+sX+jTCYXmQAKpUwbSffXfM=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <8e186307-bed2-4b5c-9bc6-bdc70171cc93@yandex.ru>
Date: Sun, 28 Apr 2024 20:39:16 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Content-Language: en-US
To: Andy Lutomirski <luto@amacapital.net>, Aleksa Sarai <cyphar@cyphar.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
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
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

28.04.2024 19:41, Andy Lutomirski пишет:
>> On Apr 26, 2024, at 6:39 AM, Stas Sergeev <stsp2@yandex.ru> wrote:
>> ﻿This patch-set implements the OA2_CRED_INHERIT flag for openat2() syscall.
>> It is needed to perform an open operation with the creds that were in
>> effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLOW
>> flag. This allows the process to pre-open some dirs and switch eUID
>> (and other UIDs/GIDs) to the less-privileged user, while still retaining
>> the possibility to open/create files within the pre-opened directory set.
>>
> Then two different things could be done:
>
> 1. The subtree could be used unmounted or via /proc magic links. This
> would be for programs that are aware of this interface.
>
> 2. The subtree could be mounted, and accessed through the mount would
> use the captured creds.
Doesn't this have the same problem
that was pointed to me? Namely (explaining
my impl first), that if someone puts the cred
fd to an unaware process's fd table, such
process can't fully drop its privs. He may not
want to access these dirs, but once its hacked,
the hacker will access these dirs with the
creds came from an outside.
My solution was to close such fds on
exec and disallowing SCM_RIGHTS passage.
SCM_RIGHTS can be allowed in the future,
but the receiver will need to use some
new flag to indicate that he is willing to
get such an fd. Passage via exec() can
probably never be allowed however.

If I understand your model correctly, you
put a magic sub-tree to the fs scope of some
unaware process. He may not want to access
it, but once hacked, the hacker will access
it with the creds from an outside.
And, unlike in my impl, in yours there is
probably no way to prevent that?

In short: my impl confines the hassle within
the single process. It can be extended, and
then the receiver will need to explicitly allow
adding such fds to his fd table.
But your idea seems to inherently require
2 processes, and there is probably no way
for the second process to say "ok, I allow
such sub-tree in my fs scope". And even if
he could, in my impl he can just close the
cred fd, while in yours it seems to persist.

Sorry if I misunderstood your idea.

