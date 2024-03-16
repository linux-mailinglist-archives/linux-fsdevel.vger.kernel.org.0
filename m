Return-Path: <linux-fsdevel+bounces-14557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD887DAE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 17:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE41C20B92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385B1BF38;
	Sat, 16 Mar 2024 16:49:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9DB1BDCD;
	Sat, 16 Mar 2024 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.191.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710607798; cv=none; b=edjb5SYyozj1VXc3CwlwXAmGSAeZYg/BdxeMg9kgpLy3V4CVO1zNCaNItABgL2IgwCBevXJnHMAsJGEsrWkLIcsoNMzfOeHAsBzIrUDDxf5DLA8L2OIGpBD3MZSJaR7WmiRESutSs/sGX/CIB9V7ItCaSpzr8zvwAmWIAGB2mrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710607798; c=relaxed/simple;
	bh=yVxEpTE1C4x1uKjaL4iOmumcJXZB0hyN+asSRrnUtgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPW0YrWZ2I314lIVRUhS5wDVxyVkGuq5fczNTSKgQdpT0G+NMx4kVaY7P4kLIONcN6FLrwoZ7FsUo/Ode58uV6aondGZa07JOu7Ns9fMM91AgwZWxaHcoh/DY7ub1vsoY+UNZKKbLvN6GwDQfAmDLMgXIrsmy8gTM9u/YbLFs4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=194.150.191.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 9AD6D8C2492;
	Sat, 16 Mar 2024 17:49:52 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: bcachefs: do not run 6.7: upgrade to 6.8 immediately if you have a multi
 device fs
Date: Sat, 16 Mar 2024 17:49:52 +0100
Message-ID: <1962788.PYKUYFuaPT@lichtvoll.de>
In-Reply-To: <foqeflqjf7h2rz4ijmqvfawqzinni3asqtofs3kmdmupv4smtk@7j7mmfve6bti>
References:
 <muwlfryvafsskt2l2hgv3szwzjfn7cswmmnoka6zlpz2bxj6lh@ugceww4kv3jr>
 <4555054.LvFx2qVVIh@lichtvoll.de>
 <foqeflqjf7h2rz4ijmqvfawqzinni3asqtofs3kmdmupv4smtk@7j7mmfve6bti>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Kent Overstreet - 16.03.24, 17:41:08 CET:
> > > No need to recreate and repopulate - you just don't want to be going
> > > back to 6.7 from a newer version.
> >=20
> > Unfortunately I need to do exactly that, as 6.8.1 breaks hibernation
> > on ThinkPad T14 AMD Gen 1:
[=E2=80=A6]
> run this tree then:
>=20
> https://evilpiepirate.org/git/bcachefs.git/log/?h=3Dbcachefs-for-v6.7

Wonderful. Thanks! Compiling this one instead. Shall I report something to=
=20
you once I booted into it? I read you had difficulties getting those patche=
s=20
into stable.

It's 6.7.9, but there is no use for the Intel Atom mitigation in 6.7.10=20
for this laptop. So it will work perfectly.

=2D-=20
Martin



