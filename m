Return-Path: <linux-fsdevel+bounces-37641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060439F4EAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 16:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F570162237
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D001F7574;
	Tue, 17 Dec 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPV5IunA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B81F63E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447645; cv=none; b=PA0qtPIaSrTIiTCojBowHrGbMsxopJgdAV2dK/NJqfoxookchso8OggsX+Wss7xaVJqW/MJ1GSO4kny5GOVUDGi0+98xMNc0oZLBs34Mo0pMoPOrPoJfsqFmbXuWl+e+VP9OHpAmpLojcqMZEErFpk52t4inv6GcVrTrmub1Fd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447645; c=relaxed/simple;
	bh=xCX9JZRcJAO6ROqILU4HTVOKOaSuMOPjbIavgtE/AeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcswmf+0/2iDSLXSn/xLxOTXWDTnWPeWX8k8rFwD5+TivDFtAeIrmZ/zkWBAg3FxrpA+kU7pDLyZyMWUsc95aGKFRA9OWb8tDrg/QonRDxdyqelwvy8VJEV85Sr3XhAC3O9BMPDfmcpWtVaLNM50Pb2y/gy1C/FOwO84EwBsN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPV5IunA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734447641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=am51q3B86pGW9dMKjUb91Q4FUviogWcoOGBjTuBK12Y=;
	b=IPV5IunAJju/hxAyh9vgS4I9NAAUMcxSbs1p2VwztN6CCQ+jTeV2X4Cve1jLG/uP3m6n5E
	UnkuKB2y5spSQGTa9qLpJWxKVp/Yzp6aCnk/67ZQmdFdCKpTuHsf/F61u1CvUllqhxOHvP
	scVbf2xh16tXmrJjLUcMTXMpCSxImfk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-lPUsl0mZOIC7szUPRfAp8w-1; Tue,
 17 Dec 2024 10:00:36 -0500
X-MC-Unique: lPUsl0mZOIC7szUPRfAp8w-1
X-Mimecast-MFC-AGG-ID: lPUsl0mZOIC7szUPRfAp8w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7B3B195394D;
	Tue, 17 Dec 2024 15:00:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.190])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CCB0D300FAB7;
	Tue, 17 Dec 2024 15:00:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 17 Dec 2024 15:59:58 +0100 (CET)
Date: Tue, 17 Dec 2024 15:59:52 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/proc: do_task_stat: Fix ESP not readable during
 coredump
Message-ID: <20241217145923.GA29091@redhat.com>
References: <cover.1730883229.git.namcao@linutronix.de>
 <11e1777296b7d06085c9fd341bafc4b9d82e6e4e.1730883229.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e1777296b7d06085c9fd341bafc4b9d82e6e4e.1730883229.git.namcao@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/06, Nam Cao wrote:
>
> @@ -534,6 +517,23 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  		ppid = task_tgid_nr_ns(task->real_parent, ns);
>  		pgid = task_pgrp_nr_ns(task, ns);
>
> +		/*
> +		 * esp and eip are intentionally zeroed out.  There is no
> +		 * non-racy way to read them without freezing the task.
> +		 * Programs that need reliable values can use ptrace(2).

OK,

but then:

> +		 * The only exception is if the task is core dumping because
> +		 * a program is not able to use ptrace(2) in that case. It is
> +		 * safe because the task has stopped executing permanently.
> +		 */
> +		if (permitted && task->signal->core_state) {
> +			if (try_get_task_stack(task)) {
> +				eip = KSTK_EIP(task);
> +				esp = KSTK_ESP(task);
> +				put_task_stack(task);

How can the task->signal->core_state check help ?

Suppose we have a task T1 with T1-pid == 100 and you read /proc/100/stat.
It is possible that the T1's sub-thread T2 starts the coredumping and sets
signal->core_state != NULL.

But read(/proc/100/stat) can run before T1 gets SIGKILL from T2 and enters
the kernel mode?

Oleg.


