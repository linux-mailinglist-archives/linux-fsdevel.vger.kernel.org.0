Return-Path: <linux-fsdevel+bounces-69207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCF3C727E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 08:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB4F14EB108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C6D304BAF;
	Thu, 20 Nov 2025 06:51:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7B303CA1;
	Thu, 20 Nov 2025 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621469; cv=none; b=fUqtaHubyMZRgl555pQlTwRLsvBwMZMnW1WpZ+phrG7tpLOCi59bM2tZwhHwRtyglQUlqx9PRGvX9mqMgkUG4imLck4yS8Q6iuGrOPJbCatCa/UoIjoTPXGazVLwPwiW7QYDKF9SGUOTbpVmP/0UpcfdNzP7k+0greaFxLIteDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621469; c=relaxed/simple;
	bh=x4/N5cjY0tOYij8FoUIDfAVD884eFP2ZulZRiTo10dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTVPLdJ6dlJen9OhBtit+tV2TTfjS8TXmQSoTGdc98c2COpob8/11kLNsEAqMnvrE2VZdUoFcSnp9wzIwjhH+dOgLs8ULyXkb3YpQD8qzdzTQbXsKzrWBGrt/6WQ6SixGNACJ59cvqWd3bUMYcDTYojUuD8O2yhnQzRHHTaGKNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0AC82227A88; Thu, 20 Nov 2025 07:51:00 +0100 (CET)
Date: Thu, 20 Nov 2025 07:50:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
	neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are
 multiple layout conflicts
Message-ID: <20251120065059.GB30432@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-4-dai.ngo@oracle.com> <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com> <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com> <09209CBD-6BEE-4BCE-8A13-D62F96A5BD87@hammerspace.com> <aeb05ba9-83c5-45a4-a75b-f76fc4686e7c@oracle.com> <20251119100800.GB25962@lst.de> <8f7653b4-deef-4bda-bf17-e06c2f208135@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f7653b4-deef-4bda-bf17-e06c2f208135@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 08:52:25AM -0800, Dai Ngo wrote:
>
> On 11/19/25 2:08 AM, Christoph Hellwig wrote:
>> On Mon, Nov 17, 2025 at 02:00:07PM -0800, Dai Ngo wrote:
>>> Perhaps I overstated the severity of the risk. The real issue is, in the
>>> current state, SCSI layout recall has no timeout and if there are enough
>>> activities on the server that results in lots of layout conflicts then the
>>> server can hang.
>> All this is really caused by the synchronous waiting.  I'm not against
>> the workaround here, but I think we need to address that.  There's
>> really no reason to consumer threads for this waiting activity and
>> we'll need to stop doing it.
>
> Yes, I think __break_lease needs to work asynchronously. But I'm concerned
> about touching a bunch of other callers.

You really don't need to touch other callers, keep the existing semantics
for them.  Just like we don't force all file I/O to be asynchronous,
just because we also offer that.


