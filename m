Return-Path: <linux-fsdevel+bounces-46188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8244A8408A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 12:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518AD3A27BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E5028135B;
	Thu, 10 Apr 2025 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2LVBxa9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D6281344
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280328; cv=none; b=Mhm2TzZ+q1qTFsA1ABKHlLvC5cBpVwpo3QHJicpNN/RSw9IWXWpZIXLkbWNxzASY4HfzD8gmeNJlIBIobT46iWjijdBiHpwfyY8z41WIQZNaLgxH4Pgak8H38taFKwDIyYr9SyT9pdK+UdclnBSteSmtQpepkKeVv7c8JpqF928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280328; c=relaxed/simple;
	bh=jndh+/z2HYP9QEo+udB/3zkY+16/NOtoIm2dOXwTGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEdpkoUxw0P/LhdTg3WSR7gE5YG/nc/zZxmJRDzoG0I6a1T3cKMrg6Z+fEsqckjGmaKti4MstgMqelj2YB7prVpiMsXTlQwBvcAHbWEtltRMqyq4ue1iciAMVN/4j/6GwYkfTkBZgEXNyqcIdWcHYVxf4Mt8wQXg2mLiwX0jLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2LVBxa9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744280326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvld6hg6NLmUVocdtsPZa6n4aYUdhPwJV0lCT2PJ1AY=;
	b=A2LVBxa918ocMN19C6l6a/7wPLM4sjsDvHhsN7omtpYP9Q8cB094X40CB89KJIijzRLlvc
	y9l2PlGKEpCcyC1xIOOOs/3ns8TkvH36YAXVXNaTUlaeAnPkB66xl/2Tx5BrlMv4ywDrJh
	WK5CITubCgKWPM/NjHXeJNETdIILb9o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-__dLQ8UxNYOK4UjUaC858w-1; Thu,
 10 Apr 2025 06:18:42 -0400
X-MC-Unique: __dLQ8UxNYOK4UjUaC858w-1
X-Mimecast-MFC-AGG-ID: __dLQ8UxNYOK4UjUaC858w_1744280321
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17790180034D;
	Thu, 10 Apr 2025 10:18:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DE0881808882;
	Thu, 10 Apr 2025 10:18:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 10 Apr 2025 12:18:06 +0200 (CEST)
Date: Thu, 10 Apr 2025 12:18:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org,
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250410101801.GA15280@redhat.com>
References: <20250409-sesshaft-absurd-35d97607142c@brauner>
 <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
 <20250409184040.GF32748@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409184040.GF32748@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/09, Oleg Nesterov wrote:
>
> Christian,
>
> I will actually read your patch tomorrow, but at first glance
>
> On 04/09, Christian Brauner wrote:
> >
> > The seqcounter might be
> > useful independent of pidfs.
>
> Are you sure? ;) to me the new pid->pid_seq needs more justification...
>
> Again, can't we use pid->wait_pidfd->lock if we want to avoid the
> (minor) problem with the wrong ENOENT?

I mean

	int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
	{
		int err = 0;

		spin_lock_irq(&pid->wait_pidfd->lock);

		if (!pid_has_task(pid, PIDTYPE_PID))
			err = -ESRCH;
		else if (!(flags & PIDFD_THREAD) && !pid_has_task(pid, PIDTYPE_TGID))
			err = -ENOENT;

		spin_lock_irq(&pid->wait_pidfd->lock);

		return err ?: __pidfd_prepare(pid, flags, ret);
	}

To remind, detach_pid(pid, PIDTYPE_PID) does wake_up_all(&pid->wait_pidfd) and
takes pid->wait_pidfd->lock.

So if pid_has_task(PIDTYPE_PID) succeeds, __unhash_process() -> detach_pid(TGID)
is not possible until we drop pid->wait_pidfd->lock.

If detach_pid(PIDTYPE_PID) was already called and have passed wake_up_all(),
pid_has_task(PIDTYPE_PID) can't succeed.

Oleg.


