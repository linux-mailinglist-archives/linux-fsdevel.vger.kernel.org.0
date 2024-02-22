Return-Path: <linux-fsdevel+bounces-12409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1856B85EE09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD137B22BF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397AAEAD2;
	Thu, 22 Feb 2024 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0PJSx2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE41FB2;
	Thu, 22 Feb 2024 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561717; cv=none; b=kVYCnTKJOdRP4FDZDURu01Vuvs+7/rLRFQb13FNjiRifP8LC+9zeoFBFkmbWGBeDXmL/pxwB3OixNu3diINVud5EpHlf9G+lgqKjyy7u6RTyWZS5IFfFfycy8lhjYFpxaUI1zNmk4KUZRo1TIncRgJbEH2eIyoMVJJfvM+jZSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561717; c=relaxed/simple;
	bh=YZ6+Xgmd8ooFkzhBG9c/UeFWshDJf3VAD1VW9Z88ago=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tc5o29c2otw3LGW9W7ZIAL/o0ZsIQdoHtvDoP8nx43ALzT76CHvU1aeNaB7FM1ezluGK12cAt5r+4Vmdgiw0/rwGbdb+yUAjriE+orwLxeC5uPMzGzl/DGuZnfuTwGSSqwho8rkA2SQh2tWlKuzulMLOh9YSJl3UVXTQd1lGvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0PJSx2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0293C433C7;
	Thu, 22 Feb 2024 00:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708561717;
	bh=YZ6+Xgmd8ooFkzhBG9c/UeFWshDJf3VAD1VW9Z88ago=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0PJSx2Mz6286a4r+SQm5k63aQj3YfF5fZkikW5JGMjY7DY9Mepu1R4gTud+GdZ37
	 18QHjW/eJOc1BatX/jPWovN2DRaQMrnQYwYeNb1tOQt25rV1iQ9544SMYb1Nrx3B23
	 XWaglwyE01VhOgYIqEjlL7XDKJRxSJkTj5LXZCSKGCFRe+sN7xci9HsrdUq8viYrL3
	 eaXZxRG53al8uCTEv0YDq6b43NmD7KsUbALRD5Jf+aFQOzWjmFj/nlqwRGRSFGWS7Q
	 8dBzfdwqmFBWENVNo2vZu2wx7e/ON0mKxmGJ1h+vmFFsEzYLoZgPili1Y6Ma9UymAO
	 mPzznB3H5hTjQ==
Date: Wed, 21 Feb 2024 18:28:35 -0600
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
Subject: Re: [PATCH v2 12/25] selinux: add hooks for fscaps operations
Message-ID: <ZdaVM7watDacZojS@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-12-3039364623bd@kernel.org>
 <CAHC9VhTgHP=3Te4=t6chGte15CA_tMoVjFuzBwh+FxQ6Ri4mQQ@mail.gmail.com>
 <ZdaRBBU6K3nvklPI@do-x1extreme>
 <CAHC9VhRr-AO2qrK3ZttsVMsQcJNhZThS7P5_i9dDC7tGPHdVAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRr-AO2qrK3ZttsVMsQcJNhZThS7P5_i9dDC7tGPHdVAA@mail.gmail.com>

On Wed, Feb 21, 2024 at 07:19:07PM -0500, Paul Moore wrote:
> On Wed, Feb 21, 2024 at 7:10 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> > On Wed, Feb 21, 2024 at 06:38:33PM -0500, Paul Moore wrote:
> > > On Wed, Feb 21, 2024 at 4:25 PM Seth Forshee (DigitalOcean)
> > > <sforshee@kernel.org> wrote:
> > > >
> > > > Add hooks for set/get/remove fscaps operations which perform the same
> > > > checks as the xattr hooks would have done for XATTR_NAME_CAPS.
> > > >
> > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > > ---
> > > >  security/selinux/hooks.c | 26 ++++++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index a6bf90ace84c..da129a387b34 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -3367,6 +3367,29 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
> > > >         return -EACCES;
> > > >  }
> > > >
> > > > +static int selinux_inode_set_fscaps(struct mnt_idmap *idmap,
> > > > +                                   struct dentry *dentry,
> > > > +                                   const struct vfs_caps *caps, int flags)
> > > > +{
> > > > +       return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> > > > +}
> > >
> > > The selinux_inode_setxattr() code also has a cap_inode_setxattr()
> > > check which is missing here.  Unless you are handling this somewhere
> > > else, I would expect the function above to look similar to
> > > selinux_inode_remove_fscaps(), but obviously tweaked for setting the
> > > fscaps and not removing them.
> >
> > Right, but cap_inode_setxattr() doesn't do anything for fscaps, so I
> > omitted the call. Unless you think the call should be included in case
> > cap_inode_setxattr() changes in the future, which is a reasonable
> > position.
> 
> Fair enough, but I'd be a lot happier if you included the call in case
> something changes in the future.  I worry that omitting the call would
> make it easier for us to forget about this if/when things change and
> suddenly we have a security issue.  If you are morally opposed to
> that, at the very least put a comment in selinux_inode_set_fscaps()
> about this so we know who to yell at in the future ;)

Makes sense, no objection from me. I'll add it in for v3.

