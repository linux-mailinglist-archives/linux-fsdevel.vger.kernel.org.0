Return-Path: <linux-fsdevel+bounces-73073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB1D0B920
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F657301D6AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 17:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F3CDDAB;
	Fri,  9 Jan 2026 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Yrj0H7vh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C735A926;
	Fri,  9 Jan 2026 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978981; cv=none; b=id7SNMhhCYNRqiBz+lrzRoZshpAokegHCBv+ndc97KFXaKa3tEm2XbwQdoOOanuoCrvEn+epBccyeOWeYbI2288A5GzNSdz8ND+CqsptedfRrLNLJy9oMTttH77BFujs7fpx37kUJ3YWezxCGRtfGiOlhwWI15qfLBb8uBAPVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978981; c=relaxed/simple;
	bh=ArAQ5ZiqCESPPsVWz+uaRx+FMRwyB7pAC2WKR8mtv7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sV/2uld68ojRPi8mo3SjjQW4IPD7txP9gbVqrWPQsBYRih8aDs7r8PGd8iyxPz1vuV9KnC9vBLIYyj0T+VXwCivodCLhtjFj/yu9J0HxQMjf/W8P2SW7g01YRCta7q+TZQHe5jZWYCkMK7EWt0oTo4nC69kJ0Nk0Yc3xYc6mxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Yrj0H7vh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5ZKww+Iwebeo8GFNHGn28wnzILsOtOLDWG3uxLZcZr4=; b=Yrj0H7vhb9o6oPMneIfWOkn/zA
	OzM1geJ6VQZQbbZOxIgiYO0n2VZZYM997wCRAglkpMNL//Qj2+snzaxs81qYGJPGs9OFDqYT1AORL
	afFkIMW1e1G6FJksaU0Xei2bGYRDwVzifGJhkJAWGc+FCu93I67DvMvykTKyKLg63ddfZGSNcVRTq
	OtTAtMEOfnWBpAz9noXDVuqR/SOy061JEwVIwa7iKCKPhOS2VyfNrq5ZotQWdQ+A0TNBnaMH02hMk
	t8ZWstkD+h1+V1uyt5QHKc+Bj1uPCGk5MKRDa8HX5x2zPOYvocBrSoNCG5qtp4iGMeVBIPXEma3Au
	szokb/BQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1veG5o-003VU4-B5; Fri, 09 Jan 2026 18:16:08 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,  Amir Goldstein
 <amir73il@gmail.com>,  "Darrick J. Wong" <djwong@kernel.org>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <CAJfpegvxLqpa0ttnEjY1W1Oqf5vpw3uKrrf8y5DdnuXcnQJzNg@mail.gmail.com>
	(Miklos Szeredi's message of "Fri, 9 Jan 2026 17:28:30 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
	<87zf6nov6c.fsf@wotan.olymp>
	<CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
	<CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
	<CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
	<b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
	<CAJfpegvxLqpa0ttnEjY1W1Oqf5vpw3uKrrf8y5DdnuXcnQJzNg@mail.gmail.com>
Date: Fri, 09 Jan 2026 17:16:07 +0000
Message-ID: <87ldi64sh4.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09 2026, Miklos Szeredi wrote:

> On Fri, 9 Jan 2026 at 16:56, Bernd Schubert <bschubert@ddn.com> wrote:
>
>> Feasible, but we should extend io-uring to FUSE_NOTIFY first, otherwise
>> this will have a painful overhead.
>
> We don't want to do the lock/add/unlock for individual dentries
> anyway, so might as well make this FUSE_NOTIFY_ENTRIES.  That would
> lock the directory, add a bunch of dentries, then unlock.
>
> The fun part is that locking the directory must not be done from the
> READDIR context, as rwsem read locks are apparently not nestable.
> This would make the interface a pain to use.  We could work around
> that by checking if a READDIR is currently in progress and then
> synchronizing the two such that the entries are added with the
> directory lock held.   It's a bit of complexity, but maybe worth it as
> it's going to be the common usage.

Yikes!  Things are not getting any simpler :-(

OK, looks like there's a lot of things I'll need to figure out before
proceeding.

/me schedules some time to learn and play a bit with all this.

Cheers,
--=20
Lu=C3=ADs

