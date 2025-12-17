Return-Path: <linux-fsdevel+bounces-71575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC84CC8BDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52D33092F01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB233B6E3;
	Wed, 17 Dec 2025 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hazkbBhg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B41A5B8B;
	Wed, 17 Dec 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988251; cv=none; b=nwMe7N2YV+pzecrsxyXQ6LOAk4lboOzmOQ0Yo2ngMCvSmIHY1kGp0ToBkRVIhYHrUR3Mu6u+SLBbp38J3L4RR5Pj/jVu+0jwrUkSexLpKT5dAe3YaH0Mjq8LSJAZ3noYIRkxxUaEIUL/EuSOZACx4Uwhvs+TOUajHo54mDujp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988251; c=relaxed/simple;
	bh=Op3Cj190mJQuH94g58Qa6mZ3F/sOl0yviWxZf3Knplc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BWYZPOAqcJN3quts6aFEBPx6muwhRLbhFHr8gt3ZiUhU4tkVDEOMEiZQ0eGqY4ryhE3fJl6/9gJIfZTNaZXZL3+lzONxsLxxldx/5KZlJtTLa/ruCOpfUcTP+xAbmIotNr2uLOMR84ONX9l84paRM3RZVs3RxnjyZN1ooMGbpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hazkbBhg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZRFkpaPMdRZ9efv9aG0zKJn+82TXTn6CIEMM1HGYC1s=; b=hazkbBhgTcpJ49EjcJg0H8cZMc
	JOoN4y9fyoTVOgLRnkDQyor1o0ylCRsPxlXuOKDgP9pXriB90o1vyWl7f6b+ZT+zzdedQVRizgRKu
	rp1ViuIJHkUOFZJEom1Y7D4JttN7ect6S06mXF0vjyarwu2G7hR9gTKqCym+YpYcrCL/c0S+Pjrpi
	nYieDGeVmrWulceKBkxzfmDTb+0V76PkDAkohojaHc2i/zNdA3dwUmVsl4Vzi+9a9Nhc/+PyvFkV9
	llUGa+nXycmM+0wTeO5dZihIKT0oBd9uoLFsVHbsCY7x8tIlWFCoNCtX7j75PA5gp884AiIN7BHAK
	Hk6P5GUQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVuDD-00Dv2e-1E; Wed, 17 Dec 2025 17:17:15 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Bernd Schubert <bschubert@ddn.com>,  Amir Goldstein
 <amir73il@gmail.com>,  Kevin Chen <kchen@ddn.com>,  Horst Birthelmer
 <hbirthelmer@ddn.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Matt Harvey <mharvey@jumptrading.com>,
  "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <CAJfpegsDL70SZVBKNcdUJcyuf+ifQGuMRy+p80ToUaQFL2aXag@mail.gmail.com>
	(Miklos Szeredi's message of "Wed, 17 Dec 2025 11:08:04 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<CAJnrk1aN4icSpL4XhVKAzySyVY+90xPG4cGfg7khQh-wXV+VaA@mail.gmail.com>
	<0427cbb9-f3f2-40e6-a03a-204c1798921d@ddn.com>
	<CAJnrk1a8nFhws6L61QSw21A4uR=67JSW+PyDF7jBH-YYFS8CEQ@mail.gmail.com>
	<20251217010046.GC7705@frogsfrogsfrogs>
	<CAJnrk1bVZDA9Q8u+9dpAySuaz+JDGdp9AcYyEMLe9zME35Y48g@mail.gmail.com>
	<87ike5xxbd.fsf@wotan.olymp>
	<CAJfpegsDL70SZVBKNcdUJcyuf+ifQGuMRy+p80ToUaQFL2aXag@mail.gmail.com>
Date: Wed, 17 Dec 2025 16:17:10 +0000
Message-ID: <87sed9ozg9.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17 2025, Miklos Szeredi wrote:

> On Wed, 17 Dec 2025 at 10:38, Luis Henriques <luis@igalia.com> wrote:
>
>> (A question that just appeared in my mind is whether the two lookup
>> operations should be exclusive, i.e. if the kernel should explicitly avo=
id
>> sending a LOOKUP to a server that implements LOOKUP_HANDLE and vice-vers=
a.
>> I _think_ the current implementation currently does this, but that was
>> mostly by accident.)
>
> Yes, I think LOOKUP_HANDLE should supersede LOOKUP.

Ack.

> Which begs the question: do we need nodeid and generation if file
> handles are used by the server?
>
> The generation is for guaranteeing uniqueness, and a file handle must
> also provide that property, so it is clearly superfluous.
>
> The nodeid is different.  It can be used as a temporary tag for easy
> lookup of a cached object (e.g. cast to a pointer).  Since it's
> temporary, it can't be embedded in the file handle.
>
> The direct cache reference can be replaced with a hash table lookup
> based on the file handle.  This would have an additional advantage,
> namely that the lifetime of objects in the user cache are not strictly
> synchronized with the kernel cache (FORGET completely omitted, or just
> a hint).

OK, this will require some more (or a lot more!) thinking from my side.
There are already several big(ish) suggestions I've started looking into,
and I need to go through them again.  Slowly ;-)

It's not clear to me at this point how to keep using nodeid+gen for
backward compatibility and replacing it by an hash table for the new
operation.  At first, it looks like a lot of code complexity will be
required for that.  But as I said, I'll need to go back and start
experimenting.

Other big change is to use fuse_ext_header instead of a variable size arg:
sounds interesting but will require more experimentation.  So, time for
going back to the drawing board!

Cheers,
--=20
Lu=C3=ADs

