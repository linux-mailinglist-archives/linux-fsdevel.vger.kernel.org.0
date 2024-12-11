Return-Path: <linux-fsdevel+bounces-37042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC9B9EC9F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065542850BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986121D9359;
	Wed, 11 Dec 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNioWYAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD0236F98
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911635; cv=none; b=oKrHBwGAvPK6iSNvzVtXrfbX7GEMLrhZKnVg7cMhVLyGTtUPDZHh35iC7d1zxtCYVnzTZVcJ4/d7wadKNN0x+A00g/DsQIwhBIaKxIomu4arInmgKyhZcUnkoZlPGQFQXX/7zNihTZ3BPpXSCcqHhxNdn7LGorN4j5V+m2CTN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911635; c=relaxed/simple;
	bh=i8j3IIC0t1FgSNso6M5lQEoO6Z8GIXTyApl8cnOC4c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byynTmBBYHnzkwKKYgRiLEI9d4Hg+ZVfuhKi++Ksv2txy7s9pcIMqeU3azG6lpGvlTt5IHpS2Huh/ogMiwJG5UmFjXJEywHuEelhbpvPnZZMbkVagcjUyYXtOUwllKVGT7WrMQmqSN5AaFmO/P1d+aogr6P7bScjulEqrw9djXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNioWYAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AB3C4CED2;
	Wed, 11 Dec 2024 10:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733911634;
	bh=i8j3IIC0t1FgSNso6M5lQEoO6Z8GIXTyApl8cnOC4c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNioWYAD72wsRhbrYAdIqS/1LO0MJCCvFU0qL2fO4G6B2aSgayge7E77mlLJw1QYg
	 TcHt/4o+f/eeWyXAjzX3tTMwVG1nstoTzF1/NDuEsRHa1wI2ujzMiiDIowrZTKCcfE
	 avcuSOdTPc0gMwS3AeS9pIDl4oaQo8ULYjUUjxH+4ahqemjQLNgRUgPTIm5O9NEs0W
	 21xYAZRxZm3jq1ElACMDi820e54g/4aPCzzT/a01eJm/5cduG1vjkUZtuI7Lhgr1IK
	 oZSXJ7pKZQ1DgYY+Hq6xe2GGO+mWzg5ts7Klw7XzockbLPkpaD6YlhtWdrKuWlAEtX
	 6VY0NJfiALRDg==
Date: Wed, 11 Dec 2024 11:07:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Karel Zak <kzak@redhat.com>, Lennart Poettering <lennart@poettering.net>, 
	Ian Kent <raven@themaw.net>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <20241211-pechvogel-kaufkraft-cbc1eac05d67@brauner>
References: <20241206151154.60538-1-mszeredi@redhat.com>
 <CAOQ4uxhG9h6vBEyw9tZ0bMygZO=3VH5FmvxffRaLNUAyH9UYaw@mail.gmail.com>
 <CAJfpeguakUSVP=zbv6=Nbp75QF8Hthv=bNk3SRLdAGqAQB8Y3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguakUSVP=zbv6=Nbp75QF8Hthv=bNk3SRLdAGqAQB8Y3w@mail.gmail.com>

On Tue, Dec 10, 2024 at 05:11:30PM +0100, Miklos Szeredi wrote:
> On Fri, 6 Dec 2024 at 19:29, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > Because with fanotify the event mask is used both as a filter for subscribe
> > and as a filter to the reported event->mask, so with your current patch
> > a user watching only FAN_MNT_DETACH, will get a FAN_MNT_DETACH
> > event on mount move. Is that the intention?
> 
> I imagine there's a case for watching a single mount and seeing if it
> goes away.   In that case it's irrelevant whether the mount got moved

Sooner or later we'll likely need something like this but I think the
mount namespace stuff is needed a lot more.

> away or it was destroyed.
> 
> > Is there even a use case for watching only attach or only detach?
> 
> I'm not sure, there could well be.

I'm pretty certain that there is. One might care just about incoming
mounts into a system service due to mount propagation to detect when
a new volume is added but not care about it going away. I think lumping
both events together isn't a great idea.

> 
> > Are we ever likely to add more mount events besides attach/detach?
> 
> Yes, modification (i.e. flag/propagation/etc changes).  And that one
> could really make sense on a per-mount basis instead of per-ns.

Yes, that's what I envision as well. Though we really have to be careful
to make sure that we don't end up shooting us in the foot by sprinkling
notifications everywhere into the code.

