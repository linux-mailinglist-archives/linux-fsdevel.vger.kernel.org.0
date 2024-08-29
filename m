Return-Path: <linux-fsdevel+bounces-27747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 504AD9637FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058D01F23EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F73F25777;
	Thu, 29 Aug 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq7ZobjL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B48814;
	Thu, 29 Aug 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896208; cv=none; b=OoyTbtfVzKFIOBTuSx9ztn6tTV7z6wpgUnf64ImW5aiDV2t6jBauntgtBB4cMn7UbyG1FYN2uNWl7Po4XJX6eBMAQVnexR9cjzt0rn5RT3gXcYoI3G9ACiSQlHeOcKrNR11MqDEndJlzLGgqgOcYdo4dHrf/NukkknWi284dQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896208; c=relaxed/simple;
	bh=hZniCH1MxHuvSisxY/q7sI9AWrbv8tOE6flx81Xn5XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geiY58Skmu1Xgl/bivYw3k15uSUeoUCekgx8wf18FtYX2Y2yZCEY2OZJGXAXu13RKWNJEWO3LY4lgfvRyYPmxOwQOTunEx3feBGQ4G+YTDONb5RpMJ8uWSM3QQGVGVQHbYASpDyxCq8y+Wi55aaneidrSWU+0uSzb/aqEV1X61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq7ZobjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C21FC4CEC0;
	Thu, 29 Aug 2024 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724896208;
	bh=hZniCH1MxHuvSisxY/q7sI9AWrbv8tOE6flx81Xn5XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gq7ZobjLqeW1NxnH7vowre3lrBsdngmjhA9mKZb71Jt8WCl4rvcshwg288GPRPmVA
	 Sj4VyGh8VxyyrKc9BdIDCEMIoaaKad/mrxPu8RZLMFK5Hr9+38WhMIRKTWl+UOSFWC
	 n8D4AFWb9mW6LdYoI1opUKlyFYREOJ9FcLbo3v/T1FoLLAoiah/4gG0W5r7wxngGTq
	 IOC22WEE9b76RI6JYRIzGfewelVzlkNGhC4NN3osEWWGJ4J4TlbKCxql/cKfaqh8RX
	 5yw40UfxMGWJswkC41VQNfqoJ0qFl625NYOVdurLseZhcfmad8mCpi6fHsHurM+w0m
	 9uppqZPmLnbzg==
Date: Wed, 28 Aug 2024 21:50:07 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 00/25] nfs/nfsd: add support for LOCALIO
Message-ID: <Zs_Tz34B3I0SGglp@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <Zs_SHZXnn0xyVQYY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs_SHZXnn0xyVQYY@kernel.org>

On Wed, Aug 28, 2024 at 09:42:53PM -0400, Mike Snitzer wrote:
> On Wed, Aug 28, 2024 at 09:03:55PM -0400, Mike Snitzer wrote:
> > These latest changes are available in my git tree here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> > 
> > I _think_ I addressed all of v13's very helpful review comments.
> > Special thanks to Neil and Chuck for their time and help!
> > 
> > And hopefully I didn't miss anything in the changelog below.
> 
> As it happens, a last minute rebase that I did just before sending out
> v14 caused me to send out 2 stale patches:

I meant these were stale:

[PATCH v14 06/25] NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
[PATCH v14 25/25] nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst

But I've now sent v14.5 to fix each...

> Sorry for the confusion.

Again ;)

