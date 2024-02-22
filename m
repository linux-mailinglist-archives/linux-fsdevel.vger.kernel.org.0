Return-Path: <linux-fsdevel+bounces-12414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC5285EEA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 02:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7279284849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0D312E40;
	Thu, 22 Feb 2024 01:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="FX6hPkUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC79F516
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708565178; cv=none; b=L2Ip9SUP23q7r0Pt+Gtrv81KpKXfuo8KDunFA+GEOpA0yJcoFZjq2GAtmUGgLhwDg4HTD0U6nyl0150y53w/we4mnYBKYxY1F/l4/FSHY+5/OBZOk5I13BT2cmnyegCrUMdxY8oiQF7uOclU1OwhcC/30YkCSMe/hdvbGr9RuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708565178; c=relaxed/simple;
	bh=y9XCxVEOdhN5SjJ6eLh60U7lwMLUJaow/6Ozfuo4eXA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxm2AjRxNBtrHC+Mc73nuhZg8k0OtcNjp/EJhoWFGpMjoX3A654gDmT7mfeQGRfgIJjepOy5PPbRjp6zPmCoj74cr4+ocqwU1Jy9d60EPQjmUluu4+bcHK1nTh3A03FzA42c2DftH9vcC72XyBjWGL9aGcK5BkDLFuGZLgBgFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=FX6hPkUf; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1708565167; x=1708824367;
	bh=gO2E4nuy6vwZurt9eqGXsAuEX2KwpaW4+k9h+b+5C9Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FX6hPkUfzeGN+bkx3pfvjKL129R8c+T6PPBzLuQNqSSK4rjQerjznUGMVy6ZV+7gh
	 WiUIw4qwxb4ex2rN5f6SoG7BmsTiClc6veUfbXAYazQ1glb1oKPQ23cpJIghB8vt4I
	 5hrnLOCuwyVYV5OEDv+3sMeadOfPjkFuAROXrRih2oFkcCnqzOzAVDqjzb4yap6db9
	 JqD3pZqWsu1sjjMM+VW7/Un/Q5tuO9mNG+PsBUkeBmbfVuk50CY4pV8sRlx6RaOs3s
	 Sgu+TXPNu5fisAUiyfhA5QRLWmS6JAUJ6H7lMjiMD36JgJYHDcCP7vi4nAoC28QMif
	 mU7aPV2OmUPXg==
Date: Thu, 22 Feb 2024 01:25:57 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Message-ID: <6fb38202-4017-4acd-8fb8-673eee7182b9@spawn.link>
In-Reply-To: <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link> <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com> <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm> <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link> <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com> <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link> <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com> <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/20/24 02:47, Miklos Szeredi wrote:
> On Tue, 20 Feb 2024 at 09:35, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> On Mon, 19 Feb 2024 at 20:54, Antonio SJ Musumeci <trapexit@spawn.link> =
wrote:
>>> On 2/19/24 13:38, Miklos Szeredi wrote:
>>>> On Mon, 19 Feb 2024 at 20:05, Antonio SJ Musumeci <trapexit@spawn.link=
> wrote:
>>>>
>>>>> This is what I see from the kernel:
>>>>>
>>>>> lookup(nodeid=3D3, name=3D.);
>>>>> lookup(nodeid=3D3, name=3D..);
>>>>> lookup(nodeid=3D1, name=3Ddir2);
>>>>> lookup(nodeid=3D1, name=3D..);
>>
>> Can you please try the attached patch?
> Sorry, missing one hunk from the previous patch.  Here's an updated one.
>
> Thanks,
> Miklos

I'll try it when I get some cycles in the next week or so but... I'm not=20
sure I see how this would address it.=C2=A0 Is this not still marking the=
=20
inode bad. So while it won't forget it perhaps it will still error out.=20
How does this keep ".." of root being looked up?

I don't know the code well but I'd have thought the reason for the=20
forget was because the lookup of the parent fails.



