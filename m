Return-Path: <linux-fsdevel+bounces-56505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE1B1800A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 12:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C067AED29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F3523371B;
	Fri,  1 Aug 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GCw54UNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E915C0;
	Fri,  1 Aug 2025 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043351; cv=none; b=VRUR/IRwegokQOIovgEUUR9+N/JcugAZFEb9u+tJ0DSXeFosQ39ieBHCvr+TTdehIcoARuVmXnRuxGFP86R3Q29m8b2mJHMk0VN7pU+5IC0FKjehqYebAwmKbD63o6RRm6guOuKpJqAKKtbgi6FKEGGLqnDRgj0wGV4fZjHtFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043351; c=relaxed/simple;
	bh=ImQxTp1iJ29lWKGzPsMU2DV+X4JRj4v4T6JVXO7/vyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JV1aliYHTUZq+U0+ifuyMe3pE2zU7JQgbGFKY5KMY4UeBLSqTnDggcjZmkoFGjxX7U+sI2ghkzYscm34WecKNOSHWCyed7SETAY6Ox0S3lIZQAvRCICHSRNUH+lUCd5KDBwYRvVOaM50dvozuiCJUejTz1MX79p0xdsVAqrDdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GCw54UNB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HDLzFV0w64w0DKyjH0FbiVLsM2SS4NNuyTADnNpFyag=; b=GCw54UNBda85MIyTRuSflNrO81
	DmPy82npLhJktPvRb4javXtFQckHOb5IRcgikim6A8VhV0NCAedtJqwwX5aTR82+16OEVmDj+H6hf
	nRzR8E1IsaDT25MuGJ3q0mW2FLRb/o8eziZgexZ8RM0IUhug6ObC8yajxN2mr/Ttl0k5dMDjK+QUL
	cZFm72ybD0N+tKPeMSt1LSPMRBza2lXOq1Dd/4PFSiGxry3/EyVnOBGWqK0jxRJ8rfKJaqXoNduPE
	vSIURZnpZ7P/iEeKlhqkrSN9ACGHbrSJ/4p61f1n4yQxbTYcmz/QKi02gb+muIzBjlml1riwdahLP
	826fuZsQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uhmnU-007DUX-8k; Fri, 01 Aug 2025 12:15:32 +0200
From: Luis Henriques <luis@igalia.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,  Miklos Szeredi <miklos@szeredi.hu>,
  Bernd Schubert <bschubert@ddn.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
In-Reply-To: <20250731173858.GE2672029@frogsfrogsfrogs> (Darrick J. Wong's
	message of "Thu, 31 Jul 2025 10:38:58 -0700")
References: <8734afp0ct.fsf@igalia.com>
	<20250729233854.GV2672029@frogsfrogsfrogs>
	<20250731130458.GE273706@mit.edu>
	<20250731173858.GE2672029@frogsfrogsfrogs>
Date: Fri, 01 Aug 2025 11:15:26 +0100
Message-ID: <8734abgxfl.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31 2025, Darrick J. Wong wrote:

> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
>> >=20
>> > Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
>> > could restart itself.  It's unclear if doing so will actually enable us
>> > to clear the condition that caused the failure in the first place, but=
 I
>> > suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
>> > aren't totally crazy.
>>=20
>> I'm trying to understand what the failure scenario is here.  Is this
>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
>> is supposed to happen with respect to open files, metadata and data
>> modifications which were in transit, etc.?  Sure, fuse2fs could run
>> e2fsck -fy, but if there are dirty inode on the system, that's going
>> potentally to be out of sync, right?
>>=20
>> What are the recovery semantics that we hope to be able to provide?
>
> <echoing what we said on the ext4 call this morning>
>
> With iomap, most of the dirty state is in the kernel, so I think the new
> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
> would initiate GETATTR requests on all the cached inodes to validate
> that they still exist; and then resend all the unacknowledged requests
> that were pending at the time.  It might be the case that you have to
> that in the reverse order; I only know enough about the design of fuse
> to suspect that to be true.
>
> Anyhow once those are complete, I think we can resume operations with
> the surviving inodes.  The ones that fail the GETATTR revalidation are
> fuse_make_bad'd, which effectively revokes them.

Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
but probably GETATTR is a better option.

So, are you currently working on any of this?  Are you implementing this
new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
look at fuse2fs too.

Cheers,
--=20
Lu=C3=ADs

> All of this of course relies on fuse2fs maintaining as little volatile
> state of its own as possible.  I think that means disabling the block
> cache in the unix io manager, and if we ever implemented delalloc then
> either we'd have to save the reservations somewhere or I guess you could
> immediately syncfs the whole filesystem to try to push all the dirty
> data to disk before we start allowing new free space allocations for new
> changes.
>
> --D
>
>>      	     	      		     	     - Ted
>>=20

