Return-Path: <linux-fsdevel+bounces-32374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2CF9A474B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 21:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4C81F24D3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC3206959;
	Fri, 18 Oct 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="cCJhzNkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7A205ABD;
	Fri, 18 Oct 2024 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280659; cv=none; b=aSOBRbDWMXayL0J/81K0ZfS6K++hpSPStjzAppnDg2XcZPq/Q+bXC7tQNupT4xWgeLrkkEBShD2QhcVjivNWM6p+LO/M3N0tUvJOyQ5P1yi1MsNd7skZhJTTiXLxycF4aP7meIA/joy1MHOW2F+txW6mBVBNzZNM+oXp8I3ohU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280659; c=relaxed/simple;
	bh=Fn7NtVK9TJDKB86szYzmRbDM7eihixOgu4TdPgTjJfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jgs5OKY4Uq8SR9pW9cqmQYMB5NMEIGr8uVIA64DcV2KleacJmE7TqnBi5vAV918ya50TuK04U149PvrmZ2wPwKkIT+tcjZVVSDngjtsjurmy7mo7qtoSjFdEU4T+J9BMNu+kLhV3ZfpSKQoioBxU0G0vIwug064SaCxOdTpj0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=cCJhzNkQ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E4101BF20A;
	Fri, 18 Oct 2024 19:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1729280654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fn7NtVK9TJDKB86szYzmRbDM7eihixOgu4TdPgTjJfc=;
	b=cCJhzNkQcCL/43kskaieoxGKgwUb1cwDDM8hHGIHzW4dHtrXqALsFB0joV3Jxfk92LG0JC
	5Y9cHuaUMfBLbhBiGr2cCw+qCNwFzSS4h+MkOtU5YHOgHytesSB6rH9dXTJ2epeOX2ncZ2
	HXewB/od35Pu2Jy21PgSHu9TnWR8Og/tif1+2SN2yAkG+fMpAiotA28La0QhzImtoFNVa8
	MFWBAT7uV/a0L7NbW2qMiaZo+xYqO1Z2bvAjBfA4z1cNUSkqf5gll/WdM/X/LEoOJF6F50
	YhEVMGszvCCi5Lwxe8oRTipLZB9jLaE2x4mQ8EOOhopZUoGTS1Q7hdVHGo/6fw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger.kernel@dilger.ca>,  Hugh Dickins
 <hughd@google.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jonathan
 Corbet <corbet@lwn.net>,  smcv@collabora.com,  kernel-dev@igalia.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 6/9] tmpfs: Add casefold lookup support
In-Reply-To: <20241017-tonyk-tmpfs-v7-6-a9c056f8391f@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 17 Oct 2024 18:14:16 -0300")
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
	<20241017-tonyk-tmpfs-v7-6-a9c056f8391f@igalia.com>
Date: Fri, 18 Oct 2024 15:44:09 -0400
Message-ID: <87o73hyz5i.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Enable casefold lookup in tmpfs, based on the encoding defined by
> userspace. That means that instead of comparing byte per byte a file
> name, it compares to a case-insensitive equivalent of the Unicode
> string.
>

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>



--=20
Gabriel Krisman Bertazi

