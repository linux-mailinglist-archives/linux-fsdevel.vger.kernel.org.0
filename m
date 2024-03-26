Return-Path: <linux-fsdevel+bounces-15329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3330E88C341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C3BB25D83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95A77440B;
	Tue, 26 Mar 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkE8O2FF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EAD5C61F;
	Tue, 26 Mar 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459187; cv=none; b=T/flWRMsEIpPlfhKurcdcFQXXwZSGWGPwvcgE2V76p17W3yBHrDMnJZNnCBmFk/2m3AirbVF0GpBE1pw9+CwE2+b1VpHLxsRzke2qwEzLa6te+mJUVWtezvll5HSJjgSL7mdcVhwyo6lGNWdjGMQJEx3rrwMebRImCpNXUSo3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459187; c=relaxed/simple;
	bh=DzWrRgZIzXMpvefy2yfoXUd4dNEUUHTlgM0Wd9O7BaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHE1K5mF6rRaSzNk51ZIKeuJ31JEt/qjyBP4q/fZFul3BAG6uQ8N/Q5t7+qkvhdH2l61xYw4sQ1dcqnxhQyLbj+d9yjpS/2xlKN8kIFNYiKPpJXC1hL9k601xz+WDvu3I8OIMBKHRd39xbepiyqOI6UCdxaZqNeM6w1cG8hcdz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkE8O2FF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44435C433F1;
	Tue, 26 Mar 2024 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711459186;
	bh=DzWrRgZIzXMpvefy2yfoXUd4dNEUUHTlgM0Wd9O7BaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkE8O2FFLvywoU3r7MQ2SVci8ViMRh//2dtlYaPJgs19ohBoyqxBrIs2/TV15xbIt
	 c57Yv20emZrtcHPEE+3keIpqfCxCalpxmJJi0jezj6D9+EmtGsCwUyxC+Tq7rR/B5O
	 +WPiYJTbZkjVnsUIbwPfVTP1udMsi0sWvd9WnOHfoAqdztFbrWr+b8MYIeMJdmk2f0
	 ZmnckBhs1fqOifhxZKNZc+pzTOxBTwBBMHikrT3ZkDgzI6r9IjhcaLq5kkLT2ohPmY
	 9GWyurle11jVl6bpvfF6EB4xHAjdIsRh9eAuGRbAvEghoR8yy9NqMUK2BVKyuZyYdp
	 oK5Bx9VU1ukoA==
Date: Tue, 26 Mar 2024 14:19:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 1/5] cleanup: Fix discarded const warning when defining
 lock guard
Message-ID: <20240326-daheim-aluminium-810603172600@brauner>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
 <20240216051640.197378-2-vinicius.gomes@intel.com>
 <20240318-flocken-nagetiere-1e027955d06e@brauner>
 <20240318-dehnen-entdecken-dd436f42f91a@brauner>
 <87msqlq0i8.fsf@intel.com>
 <20240326-steil-sachpreis-cec621ae5c59@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326-steil-sachpreis-cec621ae5c59@brauner>

On Tue, Mar 26, 2024 at 11:53:12AM +0100, Christian Brauner wrote:
> On Mon, Mar 25, 2024 at 05:50:55PM -0700, Vinicius Costa Gomes wrote:
> > Christian Brauner <brauner@kernel.org> writes:
> > 
> > >
> > > So something like this? (Amir?)
> > >
> > >  
> > > -DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock = override_creds_light(_T->lock),
> > > -	     revert_creds_light(_T->lock));
> > > +DEFINE_LOCK_GUARD_1(cred, struct cred,
> > > +		    _T->lock = (struct cred *)override_creds_light(_T->lock),
> > > +		    revert_creds_light(_T->lock));
> > > +
> > > +#define cred_guard(_cred) guard(cred)(((struct cred *)_cred))
> > > +#define cred_scoped_guard(_cred) scoped_guard(cred, ((struct cred *)_cred))
> > >  
> > >  /**
> > >   * get_new_cred_many - Get references on a new set of credentials
> > 
> > Thinking about proposing a PATCH version (with these suggestions applied), Amir
> > has suggested in the past that I should propose two separate series:
> >  (1) introducing the guard helpers + backing file changes;
> >  (2) overlayfs changes;
> > 
> > Any new ideas about this? Or should I go with this plan?
> 
> I mean make it two separate patches and I can provide Amir with a stable
> branch for the cleanup guards. I think that's what he wanted.

But send them out in one series ofc. Amir and I can sort this if needed.

