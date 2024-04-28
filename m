Return-Path: <linux-fsdevel+bounces-18022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A6B8B4D9D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CAE281861
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B9745E1;
	Sun, 28 Apr 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Lx2P2McH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CB74407;
	Sun, 28 Apr 2024 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714331770; cv=none; b=pKBkVWfSIUXK1AJ/zji9yYBS+WWpcUMhEcQfOfaifrXirAwTItYZiPm8a0NZdbbuARs3a5XxrSgT7HqTzul0uHXSUX+dW4ZdIxOyeqL1szOnDi/GcXMnAcOClfLlw0OCj60wVOTSrLWzcj8jarIN9jUuj7umMt4ZkWlogmUFT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714331770; c=relaxed/simple;
	bh=CcVLKLPUSMo9/bVwGnPhslmwAwF63JSbH90WZWpQ0AA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T7XvXYGelqqmkhSRHCrh24R1P+lIvxkb3toorNKBuwsnAg+BhvkiRL+z9PPpG7aA2k+XEfKP61lCyr/C2gy18Ou5gH8knvnXMc06MLIp6crSB5vnsL1GV2QULgvnOYfQP9cvNLOhxx20rlVbvLxH4FA0Cts27GeL0fr6k/8GReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Lx2P2McH; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c05:84:0:640:40f8:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTPS id A310760E43;
	Sun, 28 Apr 2024 22:15:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rFV7Q2Ujx8c0-9cO9JXv4;
	Sun, 28 Apr 2024 22:15:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714331755; bh=CcVLKLPUSMo9/bVwGnPhslmwAwF63JSbH90WZWpQ0AA=;
	h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
	b=Lx2P2McHndygVzQ9qy1Gn36u0tTuFDYLt+Xrpesc1JYZEjKp3gfonIbK+h0yHACZV
	 FVgwMW+Icda2NoY7BldipA06BkrtE+W8DZDJVgujEtqRKMeRLiVEs2i+eSoNcvXz13
	 aRsNd8oPmPIG/gr0u5gRJvjzYR+5fZn+CH22MZNg=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <3e7f3501-d2e5-478e-bc07-bae7730a5503@yandex.ru>
Date: Sun, 28 Apr 2024 22:15:53 +0300
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
 <8e186307-bed2-4b5c-9bc6-bdc70171cc93@yandex.ru>
In-Reply-To: <8e186307-bed2-4b5c-9bc6-bdc70171cc93@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

28.04.2024 20:39, stsp пишет:
> In short: my impl confines the hassle within
> the single process. It can be extended, and
> then the receiver will need to explicitly allow
> adding such fds to his fd table.
> But your idea seems to inherently require
> 2 processes, and there is probably no way
> for the second process to say "ok, I allow
> such sub-tree in my fs scope".
There is probably 1 more detail I had
to make explicit: if my model is extended
to allow SCM_RIGHTS passage by the use
of a new flag on a receiver's side, the kernel
will be able to check that the receiver
currently has the same creds as the sender.
Please note that my model is needed for the
process that does setuid() to a less-privileged
user. He would need to receive the cred fd
_before_ such setuid, he would need to use
the special flag to receive it, and the kernel
will also need to check that he has the same
creds anyway, so no escalation can ever happen.
Only that sequence of events makes the
SCM_RIGHTS passage safe, AFAICT. But if
you don't allow SCM_RIGHTS, as my current
impl does, then you are sure the process
can raise the creds only to his own ones.

Now talking about your sub-tree idea, would
it be possible to check that the process had
initially enough creds to access it w/o inheriting
anything? That part looks important to me,
i.e. the process must not access anything
that he couldn't access before dropping privs.
But I am not sure if your idea even includes
the priv drop.

