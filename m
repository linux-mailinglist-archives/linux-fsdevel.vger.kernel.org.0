Return-Path: <linux-fsdevel+bounces-77565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGS1FKSnlWlVTAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:51:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82F156198
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 533F03013A51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8E30DD2A;
	Wed, 18 Feb 2026 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAaxUYRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA630AD06
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415452; cv=none; b=ilwAjVuVcIpUhHSki0LS1buys12aXN6tINxzDvsyJtYN4JXH3Zx7laCFHYp6M/x9FXNdkxX8eotbWjgMhBxKfoq8717++q9kEDTdNrKUx7ZRU3aHwCG7UiX5od3P5fYkrwR5mUXta0oEVIyQXRk96bGp4ilHUu6PlLLqlmG6250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415452; c=relaxed/simple;
	bh=KUSA/TMgxw9NGGX+O3OfV9B63NPwXmy5/9p9YVvDOKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlOlHAQtOiRVRxUOexSEnJmGFSLm8Sb0nmJ15X/5qSAM8Pcz5z/0KlZWKPCsUfqknoRMd+6ZCagFZKfMaW/sTrvHHqqvtjUnqzq9semqzMTndhotly9TpTk3JS3AKb7q8CN26NWVBE+wUZpVmk6mob6kHxrnW7mXjye/hhwVY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAaxUYRT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771415449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uejI3S6pQ8uq5qlBo8k/9m3iLVJqvsCVpAeVljFGl8Y=;
	b=VAaxUYRT7dsKLLxdEg3MeiQI2x+U80NN0vqy1oztHODwlyl/9xjjavs1hjDtX943I61ce2
	ygTnxDNsOgm5lLKP0ia4muE17zJeET17PNWNoVsLrAcE6NwZZefewpm9O6Mdv3jZv292/a
	mL1vAspSSLhbaRhSrThnESM6XpZkoGg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-TudqNoMBOeeFfpxINHMDIg-1; Wed,
 18 Feb 2026 06:50:46 -0500
X-MC-Unique: TudqNoMBOeeFfpxINHMDIg-1
X-Mimecast-MFC-AGG-ID: TudqNoMBOeeFfpxINHMDIg_1771415445
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C524195605A;
	Wed, 18 Feb 2026 11:50:45 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F034F19560B6;
	Wed, 18 Feb 2026 11:50:42 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 18 Feb 2026 12:50:45 +0100 (CET)
Date: Wed, 18 Feb 2026 12:50:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Message-ID: <aZWnkY_XqQ1-kKO0@redhat.com>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77565-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9E82F156198
X-Rspamd-Action: no action

On 02/17, Christian Brauner wrote:
>
> @@ -2470,8 +2479,11 @@ __latent_entropy struct task_struct *copy_process(
>  	syscall_tracepoint_update(p);
>  	write_unlock_irq(&tasklist_lock);
>  
> -	if (pidfile)
> +	if (pidfile) {
> +		if (clone_flags & CLONE_PIDFD_AUTOKILL)
> +			p->signal->autokill_pidfd = pidfile;
>  		fd_install(pidfd, pidfile);

Just curious... Instead of adding signal->autokill_pidfd, can't we
add another "not fcntl" PIDFD_AUTOKILL flag that lives in ->f_flags ?

Oleg.


