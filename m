Return-Path: <linux-fsdevel+bounces-54373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66364AFEEC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 18:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F813B6A9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2D20127D;
	Wed,  9 Jul 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PjxytSW+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117671EB9E3
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077734; cv=none; b=FwSPtTDKKmfVQJInLHzbL4JARUDfGTEnzoQz8II5sggyFE5JyF7LeZg5dv2QbHvN6Z4vZjnJICMf59Eh6po2XDg8fOopY5h94AYE8ikEtBauPiIfZUnJrWKpvsrJAzK2cYulq9LBeIMcnZ/3gkLy+6WODCDVlWVK4V/3tVLiEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077734; c=relaxed/simple;
	bh=x9sp22toYkpc4VtFP6GGbIJjLYOoiHU3v8jcNMvPaTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0dWUyvoSl+y3Nu4HI68Pm9BJIMOnhRxebu8mGmqRHUV21pUk7TGbToLJvFRql9D6o1vnWkdAvUxMQETEnRf65PZ2jnCb0nxgXmVMBAnWQGjD06xYp+tI1AaHkg3I4FFmSwWwTbMrSB0XTYmANDuGYNVWsiGgpa1qpvITxdLuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PjxytSW+; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bcjXH6mb4zNH0;
	Wed,  9 Jul 2025 18:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752077199;
	bh=wDp5dd28Btxni9BGX/xFdhzPZyWhhotO9GBlMsWmrcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjxytSW+GUIQ1kQilkQn1YBWpaBzJdiqxMlmzc3xOBGsjBG+/qilBz9fvlo4i+mDv
	 YfU1wvFgQFgnKKP/yHlb3ycF3lo4KurXxrqPWNMakoE5gjmi4thge5h9B+jTWQ7afr
	 f12TNiPQwhR5XaA2LjD833NmC71N3a0UtLx3UMYo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bcjXG5rnbzwBb;
	Wed,  9 Jul 2025 18:06:38 +0200 (CEST)
Date: Wed, 9 Jul 2025 18:06:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <songliubraving@meta.com>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Tingmao Wang <m@maowtm.org>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Message-ID: <20250709.daHaek7ezame@digikod.net>
References: <127D7BC6-1643-403B-B019-D442A89BADAB@meta.com>
 <175097828167.2280845.5635569182786599451@noble.neil.brown.name>
 <20250707-kneifen-zielvereinbarungen-62c1ccdbb9c6@brauner>
 <20250707-netto-campieren-501525a7d10a@brauner>
 <40D24586-5EC7-462A-9940-425182F2972A@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40D24586-5EC7-462A-9940-425182F2972A@meta.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 07, 2025 at 06:50:12PM +0000, Song Liu wrote:
