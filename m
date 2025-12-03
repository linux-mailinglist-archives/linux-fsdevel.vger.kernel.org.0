Return-Path: <linux-fsdevel+bounces-70608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4DFCA1DC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 23:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E102E3022AB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FBB2ED871;
	Wed,  3 Dec 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="Zp+mGmEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C92EC0A3;
	Wed,  3 Dec 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801974; cv=none; b=ASwekXKzQdUK9Rf6Wp59+4uJwsW0SMft3E66Cc2dypGhNuV62csEEvHKIxdvOeLUgSok+ZY0CPDipi0d4x9oHY/ccAusCdUYbB5xjohHl4JlbgmokxUvgu7gqsAO3STXAEri601mhdncLGvRvrAgJciJuekUDQKjErCo4lIT0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801974; c=relaxed/simple;
	bh=jsoXfke7nWgWt25b5LpNoRBJG2qxX8q8drGhal51bJI=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=SojFaGZBRPyBLTvVzL7hjaGVoKzPLvqh6qSGEHF00vqr9B3ex0M2ATDom0g8FGWxS+n4yVuCJrKzBLh06yLnAY1AFLW6fjkf2IYwQUru5Ps405IsQLhDX1d/sqr5PMCuQJiORrARc5s8sQQOroE4KF/e8cIQCQc8IAUrMYBwq80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=Zp+mGmEw; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jbKHBwK1Kk36uhEIJCJaZfECrwmWn1Jw2ygaQG6vjbY=; b=Zp+mGmEwVjbwE4CmM0e/0Jyh3s
	x4LVG078L/XJzOmeTtsKd0FbEZoamcWQ5dL3yu7mHhEelRKB6Wagg4y+pNo8IADj2mt/hOTUFXff6
	J1pfWbTSwQRdAKuTTQYulS6FVKWZkRxcM1y46eUF/Q9u6oq4wsDRpE1BnP9MiehpgNRVDT9Xu7Tia
	ZOyV8Y9vmucuqbj21rhWp1j/a6gzCfjMgU8QCXu3sR6IGSU0bWgersqDdqznAkifieUK22iXO8LmU
	xB58uWF1Q2TeZblOPQy1JZAfqmP1RgcZluBtqf6bIthp4p9Syj7CZND0dLYDZX2RgtfKXPjj8TGU5
	dYA1goJw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99)
	id 1vQvbr-00000000B1k-2nEt;
	Wed, 03 Dec 2025 19:46:07 -0300
Message-ID: <d519f5eb5d5072dca8a06c4e127b1a0c@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: dhowells@redhat.com, Shyam Prasad N <sprasad@microsoft.com>,
 linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix handling of a beyond-EOF DIO/unbuffered read
 over SMB2
In-Reply-To: <1961803.1764798927@warthog.procyon.org.uk>
References: <1597479.1764697506@warthog.procyon.org.uk>
 <1961803.1764798927@warthog.procyon.org.uk>
Date: Wed, 03 Dec 2025 19:46:07 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> If a DIO read or an unbuffered read request extends beyond the EOF, the
> server will return a short read and a status code indicating that EOF was
> hit, which gets translated to -ENODATA.  Note that the client does not cap
> the request at i_size, but asks for the amount requested in case there's a
> race on the server with a third party.
>
> Now, on the client side, the request will get split into multiple
> subrequests if rsize is smaller than the full request size.  A subrequest
> that starts before or at the EOF and returns short data up to the EOF will
> be correctly handled, with the NETFS_SREQ_HIT_EOF flag being set,
> indicating to netfslib that we can't read more.
>
> If a subrequest, however, starts after the EOF and not at it, HIT_EOF will
> not be flagged, its error will be set to -ENODATA and it will be abandoned.
> This will cause the request as a whole to fail with -ENODATA.
>
> Fix this by setting NETFS_SREQ_HIT_EOF on any subrequest that lies beyond
> the EOF marker.
>
> Fixes: 1da29f2c39b6 ("netfs, cifs: Fix handling of short DIO read")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

