Return-Path: <linux-fsdevel+bounces-27227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444B95FA42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60071C2285F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3C19A297;
	Mon, 26 Aug 2024 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qw8uJxn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97021199EA1
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702465; cv=none; b=Jk9b+FWqJeC+sa98okmEPqd5Mk4ff6/O4E+202cEQix7XDJqMDClyUykcibkKNnFKeUPAzaE2fx/CrHZ78u6OD+73wvZtsKK2QZl7nwqiYqTrzqpE1q4erx0fiKIcCeH3YQcBBzeEaiWwyJrcBmACIYMMRb7gHUMrksX30vkn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702465; c=relaxed/simple;
	bh=kPJB+bESNpbtOL49iLVn5rRDI7QgeH5JVuRa7w+C81A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTnAnXafN8pD7cL7mvl081qjNVlVfrUqRBBTBgUEZy06+OnQHesLF5o3weWoMySuPmomSrN5AzhZTXYqCfbby4rt5jRjg8dgrIvDODCI0xeUyMtoPTBm3iCtMMQkbHA+R0kiO/RCh2HycMCot/ekJLQcM9is7rCJioHcSTJyK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qw8uJxn1; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 16:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724702461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=az5h4Wg9eeDfpa4hkRSMfQTELltA5ZhzvE5iac6003M=;
	b=qw8uJxn1gW3AIjoRXCaOoW9baIMfQYPdUt5yGVcp2ljM3f8FSs636XiLJ/PlF7EVKD8ZOH
	h2+RPLeHR2UKk8noJt+TjggJ0TJXjyKiPYFEKjWyojpuhp2tWhQVgAIH8g96M6JZJXDUGY
	hYd8/pVgwjE/UqWcbTSG7V8ePC/F4Uw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <d5zorhk2dmgjjjta2zyqpyaly66ykzsnje4n4j4t5gjxzt57ty@km5j4jktn7fh>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <ZszeUAMgGkGNz8H9@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZszeUAMgGkGNz8H9@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 09:58:08PM GMT, Michal Hocko wrote:
> On Mon 26-08-24 15:39:47, Kent Overstreet wrote:
> > On Mon, Aug 26, 2024 at 10:47:12AM GMT, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > > 
> > > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > > dangerous to use if the caller doesn't control the full call chain with
> > > this flag set. E.g. if any of the function down the chain needed
> > > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > > cause unexpected failure.
> > > 
> > > While this is not the case in this particular case using the scoped gfp
> > > semantic is not really needed bacause we can easily pus the allocation
> > > context down the chain without too much clutter.
> > 
> > yeah, eesh, nack.
> 
> Sure, you can NAK this but then deal with the lack of the PF flag by
> other means. We have made it clear that PF_MEMALLOC_NORECLAIM is not we
> are going to support at the MM level. 
> 
> I have done your homework and shown that it is really easy
> to use gfp flags directly. The net result is passing gfp flag down to
> two functions. Sure part of it is ugglier by having several different
> callbacks implementing it but still manageable. Without too much churn.
> 
> So do whatever you like in the bcache code but do not rely on something
> that is unsupported by the MM layer which you have sneaked in without an
> agreement.

Michal, you're being damned hostile, while posting code you haven't even
tried to compile. Seriously, dude?

How about sticking to the technical issues at hand instead of saying
"this is mm, so my way or the highway?". We're all kernel developers
here, this is not what we do.

