Return-Path: <linux-fsdevel+bounces-35331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 836AD9D3FA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98833B2D207
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5F1AA1CA;
	Wed, 20 Nov 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bukzJIPG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AE1F61C;
	Wed, 20 Nov 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116179; cv=none; b=rNFNl8f51DdSRRUJc84RulpGQ7jTcM1MD5wzCyZlTL3FyLaKBb9MaGyqWeLz3e3Fr93h5Y9IkT8ptzUUprHWPPkYR623Gj2rJnchUOfYwqdgFT2bIjn+CQiZS3++NoBQ8EnteTbVVf6ysf2oWlUq3BbsrtrbeBmN0FxHoAGL5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116179; c=relaxed/simple;
	bh=7HSMTOSLIuP9rca81Zdn2qb0WbYseuUIWKIfSE9hWFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a3zx++aIa6b+Z5WCd3jaKeZtTxfeuHtzP6QusIBtNIF+YuIXWoERjpBsV4YW2ZVQUvWHeyGbdtF4B3x5At6LcZE4herWqmsf/8W9UsZCs6JDhbufcqhuaDCfYF2XzH7ZuK4qzc5owGdzitp8flMNkpE3QjeBUjRhE+s1ZB9Jo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bukzJIPG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2653A403E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1732116177; bh=F7TGxCuWmnHhM60mB3zccDkNdB0MqcFNwLzQHlKYkx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bukzJIPGKY14sI9P5nuItCcL1jwwnr4Ugrfz79nRbNqOGwE3eIiaYaeD3WembPh3L
	 01pynC+fxwfeBA1c0R03AAozh6DNOxvX7SBjE+neih0hplCmIZGKfoLuYFsHlmEbJq
	 gKws+n3ikuBvCHlGAu2rXvVJ971kWZIjLJ/gh08k8WGw1OHQ1Qx5shJY+LjdUOfIaD
	 Vu6+hkGX+VwKTxSrjIawWawFaNUOlclFJCqDRV9RGTFYRLn1dmMKSr/Ne8bigRuzK1
	 ZEXjF5YeiR8tUNmwDHsXoMiYytGf1BIGyn95jhV1vXAe8iKCstJmrwIrAY7wRqfeMN
	 Pcf3tWECV1KAg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2653A403E5;
	Wed, 20 Nov 2024 15:22:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Christian Brauner <brauner@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>,
 autofs@vger.kernel.org, Alexander Aring <aahringo@redhat.com>, David
 Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, Eric Biggers
 <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 fsverity@lists.linux.dev, Mark Fasheh <mark@fasheh.com>, Joel Becker
 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH] Documentation: filesystems: update filename extensions
In-Reply-To: <20241120-packen-popsong-7d5d34c0574c@brauner>
References: <20241120055246.158368-1-rdunlap@infradead.org>
 <20241120-packen-popsong-7d5d34c0574c@brauner>
Date: Wed, 20 Nov 2024 08:22:56 -0700
Message-ID: <87a5dudj5b.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
>
> @Jon, should I take this through the vfs tree?

Up to you.  It looks like I'll definitely have another pull request
during this merge window, so I can get it Linusward too.  Just lemme
know what your preference is.

jon

