Return-Path: <linux-fsdevel+bounces-2316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90F47E4A89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720CC281396
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3FA2A1D6;
	Tue,  7 Nov 2023 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rK+OnYx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168DC2A1C1;
	Tue,  7 Nov 2023 21:23:22 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6EDD7A;
	Tue,  7 Nov 2023 13:23:22 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F31F12E6;
	Tue,  7 Nov 2023 21:23:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F31F12E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1699392202; bh=2bPfjR7kBNZGvheEbYB67hyrLGZvMBmZpVWx1tFetOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rK+OnYx1kL0a3bjZDfsENQn/36liPQbikm+cF0IIL7uoRqvigxogbLjdpPCqpOUL4
	 20vKdaAIOJQTqgbNBat7EE54SVjzJ1cB0r+6Hj6klHk0UaQtTvHi0zzjA7q+UtIOBg
	 eLOp8qgztGXW1kIIl+AOBvajTaaMWbbj3biCrXYq4GjtY/78SLhH2r2hHMkfr8Qz1N
	 IuCUc1qUEkHhZdyLr3nsjFMAHG6n+Ha22XOXRgKRcG+R0zXHSP/SXwwziD9EBQ+TvJ
	 0a0H3NY+qRfmDvAUoyLtplpp3HfufK2AolwLLciPpzLM1PTay0YOi1/RLDhckMUJMD
	 yFMw/uISJbmyg==
From: Jonathan Corbet <corbet@lwn.net>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, Karel
 Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells
 <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>,
 Amir Goldstein <amir73il@gmail.com>, Matthew House
 <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
In-Reply-To: <20231025140205.3586473-6-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
Date: Tue, 07 Nov 2023 14:23:21 -0700
Message-ID: <87il6d1cmu.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Szeredi <mszeredi@redhat.com> writes:

> Add way to query the children of a particular mount.  This is a more
> flexible way to iterate the mount tree than having to parse the complete
> /proc/self/mountinfo.
>
> Allow listing either
>
>  - immediate child mounts only, or
>
>  - recursively all descendant mounts (depth first).

So I have one probably silly question:

> +SYSCALL_DEFINE4(listmount, const struct __mount_arg __user *, req,
> +		u64 __user *, buf, size_t, bufsize, unsigned int, flags)
> +{

Why use struct __mount_arg (or struct mnt_id_req :) here rather than
just passing in the mount ID directly?  You don't use the request_mask
field anywhere.

Thanks,

jon

