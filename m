Return-Path: <linux-fsdevel+bounces-35205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F59D25C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 13:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95725B2899B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F411CCEE8;
	Tue, 19 Nov 2024 12:28:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD51CB307;
	Tue, 19 Nov 2024 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019299; cv=none; b=UDU1jeytUeIBkpE7jCnbYsuQKVG3Auy1V7v4pJ2aHWmg9dd4K6UQLAUEdq5QxgMDE6QdrmtPiMQro5fQYCmvtQCDH9C8sUj1ydszjDgO53HXvtDW28AO2LqEP1XSGX0gCcFRUlkb0rdZyylMqzyiEp7tTS3Fb1AJ1/fClBaEURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019299; c=relaxed/simple;
	bh=KZ5pNKRTZd2Wsnop4Uo5KXxBybI54wxOzs6eCvzDSU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1avRW3FjLyROmMXoSujOAwRHPd5rpXyuD5Jd09cBWb8UCflTW18+yDjiuF1NycGu6j89N7QiUxwEpbmE1PomrQs60PPmgoL01p8wWXuBXxtOAeD9flfxw9vEpx/tpJjMeK/CxExEqkoV6glMn4nwdlevW+S3Dq+VsKMPw7mUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4AJCR8jU019294;
	Tue, 19 Nov 2024 06:27:08 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4AJCR6eq019293;
	Tue, 19 Nov 2024 06:27:06 -0600
Date: Tue, 19 Nov 2024 06:27:06 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Song Liu <songliubraving@meta.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Dr. Greg" <greg@enjellic.com>, Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
Message-ID: <20241119122706.GA19220@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com> <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com> <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com> <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com> <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com> <20241114163641.GA8697@wind.enjellic.com> <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com> <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com> <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com> <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 19 Nov 2024 06:27:08 -0600 (CST)

On Sun, Nov 17, 2024 at 10:59:18PM +0000, Song Liu wrote:

> Hi Christian, James and Jan, 

Good morning, I hope the day is starting well for everyone.

> > On Nov 14, 2024, at 1:49???PM, James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> [...]
> 
> >> 
> >> We can address this with something like following:
> >> 
> >> #ifdef CONFIG_SECURITY
> >>         void                    *i_security;
> >> #elif CONFIG_BPF_SYSCALL
> >>         struct bpf_local_storage __rcu *i_bpf_storage;
> >> #endif
> >> 
> >> This will help catch all misuse of the i_bpf_storage at compile
> >> time, as i_bpf_storage doesn't exist with CONFIG_SECURITY=y. 
> >> 
> >> Does this make sense?
> > 
> > Got to say I'm with Casey here, this will generate horrible and failure
> > prone code.
> > 
> > Since effectively you're making i_security always present anyway,
> > simply do that and also pull the allocation code out of security.c in a
> > way that it's always available?  That way you don't have to special
> > case the code depending on whether CONFIG_SECURITY is defined. 
> > Effectively this would give everyone a generic way to attach some
> > memory area to an inode.  I know it's more complex than this because
> > there are LSM hooks that run from security_inode_alloc() but if you can
> > make it work generically, I'm sure everyone will benefit.

> On a second thought, I think making i_security generic is not 
> the right solution for "BPF inode storage in tracing use cases". 
> 
> This is because i_security serves a very specific use case: it 
> points to a piece of memory whose size is calculated at system 
> boot time. If some of the supported LSMs is not enabled by the 
> lsm= kernel arg, the kernel will not allocate memory in 
> i_security for them. The only way to change lsm= is to reboot 
> the system. BPF LSM programs can be disabled at the boot time, 
> which fits well in i_security. However, BPF tracing programs 
> cannot be disabled at boot time (even we change the code to 
> make it possible, we are not likely to disable BPF tracing). 
> IOW, as long as CONFIG_BPF_SYSCALL is enabled, we expect some 
> BPF tracing programs to load at some point of time, and these 
> programs may use BPF inode storage. 
> 
> Therefore, with CONFIG_BPF_SYSCALL enabled, some extra memory 
> always will be attached to i_security (maybe under a different 
> name, say, i_generic) of every inode. In this case, we should 
> really add i_bpf_storage directly to the inode, because another 
> pointer jump via i_generic gives nothing but overhead. 
> 
> Does this make sense? Or did I misunderstand the suggestion?

There is a colloquialism that seems relevant here: "Pick your poison".

In the greater interests of the kernel, it seems that a generic
mechanism for attaching per inode information is the only realistic
path forward, unless Christian changes his position on expanding
the size of struct inode.

There are two pathways forward.

1.) Attach a constant size 'blob' of storage to each inode.

This is a similar approach to what the LSM uses where each blob is
sized as follows:

S = U * sizeof(void *)

Where U is the number of sub-systems that have a desire to use inode
specific storage.

Each sub-system uses it's pointer slot to manage any additional
storage that it desires to attach to the inode.

This has the obvious advantage of O(1) cost complexity for any
sub-system that wants to access its inode specific storage.

The disadvantage, as you note, is that it wastes memory if a
sub-system does not elect to attach per inode information, for example
the tracing infrastructure.

This disadvantage is parried by the fact that it reduces the size of
the inode proper by 24 bytes (4 pointers down to 1) and allows future
extensibility without colliding with the interests and desires of the
VFS maintainers.

2.) Implement key/value mapping for inode specific storage.

The key would be a sub-system specific numeric value that returns a
pointer the sub-system uses to manage its inode specific memory for a
particular inode.

A participating sub-system in turn uses its identifier to register an
inode specific pointer for its sub-system.

This strategy loses O(1) lookup complexity but reduces total memory
consumption and only imposes memory costs for inodes when a sub-system
desires to use inode specific storage.

Approach 2 requires the introduction of generic infrastructure that
allows an inode's key/value mappings to be located, presumably based
on the inode's pointer value.  We could probably just resurrect the
old IMA iint code for this purpose.

In the end it comes down to a rather standard trade-off in this
business, memory vs. execution cost.

We would posit that option 2 is the only viable scheme if the design
metric is overall good for the Linux kernel eco-system.

> Thanks,
> Song

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

