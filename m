Return-Path: <linux-fsdevel+bounces-12486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37ED85FC57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D43928BEA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858614D445;
	Thu, 22 Feb 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTNThF7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9D39FC7;
	Thu, 22 Feb 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615679; cv=none; b=W22T/z2A85CvFeH/kZBcOSubGQNWf8Vn1LDi+O32KDQ6mZREngdzHxyuiNDbBQfWvSP3TwoiS8A8HPkU/QOqkFchCT19knx09tk+j76n/fjACCThH2F1bQ0zKOsWPXyY1f2DVqOvTQ2BL1dJYr6cX8GpFpG4sJK2T0oS8fr4EBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615679; c=relaxed/simple;
	bh=b+/c1g1bevjJS6ENQgxxzjivp4907xG9QQXiNgmqTj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3jiCuznv23xcvfefuQujkqAh7VDrRv2VBdyjasynmWhHEvN+S2cst5qgH5e2Hg0dnGp6vDGwXjADNQ9BWs/1B4+a5qewJNGWw0zVZ0z6qMmoCr0nZf1Xzx3ZjIJT7HxAJRhA1pZw+4mQkSGPT0UydKTILLKfoQq7nHyRmrWhMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTNThF7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BF5C433F1;
	Thu, 22 Feb 2024 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708615678;
	bh=b+/c1g1bevjJS6ENQgxxzjivp4907xG9QQXiNgmqTj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTNThF7gTQurO5gdJ1GkI+CaFtktmaiJxxkHcV8C6mOXZmDmZndo3Eend4/T+PPZ1
	 OecMMs9q6H0fyqzWuRIEOLvguIG5tCiDI3ok4ALjmGF9A316+J38Bd1PVzWqiOyTvX
	 7QPL1hZKe3EDURzVhYdtZEpv6XcqVlH5z31pKdyKY1AZHNMOEakzwvsjU4jXMxxoSA
	 DdFVnfIHSh0YnUrEjAraDFTpmT2ajq6N9QDwulqfdSLNDDWq5UYSfXRaF4qTJXv57I
	 ZH2lHiVy1Czeym3zx9SuBYLK33jTyNuNX5ae8Z0Et6AVVneuy5H+MKB1oWev60wKzG
	 n2OiDppEBRI+A==
Date: Thu, 22 Feb 2024 16:27:50 +0100
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
Subject: Re: [PATCH v2 00/25] fs: use type-safe uid representation for
 filesystem capabilities
Message-ID: <20240222-fluchen-viren-50e216b653fb@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:31PM -0600, Seth Forshee (DigitalOcean) wrote:
> This series converts filesystem capabilities from passing around raw
> xattr data to using a kernel-internal representation with type safe
> uids, similar to the conversion done previously for posix ACLs.
> Currently fscaps representations in the kernel have two different
> instances of unclear or confused types:
> 
> - fscaps are generally passed around in the raw xattr form, with the
>   rootid sometimes containing the user uid value and at other times
>   containing the filesystem value.
> - The existing kernel-internal representation of fscaps,
>   cpu_vfs_cap_data, uses the kuid_t type, but the value stored is
>   actually a vfsuid.
> 
> This series eliminates this confusion by converting the xattr data to
> the kernel representation near the userspace and filesystem boundaries,
> using the kernel representation within the vfs and commoncap code. The
> internal representation is renamed to vfs_caps to reflect this broader
> use, and the rootid is changed to a vfsuid_t to correctly identify the
> type of uid which it contains.
> 
> New vfs interfaces are added to allow for getting and setting fscaps
> using the kernel representation. This requires the addition of new inode
> operations to allow overlayfs to handle fscaps properly; all other
> filesystems fall back to a generic implementation. The top-level vfs
> xattr interfaces will now reject fscaps xattrs, though the lower-level
> interfaces continue to accept them for reading and writing the raw xattr
> data.
> 
> Based on previous feedback, new security hooks are added for fscaps
> operations. These are really only needed for EVM, and the selinux and
> smack implementations just peform the same operations that the
> equivalent xattr hooks would have done. Note too that this has not yet
> been updated based on the changes to make EVM into an LSM.
> 
> The remainder of the changes are preparatory work, addition of helpers
> for converting between the xattr and kernel fscaps representation, and
> various updates to use the kernel representation and new interfaces.

I still think that the generic_{get,set,remove}_fscaps() helpers falling
back to plain *vfs_*xattr() calls is a hackish. So ideally I'd like to
see this killed in a follow-up series and make all fses that support
them use the inode operation.

> 
> I have tested this code with xfstests, ltp, libcap2, and libcap-ng with
> no regressions found.

+1

