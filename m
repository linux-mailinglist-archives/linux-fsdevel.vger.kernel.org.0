Return-Path: <linux-fsdevel+bounces-28572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604796C239
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695321C22DCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A041DFE2A;
	Wed,  4 Sep 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJH/ko3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB91DCB30;
	Wed,  4 Sep 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463546; cv=none; b=BEym181IFUYcxuMt+/wjh/vmqCsiaykHf7jXn0E5rmocE6INDqMkSbJ5ny6kyhAjqJurHpPDuh3hyF/JUHXFS60+zNGC4jkklkeiPklYNlCYq7t0eD+dpw8MXwPHd2qZespia0zO6weyk/eZME9z+iVB3pswc0P2s8hu8wrEfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463546; c=relaxed/simple;
	bh=ifvQS6G1EICry98rRpOIIWpo6JM1GsNIyrDXmXGmB7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5Hu3v1hg6oBmh72NMi1e9YOcTtDyzOx7vcGOrTBfo4iAf0iwECyPgIQbO4/AX44iytEy6ntvPSkLvYGH2zV1+sFg6rP+HXn1A64anFvPT5s0NRb79FWV3+34u/9/cWIAP8ByRCLXjk2QYOq+YNaulc7+9P9klGcZV3scMpoqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJH/ko3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC5FC4CEC6;
	Wed,  4 Sep 2024 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725463546;
	bh=ifvQS6G1EICry98rRpOIIWpo6JM1GsNIyrDXmXGmB7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJH/ko3eSn4Jkm5EpAuvSE+lBftKVXkuM+j2GAKVHixUgGcFmlnQZNb63JkRludgy
	 pHa/A5e7OXa4A7tpc3UILJ6ONcfihtJOeVEZTvRFuznrMxmoeqdBMF5WmSEdOpybyc
	 toAXZrqn8Yme2RCgRki8WIPUnTX1JdgHaOumi46jCVt0BAqNTPpx9/AYDd1Bi4qIal
	 X/ujgeJK5K06cHnXZISuLTbGR4+QzXTa8psr92qduulT57ZIkzgSqVCmLer3H9pn9W
	 uQvPbyp8WSyr63rn++n6eOvnERWD3Qc0wrWrLrMCCoBKZsJOPwK0bjV6S+p+9FBqT+
	 XFsiQsSBwJn6w==
Date: Wed, 4 Sep 2024 17:25:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/15] fs/fuse: add an idmap argument to
 fuse_simple_request
Message-ID: <20240904-baugrube-erhoben-b3c1c49a2645@brauner>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
 <20240903151626.264609-4-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903151626.264609-4-aleksandr.mikhalitsyn@canonical.com>

On Tue, Sep 03, 2024 at 05:16:14PM GMT, Alexander Mikhalitsyn wrote:
> If idmap == NULL *and* filesystem daemon declared idmapped mounts
> support, then uid/gid values in a fuse header will be -1.
> 
> No functional changes intended.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Bernd Schubert <bschubert@ddn.com>
> Cc: <linux-fsdevel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Huha, you end up extending fuse_simple_request() with an idmap argument
and passing NULL 38 times and non-NULL only 4 times at the end of this
patch series. That's not pretty. Also, I really dislike passing NULL as
an argument to the idmap helpers. All of the idmapping code uses
nop_mnt_idmap for this case and I think we should the same just with
invalid_mnt_idmap constant.

So I would propose two changes:

(1) Add an extern invalid_mnt_idmap into mnt_idmapping.h and
    define it in fs/mnt_idmapping.c so that will always yield
    INVALID_VFSUID/INVALID_VFSGID. Basically, it's the same definition
    as for nop_mnt_idmap.

(2) Instead of extending fuse_simple_request() with an additional
    argument rename fuse_simple_request() to __fuse_simple_request()
    and extend __fuse_simple_request() with a struct mnt_idmap argument.

    * make fuse_simple_request() a static inline helper that calls
      __fuse_simple_request() with invalid_mnt_idmap in the fuse_i.h
      header.

    * add fuse_idmap_request() that also calls __fuse_simple_request()
      but just passes through the idmap argument.

