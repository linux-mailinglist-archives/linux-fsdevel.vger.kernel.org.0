Return-Path: <linux-fsdevel+bounces-30006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04895984CFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 23:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B953A282841
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6A13F43B;
	Tue, 24 Sep 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="SMJFFxC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F713B792;
	Tue, 24 Sep 2024 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214040; cv=none; b=Q/NfAfWyDSujorQnrPGEYbNcPeL5eYRK+8dxuQ6b682bwqwhoHf0hmlTKbALWrOz/sCKJZ5cvlMqsbXH4cBFmHRPu/Ij5LuPJrPhNhpyB49bEw7CeJa4nP6VBbGV92zjNV6638fMw/JJHjO2d1aXhUCvIFZkUAHKwkst02btxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214040; c=relaxed/simple;
	bh=QPBzZ3SMXvnMiZiD02ai/RQDT8O0tJouF/VUgawARdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FyOMglh6aXJYHnvYEespX7re+o2awjzcA20rm54G4MeOzLet7IMG2JJupxY5lJ1rLcpR/u8DNW0X/XTVhIkdpUPH5t6x8tTVISqGj0bQxVlJVbJQ1xGFxuf/u3iZq9jvk6XpZGh2s99KeUGu2cbpVDVqyEuYKh1Sf6s2YNSYLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=SMJFFxC/; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1F14240002;
	Tue, 24 Sep 2024 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1727214030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaJj1MLXDZ4CV94KUfIQzONUVPr+m/dVwLv4YyvGwsU=;
	b=SMJFFxC/nctHg0+2vf5m8UHwCTJFYoxK5cjW0DfXRH6YPhm5iaU9zAtmlunKi0fqOMyB3a
	qpB4AXTkpQZSNqRman/lebrsUaEnRt1edxfHuAJg9dcQk7QunnZ63A2PAzMP4qsxJJYvaB
	A18gSHPxE2TUUW6WZRN/M8hiFXDJPLS3px1lcw2U0wrrlgkfCyxF0RiStjKByMTQIWz3nW
	UaRPCrdT7Rp5YlvbM5vUcY8o2YaJGZdESegYJi/xQhMcfwQHXADc43kFMQ9f7m+fHORPg9
	w+gdumknm3jsqlaH2qngBsK6Gni0EGS5pj2DXRsjWfmlDvxOjxCo13dkagKZzg==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@riseup.net>
Cc: Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
  linux-kselftest@vger.kernel.org,  Gabriel Krisman Bertazi
 <krisman@kernel.org>,  linux-fsdevel@vger.kernel.org,  Shuah Khan
 <skhan@linuxfoundation.org>,  David Gow <davidgow@google.com>,
  kunit-dev@googlegroups.com,  porlando@lkcamp.dev,  dpereira@lkcamp.dev,
  ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH 1/2] unicode: kunit: refactor selftest to kunit tests
In-Reply-To: <eb26f009-37e9-4988-ae86-c349af3f9a6b@riseup.net>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Tue, 24 Sep 2024 23:30:31 +0200")
References: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
	<20240923173454.264852-2-gbittencourt@lkcamp.dev>
	<eb26f009-37e9-4988-ae86-c349af3f9a6b@riseup.net>
Date: Tue, 24 Sep 2024 17:40:27 -0400
Message-ID: <87wmj0wx10.fsf@mailhost.krisman.be>
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

Andr=C3=A9 Almeida <andrealmeid@riseup.net> writes:

> Hey!
>
> On 9/23/24 19:34, Gabriela Bittencourt wrote:
>> Instead of creating 'test' functions, use kunit functions to test
>> utf-8 support in unicode subsystem.
>
> I think it would be nice to explain in the commit message what are the
> benefits of this change, why refactoring into KUnit is a good idea?

TBH, I wouldn't mind dropping this code altogether.  We have similar
coverage in fstests already. It was useful when developing fs/unicode
but nowadays, it seems moot.

--=20
Gabriel Krisman Bertazi

