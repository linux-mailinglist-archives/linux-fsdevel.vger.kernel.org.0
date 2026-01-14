Return-Path: <linux-fsdevel+bounces-73787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038CD20620
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F70B3008CAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178D3A7848;
	Wed, 14 Jan 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ETr3Yzvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB73A4F2E
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409957; cv=none; b=SG7K+s2OiDNxtde2tCiEETD4/0roUhpWcNGiP+aQ+X/92p2bsCYE9EeI2jnuTFasoz7RWAiRr48xzUR5+3vVnsT4ilAiKS0C5FKiWKDE6O37IvxjMiDyaCjjRQjzpQdjbtnSA5XSXZ1mH+E8WTqBiwsi2UW2FbhPAidewLMrx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409957; c=relaxed/simple;
	bh=zjgZSPqvTqiaPZsuOegnP5LqJm31sl7fayZaSh35Xfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxBnsDbjAUrTOnECOYBTfBFqPBNMPxFtbtFzGTil1uTYC6PuYsJxXObfEaAXOqDhK2xhaozOlpWVLF6ht0r9pv5dxg7FcaENgPYw9Ha3PtsAVr/IcfQ4k0dEr13gR9JRyVnPan5va94wTi/yu6OhjlUf8SQBCGw49b6wy82upBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ETr3Yzvb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tsshhCdj3z+i7gDvTnyTAmu79VNyppmr/IQoED7aHws=; b=ETr3Yzvbu/4MDkheI5Ao9VteYb
	nSPe0XIUR4aAtaMMTqd8VH/kwLdZCthUwLarpwbbKxuGvhXX4DpHamjrpd7SnFGrsfjlPP+T0//4W
	yYYrlzwjhRIyHyi3Gk1ROzjxI7OieIEIHOSkJKLk0KhWwDfJNbefzKx2VlQ/ZVbcG1gSpiqzUYD9r
	35+LUCgVkiVJjhI8Dq1nqNaxUNkiqXZ0/oegxcI7LkzZoltKx3o9fSYAnxlb7eW1B7ByQZvylr3OT
	u+8hVS5Ga9OFRJ+S61tgq9QuL/q0YQzX6Tzsm8MawczEIwDraid74ECfFLo3xADmZ0dT9MaPqpWvt
	j7VLo15w==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vg4D3-005MkT-Po; Wed, 14 Jan 2026 17:59:05 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,  Miklos Szeredi
 <mszeredi@redhat.com>,  linux-fsdevel@vger.kernel.org,  Al Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/6] fuse: fixes and cleanups for expired dentry eviction
In-Reply-To: <CAJfpeguq9Kq+8D9e2Ph0-T6xrwBD42V7a2hhP7NkOapcRNZq4Q@mail.gmail.com>
	(Miklos Szeredi's message of "Wed, 14 Jan 2026 16:43:14 +0100")
References: <20260114145344.468856-1-mszeredi@redhat.com>
	<20260114-frohnatur-umwegen-8e4ce0e3fc4b@brauner>
	<CAJfpeguq9Kq+8D9e2Ph0-T6xrwBD42V7a2hhP7NkOapcRNZq4Q@mail.gmail.com>
Date: Wed, 14 Jan 2026 16:59:04 +0000
Message-ID: <87pl7c2krr.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14 2026, Miklos Szeredi wrote:

> On Wed, 14 Jan 2026 at 16:37, Christian Brauner <brauner@kernel.org> wrot=
e:
>>
>> On Wed, Jan 14, 2026 at 03:53:37PM +0100, Miklos Szeredi wrote:
>> > This mini series fixes issues with the stale dentry cleanup patches ad=
ded
>> > in this cycle.  In particular commit ab84ad597386 ("fuse: new work que=
ue to
>> > periodically invalidate expired dentries") allowed a race resulting in=
 UAF.
>> >
>> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> > ---
>>
>> Do you want me to route those via vfs.fixes?
>
> Yes, please.
>
>> Btw, the Link: you provided in the first patch points to nothing on lore.
>
> It works for me.  How can that happen?

Yikes!  I totally missed that discussion (the link works for me too btw).
I remember seeing the fuse pull request for 6.19 but not the discussion
that followed.

I'm still reading through that thread, but these patches look sensible.
Thanks a lot for fixing these issues, Miklos!

Cheers,
--=20
Lu=C3=ADs

