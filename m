Return-Path: <linux-fsdevel+bounces-77974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A4MFv13nGlfIAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:53:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C49571791F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B78E6315F060
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9883A3033E2;
	Mon, 23 Feb 2026 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9WzjV/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF93009E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861636; cv=none; b=ODTmNpcJpbTm7T7pJ9AL00fgOySDSXIc1CheuwqoVzu9zHVd6r9Y3G19PlLy3NEep37kE/jI/M8FAMZrYZuItRKW48+jlOi9ffn/pHS9ojBinKBpL8xOBjA89oUTVVUXrboWmfG3hUqAIIdmFVMllZyt4xaJInlF8GSXgs/TVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861636; c=relaxed/simple;
	bh=iHyB59AlPRHpgu0nv4iN8OdrqTn2iD57mlJ8qAQE7fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbRxkTtzCyuqTe+QUSCm778rGEcOxdPFAO3aE4wulSqaWuNkZvFqgsx4KgKq9RBUnTP+zoVOa0A011oIJ6hXN96dZvP2felTWJhiCd/qMelVL46YZ7epim6AMi+rqqenplDttrNUFw+5d+2SMknlilmKjEbXbhoyvyCZcYBhM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9WzjV/j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771861634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxCdAMxs1g6kkp2ZQGBboQJcW5rUk38g9689Mz3dIek=;
	b=b9WzjV/jh0Ra161Y8T3q2F6FLvnmtk6znhyQPmHvI3LLzxniJWMw9ojTsKE+sr58XTLTtT
	Fm1+HS02WGoWVQLhR42wtnVgAsOeuYDivKinM1ctv+FtRrq2gDBi1qnqs7kvHe0ROzIQly
	acvBoFqnghsnkZF1FIJZwQaAC+v3Lso=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-KiD2v9cqNZKA2fwgI8Qrgw-1; Mon,
 23 Feb 2026 10:47:10 -0500
X-MC-Unique: KiD2v9cqNZKA2fwgI8Qrgw-1
X-Mimecast-MFC-AGG-ID: KiD2v9cqNZKA2fwgI8Qrgw_1771861628
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0849195608F;
	Mon, 23 Feb 2026 15:47:07 +0000 (UTC)
Received: from fedora (unknown [10.44.32.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3FB291800465;
	Mon, 23 Feb 2026 15:47:03 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 23 Feb 2026 16:47:07 +0100 (CET)
Date: Mon, 23 Feb 2026 16:47:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Message-ID: <aZx2dlV9tJaL5gDG@redhat.com>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
 <20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77974-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C49571791F6
X-Rspamd-Action: no action

On 02/23, Christian Brauner wrote:
>
> @@ -2259,13 +2268,20 @@ __latent_entropy struct task_struct *copy_process(
>  	 * if the fd table isn't shared).
>  	 */
>  	if (clone_flags & CLONE_PIDFD) {
> -		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
> +		unsigned flags = PIDFD_STALE;
> +
> +		if (clone_flags & CLONE_THREAD)
> +			flags |= PIDFD_THREAD;
> +		if (clone_flags & CLONE_PIDFD_AUTOKILL) {
> +			task_set_no_new_privs(p);
> +			flags |= PIDFD_AUTOKILL;
> +		}
>  
>  		/*
>  		 * Note that no task has been attached to @pid yet indicate
>  		 * that via CLONE_PIDFD.
>  		 */
> -		retval = pidfd_prepare(pid, flags | PIDFD_STALE, &pidfile);
> +		retval = pidfd_prepare(pid, flags, &pidfile);

Confused... I think you also need to change pidfs_alloc_file() to restore
O_TRUNC after do_dentry_open() clears this flag? Just like it curently does

	pidfd_file->f_flags |= (flags & PIDFD_THREAD);

?

Oleg.


