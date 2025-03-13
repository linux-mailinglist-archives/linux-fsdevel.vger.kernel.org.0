Return-Path: <linux-fsdevel+bounces-43891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C680A5F248
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 12:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03E617CCA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5A2661A5;
	Thu, 13 Mar 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DcVzWZ5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98430265CAB;
	Thu, 13 Mar 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865128; cv=none; b=BbmgOP3e+bNwFkOv3gnfd+XGuR8X4bEigLNOAwTiGOugTNElXs/RIiA3yaL44Y4APUoQ3702/oPjLEnzXYnt5e4Kcdm3DTAoXHGojfhsESqOBLj0dpk2Szrlk4eVSc2jRMcx3BvjHapWw3ULrC+mLf5ojfTgIiuYVWnJH+PWyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865128; c=relaxed/simple;
	bh=lpdT6EuS/H1sa1OQ6p60/cl6fo3TSDytyl+T2mRRsXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IsR5ZEsaR5yqLLhN8mnmUjRp2jIZeQLBDGIX5XdSYVVP1t6bhDa3zjC7CxrhtkpaRn33tbAmsjEvRdL+0MW66McKZnGp7O0E/3SQVCEu6mer6ni+5VCpF20scZCgsozfOdlsNnUzRqmFCJTYkrG+zf1hzz4vy8r5R4UHmvFT6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DcVzWZ5D; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/SunrS3w6dQfvYQsXSmakzUccOtFtCfoI+mtBuq8dl0=; b=DcVzWZ5DJmMEbLWRixu2GEZx3E
	QR2XIfCih+w+8N0ydGXfwYHplq7Qg8Cnfc8xk+w6a9TbkRUJyfzqgoATygQexnYaOqCiSmWv6tlAP
	OwLGW1ktcqFh6AyjpvCeu3HIKOpDbpUqi9+F1U6HNsnSIfT6JhuANxfyTY3R6Wlh3GpuWYSUSQdbS
	vouPJg0MfBwGTNIqalz0jWqLYNyM9MqHmfKB8H9Kw8GXg7soc/Uh+28zzTGK6EreT/mvfny0+tzXf
	RS7s+T21MN0WNGgt+C+CGkBwbPei9SYIetdyn3XnnFjqS3+BCFiF9Csch1lnKMW6zapn/fipcB1WC
	BFbiXF6A==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tsggU-0084OU-SL; Thu, 13 Mar 2025 12:25:12 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,  Dave Chinner <david@fromorbit.com>,
  Matt Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
In-Reply-To: <CAJfpegvxp6Ah3Br9XUmnz_E5KwfOTC44JTa_Sjt0WGt8cAZKEg@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 13 Mar 2025 11:32:04 +0100")
References: <20250226091451.11899-1-luis@igalia.com>
	<87msdwrh72.fsf@igalia.com>
	<CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
	<87v7sfzux8.fsf@igalia.com>
	<CAJfpegvxp6Ah3Br9XUmnz_E5KwfOTC44JTa_Sjt0WGt8cAZKEg@mail.gmail.com>
Date: Thu, 13 Mar 2025 11:25:06 +0000
Message-ID: <875xkdfa0d.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13 2025, Miklos Szeredi wrote:

> On Tue, 11 Mar 2025 at 12:08, Luis Henriques <luis@igalia.com> wrote:
>
>> Well, the use-case I had in mind is, as I mentioned before, CVMFS.  I
>> think this file system could benefit from using this mechanism.
>
> We need more than just a hunch that this will work.  Having code out
> there that actually uses the new feature is a hard requirement.
>
> It does not need to be actually committed to the cvmfs repo, but some
> indication that the code will be accepted by the maintainers once the
> kernel part is upstream is needed.

OK, makes sense.  I do have a local cvmfs patch to use this new
notification.  For now it's just a hack to replace the current code.  It
has to be cleaned-up so that it uses FUSE_NOTIFY_INC_EPOCH only when it's
available in libfuse.  My plan was to do this only after the kernel patch
was merged, but I can try to share an earlier version of it.

>> However, I don't think that measuring the direct benefits is something
>> easily done.  At the moment, it uses a thread that tries to drain the
>> cache using the FUSE_NOTIFY_INVAL_{INODE,ENTRY} operations.  These are,
>> obviously, operations that are much more expensive than the proposed
>> FUSE_NOTIFY_INC_EPOCH.  But, on the other hand, they have *immediate*
>> effect while the new operation does not: without the call to
>> shrink_dcache_sb() it's effect can only be observed in the long run.
>
> How so?  Isn't the advantage of FUSE_NOTIFY_INC_EPOCH that it spares
> the server of having to send out FUSE_NOTIFY_INVAL_ENTRY for *all* of
> the currently looked up dentries?

Well, I guess I misunderstood you.  I can use my hacked cvmfs to measure
the improvement of removing this loop and replace it with a single
FUSE_NOTIFY_INC_EPOCH.  Obviously, the performance improvements will
depend on how many dentries were cached.

>> I can try to come up with some artificial test case for this, but
>> comparing these operations will always need to be done indirectly.  And I
>> wonder how useful that would be.
>
> Any test is better than no test.
>
>> So, you're proposing something like having a workqueue that would walk
>> through the entries.  And this workqueue would be triggered when the epo=
ch
>> is increased.
>
> Not just.  Also should periodically clean up expired dentries.

Hmmm... And would you like this to be done in fuse?  Or do you expect this
to me a more generic mechanism in dcache, available for other filesystems
as well?

Cheers,
--=20
Lu=C3=ADs

