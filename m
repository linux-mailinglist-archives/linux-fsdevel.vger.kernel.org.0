Return-Path: <linux-fsdevel+bounces-12405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B645D85EDDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E755C1C21788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F2B661;
	Thu, 22 Feb 2024 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDxoulQU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B08BE8;
	Thu, 22 Feb 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561215; cv=none; b=uW/LhfFO7xRP7swQpt4ZrOiL3z/kPsw2AJSCG9krlxft2d9ruy7y2R2OUG8gi+UIHRC4zuHMI3ygzDRFz3rDfr1LkU5t4URUeSi+jWmGRxc8rPyaun4q/lJ43c3UKColY6qq+ICUifCK+vUN283V7So5FQ4gVs3Rs8iFh1LBwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561215; c=relaxed/simple;
	bh=XcqhfhNoKUHNxVdP6oKwW+YG9FWcBd4O3WtSRUDQd8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnrQ4E3IM2aRV4HHnRZZn/Smw4Lp3U8ppOBnaOGDKW/xlJoyvr81IoPDBnIbiOuTLUemiLrOX7acNO/YY4JogMxarx0tkT0sBckzO1yJcbPQpSau9JEj0o9BJ4HC+AYDE+MMOzKLLInmYQebNp9wuxqxhN/Hd3pEMalK6y3ewSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDxoulQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32528C433C7;
	Thu, 22 Feb 2024 00:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708561214;
	bh=XcqhfhNoKUHNxVdP6oKwW+YG9FWcBd4O3WtSRUDQd8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDxoulQUlG5j8Io1Tm/pPhUl3ycuHiUYTyWq/ktRN5WuMrey79vE9zW4V3rfFheLy
	 KqMSA58gaS889K1+Jl6fHiWMghXalbwNVb2IYty4i48CcpAhSDIDptWplutXGUy3va
	 v16TzB+FAL9qK6unhUFJPi93PlLu11m/6lfyhm9QBOrGJLfThZQ9iQw7anZnBGLzUt
	 rH1qaBamX/sI8o5udLOl57/zrzg5virquJF8HmX/PUsPSwVlIsRzU2n8qrLO8i5M+1
	 n1oUnyEn10Wrsw+utmU5o9p1KjejTPGOavjwuD94KAX38V2ig60/JDa/bTWH8IMCZI
	 9JWJc4qYmuBJQ==
Date: Wed, 21 Feb 2024 18:20:13 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 15/25] security: call evm fscaps hooks from generic
 security hooks
Message-ID: <ZdaTPV/Ngd8ed/p5@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-15-3039364623bd@kernel.org>
 <CAHC9VhRQ7Xa2_rAjKYA_nkpmfUd9jn2D0SNcb6SjQFg=k8rn=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRQ7Xa2_rAjKYA_nkpmfUd9jn2D0SNcb6SjQFg=k8rn=w@mail.gmail.com>

On Wed, Feb 21, 2024 at 06:43:43PM -0500, Paul Moore wrote:
> On Wed, Feb 21, 2024 at 4:25 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  security/security.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> First off, you've got to write *something* for the commit description,
> even if it is just a single sentence.
> 
> > diff --git a/security/security.c b/security/security.c
> > index 0d210da9862c..f515d8430318 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2365,9 +2365,14 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
> >  int security_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> >                               const struct vfs_caps *caps, int flags)
> >  {
> > +       int ret;
> > +
> >         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> >                 return 0;
> > -       return call_int_hook(inode_set_fscaps, 0, idmap, dentry, caps, flags);
> > +       ret = call_int_hook(inode_set_fscaps, 0, idmap, dentry, caps, flags);
> > +       if (ret)
> > +               return ret;
> > +       return evm_inode_set_fscaps(idmap, dentry, caps, flags);
> >  }
> >
> >  /**
> > @@ -2387,6 +2392,7 @@ void security_inode_post_set_fscaps(struct mnt_idmap *idmap,
> >         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> >                 return;
> >         call_void_hook(inode_post_set_fscaps, idmap, dentry, caps, flags);
> > +       evm_inode_post_set_fscaps(idmap, dentry, caps, flags);
> >  }
> >
> >  /**
> > @@ -2415,9 +2421,14 @@ int security_inode_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
> >   */
> >  int security_inode_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
> >  {
> > +       int ret;
> > +
> >         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> >                 return 0;
> > -       return call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
> > +       ret = call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
> > +       if (ret)
> > +               return ret;
> > +       return evm_inode_remove_fscaps(dentry);
> >  }
> 
> If you take a look at linux-next or the LSM tree's dev branch you'll
> see that we've gotten rid of the dedicated IMA and EVM hooks,
> promoting both IMA and EVM to "proper" LSMs that leverage the existing
> LSM hook infrastructure.  In this patchset, and moving forward, please
> don't add dedicated IMA/EVM hooks like this, instead register them as
> LSM hook implementations with LSM_HOOK_INIT().

Yeah, I'm aware that work was going on and got applied recently. I've
been assuming this change will go in through the vfs tree though, and I
wasn't sure how you and Al/Christian would want to handle that
dependency between your trees, so I held off on updating based off the
LSM tree. I'm happy to update this for the next round though.

Thanks,
Seth

