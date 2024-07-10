Return-Path: <linux-fsdevel+bounces-23518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3A92D990
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 21:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB4B1C21298
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6CB19645C;
	Wed, 10 Jul 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="M/0RMIMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward206d.mail.yandex.net (forward206d.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D820DDB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641297; cv=none; b=LjLq4qn654169l674umyzKDMnN+44T7CtyVJXm63sUcXKsYoxzksIanT36dXCJh1CsSmEweh4qS7vGDSojGV4LoJtkP8vecaOKK/pRw6NJp8BVxQS3V4r0FksnxwIhRAXytzSLqYXw8RmqUZ2I6iN3jf8RpOGYHh+yg8eG857lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641297; c=relaxed/simple;
	bh=n1tRe6BCNBime7bqZHW0IhfFxQKMBtvMUrmnFbPdBIE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=faltkTT79H2PZtOxlMA7COOGj7WQM3+wpPnKPrvk9Y89Wki0mfWm5gp5Xw/NVCoIADf6ENlEnJCTY4YGNgNLTLTaJSA7igs8acuv+sKsi2j9N2liYMJlZ2KxfFg8czEacQbGDJPxGFSIml0w0AZIcLLemJuprxbcgDE22UAFVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=M/0RMIMj; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward206d.mail.yandex.net (Yandex) with ESMTPS id C724B623CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 22:49:12 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:2345:0:640:1ce6:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id A324D60024;
	Wed, 10 Jul 2024 22:49:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3nkpZG2pJ8c0-achqhfje;
	Wed, 10 Jul 2024 22:49:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1720640944; bh=n1tRe6BCNBime7bqZHW0IhfFxQKMBtvMUrmnFbPdBIE=;
	h=Subject:From:Cc:To:Date:Message-ID;
	b=M/0RMIMjS8MpzuIAytUfkxYkv2maTp9QIdLPn3cExA1pF+hPR+i/2LI8R+wRaYZZb
	 GDSWjMmslu7brcYfSNstvhVSPntFV0H0sJdNlqFIZxPhvrvO6MmcMl+kxMmhaVXWbn
	 q5y3I3j6OV0XCodvsAMHxxzHKdKqGycp4tbwr6U8=
Authentication-Results: mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <9fb28d29-d566-4d96-a491-8f0fbe2e853b@yandex.ru>
Date: Wed, 10 Jul 2024 22:49:03 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: Dave Marchevsky <davemarchevsky@fb.com>,
 Miklos Szeredi <mszeredi@redhat.com>, Andy Lutomirski <luto@kernel.org>
From: stsp <stsp2@yandex.ru>
Subject: permission problems with fuse
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi guys!

I started to try my app with fuse, and
faced 2 problems that are not present
with other FSes.

1. fuse insists on saved-UID to match owner UID.
In fact, fuse_permissible_uidgid() in fs/fuse/dir.c
checks everything but fsuid, whereas other
FSes seem to check fsuid.
Can fuse change that and allow saved-UID
to mismatch? Perhaps by just checking fsuid
instead?

2. My app uses the "file server" which passes
the opened fds to the less-privileged process.
This doesn't work with fuse: the passed fd
gives EACCES on eg fstat() (and likely also on
all other syscalls, haven't checked further),
while with other FSes, most operations succeed.
Some are failing on other FSes as well, like
eg fsetxattr(). I moved them to the FS server
by the trial-and-error rounds, but they are very few.
Would it be possible for fuse to allow as much
operations on an open fd, as the other FSes do?
Otherwise the priv separation seems impossible.


