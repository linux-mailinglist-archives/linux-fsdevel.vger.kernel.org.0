Return-Path: <linux-fsdevel+bounces-17559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860638AFC3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1152A281A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50B6328DB;
	Tue, 23 Apr 2024 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="rozgHBGe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECFE18B04;
	Tue, 23 Apr 2024 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912779; cv=none; b=uQtnQ2AjQMS/CxYSD2L0SK2BLcmLihoPQI4WywIoRIHmqfZVlj7NGxU3dFnPA4/amBLHiHsD40YseB7slskM1Zak2PfJHrdGpDZa3tZFhS82bI9BkKUOcQJtqov8QfhU4VljMhB4s3LzKY7+6n/fcilbD7hddH1BqUrYqNdAdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912779; c=relaxed/simple;
	bh=gEADGKBqJj3ZAJettCo9099wAMmz2xF0IxZ6PXZbvXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlzjFdfiXc57MWjYSxqyQDUgWzMQa+SAvNrPuC3QJG9HRPtbj9fh+hyK6t3V/i1+uebadvJm/XLNJinbiiFaE+WiO3B+evcETISGEFN9AkyCFdPfyjZW4gDNuaF26Nsfrj6l971R+D7zjea/yH/ouW+/5ViTSSbKmSxbyEO9yPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=rozgHBGe; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a14:0:640:8120:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id CC8D86180D;
	Wed, 24 Apr 2024 01:52:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jqTm45NoKmI0-LxKvboFV;
	Wed, 24 Apr 2024 01:52:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713912767; bh=frtj/OWfuK2l0yauuwxOq5Ja3FZYzGG8tIdmxFP5wxI=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=rozgHBGehcqd87/IxWKXLRd9g5vTbAA3lVsgEiB792xg6wC334pZBnp+3OjEKgz7b
	 guU3natDtp2HyifDgFpl7coJBqwG9lbleKAaDfZjzr4fIE9rQ9OZ/pxI8S4DA3OaEz
	 fo0ZnqwGYKldFBmH8cV96w6a6FI9GZYoMEchv2ks=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <3a6eccbd-263d-4a54-a35f-c16f60dc0a11@yandex.ru>
Date: Wed, 24 Apr 2024 01:52:45 +0300
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
> Also, there are lots of ways that f_cred could be relevant: fsuid/fsgid, effective capabilities and security labels. And it gets more complex if this ever gets extended to support connecting or sending to a socket or if someone opens a device node.  Does CAP_SYS_ADMIN carry over?
I posted a v3 where I only override
fsuid, fsgid and group_info.
Capabilities and whatever else are
not overridden to avoid security risks.
Does this address your concern?

Note that I think your other concerns
are already addressed, I just added a
bit more of a description now.

