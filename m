Return-Path: <linux-fsdevel+bounces-20007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07FF8CC4FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D1AB2128C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E787C1411EA;
	Wed, 22 May 2024 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFgz1N5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFD6AD7;
	Wed, 22 May 2024 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395938; cv=none; b=cO5REsyIck2h4e1ldjSTX1kWM3TVU3E0YD67/HPFJZLpMcOMo4n2VwkOPTk7FoPBkNIriZl0bXSXxWHDvpr+KjGLo0BbwiAVcGAVHawYKvxcSMUbyaDW8iy+VuEFnA2vDj6VjrnffpP/v2XNQt7t1Md0NbbMjDtvBmpsIwxCKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395938; c=relaxed/simple;
	bh=aFG+y098+czTY5iVUPXdlSGJuUyiMo1F/N8t7jzPlnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwiHcFGf3ljXrso9E59TCUobc7c30QI9j3Eh551M3LQvEKL77hdoyP0Pgwa78j8C+EtfobD7JkusBy49XPIdOnFPqrK0TFNt0Jbvy2zj/Qa8ZpHd1MMzeJUuv1N27eIysuv8OtIeDMfNUscgd57b+k3dVvyN8edCX/xy8h6qQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFgz1N5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BE9C2BBFC;
	Wed, 22 May 2024 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716395938;
	bh=aFG+y098+czTY5iVUPXdlSGJuUyiMo1F/N8t7jzPlnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFgz1N5ifFSn5XvarTEP4qacPfPL7GTOlObAIyVoKcb4dt6Bwjzj84ogUXuR9KUPf
	 IrhBklEh4qk8l1Ku3KxwdfvivmmF0+pEGe2cTu1BjZ9wt1n2i7JWKRU6PEHtY1zSpO
	 1E2RumqHKHbdBWFJH92FrYo+D7aGnPpIkBJsHo4hd/x+lvicJbrI/O3FzIYhz4E2jJ
	 ZeX6YG/VhWFd/X+Sfq8HZ/9Xod4kKhDoit8fac1eAHonPZWbFhTd07Voi4t3B5SDfs
	 ZWU+z7Z8jKfAgk1Ony/quti9c1DYEBpV+MQRe/hLNNggyHcFWKPPJIYLAMf2yDv9Kj
	 g5fIk/PkmxjOA==
Date: Wed, 22 May 2024 09:38:56 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240522163856.GA1789@sol.localdomain>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
 <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
 <CAOQ4uxjaLbrmSDk_a_M6YDT5tQoHO=dXTDsHVOSYcMxeQnpP1w@mail.gmail.com>
 <3b7opex4hgm3ed6v24m7k4oagp2gnsjms45yq223u2nnrbvicx@bgoqeylzxelj>
 <20240522162853.GW25518@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522162853.GW25518@frogsfrogsfrogs>

On Wed, May 22, 2024 at 09:28:53AM -0700, Darrick J. Wong wrote:
> 
> Do the other *at() syscalls prohibit dfd + path pointing to a different
> filesystem?  It seems odd to have this restriction that the rest don't,
> but perhaps documenting this in the ioctl_xfs_fsgetxattrat manpage is ok.

No, but they are arbitrary syscalls so they can do that.  ioctls traditionally
operate on the specific filesystem of the fd.

It feels like these should be syscalls, not ioctls.

- Eric

