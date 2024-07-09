Return-Path: <linux-fsdevel+bounces-23355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CE992AF8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 07:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010AD28288C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23EE12DD90;
	Tue,  9 Jul 2024 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua8osYzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E81139F;
	Tue,  9 Jul 2024 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504022; cv=none; b=sLVGkWvQaLvu6SHpICDY3Z/rGiiRhcsoQZpBiOr5L+G7xTdd8fwuQEqHGB8XPD6+0oIAGmzsYJ5XxIWu611QEwZvDbBGO5n9Av3EWGaM5zTLbRQbUts5evdHTd9Q3J7ZX2HVPfxuOUI9SuuFghEdarH5vmMNX91xmuajU9tx1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504022; c=relaxed/simple;
	bh=F1PecOhbt7t7tOAcYqSPytPp8+1pNtxqzy28x+Fwubs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bml1qGJ2vMugfk1YEn+8DScCn80VRvc1s+ZLrMkecMQKppSJhAQt46KT4T34zRz32iDz0DCseCDCVcUj3U0xvmlTWzADuG9wHrxqgVjM4w4sq+ijpMMwXs33mK2E9+s6jbwKOsOf9uzUqKadQDaTYruKjXh1efBcJ3SjLvrrTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua8osYzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA999C32782;
	Tue,  9 Jul 2024 05:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720504021;
	bh=F1PecOhbt7t7tOAcYqSPytPp8+1pNtxqzy28x+Fwubs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ua8osYzmRhOcC1aQir6D0n/Vxu2RUTnC9s6iWvILYDtWeYxUUITZnmy6h1e8k9/Bx
	 0qTupqANvLJYo2atYcgOlQq8A2PQgCSBRDLVpwmougeLvbfLbXOERDAfCVSa8Vc0dq
	 NqvLgL6nM51KD7kekPwiygkXqg8u8kKXUHVummUm5PDPELmryXojWfCJz7Pe8g5b7W
	 kdLntTICoYuXTj1ZIlroGz8nDR1vJPvhl2qclORawMG9YmK/FX85wxC6PTy4Tjy182
	 OM8FQUBjttNV10MjJKNlKrS4OnZQCPR187bRZvGlvBW9qd0AAn6vr6WHRrGnipCRQP
	 t3ncsGZ4dKlEw==
Date: Tue, 9 Jul 2024 07:46:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <20240709-bauaufsicht-bildschirm-331fb59cb6fb@brauner>
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
 <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net>
 <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
 <20240708.ig8Kucapheid@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708.ig8Kucapheid@digikod.net>

> > ... or we find a better placement in the VFS for
> > security_inode_free(), is that is possible.  It may not be, our VFS
> > friends should be able to help here.

The place where you do it currently is pretty good. I don't see an easy
way to call it from somewhere else without forcing every filesystem to
either implement a free_inode or destroy_inode hook.

