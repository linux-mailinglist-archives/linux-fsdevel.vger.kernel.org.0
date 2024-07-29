Return-Path: <linux-fsdevel+bounces-24444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1C93F54F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A101C21882
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884D71482F4;
	Mon, 29 Jul 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8NkkoXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E013CFA5;
	Mon, 29 Jul 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255983; cv=none; b=NIhClSPvDES0vl+dp1dG574TKCwiD6j+zDzRHvzXd+vIs2yKi5c2qZndnkBDa6paGRO0zgeQDFUSmjT0GD5q0NQGffxMNUPIe3hvRM7XGNzYuPP4E0rWeYF2Yjb+ARwlU04dtfTiaJY2FRQH2NddX77Fq7c77mVhcmShG9SHyBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255983; c=relaxed/simple;
	bh=KHLR5QjelL6FQP+UX88+36x9KSEqAeOkUvdgU6uiv/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5pWUO+KFfzID32taljVgRyFekzIicqkKO/D1cG6ApxGG11/3g5ANgJPIqDVjBYBeT4K2wr3TXHbwaO5uJ1Ea7G0T0VKPeWxxdvmAJsOk+3NQ3YU9pSowIGebRKc3zS7sMUI6lNI92fcr5VKaK4L6+RfZfjfILsDr5416ulH42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8NkkoXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C48BC32786;
	Mon, 29 Jul 2024 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722255982;
	bh=KHLR5QjelL6FQP+UX88+36x9KSEqAeOkUvdgU6uiv/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8NkkoXeGxVWNTdLZ1Rh+wBe0GpWjGeHVBK4jFo/IsXKV/IUTYWg/4SGEahjaKj26
	 uUuLB2VM9i1v6K2N/Pi7oQ1oW4HMqFecYKNd0RlvbtDSP72xbB93Fk6eyL283pd793
	 FAb3WpPQcSuMl99zPeLYXFhoecQfOQruXSJ/w7GaoZSrxWwkoZ31kxJem6N4CquFTj
	 Z3HSPr4dtZWV/r4YJhuhEVdcAk8Dn1iWpD860Hx3x8DyHj3mDqT4OF1xHPN0Ood4i4
	 6fAMmvfuxFdHuRLuJt1r0E/jiXDI5vssABs21yKSqxcFcot9u88xpVjxSoh2Ymov22
	 pe8f8Kfe33Y4g==
Date: Mon, 29 Jul 2024 14:26:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <20240729-respekt-tonnen-9c8f6c4d3bff@brauner>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>

On Mon, Jul 29, 2024 at 12:18:15PM GMT, Mateusz Guzik wrote:
> On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> > It was pointed out to me that inode numbers on Linux are no longer
> > expected to be unique per file system, even for local file systems.
> 
> I don't know if I'm parsing this correctly.
> 
> Are you claiming on-disk inode numbers are not guaranteed unique per
> filesystem? It sounds like utter breakage, with capital 'f'.
> 
> I know the 32-bit inode allocation code can result in unintentional
> duplicates after wrap around (see get_next_ino), but that's for
> in-memory stuff only(?) like pipes, so perhaps tolerable.
> 
> Anyhow, the kernel recently got F_DUPFD_QUERY which tests if the *file*
> object is the same.
> 
> While the above is not what's needed here, I guess it sets a precedent
> for F_DUPINODE_QUERY (or whatever other name) to be added to handily
> compare inode pointers. It may be worthwhile regardless of the above.
> (or maybe kcmp could be extended?)

We don't use kcmp() for such core operations. It's overkill and security
sensitive so quite a few configs don't enable it. See [1] for details
how kcmp() can be used to facilitate UAF attacks and defeat
probabilistic UAF mitigations by using ordering information. So that
ordering requirement should really go out the window.

Another thing is that kcmp() works cross-process which is also out of
scope for this. kcmp() really should be reserved for stuff that
checkpoint/restore in userspace needs and that's otherwise too fruity to
be implemented in our regular apis.

[1]: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html

