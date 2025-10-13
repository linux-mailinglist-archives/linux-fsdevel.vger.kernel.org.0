Return-Path: <linux-fsdevel+bounces-64003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB4EBD58D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 590094E85C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287D308F03;
	Mon, 13 Oct 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHAa9Ufx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB7B2BEC2D
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377238; cv=none; b=sEIAsCDcieWOhZRKxLhB5ShzYgQbz/L/mk9LiuMWbZ8v0u44kGIwutMP194QHP4zjLWOt+BqHdLCa/Z40JknOCpvpsEnPGfC+u3ErwJKn/AAKtBYpOSv9uBr0XRfsTlu7sYC0mPHSc2y3tWM/4AmnV/bubQJGNgjdRxWmdSOGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377238; c=relaxed/simple;
	bh=U02xRO8TH94viZsdOoVmRmGMF1FSkVidF3pPj625Dnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlURM0NBMH7xJGZ1gWzzO+0vHx7dgtNijC7p0Dfi2h+BdWTwpQQVkh+g38y8Xm5hDf6X7qi4jEBoqeEp6CKoMH/wLYzvVi7gwXN04DkFnqlJ0jPDDwJVCiafYUKGiVziaemliOO3oyWv3afl6hVTVZ4vuEzfRb4iOnTaVn9XmA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHAa9Ufx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760377235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4snZWujk+jRKVRcGEMqjAzW+5/JH8Xs+LhjE/dMhEU=;
	b=XHAa9UfxSZ/Uu6Ltga8UT7jrCuJsunigQ6cpwbkGUBgapysDDBbvvHo687Dyfd+zTbZkEA
	eFX9i5dQlHY4j54RJ9ia5o48e7nW8SABDIjU3ovE3yKHdIicluhpbPmoeUzd/CyrJ7zFuN
	HOR3Vr02NXoayG5PH0rDuXYeyu/QfSo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-2zdt_QmbNziLDO-MsmJqEg-1; Mon,
 13 Oct 2025 13:40:31 -0400
X-MC-Unique: 2zdt_QmbNziLDO-MsmJqEg-1
X-Mimecast-MFC-AGG-ID: 2zdt_QmbNziLDO-MsmJqEg_1760377230
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E80A1800343;
	Mon, 13 Oct 2025 17:40:30 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.119])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0543D19560A2;
	Mon, 13 Oct 2025 17:40:28 +0000 (UTC)
Date: Mon, 13 Oct 2025 13:44:38 -0400
From: Brian Foster <bfoster@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
Message-ID: <aO06hoYuvDGiCBc7@bfoster>
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Oct 13, 2025 at 03:39:48PM +0200, Miklos Szeredi wrote:
> On Fri, 10 Oct 2025 at 10:46, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
> > similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, verify
> > that it hasn't been invalidated.  If old_mtime is invalid or if
> > FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
> > cache is not invalidated.
> 
> [Adding Brian Foster, the author of FUSE_AUTO_INVAL_DATA patches.
> Link to complete thread:
> https://lore.kernel.org/all/20251009110623.3115511-1-giveme.gulu@gmail.com/#r]
> 
> In summary: auto_inval_data invalidates data cache even if the
> modification was done in a cache consistent manner (i.e. write
> through). This is not generally a consistency problem, because the
> backing file and the cache should be in sync.  The exception is when
> the writeback to the backing file hasn't yet finished and a getattr()
> call triggers invalidation (mtime change could be from a previous
> write), and the not yet written data is invalidated and replaced with
> stale data.
> 

Heh, well that's an old one. ;) I'm probably not going to recall all the
details, but from a quick look at the commits this was to facilitate
support for glusterfs. The original fuse code did an inval across i_size
changes and this patch updated that to try and accommodate overwrites by
doing a similar thing for mtime differences.

If I follow the report correctly, we're basically producing an internal
inconsistency between mtime and cache state that falsely presents as a
remote change, so one of these attr change checks can race with a write
in progress and invalidate cache. Do I have that right?

But still a few questions..

1. Do we know where exactly the mtime update comes from? Is it the write
in progress that updates the file mtime on the backend and creates the
inconsistency?

2. Is it confirmed that auto_inval is the culprit here? It seems logical
to me, but it can also be disabled dynamically so couldn't hurt to
confirm that if there's a reproducer.

3. I don't think we should be able to invalidate "dirty" folios like
this. On a quick look though, it seems we don't mark folios dirty in
this write path. Is that right?

If so, I'm a little curious if that's more of a "no apparent need" thing
since the writeback occurs right in that path vs. that is an actual
wrong thing to do for some reason. Hm?

If the former (and if there is simple confirmation of the auto inval
thing), I'm at least a little curious if marking folios
dirty/writeback/clean here would provide enough serialization against
the inval to prevent this problem.

> The proposed fix was to exclude concurrent reads and writes to the same region.
> 
> But the real issue here is that mtime changes triggered by this client
> should not cause data to be invalidated.  It's not only racy, but it's
> fundamentally wrong.  Unfortunately this is hard to do this correctly.
> Best I can come up with is that any request that expects mtime to be
> modified returns the mtime after the request has completed.
> 

Agreed in general. IIUC, this is ultimately a heuristic that isn't
guaranteed to necessarily get things right for the backing fs. ISTM that
maybe fuse is trying too hard to handle the distributed case correctly
where the backing fs should be the one to implement this sort of thing
through exposed mechanisms. OTOH so long as the heuristic exists we
should probably at least work to make it internally consistent.

> This would be much easier to implement in the fuse server: perform the
> "file changed remotely" check when serving a FUSE_GETATTR request and
> return a flag indicating whether the data needs to be invalidated or
> not.
> 

Indeed something along those lines sounds more elegant long term, IMO.

Brian

> Thoughts?
> 
> Thanks,
> Miklos
> 


