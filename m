Return-Path: <linux-fsdevel+bounces-61209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3988FB56127
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 15:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33314806A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55012F28F2;
	Sat, 13 Sep 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l/ps5pxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20B2EC54F
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770233; cv=none; b=i+vM+T4jMDxsHQsArtyXAuL9NrZ/NSNy3Bv8whR6Z9i7suf5ciOztT9hjFMkeOiUyKC8WS+ZYFD3TAAi77LeDCiZP5M5mPS9iB35ipyXWQm6w6IlyO/7ZRO9P0ymMPAh2nk9fz26iSDLdev725XXkcR4v8cfiErCyi7ivnK7Uo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770233; c=relaxed/simple;
	bh=R+EwJWUL37Dd0XJ17zi8pxpqIyS/lb7ojPwcQ9X/6GY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eQPPCamcpwYeGQq0vSI9I2plh/Bnwf52OhYxeFi1K5lO6yWS9bG2QjVT+9SNbecUgL0eykt1tf6UReOcc6GQNSxqTAIyhqw8PPdxvdlA5C/IXytlVawIVH+BY2zuZy7c0RCmSyeBQ7zPBy5yUEv99CgwDssDXFP50NW83pY6/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l/ps5pxY; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757770228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+EwJWUL37Dd0XJ17zi8pxpqIyS/lb7ojPwcQ9X/6GY=;
	b=l/ps5pxYqVJaXQHQrGP0VRKQYuNIAxNGZ4QgWm/WIW8p3BHTkv1aMRjc1cX2FkWAW6Zo53
	LRKEKod2HD6y6WeMMAtIR3Iflf0b1zPaK9yPuRdnBehoxMZpntvbLFX+Yqk7PB6ZVxB9hL
	DwnS3nKDRP7U8eh1JEJ3j58/D6AKVOM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] initrd: Remove unnecessary goto label 'successful_load'
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <o2ijjlbcicrrfflp54o53sj5v6morqedtkkzizhhyvl6cqvezw@yl7hx3naojcn>
Date: Sat, 13 Sep 2025 15:30:15 +0200
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <41D6E945-CB4B-4AE4-9ED7-277B59E9DC32@linux.dev>
References: <20250913121514.1789204-1-thorsten.blum@linux.dev>
 <o2ijjlbcicrrfflp54o53sj5v6morqedtkkzizhhyvl6cqvezw@yl7hx3naojcn>
To: Klara Modin <klarasmodin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 13. Sep 2025, at 15:11, Klara Modin wrote:
> On 2025-09-13 14:15:14 +0200, Thorsten Blum wrote:
>> The goto label 'successful_load' isn't really necessary. Set 'res =3D =
1'
>> immediately and let 'goto done' handle the rest.
>>=20
>> No functional changes.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> ...
>=20
> This is now the only place where res will be set to 1.

Sorry my bad.

> This does not seem correct? After this patch res is not updated to 1 =
anymore
> if execution reaches here without taking another goto, i.e. the return
> value is changed by this patch.

Thanks, I agree that it doesn't make sense. I only intended to delete
the label, not the 'res =3D 1'.

Please ignore this patch (unless someone thinks removing the goto label
is worth a v2) and sorry for the noise.

Thanks,
Thorsten


