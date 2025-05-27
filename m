Return-Path: <linux-fsdevel+bounces-49905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5579AC4F5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11BB17DD5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6169B2701D1;
	Tue, 27 May 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AO8LFqIn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0B1DF254
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351401; cv=none; b=nOv8XNWFb+dGC2w70tK1mo3Wmt7PRIXVXzlP/qOTOMg/0+MxBW6k+stQHO1y8oz5Byh+dlqzayLYk47MNSLwR8FfBs4QlA2FaxVQuyK8HNIrcLK+Bq1kC5K59/r/BJqRWatgRiQi6xiyryFUSAXPc8d5t89DS6L9K1khXmYVa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351401; c=relaxed/simple;
	bh=PGClDXKS+mM//o82pMKGcF/voIpuJytcmv+gL+wng68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzK156v2fT4I2AxLkIBHf97kzSdvwvsaE5PwiklYMr7hxOqcSjZDRyfyQ+C3/YlUWGhhRYqTAxImWdJEshFoU8hNatCrOz4GsuBY5vm3mAHyltaXDwFaiXxSmXdVofaQvccttMuQSuROGeTOoYKxvG1VMHEIxDncVjo1nCqGc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AO8LFqIn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748351398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd+q10cEIqH15mNq0pVlnhYbQLzcGmo26JmqeljKTxM=;
	b=AO8LFqInAxsRBToB/eMmOXdcW6ImTJYfc5t5SQqOsZ95oUtyGaAB5mbeq9EoMZOD1qAq5U
	LWr/0o8uPTTqEy62jjvHfT7sDQDtxzMhpgJcOLcwcqwSNuF5rdUyhgz9Y1ZkAp9bPg3Haz
	Et6Q+vOUJ4JM0IKDTcZOREUSmCinLFs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-kdOODp4hPOWyIRLC1lSXXw-1; Tue,
 27 May 2025 09:09:54 -0400
X-MC-Unique: kdOODp4hPOWyIRLC1lSXXw-1
X-Mimecast-MFC-AGG-ID: kdOODp4hPOWyIRLC1lSXXw_1748351392
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62F321956088;
	Tue, 27 May 2025 13:09:51 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.74.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54EF118004A7;
	Tue, 27 May 2025 13:09:47 +0000 (UTC)
Date: Tue, 27 May 2025 09:09:44 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v1 1/2] audit: record fanotify event regardless of
 presence  of rules
Message-ID: <aDW5mI2dE7xOMMni@madcap2.tricolour.ca>
References: <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
 <fb8db86ae7208a08277ddc0fb949419b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8db86ae7208a08277ddc0fb949419b@paul-moore.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 2025-04-11 14:14, Paul Moore wrote:
> On Mar  5, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> > 
> > When no audit rules are in place, fanotify event results are
> > unconditionally dropped due to an explicit check for the existence of
> > any audit rules.  Given this is a report from another security
> > sub-system, allow it to be recorded regardless of the existence of any
> > audit rules.
> > 
> > To test, install and run the fapolicyd daemon with default config.  Then
> > as an unprivileged user, create and run a very simple binary that should
> > be denied.  Then check for an event with
> > 	ausearch -m FANOTIFY -ts recent
> > 
> > Link: https://issues.redhat.com/browse/RHEL-1367
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Acked-by: Jan Kara <jack@suse.cz>
> > ---
> >  include/linux/audit.h | 8 +-------
> >  kernel/auditsc.c      | 2 +-
> >  2 files changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 0050ef288ab3..d0c6f23503a1 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -418,7 +418,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
> >  extern void __audit_mmap_fd(int fd, int flags);
> >  extern void __audit_openat2_how(struct open_how *how);
> >  extern void __audit_log_kern_module(char *name);
> > -extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
> > +extern void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
> >  extern void __audit_tk_injoffset(struct timespec64 offset);
> >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> >  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
> > @@ -525,12 +525,6 @@ static inline void audit_log_kern_module(char *name)
> >  		__audit_log_kern_module(name);
> >  }
> >  
> > -static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > -{
> > -	if (!audit_dummy_context())
> > -		__audit_fanotify(response, friar);
> > -}
> 
> It seems like we should at least have an audit_enabled() check, yes?
> We've had people complain about audit events being generated when audit
> is disabled, any while we don't currently have such a check in place
> here, I believe the dummy context check is doing that for us.
> 
>   static inline void audit_fanotify(...)
>   {
>     if (!audit_enabled)
>       return;
>     __audit_fanotify(...);
>   }

That would be consistent with other security events messages.  I was
going through the selinux code to see what it does and I am missing it
if selinux checks with audit_enabled().  Are selinux messages somehow
exempt from audit_enabled()?

> >  static inline void audit_tk_injoffset(struct timespec64 offset)
> >  {
> >  	/* ignore no-op events */
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 0627e74585ce..936825114bae 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2880,7 +2880,7 @@ void __audit_log_kern_module(char *name)
> >  	context->type = AUDIT_KERN_MODULE;
> >  }
> >  
> > -void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > +void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> >  {
> >  	/* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
> >  	switch (friar->hdr.type) {
> > -- 
> > 2.43.5
> 
> --
> paul-moore.com
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570


