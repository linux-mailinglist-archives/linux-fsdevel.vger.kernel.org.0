Return-Path: <linux-fsdevel+bounces-32343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680F9A3CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBEB41F264DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE00204F6C;
	Fri, 18 Oct 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og5DHr7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9F2022EF
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249576; cv=none; b=n2WZENQjvoXZBxHP+IORw55fvcy/jICCiqKzbGJTXj+R10z4szmnk9/e94cO1oQI1DiZKSCrQWHGqh4UMfAVfr9Sq4qpt1l9xwtleHUw+iydoEuAYhjfjtAohYF/JlDopBnXa+2F2mzsGSw4GvEz62bvH5N5TCqpK5ORe6TxMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249576; c=relaxed/simple;
	bh=pNP6GInREHK3+v+2NY7WntrBV4yMOIqy83o+VN8uLNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGYqsn/Od0I4rZkKftkyLymPMuApvXFGqsK8EaBhVL4JsdGWHaCJbqXFOrjyuvbqmvNRPcW2/PCh4ijBALbeHBTWUT8AIsJkLMOS0qPKsXXX7+0k5DU7oj6h/l2roDsrrVQmfE4U8zNZwS6MQTT+5J+RW8vRAdDRXI/J7tGv0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og5DHr7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBA3C4CEC3;
	Fri, 18 Oct 2024 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729249576;
	bh=pNP6GInREHK3+v+2NY7WntrBV4yMOIqy83o+VN8uLNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=og5DHr7IVVsYPAC0gMu6dEC831yZC4pCGVxODA3AFGVuaVOafs0ozvt4wYrkv8eyK
	 E2Tgkiv+O43BekC95QwQ9DLtRJ7DtIzEW7EJqxTuZ/aFNUtfU18STxKt6khZTE6Zbr
	 DWyTH0QzLvMYHohTFuYGXkPVTe9BCTudDUfThWViDTnW3QWvjlHxSmh5kG+oCxXs+W
	 WPSiWvnOvaRaapmEY/+cQff/mbe8DgRbG0g9aaId5WBkkjxWt6nXQl3L9T4qHYfb8d
	 ZUV9g0aXOGvfQKFIlY4iRqBhBbDyw6wuPtegeYfIYkyRASSVZjEpP+nmziaVt3xEWg
	 +ZrjfyEc2ivTQ==
Date: Fri, 18 Oct 2024 13:06:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241018-stadien-einweichen-32632029871a@brauner>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017235459.GN4017910@ZenIV>

On Fri, Oct 18, 2024 at 12:54:59AM +0100, Al Viro wrote:
> On Wed, Oct 16, 2024 at 04:49:48PM +0200, Christian Brauner wrote:
> > On Wed, Oct 16, 2024 at 03:00:50PM +0100, Al Viro wrote:
> > > On Wed, Oct 16, 2024 at 10:32:16AM +0200, Christian Brauner wrote:
> > > 
> > > > > ended up calling user_path_at() with empty pathname and nothing like LOOKUP_EMPTY
> > > > > in lookup_flags.  Which bails out with -ENOENT, since getname() in there does
> > > > > so.  My variant bails out with -EBADF and I'd argue that neither is correct.
> > > > > 
> > > > > Not sure what's the sane solution here, need to think for a while...
> > > > 
> > > > Fwiw, in the other thread we concluded to just not care about AT_FDCWD with "".
> > > > And so far I agree with that.
> > > 
> > > Subject:?
> > 
> > https://lore.kernel.org/r/CAGudoHHdccL5Lh8zAO-0swqqRCW4GXMSXhq4jQGoVj=UdBK-Lg@mail.gmail.com
> > 
> > Hm, this only speaks about the NULL case.
> > 
> > 
> > I just looked through codesearch on github and on debian and the only
> > example I found was
> > https://sources.debian.org/src/snapd/2.65.3-1/tests/main/seccomp-statx/test-snapd-statx/bin/statx.py/?hl=71#L71
> > 
> > So really, just special-case it for statx() imho instead of spreading
> > that ugliness everywhere?
> 
> Not sure, TBH.  I wonder if it would be simpler to have filename_lookup()
> accept NULL for pathname and have it treat that as "".
> 
> Look: all it takes is the following trick
> 	* add const char *pathname to struct nameidata
> 	* in __set_nameidata() add
>         p->pathname = likely(name) ? name->name : "";
> 	* in path_init() replace
> 	const char *s = nd->name->name;
> with
> 	const char *s = nd->pathname;
> and we are done.  Oh, and teach putname() to treat NULL as no-op.

I know, that's what I suggested to Linus initially but he NAKed it
because he didn't want the extra cycles.

> 
> With such changes in fs/namei.c we could do
>         struct filename *name = getname_maybe_null(filename, flags);
> 
> 	if (!name && dfd != AT_FDCWD)
> 		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
> 	ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
> 	putname(name);
> 	return ret;
> in statx(2) and similar in vfs_fstatat().
> 
> With that I'm not even sure we want to bother with separate
> vfs_statx_fd() - the overhead might very well turn out to
> be tolerable.  It is non-zero, but that's a fairly straight
> trip through filename_lookup() machinery.  Would require some
> profiling, though...

