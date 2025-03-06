Return-Path: <linux-fsdevel+bounces-43348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD6A54A82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8669F3A761C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18A205513;
	Thu,  6 Mar 2025 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7edti7D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08111853
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263476; cv=none; b=ffaUoBIsAFumO26fsB75jxoXnd778HkLOrDu6honrSDVDJyWPgsRc6ug5o/qdzH8ShZzLQiD5yWp5Iors+as0iUY5dflXBOnUTkH19BDoJGvNTvHq7cjYRWPKktwPwlxUkOLzpj7ACwRhiPUtt3XmM3Zv2eiV7DDcvy0gjMIlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263476; c=relaxed/simple;
	bh=ldahzMzmjug3LvTI+/cZFWuHiPQIEwSJifQj0ySJd1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9FXJnIF5TXZwmC0CBkT5SePsxKqx2tHApizJBAggVeDzW8hxDkHnuGfrft3JaRR7mNe82kdNG20JUhCekGX28UdCntzbYsSCyIOm2FCMemv4/SW+154q6l/tqBWlZkrsTDBNBxtHxZWn+ACaAhys210qRu3PO2iWpnLh/TGpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7edti7D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741263473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CW3tib2R3DZG0yWyylRQoQcBWMNLbYTJvETMGsHBs28=;
	b=V7edti7D/BPYmxawvOGR7CU/ueK/c4j/6kypjAwKdxh/2Xj1SVcpu+RrbVM8N8MfFbZIKA
	d+CT/WbkoB7fcDQX5Fn44V1XnTaA5/ZJiRfwWb+uw1hAjjZ0KAb4e31MeLtyQHv6Al8/eJ
	D9Z8ykbpPacuooN85ug+HK0LP9t7M2I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-dRO-NlYPNfKkHiwu0I_UZA-1; Thu,
 06 Mar 2025 07:17:49 -0500
X-MC-Unique: dRO-NlYPNfKkHiwu0I_UZA-1
X-Mimecast-MFC-AGG-ID: dRO-NlYPNfKkHiwu0I_UZA_1741263468
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3CC4180AF4E;
	Thu,  6 Mar 2025 12:17:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.240])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4C8911956096;
	Thu,  6 Mar 2025 12:17:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Mar 2025 13:17:17 +0100 (CET)
Date: Thu, 6 Mar 2025 13:17:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: PIDFD_THREAD behavior for thread-group leaders
Message-ID: <20250306121713.GC19868@redhat.com>
References: <nhoaiykqnoid3df3ckmqqgycbjqtd2rutrpeat25j4bbm7tbjl@tpncnt7cp26n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nhoaiykqnoid3df3ckmqqgycbjqtd2rutrpeat25j4bbm7tbjl@tpncnt7cp26n>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/06, Christian Brauner wrote:
>
> Back when we implemented support for PIDFD_THREAD we ended up with the
> decision that if userspace holds:
>
> pidfd_leader_thread = pidfd_open(<thread-group-leader-pid>, PIDFD_THREAD)
>
> that exit notification is not strictly defined if a non-thread-group
> leader thread execs:

Yes, this was even documented in commit 64bef697d33b ...

> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -745,8 +745,11 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>         /*
>          * sub-thread or delay_group_leader(), wake up the
>          * PIDFD_THREAD waiters.
> +        *
> +        * The thread-group leader will be taken over by the execing
> +        * task so don't cause spurious wakeups.
>          */
> -       if (!thread_group_empty(tsk))
> +       if (!thread_group_empty(tsk) && (tsk->signal->notify_count >= 0))
>                 do_notify_pidfd(tsk);
>
>         if (unlikely(tsk->ptrace)) {

perhaps... but this won't help if the leader exits and that another
thread does exec?

From the changelog

	Perhaps we can improve this behaviour later, pidfd_poll()
	can probably take sig->group_exec_task into account. But
	this doesn't really differ from the case when the leader
	exits before other threads (so pidfd_poll() succeeds) and
	then another thread execs and pidfd_poll() will block again.

so I am not sure what can we do.

I'll try to think more later, but I can't promise much :(

Oleg.


