Return-Path: <linux-fsdevel+bounces-70607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64ACA1DC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 23:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41310301B833
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 22:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBBB30AD0C;
	Wed,  3 Dec 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="pXsEgiLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646A3074B2;
	Wed,  3 Dec 2025 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801954; cv=none; b=Xf/bv+qaBPU8LzVwKSLYIhQPZBFLWWqu8SJpX0ykM4MrcexcEm2Uo0Wd3wcd2JiE5PIieO7WXZxJ5joDTMrBwfsPLASPv2q2WiVa3jykbCDPkqGFaBlm3L43ElEUhjq33g2Q0LdSA4pdF1EaXpb3Aj06p0F1KjRZbYkEiL5zjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801954; c=relaxed/simple;
	bh=es0sHGSXf0TAHojh7pfKWhuK0I7X1mCUymuTUFORLoA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=mLqo95LceBQhl/V3N08L9TGt8tv0U/K9BSP+4CPt4F4A+K5BhaT3AViLNZOtEO+mudn6o00OE3Ce3EREFO8hEq5tfL2gz5Pwj7Ox1xLfwCXPazB3OcX+npchL2UfkZjZ8kG2L4zHT1EFEpP+Xlp0FvoAEiwVwqJ2PrNa+762NKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=pXsEgiLT; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=es0sHGSXf0TAHojh7pfKWhuK0I7X1mCUymuTUFORLoA=; b=pXsEgiLTwJAV5A++CQT2nZpcyu
	Rxp2tsMtvEk/LXjaGPf+pdBp6DDYK5CSjPlEY4VUVMl2tJCyppIXfoo51F/JNyDJ4IeXZlP8EUH07
	6Mk0cxcGzr5stT5+MyjsOzMB+eI1IwieOsVZa5Qjz1X0b+upQ/yRNz9O3FuJAWKPzLBbCcS0G+fZt
	qCZGPUCNdzMYTkheJQWzjD6SG5YhkPV1nsnA4Y4vnk04Nrb24x28EeeKKyf4dERlI5U3bcMNETVr2
	REUKIsJCd8dH1WwNzyB0TosfsQpt6MoXyoUhuBNJoCmG0qtLiO9LBKJ5rj70uC563CIvCvCw+gtn3
	oLwhxrHg==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99)
	id 1vQvbZ-00000000B1P-2J9H;
	Wed, 03 Dec 2025 19:45:49 -0300
Message-ID: <b2fd5b735c56d701373fd7728c1ad2de@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
 Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix handling of a beyond-EOF DIO/unbuffered read
 over SMB1
In-Reply-To: <CAH2r5mvYVZRayo_dJGbSKYuL73kpBM+PwSiNm39Pr0mt37vx9g@mail.gmail.com>
References: <1597479.1764697506@warthog.procyon.org.uk>
 <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
 <CAH2r5mvYVZRayo_dJGbSKYuL73kpBM+PwSiNm39Pr0mt37vx9g@mail.gmail.com>
Date: Wed, 03 Dec 2025 19:45:49 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steve French <smfrench@gmail.com> writes:

> Paulo,
> Added your reviewed by to David's patches but wanted to doublecheck
> that I didn't apply it to too many of them since I couldn't find one
> of your notes
>
> Does this look ok for your RB on all 14 of these - or just the SMB1 one one?

I'd reviewed and discussed the other 14 patches with Dave already, so
please keep my R-b on all of them.

