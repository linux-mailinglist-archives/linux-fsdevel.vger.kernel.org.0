Return-Path: <linux-fsdevel+bounces-12487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB0785FC91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F6A28635D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70014E2C1;
	Thu, 22 Feb 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHRXk4KX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2BA14A093;
	Thu, 22 Feb 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616286; cv=none; b=rg7dGxbnIcYKFDHnEHiS67cAiSkIaGdhKy0vVOYR3os8540Y4+w0wFSnOluPaklgS3CKTZ3gXBX3KtZP3Z1EnSCyu+UfbqsFMYLnvyKC55SnbxUjmbA1q3IMqR7RrypEHBjfkWnmudJa7i1IHO0WBr7r9PTDC3YSOhX7Mt4AwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616286; c=relaxed/simple;
	bh=qu0fwWOeh/I6+oNa5FUXimTTggVsBjqh5xvuL/Jm3Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPvJdIuxviy/Ith7ypJRGp0bzZFV/m9UecqAF/Qe7R1xvNmpyB+TxeJud1rUlKn/dIg0qDXsxB20KfZZb0xvQ8PlSfOIxaYDN3Ze6pMbxJOdNroVLlMl+MXAfWB9WtLlsT7ZVDw9ABt+CN7TYpHn1zFaWVzkyUVGlcL2V5/Cqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHRXk4KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018E9C433F1;
	Thu, 22 Feb 2024 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616286;
	bh=qu0fwWOeh/I6+oNa5FUXimTTggVsBjqh5xvuL/Jm3Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHRXk4KXwfOwKzU4gL5Z9zYoGPkNdMdD2jERLNEP24+s4Qvj36nxDojqPrvri5p7u
	 IQ1kgoTttatl9OZdO/RmTNPNP8qW5Gqsmq6pp4IHEEhyxKB6FQSQjTmCy3sbhuj4oh
	 iWzU6zrkqvjg+3p53nsnVdTWiXr4eke0AU/3o39SG02vzoCk64/DHKUKU2hcyDK1Nk
	 Fp8bflMVrnJ//9AjPweq01bqfSB66Dj569+O0yt3ACuTrJmAKUiBBCXa6x3LAYEmIT
	 kInLmnVGUY8IcwrLz1obiPXwxkzc3+HHyqplVk67LBJhgtS7Xof+wvobaAGKByMGFs
	 y82eq/oIFWpgg==
Date: Thu, 22 Feb 2024 09:38:04 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
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
Subject: Re: [PATCH v2 06/25] capability: provide helpers for converting
 between xattrs and vfs_caps
Message-ID: <ZddqXN51+8UaKVTC@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>
 <20240222-wieweit-eiskunstlauf-0dbab2007754@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222-wieweit-eiskunstlauf-0dbab2007754@brauner>

On Thu, Feb 22, 2024 at 04:20:08PM +0100, Christian Brauner wrote:
> > +	if ((magic_etc & VFS_CAP_REVISION_MASK) != VFS_CAP_REVISION_1) {
> > +		vfs_caps->permitted.val += (u64)le32_to_cpu(caps->data[1].permitted) << 32;
> > +		vfs_caps->inheritable.val += (u64)le32_to_cpu(caps->data[1].inheritable) << 32;
> 
> That + makes this even more difficult to read. This should be rewritten.

Do you meant that you would prefer |= to +=, or do you have something
else in mind?

Note though that this is code that I didn't change, just moved.
Generally I tried to avoid changing code if it wasn't necessary for the
aims of this series.

> > +ssize_t vfs_caps_to_xattr(struct mnt_idmap *idmap,
> > +			  struct user_namespace *dest_userns,
> > +			  const struct vfs_caps *vfs_caps,
> > +			  void *data, size_t size)
> > +{
> > +	struct vfs_ns_cap_data *caps = data;
> > +	int ret;
> 
> This should very likely be ssize_t ret.

Indeed, I'll fix that.

