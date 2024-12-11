Return-Path: <linux-fsdevel+bounces-37047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D47689ECA67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F97188CFCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379831EC4FF;
	Wed, 11 Dec 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu9+cciU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96767187872
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913280; cv=none; b=iIODLYIbroVdxVCx679zOGbx/X5vFuRupz7/aoPv/ZdzEV/cB6T+z5gdKpiPdPAoRi2RoAz91EHR6nHQNafwsqYBff3QfDINVhoZWI6ZZz/VuJYIOUO9Mo96ZBqU3kINbuw6BaDKCWJR08tbUi+kCSJtnPGdQSDXQrIEZCFVzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913280; c=relaxed/simple;
	bh=LszskfERr22cTTni6wtDZMCQsRQlp2Ntjxa4MSYEYrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4FNwjmatNRB+I1pWfMpIevCmaTrvQ/Hr4hMlY8VDdR5qzt1+0mVJ+g3HNgY3wK2ZrKxtnrBhLk/5CrfW13IGpj+dh7rheqXeD3aBlvuskgQTMiJIACxYgPjqZYJDckwkTXGIrdApuZkZdIUUnuPD7uKSn8Gu2UAwcckj+eXL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu9+cciU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD00EC4CED2;
	Wed, 11 Dec 2024 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733913280;
	bh=LszskfERr22cTTni6wtDZMCQsRQlp2Ntjxa4MSYEYrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bu9+cciUPO8hOIxbI+NabTwk8FRDADvrfz/phA3PLjKJ8Yl8MmdRbxFhyzSrc8bHc
	 LICko342DBLJWmWVd7ZvHQgg3DnjCrFcVS/Yg+edIv+Pc5wwJMIufFi44ZLjBuyLmJ
	 l1O+62/PAZ5UM2RwJwzh5TQbAWJoNhJ9z9PrTN+wiXk1bSZdqKmv5FaXj3mtIATqYp
	 v7NZdWzMiWoOdKR/uVCCAKm5WEYGtQg4gLbhkDQgWdXADGnAfVkBXw2Tz/pDxIj6eq
	 3CzYa/blXFoidNgDl/7buivaXpvJR2Qe7h6/yh26EKs0VEn+qAWDBeiOjx3/mLDvi7
	 vbh+AvgYy4jzg==
Date: Wed, 11 Dec 2024 11:34:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <20241211-boiler-akribisch-9d6972d0f620@brauner>
References: <20241206151154.60538-1-mszeredi@redhat.com>
 <20241206-aneinander-riefen-a9cc5e26d6ac@brauner>
 <20241207-weihnachten-hackordnung-258e3b795512@brauner>
 <CAJfpegsFV6CNC0OKeiOYnTZ+MjE2Xiyd0yJaMwvUBHfmfvWz4w@mail.gmail.com>
 <20241211-mitnichten-verfolgen-3b1f3d731951@brauner>
 <CAJfpegttXVqfjTDVSXyVmN-6kqKPuZg-6EgdBnMCGudnd6Nang@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegttXVqfjTDVSXyVmN-6kqKPuZg-6EgdBnMCGudnd6Nang@mail.gmail.com>

On Wed, Dec 11, 2024 at 11:21:08AM +0100, Miklos Szeredi wrote:
> On Wed, 11 Dec 2024 at 11:00, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Dec 10, 2024 at 04:10:45PM +0100, Miklos Szeredi wrote:
> > > On Sat, 7 Dec 2024 at 22:17, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > > I took another look at f{a,s}notify. There's no copy_to_user() happening
> > > > when adding events via fsnotify(). It happens when the caller retrieves
> > > > events via read() from the relevant notify file descriptor. We should
> > > > still move calls to notify_mounts() out of the namespace semaphore
> > > > whenever we can though.
> > >
> > > Doesn't work.  After unlocking namespace_sem deref of mnt->prev_ns
> > > might lead to UAF.
> >
> > Hm, a UAF could only be triggered by mounts that were unmounted due to
> > umount propagation into another mount namespaces. The caller's mount
> > namespace in mnt_ns->prev_ns cannot go away until all mounts are put.
> 
> Why?   E.g. one does umount -l on a subtree in a private namespace,
> then destroys the namespace immediately.  There's no serialization
> between the two other than namespace_sem, so if the former releases
> namespace_sem the namespace destruction can run to completion while
> the detached subtree's mounts are still being processed.

For that the caller has to exit or switch to another mount namespace.
But that can only happen when all notifications have been registered.
I may misunderstand what you mean though.

> > The simple fix is to take a passive reference count. But I'm not sure
> > what would be more expensive (holding the lock or the reference counts).
> 
> Right, that would work, but I think holding namespace_sem for read
> while calling fsnotify() is both simpler and more efficient.

Probably, although I'm still not too happy about it. Especially since
umount propagation can generate a lot more events then mount propagation
as it tries to be exhaustive. I guess we have to see. Would be nice to
have proper test for this.

