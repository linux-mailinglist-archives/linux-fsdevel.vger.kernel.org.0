Return-Path: <linux-fsdevel+bounces-43477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B03A5717F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 20:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B04166202
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C25254AFD;
	Fri,  7 Mar 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqi/KrB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D425332F
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375191; cv=none; b=RA1EYy3FyFkUt9Az7HJgYMyZ5NWhnV19INb8zBYmujHRqFJCw2SI/0d108uCN1n+W+UMv2m4f4KzInJuyqSXnGAkfhn5SrgUaoMq8jIUQG2Mpzv4s/g+8zFGCPqtMK45GGGkmzp6Ec+wMO80CSeudJ8aCvrXkRF/R2dny+9O6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375191; c=relaxed/simple;
	bh=g4MqkEHiB7Hh07+p3G9AYFM2M8BQsXqZ/GWxguZs4Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAP/tdnH7LyXuCTIHT4+D/cX9VQxONH0dEM2zbRIXbhqYgJ5oul43p8QgUGQXOB2dsx1/0X8OX+ww1SWWEx7vWV7QxpF89a/CL5kycrIvD+voXMPyZaYuNS3BL5A743ErNzp3Me6u930wHjBZYxVC+jmzc9UwA/5bvUbdofbS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqi/KrB5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741375188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrPsYGhY2ctGgSCoMFqFX1XHzK6SWuV8/qZ7voczswo=;
	b=dqi/KrB5ftxd8Vfdq+342YcnhdzY37LFdw/EX9BrHqdmWlIoUIB7BhenpI8W1fHBHfmb3L
	wkOg4muZ++ZMWs1qoSO+oiSvC3203jYdc8DK86RLB+nMx2uE1F+qVXJCjcyN1kbuLlGyej
	VwZ5PVX4rQvOBPL6k6J/2mHHRNQ+v1M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-fHWpz0DVMHiW_mwF1wewHQ-1; Fri,
 07 Mar 2025 14:19:45 -0500
X-MC-Unique: fHWpz0DVMHiW_mwF1wewHQ-1
X-Mimecast-MFC-AGG-ID: fHWpz0DVMHiW_mwF1wewHQ_1741375184
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE68B1955BC9;
	Fri,  7 Mar 2025 19:19:43 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF3161955DCE;
	Fri,  7 Mar 2025 19:19:40 +0000 (UTC)
Date: Fri, 7 Mar 2025 14:19:38 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v1 1/2] audit: record fanotify event regardless of
 presence of rules
Message-ID: <Z8tGyiUzX6p+2vpp@madcap2.tricolour.ca>
References: <cover.1741210251.git.rgb@redhat.com>
 <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
 <aksoenimnsvk4jhxw663spln3pow5x6dys4lbtlfxqtwzwtvs4@yk5ef2tq26l2>
 <Z8pH97tbwt7OGj2o@madcap2.tricolour.ca>
 <jhvf3n4fnzsnj7opxooqblmpnuhvqhcg366y47p5u44dg4tm3i@snmc3msdcoiv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhvf3n4fnzsnj7opxooqblmpnuhvqhcg366y47p5u44dg4tm3i@snmc3msdcoiv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 2025-03-07 15:52, Jan Kara wrote:
> On Thu 06-03-25 20:12:23, Richard Guy Briggs wrote:
> > On 2025-03-06 16:06, Jan Kara wrote:
> > > On Wed 05-03-25 16:33:19, Richard Guy Briggs wrote:
> > > > When no audit rules are in place, fanotify event results are
> > > > unconditionally dropped due to an explicit check for the existence of
> > > > any audit rules.  Given this is a report from another security
> > > > sub-system, allow it to be recorded regardless of the existence of any
> > > > audit rules.
> > > > 
> > > > To test, install and run the fapolicyd daemon with default config.  Then
> > > > as an unprivileged user, create and run a very simple binary that should
> > > > be denied.  Then check for an event with
> > > > 	ausearch -m FANOTIFY -ts recent
> > > > 
> > > > Link: https://issues.redhat.com/browse/RHEL-1367
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > 
> > > I don't know enough about security modules to tell whether this is what
> > > admins want or not so that's up to you but:
> > > 
> > > > -static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > > > -{
> > > > -	if (!audit_dummy_context())
> > > > -		__audit_fanotify(response, friar);
> > > > -}
> > > > -
> > > 
> > > I think this is going to break compilation with !CONFIG_AUDITSYSCALL &&
> > > CONFIG_FANOTIFY?
> > 
> > Why would that break it?  The part of the patch you (prematurely)
> > deleted takes care of that.
> 
> So I'm failing to see how it takes care of that when with
> !CONFIG_AUDITSYSCALL kernel/auditsc.c does not get compiled into the kernel.
> So what does provide the implementation of audit_fanotify() in that case?
> I think you need to provide empty audit_fanotify() inline wrapper for that
> case...

I'm sorry, I responded too quickly without thinking about your question,
my mistake.  It isn't the prototype that was changed in the
CONFIG_SYSCALL case that is relevant in that case.

There was already in existance in the !CONFIG_AUDITSYSCALL case the
inline wrapper to do that job:

	static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
	{ }

Did I understand correctly this time and does this answer your question?

But you do cause me to notice the case that these notifications will be
dropped when CONFIG_AUDIT && !CONFIG_AUDITSYSCALL.

Thanks for persisting.

> 								Honza
> 
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
> > 
> > > -- 
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> > 
> > - RGB
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570


