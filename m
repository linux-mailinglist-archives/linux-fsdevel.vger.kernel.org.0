Return-Path: <linux-fsdevel+bounces-34849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2894E9C94AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 22:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89623281CF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 21:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B81AF0CE;
	Thu, 14 Nov 2024 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gHI+7GjR";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gHI+7GjR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38876026;
	Thu, 14 Nov 2024 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620974; cv=none; b=eBYUQwkHSsaJ1l9ivWZhaw+34A80Byo/oG2mAD35P1zWmp9+ZVpyK8YcX+npdx7KZOl5h8JptSoHM9QNnTcHeFGOeN6Fwv0nt3P3yn6MoK410jLKoIf8cOsuMnZ09xkFJT2Ozp4kmpNdCvcxacWwBxpKpDbW+sebpIgCT4leqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620974; c=relaxed/simple;
	bh=wS4IETU5H8sOM3r7VeRA6L017b67dL9K8MWdsQ3ApBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hN/4qKiGwkL8/ZxVgsNkMmGcqfRoqhFmS3UNfT15o3uVOuAyNBylmMsunA+5e2WXF/QqSlOjwpBbkXxUo3WxHCvofNJPnJFDl8uj3GJAfMfZ/UMRtlcIyLWOGytBHzh38BOHWFFjQwfTtqyrkVjLRsALlkmVlfIyyodf5IiCgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gHI+7GjR; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gHI+7GjR; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731620970;
	bh=wS4IETU5H8sOM3r7VeRA6L017b67dL9K8MWdsQ3ApBI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gHI+7GjRldAEcpgCpFSXhyICRh0Cfi6dViARKCbystU2jZQ3FtCIQLTLIHc0mbCCn
	 QDmjfK0u9aw2b4pBSES/WV7xbUqdE903v10f7PXPdrGRMlgC8jRfwksr4igdulFBoI
	 GfJvlirt2ofPfEHJgT/uQ+jqe0Zpj7ghrXa/T6Jc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D82BF128171F;
	Thu, 14 Nov 2024 16:49:30 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id qbUAHw1uv0wD; Thu, 14 Nov 2024 16:49:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731620970;
	bh=wS4IETU5H8sOM3r7VeRA6L017b67dL9K8MWdsQ3ApBI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gHI+7GjRldAEcpgCpFSXhyICRh0Cfi6dViARKCbystU2jZQ3FtCIQLTLIHc0mbCCn
	 QDmjfK0u9aw2b4pBSES/WV7xbUqdE903v10f7PXPdrGRMlgC8jRfwksr4igdulFBoI
	 GfJvlirt2ofPfEHJgT/uQ+jqe0Zpj7ghrXa/T6Jc=
Received: from [10.106.168.49] (unknown [167.220.104.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B91D712810F1;
	Thu, 14 Nov 2024 16:49:29 -0500 (EST)
Message-ID: <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing
 prog
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Song Liu <songliubraving@meta.com>, Casey Schaufler
 <casey@schaufler-ca.com>
Cc: "Dr. Greg" <greg@enjellic.com>, Song Liu <song@kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Kernel Team
 <kernel-team@meta.com>,  "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,  "martin.lau@linux.dev"
 <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk"
 <viro@zeniv.linux.org.uk>,  "brauner@kernel.org" <brauner@kernel.org>,
 "jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>, 
 "amir73il@gmail.com" <amir73il@gmail.com>, "repnop@google.com"
 <repnop@google.com>,  "jlayton@kernel.org" <jlayton@kernel.org>, Josef
 Bacik <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>,
 "gnoack@google.com" <gnoack@google.com>
Date: Thu, 14 Nov 2024 13:49:28 -0800
In-Reply-To: <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
	 <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
	 <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
	 <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
	 <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
	 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
	 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
	 <20241114163641.GA8697@wind.enjellic.com>
	 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
	 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-11-14 at 18:08 +0000, Song Liu wrote:
> 
> 
> > On Nov 14, 2024, at 9:29 AM, Casey Schaufler
> > <casey@schaufler-ca.com> wrote:
> 
> [...]
> 
> > > 
> > > 
> > > The LSM inode information is obviously security sensitive, which
> > > I
> > > presume would be be the motivation for Casey's concern that a
> > > 'mistake
> > > by a BPF programmer could cause the whole system to blow up',
> > > which in
> > > full disclosure is only a rough approximation of his statement.
> > > 
> > > We obviously can't speak directly to Casey's concerns.  Casey,
> > > any
> > > specific technical comments on the challenges of using a common
> > > inode
> > > specific storage architecture?
> > 
> > My objection to using a union for the BPF and LSM pointer is based
> > on the observation that a lot of modern programmers don't know what
> > a union does. The BPF programmer would see that there are two ways
> > to accomplish their task, one for CONFIG_SECURITY=y and the other
> > for when it isn't. The second is much simpler. Not understanding
> > how kernel configuration works, nor being "real" C language savvy,
> > the programmer installs code using the simpler interfaces on a
> > Redhat system. The SELinux inode data is compromised by the BPF
> > code, which thinks the data is its own. Hilarity ensues.
> 
> There must be some serious misunderstanding here. So let me 
> explain the idea again. 
> 
> With CONFIG_SECURITY=y, the code will work the same as right now. 
> BPF inode storage uses i_security, just as any other LSMs. 
> 
> With CONFIG_SECURITY=n, i_security does not exist, so the bpf
> inode storage will use i_bpf_storage. 
> 
> Since this is a CONFIG_, all the logic got sorted out at compile
> time. Thus the user API (for user space and for bpf programs) 
> stays the same. 
> 
> 
> Actually, I can understand the concern with union. Although, 
> the logic is set at kernel compile time, it is still possible 
> for kernel source code to use i_bpf_storage when 
> CONFIG_SECURITY is enabled. (Yes, I guess now I finally understand
> the concern). 
> 
> We can address this with something like following:
> 
> #ifdef CONFIG_SECURITY
>         void                    *i_security;
> #elif CONFIG_BPF_SYSCALL
>         struct bpf_local_storage __rcu *i_bpf_storage;
> #endif
> 
> This will help catch all misuse of the i_bpf_storage at compile
> time, as i_bpf_storage doesn't exist with CONFIG_SECURITY=y. 
> 
> Does this make sense?

Got to say I'm with Casey here, this will generate horrible and failure
prone code.

Since effectively you're making i_security always present anyway,
simply do that and also pull the allocation code out of security.c in a
way that it's always available?  That way you don't have to special
case the code depending on whether CONFIG_SECURITY is defined. 
Effectively this would give everyone a generic way to attach some
memory area to an inode.  I know it's more complex than this because
there are LSM hooks that run from security_inode_alloc() but if you can
make it work generically, I'm sure everyone will benefit.

Regards,

James




