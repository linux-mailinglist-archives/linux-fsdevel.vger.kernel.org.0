Return-Path: <linux-fsdevel+bounces-13328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F6A86E905
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 20:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DBA1F28E09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 19:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1477B3D0BC;
	Fri,  1 Mar 2024 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOzLd2kh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C939AE3;
	Fri,  1 Mar 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319620; cv=none; b=rRX421dCvk8ouUT7ONm5vuQ5nVvt50sVR017btgFztnQzcXooqsNr2rFGjz9gDu9/1emkN5wCUtYGyg8/fl1MVsz0O+07rD0bt7IaLVLO6sEkcOEiW6TfBSfyBd7+wezlzR+Pz0a7PcDj/lUtAq+pPbvKu/7j2xZl8wsd28F0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319620; c=relaxed/simple;
	bh=CxB7W6l1Tq9Zrm8obA30+CBf87HBfjcY2NxOsDja4tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu4ezvRaMxoNnCPf6sHt/NnWAjtHzqAbwX7OScTb66ZqymeY/UFGmiwEQpZNiCzK5yizlWWggyLM4jR2QoGD/Sqhwn0u94KLu2BVa8/wk89U8f0V+fzFRAj2SguXl31QQlHUEet7C4kfGk9PXQWIkV4gZJEXQbqXhWO4D1fpToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOzLd2kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5540C433F1;
	Fri,  1 Mar 2024 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709319619;
	bh=CxB7W6l1Tq9Zrm8obA30+CBf87HBfjcY2NxOsDja4tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOzLd2khb4RM9yVRZBKtLsYAGgslVXJE6WX7uusLNOBVMlWp/y1vL0AyGGMGGPI59
	 7mdOWXRG2QEB6ScIwCwvk3UMV5Hw3R1Ti69/5V4cG6dq+MiM5W6kBBYCdwldHSQOc8
	 UBmEm8x3eAFkhucdMQ/yXh3PXBtY21uVlYTtl3IA8RF4YuttFqeGPexqSuJmNXzY6r
	 Boyj3E93hWzyEJmqqPdZopzPGxAdAIgSPQ3FMVxtZmpe0bJzuL+9XhRGvampdbny/D
	 7TGVxPidmAJOjzynDBXwd/RddfG4tO9kMY7DH4C8cyANeS22JuQjTjhL7KouXmpwwF
	 W70yLAG0DXNYA==
Date: Fri, 1 Mar 2024 13:00:18 -0600
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
Message-ID: <ZeIlwkUx5lNBrdS9@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>
 <7633ab5d5359116a602cdc8f85afd2561047960e.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7633ab5d5359116a602cdc8f85afd2561047960e.camel@huaweicloud.com>

On Fri, Mar 01, 2024 at 05:30:55PM +0100, Roberto Sassu wrote:
> > +/*
> > + * Inner implementation of vfs_caps_to_xattr() which does not return an
> > + * error if the rootid does not map into @dest_userns.
> > + */
> > +static ssize_t __vfs_caps_to_xattr(struct mnt_idmap *idmap,
> > +				   struct user_namespace *dest_userns,
> > +				   const struct vfs_caps *vfs_caps,
> > +				   void *data, size_t size)
> > +{
> > +	struct vfs_ns_cap_data *ns_caps = data;
> > +	struct vfs_cap_data *caps = (struct vfs_cap_data *)ns_caps;
> > +	kuid_t rootkuid;
> > +	uid_t rootid;
> > +
> > +	memset(ns_caps, 0, size);
> 
> size -> sizeof(*ns_caps) (or an equivalent change)

This is zeroing out the passed buffer, so it should use the size passed
for the buffer. sizeof(*ns_caps) could potentially be more than the size
of the buffer.

Maybe it would be clearer if it was memset(data, 0, size)?

> I was zeroing more (the size of the buffer passed to vfs_getxattr()).
> 
> Roberto

