Return-Path: <linux-fsdevel+bounces-49426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7AABC191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F32A7AC10B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98755284B36;
	Mon, 19 May 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qfO1NOoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99B1C8603;
	Mon, 19 May 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666939; cv=none; b=MzQRW9UODN7NwUHb7Hg0SHUUZVmmBEXXTqj1zYaIpz3kuBmcuuebaeCAjd0dbYYx+NDtHY8VtDDHVWD2RyFxD6MIx3CuG2iLoZAhrWHrjic73ORvbqVWy2ZZN9imzVoAFeFnOqN+G9ggLGA3kSuOg70KJFjYucc74BZrTX4vEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666939; c=relaxed/simple;
	bh=iOG4uVnyNgfIKYKGomwH6kQE4Zu2JYG+HCSm5JAh6ZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VEVNlY35xL1gwgLfvebr8/nZs7I+1kXYx7R+Iu74AJNFmZDRe2pGE+EQyV2g0PahJTGuffTIro+lSif6u0KLj5M0Q5qOzp9/a+vvofM2d+18QuaPp221IX75YFeAnNkHu79zinN4aPUO7CoSJBmkZnWjoK/jGLce7Eu0dYDSHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qfO1NOoP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2FC2841EC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1747666936; bh=iOG4uVnyNgfIKYKGomwH6kQE4Zu2JYG+HCSm5JAh6ZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qfO1NOoP9fPo5gXZIp9Kxaap4jXSGzx6QaMvwFHhzka7t7k3EN3kNrP41vaFiSCs5
	 gJq8p9rj3QIc2oTX6cETDNXWes9X6h0diMNcaoX5jZ/xQjq+Y08gnIXwtWL/BAhW16
	 6q6c0i/CU/XdbMdTNQS5NChqD2n7+e7xuSVrORiSHwjA26kCUATp08OlDMJuQpiuHV
	 DFpBWAvTDzizgK0Ggq6w2LUnrr7bLjW3uOzktkKwOdfo2YlLoL/YiE/ROSFTmX0pws
	 rhc1+Of2EITPfUKT/oCXbNGkSlgfzNgmKhQKJc8Ye8CbZe7Yab7J26lsfjnFpLdGjT
	 GNSx1yJSKID2g==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2FC2841EC5;
	Mon, 19 May 2025 15:02:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Amir Goldstein <amir73il@gmail.com>, chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, Bernd Schubert
 <bernd.schubert@fastmail.fm>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/2] docs: filesystems: add fuse-passthrough.rst
In-Reply-To: <CAOQ4uxiMh+3JqzqMbK+HpFt-hWaM6A2nW3UHNK9nNntDRkRBeQ@mail.gmail.com>
References: <20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com>
 <20250507-fuse-passthrough-doc-v1-2-cc06af79c722@uniontech.com>
 <CAOQ4uxiMh+3JqzqMbK+HpFt-hWaM6A2nW3UHNK9nNntDRkRBeQ@mail.gmail.com>
Date: Mon, 19 May 2025 09:02:11 -0600
Message-ID: <87tt5giqz0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, May 7, 2025 at 7:17=E2=80=AFAM Chen Linxuan via B4 Relay
> <devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>>
>> From: Chen Linxuan <chenlinxuan@uniontech.com>
>>
>> Add a documentation about FUSE passthrough.
>>
>> It's mainly about why FUSE passthrough needs CAP_SYS_ADMIN.
>>
>
> Hi Chen,
>
> Thank you for this contribution!
>
> Very good summary.
> with minor nits below fix you may add to both patches:
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

It looks like these comments were never addressed ... ?

Thanks,

jon

