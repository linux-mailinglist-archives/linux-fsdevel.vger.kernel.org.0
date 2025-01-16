Return-Path: <linux-fsdevel+bounces-39405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC43A13AFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F557A23EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09B022A4F6;
	Thu, 16 Jan 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AynfpHwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452111DE4DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034642; cv=none; b=FlwNz8pUDL2/iXtFy0rnDN/dkF4PulJn7IRlzW8fiCN9iwqEVcbL7+H8WKwZ6wIgDoee+5hlGi0hEkO8qttniZPBqQ5fB7jtZw8Hc9XXCbw0Ue2w+XrGZTKQOC97kgjfEg3zSemhZm2pGYZz6sI4Nhxl0OXQlRK/7JI8PtEXeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034642; c=relaxed/simple;
	bh=ZiNS1BCtrlJJD19+3tT1FGgiaUDCjgZLTs/9T2Us6Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIMg9QAdXNk+vdFfbtScl9dZav2NLf9v5xxl8DfUZrIHZAdO4QjrIVBhW/C4CvuYDq6JbDje3gT51nnKRQ2iUvhSVJjACFob6qcfwTakLuuA2y3hFv0VRUKk+xMWXePwZBXwIQRt7r/n/1ExjZ0g13XpimKuSROfA3NAOupaRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=AynfpHwB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-113.bstnma.fios.verizon.net [108.26.156.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50GDb1YE008668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 08:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737034626; bh=VGAMmh7Q30ccwIzNytXmnS9aOKZXZF17GPVwUDA6Tvw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=AynfpHwBoFK8iYRdDjnUc0XZR3VjWGEpOXKr55vrtXVbjy/Lpswk+qfXISgVdBFMZ
	 4Td0lGfWPuauDRss8lemWQsFj3+/Oo0kjU2l3jbhA0Ito49gbn3wv+hObyeYG2q6ZL
	 fVuPnawtpQx7m4Yls5h7rIWxm6C65vnjrdVDKxDP7US3DgNFPEqv2lMNDgKajzlHnP
	 qPX8iw3HFbA2MwD8JRdnRQbD51c0yRGRL4DSIaMPpRXNV9/C47ef0n6bjtxj2dm953
	 XVeicYWJXNFw1w20SLkW1J0CN4yCL8cnHTle73pAXku69zGWn6Qmgx7LEcV90OE3nx
	 6GwerE191Mm1A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B7C6C15C0108; Thu, 16 Jan 2025 08:37:01 -0500 (EST)
Date: Thu, 16 Jan 2025 08:37:01 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>,
        Anna Schumaker <anna.schumaker@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <20250116133701.GB2446278@mit.edu>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4bv8FkvCn9zwgH0@dread.disaster.area>
 <Z4icRdIpG4v64QDR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4icRdIpG4v64QDR@infradead.org>

On Wed, Jan 15, 2025 at 09:42:29PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 15, 2025 at 10:14:56AM +1100, Dave Chinner wrote:
> > How closely does this match to the block device WRITE_SAME
> > (SCSI/NVMe) commands? I note there is a reference to this in the
> > RFC, but there are no details given.
> 
> There is no write same in NVMe.  In one of the few wiѕe choices in
> NVMe the protocol only does a write zeroes for zeroing instead of the
> overly complex write zeroes.  And no one has complained about that so
> far.

It should be noted that there is currently a patch proposing to add to
fallocate support for the operation FALLOC_FL_WRITE_ZEROS:

https://lore.kernel.org/all/20250115114637.2705887-1-yi.zhang@huaweicloud.com/

For those use cases where this is all the user requires, perhaps this
is something that Linux's nfs4 client should consider implementing?
In any case I'd suggest that interested file system developers comment
on this patch series.

Personally, I have no interest in using or implementing in a
WRITE_SAME operation which implements the all-singing, all-dancing
WRITE_SAME as envisioned by the SCSI and NFSv4.2 specifications.

I will also note that many Cloud vendors (AWS, GCE, Azure) are moving
to using NVMe instead of SCSI, especially for the higher performance
VM and software-defined block devices.  So, I would suspect that a
customer would have to wave a **very** large amount of money under my
employer's nose before this would be something that would be funded by
$WORK for block-based file systems (and even then, it appears that
NVMe is so much better at higher performance storage, such that I'm
not sure how many customers would really be all that interested).

But hey, if someone knows of some AI-related workload that needs to
write the same non-zero block a very large number of times, let me
know.  :-)

Cheers,

						- Ted


