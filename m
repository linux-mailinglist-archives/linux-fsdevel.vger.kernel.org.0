Return-Path: <linux-fsdevel+bounces-23803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498A9338F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 10:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7A11C232A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358BB374F6;
	Wed, 17 Jul 2024 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b="hYt2Bvmb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.python.org (mail.python.org [188.166.95.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB437249F9;
	Wed, 17 Jul 2024 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.166.95.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204787; cv=none; b=syky23DVHluf2R3U2X7ZaCbeYu8Ahr/6Hw4vs9DY6yeYkn12ZiGjacgMCTR9PQf6uShiHRXo4hpMb1WkJR9nxI7w3b2Gs2bZFraM9A+zlA9CaOkabrGICJnpaQ41YzTOmqCKRQHC+cZXeETUp6cLNP9/hzUKVJ6LBfvSRS6/O3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204787; c=relaxed/simple;
	bh=fTteDRfXe9Vlvc3/MVkCR1QexOCfXk5wsr0WUqhKjwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUJPLEsAIhPFCLOh1r+3m+J1NjAxgMuyyAPcMjdojjMi3TZOKN+/5IciTHi/25KyXL/iD1E7TyWf+pgnaUO+TEYL/2MNqKLaK0vsgcOR7e2EXsPKLaYmKl3Ctfn/Jt3u4C/x4Rnod6g7E2Ttlm/ZAJ5qcNxeUPfZdbwOhCgqdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=python.org; spf=pass smtp.mailfrom=python.org; dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b=hYt2Bvmb; arc=none smtp.client-ip=188.166.95.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=python.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=python.org
Received: from [192.168.1.83] (unknown [2.29.184.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.python.org (Postfix) with ESMTPSA id 4WP8Cx4j8HznWFN;
	Wed, 17 Jul 2024 04:26:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
	t=1721204783; bh=fTteDRfXe9Vlvc3/MVkCR1QexOCfXk5wsr0WUqhKjwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hYt2BvmbQYJcbMIPmDyPk0v5DDLpQwvR7wOKYjhJ3uw3TuQItzbBjTZiqlNAJKVbP
	 7sccz+rS3ckrUp0F+K65M4OQN+VxdVTR8jl+PZ319XHPjr0ZHkx3SGkX0fwY3O6JrT
	 Bb0ws6UinibHmFcuTiPzn/7nhblRN247FK4zx72Y=
Message-ID: <a0da7702-dabe-49e4-87f4-5d6111f023a8@python.org>
Date: Wed, 17 Jul 2024 09:26:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Content-Language: en-GB
To: Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>,
 Alejandro Colomar <alx.manpages@gmail.com>, Aleksa Sarai
 <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>,
 Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>,
 Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Jordan R Abrahams <ajordanr@google.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>,
 Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
 Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
 Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>,
 kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
From: Steve Dower <steve.dower@python.org>
In-Reply-To: <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 07:33, Jeff Xu wrote:
> Consider those cases: I think:
> a> relying purely on userspace for enforcement does't seem to be
> effective,  e.g. it is trivial  to call open(), then mmap() it into
> executable memory.

If there's a way to do this without running executable code that had to 
pass a previous execveat() check, then yeah, it's not effective (e.g. a 
Python interpreter that *doesn't* enforce execveat() is a trivial way to 
do it).

Once arbitrary code is running, all bets are off. So long as all 
arbitrary code is being checked itself, it's allowed to do things that 
would bypass later checks (and it's up to whoever audited it in the 
first place to prevent this by not giving it the special mark that 
allows it to pass the check).

> b> if both user space and kernel need to call AT_CHECK, the faccessat
> seems to be a better place for AT_CHECK, e.g. kernel can call
> do_faccessat(AT_CHECK) and userspace can call faccessat(). This will
> avoid complicating the execveat() code path.
> 
> What do you think ?
> 
> Thanks
> -Jeff

