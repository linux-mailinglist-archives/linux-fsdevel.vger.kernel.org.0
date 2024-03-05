Return-Path: <linux-fsdevel+bounces-13656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E941A87286A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 21:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D45282644
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79611128827;
	Tue,  5 Mar 2024 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swfNuock"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D48613C;
	Tue,  5 Mar 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669848; cv=none; b=MPs6X6lrmlYqWebmXQ/5I3bqQR3ecvwq3T4zOVEYB68CdZ4WcfMHM0uG0FiRtdqd9I2SvEpk2IjfYWm76Kut8xo2MbGksR8zSD4kyl264qsZX/OrmE+SYyfvDo8M64+/P6Gotw4Gt+ygYMkgXqSalW/ZPyiBU4ZJKSgPPIs6tsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669848; c=relaxed/simple;
	bh=6861cbPK504ommcSxo2vB7OyTQCUdsGAtfNeJdvyvJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzFROUK0m6GpYtbDTdyi+oLYNxpXRdbqDHYfEwR3i3ClkK3jowiyNsbQAivv7Q4e3gVeq3phMbZUHAIG/s28lkkIUN4d9ihvsqUkL/m7tBzLF3+ZWPUmghSCFxesx6zoV3R7hu3J6r5t20L9/0jbvCCSC/9We1gQFbCLqKPEYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swfNuock; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149E6C433C7;
	Tue,  5 Mar 2024 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709669848;
	bh=6861cbPK504ommcSxo2vB7OyTQCUdsGAtfNeJdvyvJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swfNuockyppey7DGeXzQJ3jV8CHoQtMjHp1tiE7fBTRrtgry5fF8tz2FVlvPEAV/w
	 ZnP/3cfuTJpBykA1G6yrNRUmWCYxv/E2uQ4LPbiQrBMhH9hvkWzK7XoegrbKPk9SLe
	 SZHqAOFaAzXR11T0QSiXWiqRs60yH/suKf1rjNX871spM1nuIn5n9ppOxxyYC6SyxY
	 au36vY+W5tuOYNZPgYU2R+XqlUBLN/BCfUt7FLqsnGBIFtctZdzWfeNokHD1omoL0+
	 boRAr/Qw0yMvpqTS98E3TozZwpwGCFd7vMNpI4VMTb9DcFV0E86X+tit5pnMveWnXG
	 bv2pFF0FZEx1A==
Date: Tue, 5 Mar 2024 14:17:27 -0600
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
Subject: Re: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
Message-ID: <Zed91y4MYugjI1/K@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
 <ZeXpbOsdRTbLsYe9@do-x1extreme>
 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
 <ZeX9MRhU/EGhHkCY@do-x1extreme>
 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
 <7058e2f93d16f910336a5380877b14a2e069ee9d.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7058e2f93d16f910336a5380877b14a2e069ee9d.camel@huaweicloud.com>

On Tue, Mar 05, 2024 at 06:11:45PM +0100, Roberto Sassu wrote:
> On Tue, 2024-03-05 at 13:46 +0100, Roberto Sassu wrote:
> > On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcean) wrote:
> > > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) wrote:
> > > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> > > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> > > > > > > > Use the vfs interfaces for fetching file capabilities for killpriv
> > > > > > > > checks and from get_vfs_caps_from_disk(). While there, update the
> > > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it is different
> > > > > > > > from vfs_get_fscaps_nosec().
> > > > > > > > 
> > > > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > > > > > > ---
> > > > > > > >  security/commoncap.c | 30 +++++++++++++-----------------
> > > > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > > > --- a/security/commoncap.c
> > > > > > > > +++ b/security/commoncap.c
> > > > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > > > >   */
> > > > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > > > >  {
> > > > > > > > -	struct inode *inode = d_backing_inode(dentry);
> > > > > > > > +	struct vfs_caps caps;
> > > > > > > >  	int error;
> > > > > > > >  
> > > > > > > > -	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
> > > > > > > > -	return error > 0;
> > > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is unimportant */
> > > > > > > > +	error = vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &caps);
> > > > > > > > +	return error == 0;
> > > > > > > >  }
> > > > > > > >  
> > > > > > > >  /**
> > > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
> > > > > > > >  {
> > > > > > > >  	int error;
> > > > > > > >  
> > > > > > > > -	error = __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> > > > > > > > +	error = vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > > > 
> > > > > > > Uhm, I see that the change is logically correct... but the original
> > > > > > > code was not correct, since the EVM post hook is not called (thus the
> > > > > > > HMAC is broken, or an xattr change is allowed on a portable signature
> > > > > > > which should be not).
> > > > > > > 
> > > > > > > For completeness, the xattr change on a portable signature should not
> > > > > > > happen in the first place, so cap_inode_killpriv() would not be called.
> > > > > > > However, since EVM allows same value change, we are here.
> > > > > > 
> > > > > > I really don't understand EVM that well and am pretty hesitant to try an
> > > > > > change any of the logic around it. But I'll hazard a thought: should EVM
> > > > > > have a inode_need_killpriv hook which returns an error in this
> > > > > > situation?
> > > > > 
> > > > > Uhm, I think it would not work without modifying
> > > > > security_inode_need_killpriv() and the hook definition.
> > > > > 
> > > > > Since cap_inode_need_killpriv() returns 1, the loop stops and EVM would
> > > > > not be invoked. We would need to continue the loop and let EVM know
> > > > > what is the current return value. Then EVM can reject the change.
> > > > > 
> > > > > An alternative way would be to detect that actually we are setting the
> > > > > same value for inode metadata, and maybe not returning 1 from
> > > > > cap_inode_need_killpriv().
> > > > > 
> > > > > I would prefer the second, since EVM allows same value change and we
> > > > > would have an exception if there are fscaps.
> > > > > 
> > > > > This solves only the case of portable signatures. We would need to
> > > > > change cap_inode_need_killpriv() anyway to update the HMAC for mutable
> > > > > files.
> > > > 
> > > > I see. In any case this sounds like a matter for a separate patch
> > > > series.
> > > 
> > > Agreed.
> > 
> > Christian, how realistic is that we don't kill priv if we are setting
> > the same owner?
> > 
> > Serge, would we be able to replace __vfs_removexattr() (or now
> > vfs_get_fscaps_nosec()) with a security-equivalent alternative?
> 
> It seems it is not necessary.
> 
> security.capability removal occurs between evm_inode_setattr() and
> evm_inode_post_setattr(), after the HMAC has been verified and before
> the new HMAC is recalculated (without security.capability).
> 
> So, all good.
> 
> Christian, Seth, I pushed the kernel and the updated tests (all patches
> are WIP):
> 
> https://github.com/robertosassu/linux/commits/evm-fscaps-v2/
> 
> https://github.com/robertosassu/ima-evm-utils/commits/evm-fscaps-v2/
> 
> 
> The tests are passing:
> 
> https://github.com/robertosassu/ima-evm-utils/actions/runs/8159877004/job/22305521359

Thanks! I probably won't be able to take them exactly as-is due to other
changes for the next version (rebasing onto the changes to make IMA and
EVM LSMs, forbidding xattr handlers entirely for fscaps), but they will
serve as a good road map for what needs to happen.

