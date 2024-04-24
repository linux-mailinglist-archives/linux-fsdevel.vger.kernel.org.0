Return-Path: <linux-fsdevel+bounces-17623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7078B07D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 12:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96B328307D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D800159915;
	Wed, 24 Apr 2024 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aHWX6URs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F36142E62;
	Wed, 24 Apr 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956241; cv=none; b=m3radUQssZGcZR3ioTjb1MQskSDnel+GHE0d7ZNCmBwBFiUhwT8oxhPwSUJWeWcsvFFJU8Uwa4ZnM1oo4MKN/yzpz5cOaM0FLXgAP+tZ6waH4mazfc+TGLwwX74bwAxx3ZrZR7rTpUR+zXf5Y4Ky4jOU4oL+R3oOyEHm442+rGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956241; c=relaxed/simple;
	bh=Tpknc1WS+aLV5Cxqz1NO1ZCEXDAP8+u3fI3aOx5+9VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prOgcCI7V8+pmHHPV8uSXS3xtPuDCGE7HoHuPsdez3rzBZQ/1FL5CriJMIMPnML/XIsJ1KBAUST8S1F5NUShkCfAmZ/L/K6VbTGTYZxuqeMRrKZqQLMepzEv40/o+pqY8fts4j0fTmU6bhPL8J0JbZSKXW8F3PSmMLbsuyhvQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=aHWX6URs; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:9309:0:640:3b75:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id 4E59861636;
	Wed, 24 Apr 2024 13:57:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 9vIYOJTo7Gk0-0xNd6Gyy;
	Wed, 24 Apr 2024 13:57:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713956230; bh=PW4InI6RvH6mgnnXE9HYRckmIzWlFOBQopwKxQoJMTc=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=aHWX6URsvGY9GfJ08EiIqvHVi0dly45Vh5O6Q+ZOTyxDfkNc5ORaPf7IaobMkzrAA
	 9Jo0iXVHVbmgUE3c513+Yo49C2x1HtTc9YXT7ecCU5H9oteq2GRdB7+YIxGthm5272
	 MM42/0p13z6yHj5CShN+ssTAVQMbebEA1M7iaQgI=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <0e2e48be-86a8-418c-95b1-e8ca17469198@yandex.ru>
Date: Wed, 24 Apr 2024 13:57:09 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
Content-Language: en-US
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240423110148.13114-1-stsp2@yandex.ru>
 <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

23.04.2024 19:44, Andy Lutomirski пишет:
>> On Apr 23, 2024, at 4:02 AM, Stas Sergeev <stsp2@yandex.ru> wrote:
>>
>> ﻿This patch-set implements the OA2_INHERIT_CRED flag for openat2() syscall.
>> It is needed to perform an open operation with the creds that were in
>> effect when the dir_fd was opened. This allows the process to pre-open
>> some dirs and switch eUID (and other UIDs/GIDs) to the less-privileged
>> user, while still retaining the possibility to open/create files within
>> the pre-opened directory set.
> I like the concept, as it’s a sort of move toward a capability system. But I think that making a dirfd into this sort of capability would need to be much more explicit. Right now, any program could do this entirely by accident, and applying OA2_INHERIT_CRED to an fd fished out of /proc seems hazardous.

While I still don't quite understand
the threat of /proc symlinks, I posted
v4 which disallows them.

> So perhaps if an open file description for a directory could have something like FMODE_CRED, and if OA2_INHERIT_CRED also blocked .., magic links, symlinks to anywhere above the dirfd (or maybe all symlinks) and absolute path lookups, then this would be okay.

So I think this all is now done.

> Also, there are lots of ways that f_cred could be relevant: fsuid/fsgid, effective capabilities and security labels. And it gets more complex if this ever gets extended to support connecting or sending to a socket or if someone opens a device node.  Does CAP_SYS_ADMIN carry over?
Not any more, nothin is carried but
fsuid, fsgid, groupinfo.

Thank you.

