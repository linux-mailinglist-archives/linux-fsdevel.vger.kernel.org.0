Return-Path: <linux-fsdevel+bounces-56994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB5B1D99B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 16:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74970188886D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A32262FCB;
	Thu,  7 Aug 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Soz6XNQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A00242D84
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575474; cv=none; b=OdssZrjAQAoCrw25sgNrJvATYbBZnjJ5yNxHX5y+OhDtiQqZCuUwc76YW2i/aKBcbS7dFTNymmAZS6ro6ba/5czF2Wn9PTT/tWQQVCM1CVMU4b0IKidhUUQ3CUTwW/iDlWOqIvlTEhQw7tJLYRuFFrQ+qXoREv3E/77OD3E6Yrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575474; c=relaxed/simple;
	bh=CMk97Nfce9AYr014fyggN19TjxQ2vwV9jnv9i012M/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpmmrzvqyl/ZwTM5akFWBMe/iXAvHODjD1WkM/gsCU5nyGKpv8BOibj/4G2UOkjibuWmRC+MInY6REzAJelnCAIXzq/X7N7WsIgDpSszos3cO0F19C+DvFTynj+y/meXXvjPKJpW12hcHJsNUzIbg8hcnP5rT/np9e4tuj5iwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Soz6XNQe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754575471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d16O4y9nXsFhk/FwMerVNXw25kYspWhC/njJ93UTAx8=;
	b=Soz6XNQe1ELABm3teDzDNURvq1AjZxb/RTUvbyyOnCNyTol3Xza8gGjarFZKePqCu2Hq5m
	54qoa09G0NC2K3Tq2jAwn2FNhnsQMe/Wv4+bsA0IlGzA2frIhTH5WYpf2evC2oof3MhhYm
	LuwlO1llXkicSAQsT+AiivWYc5BjAX0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-8DOqnMv2NWut1-jgmgt8-Q-1; Thu,
 07 Aug 2025 10:04:28 -0400
X-MC-Unique: 8DOqnMv2NWut1-jgmgt8-Q-1
X-Mimecast-MFC-AGG-ID: 8DOqnMv2NWut1-jgmgt8-Q_1754575464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9680A19560B5;
	Thu,  7 Aug 2025 14:04:23 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EDC91954185;
	Thu,  7 Aug 2025 14:04:18 +0000 (UTC)
Date: Thu, 7 Aug 2025 10:04:14 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] audit: record fanotify event regardless of presence
 of rules
Message-ID: <aJSyXpsVfU+PfFzN@madcap2.tricolour.ca>
References: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>
 <74767dff9834360b2100907df5142ab9@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74767dff9834360b2100907df5142ab9@paul-moore.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 2025-08-06 21:47, Paul Moore wrote:
> On Aug  6, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
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
> > Link: https://issues.redhat.com/browse/RHEL-9065
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > changelog:
> > v2
> > - re-add audit_enabled check
> > ---
> >  include/linux/audit.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Merged into audit/dev-staging with the plan being to merge it to
> audit/dev once the merge window closes.

Thanks Paul.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570


