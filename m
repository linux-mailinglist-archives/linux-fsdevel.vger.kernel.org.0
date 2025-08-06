Return-Path: <linux-fsdevel+bounces-56915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E2B1CE2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 23:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EC418C6483
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 21:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5134220F3F;
	Wed,  6 Aug 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdEVCvoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4141E0E0B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514255; cv=none; b=iPARZL4sOS7xju9uO2+OhQHWiMk3Fb6hiLsAJroz/3swkihtMtNG31Lo3g238HPK1Lo72bd/Xy+JfB9FeoR1ADRT8qpMKlW2Fzw4e6Dw4gDjpUWN78pN57PB7Bg1wrg/q/k0G6mNNzfGUT8xAvlnGHD8Jg84aul9m9SLBFCxgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514255; c=relaxed/simple;
	bh=+LCV1jDSbtCM8xMs6XjHMNRRTJcYyiBwbdn4ReTo/gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzKd37Wc9iomHDoansOZIAeCIBDB7DvzucowpncZcgBeLPn53cThHy4B/hwH8jBEs1jd+GZ6nULIQjv4RzFtGu0ltdtQp+8XLV6YwPOZoWjnj5V5i8aATMZwVPGbmm6pFQkguDll9PSy7+A44DWSDKtCs5sGUMBWS56XYduToYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdEVCvoP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754514252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JeKLDCh0OXtsQCgiYEaDHOZDUteMIsqCidzk53fVSY=;
	b=gdEVCvoPiZKb9+NrlwFdgivtW7qgqfOJOQQdLtgL2OUNLcf9jh2XtfaL9Q736o8i0Gwec+
	J7yw4q9Fby9JDdmU4dcR2o/xw39ZTG0w3gohOD4EZGqosfDYxkbEvqMEjcAjoVAfexjy90
	rgxcfsx7PjdCM/hQrKjEnTNn4u94B0U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-wHny5XraNK-g1JiWa0jbdA-1; Wed,
 06 Aug 2025 17:04:10 -0400
X-MC-Unique: wHny5XraNK-g1JiWa0jbdA-1
X-Mimecast-MFC-AGG-ID: wHny5XraNK-g1JiWa0jbdA_1754514249
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7629180048E;
	Wed,  6 Aug 2025 21:04:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FD4C1956086;
	Wed,  6 Aug 2025 21:04:05 +0000 (UTC)
Date: Wed, 6 Aug 2025 17:04:03 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v1 1/2] audit: record fanotify event regardless of
 presence of rules
Message-ID: <aJPDQ+xdHol4tLzI@madcap2.tricolour.ca>
References: <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
 <fb8db86ae7208a08277ddc0fb949419b@paul-moore.com>
 <aDW5mI2dE7xOMMni@madcap2.tricolour.ca>
 <CAHC9VhTO-bdwzfSeDvJcV19PPfqXn_HM1PUfHe5Z6fPmmsypqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTO-bdwzfSeDvJcV19PPfqXn_HM1PUfHe5Z6fPmmsypqA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 2025-05-29 20:01, Paul Moore wrote:
> On Tue, May 27, 2025 at 9:10 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2025-04-11 14:14, Paul Moore wrote:
> > > On Mar  5, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> > > >
> > > > When no audit rules are in place, fanotify event results are
> > > > unconditionally dropped due to an explicit check for the existence of
> > > > any audit rules.  Given this is a report from another security
> > > > sub-system, allow it to be recorded regardless of the existence of any
> > > > audit rules.
> > > >
> > > > To test, install and run the fapolicyd daemon with default config.  Then
> > > > as an unprivileged user, create and run a very simple binary that should
> > > > be denied.  Then check for an event with
> > > >     ausearch -m FANOTIFY -ts recent
> > > >
> > > > Link: https://issues.redhat.com/browse/RHEL-1367
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > Acked-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  include/linux/audit.h | 8 +-------
> > > >  kernel/auditsc.c      | 2 +-
> > > >  2 files changed, 2 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > > index 0050ef288ab3..d0c6f23503a1 100644
> > > > --- a/include/linux/audit.h
> > > > +++ b/include/linux/audit.h
> > > > @@ -418,7 +418,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
> > > >  extern void __audit_mmap_fd(int fd, int flags);
> > > >  extern void __audit_openat2_how(struct open_how *how);
> > > >  extern void __audit_log_kern_module(char *name);
> > > > -extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
> > > > +extern void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
> > > >  extern void __audit_tk_injoffset(struct timespec64 offset);
> > > >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> > > >  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
> > > > @@ -525,12 +525,6 @@ static inline void audit_log_kern_module(char *name)
> > > >             __audit_log_kern_module(name);
> > > >  }
> > > >
> > > > -static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > > > -{
> > > > -   if (!audit_dummy_context())
> > > > -           __audit_fanotify(response, friar);
> > > > -}
> > >
> > > It seems like we should at least have an audit_enabled() check, yes?
> > > We've had people complain about audit events being generated when audit
> > > is disabled, any while we don't currently have such a check in place
> > > here, I believe the dummy context check is doing that for us.
> > >
> > >   static inline void audit_fanotify(...)
> > >   {
> > >     if (!audit_enabled)
> > >       return;
> > >     __audit_fanotify(...);
> > >   }
> >
> > That would be consistent with other security events messages.  I was
> > going through the selinux code to see what it does and I am missing it
> > if selinux checks with audit_enabled().  Are selinux messages somehow
> > exempt from audit_enabled()?
> 
> There are likely a number of callers in the kernel that don't have
> audit_enabled() checks, some are probably bugs, others probably
> intentional; I wouldn't worry too much about what one subsystem does
> when deciding what to do for another.  In the case of fanotify, I
> suspect the right thing to do is add an audit_enabled() check since it
> is already doing an audit_dummy_context() check.  To be clear, there
> may be some cases where we do an audit_dummy_context() check and doing
> an audit_enabled() check would be wrong, but I don't believe that is
> the case with fanotify.

I totally dropped the ball on this.  I had it respun, tested and
documented, ready to go May 28th and had a note that I'd sent it
complete with Message-ID and I find no evidence it was ever sent.
Re-based, re-tested, sending.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570


