Return-Path: <linux-fsdevel+bounces-77976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG06DdJ3nGlfIAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:52:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004917919D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C66430B4824
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DFC30648A;
	Mon, 23 Feb 2026 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyvrZvrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9D3033CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861887; cv=none; b=k6lffVF8WOVJSEazyhzXHk66vj6gZeaUa4D4PAKaMwrdfnqGAW5UfdvThKYM6S8nTJWb6eh7iXerSC/EBRQCzpwsagjhIGZvBwdapltt2K6wxXPR+/cRx9dc90W4C81rQfZnUY7rfPA357ZqKLb7sqeKmq2FK5MeyGqM+WBgdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861887; c=relaxed/simple;
	bh=/moWtDIEjp4249Jyr0r/8OEFzjXOSWmszhkYg5EC3hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0+ldh+dfIssFfPQNC+7E5jFrbqEgaDk6VQI2Ht5w33uzQRGCDf7zgwDQxEBkxEyr/FyU1xX399qPcDjjbVHJnR2LdYTWSTwYiSPsfvpwDf2tHPdkDPCtDXGoULanq4oPuTaKCrZY0iRvB/nFTd7WtQpSKchVkTZUWAmnzPwqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyvrZvrn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771861884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6xikMNX4b3fNglV7/r3QwFvoHupFZoS/PKJbrFfooE=;
	b=VyvrZvrn2/0p7ewlBe1uFaU36UCjDAF2/tljVMPSJ6a40SZJQ+//SxWAnUMAZbCGAgHgOx
	NDkQR3ILyrdcN6AsyV1K+g9jQhfRAonEqief+btIoPsep6CwkWqVZwiPp5YqtidrQNkRdq
	woE5zNuVdox9jy2f+XSik9aPzBn+BXY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-Hel2MJfdOPezWKemyMmtnA-1; Mon,
 23 Feb 2026 10:51:21 -0500
X-MC-Unique: Hel2MJfdOPezWKemyMmtnA-1
X-Mimecast-MFC-AGG-ID: Hel2MJfdOPezWKemyMmtnA_1771861880
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81ECC1955E85;
	Mon, 23 Feb 2026 15:51:18 +0000 (UTC)
Received: from fedora (unknown [10.44.32.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D6FFB1800465;
	Mon, 23 Feb 2026 15:51:15 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 23 Feb 2026 16:51:18 +0100 (CET)
Date: Mon, 23 Feb 2026 16:51:14 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Message-ID: <aZx3ctUf-ZyF-Krc@redhat.com>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
 <20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
 <aZx2dlV9tJaL5gDG@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZx2dlV9tJaL5gDG@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	TAGGED_FROM(0.00)[bounces-77976-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9004917919D
X-Rspamd-Action: no action

On 02/23, Oleg Nesterov wrote:
>
> On 02/23, Christian Brauner wrote:
> >
> > @@ -2259,13 +2268,20 @@ __latent_entropy struct task_struct *copy_process(
> >  	 * if the fd table isn't shared).
> >  	 */
> >  	if (clone_flags & CLONE_PIDFD) {
> > -		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
> > +		unsigned flags = PIDFD_STALE;
> > +
> > +		if (clone_flags & CLONE_THREAD)
> > +			flags |= PIDFD_THREAD;
> > +		if (clone_flags & CLONE_PIDFD_AUTOKILL) {
> > +			task_set_no_new_privs(p);
> > +			flags |= PIDFD_AUTOKILL;
> > +		}
> >
> >  		/*
> >  		 * Note that no task has been attached to @pid yet indicate
> >  		 * that via CLONE_PIDFD.
> >  		 */
> > -		retval = pidfd_prepare(pid, flags | PIDFD_STALE, &pidfile);
> > +		retval = pidfd_prepare(pid, flags, &pidfile);
>
> Confused... I think you also need to change pidfs_alloc_file() to restore
> O_TRUNC after do_dentry_open() clears this flag? Just like it curently does
>
> 	pidfd_file->f_flags |= (flags & PIDFD_THREAD);

Aah! please ignore me. Somehow I missed exactly this change in your patch.

Sorry for noise!

Oleg.