> Hi Christian, 
> 
> Thanks for your comments! 
> 
> > On Jul 7, 2025, at 4:17 AM, Christian Brauner <brauner@kernel.org> wrote:
> 
> [...]
> 
> >>> 3/ Extend vfs_walk_ancestors() to pass a "may sleep" flag to the callback.
> >> 
> >> I think that's fine.
> > 
> > Ok, sorry for the delay but there's a lot of different things going on
> > right now and this one isn't exactly an easy thing to solve.
> > 
> > I mentioned this before and so did Neil: the lookup implementation
> > supports two modes sleeping and non-sleeping. That api is abstracted
> > away as heavily as possible by the VFS so that non-core code will not be
> > exposed to it other than in exceptional circumstances and doesn't have
> > to care about it.
> > 
> > It is a conceptual dead-end to expose these two modes via separate APIs
> > and leak this implementation detail into non-core code. It will not
> > happen as far as I'm concerned.
> > 
> > I very much understand the urge to get the refcount step-by-step thing
> > merged asap. Everyone wants their APIs merged fast. And if it's
> > reasonable to move fast we will (see the kernfs xattr thing).
> > 
> > But here are two use-cases that ask for the same thing with different
> > constraints that closely mirror our unified approach. Merging one
> > quickly just to have something and then later bolting the other one on
> > top, augmenting, or replacing, possible having to deprecate the old API
> > is just objectively nuts. That's how we end up with a spaghetthi helper
> > collection. We want as little helper fragmentation as possible.
> > 
> > We need a unified API that serves both use-cases. I dislike
> > callback-based APIs generally but we have precedent in the VFS for this
> > for cases where the internal state handling is delicate enough that it
> > should not be exposed (see __iterate_supers() which does exactly work
> > like Neil suggested down to the flag argument itself I added).
> > 
> > So I'm open to the callback solution.
> > 
> > (Note for really absurd perf requirements you could even make it work
> > with static calls I'm pretty sure.)
> 
> I guess we will go with Mickaël’s idea:
> 
> > int vfs_walk_ancestors(struct path *path,
> >                       bool (*walk_cb)(const struct path *ancestor, void *data),

> >                       void *data, int flags)
> > 
> > The walk continue while walk_cb() returns true.  walk_cb() can then
> > check if @ancestor is equal to a @root, or other properties.  The
> > walk_cb() return value (if not bool) should not be returned by
> > vfs_walk_ancestors() because a walk stop doesn't mean an error.
> 
> If necessary, we hide “root" inside @data. This is good. 
> 
> > @path would be updated with latest ancestor path (e.g. @root).
> 
> Update @path to the last ancestor and hold proper references. 
> I missed this part earlier. With this feature, vfs_walk_ancestors 
> should work usable with open-codeed bpf path iterator. 
> 
> I have a question about this behavior with RCU walk. IIUC, RCU 
> walk does not hold reference to @ancestor when calling walk_cb().

I think a reference to the mount should be held, but not necessarily to
the dentry if we are still in the same mount as the original path.

> If walk_cb() returns false, shall vfs_walk_ancestors() then
> grab a reference on @ancestor? This feels a bit weird to me. 

If walk_cb() checks for a root, it will return false when the path will
match, and the caller would expect to get this root path, right?

In general, it's safer to always have the same behavior when holding or
releasing a reference.  I think the caller should then always call
path_put() after vfs_walk_ancestors() whatever the return code is.

> Maybe “updating @path to the last ancestor” should only apply to
> LOOKUP_RCU==false case? 
> 
> > @flags could contain LOOKUP_RCU or not, which enables us to have
> > walk_cb() not-RCU compatible.
> > 
> > When passing LOOKUP_RCU, if the first call to vfs_walk_ancestors()
> > failed with -ECHILD, the caller can restart the walk by calling
> > vfs_walk_ancestors() again but without LOOKUP_RCU.
> 
> 
> Given we want callers to handle -ECHILD and call vfs_walk_ancestors
> again without LOOKUP_RCU, I think we should keep @path not changed
> With LOOKUP_RCU==true, and only update it to the last ancestor 
> when LOOKUP_RCU==false. 

As Neil said, we don't want to explicitly pass LOOKUP_RCU as a public
flag.  Instead, walk_cb() should never sleep (and then potentially be
called under RCU by the vfs_walk_ancestors() implementation).

> 
> With this behavior, landlock code will be like:
> 
> 
> /* Assume we hold reference on “path”. 
>  * With LOOKUP_RCU, path will not change, we don’t need 
>  * extra reference on “path”.
>  */
> err = vfs_walk_ancestors(path, ll_cb, data, LOOKUP_RCU);
> /* 
>  * At this point, whether err is 0 or not, path is not 
>  * changed.
>  */
> 
> if (err == -ECHILD) {
> 	struct path walk_path = *path;
> 
> 	/* reset any data changed by the walk */
> 	reset_data(data);
> 
> 	/* get a reference on walk_path. */
> 	path_get(&walk_path);
> 
> 	err = vfs_walk_ancestors(&walk_path, ll_cb, data, 0);
> 	/* Now, walk_path might be updated */
> 
> 	/* Always release reference on walk_path */
> 	path_put(&walk_path);
> }
> 
> 
> BPF path iterator sode will look like:
> 
> static bool bpf_cb(const struct path *ancestor, void *data)
> {
> 	return false;
> }

Instead of this callback, we could just always return if walk_cb is
NULL.

> 
> struct path *bpf_iter_path_next(struct bpf_iter_path *it)
> {
> 	struct bpf_iter_path_kern *kit = (void *)it;
> 
> 	if (vfs_walk_ancestors(&kit->path, bpf_cb, NULL))
> 		return NULL;
> 	return &kit->path;
> }
> 
> 
> Does this sound reasonable to every body?
> 
> Thanks,
> Song
> 

