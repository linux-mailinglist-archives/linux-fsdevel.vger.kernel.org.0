Return-Path: <linux-fsdevel+bounces-43855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9475A5E975
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 02:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CC3189AFA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034082AE8D;
	Thu, 13 Mar 2025 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsteTEJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5F747F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741829806; cv=none; b=qeg6Ce0Fngy2mna5Qd4/9L5IA/kyrx/wuyPOoCwq4BEgK0pwJutA6/M34w/R0cpSCwFxkGSIHJxkX5fzsMhdwBReE0vYxO9qnOruatBAaQYahni3E/8dLB850JZXK79L2GDTTBpo5vI7YqP6E3UiDclUL2hXRJh3BL3y8sbxalk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741829806; c=relaxed/simple;
	bh=SA22QSLUYyol1u4wMjFAO85jdH5duOHGUlWzrso8yZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkSBB2lBHcNkp+Clk8s/Dtsm6OFUtsMSX9dKGkjNPFQ5yOb9nKDTBUwj5MnjilnfcMl9mePMhzAuWroH+g4KrsFJ0pM8zOADFVEuATG07fDELru98M1SuGkQGhzf+kFHy7ZYgZvy8xBj4KQQiRk9R9t2og0MKqPZcMOs4YyF7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsteTEJu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741829802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0kUhjCqdb4FPJavIOLP1GIJNyUID8mWi+LpOymw+zs=;
	b=dsteTEJufSJCywha05PQtxz187/EIoHb9B69nhjgLptJBkjacsK5lqMYsnhPxOL/JPo9If
	cjylcDBBU5FYh9AJA+mjdqPIzHtH+n0nSEARWebMaL8y9SO/8yhKOtrO2jR3gvGmSkZDl3
	1NjrrhUoF3/e8RJ9nevqfKwjQj+YCgU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-J6-VLbwlMDeShec5NqsR-g-1; Wed,
 12 Mar 2025 21:36:40 -0400
X-MC-Unique: J6-VLbwlMDeShec5NqsR-g-1
X-Mimecast-MFC-AGG-ID: J6-VLbwlMDeShec5NqsR-g_1741829799
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CA681955BC1;
	Thu, 13 Mar 2025 01:36:38 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E03D1800944;
	Thu, 13 Mar 2025 01:36:27 +0000 (UTC)
Date: Thu, 13 Mar 2025 09:36:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z9I2lm31KOQ784nb@fedora>
References: <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
 <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com>
 <Z8eURG4AMbhornMf@dread.disaster.area>
 <81b037c8-8fea-2d4c-0baf-d9aa18835063@redhat.com>
 <Z8zbYOkwSaOJKD1z@fedora>
 <a8e5c76a-231f-07d1-a394-847de930f638@redhat.com>
 <Z8-ReyFRoTN4G7UU@dread.disaster.area>
 <Z9ATyhq6PzOh7onx@fedora>
 <Z9DymjGRW3mTPJTt@dread.disaster.area>
 <Z9FFTiuMC8WD6qMH@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9FFTiuMC8WD6qMH@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Mar 12, 2025 at 04:27:12PM +0800, Ming Lei wrote:
> On Wed, Mar 12, 2025 at 01:34:02PM +1100, Dave Chinner wrote:

...

> 
> block layer/storage has many optimization for batching handling, if IOs
> are submitted from many contexts:
> 
> - this batch handling optimization is gone
> 
> - IO is re-ordered from underlying hardware viewpoint
> 
> - more contention from FS write lock, because loop has single back file.
> 
> That is why the single task context is taken from the beginning of loop aio,
> and it performs pretty well for sequential IO workloads, as I shown
> in the zloop example.
> 
> > 
> > > It isn't perfect, sometime it may be slower than running on io-wq
> > > directly.
> > > 
> > > But is there any better way for covering everything?
> > 
> > Yes - fix the loop queue workers.
> 
> What you suggested is threaded aio by submitting IO concurrently from
> different task context, this way is not the most efficient one, otherwise
> modern language won't invent async/.await.
> 
> In my test VM, by running Mikulas's fio script on loop/nvme by the attached
> threaded_aio patch:
> 
> NOWAIT with MQ 4		:   70K iops(read), 70K iops(write), cpu util: 40%
> threaded_aio with MQ 4	:	64k iops(read), 64K iops(write), cpu util: 52% 
> in tree loop(SQ)		:   58K	iops(read), 58K iops(write)	
> 
> Mikulas, please feel free to run your tests with threaded_aio:
> 
> 	modprobe loop nr_hw_queues=4 threaded_aio=1
> 
> by applying the attached the patch over the loop patchset.
> 
> The performance gap could be more obvious in fast hardware.

For the normal single job sequential WRITE workload, on same test VM, still
loop over /dev/nvme0n1, and running fio over loop directly:

fio --direct=1 --bs=4k --runtime=40 --time_based --numjobs=1 --ioengine=libaio \
	--iodepth=16 --group_reporting=1 --filename=/dev/loop0 -name=job --rw=write

threaded_aio(SQ)	:	81k  iops(write), cpu util: 20% 
in tree loop(SQ)	:   100K iops(write), cpu util: 7%	


Thanks,
Ming


