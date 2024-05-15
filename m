Return-Path: <linux-fsdevel+bounces-19537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958418C6A1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5061C28385C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76DE156248;
	Wed, 15 May 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J9El22d1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BEC155A53;
	Wed, 15 May 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788856; cv=none; b=EOUCJdkWk7gq9+tsmXZZUTJGoREFVo1fmVeBojv498d0fcv160AkrYZ+0OaT6O47MoHZFV5w0YAgeg4cOzx1ucM527oLKP9qxEr0nxYHCQcJohjhaSXZbQVq30Q3OR27LOG6bMmEDpjMMCqhyiR/qxVgT8df1FXDT5pG3gwQ4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788856; c=relaxed/simple;
	bh=k/puBfybqGdRr3s0WvxOTD3Uq//G7F2oQm8GUykR+Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHOYF7PalhZ6ym+wNvh1HeRYlspn4FK9wBIcC/mDrCvGM95JkRbEdXqBRfqexBRsDqPK9TDeGkNCQjFv/yPmJ3EpQPcX0fiDnKIAvmhpRCnd0IAymfQeEyKSVnjOdsA5xWY5NG1H6n/1IuNPQq6r1OT8uheeqyRtpDkiXIwsNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=J9El22d1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k/puBfybqGdRr3s0WvxOTD3Uq//G7F2oQm8GUykR+Bg=; b=J9El22d1eLEvXYRqeMrIo/on1Y
	xKAb0pZjsq5PVXgThiBl41GRr0BHp7i/pJK9+wlrkWI+MAcv1d+GKcDZVno/b2lv6J2dz7dJMq0u5
	f8aZB4jeZrAZ0qKTW0uP49kEVwMib1KR8qHxsb7MGaFUZaLHzGRhlzolaD99EYQZiqoumUb4381bY
	wlzvjyoBK+eA3eO87XiJlOudtLYFK0MLsM/7QMVXaeI7gxX5hevKWaQyUIiaCCwHaqVXhEatxH7IX
	KcIPWfR59DT3w66YccTf+I1Xx3Ai30S0Md1p32AxY0vqhjS51mW4xTPXQ1+1kdJ8aWMY192U2kBPj
	WItA821Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s7H3Y-007XlO-0F;
	Wed, 15 May 2024 16:00:40 +0000
Date: Wed, 15 May 2024 17:00:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jiasheng Jiang <jiashengjiangcool@outlook.com>
Cc: brauner@kernel.org, jack@suse.cz, arnd@arndb.de, gregkh@suse.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libfs: fix implicitly cast in simple_attr_write_xsigned()
Message-ID: <20240515160040.GL2118490@ZenIV>
References: <BYAPR03MB41685A92DCDD499A2B1369F0ADEC2@BYAPR03MB4168.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR03MB41685A92DCDD499A2B1369F0ADEC2@BYAPR03MB4168.namprd03.prod.outlook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 15, 2024 at 03:17:25PM +0000, Jiasheng Jiang wrote:
> Return 0 to indicate failure and return "len" to indicate success.
> It was hard to distinguish success or failure if "len" equals the error
> code after the implicit cast.
> Moreover, eliminating implicit cast is a better practice.

According to whom?

Merits of your ex cathedra claims aside, you do realize that functions
have calling conventions because they are, well, called, right?
And changing the value returned in such and such case should be
accompanied with the corresponding change in the _callers_.

Al, wondering if somebody had decided to play with LLM...

