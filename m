Return-Path: <linux-fsdevel+bounces-42718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2BA46AB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 20:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25837A74B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2072238D27;
	Wed, 26 Feb 2025 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPPsEYMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC1236A70;
	Wed, 26 Feb 2025 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597270; cv=none; b=onfq+PHrVsKUq3dNAZdOmaQf/RPEFwPbEJjMhen402XT394g6uAadYGbySmUMXxRZl5I/lgPOPgopEyxQyr/KkehBB18HvpAfCh+GQPgIPi3CWCqWaHZrpN6MF+07eilTzmEOZaFnP6/crD+0TK+O2g/q2jg9uYAMbQUs0j5UZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597270; c=relaxed/simple;
	bh=i/naK2lcPrsZcpnXtdZkpMy9O49yW/4nymiV3W56gVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE70YnSqrB3rFXOk5I/o38FybA6M3gww7JLc+e4qWGTGc6SFBNv661N0t0C+QEqWpwTBdpbWICx7AkmNsp9Y9pI5oAXEvdVwFvdubikmzzzDnBGM1bKmxpsM3jXwFullWk45pezGsMyQ9zgm4UTEnqWBuk9D3jkW/YDjlyL9LVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPPsEYMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF30C4CED6;
	Wed, 26 Feb 2025 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740597269;
	bh=i/naK2lcPrsZcpnXtdZkpMy9O49yW/4nymiV3W56gVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPPsEYMVKXtAClAtFNK+li48+SbI3R4U9WE3gTNwbc19uH7ju2plJ0bOFge5Qcmbh
	 GH7yLggtNe3O8xIQ1EArqN5JI+ChEdjK5DhOXNzDuDTv+1LaNP+8OrCPtXz8szKCS/
	 CSVtN5ioSOLcgiBSYsyL1UIo449oofTIwq0ERDRg=
Date: Wed, 26 Feb 2025 11:13:20 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
Message-ID: <2025022612-stratus-theology-de3c@gregkh>
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>

On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
> > On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
> >> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
> >>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
> >>>
> >>> There are reports of this commit breaking Chrome's rendering mode.  As
> >>> no one seems to want to do a root-cause, let's just revert it for now as
> >>> it is affecting people using the latest release as well as the stable
> >>> kernels that it has been backported to.
> >>
> >> NACK. This re-introduces a CVE.
> > 
> > As I said elsewhere, when a commit that is assigned a CVE is reverted,
> > then the CVE gets revoked.  But I don't see this commit being assigned
> > to a CVE, so what CVE specifically are you referring to?
> 
> https://nvd.nist.gov/vuln/detail/CVE-2024-46701

That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory reads
for offset dir"), which showed up in 6.11 (and only backported to 6.10.7
(which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
d_children list to iterate simple_offset directories") is in 6.14-rc1
and has been backported to 6.6.75, 6.12.12, and 6.13.1.

I don't understand the interaction here, sorry.

> The guideline that "regressions are more important than CVEs" is
> interesting. I hadn't heard that before.

CVEs should not be relevant for development given that we create 10-11
of them a day.  Treat them like any other public bug list please.

But again, I don't understand how reverting this commit relates to the
CVE id you pointed at, what am I missing?

> Still, it seems like we haven't had a chance to actually work on this
> issue yet. It could be corrected by a simple fix. Reverting seems
> premature to me.

I'll let that be up to the vfs maintainers, but I'd push for reverting
first to fix the regression and then taking the time to find the real
change going forward to make our user's lives easier.  Especially as I
don't know who is working on that "simple fix" :)

thanks,

greg k-h

