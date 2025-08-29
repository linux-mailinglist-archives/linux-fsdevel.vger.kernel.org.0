Return-Path: <linux-fsdevel+bounces-59666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D1BB3C533
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 00:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7924A66318
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA452D8378;
	Fri, 29 Aug 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ldt5wdMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A832D6630;
	Fri, 29 Aug 2025 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507312; cv=none; b=t8/arEGoIbpKedW01CtB0dsF++3Y0unqqLmSR9XnNMPBRXYFb3ErKSz1i3KrR4Xky1kGS2fmu3ii39aP6Z7B+AdYPAuSDBdG6ogwW4ScbIkXNzuVyHHaBKAP9eFfGWH5jKNjDID1gM900sQBhwrc2ifKwLpa53Lrx7isWTj+p0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507312; c=relaxed/simple;
	bh=LrGW602noRH4ycUbq4ifn1lFbE7sC7VkXZRcjJjJqWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDRKxsyqAXd4j6X1O+DVVe769q9KUB7HxVd9Syi1hw5jS0IsSJaBffr2VRMlq821RDoGadD5m8KFaraYtIo+aQJmtFRyc9FjI9Qn96qUUX3Ui0XfKh5J7q9U3nypPsgBTQLojfGlEAFSYRpemX97ORPnAKs927rMKzgpC9udKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ldt5wdMm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7B25C40AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756507310; bh=LrGW602noRH4ycUbq4ifn1lFbE7sC7VkXZRcjJjJqWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ldt5wdMm3bFjCpjp91IqNimd990wa1F3Kvv1o5CdgwQDwHtsKcMU4UpQ2IgoHzAF7
	 iGErhb4LVIzpP7QUb3qzWNPr4Op7QfTs6LwCXGnLavAvEE9Whwpw6t03EEFMwxYvHU
	 xb7xfGWvBJ51jlsM6ezD2TsLTXa/SOAEWyue+3QOBBq7HMYsUjv9ttOk1frZ8zPLDz
	 vvUUIxpDxF2TiFFdGWG9Q0XUFUMXl2nYw3/6b48Gw7lghOOAf9awqpSYMsJ4Jab96t
	 GXco8XKiht8asLstbc7V8yTC6KqPhlzbyPg+bJU7jVk19UrDUpvGlbO2GbzFREFiuX
	 Vc+SNs/m3vsvA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7B25C40AF5;
	Fri, 29 Aug 2025 22:41:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Filesystems Development
 <linux-fsdevel@vger.kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Christian Brauner
 <brauner@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/5] Documentation: sharedsubtree: reST massaging
In-Reply-To: <20250819061254.31220-1-bagasdotme@gmail.com>
References: <20250819061254.31220-1-bagasdotme@gmail.com>
Date: Fri, 29 Aug 2025 16:41:49 -0600
Message-ID: <87ecst3g42.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> Shared subtree docs is converted with minimal markup changes to reST in commit
> cf06612c65e5dc ("docs: filesystems: convert sharedsubtree.txt to ReST"). The
> formatting, however, is still a rather rough and can be improved.
>
> Let's polish it.

I have applied the set, thanks.

jon

