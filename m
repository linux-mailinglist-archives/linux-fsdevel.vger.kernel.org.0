Return-Path: <linux-fsdevel+bounces-77576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMydI3S/lWkfUgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:32:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AE7156B26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31B3C3011D74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ED72D73BD;
	Wed, 18 Feb 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW15zfro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE42D837E;
	Wed, 18 Feb 2026 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421482; cv=none; b=UAyzja8svdZPaG8J1d1K9js1YETK/spxwNR9Y8Quh/Dxr8LelYIKzKTIEiN32kp7gq6nKMFtOklVmOmVyG7UvWEC+lTkw6O53UOzZg4MXEuGQsjg8p8VSTDJunKJTp85ekrj8K3XgET1Rbqg2QZV+xLO89Co0XcaHGYV904pwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421482; c=relaxed/simple;
	bh=VgU6I28atZXLQWOybT9ngkln1YsKlEcZz84d8eKEl9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1clSPoKLj5Yq6jr00xN2df2XYkVJUhf6nb0ObAZYxC3tqtcIGt+x9XVn0O0/TtnAQnvEcZNc5VD6gM5+GPR6CO8s7iapZErsbAWhVM8EHaK5Yy/T1lsZbtTA70wJbcSk9IzcNCLjN5d4LdAn7SnEN8h6cFUDXCIRTNhblEwps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW15zfro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD1EC19421;
	Wed, 18 Feb 2026 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771421482;
	bh=VgU6I28atZXLQWOybT9ngkln1YsKlEcZz84d8eKEl9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NW15zfrofWGJMfqdEJMnMRxUk5HiwLD4mwTCYizQNM7G5YYwaoBsKv0SWES2MHyB/
	 TUvnkcamcRq+yU6LwnWJjVasGWgc12le3RwNMNXtncntRtwl/R3PxnBxQ2BygIYkUj
	 5Ck6FnJshTja3OvDiGmKgSguvk1dCgcsLeKHEIEwiEPSUB6+WQpy86MsHlV1EG7xNp
	 o6AC8ceF6dMCKPKQhROEgldkyD6x8QvhzNSaWMvRBZnJougx53h34vt1iULQReCYn7
	 gss7jBc0tg2n6CXR3MsvoXM/uvbNyxp0fAZtc7svieNSGbd2dekIP0fQSOmdFD9zDk
	 H5cjZBDdoHh/A==
Date: Wed, 18 Feb 2026 14:31:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Message-ID: <20260218-wildkatzen-emporsteigen-9eb20f74a8c0@brauner>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
 <aZWnkY_XqQ1-kKO0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZWnkY_XqQ1-kKO0@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77576-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2AE7156B26
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:50:41PM +0100, Oleg Nesterov wrote:
> On 02/17, Christian Brauner wrote:
> >
> > @@ -2470,8 +2479,11 @@ __latent_entropy struct task_struct *copy_process(
> >  	syscall_tracepoint_update(p);
> >  	write_unlock_irq(&tasklist_lock);
> >  
> > -	if (pidfile)
> > +	if (pidfile) {
> > +		if (clone_flags & CLONE_PIDFD_AUTOKILL)
> > +			p->signal->autokill_pidfd = pidfile;
> >  		fd_install(pidfd, pidfile);
> 
> Just curious... Instead of adding signal->autokill_pidfd, can't we
> add another "not fcntl" PIDFD_AUTOKILL flag that lives in ->f_flags ?

This is a version I had as well and yes, that works too!

