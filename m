Return-Path: <linux-fsdevel+bounces-75630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MuJC271eGnYuAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:27:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1AD986C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6D62303353B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2E2EA482;
	Tue, 27 Jan 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrGgzLq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618412DF14B
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534740; cv=none; b=pNN6o33T3U3diiTknEX/YOZBm1hGEbbW0fYp3NhV8EHNccL3Fh7PLOs6U2B0ddI078HMnUAY0FzobSklrLMQxzR+pYmufSkjhHbZjeAYY6fsgC7RukOAqXhuCgz3fmRYyxU/SpIFhFBQtWXPqutERgUZn+xiXgLKiTv8dJMXGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534740; c=relaxed/simple;
	bh=WoywLs3pjNqpB/uecLRDSsX1z6Vl9eGn3ukPXY6L85w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvKyJUhbwZhfzT3gwrvBF7RF9CFEvTvgaPXoFl9Rgz6Goh2yYjWX8kNh/RiForTe4GRAQJBbRMpmijPyWrqQCKz96ZFzOn8bZvhQUCm2z15NSS7dJofk0BXQEGBqipDbs79avTxCUr7RD7sMaSrfZjD/CX32nSkZYjnOA7DoaGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrGgzLq4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769534738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYDGJ5opMmdA+UH/QDKUhHHjs4Ehiyk8rSz1A55NKGc=;
	b=VrGgzLq4gZCLa3w9qfWkjtWMa0ASp99RCK8pnhHI/sC9ZU0NQOdKRQEBXupVrFybxZhXsQ
	015d1iHjCZSQZsu6bylLRUuvYBiogJQJmeRu6Q1zPSoLqeCCHJwkwQR5lR6NXYN3IL7rMT
	cjgTu46v/XmmQl0Xe6B4uDYce1QXzNk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-dDc73ywAOxaaGDNzYpuNfA-1; Tue,
 27 Jan 2026 12:25:33 -0500
X-MC-Unique: dDc73ywAOxaaGDNzYpuNfA-1
X-Mimecast-MFC-AGG-ID: dDc73ywAOxaaGDNzYpuNfA_1769534732
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95C831955DB7;
	Tue, 27 Jan 2026 17:25:31 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A588D30001A2;
	Tue, 27 Jan 2026 17:25:26 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 27 Jan 2026 18:25:31 +0100 (CET)
Date: Tue, 27 Jan 2026 18:25:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: alexjlzheng@gmail.com
Cc: usamaarif642@gmail.com, david@kernel.org, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, alexjlzheng@tencent.com,
	mingo@kernel.org, ruippan@tencent.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] procfs: fix missing RCU protection when reading
 real_parent in do_task_stat()
Message-ID: <aXj1BZY0P_NQp0yI@redhat.com>
References: <20260127150450.2073236-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127150450.2073236-1-alexjlzheng@tencent.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,oracle.com,tencent.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-75630-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7F1AD986C5
X-Rspamd-Action: no action

On 01/27, alexjlzheng@gmail.com wrote:
>
> From: Jinliang Zheng <alexjlzheng@tencent.com>
>
> When reading /proc/[pid]/stat, do_task_stat() accesses task->real_parent
> without proper RCU protection, which leads:

Thanks for the patch...

>   cpu 0                               cpu 1
>   -----                               -----
>   do_task_stat
>     var = task->real_parent
>                                       release_task
>                                         call_rcu(delayed_put_task_struct)
>     task_tgid_nr_ns(var)
>       rcu_read_lock   <--- Too late!

Almost off-topic, but I can't resist. This looks confusing to me.
It is not "Too late", this rcu_read_lock() protects another thing.
Nevermind.

I think that the changelog could be more clear. It should probably
mention that forget_original_parent() doesn't take child->signal->siglock
and thus we have a race... I dunno.

> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -528,7 +528,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  		}
>
>  		sid = task_session_nr_ns(task, ns);
> -		ppid = task_tgid_nr_ns(task->real_parent, ns);
> +		rcu_read_lock();
> +		ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
> +		rcu_read_unlock();

But this can't really help. If task->real_parent has already exited and
it was reaped, then it is actually "Too late!" for rcu_read_lock().

Please use task_ppid_nr_ns() which does the necessary pid_alive() check.

Oleg.


