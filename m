Return-Path: <linux-fsdevel+bounces-44327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F11A676C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 15:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD153B1A8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76120E016;
	Tue, 18 Mar 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8Y9PtCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461420E010
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309266; cv=none; b=UQ9KOZK3avbYFWZST0o4g2F50twcFoenKHXlGrSoN7hOydajtbigYKpD4z4BoffVVPhyUI0r5n2Eclta/fp/Tnpam6k53p61sCjwGeBF0w9hF6ZUHFQq8mChoaTAdlIogOHcU6oYuWx+M/StrT9Lg5KLSoYrzYD9MYuaYcDBMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309266; c=relaxed/simple;
	bh=EYIyrR+wwIF/Uwb9Rs5+jvTyKUMnjE731tOHnh4p3Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDVB4d+841lEJS1zE5sZNI5P6zjeERa2Yi+RbCmr1/BiNOPgggejZJemPv2Xqrqm9kji7u9nGq2KTO0OtLi4H4h3z5PAaQ8Q8d/C1hWKy0VZquKFXhB0yoGgFbky39NFbwVzac5RiFf+6WYSMY28FGll/1IVLfcIM9Lc+5ZMWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8Y9PtCD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742309259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkhRbg1C4uG3YU7cChJAbWN5iF2Y82Lg6ewPzJk1EvQ=;
	b=X8Y9PtCDwIQUP98wGjzt56jDuce5JkocisCfw6/nx1gPPm3Os8mAWPNUL3F1LSQMm8sZwJ
	63hXvkgZYmTyQVEkpUhJ1wVq6Bxbl0Xm2wF0lU+z5L8bwZ0m2bUuArIWm0sOmJcjB/DSQX
	UFrobn/AT2CUuGttar3ud3VISbuJBY8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-AFABDqdLPJufa51CgG2feA-1; Tue,
 18 Mar 2025 10:47:32 -0400
X-MC-Unique: AFABDqdLPJufa51CgG2feA-1
X-Mimecast-MFC-AGG-ID: AFABDqdLPJufa51CgG2feA_1742309251
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39C921800A3E;
	Tue, 18 Mar 2025 14:47:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.101])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 672AB1955BE1;
	Tue, 18 Mar 2025 14:47:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 18 Mar 2025 15:46:58 +0100 (CET)
Date: Tue, 18 Mar 2025 15:46:54 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2] pidfs: ensure that PIDFS_INFO_EXIT is available
Message-ID: <20250318142601.GA19943@redhat.com>
References: <20250318-geknebelt-anekdote-87bdb6add5fd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-geknebelt-anekdote-87bdb6add5fd@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

I'll try to actually read this patch (and pidfs: improve multi-threaded
exec and premature thread-group leader exit polling) tomorrow, but I am
a bit confused after the quick glance...


On 03/18, Christian Brauner wrote:
>
> +static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
> +				   unsigned int flags)
> +{
> +	enum pid_type type;
> +
> +	if (flags & CLONE_PIDFD)
> +		return true;

OK, this is clear.

> +	if (flags & PIDFD_THREAD)
> +		type = PIDTYPE_PID;
> +	else
> +		type = PIDTYPE_TGID;
> +
> +	/*
> +	 * Since pidfs_exit() is called before struct pid's task linkage
> +	 * is removed the case where the task got reaped but a dentry
> +	 * was already attached to struct pid and exit information was
> +	 * recorded and published can be handled correctly.
> +	 */
> +	if (unlikely(!pid_has_task(pid, type))) {
> +		struct inode *inode = d_inode(path->dentry);
> +		return !!READ_ONCE(pidfs_i(inode)->exit_info);
> +	}

Why pidfs_pid_valid() can't simply return false if !pid_has_task(pid,type) ?

pidfd_open() paths check pid_has_task() too and fail if it returns NULL.
If this task is already reaped when pidfs_pid_valid() is called, we can
pretend it was reaped before sys_pidfd_open() was called?

Oleg.


