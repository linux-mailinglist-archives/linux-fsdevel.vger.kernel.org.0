Return-Path: <linux-fsdevel+bounces-13752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7A873625
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2151C22D6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0505B1EA;
	Wed,  6 Mar 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFi19MQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA27F7D3
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727463; cv=none; b=dNDQIL5WW5kii++Md9/urv5OvB1FQw/69oNTG34QNJbEQxVyT9uUgYVo2x9WLSIN3W+6+isCAdP8jYuiMbeVMh6XMHkuio3iO5yIOw017Sk7ZPdXZPgybC+WrbgyLREYV0vOA4ZhBYojozxQkY/vI4XENUkOlVXBc2bPIUgf6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727463; c=relaxed/simple;
	bh=77BWc4q0zgSJzePWWxS51TqieV7imu/5pIxn6gVEg3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgzD7ZZp3hMiLDiE30bM+CuOqI9i7WmisqvN3+cv+v43guVtB6SGbpxCcOMruIjsNleiCHTXuFckyAoRWe2XKqkWyckqUVHmls7z7cmB0xwKE0c/w0Ge/4qhBUwSL+x49BO5PmOXQt59S7qX6G1s7RK0SAkq7WuBIFPIvj7cYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFi19MQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D667C433F1;
	Wed,  6 Mar 2024 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709727462;
	bh=77BWc4q0zgSJzePWWxS51TqieV7imu/5pIxn6gVEg3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFi19MQ0Z5DgNfTacmVEicn8PTn+1dVRV3XCBYXzcOFe/r9/Ot2+NfbzsGAjgRjE+
	 1NC0u/ELbSZongPN9aNJb2W4dbiihlhwRdq0cEF+W8qAk3QjDLZF9rlOFEwYzessCz
	 lB/k0g2gt/bcM72d5SV5WApgF+eL7A37N3g2ya48AatfrBiCogIpwgW82vC8kF245R
	 vtTdCvoE8t5QFBEm2LGvuqrTHYLRHIbRABq0Aj8DBfzlIftiOP7gkRnIxXapE7BOil
	 hzCoiqXA2MUXMpT3kd93+ncANMrXyQZbzAouPI9j+9X32LGs0UdFgaYubQJAR+iIzy
	 X3VJCPRaUnEgQ==
Date: Wed, 6 Mar 2024 13:17:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Bill O'Donnell <billodo@redhat.com>, 
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] vfs: Convert debugfs to use the new mount API
Message-ID: <20240306-alimente-tierwelt-01d46f2b9de7@brauner>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
 <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com>
 <20240306-beehrt-abweichen-a9124be7665a@brauner>
 <CAJfpeguCKgMPBbD_ESD+Voxq5ChS9nGQFdYrA4+YWBz17yFADA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguCKgMPBbD_ESD+Voxq5ChS9nGQFdYrA4+YWBz17yFADA@mail.gmail.com>

On Wed, Mar 06, 2024 at 01:13:05PM +0100, Miklos Szeredi wrote:
> On Wed, 6 Mar 2024 at 11:57, Christian Brauner <brauner@kernel.org> wrote:
> 
> > There's a tiny wrinkle though. We currently have no way of letting
> > userspace know whether a filesystem supports the new mount API or not
> > (see that mount option probing systemd does we recently discussed). So
> > if say mount(8) remounts debugfs with mount options that were ignored in
> > the old mount api that are now rejected in the new mount api users now
> > see failures they didn't see before.
> >
> > For the user it's completely intransparent why that failure happens. For
> > them nothing changed from util-linux's perspective. So really, we should
> > probably continue to ignore old mount options for backward compatibility.
> 
> The reject behavior could be made conditional on e.g. an fsopen() flag.

and fspick() which I think is more relevant.

> 
> I.e. FSOPEN_REJECT_UNKNOWN would make unknown options be always
> rejected.  Without this flag fsconfig(2) would behave identically
> before/after the conversion.

Yeah, that would work. That would only make sense if we make all
filesystems reject unknown mount options by default when they're
switched to the new mount api imho. When we recognize the request comes
from the old mount api fc->oldapi we continue ignoring as we did before.
If it comes from the new mount api we reject unless
FSOPEN/FSPICK_REJECT_UKNOWN was specified.

