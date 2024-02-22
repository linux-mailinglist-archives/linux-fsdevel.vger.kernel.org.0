Return-Path: <linux-fsdevel+bounces-12430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B785F3C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800BA28510B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDFB364DB;
	Thu, 22 Feb 2024 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFM+vqbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC4364B3;
	Thu, 22 Feb 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592513; cv=none; b=KVxt+32zbKgDvcJ2b0WOMd+eX9mVgE9W/a1Q6WYVt1KqSMwnvbzPMK1M35aIk91zI8hNEuC2td0vnujSuR/TAfS6fRC1flj9JETuQLIs/AdCE4PJTkCJkPkOjV2Ke67+YcM29NOGwAaBoyoLZgpg35e5Sqyw2FiwLAsvNw5HWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592513; c=relaxed/simple;
	bh=GxSaTtmPOkR31tiEKOdHiyrXj7lJdpFYYTiUQkvexjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXWb3HsqrVLryCMFRTlcBCzNWwdOt7R9bARjvrilO4WTQ5eJcNfUTeYN9ecAT9a8bSIssyXeA9cTE1wzCJWRkQExkgCySiX/6TLlyfD/+bU1sNw3Scf2NLRUdUr/G4lRbgyQYKSYVKEqj1QK5lrgxjBZ6empQTqfU1ZFQSs3Hxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFM+vqbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1279C43390;
	Thu, 22 Feb 2024 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708592512;
	bh=GxSaTtmPOkR31tiEKOdHiyrXj7lJdpFYYTiUQkvexjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFM+vqbDR1MJKKRgfRjIOrzOc424GqoblK3T1+Qj60DGCCRltcn5K+HtDBiz0oNAI
	 7lhVYwgGLRYljApFvefFky2iXriPAhJEs4B28OmBTUXH8TaOq2m8oDcX/B81uT4svx
	 03S0IobkRFAoLzQ1BoOO/wC745aTOAvzBM21OXSh85cdiAg8OiRAuhGyWmFMxJDTMI
	 CkFWISZ1Zu/12netouLXOhDsFac1RLZ86e6jawWG+EpCMEvlxDNJPjWuDd2n0D209V
	 GLUhxd6XM89B/9DMjH3tTsKJTvXM/Un7Mue2dyxK6CccWL5PvwJ/cQgN61KOD7FfWi
	 IhTUB5C3TyEig==
Date: Thu, 22 Feb 2024 10:01:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-unionfs@vger.kernel.org, Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: Re: Can overlayfs follow mounts in lowerdir?
Message-ID: <20240222-verflachen-flutlicht-955cd64306f8@brauner>
References: <67bb0571-a6e0-44ea-9ab6-91c267d0642f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67bb0571-a6e0-44ea-9ab6-91c267d0642f@gmail.com>

On Thu, Feb 22, 2024 at 07:19:00AM +0100, Rafał Miłecki wrote:
> Hi,
> 
> I'm trying to use overlay to create temporary virtual root filesystem.
> I need a copy of / with custom files on top of it.
> 
> To achieve that I used a simple mount like this:
> mount -t overlay overlay -o lowerdir=/,upperdir=/tmp/ov/upper,workdir=/tmp/ov/work /tmp/ov/virtual
> 
> In /tmp/ov/virtual/ I can see my main filesystem and I can make temporary
> changes to it. Almost perfect!
> 
> The problem are mounts. I have some standard ones:
> proc on /proc type proc (rw,nosuid,nodev,noexec,noatime)
> sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,noatime)
> tmpfs on /tmp type tmpfs (rw,nosuid,nodev,noatime)
> 
> They are not visible in my virtual root:
> # ls -l /tmp/ov/proc/
> # ls -l /tmp/ov/sys/
> # ls -l /tmp/ov/tmp/
> (all empty)
> 
> Would that be possible to make overlayfs follow such mounts in lowerdir?

No, this doesn't work:

* overlayfs does clone mounts recursively
* procfs can't be used as a lower layer

So they would need to be bind-mounted on top of these locations.

