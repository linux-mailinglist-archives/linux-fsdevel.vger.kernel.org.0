Return-Path: <linux-fsdevel+bounces-39427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78EAA140E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D070A167FF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049D22CBC1;
	Thu, 16 Jan 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cAdrVghH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C9155756
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048619; cv=none; b=BexHEg5Qd1cTUmSueg3ykgJLSDMS+4iR4Q6OLBr4M9jvtXG7j990S9WKST8JCcu2iSQp0RSmNU7ghFM0nNyW7x+RdPEfZEOIK1O8mGaccbJP2TedZGo82V/1x1oUSYJ4oiH/qqwwbBnnQ4wQL45/1c80LLL0R4A/k+9PwzRfU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048619; c=relaxed/simple;
	bh=EL5RVArMfSF1wd8a4V7Z7jeVW4UyC7B/aQNufHq+ovo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3rawxu2c6lZo9YG8EoZKuSenh010VumiZ1oQZgT+Y/5O0aTkbvN/lemccXTwan5PTxMuOpZr8g4KjifuKJ4WIGD6ZUM2K7iNC2pL5dkAAEVKD7cNVvbGtoiwWmX+aKXlIulo4/+GqshMU+iTiGV53kIgE7KoWkhAlkKv/2KV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cAdrVghH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-113.bstnma.fios.verizon.net [108.26.156.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50GHU0Fn009839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 12:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737048603; bh=H7ODOWazAZ9JZ+VnZvDHoa9w38yZBfcf2ECm7Co0svQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=cAdrVghHPGC8gAUyBmu+wPQc4pRH6TBYoN2iRTEUqeMvrWE1mLgtxeN7mzlhORhZA
	 WZIiQzWsnkLtFBAH4Bz/dmjTsuMvbOD/1XqkTIi+g0+hB+NvQsMfQgxZUdNzJSCQkv
	 cR0Zk6lECHMe/mlnxUM9vb7vyhEssH1Iz4OWtt2cR3/roAPbNh3ZTOv5vMDN94tfzc
	 1nDCxd/fdrL9/yVFyLUqyzjOFl3mylZSil+r4WXbx85DLtn8O63G7YwfrVTiny8lXI
	 drA8DTFK1PKBfz8iYj7azK7Uh23VOAn8AKI5goJptyBiqHfRxjQl/CufKNub5UCe/k
	 FX0hQ3KMv/DEQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AEDC015C0108; Thu, 16 Jan 2025 12:30:00 -0500 (EST)
Date: Thu, 16 Jan 2025 12:30:00 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>,
        Anna Schumaker <anna.schumaker@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <20250116173000.GA2479310@mit.edu>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4bv8FkvCn9zwgH0@dread.disaster.area>
 <Z4icRdIpG4v64QDR@infradead.org>
 <20250116133701.GB2446278@mit.edu>
 <21c7789f-2d59-42ce-8fcc-fd4c08bcb06f@oracle.com>
 <20250116153649.GC2446278@mit.edu>
 <5fdc7575-aa3d-4b37-9848-77ecf8f0b7d6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fdc7575-aa3d-4b37-9848-77ecf8f0b7d6@oracle.com>

On Thu, Jan 16, 2025 at 10:45:01AM -0500, Chuck Lever wrote:
> 
> Any database that uses a block size that is larger than the block
> size of the underlying storage media is at risk of a torn write.
> The purpose of WRITE_SAME is to demark the database blocks with
> sentinels on each end of the database block containing a time
> stamp or hash.

There are alternate solutions which various databases to address the
torn write problem:

   * DIF/DIX (although this is super expensive, so this has fallen out
        of favor)
   * In-line checksums in the database block; this approach is fairly
        common for enterprise databases (interestingly, Google's cluster
	file systems, which don't need to support mmap, do this as well)
   * Double-buffered writes using a journal (this is what open source
         databases tend to use)
   * For software-defined cloud block devices (such as Google's
       Persistent Disk, Amazon EBS, etc.) and some NVMe devices,
       aligned writes can be guaranteed up to some write granularity
       (typically up to 32k to 64k, although pretty much all database
       pages today are 16k).  This is actively fielded as
       customer-available products and/or in development in at least
       two first-party cloud database products based on MySQL and/or
       Postgres; and there are some active patches which John Garry
       has been working on so that users can use this technique
       without having to rely on first party cloud product teams
       knowing implementation details of their cloud block devices.
       (This has been discussed in past LSF/MM sessions.)

> If, when read back, the sentinels match, the whole database
> block is good to go. If they do not, then the block is torn
> and recovery is necessary.

Are there some database teams that are actively working on a scheme
based on WRITE SAME?  I have talked to open source developers on the
MySQL and Postgres teams, as well as the first party cloud product
teams at my company and some storage architects at competitor cloud
companies, and no one has mentioned any efforts involving WRITE SAME.
Of course, maybe I simply haven't come across such plans, especially
if they are under some deep, dark NDA.  :-)

However, given that support for WRITE SAME is fairly rare (like
DIF/DIX it's only available if you are willing to pay $$$$ for your
storage, because it's a specialized feature that storage vendors like
to change a lot for), I'm bit surprised that there are database groups
that would be intersted in relying on such a feature, since it tends
not be commonly available.

If there are real-world potential users, go wild, but at least for the
use cases and databases that I'm aware of, the FALLOC_FL_WRITE_ZEROS
and atomic writes patch series (it's really untorn writes but we seem
to have lost that naming battle) is all that we need.

Cheers,

						- Ted

