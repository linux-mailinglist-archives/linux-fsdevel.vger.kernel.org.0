Return-Path: <linux-fsdevel+bounces-17731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835498B1ED9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF651F249CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959D86274;
	Thu, 25 Apr 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HP7iTtDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B58594A;
	Thu, 25 Apr 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039946; cv=none; b=Zj5wkqZ1gANj1Gy6B31Yn4iHko84D4pqYY4J2Z9QE0km5NKtRKzbjoYxSwaMvmx5NmkdDbUsIWVMZcxcv4s91AgSCwWsOmouFx8/+wKTSuHH6kewoUqnS4a9G7cCuQypbZjQ5M1z/u2HcWvBkxrWHCO+AYvA2C1nmZhzEeg1enE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039946; c=relaxed/simple;
	bh=wy/vAfN3IBii4kwsZud03p3AdGefvq4UBkCuhdPyqno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSucy87AG+41Ese6TSR7RsdVimzDnOZyA2JNZV3nLgDRA8265JCBbLRD3WzDNh67Nj63xilNol6YWaF0TQKfjkeyMzqnKaQqtBOZ2Fho9GnHhSOKD8+6nQIxbc07EewDKHlwiDohSvXNzLTk3v9IzW0UF+zge5psi60WXEVQ2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=HP7iTtDD; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8a85:0:640:45ff:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id B33F2614BE;
	Thu, 25 Apr 2024 13:12:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CCJCnHgOk0U0-8XUahYy7;
	Thu, 25 Apr 2024 13:12:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714039933; bh=niuWKO58ge/tVnPVLdNAnsg7BggPhgvUmdD2vORWwoI=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=HP7iTtDDcz8JiQwv1xRbvepnEVrFyWgImj3cHsZBPu+a4TAomyZcfLhQn1e7kzubr
	 2EvMopWEcYoCTCNWfijBiy7TKP52nW+Yo6lwVy9ir/3KFSZPKRbcuRdl/lIhjtKqqN
	 qT7vNgADGZ6nyJRaqcs7QvEBx2k5bqmaqZBTzoP4=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <df51f2fd-385a-47bf-a072-a8988a801d52@yandex.ru>
Date: Thu, 25 Apr 2024 13:12:12 +0300
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
 <6b46528a-965f-410a-9e6f-9654c5e9dba2@yandex.ru>
 <20240425-ausfiel-beabsichtigen-a2ef9126ebda@brauner>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20240425-ausfiel-beabsichtigen-a2ef9126ebda@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.04.2024 12:54, Christian Brauner пишет:
> I'm not sure what you don't understand or why you need further
> clarification. Your patch allows any opener using your new flag to steal
> the uid/gid/whatever from the original opener.

No, absolutely impossible (see below).


>   It was even worse in the
> first version where the whole struct cred of the original opener was
> used. It's obviously a glaring security hole that's opened up by this.

Well, it was the second version actually
(first one only had fsuid/fsgid), but no,
its the same thing either way.
The creds are overridden for a diration of
an openat2() syscall. It doesn't matter
what uid/gid are there, because they are
not used during openat2(), and are reverted
back at the end. The only reason I decided
to get back to fsuid/fsgid, were the capabilities,
which I don't want to be raised during openat2().

> Let alone that the justification "It's useful for some lightweight
> sandboxing" is absolutely not sufficient to justify substantial shifts
> in the permission model.
>
> The NAK stands.

But I am sure you still don't understand
what exactly the patch does, so why not
to ask instead of asserting?
You say uid/gid can be stolen, but no,
it can't: the creds are reverted. Only
fsuid/fsgid (and caps in v2 of the patch)
actually affect openat2(), but nothing is
"leaked" after openat2() finished.

That said, Viro already pointed to the actual
problem, and the patch-testing bot did the
same. So I have a valid complains already,
and you don't have to add the invalid ones
to them. :)


