Return-Path: <linux-fsdevel+bounces-69071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E538CC6DD7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A16EA2D975
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD53446D5;
	Wed, 19 Nov 2025 09:57:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CB33C503;
	Wed, 19 Nov 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546222; cv=none; b=Wm9Hqat8Rp8oAEvha4nwar91gZuzQg/27WEldwy55zVlgSc0ibPCzjcb7dCe6Lb1kYvatJkN58HfDRYLmPo3ubc5Vme66Mm4iFM7r/j7fXEtlzirjUZTvcF1/AgmqNVxVuYjZCobFbBjBeN/f4oQiLyIEdCxZjE2Eg3ByKPBDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546222; c=relaxed/simple;
	bh=S782cekPPBYFMzmJw77Amv/M3nrXk3xRb2V1efGBGng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmfHNlTCMEeam+mkm1FmDEFOISCz8/Sr5q++3r775HPB3IKlS9WFDKv5s8ONTZ+avvdGyAxxgFmu4AJJOPC4WNz5IHrtN7GQ3IrWq3pHdiJATIy+uWodPwV9PSPWzWWN4JBPkSaOY84uTJ/AgMP7ddLAud8CGylTstblHCIKL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51FB068BEB; Wed, 19 Nov 2025 10:56:55 +0100 (CET)
Date: Wed, 19 Nov 2025 10:56:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
	neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are
 multiple layout conflicts
Message-ID: <20251119095654.GC25764@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-4-dai.ngo@oracle.com> <967cc3ea-a764-4acf-b438-94a605611d86@oracle.com> <e43b83f1-cc9f-41b6-b659-bb6cf82f7345@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e43b83f1-cc9f-41b6-b659-bb6cf82f7345@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 15, 2025 at 12:20:43PM -0800, Dai Ngo wrote:
> break_lease is called from many places - the NFS client and server,
> CIFS and VFS. Many of these callers do not handle error returned
> from break_lease, some don't even check return value from break_lease.
>
> Until we fix all callers of break_lease to handle error return, which
> I think it's much more involved, returning error from break_lease is
> not possible.

There is about a dozen callers.  Although some might not want to handle
this error, having a flags argument to opt into for the callers that
can and want is entirely reasonable.

> I have plan to post a separate patch to check for layout conflict
> caused from the same client and skip the recall - same as what's
> currently done for delegation conflict.

That would be very useful.


