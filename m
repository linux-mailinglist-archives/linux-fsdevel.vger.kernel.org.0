Return-Path: <linux-fsdevel+bounces-17942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55958B40AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 22:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB9C282E0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 20:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9765A23746;
	Fri, 26 Apr 2024 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DXpPccp/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2B2231F;
	Fri, 26 Apr 2024 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162196; cv=none; b=o7z2AmgyjQDqjMZ0CtWsAKLZuMwUaGBoG8044qjrPAfTJ4QtyrqkgPTP0dJHBirYN1gSCrOxLGaqkGoZeNSP6d4w4zt7Zp77dMQ1N9P0wRKZewaSXspsCEqS6Sh3A4QlNUHT7d4TVZPY2to5cErKDsDzFDCUaEDY9y3SVL89I+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162196; c=relaxed/simple;
	bh=B2y0EhLw+wM5wP9UmPyHkEJLcBkxN6TEuBi1BXG1Qqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWgKURvg2sknvjsc/eezbxl+msAsyfYmDd5/V32Q1odu3PLcfaXBQOagvOhbCovQQqH+ilvfxMXxsEJKRPAWqkU8gEGW3WI6kJih9J46vIsAmk0wtdqtRs795WKHyBY0gN8Z1JYEnZzYvTb4ID1fhRBaqCxkKs4ZqfREWB05kfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DXpPccp/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jB1S2xzTGiFiesx+Ltzu8Nbt+KQhHNk6IJcbmv7OyAc=; b=DXpPccp/07yVxEzKTsHTNu48m2
	CLX6pcZeeTv4p1bouiI2vYjMvVNNdNIpDtYk/jxQKB38ekCXTpC43ywwG0DfqzMh4msq8RPPF9bSK
	HnwsQtVjKZ9Ux53zlgxHZigWQQe3RcwjiRFgk2P4q3DvgfQpxVHQIRAvvBmD4312wYaeWrKeHQ+Cg
	MZHYYnXLecy9VKcEqa1mXo2yvBOk1bVe4Tn4gsnPl3n6WqKahm9ZlHv50G9TPcFImAjWJdPuJVZU8
	3A+zsvJG/g4L+sSt2ZMBPf1xs2uG1GYejS2eIy4qIWoE4U9Zdd2J9qp79K1Zft5D+0BdEmcXxrhP8
	VwKxX5Og==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0Rt7-005OpJ-0s;
	Fri, 26 Apr 2024 20:09:41 +0000
Date: Fri, 26 Apr 2024 21:09:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lucas Karpinski <lkarpins@redhat.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexl@redhat.com, echanude@redhat.com,
	ikent@redhat.com
Subject: Re: [RFC v2 1/1] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20240426200941.GP2118490@ZenIV>
References: <20240426195429.28547-1-lkarpins@redhat.com>
 <20240426195429.28547-2-lkarpins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426195429.28547-2-lkarpins@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 26, 2024 at 03:53:48PM -0400, Lucas Karpinski wrote:

> -static void namespace_unlock(void)
> +static void free_mounts(struct hlist_head *mount_list)
>  {
> -	struct hlist_head head;
>  	struct hlist_node *p;
>  	struct mount *m;
> +
> +	hlist_for_each_entry_safe(m, p, mount_list, mnt_umount) {
> +		hlist_del(&m->mnt_umount);
> +		mntput(&m->mnt);

... which may block in quite a few ways.

> +	}
> +}
> +
> +static void delayed_mount_release(struct rcu_head *head)
> +{
> +	struct mount_delayed_release *drelease =
> +		container_of(head, struct mount_delayed_release, rcu);
> +
> +	free_mounts(&drelease->release_list);

... and therefore so can this.

> +	kfree(drelease);
> +}


> +		call_rcu(&drelease->rcu, delayed_mount_release);

... which is a bad idea, since call_rcu() callbacks are run
from interrupt context.  Which makes blocking in them a problem.

