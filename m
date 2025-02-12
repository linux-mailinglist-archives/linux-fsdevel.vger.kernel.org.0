Return-Path: <linux-fsdevel+bounces-41600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6414A32985
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F9164EEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99AD21127E;
	Wed, 12 Feb 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nme/0NXh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388E211286;
	Wed, 12 Feb 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372831; cv=none; b=sZCf4ilmunBEUGO5pgQCt5id9a69aoYqsQk1X2JaNKJalIrbyAdEB7MrDPsYl0CGU41cZvfSpNscgVkOu/KKlY/1BAoMEH3nnuRRStyj0ZAZQiHCJJ4OTbmbGD/wNGCB3LpGzRqdaBG6AO9b8AZ2c35uvYCrFFa76C8eIy0wFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372831; c=relaxed/simple;
	bh=zN1cqeJ4n8iZCTefb/xNi+E397LMgJlsB4l/CmM34tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WlpJhK+6B0JDwjkeo1TBzYt1W9qTin2esO4jUW3xX5miWkb3PrnfNar/0A3s/Wm2ryMgQUqKWn868gz0s3J24y9l7d0lRws2nQ/5tX3mTQEellxVMRhWRlYal4Kedg3ltQyGgp29KhCxVRJFtgbnJLHVHcVv+r+IBq9eKsSSZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nme/0NXh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A9115411AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739372819; bh=zN1cqeJ4n8iZCTefb/xNi+E397LMgJlsB4l/CmM34tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nme/0NXhvJfGAfAkQWzh6foZ35Y9dNzRxzeqBX5eRbWY1VU5FpeRP12lXExMsPhmX
	 h5hNu5DZOuxBM0peTldXFUbHrU283jALXCAs2avrZKl8CiR9WHTopd0z6qQihLOPS1
	 WtUgf6kQNqtYIFM6fVUD8SIWnN2OpyAlMuNnjYkyvVxSQbPAE38+UU0VftkReixdGW
	 HCvZLJhhP1Y0J06WjQVWRWstC8M8bMjy4nigCj4Zr1bEOv+p2WdEgGOapN/vWLAtCO
	 zBgTScCfdCigMieYp5vaHx4Gl1fxZ6ZeCQtYh5GCed+r7c0xBDsQq2lqc7Usykg2t7
	 eq+CytWi5k3Dg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A9115411AD;
	Wed, 12 Feb 2025 15:06:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Aiden <jiaheng.ma@foxmail.com>, brauner <brauner@kernel.org>
Cc: sforshee <sforshee@kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-doc <linux-doc@vger.kernel.org>,
 trivial <trivial@kernel.org>
Subject: Re: [PATCH] doc: correcting two prefix errors in idmappings.rst
In-Reply-To: <tencent_56F055D25153E6EF7E7DF6F8F146E4313408@qq.com>
References: <tencent_56F055D25153E6EF7E7DF6F8F146E4313408@qq.com>
Date: Wed, 12 Feb 2025 08:06:58 -0700
Message-ID: <875xlfurql.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Aiden" <jiaheng.ma@foxmail.com> writes:

> Add the 'k' prefix to id 21000. And id `u1000` in the third
> idmapping should be mapped to `k31000`, not `u31000`.
>
> Signed-off-by: Aiden Ma <jiaheng.ma@foxmail.com>
> ---
> Documentation/filesystems/idmappings.rst | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Your HTML mail will have kept this email of the mailing lists; please
resent as plain-text only.

Also, trivial@kernel.org has been inactive for years; where did you pick
up that address?

Thanks,

jon

