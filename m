Return-Path: <linux-fsdevel+bounces-17728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A078B1DF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775BD282E91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F97128803;
	Thu, 25 Apr 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="cHLvtu41"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9258528F;
	Thu, 25 Apr 2024 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037022; cv=none; b=isAwv/x8agu8jbfvNpCxq1eCCh4mwUhaEbgKU6Y9gmhY0Q60/M0Wgz/u0Mi+6etoe7VGOILhbTW/HZyO9DtBcxzlMwly+rl6XNBpv5DCw0LTIVwgVBx/tZVMoBkgDlqk+4PzOeKnV5/rjR1XzdAaE8FhpmQIDKrF6zWZh/TODWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037022; c=relaxed/simple;
	bh=A4N62TDY2FnhU4Mk1kWS3SEqpge5O5/RVzJOoVq2uAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVT+0dCkzedS6YiSbxmVgc3+4m675iEAfoXT49z3KbgZdmnonCiQp9BvD4d/15kT+nkqXqcwY3rVQnhWWPoPObxg/M+AdJTFTTwTBwY4aRxWVuQrwVoarsJoVOfIRsULPeSDMiNdJuIUZJxxmn2HD0XsBaiBACYjV/1q34VZdOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=cHLvtu41; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:629:0:640:2d57:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 0FDE061514;
	Thu, 25 Apr 2024 12:23:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id RNIjJAN3UCg0-gn0GTDkf;
	Thu, 25 Apr 2024 12:23:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714037009; bh=ZuVO93ildlmJKltNuYp5AwhW1NHN300nQCPjAg9zoVk=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=cHLvtu413lU2yWwn0h6RTVFreAZNKIX/viLf9e8seYfZEF7MUvHzd4YPvbS7hs87V
	 WWjl2varW8TWEqeb6VGFa6uYD8H4y6RSj1HtihUVz/lugJOAwwQCJmeje8ZRP1LAVh
	 cWaBdXX/DEvAijV2WOryDgpM8EwXxjE9yRxCh4w8=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <7c620151-be12-4580-818e-86e8b7f46e09@yandex.ru>
Date: Thu, 25 Apr 2024 12:23:27 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240424105248.189032-1-stsp2@yandex.ru>
 <20240424105248.189032-3-stsp2@yandex.ru> <20240425023127.GH2118490@ZenIV>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20240425023127.GH2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.04.2024 05:31, Al Viro пишет:
> Incidentally, suppose you have the same process run with stdin opened
> (r/o) by root.  F_SETFD it to O_CLOEXEC, then use your open with
> dirfd being 0, pathname - "" and flags - O_RDWR.
I actually checked this with the test-case.
It seems to return ENOENT:


Breakpoint 1, openat2 (dirfd=0, pathname=0x7fffffffdbee "",
     how=0x7fffffffd5e0, size=24) at tst.c:13
13        return syscall(SYS_openat2, dirfd, pathname, how, size);
(gdb) fin
Run till exit from #0  openat2 (dirfd=0, pathname=0x7fffffffdbee "",
     how=0x7fffffffd5e0, size=24) at tst.c:13
0x000000000040167b in main (argc=3, argv=0x7fffffffd7b8) at tst.c:140
140        fd = openat2(0, efile, &how1, sizeof(how1));
Value returned is $1 = -1
(gdb) list
135        err = fcntl(0, F_SETFD, O_CLOEXEC);
136        if (err) {
137            perror("fcntl(F_SETFD)");
138            return EXIT_FAILURE;
139        }
140        fd = openat2(0, efile, &how1, sizeof(how1));
141        if (fd == -1) {
142            perror("openat2(1)");
143    //        return EXIT_FAILURE;
144        } else {
(gdb) p errno
$2 = 2


So it seems the creds can't be stolen
from a non-dir fd, but I wonder why
ENOENT is returned instead of ENOTDIR.
Such ENOENT is not dicumented in a
man page of openat2(), so I guess there
is some problem here even w/o my patch. :)


