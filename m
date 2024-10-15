Return-Path: <linux-fsdevel+bounces-31977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2844E99ED28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3934B20EF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF61FC7EE;
	Tue, 15 Oct 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="gQ9AzmYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2D1FC7CA;
	Tue, 15 Oct 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998471; cv=none; b=bQHT3KcD5kdfxtsPE/Djym4kzzDwpsORp6GTz0dMpjJZ9aMFp8mQuLVvPiqGaEwGiHi/lYPuMIXBOAokWPuC2zEZ9M9OeMJXJJRfynpmT0Wq0w7Ed94CUonOQNZNZ8yU9d5eIgKK73IGcVqRSjBRE8rEe0LoECMwrGADtBrM6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998471; c=relaxed/simple;
	bh=U7+SL2Dsj3x9o3x8Ayq9bwF0PHRYf5iIymEoLyJT7hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cKK1cf8f4fUScSbm1Q0SjJzMm1MzhrRqyzRJmKDzsCHhFRKuaPRx2WV2BRoEqqKoIVBYfYsys/Lq1qdLKtoftAohu23mazig1yslaB9nWqji1W6L4RYA2mbaQB/OY91y5iEo1yWH+Kiy3j6Sv+UubtX0/C6AaainE3ZG1yFIE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=gQ9AzmYd; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 027C760009;
	Tue, 15 Oct 2024 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1728998461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzsywUYuiwbhx55bjvyt2J4KNPE7dcZU7e49a12afaU=;
	b=gQ9AzmYdc7GYvx5XULf/FocUXELlEKjfT3q8+wLZsyrnR+SIXM67RSnKQEuxaN+8qqq1Yx
	mhiWLzb1VwXCu6jGZsHm1fQahQV5PoAyvm5KCkLeEjPnjzId+/Pv9QIszNwFMGSG4OE7NV
	CXMBC8YwhV9cC7nyvghCzdvHB1fOW8q8B9QfGdJcM8RIUjCYO327BuY6fxQgZ1qUO1BdHc
	Kk5fYJCKwuQH6W3FoRSITiC3L0KWZ0OHK3/eiKHvIuTmb5PNkDtqoPH3FjTb9j2PYu1C2S
	n3ZxxvA6hYpv0oQ6r8LJOWrilbRCw6A10Eg2w4xpgtLD7CRskhX29aAwh4WGOQ==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Brendan Higgins <brendanhiggins@google.com>,
  Rae Moar <rmoar@google.com>,  Kees Cook <kees@kernel.org>,
  linux-kselftest@vger.kernel.org,  kunit-dev@googlegroups.com,
  linux-kernel@vger.kernel.org,  Stephen Rothwell <sfr@canb.auug.org.au>,
  Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
  linux-fsdevel@vger.kernel.org,  ~lkcamp/patches@lists.sr.ht,  Pedro
 Orlando <porlando@lkcamp.dev>,  Danilo Pereira <dpereira@lkcamp.dev>,
  Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: [PATCH 5/6] unicode: kunit: refactor selftest to kunit tests
In-Reply-To: <20241011072509.3068328-7-davidgow@google.com> (David Gow's
	message of "Fri, 11 Oct 2024 15:25:09 +0800")
References: <20241011072509.3068328-2-davidgow@google.com>
	<20241011072509.3068328-7-davidgow@google.com>
Date: Tue, 15 Oct 2024 09:20:57 -0400
Message-ID: <87wmi9sds6.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

David Gow <davidgow@google.com> writes:

> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
>
> Refactoring 'test' functions into kunit tests, to test utf-8 support in
> unicode subsystem.
>
> This allows the utf8 tests to be run alongside the KUnit test suite
> using kunit-tool, quickly compiling and running all desired tests as
> part of the KUnit test suite, instead of compiling the selftest module
> and loading it.
>
> The refactoring kept the original testing logic intact, while adopting a
> testing pattern across different kernel modules and leveraging KUnit's
> benefits.
>

Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>

-- 
Gabriel Krisman Bertazi

