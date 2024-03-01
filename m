Return-Path: <linux-fsdevel+bounces-13293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFFB86E384
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029871C22FEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70AC6EB55;
	Fri,  1 Mar 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkTYwZHI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3E442A;
	Fri,  1 Mar 2024 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303990; cv=none; b=WGw+yuhpsZRQGYbCWNYjZmJe0IVoqJfR8Bk803izm4apQje9HMhyBJBGYf6Nf8sn2a2oZyUBjW0IxIxFjUQPPbDF7nOd/JDXmVdU4SU8MXxQFHCZ9PZOaOMl9zjJT4dnsJXAssRta7GExRjDjBCWsgbr0Pic0wmCTLcvaVS8jTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303990; c=relaxed/simple;
	bh=hxhuvMYF4B3Dog5TINXGHY1tM8RGbN4JK+KayqqRuxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/Ga5q6nw+Gke7sHTyVYku08FrGEkcg7liixt0wduQIxopoKc0PMSAfCNHYC1BTyFNNRhTt9tV66hCiMUCPIwz6gG/OppHnnKV7XRvcvYfCGrqW0XsQdGqAlNnj/WjhJYD9O0vPX0NAZHJRyviXB0or4ma2hU8nzElg+vOwEhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkTYwZHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676C9C433C7;
	Fri,  1 Mar 2024 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709303989;
	bh=hxhuvMYF4B3Dog5TINXGHY1tM8RGbN4JK+KayqqRuxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkTYwZHIPbpwdds7MCHekEZIpXeMkc994OXWtMlhE2HLlHz1HRtOqxs0YJJ4pNWKC
	 PJMC2lMg0K4RYccYFEG5FHLGnOx6ChUfr0h9xGGQ4+cvZfhic8DrWEyFDne1BaV3Rj
	 3WPvSOBxcctqjKRJqbovZgzTnmPE8Fa7zlPzlx6f0BshJNkd3zjo65vobG/R22s3K7
	 tdFcaxj31SrPEUz6Eoijz6AedsUpSuXefn86R/846mGnFQ2g4DdyFItnw1hwssRh7O
	 LboBYFH+1vgzL5Bold2ITr4bGuLtkAtJZ17346ntLqf72vpYtgpOS1fUgExwlgywc/
	 SwpC/1pignJ6g==
Date: Fri, 1 Mar 2024 08:39:48 -0600
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
Subject: Re: [PATCH v2 14/25] evm: add support for fscaps security hooks
Message-ID: <ZeHotBrI0aYd2HeA@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-14-3039364623bd@kernel.org>
 <15a69385b49c4f8626f082bc9b957132388414fb.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a69385b49c4f8626f082bc9b957132388414fb.camel@huaweicloud.com>

On Fri, Mar 01, 2024 at 10:19:13AM +0100, Roberto Sassu wrote:
> On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> > Support the new fscaps security hooks by converting the vfs_caps to raw
> > xattr data and then handling them the same as other xattrs.
> 
> Hi Seth
> 
> I started looking at this patch set.
> 
> The first question I have is if you are also going to update libcap
> (and also tar, I guess), since both deal with the raw xattr.

There are no changes needed for userspace; it will still deal with raw
xattrs. As I mentioned in the cover letter, capabilities tests from
libcap2, libcap-ng, ltp, and xfstests all pass against this sereies.
That's with no modifications to userspace.

> From IMA/EVM perspective (Mimi will add on that), I guess it is
> important that files with a signature/HMAC continue to be accessible
> after applying this patch set.
> 
> Looking at the code, it seems the case (if I understood correctly,
> vfs_getxattr_alloc() is still allowed).

So this is something that would change based on Christian's request to
stop using the xattr handlers entirely for fscaps as was done for acls.
I see how this would impact EVM, but we should be able to deal with it.

I am a little curious now about this code in evm_calc_hmac_or_hash():

		size = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr->name,
					  &xattr_value, xattr_size, GFP_NOFS);
		if (size == -ENOMEM) {
			error = -ENOMEM;
			goto out;
		}
		if (size < 0)
			continue;

		user_space_size = vfs_getxattr(&nop_mnt_idmap, dentry,
					       xattr->name, NULL, 0);
		if (user_space_size != size)
			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
				 dentry->d_name.name, xattr->name, size,
				 user_space_size);

Because with the current fscaps code you actually could end up getting
different sizes from these two interfaces, as vfs_getxattr_alloc() reads
the xattr directly from disk but vfs_getxattr() goes through
cap_inode_getsecurity(), which may do conversion between v2 and v3
formats which are different sizes.

Thanks,
Seth

