Return-Path: <linux-fsdevel+bounces-71466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F9CC2704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9167308CF92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C90342511;
	Tue, 16 Dec 2025 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZLXdD7Nm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14A341AB8;
	Tue, 16 Dec 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884805; cv=none; b=Q/NiOJ+2im3jARe7QieGrudCGWrOrGAGvz7zkj1iGJzP16Kpj6SMFY6iKuCWby35IYVDEW+o09qYEUqbh2jcYpP5hbZy0RB4GYX8hIaeGQWHaIAEWdsoC3Tp5Fz+TjDlxhPDnB9wz7Jxd0uvdXe07/yXi3bPhSOMNw/kwtPu0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884805; c=relaxed/simple;
	bh=Sz9CRwUxNj13uZf09catC9Xh0CwQJZzFe94B5napAYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZyKAYz4wtrA6sX5jKG0Z1X2SGay1aGHVe0e2xOHRrpU33namQe252hSgazWPgHCUecXmqLhaL84AtPM9XxexZ4NIUqzRl7RYQnilSDZOlBk1BXPjt8M9M/qSVI/sJiGRBdkA2pS2KVw3r4DfE2bOIZtXrojU4N96ittpjnGR1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZLXdD7Nm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wFhJWGnB1cVGegbl1CTR6rHPJgkdnuIcEfCoCtQRfTg=; b=ZLXdD7NmoD3Kg75KrduoydQGhi
	MoJJZ+UILTcdNoqU/oQXbUrtTau+zEXqrV5c/jAXWqQGl9R0zeAuTnZGOVTBGB3ckVhAIEyXCCCCN
	8MKsMq3rw9FbPg8nEsIGlbjMOkHjprlz+miTnGm3orvlcbGnUNfe7yzgw7nj6azHVl1h7LFwJenYd
	T1/tj+Z8CWsYfGZSTcHBkRT/gjoFYkr9i5t0t7L8IKySLXK/bj14XIVCXcXnEeDeO0CT6jK1cCBWA
	S9pMyn99kjw5pGgKRw7w/eR6an0wt2QCvkcyb8YhwouIqS5WgbG/z5NXVs40SYNWMJNdtJfLMhvY+
	T0p3cXjQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVTIm-00DMei-Cr; Tue, 16 Dec 2025 12:33:12 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Bernd Schubert <bschubert@ddn.com>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
In-Reply-To: <CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_sksMj84xPPCMGQ@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 16 Dec 2025 11:19:28 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-4-luis@igalia.com>
	<CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_sksMj84xPPCMGQ@mail.gmail.com>
Date: Tue, 16 Dec 2025 11:33:12 +0000
Message-ID: <87pl8ed5l3.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16 2025, Miklos Szeredi wrote:

> On Fri, 12 Dec 2025 at 19:12, Luis Henriques <luis@igalia.com> wrote:
>>
>> This patch adds the initial infrastructure to implement the LOOKUP_HANDLE
>> operation.  It simply defines the new operation and the extra fuse_init_=
out
>> field to set the maximum handle size.
>
> Since we are introducing a new op, I'd consider switching to
> fuse_statx for the attributes.

So, just to clarify: you're suggesting that the maximum handle size should
instead be set using statx.  Which means that the first time the client
(kernel) needs to use this value it would emit a FUSE_STATX, and cache
that value for future use.  IIUC, this would also require a new mask
(STATX_MAX_HANDLE_SZ) to be added.  Did I got it right?

What would be the advantages of using statx?  Keeping the unused bytes in
struct fuse_init_out untouched?

Cheers,
--=20
Lu=C3=ADs

