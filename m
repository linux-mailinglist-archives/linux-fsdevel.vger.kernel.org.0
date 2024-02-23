Return-Path: <linux-fsdevel+bounces-12559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017418610D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 12:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF491F2581B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373587AE5A;
	Fri, 23 Feb 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5EEtA94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B206692E0
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689311; cv=none; b=Tzq7CkZkS3xCoVnwXPMhKH9VrMDlHdv7UqrIqKQhmvQqwgb7ThgXG0t317FSGxGpR16u6c1M6rAl4PwcFf9XxrPnAxP/SfJ0r3Y57xRnmT1uepX/jCauiYL1+R8LsvCkapWkswzz7iR3cTmfNuuTmR55kyCqDc/mYCU0nA6zxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689311; c=relaxed/simple;
	bh=L1DveAzrzs7XCnZGBGc2SOvON4gjQpyhQfvi8zP1IpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3kgm9tLTliYZmv+9gZWdFy7gLvotGtIg8dVnIC1HKQKHtNYUjXUl+SpPQHGlHCSG9MWDOC3UDezYYqZ8wY31RKSYtPs9Y9FKpRlPgw8psuEke/7n3k270b22V6Z5WZLlymPdhQVueT42lFhNmLZTEnFnGYGDybsMskGIa1ekyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5EEtA94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1992C433C7;
	Fri, 23 Feb 2024 11:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708689311;
	bh=L1DveAzrzs7XCnZGBGc2SOvON4gjQpyhQfvi8zP1IpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5EEtA94Y6vHPMjx2gBMO1pLTigBmiuF7buDKd0X4YPlc32hmqqRFiEsiT97yHV4x
	 MVWXqV402tMrRsk0/YXrzbA704FId6BEk9Ih3p4jn+eXSirEfNhZ6b1zTLKAYIQ8IW
	 i9E9zXZOXYAIM6+WdrfXHog8At9QZcGUCnkjcoX0fYo2lYvW7UUE++1xXAuo1YNxTJ
	 e+Epdyi+Zs2hCd1D/+Sew7Fp/htDAtkoR2HkUdV2+7h00iMXL8I4Yht0Cmt2qPaf9F
	 Exejm/zydjVm8eDrmZZ4++7js3zct4O/QzfFE7ue05HZLvYMYLundH3R1QclsZgSt2
	 H2uolbLuWUE5A==
Date: Fri, 23 Feb 2024 12:55:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240223-delfin-achtlos-e03fd4276a34@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222190334.GA412503@dev-arch.thelio-3990X>

> Apologies if this has already been reported or fixed but I did not see
> anything on the mailing list.
> 
> On next-20240221 and next-20240222, with CONFIG_FS_PID=y, some of my
> services such as abrtd, dbus, and polkit fail to start on my Fedora
> machines, which causes further isssues like failing to start network
> interfaces with NetworkManager. I can easily reproduce this in a Fedora
> 39 QEMU virtual machine, which has:
> 
>   # systemctl --version
>   systemd 254 (254.9-1.fc39)

If something fails for completely inexplicable reasons:

Feb 23 12:09:58 fed1 audit[353]: AVC avc:  denied  { read write open } for  pid=353 comm="systemd-userdbd" path="pidfd:[709]" dev="pidfs" ino=709 scontext=system_u:system_r:systemd_userdbd_t:>

>   +SELINUX

pidfd creation can now be mediated by LSMs since we can finally go
through the regular open path. That wasn't possible before but LSM
mediation ability had been requested a few times.

In short, we have to update the selinux policy for Fedora. (Fwiw, went
through the same excercise with nsfs back then.)

I've created a pull-request here:

https://github.com/fedora-selinux/selinux-policy/pull/2050

and filed an issue here:

https://bugzilla.redhat.com/show_bug.cgi?id=2265630

We have sufficient time to get this resolved and I was assured that this
would be resolved. If we can't get it resolved in a timely manner we'll
default to N for a while until everything's updated but I'd like to
avoid that. I'll track that issue.

