Return-Path: <linux-fsdevel+bounces-16125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A6898BD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74053B236A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190112EBDC;
	Thu,  4 Apr 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="KlqV4cg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F912E1E8;
	Thu,  4 Apr 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246856; cv=pass; b=RpvX8g4Uy/jTAtyMf2DJjXpDgC/jj4uFEWDLnsJcD89FvAy965Pj+FEinjUQLcNrpoh31ghaZ94O2d/6OPFOHZGzMO9MjjntZ+IooPP1deG+bP6sHsUh/4D/HTFqIxF/EOkHYrk4u/Ib/5ro4L2N/TTt0zbJ/+MICtRKfTZmVVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246856; c=relaxed/simple;
	bh=LUFWgRFtjQZ49bnS25rMZ1qtgXnfmx0q15Zi6FSjpy8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=pnSCn6RM2DzaGK6Rqu/azCdHXHPOlXQgvuvjvLxfGG5CDnJE4WW1n748wyLlIxqn6fYJBBAzU/pndOLPB3xkqtV4e+Uc0Rx1Vp6dHuGlM89Stj7FAp/rGsRi5YIAZ0DfXqkrCbRsRrk0DYzH+KLrzwVuEvihvL4V5U2XCwXqPB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=KlqV4cg0; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1712246847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VfdAcUgMKKdIImznXQCsjzxihOdEcjXVNKwK2JA30Q=;
	b=KlqV4cg0zu0RMjPJ2+96XschbtCo+vwr0mHQpil0K68WGDUrHUMZ12SFTM9S1BaqjjBIx/
	EDwshMfEnj5+HudcR88Pd+PoK/32C0K5LZYosj9cm9gcnrosLu0R9G/tfchMknldVhDt6C
	wuzB1TfYgNcugCcGsMWhys6ABmzuh2SSMKXAP6/0v/ZjS9tcvwofC5gmlaHAYEl1pI46nf
	oQt/iOC7WOWRjJUqZDhSXkpNQ5jxexKcvgpwPS0WVgUrWI/A0nSPpKEMOjq4YQELdGJSIS
	yWikbG8PAoFVM7LNXaOMp23uO7cRJomjSxHn2R1dfCpOjwD7pJSkWZGaNWsFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1712246847; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VfdAcUgMKKdIImznXQCsjzxihOdEcjXVNKwK2JA30Q=;
	b=qzPWneXaxl526HZlYSdO9k7llZr6l9jznC3EaHDXdORExty5mLPf16WNWkEbAU3d8oczwA
	GFdn6D/faaCebfoZuASOIBhvfLwOcOfGFx2QoEanuQjqkwjoWPTUVXIw2MXi7ZiTsW8ER4
	FrGQxnWyzA+GA1xPOe6PRGpbSJNshzYrrinxQnNEJJ9rzWRLcYAKJjyQb87nqZPDWDq+JW
	lwlJh/PF6Nie3bu90aLsh+lmC90Jp9QU4Kome9fs+MW+TlrZr+92xseh9NpB0VcpkZAoHN
	Y3VmyIzi6zdbAdPKIVbbuOI/O+z/dMpJmriIn9aTCIsvzL2otGjovY1SByWZZQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1712246847; a=rsa-sha256;
	cv=none;
	b=Mv6xhiXFLzmVYcG110KOH5zMR9BCpHlX2HcZQJrkSUrOb0RFTLgNEdwWkSM6GO9KyvSNN+
	NXZRug3ua6MyoAAqSiG0+mO4sqqp29ZdTpqnLuqQNxktp/X5wRyUM+dgdxbF7KKebbmM02
	o1Uor6zQz7E5UrLWo5n8QJmKdxrb2SsqoKkHiUj9COBabZc+f4s+j6XMoEJe3+jWBEv1fF
	ElmeqtFCNr1tQfdxk1vrecvJbGL0cmI8wzZB2Lvjpb3NY/3tOcpAHPXMpErPSVzpllMgYb
	bCOLcgs5tc0Iehr+Ppzngf3z1zCZ9hTDEtsn95S4BzSv7+iE9SA4zF2dYFq+Ag==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: dhowells@redhat.com, Shyam Prasad N <sprasad@microsoft.com>,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live
 connection
In-Reply-To: <3756406.1712244064@warthog.procyon.org.uk>
References: <3756406.1712244064@warthog.procyon.org.uk>
Date: Thu, 04 Apr 2024 13:07:24 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Dave,

David Howells <dhowells@redhat.com> writes:

> During mount, cifs_mount_get_tcon() gets a tcon resource connection record
> and then attaches an fscache volume cookie to it.  However, it does this
> irrespective of whether or not the tcon returned from cifs_get_tcon() is a
> new record or one that's already in use.  This leads to a warning about a
> volume cookie collision and a leaked volume cookie because tcon->fscache
> gets reset.
>
> Fix this be adding a mutex and a "we've already tried this" flag and only
> doing it once for the lifetime of the tcon.

Can't we just move the cookie acquisition to cifs_get_tcon() before it
gets added to list @ses->tcon_list.  This way we'll guarantee that the
cookie is set only once for the new tcon.

Besides, do we want to share a tcon with two different superblocks that
have 'fsc' and 'nofsc', respectively?  If not, it would be better to fix
match_tcon() as well to handle such case.

> [!] Note: Looking at cifs_mount_get_tcon(), a more general solution may
> actually be required.  Reacquiring the volume cookie isn't the only thing
> that function does: it also partially reinitialises the tcon record without
> any locking - which may cause live filesystem ops already using the tcon
> through a previous mount to malfunction.

Agreed.

