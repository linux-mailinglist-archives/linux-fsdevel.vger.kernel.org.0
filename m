Return-Path: <linux-fsdevel+bounces-67149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D46F6C36635
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7492E502294
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC21E334C2B;
	Wed,  5 Nov 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMrvcThp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F1331A59;
	Wed,  5 Nov 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356227; cv=none; b=S11uMwJaf8FrbcnQifEJz0plYqTOW3WzX0Nf8KvSN8tyIeCPKiZ9pCrHNWuhxh4fbkZnLqLcGXeukGDzVllsUt/g4gP+oqJBsqLKB1A7rF1dRW6aAGszQ7tJnLMMaaCiJu1SvgmbN4M8/s8ojVJGOQQHTZ5rR+bCUSXgeYWspYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356227; c=relaxed/simple;
	bh=kUs8Lv2NDX+HzCDICX2X7wBuseMdW6bT2eEf/zscT/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj3T1v/331VyzhdKe9HuEzbzDACObaKZk/f0CION5BGLM1PozB5yuGI9Wymp2UlKrW6pKOfL6kcNCVGmlJNxMyDWfKoDHBvGKonrj9ArOK+3+4Oa3F8X1Ex1t+/IghDsB4fvY9Hj6Yv/U/T60XYXHMaMDj7kKPncOMPonYM6ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMrvcThp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE3FC4CEF5;
	Wed,  5 Nov 2025 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762356226;
	bh=kUs8Lv2NDX+HzCDICX2X7wBuseMdW6bT2eEf/zscT/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMrvcThpY3YAAbWSY9xnzagjiDcwxd3DE9e20MpciQ0mHPg3Rf2Ci/61aau+E4mQM
	 8nZgzHXJSUUcSaMnT3I6e/kc2OTFqEOU8mhgloW70El8EVP4uFuINodUwyZYdb4wN6
	 1lFZyctatEB0Ly2mBkqqT1g1f5kszp3d1j2Gfcxbk6+UPzncHihdjKp/ahdU45prxY
	 rmgoXHjD8Oya/yhaU7KPl20KhLjgM4879Ne2XzlbiGqEnxwVLMRrnoxp2UrzmMsOXc
	 mmWDqocG56Gn6iM3/+Xaa3pHugJb+dKTjiXrnAV7pXWqqp81/F+Ra04o22uyDpfK++
	 osL5X75ZbKhQQ==
Date: Wed, 5 Nov 2025 16:23:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net, 
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, borntraeger@linux.ibm.com, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251105-absatz-zehrt-8d1197f900c9@brauner>
References: <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
 <20251029193755.GU2441659@ZenIV>
 <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
 <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
 <423f5cc5352c54fc21e0570daeeddc4a58e74974.camel@HansenPartnership.com>
 <20251105-sohlen-fenster-e7c5af1204c4@brauner>
 <305ff01c159993d8124ae3125f7dacf6b61fa933.camel@HansenPartnership.com>
 <20251105-ausfiel-klopapier-599213591ad2@brauner>
 <ddc9e2efa25d59ae7f1989ac155b9a9043ca830b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddc9e2efa25d59ae7f1989ac155b9a9043ca830b.camel@HansenPartnership.com>

On Wed, Nov 05, 2025 at 09:01:59AM -0500, James Bottomley wrote:
> On Wed, 2025-11-05 at 14:46 +0100, Christian Brauner wrote:
> > On Wed, Nov 05, 2025 at 08:33:10AM -0500, James Bottomley wrote:
> > > On Wed, 2025-11-05 at 14:16 +0100, Christian Brauner wrote:
> > > > On Wed, Nov 05, 2025 at 08:09:03AM -0500, James Bottomley wrote:
> > > > > On Wed, 2025-11-05 at 12:47 +0100, Christian Brauner wrote:
> > > [...]
> > > > > > And suspend/resume works just fine with freeze/thaw. See
> > > > > > commit
> > > > > > eacfbf74196f ("power: freeze filesystems during
> > > > > > suspend/resume") which implements exactly that.
> > > > > > 
> > > > > > The reason this didn't work for you is very likely:
> > > > > > 
> > > > > > cat /sys/power/freeze_filesystems
> > > > > > 0
> > > > > > 
> > > > > > which you must set to 1.
> > > > > 
> > > > > Actually, no, that's not correct.  The efivarfs freeze/thaw
> > > > > logic must run unconditionally regardless of this setting to
> > > > > fix the systemd bug, so all the variable resyncing is done in
> > > > > the thaw call, which isn't conditioned on the above (or at
> > > > > least it shouldn't be).
> > > > 
> > > > It is conditioned on the above currently but we can certainly fix
> > > > it easily to not be.
> > > 
> > > It still seems to be unconditional in upstream 6.18-rc4
> > > kernel/power/hibernate.c with only freeze being conditioned on the
> > 
> > I'm honestly not sure how efivarfs would be frozen if
> > filesystems_freeze() isn't called... Maybe I missed that memo though.
> > In any case I just sent you...
> 
> We don't need to be frozen: our freeze_fs method is empty, we just need
> thaw_fs calling.

No, you need to call freeze so the power subsystem can mark the
filesystem as being exclusively frozen by it because that specific
freeze must not be undone by anyone else e.g., userspace or some other
internal unfreeze due to some filesystem (for other filesystems this is
very relevant) internal freeze for say scrub or whatever.

If filesystem_thaw() doesn't find efivarfs frozen - and exclusively
frozen by the power subsyste - it obviously won't call the actual
efivarfs thaw method. It's all working in order. My patch should fix
your issue and will ensure efivarfs always runs. We wouldn't even need
an SB_I_* flag for this. We could equally well just match superblock but
other filesystems might need or want to opt into this too.

Don't implement thaw_super() yourself, please.

> 
> Is the trouble that there's now freeze/thaw accounting, so thaw won't
> be called based on that if freeze wasn't?  In which case might it not
> be better for us to implement thaw_super, which is called
> unconditionally and leaves the accounting up to the filesystem?
> 
> > > setting of the filesystem_freeze variable but I haven't checked -
> > > next.
> > > 
> > > However, if there's anything in the works to change that we would
> > > need an exception for efivarfs, please ... we can't have a bug fix
> > > conditioned on a user setting.
> > 
> > ... a patch in another mail.
> > 
> > Sorry in case I misunderstood that you _always_ wanted that sync
> > regardless of userspace enabling it.
> 
> We need the thaw method called to get the variable resync to happen. 
> That fixes a bug on hibernate with systemd (and also accounts for an
> other efi variable changes the user may have made between hibernate and
> resume), yes.  And we need that to happen unconditionally to fix the
> systemd bug.
> 
> Regards,
> 
> James
> 

