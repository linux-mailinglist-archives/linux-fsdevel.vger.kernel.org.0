Return-Path: <linux-fsdevel+bounces-19940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF1D8CB4D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 22:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF7F1F22C09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B479149C5B;
	Tue, 21 May 2024 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SKT3Wtix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779853816;
	Tue, 21 May 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324201; cv=none; b=NH5Gz/jrp/xwFUjtJjeOwyBQua7J6f0B4pogNORlZOcKC5ZTj4X9Wraqs/rOKIjaVSMlQGeHtOpVgWCo7Bv7Q/Oc75XikctdkV3eGOr30OjnGi0q/zjrpZLVwqZfNJbIhQFNvNln2mD/apN1cFBDAYYYPdEUCksZXtaOlD0jtKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324201; c=relaxed/simple;
	bh=UJeYAx0s+riUtaDffRhQZniXYmFCQfIeCHnUNZFJ0/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXLxz9oWhsS+xNVmezMv6wJMRn+JrlOidz8UXXIXDQ5jswXb+sY8E+ZwuTon3ZKAukSWdC5qEpsNjiAgcukHruNKUjVm2Gt9+uADzS1vtJQ3boVet07yBRLDUNjF/Y/V8H2wRSHSsyR1bPJ9f+oBBPFtef01woUaDuuhx/OTJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SKT3Wtix; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:39ad:0:640:62fe:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id A3851613DB;
	Tue, 21 May 2024 23:35:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GZQB3w8oDmI0-W1EtqRHB;
	Tue, 21 May 2024 23:35:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1716323717; bh=c7N6rlTa5ppx9RAeRPq2mB8w6Nw+lsRi9BsRkwM6uhE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=SKT3Wtixr0847bCZuU1FA1EPajMmaeICi/K5joOm6b1Mz7LA/Cppwhwg8u2r4Ktya
	 YpQ8xO8wgnibdHZKHCD+LE9aoIid3dWuSfUBaGb8QMRb4J2jjIZcxvZMsVyWzm8Y+v
	 iqxosxvl1YnrIWLIPuRa48u/NAleBv8ge33M8tlA=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <125b6804-d9f8-4c36-83cd-36143ba1045d@yandex.ru>
Date: Tue, 21 May 2024 23:35:16 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] implement OA2_CRED_INHERIT flag for openat2()
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240427112451.1609471-1-stsp2@yandex.ru>
 <CAG48ez0rOch3wemsmrL-ocadG1YeJ6Lyhz1uLxJod22Unbb_GA@mail.gmail.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CAG48ez0rOch3wemsmrL-ocadG1YeJ6Lyhz1uLxJod22Unbb_GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

21.05.2024 22:01, Jann Horn пишет:
> On Sat, Apr 27, 2024 at 1:24 PM Stas Sergeev <stsp2@yandex.ru> wrote:
>> This patch-set implements the OA2_CRED_INHERIT flag for openat2() syscall.
>> It is needed to perform an open operation with the creds that were in
>> effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLOW
>> flag. This allows the process to pre-open some dirs and switch eUID
>> (and other UIDs/GIDs) to the less-privileged user, while still retaining
>> the possibility to open/create files within the pre-opened directory set.
> As Andy Lutomirski mentioned before, Linux already has Landlock
> (https://docs.kernel.org/userspace-api/landlock.html) for unprivileged
> filesystem sandboxing. What benefits does OA2_CRED_INHERIT have
> compared to Landlock?

The idea is different.
OA2_CRED_INHERIT was supposed to give you an additional access (to what 
you can't access otherwise, after a priv drop), while landlock allows 
you to explicitly restrict an access. OA2_CRED_INHERIT more answered 
with idmapped mounts rather than the landlock, but idmapped mounts are 
not fully unpriv'd.


