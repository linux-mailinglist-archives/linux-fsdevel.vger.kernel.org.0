Return-Path: <linux-fsdevel+bounces-35484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF289D54CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 22:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91C6B21822
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 21:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E301DA0FE;
	Thu, 21 Nov 2024 21:36:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6D12FB1B;
	Thu, 21 Nov 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224977; cv=none; b=nswTDvCPEDlPjAwt8IK7srYU7gGS6iXdhXVoSaWRDa2Sjav6rB1WNEGar+Gzo3iR5Qss+h+rF7q8UGGFIoDyHoAo6OylnyKsAbFiaMSFiwmlSbTWkIKqGwrWnPtFePgNreVhE67o8ApEBuQ5VdKeFlhMhXK30W/NY4kCFa/2r1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224977; c=relaxed/simple;
	bh=qr8EncFIIAvG9tIgF5QxMs4376UrfnO8iYuvacIsgGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7DHfjx9kvHf5V+9iTMBZKXuqwInxDVMEfIHIlSe5ITcw302J3qv4hTqOUYHeshInc5bNilpoi8zmjAHxpWsVMGpyEPj6OpiPgq0plCgzMVcdNcg/ZXVq1HN9JaPBn89Y/5iE+hWZGovtU/mQC0YI53XcEyzEy8FvwsGZtA1RIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 975C08FC2D;
	Thu, 21 Nov 2024 21:26:38 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Date: Thu, 21 Nov 2024 22:26:38 +0100
Message-ID: <10576437.nUPlyArG6x@lichtvoll.de>
In-Reply-To: <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
References:
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Shuah, hi everyone.

Shuah, I appreciate your effort to resolve the Code of Conduct issue.

Also I make no judgment about the technical matter at hand. Basically I do=
=20
not even have a clear idea on what it is about. So I am just commenting on=
=20
the Code of Conduct enforcement process:

Shuah Khan - 20.11.24, 23:21:06 MEZ:
> I didn't pick up on your desire to apologize after the discussion in
> our conversation.
>=20
> Are you saying you will be happy to make amends with an apology after
> the discussion and debate?

Do you really think that power-playing Kent into submission by doing a=20
public apology is doing anything good to resolve the issue at hand?

While it may not really compare to some of the wording Linus has used=20
before having been convinced to change his behavior=E2=80=A6 I do not agree=
 with=20
the wording Kent has used. I certainly do not condone it.

But this forced public apology approach in my point of view is very likely=
=20
just to cement the division instead of heal it. While I publicly disagreed=
=20
with Kent before, I also publicly disagree with this kind of Code of=20
Conduct enforcement. I have seen similar patterns within the Debian=20
community and in my point of view this lead to the loss of several Debian=20
developers who contributed a lot to the project while leaving behind=20
frustration and unresolved conflict.

No amount of power play is going to resolve this. Just exercising=20
authority is not doing any good in here. This needs mediation, not forced=20
public humiliation.

To me, honestly written, this whole interaction feels a bit like I'd=20
imagine children may be fighting over a toy. With a majority of the=20
children grouping together to single out someone who does not appear to fit=
=20
in at first glance. I mean no offense with that. This is just the impressio=
n=20
I got so far. The whole interaction just does not remind me of respectful=20
communication between adult human beings. I have seen it with myself=E2=80=
=A6 in=20
situations where it was challenging for me to access what I learned, for=20
whatever reason, I had been acting similarly to a child. So really no=20
offense meant. This is just an impression I got and wanted to mirror back=20
to you for your consideration.

I'd make three changes to the current approach regarding Kent's behavior:

1) Take it to private mediation.

2) Move it from mail to actually talking with one another. Resolving=20
conflicts by mail exchange is hard. Maybe voice / video chat. Or meeting in=
=20
person, in case it possible. In other words: *Talk to each other*! Mail is=
=20
really very bad for things like that.

3) Assume good intentions!

And the best first step for everyone involved may just be: Take a deep=20
breath and let it sit for a while. Maybe there is something to learn from=20
this for everyone involved, including myself.

I have and claim no standing in kernel community. So take this for=20
whatever it is worth for you.

Best,
=2D-=20
Martin



