Return-Path: <linux-fsdevel+bounces-77562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEn8BbWhlWlcSwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:25:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC6155E24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A481301016F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F430B51D;
	Wed, 18 Feb 2026 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqYx/gbe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B976302140
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771413936; cv=none; b=EVAiEOC5gpehrMAXVhlTE0mB7PZbpOw6Lz1Pm4TCz8COsVd5l0f1GqCJlbGqftwEhHlg4q0i5rpctcYLFlhPk4e2WYWmKo23X7DupkLQQx2959eTAz+KlnkPyVwspuuR6KIBC+sGS4+jzWj4drXKI+3+RX1A/LjkB0ozj3kY92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771413936; c=relaxed/simple;
	bh=xMYoykPJQ2/8o+91tJZD7nJGatN6/t4dOKrarTkFSds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJuFcJpLDddSso/SarfzTFdOg0IGNp3NTvsa57KKGA0XjRIU09cd963TbPmI3e4wvdek6YNgfTe7yyCcL6O+83P1/6UuEUMIUGvae3jfxqh3eyaSsVFGDEPu5B/tWFsl2a0HFuJRPpPZxhQTYXlK0dLt/xXEU36cL2923YZ0DMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqYx/gbe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771413934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XF9kgpoYg6vyEQtSXnWziHI58jvkIsKa09G/WHBCZI=;
	b=YqYx/gbejahfELzVt5BRTyIuWHWCFFUwVemgl9AqxarHJzRUrCZxLOJPGBVKrD2wW9dFD5
	u3EgzOoihnW3vM+ZDPk3VBxz62+5wXJz3htFK4srSkN8uN9hRY4Y6GQTH7aMwk6avg5I+g
	RqQ8ZX7vg4lhUMabra5fR1rNmSh57SM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-S6U_T6qnO9aCisWAz5vprg-1; Wed,
 18 Feb 2026 06:25:32 -0500
X-MC-Unique: S6U_T6qnO9aCisWAz5vprg-1
X-Mimecast-MFC-AGG-ID: S6U_T6qnO9aCisWAz5vprg_1771413931
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38A33180034A;
	Wed, 18 Feb 2026 11:25:31 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 55EEE180034A;
	Wed, 18 Feb 2026 11:25:28 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 18 Feb 2026 12:25:30 +0100 (CET)
Date: Wed, 18 Feb 2026 12:25:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/4] clone: add CLONE_AUTOREAP
Message-ID: <aZWhpo7-1a0ChJMN@redhat.com>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-1-33a403c20111@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217-work-pidfs-autoreap-v3-1-33a403c20111@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77562-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 6DBC6155E24
X-Rspamd-Action: no action

On 02/17, Christian Brauner wrote:
>
> CLONE_AUTOREAP can be combined with CLONE_PIDFD to allow the parent to
> monitor the child's exit via poll() and retrieve exit status via
> PIDFD_GET_INFO. Without CLONE_PIDFD it provides a fire-and-forget
> pattern where the parent simply doesn't care about the child's exit
> status. No exit signal is delivered so exit_signal must be zero.
                                         ^^^^^^^^^^^^^^^^^^^^^^^^

Well, it has no effect if signal->autoreap is true. Probably makes
sense to enforce this rule anyway... but see below.

> @@ -2028,6 +2028,13 @@ __latent_entropy struct task_struct *copy_process(
>  			return ERR_PTR(-EINVAL);
>  	}
>
> +	if (clone_flags & CLONE_AUTOREAP) {
> +		if (clone_flags & CLONE_THREAD)
> +			return ERR_PTR(-EINVAL);
> +		if (args->exit_signal)
> +			return ERR_PTR(-EINVAL);
> +	}
> +
>  	/*
>  	 * Force any signals received before this point to be delivered
>  	 * before the fork happens.  Collect up signals sent to multiple
> @@ -2374,6 +2381,8 @@ __latent_entropy struct task_struct *copy_process(
>  		p->parent_exec_id = current->parent_exec_id;
>  		if (clone_flags & CLONE_THREAD)
>  			p->exit_signal = -1;
> +		else if (clone_flags & CLONE_AUTOREAP)
> +			p->exit_signal = 0;

So this is only needed for the CLONE_PARENT|CLONE_AUTOREAP case. Do we
really need to support this case? Not that I see anything wrong, but let
me ask anyway.

OTOH, what if a CLONE_AUTOREAP'ed child does clone(CLONE_PARENT) ?
in this case args->exit_signal is ignored, so the new child will run
with exit_signal == 0 but without signal->autoreap. This means it will
become a zombie without sending a signal. Again, I see nothing really
wrong, just this looks a bit confusing to me.

Oleg.


