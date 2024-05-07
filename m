Return-Path: <linux-fsdevel+bounces-18925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72398BE93A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A3E1C23CAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A016F844;
	Tue,  7 May 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkRg+bwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8216F299
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099547; cv=none; b=e8/6qidM8Kd00sMbJgPKZCKx5+ndJZC9n+bl24JWkWT9fHwAmA1u3rU+f80+tLCPLM3B+Ans+keKBzwOy8bjAlyOQn2cB1QhOVzEGNm0W/2YqU/Kk3SlqZfe4qCur4LF4nd4dqiJTjExbCC/aPv5lflKhH6aclJzH3cq66noJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099547; c=relaxed/simple;
	bh=6E+24P5wmvhDAgZ8v3CIPCQcRJi6iUGse3AmHM1NHK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZoc1KIAib8cRxIvFHnwngSJjZzsftoXDeI586PqCFX+bpyw/RlTZBplTBygmxnUPw9ktHznQ1t8XGtxm1338PcBO8/N5X1EAxDHEelMmclARWqXo6EiEXVeUgeso4K8dvzPMgAREecwKx+wZei4j9bhu6ZSciwa5PvfLxLJjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkRg+bwr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715099545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiyBLJyHU9ak1Riyxp9GKdq0G0Yxbly1rVCUH0ePK7U=;
	b=MkRg+bwrfB30xIogFd9h8cVGfYYB9s0/MfhpwHeKrtvK5k5QpxgqFCCyMRuvh43TMiDeoY
	Gondoxx3sGQckCcAI5x3vWu8I4kcgnJ6z3IHEVK7PmMI6H1w1Qu3MzwirLQkJw/nn8lAmL
	pSKseP+NMMAKxSE9A/grgy2ROoGNByI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-Vy3rIZKFNIKQWpLBtrTD3w-1; Tue,
 07 May 2024 12:32:23 -0400
X-MC-Unique: Vy3rIZKFNIKQWpLBtrTD3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FF091C29EA0
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 16:32:23 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.146])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 15062492CAA;
	Tue,  7 May 2024 16:32:22 +0000 (UTC)
Date: Tue, 7 May 2024 12:32:41 -0400
From: Brian Foster <bfoster@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	vgoyal@redhat.com
Subject: Re: [PATCH] virtiofs: include a newline in sysfs tag
Message-ID: <ZjpXqTxUge0bg_O3@bfoster>
References: <20240425104400.30222-1-bfoster@redhat.com>
 <20240430173431.GA390186@fedora.redhat.com>
 <ZjkoDqhIti--j1F5@bfoster>
 <20240507140330.GD105913@fedora.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507140330.GD105913@fedora.redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Tue, May 07, 2024 at 10:03:30AM -0400, Stefan Hajnoczi wrote:
> On Mon, May 06, 2024 at 02:57:18PM -0400, Brian Foster wrote:
> > On Tue, Apr 30, 2024 at 01:34:31PM -0400, Stefan Hajnoczi wrote:
> > > On Thu, Apr 25, 2024 at 06:44:00AM -0400, Brian Foster wrote:
> > > > The internal tag string doesn't contain a newline. Append one when
> > > > emitting the tag via sysfs.
> > > > 
> > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > > ---
> > > > 
> > > > Hi all,
> > > > 
> > > > I just noticed this and it seemed a little odd to me compared to typical
> > > > sysfs output, but maybe it was intentional..? Easy enough to send a
> > > > patch either way.. thoughts?
> > > 
> > > Hi Brian,
> > > Orthogonal to the newline issue, sysfs_emit(buf, "%s", fs->tag) is
> > > needed to prevent format string injection. Please mention this in the
> > > commit description. I'm afraid I introduced that bug, sorry!
> > > 
> > 
> > Hi Stefan,
> > 
> > Ah, thanks. That hadn't crossed my mind.
> > 
> > > Regarding newline, I'm concerned that adding a newline might break
> > > existing programs. Unless there is a concrete need to have the newline,
> > > I would keep things as they are.
> > > 
> > 
> > Not sure I follow the concern.. wasn't this interface just added? Did
> > you have certain userspace tools in mind?
> 
> v6.9-rc7 has already been tagged and might be the last tag (I'm not
> sure). If v6.9 is released without the newline, then changing it in the
> next kernel release could cause breakage. Some ideas on how userspace
> might break:
> 
> - Userspace calls mount(2) with the contents of the sysfs attr as the
>   source (i.e. "myfs\n" vs "myfs").
> 
> - Userspace stores the contents of the sysfs attr in a file and runs
>   again later on a new kernel after the format has changed, causing tag
>   comparisons to fail.
> 

OK, fair points.

> > FWIW, my reason for posting this was that the first thing I did to try
> > out this functionality was basically a 'cat /sys/fs/virtiofs/*/tag' to
> > see what fs' were attached to my vm, and then I got a single line
> > concatenation of every virtiofs tag and found that pretty annoying. ;)
> 
> Understood.
> 
> > I don't know that is a concrete need for the newline, but I still find
> > the current behavior kind of odd. That said, I'll defer to you guys if
> > you'd prefer to leave it alone. I just posted a v2 for the format
> > specifier thing as above and you can decide which patch to take or not..
> 
> The v6.9 release will happen soon and I'm not sure if we can still get
> the patch in. I've asked Miklos if your patch can be merged with the
> newline added for v6.9. That would solve the userspace breakage
> concerns.
> 

IMO, this all seems a little overblown. If the only issue ends up
missing the release deadline, then I'd say just mark it as a Fixes:
patch for the original patch in v6.9 (probably should have done that
anyways, I guess). Odds are anybody who's going to use this will pick it
up via a stable kernel (through distros and whatnot) anyways. But again
just my .02. ;)

Brian

> Stefan



