Return-Path: <linux-fsdevel+bounces-78826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nTcXK4zkomm67wQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:50:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941B1C30A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E22B73084F03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393142B75E;
	Sat, 28 Feb 2026 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C73sdxY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C531F09AD
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283014; cv=none; b=aNpLvVhwzJy/MWQOJ7e03FTrs6h6BkGgtl5HBiFXN/6UrnflilRwg5XV9xxlPIDcTCdsvg8C2/6NHZHggb1etZy4rE4+slKKtqB2UiY5Ay79YH9BckJoBSxk171nG8QNVh+SJquhAxAsDUnluSejAGWp77CvSU8Q3J2xL3IvW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283014; c=relaxed/simple;
	bh=B/q7K1DrEDD1HKv+pKWyeAVJRAUxSM3TAq08ogT1qWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYoienUjfkmHLd2Q2gzQL5ssa0gKbmCXkEhyBELtcV+pnLmO+vF0S/BietXUMHEyOAYuRU87RFVA8y+mUZYaRBmFbF9rIkEnoSclOpqVlg6T0m4WlpKumh5AM1W+MSrmdgrqtaqEsACxaRbetJrtbOQG6+jP89olR0aDYH/TVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C73sdxY+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772283012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4sOn5AHSqgi448usfrFY5mRWU53rDYJ9rLsWoM8w7ro=;
	b=C73sdxY+0hYuvs0btSDsZ58Cc7vTWpPnRKo4RG0kfFqqf5f1RO9Q9tA/pTEEi2r4Okbosq
	PWXqCWSM+RUWp1eLyOmWRpwFYU8G5DRcIsSuRB/tWrJ12GnQ4ofcmMXkrXgPHJI3NEnY0w
	WTTXxwdhlOA/Me1WMoqKFAROSHqn+x0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-rFVCu2jFOIGUyKn6mZlWfQ-1; Sat,
 28 Feb 2026 07:50:02 -0500
X-MC-Unique: rFVCu2jFOIGUyKn6mZlWfQ-1
X-Mimecast-MFC-AGG-ID: rFVCu2jFOIGUyKn6mZlWfQ_1772283001
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D0F81800451;
	Sat, 28 Feb 2026 12:50:01 +0000 (UTC)
Received: from fedora (unknown [10.44.32.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 107E330001B9;
	Sat, 28 Feb 2026 12:49:57 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 28 Feb 2026 13:50:00 +0100 (CET)
Date: Sat, 28 Feb 2026 13:49:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] pidfd: add CLONE_AUTOREAP, CLONE_NNP, and
 CLONE_PIDFD_AUTOKILL
Message-ID: <aaLkdAEaS11Pw_G_@redhat.com>
References: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78826-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0941B1C30A2
X-Rspamd-Action: no action

On 02/26, Christian Brauner wrote:
>
> Christian Brauner (6):
>       clone: add CLONE_AUTOREAP
>       clone: add CLONE_NNP
>       pidfd: add CLONE_PIDFD_AUTOKILL

Well, I still think copy_process should deny
"CLONE_PARENT && current->signal->autoreap", in shis case the
new child will have .exit_signal == 0 without signal->autoreap.
But this really minor.

FWIW, I see no technical problems in 1-3, feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


