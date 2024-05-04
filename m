Return-Path: <linux-fsdevel+bounces-18740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 319AA8BBE27
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 23:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C624B213AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 21:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10884A5C;
	Sat,  4 May 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="slPbuUc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3B57C9A;
	Sat,  4 May 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714857116; cv=none; b=hNWGGTMnhXk8752WzopOyedofe/sbRtCsk21ZWaDCA8xUn/xL/p94cnF3EaM62VkW+CXBLIbBpKQh6vt9M6h6g0RO7yi8Mc0hAnbB8Fuzzwe23cH/j/5QezpjN1+jKrfBau4D7TRW90OVTsJGvkrjDljKgHo7NW+F3yfWfiGyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714857116; c=relaxed/simple;
	bh=Y46KvSj8aOYClih0SfoEYsp6AkbAmD5E3/REAhbZ5H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAzrODzpu0e+xr8RZ4wntDpFfcTtEx/wWtUWvEx58M3aJNF7mgqMfUAvW/1zlfO6US4G/O4d8T4dxS4Pe4car+WUoZo//RHKtvX3dA9dzmxWaNJIMHr+cpGD9snY6WCgUScaOK1VWxmQxx7QRcoXaOJPhO4ITgh/c7JRcpcvd+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=slPbuUc2; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:39ad:0:640:62fe:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTPS id 45DEC60AA6;
	Sun,  5 May 2024 00:11:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id gBddwhTxU8c0-DLitvI3Q;
	Sun, 05 May 2024 00:11:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714857104; bh=qu1Z4qXkl0rii4qXTlrRxPjlamjfNzJe5s7ny/pBNdU=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=slPbuUc2eQYMjsyN99pW1eUKCnq5y3ETZ0tON2j8zhWjy0qQL5ZVcQB9owgDwbqIK
	 odfKpQnarQBxe/nfTJbo0oUBSzKyGTtHz3PfpGCj5IylE8HVMP/Jvu6NOsmErXzSc2
	 6h/Cbz0LxmL7Ov4YCkAcmYkItSsdyXl/BQ8dmKvc=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <9c043e69-46af-4e21-8d52-4fd8b2e24404@yandex.ru>
Date: Sun, 5 May 2024 00:11:41 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] openat2: add OA2_CRED_INHERIT flag
Content-Language: en-US
To: Donald Buczek <buczek@molgen.mpg.de>, linux-kernel@vger.kernel.org
Cc: Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 David Laight <David.Laight@ACULAB.COM>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240427112451.1609471-1-stsp2@yandex.ru>
 <20240427112451.1609471-4-stsp2@yandex.ru>
 <bf4a737a-0c5b-4349-886d-4013683818ce@molgen.mpg.de>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <bf4a737a-0c5b-4349-886d-4013683818ce@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

04.05.2024 23:38, Donald Buczek пишет:
> On 4/27/24 13:24, Stas Sergeev wrote:
>> This flag performs the open operation with the fs credentials
>> (fsuid, fsgid, group_info) that were in effect when dir_fd was opened.
>> dir_fd must be opened with O_CRED_ALLOW, or EPERM is returned.
>>
>> Selftests are added to check for these properties as well as for
>> the invalid flag combinations.
>>
>> This allows the process to pre-open some directories and then
>> change eUID (and all other UIDs/GIDs) to a less-privileged user,
>> retaining the ability to open/create files within these directories.
>>
>> Design goal:
>> The idea is to provide a very light-weight sandboxing, where the
>> process, without the use of any heavy-weight techniques like chroot
>> within namespaces, can restrict the access to the set of pre-opened
>> directories.
>> This patch is just a first step to such sandboxing. If things go
>> well, in the future the same extension can be added to more syscalls.
>> These should include at least unlinkat(), renameat2() and the
>> not-yet-upstreamed setxattrat().
>>
>> Security considerations:
>> - Only the bare minimal set of credentials is overridden:
>>    fsuid, fsgid and group_info. The rest, for example capabilities,
>>    are not overridden to avoid unneeded security risks.
>> - To avoid sandboxing escape, this patch makes sure the restricted
>>    lookup modes are used. Namely, RESOLVE_BENEATH or RESOLVE_IN_ROOT.
>> - Magic /proc symlinks are discarded, as suggested by
>>    Andy Lutomirski <luto@kernel.org>> - O_CRED_ALLOW fds cannot be 
>> passed via unix socket and are always
>>    closed on exec() to prevent "unsuspecting userspace" from not being
>>    able to fully drop privs.
>
> What about hard links?
Well, you set umask to 0 in your example.
If you didn't do that, the dir wouldn't have
0777 perms, and the hard link would not
be created.
But yes, that demonstrates the unsafe
usage scenario, i.e. unsafe directory perms
immediately lead to a security hole.
Maybe O_CRED_ALLOW should check for
safe perms, or maybe it shouldn't... So far
there are no signs of this patch to ever be
accepted, so I am not sure if more complexity
needs to be added to it.

