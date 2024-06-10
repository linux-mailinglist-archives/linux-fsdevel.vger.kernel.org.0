Return-Path: <linux-fsdevel+bounces-21347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A13902762
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 19:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A962897D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358E143C4E;
	Mon, 10 Jun 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sBbotLg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D2139580;
	Mon, 10 Jun 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718039010; cv=none; b=uUyy05whMWTg9+i9t1iyuPzL5tY03btZcalnm1t/60gr3aWgGMEyGrT6D5EKrf1rUKJjAB7eFyoRrcb90NGN9AQbDT8z2kAyrpMtESFZ5HvyXfo40QCkhRA7Ykq6r3bw2OXf6eRml6Swjp+v9UsDnDoZBypI4kDnQ0amtN4DasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718039010; c=relaxed/simple;
	bh=ZUWbNnG/kmBxXFsw8L/xdfxvK4PTwd8k2rEbdgdoSJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUYwxJg3zCpFnhzlEucmTOuZewv9A2ZCHLPrwJ6qSUo/zSHslIlZLhdRDs4+tFf82BK3z5XFZynC4AFcsbIimjhkv4IVydY/z2Db2dDqaYapu0NP11WBFEFTL2OcKiDTi+Jr5MBh7Ksu7bwcgPkGgS7cb/coVffkp76PCbklou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sBbotLg1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Yx7PwsAlYE6mN8F2bE8k5ri0pIVLDxNUdHZDelulKM=; b=sBbotLg1AdOMWC/+cP1MetArMt
	9YB85pqqJFx/E5eXyrXDsw43wv//7RRTu6+y0R11Z9WuRiS91qnpVLn4IyWjtaJHxCCfJIv6rAXmS
	Mnh/MVsZD7IxFcRWZF5P882vQZpzIg5lTGC3OtEytBGqYfFZnONzC2NbiTTE9gRFLL52lnAR0TZ0W
	Kr8VaATt9dlOULikTRNUqM6szJtgDR7Y95x6YuYxo/OrW36RyF7hc9rnqmPfWJtVvpzpc+aOzehRm
	hGaQNBj2aN93ZXBJ/oEa3lRkOseuQ6Q2EHReBaQJnx8aZB/1S4SMnmlIHqhrSUAjAO5ufsk4QocA8
	hvDy4uJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sGiQT-008nVs-0V;
	Mon, 10 Jun 2024 17:03:21 +0000
Date: Mon, 10 Jun 2024 18:03:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Fei Li <fei1.li@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] UAF in acrn_irqfd_assign() and vfio_virqfd_enable()
Message-ID: <20240610170321.GA2069166@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk>
 <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
 <20240607161043.GZ1629371@ZenIV>
 <20240607210814.GC1629371@ZenIV>
 <20240610051206.GD1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610051206.GD1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 10, 2024 at 06:12:06AM +0100, Al Viro wrote:

> vfio_virqfd_enable() has the same problem, except that there we
> definitely can't move vfs_poll() under the lock - it's a spinlock.
> 
> Could we move vfs_poll() + inject to _before_ making the thing
> public?  We'd need to delay POLLHUP handling there, but then
> we need it until the moment with do inject anyway.  Something
> like replacing
>         if (!list_empty(&irqfd->list))
> 		hsm_irqfd_shutdown(irqfd);
> in hsm_irqfd_shutdown_work() with
>         if (!list_empty(&irqfd->list))
> 		hsm_irqfd_shutdown(irqfd);
> 	else
> 		irqfd->need_shutdown = true;
> and doing
> 	if (unlikely(irqfd->need_shutdown))
> 		hsm_irqfd_shutdown(irqfd);
> 	else
> 		list_add_tail(&irqfd->list, &vm->irqfds);
> when the sucker is made visible.
> 
> I'm *not* familiar with the area, though, so that might be unfeasible
> for any number of reasons.

Hmm...  OK, so we rely upon EPOLLHUP being generated only upon the final
close of eventfd file.  And vfio seems to have an exclusion in all callers
of vfio_virqfd_{en,dis}able(), which ought to be enough.

For drivers/virt/acrn/irqfd.c EPOLLHUP is not a problem for the same
reasons, but there's no exclusion between acrn_irqfd_assign() and
acrn_irqfd_deassign() calls.  So the scenario with explicit deassign
racing with assign and leading to vfs_poll(file, <freed memory>) is
possible.

And it looks like drivers/xen/privcmd.c:privcmd_irqfd_assign() has
a similar problem...

How about the following for acrn side of things?  Does anybody see
a problem with that "do vfs_poll() before making the thing visible"
approach?

diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index d4ad211dce7a..71c431506a9b 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -133,7 +133,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	eventfd = eventfd_ctx_fileget(f.file);
 	if (IS_ERR(eventfd)) {
 		ret = PTR_ERR(eventfd);
-		goto fail;
+		goto out_file;
 	}
 
 	irqfd->eventfd = eventfd;
@@ -145,29 +145,26 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	init_waitqueue_func_entry(&irqfd->wait, hsm_irqfd_wakeup);
 	init_poll_funcptr(&irqfd->pt, hsm_irqfd_poll_func);
 
+	/* Check the pending event in this stage */
+	events = vfs_poll(f.file, &irqfd->pt);
+
+	if (events & EPOLLIN)
+		acrn_irqfd_inject(irqfd);
+
 	mutex_lock(&vm->irqfds_lock);
 	list_for_each_entry(tmp, &vm->irqfds, list) {
 		if (irqfd->eventfd != tmp->eventfd)
 			continue;
-		ret = -EBUSY;
+		hsm_irqfd_shutdown(irqfd);
 		mutex_unlock(&vm->irqfds_lock);
-		goto fail;
+		irqfd = NULL;	// consumed by hsm_irqfd_shutdown()
+		ret = -EBUSY;
+		goto out_file;
 	}
 	list_add_tail(&irqfd->list, &vm->irqfds);
+	irqfd = NULL;	// not for us to free...
 	mutex_unlock(&vm->irqfds_lock);
-
-	/* Check the pending event in this stage */
-	events = vfs_poll(f.file, &irqfd->pt);
-
-	if (events & EPOLLIN)
-		acrn_irqfd_inject(irqfd);
-
-	fdput(f);
-	return 0;
-fail:
-	if (eventfd && !IS_ERR(eventfd))
-		eventfd_ctx_put(eventfd);
-
+out_file:
 	fdput(f);
 out:
 	kfree(irqfd);

