Return-Path: <linux-fsdevel+bounces-12398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8848785ED91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AF7B23C39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685D6FC7;
	Thu, 22 Feb 2024 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y42VscKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27331854;
	Thu, 22 Feb 2024 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560481; cv=none; b=bighMFvtnxScIe9blMRrySrupue9zM9x8WAQFRP4nB3hIbadegZ4hk9Ia3jG0UFuRjMJrJ/Qgn/8dDrAHetzaF/bNYo9v+6o5DVEfS26t377BRgBa/1TPWh6MqWOfAxt1QG/C8OenzmFHLfVi6sMfDVeQ3eWsvTMCwiLoxkZuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560481; c=relaxed/simple;
	bh=vE8G0tEnjCDvKYtM1hAj6g+Z7bZNowrFZogG32m/K70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDpZvRKAXUTBXQBGwzd9zjJ7Y1eK3EPr2OpFFuReeIZ3TIkqLVUpTuoCPJxPq0i8twmEF3uvEi+2XKtUB4/3LK5mM0gXXSqpe3mbw22l8ggW07DuzgjzOVYzAzBCCFED8m92YK9mhUvhw47yiQ27b7wPXgF7JF8ZgezhG4YOo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y42VscKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF65C433C7;
	Thu, 22 Feb 2024 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708560480;
	bh=vE8G0tEnjCDvKYtM1hAj6g+Z7bZNowrFZogG32m/K70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y42VscKrvxtAeYusTRWD6nCdHe83JpVE4gTfo6qOWzSr35vqn+d3jY7Zw5IcL0vnB
	 PakgDEDQ6OPmTo0AK9gFPD6TJx3p4/8JJPJFk4lV1V5VLRgjczH0cX15H6dfnlWs19
	 w9A5I0t+DccGyh5nE/w3d3RJxsfu3btoZCd1VpBOA8jebEHWFizMP5AWg0So7quzxy
	 QjGE4Tti8547FKVzZGuTljGQDc+MGukbKyomzjNKeJn1tK8sY/PgOiEivvyH+Ww0bn
	 a6KlSCCFCx5aeAWxlgoHf4bXLz8WtZSNJ8rbHPmwW6S9h1/qML7j6TvG6WBPb5Dara
	 Fq6dZETVqsoFw==
Date: Wed, 21 Feb 2024 18:07:59 -0600
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
Subject: Re: [PATCH v2 11/25] security: add hooks for set/get/remove of fscaps
Message-ID: <ZdaQX9385Sq3VmMZ@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-11-3039364623bd@kernel.org>
 <CAHC9VhQ5QK_4BaHCj9SEvW9M_suWa9edDXrbw2MiNcn56eoWPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ5QK_4BaHCj9SEvW9M_suWa9edDXrbw2MiNcn56eoWPg@mail.gmail.com>

On Wed, Feb 21, 2024 at 06:31:42PM -0500, Paul Moore wrote:
> On Wed, Feb 21, 2024 at 4:26 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > In preparation for moving fscaps out of the xattr code paths, add new
> > security hooks. These hooks are largely needed because common kernel
> > code will pass around struct vfs_caps pointers, which EVM will need to
> > convert to raw xattr data for verification and updates of its hashes.
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  include/linux/lsm_hook_defs.h |  7 +++++
> >  include/linux/security.h      | 33 +++++++++++++++++++++
> >  security/security.c           | 69 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 109 insertions(+)
> 
> One minor problem below, but assuming you fix that, this looks okay to me.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> 
> > diff --git a/security/security.c b/security/security.c
> > index 3aaad75c9ce8..0d210da9862c 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2351,6 +2351,75 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
> 
> ...
> 
> > +/**
> > + * security_inode_get_fscaps() - Check if reading fscaps is allowed
> > + * @dentry: file
> 
> You are missing an entry for the @idmap parameter.

Fixed, thanks!

