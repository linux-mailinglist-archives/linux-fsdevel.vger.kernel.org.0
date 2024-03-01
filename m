Return-Path: <linux-fsdevel+bounces-13326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2586E8C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 19:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7577D1C228F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82063C6A4;
	Fri,  1 Mar 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEgSFkvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BD39FF2;
	Fri,  1 Mar 2024 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319005; cv=none; b=qM/0+6AwdcxlDjLBes/JB5+gq0TO2eCOjXvRHqgIAR8xjfmByWavyVqDvou46WyXaRVcmI5/sV8qMoE4fQrZt/3yVachcBOX9ItqjP/D3wz7f/3sqdI/SWNIFwh1Jl0lf6Ne7D5xDrZhC36f+CSLnWa6t8jefIA9xVcS8uAOat8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319005; c=relaxed/simple;
	bh=tLJu7ylBVLKDcDz0H2Gy43nmkrZwb++Fe+dzgeQcDT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlYnCfNHwQvMITNhGwDzkR8qk5ekHNwB76MZJ996CF6wyg0kZD2UUAmmoEx4YpwpNIuWq/VMbpD5/HP5etK4/mJrPDHyO+1dBNQAn9eb2T/1gu0XsM+zFWGELZJAe+7Q9Bbal+HHdImzdird0q9K4avKRfgj8J1sVn5Nv5D83IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEgSFkvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EABAC433C7;
	Fri,  1 Mar 2024 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709319004;
	bh=tLJu7ylBVLKDcDz0H2Gy43nmkrZwb++Fe+dzgeQcDT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEgSFkvEmZJVkzuvCkuWj3Iuk3RWW5AkWQk1LOkhZIsdBGOyuVWDf2rX7zH7R07a5
	 hbFmyKz/cJXxMq5rnzAzlik6vYxKVw6Vhis+L++9H+3mossKO/mLWZ10lyBgk1N/0O
	 JylGz2aTWcWuAq4AEyd7FESvDeof23w3v3HW5IvPgbRPcWSZTConXL3NDB+LAw8hER
	 zwT9jATJZWX1+9DjIwjKiSP61NRHohkFV9dybsfNRQjeFA0DsgCP/3tRoYnv41hw5x
	 S4DUFTNSl/JhfA3nlBV/Y8VuVI7JuEUKYaEYpOBpzLfN2iaQw5lgpjziH2R3m+Qth5
	 NLHd5VFZPV2fw==
Date: Fri, 1 Mar 2024 12:50:03 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	James Morris <jmorris@namei.org>,
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
Message-ID: <ZeIjW9JUeAqd0D85@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-11-3039364623bd@kernel.org>
 <c5b496e53dac2b4b5402cc5aa9a09178d63323b7.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b496e53dac2b4b5402cc5aa9a09178d63323b7.camel@huaweicloud.com>

On Fri, Mar 01, 2024 at 04:59:16PM +0100, Roberto Sassu wrote:
> On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
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
> > 
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 76458b6d53da..7b3c23f9e4a5 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -152,6 +152,13 @@ LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *acl_name)
> >  LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *acl_name)
> > +LSM_HOOK(int, 0, inode_set_fscaps, struct mnt_idmap *idmap,
> > +	 struct dentry *dentry, const struct vfs_caps *caps, int flags);
> > +LSM_HOOK(void, LSM_RET_VOID, inode_post_set_fscaps, struct mnt_idmap *idmap,
> > +	 struct dentry *dentry, const struct vfs_caps *caps, int flags);
> > +LSM_HOOK(int, 0, inode_get_fscaps, struct mnt_idmap *idmap, struct dentry *dentry);
> > +LSM_HOOK(int, 0, inode_remove_fscaps, struct mnt_idmap *idmap,
> > +	 struct dentry *dentry);
> 
> Uhm, there should not be semicolons here.

Yes, I've fixed this already for the next version.

Thanks,
Seth

