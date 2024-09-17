Return-Path: <linux-fsdevel+bounces-29596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303097B3DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 20:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21F1B23EF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614E117DFF3;
	Tue, 17 Sep 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="N18yI4Tc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422845BEC;
	Tue, 17 Sep 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726596059; cv=pass; b=L8DW1k2w9iLdp98YJvpu+IbcX5Dbo/e8WNqD/hqVVYPI+CIlLZG+upIptqGtmGn+NDE8s2WPTBSPpin8uJ9afEbX06Z/tLYBzCzC542Qf3s9FWpWPnlI7NDqkMwAG0A6ZT/NPgglLppbZGmQg2Ya2efRYDi8Clu0Kb8q9fKW+hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726596059; c=relaxed/simple;
	bh=eKPPjW9EFfB/e0HtaRnZmVn/D9fkS4y0q3h8N75pzmw=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=r70zkSpAcFk9sO1o1Wa800LAk3f2+6rEU6jmGFasPQHlicqClSaCKu6ZENFb/W/gMMfdrWer1ETaG/mwRCBr8lSLs6xoVCXcHAFiAeEfKZmYyLdcb3Cqo38hmrgcExJ5zEMtaSgwMhARgGwMuikuVZeKOc0kBYuMLUEAW6E1HSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=N18yI4Tc; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <4bb2eee39bec0972377931aa8f4c280e@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1726595704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZifXv4tH2AMowpJIY3a0cqDosHbBcoPJ0cgxU1S6whg=;
	b=N18yI4TcO9neeR65/IHVynJ9Bg/cKB2p8xvhHHWOKVUkGsmO6yw71wBs/GJ1yZf/cn5RPB
	Oj3jJv0HTb3ZwAhMgg/JdlevxWZA4606y63JHARzCkQAPIUUDvUtL2LFEm4ZaKnOUnQkEA
	LNgr22wu0Xx+pBhdXFuzCZSCouOR6ERNc/r1OZeobBJ+9Omo0i98S7UiKpuNaRAx5uqb16
	4YK1gyp/E7SbVh2CB3D4XxQAV2cD2iLmPxxDx8u2cxE/AIpgc44V+3ixEynPmTiiiHeF/b
	6+u8L5o9wBT7xnwLQByRH0U/pwQUcSO/n4RTr2sj1TwHMmTRdnV9yN2S0Xzp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1726595704; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZifXv4tH2AMowpJIY3a0cqDosHbBcoPJ0cgxU1S6whg=;
	b=TpGlvZJJcW88BI2v7D+1mzGzLX2d8jNpjSVA+jMbMG57ep2QkLm0PNNVYIkwH29KDb/NAn
	8LqdORJBdXNTeyZaHdNk9a1Ziy/NUEKOeHP/ZuuO8VGAnFaAYJtwsEk6qVuNncmgM/zBdE
	kfKMtlgUDB9bAw9AYkv0eZPRyHiFwalnFcbLaDj3Wlo3l8AYkmUGhjBOcd8Mta+AlwBur6
	gipd5WhfUUKAFhrop2Rsit+oZwFDB9gJeYAbtqNYeJndWwZfeSkoxFtZGdEKEYaIOX5RvL
	a7wmmQtIXScZV5Rpqe2TlHea3SEn5+KX4En++ubxsWcTEg8W8CjpwgGzjhhz6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1726595704; a=rsa-sha256;
	cv=none;
	b=ffta3tcdXmgohNfSYh4Ruw9fXc7HFrag2S5Ufn5/zs3gAAVBMLSCbwmE7Qi9k1I57FlFFv
	ZJM/ifApNI1VsqNSXPyObg+gHyRVG0zXv2sAzeEy1qwV4QrsQyU60pj4/Gt8VTNziGXqmm
	TqlQifVKGpEwXDiwvpTH3InszgJM4xLHUIvI2lPwSeArvFv4EA6f+p6T18Bh3wddVqdu/v
	6hiH19gLzo71cf6zb3pZybtO3gIs+UCtOFfbqNOwY1mcveOjv5Ot8XwCIY6ttOlmMfsjRs
	10HHMgGUtMsnsTaRncYhfotbhZDoU38hiEdwiabwH2woDCvlt1VEhyO795gQ4Q==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
 Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, kernel test robot <oliver.sang@intel.com>, Jeff
 Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs, cifs: Fix mtime/ctime update for mmapped writes
In-Reply-To: <2106017.1726559668@warthog.procyon.org.uk>
References: <2106017.1726559668@warthog.procyon.org.uk>
Date: Tue, 17 Sep 2024 14:55:00 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> The cifs flag CIFS_INO_MODIFIED_ATTR, which indicates that the mtime and
> ctime need to be written back on close, got taken over by netfs as
> NETFS_ICTX_MODIFIED_ATTR to avoid the need to call a function pointer to
> set it.
>
> The flag gets set correctly on buffered writes, but doesn't get set by
> netfs_page_mkwrite(), leading to occasional failures in generic/080 and
> generic/215.
>
> Fix this by setting the flag in netfs_page_mkwrite().
>
> Fixes: 73425800ac94 ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409161629.98887b2-oliver.sang@intel.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/buffered_write.c |    1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>

