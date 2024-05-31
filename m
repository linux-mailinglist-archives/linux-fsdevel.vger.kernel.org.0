Return-Path: <linux-fsdevel+bounces-20667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15F8D68BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 20:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32141F28DF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE817C21B;
	Fri, 31 May 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nycjtFk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7F7BB01
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178914; cv=none; b=MoXy3ZTN0fazcWbhvaBsqbS5tIer/FTmmuK4snXQgUhuzBRQUhyXaypxXWJy1ddeMg5k6yd/r1RuWLUSN7uh5D/wT5PHe3TX/7Y2RXi8wPWjvCfZ0xU4UvR4Gh7yYNYhRg/7+baLHoJs045cgX2VJT0WBT6D6jwP0XDryP35cB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178914; c=relaxed/simple;
	bh=bFew3LFAIXyTqRzbHiBfSOrIDw2Ip0FO0DSKOIJ6i/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZULB3SeIhWRFEqdzBJ1PWNPYeV2YJSRrqA0da49eLdX75NMMThWWj6sDcn5MuifWGiVcySTgcJcccaMIN65ats5hppvjCPK8QcNIDeP4YmLBHw5ZRiWXz/kFTuZxL2fyY+2oxwKrEUcz4dL+KRQGOUjJ0gYy7v4Et1X+hbc4vLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nycjtFk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C816DC116B1;
	Fri, 31 May 2024 18:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717178913;
	bh=bFew3LFAIXyTqRzbHiBfSOrIDw2Ip0FO0DSKOIJ6i/4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nycjtFk2ZPyMKXgsh0jBfgDGBtOllNfP2+/cJpBXGoEsw3NNmhHou3z484/0mFK8q
	 ssqh4KwFY2SmGBkoyJsR6AijDl/q25jNT/zy7gH7Zt9jQEf+aSpMTlPCEQss+rtYuC
	 pYlf+lDZc2P1ElzrvGGW2EglciBIIIgh6MBacwFEa78XkovYPX0VUHnyX1wqIDY6M5
	 iUp7ku0GQfLsQV4t3DfpHjZCBJJ1/fxFnc6n6Pmu8MaWlhk3KjhFIHZ0aNQ/2i5ndE
	 QDjzRU5V4ds8BZhcLeFSMdw6ZHuuFQDgGGoLvDPIwXAdthi9TXHlcUkDbQnI2JDs0U
	 BYl/7TeE9fPUA==
Message-ID: <a557064e2c833739d2cf74741454dabb73877f63.camel@kernel.org>
Subject: Re: [PATCH] fs: don't block i_writecount during exec
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner
	 <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	david@fromorbit.com, hch@lst.de
Date: Fri, 31 May 2024 14:08:31 -0400
In-Reply-To: <CAHk-=wibjzPz+PQiBpbonJgcuMCUWj2hYtwNCdUF-D7+zSwLag@mail.gmail.com>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
	 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
	 <CAHk-=wibjzPz+PQiBpbonJgcuMCUWj2hYtwNCdUF-D7+zSwLag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 08:40 -0700, Linus Torvalds wrote:
> On Fri, 31 May 2024 at 06:05, Christian Brauner <brauner@kernel.org>
> wrote:
> >=20
> > Back in 2021 we already discussed removing deny_write_access() for
> > executables. Back then I was hesistant because I thought that this
> > might
> > cause issues in userspace. But even back then I had started taking
> > some
> > notes on what could potentially depend on this and I didn't come up
> > with
> > a lot so I've changed my mind and I would like to try this.
>=20
> Ack. Let's try it and see if anybody notices. Judging by past
> performance, nobody will, but...
>=20
> I still think we should strive to remove the underlying i_writecount
> entirely, but yes, even if we're eventually able to do that, it
> should
> be done in small steps, and this is the obvious first one.
>=20
>=20

FWIW: file leases also use i_writecount and i_readcount(...see
check_conflicting_open()), but they don't rely on the semantics for
blocking writes. They're just interested in whether the inode is open
for read or write anywhere.
--=20
Jeff Layton <jlayton@kernel.org>

