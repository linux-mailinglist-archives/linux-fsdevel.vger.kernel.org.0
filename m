Return-Path: <linux-fsdevel+bounces-44253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E1AA669B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 06:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B083B0BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2B11DDC2D;
	Tue, 18 Mar 2025 05:43:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910591ABEC5;
	Tue, 18 Mar 2025 05:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276633; cv=none; b=OE1YJV1x/3WkTbYK53a2MdC7bQhAXjiYbeerGKjsb3Z0bJIrvNdU6+O8s3Y+knsu/dFR2qNoM98EST+CGolPMmw3sk6PUKXOZb3wUJb2zoAHF1IxT2jsmfN41J0VlQm9p7lk1XEQ6/o+A4ZOBHR0AfNSyH7s3FRGmwUcvjV3Wlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276633; c=relaxed/simple;
	bh=2dk0BrLK/WpfJUI/Nlg5n6tAxyfJJrF6mHW38n3CxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCSUNePN9G1/RwaFOKq5gommzM3olmd65Vrvxsq+mCovndy2VYCylykdYnprRSdXCuL8TBXKc2k7U1G8ZECEaC2KfioJH+/QlpcPJfUXBFUCeZSYzt6xEop3Xu/0tZs+VrvDD3vDcHyHgJ6EgdqscXtkETxdPicBdyWnOhe45D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68B6968AA6; Tue, 18 Mar 2025 06:43:46 +0100 (CET)
Date: Tue, 18 Mar 2025 06:43:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 11/13] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250318054345.GE14470@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-12-john.g.garry@oracle.com> <20250317064109.GA27621@lst.de> <7d9585df-9a1c-42f7-99ca-084dd47ea3ae@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d9585df-9a1c-42f7-99ca-084dd47ea3ae@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 17, 2025 at 09:36:13AM +0000, John Garry wrote:
>> It is only preferred if actually supported by the underlying hardware.
>> If it isn't it really shouldn't even be tried, as that is just a waste
>> of cycles.
>
> We should not even call this function if atomics are not supported by HW - 
> please see IOCB_ATOMIC checks in xfs_file_write_iter(). So maybe I will 
> mention that the caller must ensure atomics are supported for the write 
> size.

I see that this is what's done in the current series now.  But that feels
very wrong.  Why do you want to deprive the user of this nice and useful
code if they don't have the right hardware?  Why do we limit us to the
hardware supported size when we support more in software?  How do you
force test the software code if you require the hardware support?

>>> +	trace_xfs_file_direct_write(iocb, from);
>>> +	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
>>> +			dio_flags, NULL, 0);
>>
>> The normal direct I/O path downgrades the iolock to shared before
>> doing the I/O here.  Why isn't that done here?
>
> OK, I can do that. But we still require exclusive lock always for the 
> CoW-based method.

If you can do away with the lock that's great and useful to get good
performance.  But if not at least document why this is different from
others.  Similarly if the COW path needs an exclusive lock document why
in the code.


>
>>
>>> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
>>> +	    dops == &xfs_direct_write_iomap_ops) {
>>
>> This should probably explain the unusual use of EGAIN.  Although I
>> still feel that picking a different error code for the fallback would
>> be much more maintainable.
>
> I could try another error code - can you suggest one? Is it going to be 
> something unrelated to storage stack, like EREMOTEIO?

Yes, the funky networking codes tends to be good candidates.  E.g.
ENOPROTOOPT for something that sounds at least vaguely related.

>>> +
>>> +	if (iocb->ki_flags & IOCB_ATOMIC)
>>> +		return xfs_file_dio_write_atomic(ip, iocb, from);
>>> +
>>
>> Either keep space between all the conditional calls or none.  I doubt
>> just stick to the existing style.
>
> Sure

FYI, that I doubt should have been in doubt.  I was just so happy to
finally get the mail out after a flakey connection on the train.


