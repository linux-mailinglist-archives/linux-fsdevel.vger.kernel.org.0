Return-Path: <linux-fsdevel+bounces-46903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD24A9644D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90170188C645
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA81EA7C6;
	Tue, 22 Apr 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIpNRczK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C61F7092
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314095; cv=none; b=QOuY0a/c9baBgmF94Zx/3XbOAgRFQPqD2sgRc3qfPfg2XZ935Igun3w8JUPF36ql07aIvsY7PV7tQgR31eLPySaqLhBoeZ+y4HEiKiPlSWOStV3BLoD7QW/xh50apTOtnRXSxpaQvp7qmkKnlNCnbWswtnX8te/hCjmq7FZwHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314095; c=relaxed/simple;
	bh=q0bgWa+lDA6Z/ovL84KJsHjikIanDXlPnGTKy9S5HDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smFzAM8d+24aWG8FjdFq3oBQpdwlo1B+Dmg6g1x7XKruL7TEdYsLx2kJDEXTKhSNvqMwcI1JdnEupe/vkpjX572kha12xDJUIJXO1ougzTeefwd2SwO21USzMhQCH1U8aEDN2t8cCvK6czdUEP9avkZX20HVBahcjgQAo4kMIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIpNRczK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E46C4CEE9;
	Tue, 22 Apr 2025 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745314094;
	bh=q0bgWa+lDA6Z/ovL84KJsHjikIanDXlPnGTKy9S5HDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIpNRczKC8Oi6Pe5zS5Ns75IUxH9Bdg4+PcW8ql8novh2AzVKFooeE3Cd/hzB4wdK
	 QhnUY19C7+zo4QEJqtV4BEf1QDq4wD0qioXpfBx4pnJu2lNgDuAyrP9kF1xAetcOZi
	 zzCgP2gaUWyujRoAkAzzTNZpROTpnLAtstLpKAvORqe4D1/fo5B+8dK9N8YFJkOvwP
	 mxjpSLZgy6qBCnH7l65EYyX3iuBDCMqU5NfneMw1Z0H+GbWeybjHpq/diVxZsRzXaG
	 dHa8x2XO8KJWw/OBAJY39sH9w/0Llg3GhTdnjkvvL5qy1NP8qxpZ6+mHxy6sz5mKnf
	 dCmPBoZri1nhQ==
Date: Tue, 22 Apr 2025 11:28:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC 3/3] mnt_idmapping: inline all low-level helpers
Message-ID: <20250422-meerrettich-vorladung-580bdb850994@brauner>
References: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
 <20250416-work-mnt_idmap-s_user_ns-v1-3-273bef3a61ec@kernel.org>
 <CAHk-=wgt5Lw7q_VAHgEC+HT4d5iJos6_shnyOnNBQeT0qrJSXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgt5Lw7q_VAHgEC+HT4d5iJos6_shnyOnNBQeT0qrJSXw@mail.gmail.com>

On Wed, Apr 16, 2025 at 08:04:26AM -0700, Linus Torvalds wrote:
> On Wed, 16 Apr 2025 at 06:17, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Let's inline all low-level helpers and use likely()/unlikely() to help
> > the compiler along.

Sorry, I just had time to get back to this now.

> 
> Hmm. This looks like it might be a mistake - code generation will
> probably not be great, because you still end up calling a real
> function for some of the cases (ie from_kuid() in the actual real
> translation case), so all the register allocation etc issues with
> having a function call largely do remain.

Good point.

> 
> Yes, it inlines things into generic_permission(), and that will avoid
> the function call overhead for the common case (good), but it also
> does make for bigger code generation. And it doesn't actually *change*
> the code - it ends up doing all the same accesses, just the
> instruction flow is slightly different.
> 
> So I think you'd actually be better off with *just* the IOP_USERNS
> patch, and only inlining *that* fast-path case, and keep the other
> cases out-of-line.

Right.

> 
> IOW - instead of only checking IOP_USERNS only in i_user_ns() and
> making it return 'init_user_ns' without doing the pointer following, I
> think you should make just our *existing* inlined i_uid_into_vfsuid()
> helper be the minimal inlined wrapper around just the IOP_USERNS
> logic.
> 
> Because right now the problem with i_uid_into_vfsuid() is two-fold
> 
>  - it does that pointer chasing by calling i_user_ns(inode)
> 
>  - it then calls make_vfsuid() which does lots of pointless extra work
> in the common case
> 
> and I think both should be fixed.

Yes, agreed. I've mentioned that various times on other patch series. It
was just a matter of time and I had prioritized other stuff.

> 
> Btw, make_vfsuid() itself is kind of odd. It does:
> 
>         if (idmap == &nop_mnt_idmap)
>                 return VFSUIDT_INIT(kuid);
>         if (idmap == &invalid_mnt_idmap)
>                 return INVALID_VFSUID;
>         if (initial_idmapping(fs_userns))
>                 uid = __kuid_val(kuid);
>         else
>                 uid = from_kuid(fs_userns, kuid);
>         if (uid == (uid_t)-1)
>                 return INVALID_VFSUID;
>         return VFSUIDT_INIT_RAW(map_id_down(&idmap->uid_map, uid));
> 
> and honestly, that looks just horrendous for the actual simple cases.
> I think it's a historical accident, but the
> 
>                 return VFSUIDT_INIT(kuid);
> 
> and the
> 
>                 uid = __kuid_val(kuid);
>         ....
>         return VFSUIDT_INIT_RAW(map_id_down(&idmap->uid_map, uid));
> 
> things are actually the same exact "no mapping" code for the case we
> care about most. We shouldn't even do that
> 
>         if (uid == (uid_t)-1)
>                 return INVALID_VFSUID;
> 
> case at all for that case, because the no-mapping situation is that
> INVALID_VFSUID *is* (uid_t)-1, so all of this is entirely pointless.
> 
> So I think the inlined fast-case should be that
> 
>         if (idmap == &nop_mnt_idmap || initial_idmapping(fs_userns))
>                 return VFSUIDT_INIT(kuid);
> 
> code, and then the 'initial_idmapping()' thing should check the
> IOP_USERNS bit explicitly, and never use the i_user_ns() helper at all
> etc.
> 
> That case should then be "likely()", and the rest can remain out-of-line.
> 
> IOW: instead of inlining all the helpers, just make the *one* helper
> that we already have (and is already a trivial inline function) be
> much more targeted, and make that fast-case much more explicit.
> 
> Hmm?

Yes, but I'd also like to add the shortcut to i_user_ns() because it's
called in quite a few places that it might actually matter. So both
initial_imdapping() and i_user_ns() should short-circuit ad
initial_idmapping() should take an inode as the argument just as
i_user_ns(). I'll send a new version out today hopefully.

Thanks for taking the time to review this!

