Return-Path: <linux-fsdevel+bounces-71471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BE3CC2AEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 13:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0894431A802A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 12:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7913570DC;
	Tue, 16 Dec 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HUTZx0V2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E393570B0;
	Tue, 16 Dec 2025 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886549; cv=none; b=cZpTmfaZTsaViWYsiBrm/Rh0oxX+YCYjDbe/oLKgq7SafaD52e4FSWn6Yck7tzqNZc1PbDCUzffkc6jl+ajGWSnw+F2MjTEGgIDWWY2R/+MJzkbbXjrQKC50O6OOo9xpSv1ZUJZ0ZygIp2S74ZlqqwM/lpZiuL7o1Gvl9vjOEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886549; c=relaxed/simple;
	bh=kWmVjzJbflYYYfJyjioyZizFxQTMZX/xgN9efzJ8dZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q0mvualNq+UsZ5B6S/L9bx1iwEbi6EuRNKU4BdYsbqO5n/F2R3OtD/djfHKV2dMFduM+rlVzQ/ZJUDl9SIOd7OU46Wax0gNX+U4ZIYKGOyM8Y0NDJXaHEHJmsTvd+BcqHfrQJaHC1ZjdfMoeUciBHtRGltA+TtVWhdyhmu78eUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HUTZx0V2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PJYZVMcs/arHSwxVZZwQuj1IXRWxJY68PEX+DfaVYwA=; b=HUTZx0V28H+8OSkEX9Sfl6V3dw
	4cjiV4VJQQLW89mRPdRVsy4YBN86ZYwHhoW+yjE4Gp1w6fbdWbMOPJP6zT322SowTI7eoDYmQoGuF
	ZstciD18Y3ehHvUIn+ppE6iMX1Lhwqi5RtlX0UNiBQwLjZOL1CXFbVhKxdnWiIky8EQrpHph+68Vh
	XvD+VxnBiDWlz9dS9iXzwddaqmfGP/TLBGOzsBesfIKOteA2FF1sK1TiOi9xBRKGq9A0imZwfGj/M
	6KD9awCbM+S83rySV153KKAmT3y8VTDfl7cTV18955cpFbyDntXmRDATZhcm5S6G4LQ8tKk/JDNJ6
	0u8z7p4w==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVTkv-00DNDh-OH; Tue, 16 Dec 2025 13:02:17 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Bernd Schubert <bschubert@ddn.com>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
In-Reply-To: <CAJfpegt-0VDicWso6ZjsFyawuKj8Xf4qwTEth00CdAd-pUNcjQ@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 16 Dec 2025 12:46:54 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-4-luis@igalia.com>
	<CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_sksMj84xPPCMGQ@mail.gmail.com>
	<87pl8ed5l3.fsf@wotan.olymp>
	<CAJfpegt-0VDicWso6ZjsFyawuKj8Xf4qwTEth00CdAd-pUNcjQ@mail.gmail.com>
Date: Tue, 16 Dec 2025 12:02:12 +0000
Message-ID: <87ecoud48r.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16 2025, Miklos Szeredi wrote:

> On Tue, 16 Dec 2025 at 12:33, Luis Henriques <luis@igalia.com> wrote:
>>
>> On Tue, Dec 16 2025, Miklos Szeredi wrote:
>>
>> > On Fri, 12 Dec 2025 at 19:12, Luis Henriques <luis@igalia.com> wrote:
>> >>
>> >> This patch adds the initial infrastructure to implement the LOOKUP_HA=
NDLE
>> >> operation.  It simply defines the new operation and the extra fuse_in=
it_out
>> >> field to set the maximum handle size.
>> >
>> > Since we are introducing a new op, I'd consider switching to
>> > fuse_statx for the attributes.
>>
>> So, just to clarify: you're suggesting that the maximum handle size shou=
ld
>> instead be set using statx.  Which means that the first time the client
>> (kernel) needs to use this value it would emit a FUSE_STATX, and cache
>> that value for future use.  IIUC, this would also require a new mask
>> (STATX_MAX_HANDLE_SZ) to be added.  Did I got it right?
>
> No, using statx as the output of LOOKUP_HANDLE is independent from the
> other suggestion.
>
>> What would be the advantages of using statx?  Keeping the unused bytes in
>> struct fuse_init_out untouched?
>
> Using fuse_statx instead of fuse_attr would allow btime (and other
> attributes added to statx in the future) to be initialized on lookup.

Oh! Of course, I totally misunderstood your suggestion.  Right, creating a
new *_out struct probably makes sense.  Something like a mix between
fuse_entry_out and fuse_statx_out.

Cheers,
--=20
Lu=C3=ADs

