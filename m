Return-Path: <linux-fsdevel+bounces-36656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BA9E7636
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB5A1889C20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE846819;
	Fri,  6 Dec 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EbLKTlRu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29EA206291;
	Fri,  6 Dec 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502850; cv=none; b=PpvDRJ2N4IYVWOGDWoFJrLuVtfn31MVlskcpuNjhLZj6hCDitieRRsRYboUeJuZRO9TAPePpnyr9o1Tm3YPUEOw203gDn1bfikNJRz3J61Vl6QgffoV1CpnMYuMOgmmZmPcABcR2iN5K6kH6U9+G3tYncE1qR6EPBqTHnWZIuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502850; c=relaxed/simple;
	bh=LKueHQ78rcCNc7U7HIc5TQLJq760z6/eZpxwR/v78to=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rdtqyTuAzAXakKDFTtf/YWYt+zqyUpn5tqOvkia+4vnv0javcsA3fx5un8EHb0XPJQthNm6IgICwsahzHn8EJWlMre7/DDGRf7rQcYMrT2UQgSZUl9sdHr1uEcgIpa4x6/psGAbML/tW4dsqCBgQwWzIIRZoR2ZP+5xyPmUbA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EbLKTlRu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EECB6403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733502848; bh=T+W35gjpwhIpUnM/HduaXP4iNQo3Vv3IpBLT9FguhPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EbLKTlRuL1ZSRbOSC8ggKaf0TCk4yoJNI6fCLy3hNZIQRmem7dHlMeowu3Jb4IyNO
	 y99UxsmjiSHUKRw53Sa080IJIsTxZnZlLP75V/63eY6lutHZ9pAiFbuXzXzAxVvO7H
	 vEkfvxdHYkgDxKbfl057ovTQdQRtTEs5FEhzOIgpKaXtUslviH10fOqncILfOxcEX1
	 abxVQhrLOrWywoRrIcz56NDRrOBRAsKzCtwr9JjDW+dcSlXYhIJLpPBnEyH9cLrKXB
	 JyV87SI9OnemckWng3e2+7udt7wXa/pfo+o/OJa8L2wmqM4Y15aKV966S5aDzxk4oo
	 QYZYt54WCva+A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EECB6403E1;
	Fri,  6 Dec 2024 16:34:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Eric Biggers <ebiggers@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: core-api: add generic parser docbook
In-Reply-To: <20241120060711.159783-1-rdunlap@infradead.org>
References: <20241120060711.159783-1-rdunlap@infradead.org>
Date: Fri, 06 Dec 2024 09:34:07 -0700
Message-ID: <87plm4u5xc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Add the simple generic parser to the core-api docbook.
> It can be used for parsing all sorts of options throughout the kernel.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  Documentation/core-api/index.rst  |    1 +
>  Documentation/core-api/parser.rst |   17 +++++++++++++++++
>  lib/parser.c                      |    5 +++--
>  3 files changed, 21 insertions(+), 2 deletions(-)

Applied, thanks.

jon

