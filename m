Return-Path: <linux-fsdevel+bounces-18897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02738BE299
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B8C1F224FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46D515D5B2;
	Tue,  7 May 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="szMkz5XQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28015B153;
	Tue,  7 May 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086554; cv=none; b=lkyRw0wCtQjqgCMedezZ215X9JHBuZFdxwS9DdRtiN/iynYrJvxR/2zeO+EKyZtL+6ZQgKn8/Al4412tgHK0YNuEPBWhdBuDfgWiDTwx4BeeWCQ0B6V/in6YMe+PYwuxwumhd6FCKESr2eek33n/DIZLJRXu+fvMgcgV7r0M/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086554; c=relaxed/simple;
	bh=7mLQ4noYOwaZz0uIOPLa+mJodEytp0OT+zTex7p1R9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mR5WtHVhTbpXfW3Ql19fJiZYapBA4PEPF7fc6tO87EgnSocJx/b8bbkRI4Cru+zO/WfwfTxjfwK97rXml1iXGFjTunQPqmWhAsxthXr3jI+8AVzrqMzSz9zvRBShbUqMOsYomf+f+fPuSz1jXtC0ELRxduh8JBCl98Z1Mn7aPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=szMkz5XQ; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:230c:0:640:f8e:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 3390E61277;
	Tue,  7 May 2024 15:48:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MmXuqmAmDqM0-G4BR5X7Q;
	Tue, 07 May 2024 15:48:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1715086104; bh=zAPclAFMPPKUlH6qpuAnNZJMeX8QiDYjKI0Oitzf9Wg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=szMkz5XQXmyp2MPWrKjBmUyCNvF4aEiWBUHmeQuOvbJ+FrIwFO5zMOe5s9r3DFbuY
	 y3OvHyeI6zCWBYm8xV4pmdhi/ldtf9ACwxzz9kUvbTK84BTzHgCL8jB+0xLQIhuhwa
	 SIuvfx3CMflI8RM6yWMNn/teOn3X4MbK3GIdz2fk=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <7fcb3f51-468f-444d-9dd4-fa4028f018fc@yandex.ru>
Date: Tue, 7 May 2024 15:48:22 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] implement OA2_CRED_INHERIT flag for openat2()
Content-Language: en-US
To: Aleksa Sarai <cyphar@cyphar.com>
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
 <20240506.071502-teak.lily.alpine.girls-aiKJgErDohK@cyphar.com>
 <5b5cc31f-a5be-4f64-a97b-7708466ace82@yandex.ru>
 <20240507.110127-muggy.duff.trained.hobby-u9ZNUZ9CW5k@cyphar.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20240507.110127-muggy.duff.trained.hobby-u9ZNUZ9CW5k@cyphar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

07.05.2024 14:58, Aleksa Sarai пишет:
> On 2024-05-07, stsp <stsp2@yandex.ru> wrote:
>> 07.05.2024 10:50, Aleksa Sarai пишет:
>>> If you are a privileged process which plans to change users,
>> Not privileged at all. But I think what you say is still possible with
>> userns?
> It is possible to configure MOUNT_ATTR_IDMAP in a user namespace but
> there are some restrictions that I suspect will make this complicated.
> If you try to do something with a regular filesystem you'll probably run
> into issues because you won't have CAP_SYS_ADMIN in the super block's
> userns. But you could probably do it with tmpfs.

Then its likely not a replacement for
my proposal, as I really don't need that
on tmpfs.
Perhaps right now I can use the helper
process and an rpc as a replacement.
This is much more work and is slower,
but more or less can approximate my
original design decision quite precisely.
Another disadvantage of an rpc approach
is that the fds I get from the helper
process, can not be trusted, as in this
case kernel doesn't guarantee the fd
actually refers to the resource I requested.
I've seen a few OSes where rpc is checked
by a trusted entity to avoid such problem.

>>> A new attack I just thought of while writing this mail is that because
>>> there is no RESOLVE_NO_XDEV requirement, it should be possible for the
>>> process to get an arbitrary write primitive by creating a new
>>> userns+mountns and then bind-mounting / underneath the directory.
>> Doesn't this need a write perm to a
>> directory? In his case this is not a threat,
>> because you are not supposed to have a
>> write perm to that dir. OA2_CRED_INHERIT
>> is the only way to write.
> No, bind-mounts don't require write permission.

Oh, isn't this a problem by itself?
Yes, in this case my patch needs to
avoid RESOLVE_NO_XDEV, but I find this a harsh restriction. Maybe the 
bind mount was done before a priv drop? Then it is fully legitimate. 
Anyway, I don't know if I should work on it or not, as there seem to be 
no indication of a possible acceptance.


