Return-Path: <linux-fsdevel+bounces-34830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E69C9084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 18:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984AC280E4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1518BBAA;
	Thu, 14 Nov 2024 17:06:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF6C433D2;
	Thu, 14 Nov 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604007; cv=none; b=Zzd9UcySQu9ttBC8lVAVtVO9BBmNx7mPDj4p4igToCRpYuoHJp/nDpmPWvXtCUplR/4nkiEW6eMJ1vg/T57tehC2ktrpb2u3BRrOMjXsMz1iLbn2h4l/HJa513tdcDKa0P76c7PNPW7hQd8W6vSrjmr066XX4i06QaGeQdFGPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604007; c=relaxed/simple;
	bh=LBpVriT/45fHDSuwLK7td1akcqS9lpNzp3EEEVmNJIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+0SCZVuXeEelCET4O77YE26dmvjAdaWn3YRIP4Zb2fnS99xwgG6pGRFlGqiT1cFerrB/b20pQHtWgDpwQASAWm2x58Te4Ho+PMPfLsCoCeJtlkJRvDw+erB7FZCF55l56Cb0o3RIFkHdP1EkkOVq3NM2msym+i+GkNAF2Y60vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4AEGah9Z009457;
	Thu, 14 Nov 2024 10:36:43 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4AEGafRI009456;
	Thu, 14 Nov 2024 10:36:41 -0600
Date: Thu, 14 Nov 2024 10:36:41 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Song Liu <song@kernel.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        Song Liu <songliubraving@meta.com>,
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
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
Message-ID: <20241114163641.GA8697@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20241112082600.298035-1-song@kernel.org> <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com> <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com> <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com> <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com> <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com> <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 14 Nov 2024 10:36:44 -0600 (CST)

On Wed, Nov 13, 2024 at 10:57:05AM -0800, Song Liu wrote:

Good morning, I hope the week is going well for everyone.

> On Wed, Nov 13, 2024 at 10:06???AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 11/12/2024 5:37 PM, Song Liu wrote:
> [...]
> > > Could you provide more information on the definition of "more
> > > consistent" LSM infrastructure?
> >
> > We're doing several things. The management of security blobs
> > (e.g. inode->i_security) has been moved out of the individual
> > modules and into the infrastructure. The use of a u32 secid is
> > being replaced with a more general lsm_prop structure, except
> > where networking code won't allow it. A good deal of work has
> > gone into making the return values of LSM hooks consistent.
> 
> Thanks for the information. Unifying per-object memory usage of
> different LSMs makes sense. However, I don't think we are limiting
> any LSM to only use memory from the lsm_blobs. The LSMs still
> have the freedom to use other memory allocators. BPF inode
> local storage, just like other BPF maps, is a way to manage
> memory. BPF LSM programs have full access to BPF maps. So
> I don't think it makes sense to say this BPF map is used by tracing,
> so we should not allow LSM to use it.
> 
> Does this make sense?

As involved bystanders, some questions and thoughts that may help
further the discussion.

With respect to inode specific storage, the currently accepted pattern
in the LSM world is roughly as follows:

The LSM initialization code, at boot, computes the total amount of
storage needed by all of the LSM's that are requesting inode specific
storage.  A single pointer to that 'blob' of storage is included in
the inode structure.

In an include file, an inline function similar to the following is
declared, whose purpose is to return the location inside of the
allocated storage or 'LSM inode blob' where a particular LSM's inode
specific data structure is located:

static inline struct tsem_inode *tsem_inode(struct inode *inode)
{
	return inode->i_security + tsem_blob_sizes.lbs_inode;
}

In an LSM's implementation code, the function gets used in something
like the following manner:

static int tsem_inode_alloc_security(struct inode *inode)
{
	struct tsem_inode *tsip = tsem_inode(inode);

	/* Do something with the structure pointed to by tsip. */
}

Christian appears to have already chimed in and indicated that there
is no appetite to add another pointer member to the inode structure.

So, if this were to proceed forward, is it proposed that there will be
a 'flag day' requirement to have each LSM that uses inode specific
storage implement a security_inode_alloc() event handler that creates
an LSM specific BPF map key/value pair for that inode?

Which, in turn, would require that the accessor functions be converted
to use a bpf key request to return the LSM specific information for
that inode?

A flag day event is always somewhat of a concern, but the larger
concern may be the substitution of simple pointer arithmetic for a
body of more complex code.  One would assume with something like this,
that there may be a need for a shake-out period to determine what type
of potential regressions the more complex implementation may generate,
with regressions in security sensitive code always a concern.

In a larger context.  Given that the current implementation works on
simple pointer arithmetic over a common block of storage, there is not
much of a safety guarantee that one LSM couldn't interfere with the
inode storage of another LSM.  However, using a generic BPF construct
such as a map, would presumably open the level of influence over LSM
specific inode storage to a much larger audience, presumably any BPF
program that would be loaded.

The LSM inode information is obviously security sensitive, which I
presume would be be the motivation for Casey's concern that a 'mistake
by a BPF programmer could cause the whole system to blow up', which in
full disclosure is only a rough approximation of his statement.

We obviously can't speak directly to Casey's concerns.  Casey, any
specific technical comments on the challenges of using a common inode
specific storage architecture?

Song, FWIW going forward.  I don't know how closely you follow LSM
development, but we believe an unbiased observer would conclude that
there is some degree of reticence about BPF's involvement with the LSM
infrastructure by some of the core LSM maintainers, that in turn makes
these types of conversations technically sensitive.

> Song

We will look forward to your thoughts on the above.

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

