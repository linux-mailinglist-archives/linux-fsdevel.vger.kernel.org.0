Return-Path: <linux-fsdevel+bounces-75700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMaIK3rCeWl0zAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:02:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 216329DFA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1018C300F159
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB383358CD;
	Wed, 28 Jan 2026 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irU9b/j4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029732573A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587314; cv=none; b=qfunE56DHFtLThfQg5Q8Edvs1yjSBbUs60aEwW+ORxZs2ZdR+OvKC65IQzjyaH22jVjIWn4DpJdPsVjW+fn24PgJ5iZk1I9XS9Aukga8ri0iV3cuT1S/WPKvL/ywF6B0CiTSW0K3I07cH/p+++za2N1yw1v/xoCgtsEI/SfLvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587314; c=relaxed/simple;
	bh=i+Guv+zzYgPIFqdxutVNS1+EwVhbB3Dyjdzi42SCcGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVdVsHHHTditdsanXyPGFnnnynEy3H5FQzASpS4xbVmRSJu/tHPAnQJNBvi0dxXMgJeQtMrbQwjtb3dr2Ngw5uItG0ipqv6v5Ulq/z7Rmylv3CqJVNwKcPw3bmJqcFymk1keWQP97YPkPB7qj2644YFCPh4UBkR+ukIzxvS0ycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irU9b/j4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769587312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr33vyezfoD1LNyVZAwta4v2/gDVnDyPxoY+tzG0x+g=;
	b=irU9b/j487F+WxqanJhFZ2RIowqtsS8lFzlfePoJQMaxT6WBPOojsLMvnNej1jXcDtwWLp
	5u2IkJSuQhHTt+QJLUJPtrXopZsz4XciFB8BgTFWZLh95fKIKVuKwIKSTkpjudG0C96l2D
	2MtUHUVgJCmTwkjI/5vtmv5hQ9V2bKw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-UhY87J2FNhipG5F8WsieSw-1; Wed,
 28 Jan 2026 03:01:42 -0500
X-MC-Unique: UhY87J2FNhipG5F8WsieSw-1
X-Mimecast-MFC-AGG-ID: UhY87J2FNhipG5F8WsieSw_1769587301
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD77918002D0;
	Wed, 28 Jan 2026 08:01:40 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D91D01800840;
	Wed, 28 Jan 2026 08:01:36 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 28 Jan 2026 09:01:40 +0100 (CET)
Date: Wed, 28 Jan 2026 09:01:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: alexjlzheng@gmail.com, usamaarif642@gmail.com, david@kernel.org,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	alexjlzheng@tencent.com, mingo@kernel.org, ruippan@tencent.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] procfs: fix missing RCU protection when reading
 real_parent in do_task_stat()
Message-ID: <aXnCX7SmABmQJis3@redhat.com>
References: <20260127150450.2073236-1-alexjlzheng@tencent.com>
 <aXj1BZY0P_NQp0yI@redhat.com>
 <zgqq2et7hf4fh3ggzvvcfmr5wkwoqjfzftxpdedinwinpr4xun@jrbtkbd5ig6n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zgqq2et7hf4fh3ggzvvcfmr5wkwoqjfzftxpdedinwinpr4xun@jrbtkbd5ig6n>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,oracle.com,tencent.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-75700-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 216329DFA3
X-Rspamd-Action: no action

On 01/27, Mateusz Guzik wrote:
>
> On Tue, Jan 27, 2026 at 06:25:25PM +0100, Oleg Nesterov wrote:
> > On 01/27, alexjlzheng@gmail.com wrote:
> > > --- a/fs/proc/array.c
> > > +++ b/fs/proc/array.c
> > > @@ -528,7 +528,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
> > >  		}
> > >
> > >  		sid = task_session_nr_ns(task, ns);
> > > -		ppid = task_tgid_nr_ns(task->real_parent, ns);
> > > +		rcu_read_lock();
> > > +		ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
> > > +		rcu_read_unlock();
> >
> > But this can't really help. If task->real_parent has already exited and
> > it was reaped, then it is actually "Too late!" for rcu_read_lock().
> >
> > Please use task_ppid_nr_ns() which does the necessary pid_alive() check.

Ah, I was wrong, I forgot about lock_task_sighand(task). So in this case
pid_alive() is not necessary, and the patch is fine.

But unless you have a strong opinion, I'd still suggest to use
task_ppid_nr_ns(), see below.

> Suppose it fits the time window between the current parent exiting and
> the task being reassigned to init. Then you transiently see 0 as the pid,
> instead of 1 (or whatever). This reads like a bug to me.

But we can't avoid this. Without tasklist_lock even

 	task_tgid_nr_ns(current->real_parent, ns);

can return zero if we race with reparenting. If ->real_parent is reaped
right after we read the ->real_parent pointer, it has no pids. See
__unhash_process() -> detach_pid().

> It probably should do precisely the same thing proposed in this patch,
> as in:
> 	rcu_read_lock();
> 	ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
> 	rcu_read_unlock();

No, task_ppid_nr_ns(tsk) does need the pid_alive() check. If tsk exits,
tsk->real_parent points to nowhere, rcu_read_lock() can't help.

This all needs cleanups. ->real_parent and ->group_leader need the helpers
(probably with some CONFIG_PROVE_RCU checks) and they should be moved to
signal_struct.

So far I have only sent some trivial initial cleanups/preparations, see
https://lore.kernel.org/all/aXY_h8i78n6yD9JY@redhat.com/

I'll try to do the next step this week. If I have time ;) I am on a
forced PTO caused by renovations in our apartment.

Oleg.


