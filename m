Return-Path: <linux-fsdevel+bounces-45284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3070A75855
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 04:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C9F7A4DEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 02:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7EB288BA;
	Sun, 30 Mar 2025 02:05:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A42594;
	Sun, 30 Mar 2025 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743300354; cv=none; b=FNL2HhpjKRo8zNHLvr3GWoOkrDY2r4RdTXIo0raqqQuF8x+noMHTUqBuX0ouv8dsOlQbpj7ciaDFbA+HAhTNIGk00o9rO2fREAVnD/DzYHGvESUhjUoPBBcIqqERI52mbAtztT/kBs1p5XqHr3EF4ap7ovfHlufs7m9Tohd2i9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743300354; c=relaxed/simple;
	bh=h5eblBkeQPp3yr4CoLpcNqIK5ZT10dlT1isVczh0PZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rr7AwtUzSeCzKJxVATRzthy27XrWgg/QbYcJo1YNNOZve3Vxj6kmHlnBKlZuKDKbN9SRJmy3ozYCh4XafPRx8v5dy8RE1zpnvUJMTrsZQjLCRoRN/gfb2UPy5hksKo3l/e0seTlcM6RwJOLY56eDBwMO2w2ekgwijUdsYOFgS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tyi3K-000000001y7-0Ilg;
	Sat, 29 Mar 2025 22:05:34 -0400
Message-ID: <2ccb9f828ea392eb22f8deb7d9644a4575fa9ee5.camel@surriel.com>
Subject: Re: [syzbot] [mm?] [fs?] BUG: sleeping function called from invalid
 context in folio_mc_copy
From: Rik van Riel <riel@surriel.com>
To: Luis Chamberlain <mcgrof@kernel.org>, syzbot	
 <syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com>, Jan Kara
 <jack@suse.cz>,  Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, hare@suse.de, joel.granados@kernel.org, 
	john.g.garry@oracle.com, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Date: Sat, 29 Mar 2025 22:05:34 -0400
In-Reply-To: <Z-XGWGKJJThjtsXM@bombadil.infradead.org>
References: <67e57c41.050a0220.2f068f.0033.GAE@google.com>
	 <Z-XGWGKJJThjtsXM@bombadil.infradead.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2025-03-27 at 14:42 -0700, Luis Chamberlain wrote:
> On Thu, Mar 27, 2025 at 09:26:41AM -0700, syzbot wrote:
> > Hello,
>=20
> Thanks, this is a known issue and we're having a hard time
> reproducing [0].
>=20
> > C reproducer:=C2=A0=C2=A0
> > https://syzkaller.appspot.com/x/repro.c?x=3D152d4de4580000
>=20
> Thanks! Sadly this has not yet been able to let me reprodouce the
> issue,
> and so we're trying to come up with other ways to test the imminent
> spin
> lock + sleep on buffer_migrate_folio_norefs() path different ways
> now,
> including a new fstests [1] but no luck yet.

The backtrace in the report seems to make the cause
of the bug fairly clear, though.

The function folio_mc_copy() can sleep.

The function __buffer_migrate_folio() calls
filemap_migrate_folio() with a spinlock held.

That function eventually calls folio_mc_copy():

 __might_resched+0x5d4/0x780 kernel/sched/core.c:8764
 folio_mc_copy+0x13c/0x1d0 mm/util.c:742
 __migrate_folio mm/migrate.c:758 [inline]
 filemap_migrate_folio+0xb4/0x4c0 mm/migrate.c:943
 __buffer_migrate_folio+0x3ec/0x5d0 mm/migrate.c:874
 move_to_new_folio+0x2ac/0xc20 mm/migrate.c:1050
 migrate_folio_move mm/migrate.c:1358 [inline]
 migrate_folios_move mm/migrate.c:1710 [inline]

The big question is how to safely release the
spinlock in __buffer_migrate_folio() before calling
filemap_migrate_folio()

--=20
All Rights Reversed.

