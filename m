Return-Path: <linux-fsdevel+bounces-43180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F6A4EF87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 22:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3034173009
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47C27780E;
	Tue,  4 Mar 2025 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J36OZAtJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE71EE7B1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124873; cv=none; b=YUnpc0qKtqZpWoZI6iVMfE9YcEwQgnuo3msb2G6aVawt3emh/G9fWe+GD36gbVsEYrMhueEDHulyRquwY/9nl4zgND5YRS3uRX6nMNU8P39AyLf0JubS042tlMBezaf0yS1j5wXyFGUkLBPLUYBPLtW7owErSNDHIunXkoQFBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124873; c=relaxed/simple;
	bh=9+No9qlg0OPJqoysAdh1uqVF+QBg4Q1vdrLvre9+vU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0jIBaXcfn10UikjVP6Q5XJZg2+ctNbJbQzNzn2Au3VRmX1QtUyF94odAwicWg9x3Vgw//3A/keqBYJE9BbI/r6cv7LmLWoooZ2XutRtEGprHGNjEXTFcAK0tXtfFqix45tH0ZCscLe/kY6Zi/IvPz4xc4D3+/nNsHCRw87IWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J36OZAtJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741124870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9Y6+IRWMSvTUT49laDAVAKLSnNJ5JV6vNN5Xfx40rc=;
	b=J36OZAtJSyANVBr9Dw/NbuDeZVKUlZynElvEV1VkRHc7L2dGiuNkI7FOoPjVg0666Abjoi
	Jg0/QecnSbb7Qn5mmP/gizR/po6xMpOOD065L/6cv8YpvE7yH/2vAh/R8b5UUSIIKLACbK
	e/CyuIZwIfLTAiTMIsPAQ/m4A1X5Gs8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-nUGYj0AKN4ie5ldY4H4l5A-1; Tue,
 04 Mar 2025 16:47:47 -0500
X-MC-Unique: nUGYj0AKN4ie5ldY4H4l5A-1
X-Mimecast-MFC-AGG-ID: nUGYj0AKN4ie5ldY4H4l5A_1741124866
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C39E1800874;
	Tue,  4 Mar 2025 21:47:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E93BC1954B00;
	Tue,  4 Mar 2025 21:47:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 22:47:14 +0100 (CET)
Date: Tue, 4 Mar 2025 22:47:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2 06/15] pidfs: allow to retrieve exit information
Message-ID: <20250304214710.GF5756@redhat.com>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
 <20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org>
 <20250304173456.GD5756@redhat.com>
 <20250304-wochen-gutgesinnt-53c0765c5e81@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-wochen-gutgesinnt-53c0765c5e81@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/04, Christian Brauner wrote:
>
> On Tue, Mar 04, 2025 at 06:34:56PM +0100, Oleg Nesterov wrote:
> > On 03/04, Christian Brauner wrote:
> > >
> > > +	task = get_pid_task(pid, PIDTYPE_PID);
> > > +	if (!task) {
> > > +		if (!(mask & PIDFD_INFO_EXIT))
> > > +			return -ESRCH;
> > > +
> > > +		if (!current_in_pidns(pid))
> > > +			return -ESRCH;
> >
> > Damn ;) could you explain the current_in_pidns() check to me ?
> > I am puzzled...
>
> So we currently restrict interactions with pidfd by pid namespace
> hierarchy. Meaning that we ensure that the pidfd is part of the caller's
> pid namespace hierarchy.

Well this is clear... but sorry I still can't understand.

Why do we check current_in_pidns() only if get_pid_task(PIDTYPE_PID)
returns NULL?

And, unless (quite possibly) I am totally confused, if task != NULL
but current_in_pidns() would return false, then

	kinfo.pid = task_pid_vnr(task);

below will set kinfo.pid = 0, and pidfd_info() will return -ESRCH anyway?

> So this check is similar to:
>
> pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
> {
>         struct upid *upid;
>         pid_t nr = 0;
>
>         if (pid && ns->level <= pid->level) {
>                 upid = &pid->numbers[ns->level];
>                 if (upid->ns == ns)
>                         nr = upid->nr;
>         }
>         return nr;
> }
>
> Only that by the time we perform this check the pid numbers have already
> been freed so we can't use that function directly.

Confused again... Yes, the [u]pid numbers can be already "freed" in that
upid->nr can be already idr_remove()'ed, but

> But the pid namespace
> hierarchy is still alive as that won't be released until the pidfd has
> put the reference on struct @pid.

Yes, so I still don't undestand, sorry :/

IOW. Why not check current_in_pidns() at the start? and do
task = get_pid_task() later, right before

	if (!task)
		goto copy_out;

?

Oleg.


