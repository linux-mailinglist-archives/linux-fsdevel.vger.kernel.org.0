Return-Path: <linux-fsdevel+bounces-77252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ET2xDIPskWmkoAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 16:55:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8806613F0E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 16:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99B15300955A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC662417DE;
	Sun, 15 Feb 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfXuqOJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74E18BC3D
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771170940; cv=none; b=Axp9MMOd7lfEekv9wqpjpj6cncL0tAX+ggkUwnZeWvIsatA/qnB+rYDYIgM6LaYPMCv9Q7RWia+OVopP6UArn3tPg1VEaQjjKhzIhFbm7XHYkoBA7SHHXQNMIyCIxasRERnzj0VR8uZbHuikdBqm8gZDbAlorVuCdN1kNCZkTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771170940; c=relaxed/simple;
	bh=V1Kd52Svd0d4Ifm+Ujbb9DMQkftOdRtXjzloUNnB8s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZDOufCb2ZYKWJjrNsPEcc/tqIrlCakzTULG+a5zrfOW2KsvFh0xRpRQ+ZRjVFtn+EwEihzbvu1EOlC3ijkOnRq+yRWkmJiVXcIHTinQ0jZDLoh671K14GcOWx1KKwsU5ctHj/zIDsVdtNADIL9ybcFH6VmWCj9+mgKWcNciY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfXuqOJ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771170938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fiNrGcY3mKcowblXtfyit1JCIYjw1DXbmLL3M6Khkyg=;
	b=MfXuqOJ2jpLIuAHjdv0f9keN2WT8JewVemLJ/jEGkFL9Pzuq3QR1cMSh/LPX4lQ8+m8hED
	TvQ/2JXEiD/ml8rtQ76oWHrvDouAnsgo2GkDJUj67ala4cPCdR6nkhhSpXM3JpU8euCZQ6
	HAEnTSXo/EPo00wMVL3Dh7W0eG0TcfA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-DNwnof6hN5-5sMv7I3qhoA-1; Sun,
 15 Feb 2026 10:55:36 -0500
X-MC-Unique: DNwnof6hN5-5sMv7I3qhoA-1
X-Mimecast-MFC-AGG-ID: DNwnof6hN5-5sMv7I3qhoA_1771170935
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4F2718003FC;
	Sun, 15 Feb 2026 15:55:34 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 110741800465;
	Sun, 15 Feb 2026 15:55:32 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 15 Feb 2026 16:55:34 +0100 (CET)
Date: Sun, 15 Feb 2026 16:55:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: array: drop stale FIXME about RCU in task_sig()
Message-ID: <aZHscwK0j3068kFS@redhat.com>
References: <20260215124511.14227-1-jaime.saguillo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215124511.14227-1-jaime.saguillo@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77252-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8806613F0E3
X-Rspamd-Action: no action

On 02/15, Jaime Saguillo Revilla wrote:
> task_sig() already wraps the SigQ rlimit read in an explicit RCU
> read-side critical section. Drop the stale FIXME comment and keep using
> task_ucounts() for the ucounts access.
> 
> No functional change.
> 
> Signed-off-by: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
> ---
>  fs/proc/array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index f447e734612a..90fb0c6b5f99 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -280,7 +280,7 @@ static inline void task_sig(struct seq_file *m, struct task_struct *p)
>  		blocked = p->blocked;
>  		collect_sigign_sigcatch(p, &ignored, &caught);
>  		num_threads = get_nr_threads(p);
> -		rcu_read_lock();  /* FIXME: is this correct? */
> +		rcu_read_lock();
>  		qsize = get_rlimit_value(task_ucounts(p), UCOUNT_RLIMIT_SIGPENDING);

I think that task_ucounts/rcu interaction need cleanups, I'll try to do
this next week(s)...

But as for this change I agree: the code is correct and "FIXME' adds the
unnecessary confusion.

Acked-by: Oleg Nesterov <oleg@redhat.com>


