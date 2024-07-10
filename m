Return-Path: <linux-fsdevel+bounces-23478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC392D17F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 14:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E2E283FE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 12:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299719149C;
	Wed, 10 Jul 2024 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zhzCAGF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BE19006D
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614212; cv=none; b=ENcuOOZceZRmDCah5lT5uIiEn+zTJTM7HCh8KCcECscnVcfp98B+scUDKc4PDsVjWIZ1dIHIMcYAiFIGQdUH4Vhrb2+ly5TMrneKkj8M8QMKUH2bwxy+HwYCnaRHfBK7k9uQh8L570HjmhsX6GDVqwcivbKS/hUZ61jA/6ThjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614212; c=relaxed/simple;
	bh=vSt8ATyc0QW2ELjNwenXd0lqCgeHqfN85jWMuOX2ZOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTt6Kr+gSm1sigVlAmhcKd4DPhY8Vh0Qfh1b6V3ZBQdN60tQoljVHMNi7Upqh0lpO2j7I+IDR1URRPZkfXqiZYOWcnff21JuIn2uP4FZ1yR4/2aZyGF4/5dRI1w67T7/pFUcySO4shuZNSFOm5ZuqO2TKx1a//Ewt85Q8dh+WaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zhzCAGF5; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJxpk1YQpzsmx;
	Wed, 10 Jul 2024 14:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720614206;
	bh=qkUVf6tdsMSSUWcWV6e8p4MA3pLxRix77tQItoe1jNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zhzCAGF5s9ET2l9+tmW3qbMoPxije6wbrhoSbv+Se0LFOECSpA7VvvPNjRBpxuU32
	 9tY8U51d4GEqg35DR0ZEa+Qw3sr5w9wK7WnuWLpjusJTLeKmyCJdBJSKhCjcbsBXyc
	 eUs9FQUceaBhR1TfSs7iFRkhAw0a78u4CtEmatrk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJxph4lRRz18YT;
	Wed, 10 Jul 2024 14:23:24 +0200 (CEST)
Date: Wed, 10 Jul 2024 14:23:21 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Kees Cook <keescook@chromium.org>, syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, 
	jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <20240710.Hai0Uj3Phaij@digikod.net>
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
 <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net>
 <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Jun 27, 2024 at 02:28:03PM -0400, Paul Moore wrote:
> On Thu, Jun 27, 2024 at 9:34 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > I didn't find specific issues with Landlock's code except the extra
> > check in hook_inode_free_security().  It looks like inode->i_security is
> > a dangling pointer, leading to UAF.
> >
> > Reading security_inode_free() comments, two things looks weird to me:
> >
> > > /**
> > >  * security_inode_free() - Free an inode's LSM blob
> > >  * @inode: the inode
> > >  *
> > >  * Deallocate the inode security structure and set @inode->i_security to NULL.
> >
> > I don't see where i_security is set to NULL.
> 
> The function header comments are known to be a bit suspect, a side
> effect of being detached from the functions for many years, this may
> be one of those cases.  I tried to fix up the really awful ones when I
> moved the comments back, back I didn't have time to go through each
> one in detail.  Patches to correct the function header comments are
> welcome and encouraged! :)
> 
> > >  */
> > > void security_inode_free(struct inode *inode)
> > > {
> >
> > Shouldn't we add this check here?
> > if (!inode->i_security)
> >         return;
> 
> Unless I'm remembering something wrong, I believe we *should* always
> have a valid i_security pointer each time we are called, if not
> something has gone wrong, e.g. the security_inode_free() hook is no
> longer being called from the right place.  If we add a NULL check, we
> should probably have a WARN_ON(), pr_err(), or something similar to
> put some spew on the console/logs.
> 
> All that said, it would be good to hear some confirmation from the VFS
> folks that the security_inode_free() hook is located in a spot such
> that once it exits it's current RCU critical section it is safe to
> release the associated LSM state.
> 
> It's also worth mentioning that while we always allocate i_security in
> security_inode_alloc() right now, I can see a world where we allocate
> the i_security field based on need using the lsm_blob_size info (maybe
> that works today?  not sure how kmem_cache handled 0 length blobs?).
> The result is that there might be a legitimate case where i_security
> is NULL, yet we still want to call into the LSM using the
> inode_free_security() implementation hook.

Looking at existing LSM implementations, even if some helpers (e.g.
selinux_inode) return NULL if inode->i_security is NULL, this may not be
handled by the callers.  For instance, SELinux always dereferences the
blob pointer in the security_inode_permission() hook.  EVM seems to be
the only one properly handling this case.

Shouldn't we remove all inode->i_security checks and assume it is always
set?  This is currently the case anyway, but it would be clearer this
way and avoid false sense of security (with useless checks).

