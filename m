Return-Path: <linux-fsdevel+bounces-42900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BDBA4B295
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 16:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C351890384
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEBE1E5B6F;
	Sun,  2 Mar 2025 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNxVr+j1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1302D600
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740928840; cv=none; b=PpirEVOsbMFehBUnWaCWNvRfCPHqGsVZEQvmOJBmv01kB/dQaKmv+L2pMdGozaCbr6MizOv3D+K1Yxo5C4alTeNbEz8D2E6fUZDbNox2buXjkYNGe/lKFviNKY2AKGl1rePwMBxnr9FbN9Rv3zMTfQD5oV1IVnvgSeTK93XTT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740928840; c=relaxed/simple;
	bh=miiswJvuvn+ijwJxeps68+CQSmWQM2le3ZUj6VJqT+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb4hUZ4YSwiZwO7axui+42vRtgU5B1kaEQ6qvOy46NN+lAyjATtHwpaXGluzC2UY/8M+OMJBmEQvBVORRRyP8N3Z63CQLgHwdL/wahwuP5HP2Ea0NOd/gdxt+6JiEIHAeg/BPdQAKKOCXgyCdFyDlBwrKRYubvUwYKF5MmWHxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNxVr+j1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740928837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NpLn6QYYWy+Vl7CM5ak9SBH05RWLlbZtS6lnh1SK+b8=;
	b=JNxVr+j1wGx90jUS4enfMbfq7jaQGm7lAU1MscNEUzJ89ZZrfxyvYySgnUABvLtUi0S12f
	j1Ubx3PK+pRFBiv4HUeso8a+EnRIEfJGL/jX4gV9N/vqJT/3dP35Li4aE7CdJQizrD6jfg
	pJs9HXEiMWQAl9JK+TauSNXWUbSf8nw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-mNCGpMx8NVmcpRkUjpXzSw-1; Sun,
 02 Mar 2025 10:20:19 -0500
X-MC-Unique: mNCGpMx8NVmcpRkUjpXzSw-1
X-Mimecast-MFC-AGG-ID: mNCGpMx8NVmcpRkUjpXzSw_1740928817
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 736D81800570;
	Sun,  2 Mar 2025 15:20:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D4AED1956094;
	Sun,  2 Mar 2025 15:20:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Mar 2025 16:19:47 +0100 (CET)
Date: Sun, 2 Mar 2025 16:19:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 05/10] pidfs: record exit code and cgroupid at exit
Message-ID: <20250302151942.GC2664@redhat.com>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-5-5bd7e6bb428e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-5-5bd7e6bb428e@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 02/28, Christian Brauner wrote:
>
> +void pidfs_exit(struct task_struct *tsk)
> +{
> +	struct dentry *dentry;
> +
> +	dentry = stashed_dentry_get(&task_pid(tsk)->stashed);
> +	if (dentry) {
> +		struct inode *inode;
> +		struct pidfs_exit_info *exit_info;
> +#ifdef CONFIG_CGROUPS
> +		struct cgroup *cgrp;
> +#endif
> +		inode = d_inode(dentry);
> +		exit_info = &pidfs_i(inode)->exit_info;
> +
> +		/* TODO: Annoy Oleg to tell me how to do this correctly. */
> +		if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
> +			exit_info->exit_code = tsk->signal->group_exit_code;
> +		else
> +			exit_info->exit_code = tsk->exit_code;

I think you don't need to check SIGNAL_GROUP_EXIT,

		exit_info->exit_code = tsk->exit_code;

should be fine.

Yes, if SIGNAL_GROUP_EXIT is already set then signal->group_exit_code
can differ.

But this can only happen if the "current" thread exits on its own using
sys_exit() and it races with another thread which does sys_exit_group()
and sets SIGNAL_GROUP_EXIT.

In this case pidfs_exit() can miss SIGNAL_GROUP_EXIT anyway, but we don't
care.  This doesn't differ from the case when current exits, and then
another thread does sys_exit_group() or exec().

Just in case... If current exits because it was killed by sys_exit_group()
from another thread, current->exit_code will be correct, it will be equal
to signal->group_exit_code.

But I am not sure I understand the next patch. let me check...

Oleg.


