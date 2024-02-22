Return-Path: <linux-fsdevel+bounces-12484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2AE85FC36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AD11F260F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0990714C5B7;
	Thu, 22 Feb 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh2e4QBZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA691353E2;
	Thu, 22 Feb 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615373; cv=none; b=jkN4VUzrIt1zhNEuN6aFoCo3wLd8w2sP+UTgx8MrS7yFHIGKNHTg7DbDCCWcKx0VmXPhF1kPA82T0rx+ctxvpHGW26pfj0nRrVtuWeJmm1Toy1iZeKwh3WCVs+562AXcnblQgO1WZ1OaC91n9mtB/tQBJWbBNaxQ/KqEofxdWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615373; c=relaxed/simple;
	bh=nIRV4TxaPa6vXCVCxIMnFBsUIz9LyGcVVI0m7g2TYzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4mmP1YkLnjtYHML+/qe9bmNA2RISoEjxzxTJ+sft3/ySA72n5nXTZ0i8ry041jc81Gxp2Rf1w0+X/wSC/y+mlxBqhI1KNxNKOyRVbDN/Mo5idhEA+pghB+7c9jaj3PXAml9AXXJzDSsZEcqGEkX1uiy/WseicWsxoXESLxgYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh2e4QBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EC1C433F1;
	Thu, 22 Feb 2024 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708615372;
	bh=nIRV4TxaPa6vXCVCxIMnFBsUIz9LyGcVVI0m7g2TYzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wh2e4QBZn3IKMQYquvwDC4G6Wa8GTvdSdj+VkXWMspmApkYgGrH1IyNao+davZ9+N
	 ph8/Dd0MxAckccCoxqRklZd4f9Gz32tTkspW1XZRNfBJEDdXdlKyZSvguG5P7DZNYE
	 EYl53YqMTdXoVOhGJ4txQFTCQkwmx/zbFQAUZkWMarulGNDo7JqC0/Uw1KnarHwJco
	 Kl7oSE/lQe4bqaa5oJMI6SfNazuEH9BGmBMNT4DeC86K7ONswklCHrq8nHhvlhhYuv
	 e2F0Bputl9nA/cfmX957EaLzp9x7nWnpItnBESthxAszfsN0yV88BByS6giewzIbGR
	 TR/hyUk/BCbHg==
Date: Thu, 22 Feb 2024 16:22:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 07/25] capability: provide a helper for converting
 vfs_caps to xattr for userspace
Message-ID: <20240222-amortisieren-geblendet-6e977e2d572c@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-7-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-7-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:38PM -0600, Seth Forshee (DigitalOcean) wrote:
> cap_inode_getsecurity() implements a handful of policies for capability
> xattrs read by userspace:
> 
>  - It returns EINVAL if the on-disk capability is in v1 format.
> 
>  - It masks off all bits in magic_etc except for the version and
>    VFS_CAP_FLAGS_EFFECTIVE.
> 
>  - v3 capabilities are converted to v2 format if the rootid returned to
>    userspace would be 0 or if the rootid corresponds to root in an
>    ancestor user namespace.
> 
>  - It returns EOVERFLOW for a v3 capability whose rootid does not map to
>    a valid id in current_user_ns() or to root in an ancestor namespace.
> 
> These policies must be maintained when converting vfs_caps to an xattr
> for userspace. Provide a vfs_caps_to_user_xattr() helper which will
> enforce these policies.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

