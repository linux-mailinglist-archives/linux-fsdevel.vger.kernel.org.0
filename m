Return-Path: <linux-fsdevel+bounces-21853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E490BD0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 23:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F773B21A02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588B198E8F;
	Mon, 17 Jun 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="gRJsNVcg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D16166316;
	Mon, 17 Jun 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661035; cv=none; b=TEw/RNo7X7pdVmPv1FDETby87MIp8oRzT/qN5sD+B59IlqD0jyA+Xj6MiwVahGY8t4xQTEAxry2thBkphAPD6LikD0Jr2KDQ18VbTO+ATK1YSuY1TfO03glSQDzgOiCHU45LwwYsemG2P+ILWUDhvSt0JaibFnQ5N6tLEEwxjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661035; c=relaxed/simple;
	bh=K5996YmuF9Yp/VeUlVnALyukbdeZvYdysz4v9fM3yfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxlJ0IBcRcgzKfDImu3fOuwqmqERE3Sxz+UdOUL+Xt0madrZp8FyLWP+96XGTFZ4aV4Mw7H6+g6L05XvMeN4/ez8DJIeVxMcsMFDdHFYFQ6wmQlczB9jDKxku0x4W+MJTs/yx/t/M1L1I66BjZ+G6A5V00PyLtFD1LlGm1Q2WUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=gRJsNVcg; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5AC4A14C1E3;
	Mon, 17 Jun 2024 23:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718661024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiIgFPt+sEVlD3kUlLI3/jKRfS5oj8sZw2II+1SmJqE=;
	b=gRJsNVcgQ9b9/aamX83T1THpiGBoNbun7e2YBuUibZpxVBifs/D/JFC8KwlYEHn17DvvKt
	D40r91JM2hXgVut6vW+l1LwrB5RyfWk8988PASY9mj80Os7I0ZPoLdfQffBgisSWiMTJWK
	oifVvqMPeVoOxHDbxnshbKF94wGZlTdYrMog5B5G9U2EfEDMiFpfphTPa0QO8ymtPg0zKD
	C5l0LH9K0T/xwb4Wtmv1K79gSu4Q/N3zpIHVcOEppgyazxG6yy5TP4bvMUsZKEojerjx2P
	s48UJ+XD4RKV+iPOAklHilqq6GjZV4zIEMSolexVTwnPBJTvLJbUBgAMqIGogw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d3703de6;
	Mon, 17 Jun 2024 21:50:16 +0000 (UTC)
Date: Tue, 18 Jun 2024 06:50:01 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Kastner <ckk@debian.org>
Cc: David Howells <dhowells@redhat.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Luca Boccassi <bluca@debian.org>, TJ <linux@iam.tj>,
	Emanuele Rocca <ema@debian.org>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <ZnCviUrk5iQGrE4x@codewreck.org>
References: <Zj0ErxVBE3DYT2Ea@gpd>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
 <531994.1716450257@warthog.procyon.org.uk>
 <ZlnnkzXiPPuEK7EM@ariel.home>
 <57e56ca5-bbbc-495a-926e-54d7e2f5e76c@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57e56ca5-bbbc-495a-926e-54d7e2f5e76c@debian.org>

Christian Kastner wrote on Mon, Jun 17, 2024 at 07:10:56PM +0200:
> On 2024-05-31 17:06, Emanuele Rocca wrote:
> > Meanwhile TJ (in CC) has been doing a lot of further investigation and
> > opened https://bugzilla.kernel.org/show_bug.cgi?id=218916.
> 
> just to loop back to the MLs: in the referenced bug, TJ posted an
> analysis and and added a patch that fixed the issue for multiple testers.

Thanks for the mail, one of these days I'll try to understand how to
make bugzilla automatically put me in cc of all the 9p bugs..

Analysis and tentative fix are of great help! Looks like we now
understand what's wrong -- if I understand the description correctly we
know the correct size (files aren't modified in the background, just
other threads within the VM, right?); and the problem is that the netfs
IO reverts the size back to an incorrect value when it completes?

If so then the fix looks odd to me, the problem ought to be fixed at the
netfs/9p interface level, I don't see why an unbuffered read should
update the size metadata when it's done...

David, what do you think?

-- 
Dominique Martinet | Asmadeus

