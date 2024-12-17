Return-Path: <linux-fsdevel+bounces-37615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514839F4583
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CC1188C886
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD701D5CFE;
	Tue, 17 Dec 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nawwXJN5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6515624D;
	Tue, 17 Dec 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421916; cv=none; b=AMTEEwugeaiMc7ytkGfGozgWHCuneSGLlhfhHpjhMyguOKjwXsgiMrwfnIrXB/aQ1n72dfCA8Tl/TYjzAEfwIVnIFcytXLI95RgScVROZ9A9aojr7556BaWwPJQB6rQFWpPokvkg2ifqvWYkV0zgOBpNvch9+RkH9zRz/yZyTC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421916; c=relaxed/simple;
	bh=W7u7NrNIt6wEF6JH3dnaSIkQytYOxlYwLmxwNTHF0XU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MqqPyicKYjMO/QVCECi4/7ZVOqD2Y11qLNAegduNp2XnQfgc7NfRPnFuQ4IQlYNpr9b//TOjl5iU8WqJgXxG+AKdYb8RPMkyVANQMpkinaP3GSIJoz9TepYPino2RHvRzlQdUM5ctQWB/Ku2rPdZUbLJLp11AS4coNFR2aAcIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nawwXJN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6378C4CED3;
	Tue, 17 Dec 2024 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734421916;
	bh=W7u7NrNIt6wEF6JH3dnaSIkQytYOxlYwLmxwNTHF0XU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nawwXJN5SgUl99Yi6ymd3rloqO97qd3jMRK6koep+pMWnljWNfFpbm89bmKUC+fHW
	 Zpw06/nxYEXMUX4ZRtFWeSLDx8tzpBynIINdK/Un7erHvqeQwX5dVBw3HSa1tQRwQv
	 AwJa8FLXRvD3hbRhGYNC5HeS0xIzz3+5IusZ44xydG6Qydl3ZJ1MmcTqwMzLSqhAxw
	 45M5YU+99EgaVeqMocSCfwfJsCoo11sxDJWBOi/oI0pTrFc7WesVGsDissWRQozNUT
	 F7SM0z7nGDlxhulMXaJibTgH1PTOOkKZ1bxro4CRxGYj1okSJ8CdU2gC4kKL5/L3ZY
	 nem64fEonWgbw==
Date: Mon, 16 Dec 2024 23:51:52 -0800
From: Kees Cook <kees@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
CC: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] inotify: Use strscpy() for event->name copies
User-Agent: K-9 Mail for Android
In-Reply-To: <Z2D6FzPgomC442vW@casper.infradead.org>
References: <20241216224507.work.859-kees@kernel.org> <Z2D6FzPgomC442vW@casper.infradead.org>
Message-ID: <41850E19-F71C-4D69-91E6-7B095A9FFD5C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 16, 2024 8:12:07 PM PST, Matthew Wilcox <willy@infradead=2Eorg=
> wrote:
>On Mon, Dec 16, 2024 at 02:45:15PM -0800, Kees Cook wrote:
>> Since we have already allocated "len + 1" space for event->name, make s=
ure
>> that name->name cannot ever accidentally cause a copy overflow by calli=
ng
>> strscpy() instead of the unbounded strcpy() routine=2E This assists in
>> the ongoing efforts to remove the unsafe strcpy() API[1] from the kerne=
l=2E
>
>Since a qstr can't contain a NUL before the length, why not just use
>memcpy()?
>
>>  	event->name_len =3D len;
>>  	if (len)
>> -		strcpy(event->name, name->name);
>> +		strscpy(event->name, name->name, event->name_len + 1);

So that the destination is guaranteed to be NUL terminated no matter what'=
s in the source=2E :) (i=2Ee=2E try to limit unlikely conditions from expan=
ding=2E)

--=20
Kees Cook

