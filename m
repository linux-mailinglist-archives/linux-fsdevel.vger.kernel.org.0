Return-Path: <linux-fsdevel+bounces-18026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9708B4DDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 23:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC88D28138C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 21:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD33B647;
	Sun, 28 Apr 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Ya6z4iXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1001C14;
	Sun, 28 Apr 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714338916; cv=none; b=PQiSLEsbMoHHx03IoeftxZ5foxu1o4QhD9Y+uYQ6fkxvuweUUcuzk5cjgDRNiagotlqiVpS3QwFCiiIZ2QjpUoQ8ICnzOhJjX9kngQmk+0igUe/+8zg5fLc2zwEBl0LiDItZFzcbgHb7owg6D3QCJcCn+9esxnteafVGlil+tRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714338916; c=relaxed/simple;
	bh=gUQG8PqdPH5BDrs7AhxJjTFFaurC53tWLI7kU1Lb8xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbv1AtF6hjNIVVmdizOoxTes0gjYXAZv7uO0dUbO9G8Qq8Apx49wqdaGu1FEfVKRng1p+1PWmz35pBNDZ5JtSlGEIQ5r+540jQTpb/6Bs7mNqtcwDU3jsXGLWOfEKXRYdPL80qaNWumxwjMq/kgDXwWWwl8Tf/m+YmRuQx5G1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Ya6z4iXe; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4d9c:0:640:f3a0:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id 529F060954;
	Mon, 29 Apr 2024 00:15:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xEXIs2Td6iE0-gY3OEpmK;
	Mon, 29 Apr 2024 00:15:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714338902; bh=72CUr+jbIWTZIzy4esppyzeMB8w2qj2dHIKtHXbQeGY=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Ya6z4iXepp4hzH6gKF62HTLLZOUMQCXkyBnYVjQucazO4C5/Kk6SSNNKTXIco12BA
	 i03sti8GPnueaqQKTowxgJDhwHOEgYhIXG/h0bGLlWDizLcFcjx6fnpIgXAJKK+g+T
	 OEKOLKHvphpxPpGvOhnF6MGd+C4tYu/wKDs/JxKE=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <33bbaf98-db4f-4ea6-9f34-d1bebf06c0aa@yandex.ru>
Date: Mon, 29 Apr 2024 00:14:59 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Content-Language: en-US
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
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CALCETrVioWt0HUt9K1vzzuxo=Hs89AjLDUjz823s4Lwn_Y0dJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

28.04.2024 23:19, Andy Lutomirski пишет:
>> Doesn't this have the same problem
>> that was pointed to me? Namely (explaining
>> my impl first), that if someone puts the cred
>> fd to an unaware process's fd table, such
>> process can't fully drop its privs. He may not
>> want to access these dirs, but once its hacked,
>> the hacker will access these dirs with the
>> creds came from an outside.
> This is not a real problem. If I have a writable fd for /etc/shadow or
> an fd for /dev/mem, etc, then I need close them to fully drop privs.

But isn't that becoming a problem once
you are (maliciously) passed such fds via
exec() or SCM_RIGHTS? You may not know
about them (or about their creds), so you
won't close them. Or?

> The problem is that, in current kernels, directory fds don’t allow
> access using their f_cred, and changing that means that existing
> software that does not intend to create a capability will start to do
> so.

Which is what I am trying to do. :)

>> My solution was to close such fds on
>> exec and disallowing SCM_RIGHTS passage.
> I don't see what problem this solves.

That the process that received them,
doesn't know they have O_CRED_ALLOW
within. So it won't deduce to close them
in time.
Again, this is not the only possible solution.
The receiver can indicate its will to receive
them anyway, and the kernel can check if
such transaction is safe. But it was simpler
to just disallow, who needs to pass those?

>> SCM_RIGHTS can be allowed in the future,
>> but the receiver will need to use some
>> new flag to indicate that he is willing to
>> get such an fd. Passage via exec() can
>> probably never be allowed however.
>>
>> If I understand your model correctly, you
>> put a magic sub-tree to the fs scope of some
>> unaware process.
> Only if I want that process to have access!

Who is "I" in that context?
Can it be some malicious entity?

>> He may not want to access
>> it, but once hacked, the hacker will access
>> it with the creds from an outside.
>> And, unlike in my impl, in yours there is
>> probably no way to prevent that?
> This is fundamental to the whole model. If I stick a FAT formatted USB
> drive in the system and mount it, then any process that can find its
> way to the mountpoint can write to it.  And if I open a dirfd, any
> process with that dirfd can write it.  This is old news and isn't a
> problem.

But IIRC O_DIRECTORY only allows O_RDONLY.
I even re-checked now, and O_DIRECTORY|O_RDWR
gives EISDIR. So is it actually true that
whoever has dir_fd, can write to it?

>> In short: my impl confines the hassle within
>> the single process. It can be extended, and
>> then the receiver will need to explicitly allow
>> adding such fds to his fd table.
>> But your idea seems to inherently require
>> 2 processes, and there is probably no way
>> for the second process to say "ok, I allow
>> such sub-tree in my fs scope".
> A process could use my proposal to open_tree directory, make a whole
> new mountns that is otherwise empty, switch to the mountns, mount the
> directory, then change its UID and drop all privs, and still have
> access to that one directory.

Ok, if that requires actions that can't
be done after priv drop, then it can
indeed fully drop privs w/o mounting
anything, if he doesn't want such access.
Then the only security-related difference
with my approach is that mine guarantees
nothing new can be accessed, no matter
who passes what. Currently nothing can
be passed at all, but if it can - my approach
would still guarantee only the same creds
can be passed, not a new ones.
Can the same restriction be applied in
your case?


