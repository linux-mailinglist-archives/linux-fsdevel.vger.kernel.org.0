Return-Path: <linux-fsdevel+bounces-8478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B23983750F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 22:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1961B24351
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE27047F73;
	Mon, 22 Jan 2024 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkJDf7l0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92547F5D;
	Mon, 22 Jan 2024 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957994; cv=none; b=i82lsmEHghpdLbEXEwi6deAStDQi3eW2N1981+NGqt7/jgwg2HVCe+qo4+tMxoIwmEHU9Kjx5rCAKibEOaPVmto/Nz/Jqd0HQAjWp+dSLpJ2zfPc4LZNumvAKy1BffeSYckBGAOw74NLPwnAuGMbjHq04UBqkj6wjHpCE6aZ3m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957994; c=relaxed/simple;
	bh=ZXyiGsWguy+RfxWlnQxaverivjM+wRLxZL1i2CYl7tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nelAopJm8H5hm7/8NkhOIC02bUy21OxHcjSBzSOaG9OLvfpSR8Pi9Ng9feFG37CstDfuv+32lqV9Qmc4PwWB0N4rxymXcyjwOQIPUanE3GGSpgPNHg97L+P1NtPIeiiFt4eMU8HlsYJBXywGlJVlpy6a+WDJUcl7ovu0XSHiekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkJDf7l0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5523CC43394;
	Mon, 22 Jan 2024 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705957993;
	bh=ZXyiGsWguy+RfxWlnQxaverivjM+wRLxZL1i2CYl7tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkJDf7l0+2OqvUYL7q9udltR+hyEJl3POQWYLMZXkPte/hX3V8K8MmdYeiDSe7kVH
	 PdAoUoADWM3Oonf/gYOtYzNJsN5L3ZkHK5ZbCssmXdF/ZCfuDmeeq0k3/Sw5IaOjR1
	 z2cHkM4JjIFCpbCaDZGfRY79/dbvV+N7JQfeVl+6Ir5gNSYO9hnYDTgAUl1mvYbbXl
	 53DZ4PdPz5lJlTv7vo8555vN55/M9en/C80WBbKRcwM/M74WrOfj3/YGIeo0YOuF/k
	 +zJ+fRgrl0NlOpV3ORBwlU6bj+YVKsJzFbbnv52vioud7aSwzZyWxvVrTBVfSRxVlQ
	 TduxX3FC6oQrA==
Date: Mon, 22 Jan 2024 15:13:12 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	mszeredi@redhat.com, stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/9] fuse: basic support for idmapped mounts
Message-ID: <Za7aaIuQDH92jel+@do-x1extreme>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240121-pfeffer-erkranken-f32c63956aac@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121-pfeffer-erkranken-f32c63956aac@brauner>

On Sun, Jan 21, 2024 at 06:50:57PM +0100, Christian Brauner wrote:
> > - We have a small offlist discussion with Christian about adding fs_type->allow_idmap
> > hook. Christian pointed out that it would be nice to have a superblock flag instead like
> > SB_I_NOIDMAP and we can set this flag during mount time if we see that the filesystem does not
> > support idmappings. But, unfortunately, I didn't succeed here because the kernel will
> > know if the filesystem supports idmapping or not after FUSE_INIT request, but FUSE_INIT request
> > is being sent at the end of the mounting process, so the mount and superblock will exist and
> > visible by the userspace in that time. It seems like setting SB_I_NOIDMAP flag, in this
> > case, is too late as a user may do the trick by creating an idmapped mount while it wasn't
> > restricted by SB_I_NOIDMAP. Alternatively, we can introduce a "positive" version SB_I_ALLOWIDMAP
> 
> I see.
> 
> > and a "weak" version of FS_ALLOW_IDMAP like FS_MAY_ALLOW_IDMAP. So if FS_MAY_ALLOW_IDMAP is set,
> > then SB_I_ALLOWIDMAP has to be set on the superblock to allow the creation of an idmapped mount.
> > But that's a matter of our discussion.
> 
> I dislike making adding a struct super_block method. Because it means that we
> call into the filesystem from generic mount code and specifically with the
> namespace semaphore held. If there's ever any network filesystem that e.g.,
> calls to a hung server it will lockup the whole system. So I'm opposed to
> calling into the filesystem here at all. It's also ugly because this is really
> a vfs level change. The only involvement should be whether the filesystem type
> can actually support this ideally.
> 
> I think we should handle this within FUSE. So we allow the creation of idmapped
> mounts just based on FS_ALLOW_IDMAP. And if the server doesn't support the
> FUSE_OWNER_UID_GID_EXT then we simply refuse all creation requests originating
> from an idmapped mount. Either we return EOPNOSUPP or we return EOVERFLOW to
> indicate that we can't represent the owner correctly because the server is
> missing the required extension.

Could fuse just set SB_I_NOIDMAP initially then clear it if the init
reply indicates idmap support? This is like the "weak" FS_ALLOW_IDMAP
option without requiring another file_system_type flag.

