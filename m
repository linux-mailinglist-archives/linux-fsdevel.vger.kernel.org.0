Return-Path: <linux-fsdevel+bounces-62232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB46B89A79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 15:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71667E6E7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3A30FC1C;
	Fri, 19 Sep 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="kWuC4YKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAFF30B50D;
	Fri, 19 Sep 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288377; cv=none; b=TF5T3QZnY9jfvRO0CyEb0ztwyqPywZxxNeNgiRZfwLR2YX93ypXVLp49nbAU+miVg7lFw5QqbAqLsIgp0xseHnnk39vU1NTdjxN/y1dluUCzFvie18W7R/lIfSzejwdZw16xiOVJvcHpFzCss6HMUV7hitDEbpkTOLFiYqR77EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288377; c=relaxed/simple;
	bh=lm2A3dPZDzf/mZppxbNchDX8Rb8Py4sLl8ierryTQww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY+4gN1n9QnaMyT2hgZ04RmzHTy7oe4xyMSGNDxusCGYwHHOnaU4lshXaz5nvUfQbCCdUK73NZpJN7CeoXRLxktP5qak2Ug4ZayG22dsX/SiuXkhGSaUxjOlBbxJ0iU2m4mYBFoJZlBRktBHglNUu4cFYn+SBmVVR5GOn0zxNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=kWuC4YKR; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5F58B14C2D3;
	Fri, 19 Sep 2025 15:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1758288372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsnDrdqazOH6edpUSjZq4v3ZhoHiO3iWfgFf3R4oWZ0=;
	b=kWuC4YKRZS+O+U1gF7JwqeWT/piI/+hq55mWhU5xYblj/zKP6A4UEA1JtXfBeSiwa/E3e7
	RoColewv2xsbKx5nwfbTRV25uCGi2Fg5m61JYg9hB61lGRMlupN7Pwn9Usx4NLJJqONfVF
	6iKAmaQNznLW9PTv3dgz/BC3WP8h8Em0zOdWFkzO0YqkoWTIqvmFv/JyWbikXJ+/9iCShS
	fIfXUOyBgMBzLbgp+IWZjfMVMBy62T8O/FoJn0IK7UeDvFB31oeALTy62cKCntKW/Ia5zw
	hLCBW8bW169dlnbhm8VP8+1tUPvBY7Y2Wg+p5ICYi3nwLAfguXOx88Emeaxm8A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 25a0b8d7;
	Fri, 19 Sep 2025 13:26:08 +0000 (UTC)
Date: Fri, 19 Sep 2025 22:25:53 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>,
	Hillf Danton <hdanton@sina.com>, dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, pc@manguebit.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
Message-ID: <aM1Z4aLfJZs4XydW@codewreck.org>
References: <68cb3c24.050a0220.50883.0028.GAE@google.com>
 <20250919064800.GA20476@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919064800.GA20476@redhat.com>

Hi Oleg,

Oleg Nesterov wrote on Fri, Sep 19, 2025 at 08:48:00AM +0200:
> this is yet another issue seems to be fixed by
> 
> 	[PATCH] 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN
> 	https://lore.kernel.org/all/20250819161013.GB11345@redhat.com/
> 
> are you going to apply it?

Sorry for the lack of reply, I had meant to deal with it earlier but
other patches came in and it fell into the cracks.

I've just pushed your patch to my -next branch, I'll submit it to Linus
during the merge window in a couple of weeks

-- 
Dominique Martinet | Asmadeus

