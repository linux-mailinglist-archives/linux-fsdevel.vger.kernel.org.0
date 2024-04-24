Return-Path: <linux-fsdevel+bounces-17617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58CB8B05F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 11:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7761F23B92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12852158D9C;
	Wed, 24 Apr 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="s9nIIatB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041F1E4A9;
	Wed, 24 Apr 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950703; cv=none; b=gEw6OH7N1w08MDcz8KqPrbHTx2pSVcKhsa8cFW+uURa7+fhT60fF6dIEHiW4uM8K05PXVSFBXf5t59+C38enCAPZU4a3QCZKPK82xcUV6Uson6ZPB3KGMj93CMwStNQo+W7pzI2UVYA7zEZc9n8sE6rKWygL3kYp1iUtv4VOesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950703; c=relaxed/simple;
	bh=W20kwssXX+k6F27oa/QR8qY77T2GYkiFI95znuilYbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj13OQc7nK0xaln4qqPR0E0fFKbDJ8YuTH1EiipsuvLqWlJx0vvFzEb7NURqvynCv3TBMXvWGejFoEktuw023Bt65Ey3/ebBCAJA9o7Ki3ByZPQOlJ+fb0hBEnPLq9ikWKKL7LNZ7awvq7LqdwIDw9xS0xJIDhg8G9nfvoftp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=s9nIIatB; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:193:0:640:a325:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id F1DD261136;
	Wed, 24 Apr 2024 12:24:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id oOHRLuOIlOs0-Wj71FBxI;
	Wed, 24 Apr 2024 12:24:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713950691; bh=W20kwssXX+k6F27oa/QR8qY77T2GYkiFI95znuilYbU=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=s9nIIatBSNRVyZWfhwOL1gcyFqYaW6uPcg0gU2ANhN8UybGw/STAJvNRhOHnyqF04
	 mIdig5PWwMsn8UAUhmxZDXtHpmwUGte3O9N4BSPN8sphhd3I7wstlA0ty1LF33eeMd
	 3bjkGnDIMBx372iGUfYqv8mu6bUG2aZzGTqWld0w=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <80e72876-da81-4694-86a2-835c049ed30f@yandex.ru>
Date: Wed, 24 Apr 2024 12:24:49 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: reorganize path_openat()
To: David Laight <David.Laight@ACULAB.COM>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andy Lutomirski <luto@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20240422084505.3465238-1-stsp2@yandex.ru>
 <858f6fb6afcd450d85d1ff900f82d396@AcuMS.aculab.com>
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <858f6fb6afcd450d85d1ff900f82d396@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

24.04.2024 12:17, David Laight пишет:
> From: Stas Sergeev
>> Sent: 22 April 2024 09:45
> I seem to have 5 copies of this patch.....

Yep, its re-sent with every new iteartion,
but doesn't change by itself (the other
one changes).
Is there anything I can do to avoid
unneeded duplicates of an unchanged
patch?
Manually reduce Cc list until the patch
changes? That looks too much of a trouble
though.

> You probably ought to merge the two 'unlikely' tests.

Ok.


> Copying op->open_flag to a local may also generate better code.

Can't gcc deduce this on its own?
But ok, will do.


