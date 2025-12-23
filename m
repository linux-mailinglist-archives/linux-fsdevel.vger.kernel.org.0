Return-Path: <linux-fsdevel+bounces-71984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13783CD9A67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 15:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E9D230213E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D9341AB1;
	Tue, 23 Dec 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ANo8Ppay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B732C954;
	Tue, 23 Dec 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500289; cv=none; b=JyugoK6xeJ6hmSHdkegDcgXdokOaPTrxAedIrBEMtL8Wq6rWA/P1h0pmtOQVPCn77BHKuOVoOGHYcb9hivYIWiqUbStR1o2k6OoN5yXqQwAF1XPz3JWu9XX0mi5QIgeURNt3K4IkHDhQ3FTUt+JZZ7p3l//y2duI5YUwhu67bjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500289; c=relaxed/simple;
	bh=ldNzDYQNfjNFqRt8ty7M4m0uQ2vpZlFHmbkenZYRZGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LdRtRasuD0VDJaziJhUGK4wyTcjGFL/Vp7TuEhvbxq+ae7oNpXqAyduPMuzRC+r1l20QgHNefBkK9XcXgNk2tW8jPgfnyPpkA6jcczE/qYQSyEgOEH/WBO3fWiy3gZppngYnIUzBOxNcwu8Pkyq4K+7QEdKjBPKo750+5bFdR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ANo8Ppay; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0/twY4Aes/4gS6FVt/apwkKgHj0mHMU+w1yjOsNwT5g=; b=ANo8PpaymKvuah+jhYMKN4jtXA
	pbnVf7+BihfKNRRonbXQk8vnSa8vO9EwNVQV/Ve0rExiolEtZz03ImTpi9RnGlEG4cP/T69pCc8zO
	UkauyJUBozyJbgp/dyIK2SIr61AspbMgayYh4yMrqHY7tt73MLLgM68rmBBB/QDjg4VHYWK9uWSny
	92+eXuTaPr44NIJTEYbdOz4DR61zUkZd1ZhqQFR2LnODQFRGISJWSYSrraXgBHiBDG7sdVjo2K7F2
	48ShDfs8t9Wv7Fb5D/VKCFhyUkTGEASCdiKWDbi8HcTtDxZdocmVnpRl3DtEKLLrCojVtxkqHRyOv
	C7bo4QNQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vY3Pv-00FuJO-9p; Tue, 23 Dec 2025 15:31:15 +0100
From: Luis Henriques <luis@igalia.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com
Subject: Re: [PATCH] fuse: add missing iput() in fuse_lookup() error path
In-Reply-To: <20251219221031.GZ1712166@ZenIV> (Al Viro's message of "Fri, 19
	Dec 2025 22:10:31 +0000")
References: <20251219174310.41703-1-luis@igalia.com>
	<20251219221031.GZ1712166@ZenIV>
Date: Tue, 23 Dec 2025 14:31:09 +0000
Message-ID: <87sed12rte.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19 2025, Al Viro wrote:

> On Fri, Dec 19, 2025 at 05:43:09PM +0000, Luis Henriques wrote:
>> The inode use count needs to be dropped in the fuse_lookup() error path,
>> when there's an error returned by d_splice_alias().
>>=20
>> (While there, remove extra white spaces before labels.)
>>=20
>> Fixes: 5835f3390e35 ("fuse: use d_materialise_unique()")
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>
> Have you actually looked at d_splice_alias()?
>
> It does consume inode reference in all cases, success or error.  On succe=
ss
> it gets transferred to dentry; on failure it is dropped.  That's quite
> deliberate, since it makes life much simplier for failure handling in the
> callers.
>
> If you can reproduce a leak there, I would like to see a reproducer.
> If not, I would say that your patch introduces a double-iput.
>
> NAK.

Totally deserved :-(

To be honest, while investigating this I remember finding the following in
d_obtain_alias() documentation:

  On successful return, the reference to the inode has been transferred
  to the dentry.  In case of an error the reference on the inode is release=
d.

Since d_splice_alias() didn't included that note explicitly, I (wrongly)
assumed it would *not* consume the reference.  Sure, I did had a look at
the function, but clearly not close enough.

Sorry for wasting your time, and thank you for the explanation.

Cheers,
--=20
Lu=C3=ADs

