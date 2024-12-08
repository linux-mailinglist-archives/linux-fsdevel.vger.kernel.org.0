Return-Path: <linux-fsdevel+bounces-36714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0A89E883A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 23:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C051216387C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 22:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE0718453E;
	Sun,  8 Dec 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="dEH7H7bb";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="ltA0ekiH";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="qluQJvNW";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="N6VaiPZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE51DA23
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Dec 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733697143; cv=none; b=CiuPS0k1vO88c1KSwkRabq8CY+rtgDH+OmMvaQn/8OPw/AEvhwb/9SpU8LYuKlHHW8cADmpkgpLes32INuIWO/u3MWC86Z+A1et/bj6aTi+5Fn9CcMoGhYPFL320DJPqVrAkW5OuJ/vGNZiLhXHklelcKXlmKG5EORvxYAKzXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733697143; c=relaxed/simple;
	bh=wx71ZcuBrQXuKP8KxiiM68kr5T/W7LdEZHrkIbjsaI0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bOXIgaAmMJwXdWlRZYL8kruwtoyxBE8f9hMxJKAp8nGc4LdyQB0T7Gy4U22jgWS6qMC+VeIY2XlvLvFEXs/6HaKee4Segp5h5wZi+ERAjD/vU8Fj1OSR4h/01HHDTuqIQnn0m4uAfsQgXKnmBWK70wzTgVnJ2GLsQ1dGsj4C7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=dEH7H7bb; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=ltA0ekiH; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=qluQJvNW; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=N6VaiPZF; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:808e:8168:83e7:b10])
	by mail.tnxip.de (Postfix) with ESMTPS id D493B208CF;
	Sun,  8 Dec 2024 23:32:16 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733697136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttwo0awN7SSVixNX02knxUNLQtEhIIs1K1K18/qUJEc=;
	b=dEH7H7bbbOvRc6grLrc/W2mvGAwFT+tMIUGX/D+IdHTkGsSyq129zC/Fa24l/6m4QtPlIM
	0UBQW2yasbU5CNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733697136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttwo0awN7SSVixNX02knxUNLQtEhIIs1K1K18/qUJEc=;
	b=ltA0ekiHMVsU9vS1xqLh6fZmOppy5SKfEZU6bQbPimXjmLmdiISH6eKjR/fonJYzov7XKA
	7VoJmqFBlSocPBErVIqfWaZgT64g5/2ShzWpCCv5T88/+A6RRLh49LELAc9OK2EAAR3w7v
	zmqS40SVJUgYv3TTDqBzOqVFQWALyd4=
Received: from [IPV6:2a04:4540:8c05:f700:b769:775:6562:48b8] (highlander.local [IPv6:2a04:4540:8c05:f700:b769:775:6562:48b8])
	by gw.tnxip.de (Postfix) with ESMTPSA id 34CFE780FEA1F;
	Sun, 08 Dec 2024 23:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733697136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttwo0awN7SSVixNX02knxUNLQtEhIIs1K1K18/qUJEc=;
	b=qluQJvNWER1VlL8oEDRV8ReDTBHhDplAgwrmKN/Gb3yhkh0DtXYsR5YGiBkzsuVWKkON6+
	9M+Td0nS2Ww1x8hctoxhzwVPP76G//fc+psDOhanvj5KMjX0qcoJ2NbXWF9/SW9uLaY7XW
	/jQvqbAmV9noLpMz2SC0aLXyWQcwows=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733697136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttwo0awN7SSVixNX02knxUNLQtEhIIs1K1K18/qUJEc=;
	b=N6VaiPZFpjKtRlXW/6LQwj9G/nP0Lxzh5HBSN/2HkJPfowFNLTjACdGM0FO7u8QC5IFQGt
	5fvApv3sZVadIHAg==
Message-ID: <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
Date: Sun, 8 Dec 2024 23:32:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
Subject: Re: silent data corruption in fuse in rc1
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
Content-Language: en-US, de-DE
In-Reply-To: <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/12/2024 21:02, Malte Schröder wrote:
> On 08/12/2024 02:23, Matthew Wilcox wrote:
>> On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
>>> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
>>> me.     
>> That's a merge commit ... does the problem reproduce if you run
>> d1dfb5f52ffc?  And if it does, can you bisect the problem any further
>> back?  I'd recommend also testing v6.12-rc1; if that's good, bisect
>> between those two.
>>
>> If the problem doesn't show up with d1dfb5f52ffc? then we have a dilly
>> of an interaction to debug ;-(
> I spent half a day compiling kernels, but bisect was non-conclusive.
> There are some steps where the failure mode changes slightly, so this is
> hard. It ended up at 445d9f05fa149556422f7fdd52dacf487cc8e7be which is
> the nfsd-6.13 merge ...
>
> d1dfb5f52ffc also shows the issue. I will try to narrow down from there.
>
> /Malte
>
Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
with 3b97c3652d91 as the culprit.

/Malte


