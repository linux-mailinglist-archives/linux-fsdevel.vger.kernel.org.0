Return-Path: <linux-fsdevel+bounces-13477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007818703FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AB21F275B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92341C64;
	Mon,  4 Mar 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ehaq55tS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BE3FB8B;
	Mon,  4 Mar 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562284; cv=none; b=tCf8IPQrchVldnUxzU4+DFQM5guLABmbXhLA02wgRwzDrApgS5nbNyzh6b5kWOh0INVfZOc4DuQE+xbemAWgxgQrmjgtw45dx1VS3EukZrRZrM9c4C2Nnrw7vuy4m3ALiF1euyFgaJDamtIQBsnvElM2qR7+YBTDy/6dldr0M0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562284; c=relaxed/simple;
	bh=KITP09qisQQ4/2pZCbAvCnZGgo1XzhvdRiFLcmTHqb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuHfJyOxT9t6whOLSevGq6jOqgoaP3CsnHFYWTLKRIs7+WRZm9squzOC6Q76+4LIcd2RyZpBqzplLDXg/LW24G52qpTM1xDDQV/bs3WEY80mkfjHx+l7HEMBeCMcBI9SxulgVAIAfer7ncmR+NtZpbXwxfKn6rPN/qtEyqnBPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ehaq55tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A25C433C7;
	Mon,  4 Mar 2024 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709562283;
	bh=KITP09qisQQ4/2pZCbAvCnZGgo1XzhvdRiFLcmTHqb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ehaq55tSG+2t9+StHrrqBipANU2b83k2yNcb1blrzEyGt4+jcqmbJN51d+wZP7VYI
	 WjL780kUEccs2iD3JbCsxbUxOk/fIOJL24eDnlUwa/4tj9VjcX/Wt00Ygr4xkeR4BQ
	 48mo7Af1s/UxBDHcU0OfM67z90hF/jhdsIRuTQEKwXzB3s9nMCaUPmQEpi8ZpflqbS
	 sJw3BASxEWhmK6XUyPm9aCTyM2WiO6ufOpj2djBd9O3cJLc5U1AJwpNjDmfFROs9DU
	 a+WRpD1q4ms9UY5U5DCQHf/gQ5Lxxq7wJjhvTc4nA4YwD2pxmEAfZJvbwT9u6baMCy
	 tVWTyPR8PdQGQ==
Date: Mon, 4 Mar 2024 08:24:42 -0600
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
Subject: Re: [PATCH v2 06/25] capability: provide helpers for converting
 between xattrs and vfs_caps
Message-ID: <ZeXZqueCPTNzZtku@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>
 <7633ab5d5359116a602cdc8f85afd2561047960e.camel@huaweicloud.com>
 <ZeIlwkUx5lNBrdS9@do-x1extreme>
 <be91c7158b1b9bed35aa9c3205e8f8e467778a5f.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be91c7158b1b9bed35aa9c3205e8f8e467778a5f.camel@huaweicloud.com>

On Mon, Mar 04, 2024 at 09:33:06AM +0100, Roberto Sassu wrote:
> On Fri, 2024-03-01 at 13:00 -0600, Seth Forshee (DigitalOcean) wrote:
> > On Fri, Mar 01, 2024 at 05:30:55PM +0100, Roberto Sassu wrote:
> > > > +/*
> > > > + * Inner implementation of vfs_caps_to_xattr() which does not return an
> > > > + * error if the rootid does not map into @dest_userns.
> > > > + */
> > > > +static ssize_t __vfs_caps_to_xattr(struct mnt_idmap *idmap,
> > > > +				   struct user_namespace *dest_userns,
> > > > +				   const struct vfs_caps *vfs_caps,
> > > > +				   void *data, size_t size)
> > > > +{
> > > > +	struct vfs_ns_cap_data *ns_caps = data;
> > > > +	struct vfs_cap_data *caps = (struct vfs_cap_data *)ns_caps;
> > > > +	kuid_t rootkuid;
> > > > +	uid_t rootid;
> > > > +
> > > > +	memset(ns_caps, 0, size);
> > > 
> > > size -> sizeof(*ns_caps) (or an equivalent change)
> > 
> > This is zeroing out the passed buffer, so it should use the size passed
> > for the buffer. sizeof(*ns_caps) could potentially be more than the size
> > of the buffer.
> 
> Uhm, then maybe the problem is that you are passing the wrong argument?
> 
> ssize_t
> do_getxattr(struct mnt_idmap *idmap, struct dentry *d,
> 	struct xattr_ctx *ctx)
> {
> 	ssize_t error;
> 	char *kname = ctx->kname->name;
> 
> 	if (is_fscaps_xattr(kname)) {
> 		struct vfs_caps caps;
> 		struct vfs_ns_cap_data data;
> 		int ret;
> 
> 		ret = vfs_get_fscaps(idmap, d, &caps);
> 		if (ret)
> 			return ret;
> 		/*
> 		 * rootid is already in the mount idmap, so pass nop_mnt_idmap
> 		 * so that it won't be mapped.
> 		 */
> 		ret = vfs_caps_to_user_xattr(&nop_mnt_idmap, current_user_ns(),
> 					     &caps, &data, ctx->size);
> 
> 
> ctx->size in my case is 1024 bytes.

Ah, yes that definitely isn't correct. I will fix it, thanks for finding
it.

