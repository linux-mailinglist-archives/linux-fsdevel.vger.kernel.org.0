Return-Path: <linux-fsdevel+bounces-37040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13859EC9E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68032288CBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC1236FB1;
	Wed, 11 Dec 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDWJLdI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FF1A83ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911247; cv=none; b=PQ9kvqevjXTNwflXxiNvYVKJAkgYRmyL8BIC2QspUl7YPKFgO+TJNe0EafbZZx85WetP8ZWOeeJb/DtBRAUI4Bx5YJNoxDZeQy7umzOQgF2+WwlEEzF0fAH41JaPwxMLelg8Vkm63v3KXtJ6OQasvBDt1p1LT3ioIHOI+VCc0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911247; c=relaxed/simple;
	bh=oWfCUjaOZd2hoSGvftYx3XRUndCPgoVH3VhqnXRgOvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5qlBY9L7RffifAnv2PKDr2HpeRCBymWK24LWMcN2oPUPltLpXfMDZBa7HMHUY+CEU+DryT/bcSUMy7eKi4XJQuDaBGfKVF+QkOV8fOzIZiGeYfPzuuriPgGamK1Sl5N8xMs89S+TUA5A6s7t5+DDNPyc2mvwCACnWr0IrMeMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDWJLdI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A28C4CEE0;
	Wed, 11 Dec 2024 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733911247;
	bh=oWfCUjaOZd2hoSGvftYx3XRUndCPgoVH3VhqnXRgOvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDWJLdI4yI/Fv3wjOehrXhqILddwcSh0qpS2vTxo4jhuJ/rtered1Zma5PTPzVvNo
	 tSmgaqfN3p0G3ixenpJU5eOgZPNZB88nNyPYhS1gRC4Ec+67w1ij95JZRsxNgxLgqL
	 vFrq16NFDg814CatW9KaRJgIb5QaoWurL34+FIjaXHO/9Yv4HYn/DkcYoGDWATgYYw
	 xEcUvQlL3Zu4Z6jXnE1CqB1SRDzcyiFjAzd5osFsuF2ZjzdjYFR1xYgIZ10hq5qrHy
	 8RkVQs2n9gIZvtgLcDzSh1DzSGY1D4m+Bu4Gs+NGFEudh1CY1yBHT7o/SK92Rvu9a1
	 I2+zuCc9cE0WQ==
Date: Wed, 11 Dec 2024 11:00:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <20241211-mitnichten-verfolgen-3b1f3d731951@brauner>
References: <20241206151154.60538-1-mszeredi@redhat.com>
 <20241206-aneinander-riefen-a9cc5e26d6ac@brauner>
 <20241207-weihnachten-hackordnung-258e3b795512@brauner>
 <CAJfpegsFV6CNC0OKeiOYnTZ+MjE2Xiyd0yJaMwvUBHfmfvWz4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsFV6CNC0OKeiOYnTZ+MjE2Xiyd0yJaMwvUBHfmfvWz4w@mail.gmail.com>

On Tue, Dec 10, 2024 at 04:10:45PM +0100, Miklos Szeredi wrote:
> On Sat, 7 Dec 2024 at 22:17, Christian Brauner <brauner@kernel.org> wrote:
> 
> > I took another look at f{a,s}notify. There's no copy_to_user() happening
> > when adding events via fsnotify(). It happens when the caller retrieves
> > events via read() from the relevant notify file descriptor. We should
> > still move calls to notify_mounts() out of the namespace semaphore
> > whenever we can though.
> 
> Doesn't work.  After unlocking namespace_sem deref of mnt->prev_ns
> might lead to UAF.

Hm, a UAF could only be triggered by mounts that were unmounted due to
umount propagation into another mount namespaces. The caller's mount
namespace in mnt_ns->prev_ns cannot go away until all mounts are put.

The simple fix is to take a passive reference count. But I'm not sure
what would be more expensive (holding the lock or the reference counts).

> Anyway, I don't think this is an issue, especially with the downgrade
> to read that you added.

Yeah, probably.

