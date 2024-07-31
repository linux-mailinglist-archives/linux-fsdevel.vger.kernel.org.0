Return-Path: <linux-fsdevel+bounces-24695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3949D943277
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5314D1C23720
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB41BBBD1;
	Wed, 31 Jul 2024 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfOQpb5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6241BBBC5
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437506; cv=none; b=W2y4L6CqX5dyaAe1nAFUhPuMnsCbUd5fstNELoxAKTUIy0GMcRYbSBx5pSvF47X09wr4ogmvDyg6FVdE1YbBX+QI9azi873Htu3OvP5pw23tdQXIHZIA/hCig724aPFiJ+TRIyHom6S4qz4PJd0u+nsOwTWEvptt6hM3bH8w58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437506; c=relaxed/simple;
	bh=K+L+moXPyRckcJEOPIpXPdO70rl9nvkMMU/SwZ6KEgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqbu6UvIT6LmcGUAdyX2/2BjZGAnJCRcjB4+JbfxSSbjOqe2qa426IpTjD38s+x45ptUOzLHFRUckhiD01shx39Tr6GxolsuJVgU8pO/fCoxKZAXgDdLQIBYRpzOxU11ZULaVqy/y2K4ETHKkn3DHtiRR9ByBqZ5tZlQuuZG+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfOQpb5C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722437503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Pv+HDvEvOySzEJcwpcEm+6Prwjz4GlxMPdJTpaqB7c=;
	b=FfOQpb5C/vUqRmaUe0JMDFGpV3gyBvvsTGXnOSbSxPAu5sb3RFt4ygWRUTue9cLRYKUbvG
	weyxQ6cmPoXb9gcWJFXdDJMjuT72VRgoAdn6JxAJUkSZdrT3YkuhrajCaowWnqnNDDJfjs
	O0wzi0KQUT+HVYfEFpNJeA+csol9WPU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-_dHwd0tEMuCXIYEWQas0Og-1; Wed,
 31 Jul 2024 10:51:40 -0400
X-MC-Unique: _dHwd0tEMuCXIYEWQas0Og-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B71AB1944AAC;
	Wed, 31 Jul 2024 14:51:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 60918300018D;
	Wed, 31 Jul 2024 14:51:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 16:51:37 +0200 (CEST)
Date: Wed, 31 Jul 2024 16:51:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240731145132.GC16718@redhat.com>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/31, Christian Brauner wrote:
>
> It's currently possible to create pidfds for kthreads but it is unclear
> what that is supposed to mean. Until we have use-cases for it and we
> figured out what behavior we want block the creation of pidfds for
> kthreads.

Hmm... could you explain your concerns? Why do you think we should disallow
pidfd_open(pid-of-kthread) ?

> @@ -2403,6 +2416,12 @@ __latent_entropy struct task_struct *copy_process(
>  	if (clone_flags & CLONE_PIDFD) {
>  		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
>  
> +		/* Don't create pidfds for kernel threads for now. */
> +		if (args->kthread) {
> +			retval = -EINVAL;
> +			goto bad_fork_free_pid;

Do we really need this check? Userspace can't use args->kthread != NULL,
the kernel users should not use CLONE_PIDFD.

Oleg.


