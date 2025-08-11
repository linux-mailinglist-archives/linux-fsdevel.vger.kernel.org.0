Return-Path: <linux-fsdevel+bounces-57399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F0B21293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7BF175693
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17A29BDA3;
	Mon, 11 Aug 2025 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b="GOnLP2YI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hope.aquinas.su (hope.aquinas.su [82.148.24.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C232475F7;
	Mon, 11 Aug 2025 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.148.24.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930937; cv=none; b=r6QMKKJUdXQo5DIG6watXvqotrMOtVKRGykwwz6W0cdMMn73VXumCpJ8QxeaH67zpvGiSl0ZZd2VcHi9f+eNY5EqteecgZ5TYASbwTogSkkXcGIYXLwAfBE/fLzvyJlWl5wZbikCy6ODF7CGOQK1jsZzL5zcvYRix/RKLitHbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930937; c=relaxed/simple;
	bh=LGCt325F09xhWzyUVCNeUGVbkFuJRenLZLO7XVdurNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZVNxPPT+HjP9G3+sy7zO/K6tKM2xQmwAWXAtTIsMwhzSqddhR3aEymQmcCT7cOv6KYz94tljrfoj11gz8dsxLOQuyODo/4RJ5yJIJ2q9utO7lsITYpqZ78PhPIv061v7v5uagdqDmSqjXuf58Hskl27z9xlmF+ZVD5+uaxeCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su; spf=pass smtp.mailfrom=aquinas.su; dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b=GOnLP2YI; arc=none smtp.client-ip=82.148.24.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aquinas.su
Received: from woolf.localnet (host-46-241-65-133.bbcustomer.zsttk.net [46.241.65.133])
	(Authenticated sender: admin@aquinas.su)
	by hope.aquinas.su (Postfix) with ESMTPSA id 88D4E6EBB9;
	Mon, 11 Aug 2025 19:48:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aquinas.su; s=default;
	t=1754930933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGCt325F09xhWzyUVCNeUGVbkFuJRenLZLO7XVdurNc=;
	b=GOnLP2YIHOppkSHTJKhMGU/aDYfgA1iTCXY+uX5kJDRZrm77T8mQ+vRWMIdqLT0J8os3mJ
	e+1SNQPhO+wZ2CATcVr0BMH41YAgxjR+N93u46P4MNxazjvuubDb7jpIRmKXJyBjcZwhS0
	evloaRuWGGz6r37ZSV1MlRJCBZTm+7rXwcUAct0L1EL7pqBr0OdgWVUNxKEKXPVDUGuBR3
	LVCKgT2ULI/lwset+fDQs8DcLNpJA6RL0CeXPJTL6RcneEY63WirwV0FZ8s5cVTT5XzTJf
	2hKX+ve1LQ18Zw3m+ePI7zHLB+7ORrrG6YLDFsJtUe4VGzeeXLdzGivLux63fQ==
Authentication-Results: hope.aquinas.su;
	auth=pass smtp.auth=admin@aquinas.su smtp.mailfrom=admin@aquinas.su
From: Aquinas Admin <admin@aquinas.su>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Sasha Levin <sashal@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>,
 Malte =?UTF-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Mon, 11 Aug 2025 23:48:51 +0700
Message-ID: <10702976.nUPlyArG6x@woolf>
In-Reply-To: <aJgaiFS3aAEEd78W@lappy>
References:
 <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
 <aJgaiFS3aAEEd78W@lappy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

>=20
> The kernel has thrived for over 30 years not just because of technical
> excellence, but because it has (mostly) maintained a collaborative
> environment where developers can work together despite disagreements.
> That collaborative environment IS doing right by users.
>=20
Come on? It's been around for 30 years because it's financially beneficial =
for=20
some players. Should we forget about the letters and insults that flew arou=
nd=20
before 2018? The Code of Conduct wasn't introduced just like that. Well,=20
that's just a small remark, in general. The fact is, there are no objection=
s=20
to the technical quality of Bcachefs. The objections are exclusively about=
=20
Kent's personality and how he conducts his affairs. Maybe someone experienc=
ed=20
in resolving such issues and handling personnel conflicts could suggest a=20
solution? Analyze the situation and offer methods for resolution? Especiall=
y=20
since the problem is far from being solely about Kent. I suggest that inste=
ad=20
of threats, hasty conclusions, and quick decisions, we turn to professional=
s=20
with the right expertise, who are surely present in the Linux Foundation. I=
t=20
will take time, but it will help everyone become better. I hope everyone=20
understands that the right solution shouldn't be dictated by someone's=20
feelings or grudges=E2=80=94regardless of who's involved.



