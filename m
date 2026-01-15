Return-Path: <linux-fsdevel+bounces-73927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B55ED24D1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 14:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A74383017FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6863A1A4E;
	Thu, 15 Jan 2026 13:51:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF103A1A2B;
	Thu, 15 Jan 2026 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485109; cv=none; b=DiYrU5YogLGRo2LNx8htdqyOSuggmFAk7xm07+1ix8CSHMq/UTKvpKhnH3j7uJmPb5tRvScccHwEUPQdgw2mR5MgQ6t5FWZv0a88sAc1BrZvoNszjb3Dzi4qYIw7c7h4ak7Lmt05kCKCuWiZkpz9NKOWZCc9QBpg1NslkB/NDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485109; c=relaxed/simple;
	bh=c+M3YHnkE9u/NZOHTWdDXVsEeQWJiRbQjINUHDd7wTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxpndEh6HrNUt8LfQbOQ4bDx4TctNGmxqg1d5Ywqnxo9as8YwHwWlwHzUzQqWZfCPe16EuV0V5aFhzRPaqB0bh0ZdevPMGCAlDfCz8B189mNF7IEXq8DmeInUzlaVm2Wt1+vzBF8sOKf+ZZkVHbCeOQv3Za0P1VLwIS6YiKHSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 061E0E0475;
	Thu, 15 Jan 2026 14:46:27 +0100 (CET)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 15 Jan 2026 14:46:27 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>, 
	Luis Henriques <luis@igalia.com>
Subject: Re: Re: [PATCH v4 3/3] fuse: add an implementation of open+getattr
Message-ID: <aWju_kqgdiOZt8gn@fedora.fritz.box>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
 <20260109-fuse-compounds-upstream-v4-3-0d3b82a4666f@ddn.com>
 <CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>
 <aWjteRMwc_KIN4pt@fedora.fritz.box>
 <3223f464-9f76-4c37-b62b-f61f6b1fc1f6@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3223f464-9f76-4c37-b62b-f61f6b1fc1f6@bsbernd.com>

On Thu, Jan 15, 2026 at 02:41:49PM +0100, Bernd Schubert wrote:
> 
> 
> On 1/15/26 14:38, Horst Birthelmer wrote:
> > On Wed, Jan 14, 2026 at 06:29:26PM -0800, Joanne Koong wrote:
> >> On Fri, Jan 9, 2026 at 10:27 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >>>
> >>> +
> >>> +       err = fuse_compound_send(compound);
> >>> +       if (err)
> >>> +               goto out;
> >>> +
> >>> +       err = fuse_compound_get_error(compound, 0);
> >>> +       if (err)
> >>> +               goto out;
> >>> +
> >>> +       err = fuse_compound_get_error(compound, 1);
> >>> +       if (err)
> >>> +               goto out;
> >>
> >> Hmm, if the open succeeds but the getattr fails, why not process it
> >> kernel-side as a success for the open? Especially since on the server
> >> side, libfuse will disassemble the compound request into separate
> >> ones, so the server has no idea the open is even part of a compound.
> >>
> >> I haven't looked at the rest of the patch yet but this caught my
> >> attention when i was looking at how fuse_compound_get_error() gets
> >> used.
> >>
> > After looking at this again ...
> > Do you think it would make sense to add an example of lookup+create, or would that just convolute things?
> 
> 
> I think that will be needed with the LOOKUP_HANDLE from Luis, if we go
> the way Miklos proposes. To keep things simple, maybe not right now?

I was thinking more along the lines of ... we would have more than one example especially for the error handling. Otherwise it is easy to miss something because the given example just doesn't need that special case.
Like the case above. There we would be perfectly fine with a function returning the first error, which in the case of lookup+create is the opposite of success and you would need to access every single error to check what actually happened.

> 
> 
> Thanks,
> Bernd

