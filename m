Return-Path: <linux-fsdevel+bounces-23359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F6292B173
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 09:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948C3B21559
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCC91514E2;
	Tue,  9 Jul 2024 07:46:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098514B092;
	Tue,  9 Jul 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511189; cv=none; b=Ay/zWlhgGQb6DVpaIqaJwfEa3k0S1JW/4V4doH9uD4qbWtYoxJRjg2RN/8s3K98xCM62x0el1xYp3B+w+OZx1wkcoo3h8MqfDbuVKhWRaj5tRu0mh7ZAJxZYVJWdKQGHjPRVICid0OJlv5LQRcKC2ZIG1vRXdo4Jx2esbtY4+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511189; c=relaxed/simple;
	bh=ioA9i8VqGwgL7GiiySY0xF+3cEe9lV+XjJAlZzEZCwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqW/HF4Es3ROvSwUk7VZ+RzzNjC401PjwSK/I7OwnmYAhbmZnQczVlV/26OtfBtXcmOznEJXOdb5Zz8GrJvS/2ueK/+57Tto/mxWPfoG/AVAkXCOvVC4MMKfVQ3aY7slf8JruN76ay4tTd2GrvulZW58a0poD+XNgYUpcYGaztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06CC268AFE; Tue,  9 Jul 2024 09:46:24 +0200 (CEST)
Date: Tue, 9 Jul 2024 09:46:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 10/13] xfs: Unmap blocks according to forcealign
Message-ID: <20240709074623.GB21491@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240705162450.3481169-11-john.g.garry@oracle.com> <20240706075858.GC15212@lst.de> <5e4ec78f-42e3-47cb-bf92-eddc36078edf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e4ec78f-42e3-47cb-bf92-eddc36078edf@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 08, 2024 at 03:48:20PM +0100, John Garry wrote:
>>> +	int			isforcealign;	/* freeing for inode with forcealign */
>>
>> This is really a bool.  And while it matches the code around it the
>> code feels a bit too verbose..
>
> I can change both to a bool - would that be better?
>
> Using isfa (instead of isforcealign) might be interpreted as something else 

The check should be used in one single place where we decided if
we need to to the alignment based adjustments.  So IMHO just killing
it and open coding it there seems way easier.   Yes, it is in a loop,
but compared to all the work done is is really cheap.

>> We've been long wanting to split the whole align / convert unwritten /
>> etc code into a helper outside the main bumapi flow.  And when adding
>> new logic to it this might indeed be a good time.
>
> ok, I'll see if can come up with something

I can take a look too.  There is some real mess in there like trying
to account for cases where the transaction doesn't have a block
reservation, which I think could have happen in truncate until
Zhang Yi fixed it for the 6.11 merge window.


