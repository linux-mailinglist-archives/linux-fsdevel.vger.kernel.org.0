Return-Path: <linux-fsdevel+bounces-18033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E608B4EC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 01:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B192CB20F6B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 23:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9C31A286;
	Sun, 28 Apr 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U6rtpiMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9A17C96;
	Sun, 28 Apr 2024 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714346637; cv=none; b=E2L+4BoijQSzTjA84dLordivdG/K9yCzajnxLoouatznfMI5kboi0kKWKyGOagwTqGC0iZVuKZZrMaG7GiqrOcWzfw4sRf8UezuNwDsRFaTrt+mnDMhRrZPbt69F4txhiYVegZ8e21sJHryfyg+0dEos/msEIgvplxtaxep+8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714346637; c=relaxed/simple;
	bh=G8bcd97UC4AdurHIryOXHBOgo8XBvyOM0yQ3eotL3G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou5UI/MZNCx7lSbSwkny0GzMs/68mA5sAhpWv+3wvpt5u4KdYShT6zwI7jpFwsdu4xjUWpdrzHvsr1bdTkqImI2gxNKDs8/+jf0ik9JNqZqMZYZ3BmCXE6djfyAlk0xJSI7J5ghFSd9yCDMWuKzrTPlUrQC+YVCv9PZUcDoutHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=U6rtpiMs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GvGwY/VyPI7NHMoTrlnxk5E4tmObsoCK28HHsMidyBY=; b=U6rtpiMsmVcjaZOh8OKTi7XMW0
	yNj5zje20sL7z+USF0KWoWTTODzk7u+FeS0dmRZX+kTzBjUtyO1eurUWHR4Va8Lfo3SgWHErayv7J
	JVtGN4aHwopsGKTxEx/SpI0Ph4UoD0aVm0/3wxuEqe84gBrbNyr27BjTLrof11+GYauwS9q4gQnoo
	IbiRHLy6hLj9Jyx6qWgfXDjDUW8M0X48vLNYMI505f0nBelbKOGMMUw54+mNuU9nXyr/VMHl9hr8S
	RD9+aPrVw//LujYmUv3X4mdx+Od+dvshzXb29N/baU3KijKHYB/9RqlDEpSGtYd9xRbpekjG+AsaQ
	btyP2fFQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s1Ds5-006zcl-2p;
	Sun, 28 Apr 2024 23:23:49 +0000
Date: Mon, 29 Apr 2024 00:23:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com,
	Yu Kuai <yukuai1@huaweicloud.com>,
	Eduard Shishkin <edward6@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: Re: [PATCH vfs.all 15/26] s390/dasd: use bdev api in dasd_format()
Message-ID: <20240428232349.GY2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-16-yukuai1@huaweicloud.com>
 <20240416013555.GZ2118490@ZenIV>
 <Zh47IY7M1LQXjckX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ca513589-2110-45fe-95b7-5ce23487ea10@linux.ibm.com>
 <20240428185823.GW2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428185823.GW2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 28, 2024 at 07:58:23PM +0100, Al Viro wrote:
> On Wed, Apr 17, 2024 at 02:47:14PM +0200, Stefan Haberland wrote:
> 
> > set_blocksize() does basically also set i_blkbits like it was before.
> > The dasd_format ioctl does only work on a disabled device. To achieve this
> > all partitions need to be unmounted.
> > The tooling also refuses to work on disks actually in use.
> > 
> > So there should be no page cache to evict.
> 
> You mean this?
>         if (base->state != DASD_STATE_BASIC) {
>                 pr_warn("%s: The DASD cannot be formatted while it is enabled\n",
>                         dev_name(&base->cdev->dev));
>                 return -EBUSY;
>         }  
> 
> OK, but what would prevent dasd_ioctl_disable() from working while
> disk is in use?  And I don't see anything that would evict the
> page cache in dasd_ioctl_disable() either, actually...
> 
> What am I missing here?

BTW, you are updating block size according to new device size, before
        rc = base->discipline->format_device(base, fdata, 1);
	if (rc == -EAGAIN)
		rc = base->discipline->format_device(base, fdata, 0);
Unless something very unidiomatic is going on, this attempt to
format might fail...

