Return-Path: <linux-fsdevel+bounces-41787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E462A37582
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B5D16EEEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CF919C543;
	Sun, 16 Feb 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="0d08wVSi";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="YbRebIAE";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="BNaYc1gl";
	dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="FEmFtyCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF901194A6C
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Feb 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722340; cv=none; b=cqwzLx2lBX/scZC0w8K/DrNuszqrzE3/aFfYv+IJUE7GVVL4wBaEKmdzA29pgskQsqK+Orbtzq4uAaafB2+shb+pHKbWHwaP5R5xpHssZ+sXaaBbmPpAGUQOR0YxdlnxC+Tro4OMohDHvjL9s9dK7RIXN57ieXH/rX+PsFgDes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722340; c=relaxed/simple;
	bh=AD3pnt+DAnHLgfgIibXEPMinmyZrMiTsQf+5EUvh/uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3BPuF1BuxYFoF2PC6GFY09S3SrwzChqel9NPo5REsg8btcqAOVOkqD0UWjwvnFgL6fBu1b+ArCOd0bMkqvDrXdhI8s8bQVK0gWJfWUGcF8iNOJNz1qKuZfrkL8uuY+4QXmvB91zCbXmJPR9vp2x2uoxVQTroAm7XGRY03vj538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=0d08wVSi; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=YbRebIAE; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=BNaYc1gl; dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=FEmFtyCF; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:154:def6:2611:4f2b])
	by mail.tnxip.de (Postfix) with ESMTPS id 94E7A208AB;
	Sun, 16 Feb 2025 17:12:04 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1739722324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uBkjYqP5JIgG5iQ/D34V7VSDU02J6/XrzwOWnxLnNE=;
	b=0d08wVSiNQ+6Eudjplo9Cu1y1nKWzHpT1Nr2Z9m1s2uctjqt6wRm/Gzg9Ef0clTbK68MwT
	tw/fdvSfL5K4DLBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1739722324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uBkjYqP5JIgG5iQ/D34V7VSDU02J6/XrzwOWnxLnNE=;
	b=YbRebIAEtHEqmKCLeGruQRpOdHHUrGgwq8zN1w4G32w9ba0ypRBcqxd/GWeughn/ZjSAMK
	l1OUixXPzPgFixHQJEW3kmfLPR4mFnm5tDcbURNWIHDopXI3mP4xO8fgiWlpUdPXZ3GG3f
	QlBE3gD/xr/UQYzAH1TP0MOmdOjsYo0=
Received: from [IPV6:2a04:4540:8c05:dc00:38e:599a:86c2:1131] (unknown [IPv6:2a04:4540:8c05:dc00:38e:599a:86c2:1131])
	by gw.tnxip.de (Postfix) with ESMTPSA id C43A430000000002F1FED;
	Sun, 16 Feb 2025 17:12:03 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1739722323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uBkjYqP5JIgG5iQ/D34V7VSDU02J6/XrzwOWnxLnNE=;
	b=BNaYc1glazZormSIYIYFr04YtehvrgDsrfGdutqhH/4dwdGE8bkpLtRW34+ho8QggFM/y2
	mVoFvCwm2Hq8DMBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1739722323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uBkjYqP5JIgG5iQ/D34V7VSDU02J6/XrzwOWnxLnNE=;
	b=FEmFtyCFYHT/KTJUXJ0PgIj6K7VC5OkPkLT7LeTaknM/4XwfdMPYGVkYboZk2Arh1h6xBe
	y7nu+4QGfTbMcvZ+Cwsi91b0fTh7NPYrYmLGv9fi0TLdNDFb3Zfl82QYspaWqNfjyANypj
	Yra18ts3Bxw0+R0RQvSM5mJbUN22uSQ=
Message-ID: <0e5236de-93b9-466a-aba0-2cc8351eb2b5@tnxip.de>
Date: Sun, 16 Feb 2025 17:12:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Random desktop freezes since 6.14-rc. Seems VFS related
To: Matthew Wilcox <willy@infradead.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <39cc7426-3967-45de-b1a1-526c803b9a84@tnxip.de>
 <Z7DKs3dSPdDLRRmF@casper.infradead.org>
 <87e7e4e9-b87b-4333-9a2a-fcf590271744@tnxip.de>
 <Z7Hj3pzwylskq4Fd@casper.infradead.org>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <Z7Hj3pzwylskq4Fd@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 16/02/2025 14:10, Matthew Wilcox wrote:
> On Sun, Feb 16, 2025 at 12:26:06AM +0100, Malte Schröder wrote:
>> On 15/02/2025 18:11, Matthew Wilcox wrote:
>>> On Sat, Feb 15, 2025 at 01:34:33PM +0100, Malte Schröder wrote:
>>>> Hi,
>>>> I am getting stuff freezing randomly since 6.14-rc. I do not have a clear way to 
>>> When you say "since 6.14-rc", what exactly do you mean?  6.13 is fine
>>> and 6.14-rc2 is broken?  Or some other version?
>> 6.13 and 6.13 + bcachefs-master was fine. Issue started with 6.14-rc1.
> That's interesting.
>
>>> This seems very similar to all of these syzbot reports:
>>> https://lore.kernel.org/linux-bcachefs/Z6-o5A4Y-rf7Hq8j@casper.infradead.org/
>>>
>>> Fortunately, syzbot thinks it's bisected one of them:
>>> https://lore.kernel.org/linux-bcachefs/67b0bf29.050a0220.6f0b7.0010.GAE@google.com/
>>>
>>> Can you confirm?
>> >From my limited understanding of how bcachefs works I do not think this
>> commit is the root cause of this issue. That commit just changes the
>> autofix flags, so it might just uncover some other issue in fsck code.
>> Also I've been running that code before the 6.14 merge without issues.
> If you have time to investigate this, seeing if you can reproduce this on
> commit 141526548052 and then (if it does reproduce) bisecting between that
> and v6.13-rc3 might lead us to the real commit that's causing the problem.
>
I will try. But I will need to find a way to reliably reproduce my issue
first.

