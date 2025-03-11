Return-Path: <linux-fsdevel+bounces-43696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB3AA5BE8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA82118981EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F8252913;
	Tue, 11 Mar 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fY1ciEpn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE723F295;
	Tue, 11 Mar 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691336; cv=none; b=ErzuOR7SubhZazOowibtVidWI0z4T+ptCj0oO+Jc4V1tdyamtxNPGQeVvt42VpaXOWHN9mke5xWntm+4fBL8pCFwUbvk2RpWkvDJXC1mXJ5oDend1/80XlF3OZhl1FPHneUeXFLWl+AeBkGPuhSZ19q6wgMjdgswog37aafvzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691336; c=relaxed/simple;
	bh=6QPAKh6/UhudhOGiYP2Joig8dg3+yA0xnLYREG0IUt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+rva1ia8NEvSLfW7hXAqD9OwSKm161ReHMCv2yXROrlb7s/Wq4yswCWyFaWRmpj0MBwYK+j0reHIIYe2kr0etbbL0LyhpRnfBtAQsNYVY9knWZ4IDWEQRfLsPXNgsbbieEYTWyyUEygnaRIBz1U6rSJ6nkP+DJgbcn7d6AD0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fY1ciEpn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3Wt+6IsDowyHHy1LGGn9ikHPVWxsgvWGSYUv9JfpVDI=; b=fY1ciEpnYiwX9D3XxypCUl3njY
	8CUV4yWNxteb/xDBgteZB1ujY8A3qeBFWl+Th6KaSvAu6ML8+vtKMk0PnsEGCa9ae83ZSowB8Z3FS
	sNKZTMaYb6UworjgCzR8iYHnRYljsjgs+cJUj3xUG0s9cvHQDCwNvsMPkMN8Tci8oEx30BPscNoPj
	hrw68uKPQmwbdmqs0EuJHkuBw9PETWsHouX0NqiQXPpdkipEK1tqAWh1HbCPC7s6OmhxIMg3tGggK
	l1g1Uj1VjzPWfu0TtLl3VGw+q9FipdKbaEyLVdyFNsdGzMqQaGoVQT+ACpfGRiY9AFapfeHimYLvQ
	ZnvbArrQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1trxTK-0072PK-17; Tue, 11 Mar 2025 12:08:35 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,  Dave Chinner <david@fromorbit.com>,
  Matt Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
In-Reply-To: <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 10 Mar 2025 17:42:53 +0100")
References: <20250226091451.11899-1-luis@igalia.com>
	<87msdwrh72.fsf@igalia.com>
	<CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
Date: Tue, 11 Mar 2025 11:08:35 +0000
Message-ID: <87v7sfzux8.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

On Mon, Mar 10 2025, Miklos Szeredi wrote:

> On Fri, 7 Mar 2025 at 16:31, Luis Henriques <luis@igalia.com> wrote:
>
>> Any further feedback on this patch, or is it already OK for being merged?
>
> The patch looks okay.  I have ideas about improving the name, but that ca=
n wait.

Naming suggestions are always welcome!

> What I think is still needed is an actual use case with performance numbe=
rs.

Well, the use-case I had in mind is, as I mentioned before, CVMFS.  I
think this file system could benefit from using this mechanism.

However, I don't think that measuring the direct benefits is something
easily done.  At the moment, it uses a thread that tries to drain the
cache using the FUSE_NOTIFY_INVAL_{INODE,ENTRY} operations.  These are,
obviously, operations that are much more expensive than the proposed
FUSE_NOTIFY_INC_EPOCH.  But, on the other hand, they have *immediate*
effect while the new operation does not: without the call to
shrink_dcache_sb() it's effect can only be observed in the long run.

I can try to come up with some artificial test case for this, but
comparing these operations will always need to be done indirectly.  And I
wonder how useful that would be.

>> And what about the extra call to shrink_dcache_sb(), do you think that
>> would that be acceptable?  Maybe that could be conditional, by for examp=
le
>> setting a flag.
>
> My wish would be a more generic "garbage collection" mechanism that
> would collect stale cache entries and get rid of them in the
> background.  Doing that synchronously doesn't really make sense, IMO.

So, you're proposing something like having a workqueue that would walk
through the entries.  And this workqueue would be triggered when the epoch
is increased.

> But that can be done independently of this patch, obviously.

OK, cool!  I'm adding this to my TODO list, I can have a look into it once
we're done this patch.

Cheers,
--=20
Lu=C3=ADs

