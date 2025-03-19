Return-Path: <linux-fsdevel+bounces-44439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E5A68C5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B263BEBD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D71A255E4D;
	Wed, 19 Mar 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9yLkn6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C01255229
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385945; cv=none; b=rMbkQUewiD0jbkZnTuum9kNzFATUuPRQui7xcwZskYH03ZGfkfc3KOAjdV2+vr6UAHHpNwptS5iRyGoTaNs8+L3nqJtFnr5kqNT/m7IkoA+6nNE2H/bH/AiIlSaPb/mHSh8HQ1xArCZrdgcKt/kkTn272WfaednuhkKict6+Kqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385945; c=relaxed/simple;
	bh=xtdNJ8nkj5NI3IzOVFP/CzI4pRTgW+Gb1RgNJmnJ/fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLnvy7xT2F1HLNSTwNx6A3JBV7mSOLRA9zWZgLXolIpCAiw2qlG22usFADO+QHjvWRjSs96aNitfkG0elM15QauSa87Z+vB4KiOokGs7vnRaNbAK+pkzi8DIPbaKDhT6Qq6MJ8kHhU5Luqbkj0iLL3FPRIFcXNN4HcD8cAKGNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9yLkn6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742385943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtdNJ8nkj5NI3IzOVFP/CzI4pRTgW+Gb1RgNJmnJ/fw=;
	b=Q9yLkn6XlPTmsUTeODrNaF1dRYtd1dZcR7OBExBUCzmKcxeISATjZ5WRrIvqAEF66dYAeE
	MUKCwAxssluG6uEPX4RIn440TrOCFzhQ/h/jvUboCYup5uxMFFyVhOaHkuEJa+D+zr5gYs
	aN9uM1isZMbMoaL9L1CiPpeM2fZ9bYk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-hCats8CLOiq5oelXu84EGQ-1; Wed,
 19 Mar 2025 08:05:39 -0400
X-MC-Unique: hCats8CLOiq5oelXu84EGQ-1
X-Mimecast-MFC-AGG-ID: hCats8CLOiq5oelXu84EGQ_1742385937
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7800A195608A;
	Wed, 19 Mar 2025 12:05:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C472D3001D0E;
	Wed, 19 Mar 2025 12:05:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Mar 2025 13:05:04 +0100 (CET)
Date: Wed, 19 Mar 2025 13:05:00 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2] pidfs: ensure that PIDFS_INFO_EXIT is available
Message-ID: <20250319120500.GB26879@redhat.com>
References: <20250318-geknebelt-anekdote-87bdb6add5fd@brauner>
 <20250318142601.GA19943@redhat.com>
 <20250319-behielt-zensieren-e63e234730d2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-behielt-zensieren-e63e234730d2@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/19, Christian Brauner wrote:
>
> On Tue, Mar 18, 2025 at 03:46:54PM +0100, Oleg Nesterov wrote:
> >
> > Why pidfs_pid_valid() can't simply return false if !pid_has_task(pid,type) ?
> >
> > pidfd_open() paths check pid_has_task() too and fail if it returns NULL.
> > If this task is already reaped when pidfs_pid_valid() is called, we can
> > pretend it was reaped before sys_pidfd_open() was called?
>
> We could for sure but why would we. If we know that exit information is
> available then returning a pidfd can still be valuable for userspace as
> they can retrieve exit information via PIDFD_INFO_EXIT and it really
> doesn't hurt to do this.

OK, agreed. I thought I missed another subtle reason.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


