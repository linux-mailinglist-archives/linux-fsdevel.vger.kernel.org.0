Return-Path: <linux-fsdevel+bounces-54161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC80AFBA7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A4168566
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B352641F9;
	Mon,  7 Jul 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hJYAdNUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9DC1A23B5;
	Mon,  7 Jul 2025 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912290; cv=none; b=pWd0wWvo4DcVL0DuvVxrB9f0oqWk3PFojVeW0jqtbnt4Ldvt2tODWS+5upCdu5C5qJ9IWASM8KT5yjOSZaaampzWHbDOTZMWfz8UcH6NvVAau97T4OJq3lLEVxIDcZDRTmTBvzOXOGVjjxvg2VgexAKnXzURuSvlOSHF9em+QIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912290; c=relaxed/simple;
	bh=pDI+5V6KgP/ER5J++RWkkIYIk4xybHsObqeJLJdlzjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yt9j3d5sqn/nkT4e52PjsjpANYuZ6AxBLUM/QtQDzbEovIilVsLUnvM2dO8d6g7cj2iClSsPGygacFbDhKLU61wU/zl8pMr8AsEyd6CRBu+6edNp5WdhLC+h4FQsXUCcnWdD9c/WyTinP6XPEIYtGy5icJLICh9rPWDWxywygOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hJYAdNUA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3373C40AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751912282; bh=pDI+5V6KgP/ER5J++RWkkIYIk4xybHsObqeJLJdlzjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hJYAdNUA3WXbfI4RZNUgS9ytEoN0KkPOarsSKgEl7K7RrcVHNlo4FLXpOIs5PDSTE
	 HTjtL0r8U8v/TZgFjVXTzVZD55+R75D5TD88SLbcLQjjZUFUYOMOwSUa5jw2SI86cw
	 RzbTcBTqTBKoq9GIDmg3GJAlu86SGS6dCIdCzPM7Sd/YfEW2jbH1KEXbnu4DtlOT60
	 G76ahmENyj0VZQQ+UZ0NhyGMKuRsHl7YtbudnGn8MK3JfmyS9SwtBgQ5YPT4QXVFrZ
	 U+d//OQTI+KvSPIaFvnlIKBSFmBIJs2nLBzb2YZYQmYtrVmsrUMirWDA7jMiH+ExBe
	 SFwU5I7pC+Tlw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3373C40AA9;
	Mon,  7 Jul 2025 18:18:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar
 <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Nicolas Schier
 <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, Thomas =?utf-8?Q?We?=
 =?utf-8?Q?i=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Kees Cook <kees@kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/15] kunit: Introduce UAPI testing framework
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
Date: Mon, 07 Jul 2025 12:18:01 -0600
Message-ID: <87qzyr7tly.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:

> This series aims to combine kselftests and kunit, avoiding both their
> limitations. It works by compiling the userspace kselftests as part of
> the regular kernel build, embedding them into the kunit kernel or module
> and executing them from there.

Please forgive the possibly dumb question but ... this series sets up
the framework, but doesn't actually integrate the kselftests, right?
Will it be necessary to write a little KUnit glue function for each
kselftest, or is there some other scheme in mind here?

Thanks,

jon

