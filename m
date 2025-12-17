Return-Path: <linux-fsdevel+bounces-71577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E17CC8F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 18:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8308300BE69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFFA33A9E3;
	Wed, 17 Dec 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ql6KCuK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E132D663E;
	Wed, 17 Dec 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990991; cv=none; b=s14QECF1cdnud/7osFjtGgwj0eWn9SobfVZ9nw5pdUT0mTPcR9RtMiQ4GupiQmfkFRJyRj17g8LNJVFE88sigW2hRdzoQsNPJSWeXy+8FGl0Pi9gUUxUDTxUc0h8v2Bs5ETLCcSs4zH5henppQN7Wz6VOmQg03Mb2dLi14mUkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990991; c=relaxed/simple;
	bh=fpMT0wLq/t3XGakqK8qCUMkE97fU8nA7avKnISC1xZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+4R6dRKJUvt2NUC9qcpp8wlDnspqUFpjpnKpf6wdxglvIcvv9FStwyBROwrChcloZe+gkKR7qvgbzUFUcTlHycg2utRvGncGOfeYVUu0MWyJn4jdHdSPinxRKkUrNPXN2nLa50K/+0py4EaJUMArHtP+hDt20bq2HSZpnKzQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ql6KCuK/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eXBf49DUa2aK/vl2TUAfcs9TVtTDGlcPm7CWRwkSKT8=; b=ql6KCuK/A6Jv/FpmGEx3VlbBvc
	aIu1jl0e2Z/S2OhqU9hEHAIlhGU+V8tQeiRQLPmzMiWl9iBWYh6SYrcl/iprzKW3UuRxFnVsmPVHr
	Xbn/GIA9bOEKRxldHifqU08xI6H3qIsv1TiXpggICTIIsIG3BlE0R9PPSJ4mEHzdPjB/uzqzfIebB
	vlq74kSZDiSVO9EMV8fSKwJtbJXd4f/Lqt1YGds5Q4CKEfWDbickIR9nXdtJpbHkrSe95TallNdwr
	mIEanjmBtMHK9+u0czYsLTtBHD5+y5TrSvfyEcA14WVeTiXZrFYhTUp3aXsz2AnJmTG86zRP1C1fA
	NdtFEDAw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVuvU-00Dw2Y-30; Wed, 17 Dec 2025 18:03:00 +0100
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  "Darrick J. Wong" <djwong@kernel.org>,  Bernd
 Schubert <bschubert@ddn.com>,  Kevin Chen <kchen@ddn.com>,  Horst
 Birthelmer <hbirthelmer@ddn.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>,
  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 6/6] fuse: implementation of export_operations
 with FUSE_LOOKUP_HANDLE
In-Reply-To: <b3ygfin4h2v64fs2cup2fu5pux7skm7nby7nhostqo7ejgbw2r@zvr6yre5vr57>
	(Horst Birthelmer's message of "Tue, 16 Dec 2025 21:12:46 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-7-luis@igalia.com>
	<CAJfpegu8-ddQeE9nnY5NH64KQHzr1Zfb=187Pb2uw14oTEPdOw@mail.gmail.com>
	<874ipqcq5q.fsf@wotan.olymp>
	<b3ygfin4h2v64fs2cup2fu5pux7skm7nby7nhostqo7ejgbw2r@zvr6yre5vr57>
Date: Wed, 17 Dec 2025 17:02:59 +0000
Message-ID: <87jyyloxbw.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16 2025, Horst Birthelmer wrote:

> On Tue, Dec 16, 2025 at 05:06:25PM +0000, Luis Henriques wrote:
>> On Tue, Dec 16 2025, Miklos Szeredi wrote:
> ...
>> >
>> > I think it should be either
>> >
>> >   - encode nodeid + generation (backward compatibility),
>> >
>> >   - or encode file handle for servers that support it
>> >
>> > but not both.
>>=20
>> OK, in fact v1 was trying to do something like that, by defining the
>> handle with this:
>>=20
>> struct fuse_inode_handle {
>> 	u32 type;
>> 	union {
>> 		struct {
>> 			u64 nodeid;
>> 			u32 generation;
>> 		};
>> 		struct fuse_file_handle fh;
>> 	};
>> };
>>=20
>> (The 'type' is likely to be useless, as we know if the server supports fh
>> or not.)
>>=20
>> > Which means that fuse_iget() must be able to search the cache based on
>> > the handle as well, but that should not be too difficult to implement
>> > (need to hash the file handle).
>>=20
>> Right, I didn't got that far in v1.  I'll see what I can come up to.
>> Doing memcmp()s would definitely be too expensive, so using hashes is the
>> only way I guess.
>>=20
> Please excuse my ignorance, but why would memcmp() be too expensive for a=
 proof of concept?
> Inode handles are limited and the cache is somewhat limited.

(Oops, looks like I missed your email.)

So, if every time we're looking for a file handle we need to memcmp() it
with all the handles until we find it (or not!), that would easily be very
expensive if we have a lot of handles cached.  That's what I meant in my
reply, comparing this with an hash-based lookup.

(Not sure I answered your question, as I may have also misunderstood
Miklos suggestions.  It happens quite often!  Just read my replies in this
patchset :-) )

Cheers,
--=20
Lu=C3=ADs

