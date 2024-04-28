Return-Path: <linux-fsdevel+bounces-18032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06728B4E7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 00:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77381281213
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819FFBFD;
	Sun, 28 Apr 2024 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LsyOqxLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB6B642;
	Sun, 28 Apr 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714342388; cv=none; b=rn5YsOC/LfycICS2MVyjlzpM9svLjEQhR1dXdmInak/BtlZk7jfZyXwPeTRHxPdsMijTMXLFvpnZOtbCJ8zfi+IzRTCgtxp4r5lS31D/o6mUVPIrRbrofvHCWO/MUBx4Y+6MK7Do4sRoU0djsI73+tEHhBpHkfFFkmzO8Fs+uN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714342388; c=relaxed/simple;
	bh=v+x60Em69Y3V15yKVtpLHgKkcW8An+47dIIafknn1Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWATB4jWPHVQ1ZZhEymdEh7xka/D7I+KXw7TqQLL0pV2XUd5IGlupvD/rAmrSZdl1yhem7pxEJe20Xzh9fYr4/5agSnOd8gSi8Ns714+2aN1d2On5jJcFd3z5Ws0ETH7Xkw1xvyqqa82O8DRBPH62cAq2Q0DaC5mjAvlw2Rn2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LsyOqxLS; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:28a2:0:640:9f07:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id A818360E39;
	Mon, 29 Apr 2024 01:13:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wCYcLSYpCSw0-neCwgFvP;
	Mon, 29 Apr 2024 01:13:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714342380; bh=c9Y0BivHdjPKZY5c2XXTa9ws62jwT30YMQALX3hKUgU=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=LsyOqxLSL+upd6hnVyorcANpJaN3+4rBG+WC9FGO2DJNOLJqiBFKcdVbORF/YVI6k
	 k1c9E5X7wsizm3X+SBFEdRVCBDXzZSSBjrxGZvnDpE/C7KRJRjBYSRLtWBzTSdxa+m
	 JVb5ceF0eM55CN/tzh31ttIGaTAnZwuLtTnuIMGc=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <eae8e7e6-9c03-4c8e-ab61-cf7060d74d6d@yandex.ru>
Date: Mon, 29 Apr 2024 01:12:58 +0300
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
 <33bbaf98-db4f-4ea6-9f34-d1bebf06c0aa@yandex.ru>
 <CALCETrXPgabERgWAru7PNz6A5rc6BTG9k2RRmjU71kQs4rSsPQ@mail.gmail.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CALCETrXPgabERgWAru7PNz6A5rc6BTG9k2RRmjU71kQs4rSsPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

29.04.2024 00:30, Andy Lutomirski пишет:
> On Sun, Apr 28, 2024 at 2:15 PM stsp <stsp2@yandex.ru> wrote:
>> But isn't that becoming a problem once
>> you are (maliciously) passed such fds via
>> exec() or SCM_RIGHTS? You may not know
>> about them (or about their creds), so you
>> won't close them. Or?
> Wait, who's the malicious party?

Someone who opens an fd with O_CRED_ALLOW
and passes it to an unsuspecting process. This
is at least how I understood the Christian Brauner's
point about "unsuspecting userspace".


>    Anyone who can open a directory has,
> at the time they do so, permission to do so.  If you send that fd to
> someone via SCM_RIGHTS, all you accomplish is that they now have the
> fd.

Normally yes.
But fd with O_CRED_ALLOW prevents the
receiver from fully dropping his privs, even
if he doesn't want to deal with it.

> In my scenario, the malicious party attacks an *existing* program that
> opens an fd for purposes that it doesn't think are dangerous.  And
> then it gives the fd *to the malicious program* by whatever means
> (could be as simple as dropping privs then doing dlopen).  Then the
> malicious program does OA2_INHERIT_CREDS and gets privileges it
> shouldn't have.

But what about an inverse scenario?
Malicious program passes an fd to the
"unaware" program, putting it under a
risk. That program probably never cared
about security, since it doesn't play with
privs. But suddenly it has privs, passed
out of nowhere (via exec() for example),
and someone who hacks it, takes them.

>>>> My solution was to close such fds on
>>>> exec and disallowing SCM_RIGHTS passage.
>>> I don't see what problem this solves.
>> That the process that received them,
>> doesn't know they have O_CRED_ALLOW
>> within. So it won't deduce to close them
>> in time.
> Hold on -- what exactly are you talking about?  A process does
> recvmsg() and doesn't trust the party at the other end.  Then it
> doesn't close the received fd.  Then it does setuid(getuid()).  Then
> it does dlopen or exec of an untrusted program.
>
> Okay, so the program now has a completely unknown fd.  This is already
> part of the thread model.  It could be a cred-capturing fd, it could
> be a device node, it could be a socket, it could be a memfd -- it
> could be just about anything.  How do any of your proposals or my
> proposals cause an actual new problem here?

I am not actually sure how widely
does this spread. I.e. /dev/mem is
restricted these days, but if you can
freely pass device nodes around, then
perhaps the ability to pass an r/o dir fd
that can suddenly give creds, is probably
not something new...
But I really don't like to add to this
particular set of cases. I don't think
its safe, I just think its legacy, so while
it is done that way currently, doesn't
mean I can do the same thing and
call it "secure" just because something
like this was already possible.
Or is this actually completely safe?
Does it hurt to have O_CRED_ALLOW
non-passable?

>>> This is fundamental to the whole model. If I stick a FAT formatted USB
>>> drive in the system and mount it, then any process that can find its
>>> way to the mountpoint can write to it.  And if I open a dirfd, any
>>> process with that dirfd can write it.  This is old news and isn't a
>>> problem.
>> But IIRC O_DIRECTORY only allows O_RDONLY.
>> I even re-checked now, and O_DIRECTORY|O_RDWR
>> gives EISDIR. So is it actually true that
>> whoever has dir_fd, can write to it?
> If the filesystem grants that UID permission to write, then it can write.

Which to me sounds like owning an
O_DIRECTORY fd only gives you the
ability to skip the permission checks
of the outer path components, but not
the inner ones. So passing it w/o O_CRED_ALLOW
was quite safe and didn't give you any
new abilities.


