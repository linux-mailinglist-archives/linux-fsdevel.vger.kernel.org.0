Return-Path: <linux-fsdevel+bounces-46001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17417A811AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349E34E1208
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBC5230BFA;
	Tue,  8 Apr 2025 15:58:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE01E1C1F;
	Tue,  8 Apr 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127907; cv=none; b=AaUYmISbQnuz3s4Hcxhl+ca4UdJlbIkkBEYOyXwEILdShsPNIXCxQAvnulUhPFQb3rtcqLODEdRCK245ipTlpzVxytB27gMD5gGGR1yUM/6LL82j17hJGHuK+DAN0XAMZ/Zyk248Mkuk/dlrVqRCH0xspbI0a/j0+CO4Ub/YJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127907; c=relaxed/simple;
	bh=kQtV6n2Kqim1E4uFpTPCju+r1SQTshVBy2mcPORbT3I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ktcuss/EwCyOTHDQ0WmoTJlJ6a14Rr6dTiJmAi0WOcLNN3dQDsm5RRP8fGFrAWKyUoxmDhPsvxUelxvYjO9KwBe1sJCP8pVXJi/qT/KnsP6+GfS5bdAKk4jgWkbsg+aUUWUdoU0RwYj5CHrK8HSLnkzne4y3Tx6OTSeeS2HYmyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8170D29857F;
	Tue,  8 Apr 2025 17:58:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id mv9SRLM6fGTr; Tue,  8 Apr 2025 17:58:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 258E429858C;
	Tue,  8 Apr 2025 17:58:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lyA74G31QVcN; Tue,  8 Apr 2025 17:58:20 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id C6A5F29857F;
	Tue,  8 Apr 2025 17:58:20 +0200 (CEST)
Date: Tue, 8 Apr 2025 17:58:20 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, 
	Cengiz Can <cengiz.can@canonical.com>, 
	Attila Szasz <szasza.contact@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	lvc-patches@linuxtesting.org, dutyrok@altlinux.org, 
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com, 
	stable <stable@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <168561308.256760721.1744127900601.JavaMail.zimbra@nod.at>
In-Reply-To: <20250408145053.GJ6266@frogsfrogsfrogs>
References: <20241019191303.24048-1-kovalev@altlinux.org> <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh> <2025032404-important-average-9346@gregkh> <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc> <20250407-biegung-furor-e7313ca9d712@brauner> <20250407190814.GB6258@frogsfrogsfrogs> <CAFLxGvxH=4rHWu-44LSuWaGA_OB0FU0Eq4fedVTj3tf2D3NgYQ@mail.gmail.com> <20250408145053.GJ6266@frogsfrogsfrogs>
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in
 hfs_bnode_read_key
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF136 (Linux)/8.8.12_GA_3809)
Thread-Topic: hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Thread-Index: RB6CVOkT8Caj0B9BqKiFFs5kHooyAg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Darrick J. Wong" <djwong@kernel.org>
>> IMHO guestmount and other userspace filesystem implementations should
>> be the default
>> for such mounts.
>=20
> Agree.  I don't know if they (udisks upstream) have any good way to
> detect that a userspace filesystem driver is available for a given
> filesystem.  Individual fuse drivers don't seem to have a naming
> convention (fusefat, fuse2fs) though at least on Debian some of them
> seem to end up as /sbin/mount.fuse.$FSTYPE.
>=20
> guestmount seems to boot the running kernel in qemu and use that?  So I
> guess it's hard for guestmount itself even to tell you what formats it
> supports?  I'm probably just ignorant on that issue.

Yes, libguestfs runs a Linux kernel inside. It support qemu, UserModeLinux
and IIRC it had even a PoC for LKL (Linux Kernel Library).
That said, the performance is not optimal but I'm sure with reasonable
effort it could be improved at lot.
At least to work with odd filesystem in a satisfying way.

Thanks,
//richard

