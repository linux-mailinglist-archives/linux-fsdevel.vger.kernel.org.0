Return-Path: <linux-fsdevel+bounces-74321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD68D39937
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 19:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B646300A841
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2A2FF15B;
	Sun, 18 Jan 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4yD8TVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB61D5174
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768761579; cv=none; b=dLt9zwQVbkKwOpboZgnnceVD0stwe1dyLrY7zRxMD4rlCrtjICRDQ3dsNsKpzRRULXqMyQFnWKwkBbVTGsN2dzITu1O94JkPr7RliIh898kmd4DUTqi+02K4aY4bZFkUMKcahCoToVzm259T8n+R0UvKWFxWiWgVnpaQ2omnjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768761579; c=relaxed/simple;
	bh=4lZpR8FG8w/chOL3V/R5ZNGJ23dMmKUtrEGWwqpJ9iU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k4i9NSsQ1J26dIbmDxBTkD/B8TNzcV7LFIoI7MgRHSRPGvidfZ1ajr59lWBu+DTqOE5XV/nV9k5KAJ1uGtcDAw9byv/gNrNLir7xlShRJ+qnZ5oVt6gHiQzeGz9OSyjZAVpu4i4emUHwQpgVH0c2wiOXYf8gG3omUsXHL33kuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4yD8TVm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso32160125e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 10:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768761576; x=1769366376; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssETAPjk15Tfi3uSMKlD8z7k1rFd42Egkuq2oU+e61c=;
        b=W4yD8TVmn32U1wFy7KF7r3dunPVVb+xW4MX8jLEGPk3Nmt/jpxBWxDeBYT7Xl8el07
         UiSdefFtUZ+CMvKkXj4cYPKrLZhBIkepAbWdHJx7NlllVWMeXCSUkHx+redRln3Eovo0
         xFdz6EBCCr+/Qi8TlhKBpAc2dKLOy7GDYhWubuy3G6ZDQUnD+GKB5Ezhw1w54N4SSMPd
         IdXcdzv2dLm/SBUom9Y6O/I5tCfA0IQsyzA6CBwyM3xlKgi70mhcaRtTj+ikdxO3PACA
         hzybQSiRnkA5BcUlpUw/b4M2qfyjclvY0eYt7kWTf+BImD3m3EVBUgN+AzB5uYJwArlp
         Y/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768761576; x=1769366376;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ssETAPjk15Tfi3uSMKlD8z7k1rFd42Egkuq2oU+e61c=;
        b=GoU+kbUx9BqZOIghJgQ2Oylj46uVef4k0OIFW7tjTU2SIqF3P6SUJ/xHtUChf5nm7B
         V6J8nbWgNwEombb9GSWcWJ8/DSdR5rVbUQoXZKuJGlYdW99Ag7Hb9Dzw6W5BvKW72fqx
         zb8feuSGAaa+Ht9DAJpw66DWdqki+Ecfe6uAe+YADvNTg71oGl1jfMirZn37OA38O744
         aLwZPGOkLBv//NOTEx6mFHYhBWPbKEQ8s4c0Hd1CrBGmdutgE6ApNrPmGlNWnrE4KnlA
         N5ht6vSYGlhy/LcgB98XHJXSw1noGfF1awrff2O2O15bLRQnACJkS1s+c3RvnHL/PfIj
         LUUA==
X-Forwarded-Encrypted: i=1; AJvYcCUKXthI3DPsXzSgQjwSydXtV3wPGstHOTLb52xhmNQN4fjFBjcZBoANsm+uLTjoQrrnXL2PBm70yhFh9wis@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rB+RZgE0O/Vw0Ri5N3LMF2P9PeR5qFluMju4iXPeAvjxlluv
	UbJxckgG7oI28H0NGPbQmFYM+oNCrk8i6WcipCZ9YBdKSjf5eawwGEFMC4tnSQ==
X-Gm-Gg: AY/fxX4q6InBpllkWb0+98FuZe69igU+M+3YD/2A1EyY60PIfckqyGM/AQ5UHXn3FiK
	l/wG8TGSkNtw5RVhrCw9IPdg8MGG0jZWHsOWJ6XgdEMacHZwczaHLG13/nUjeR+oZqT0OFBPyti
	N7QO0OgGv3iqIcjuRiucC3/QkZRL8KkAg9OltPzQxmyy/IOpgFODAROFCeDoGLIspeJ9hn/a8vr
	/EI88xd448ml1+/VQA2zotIrgj6LRykXt/XwMusJhko0taAixbxdki6VZk/WOlxfyAU9ql3Jv3B
	oPhhsAR/5/j1VPFOZh2cl2IwkT9kG6TcCLSM7fihDtUmHmVvzSd5cC17AtgmfPYkjhHOhFMPjcM
	VliF9PYAtc7W0XoIyqalFxizC+/D7LoGLPvWE2C9k6Lw53XPw7y7yiWcTp7YixRWQDa+UglUQA8
	2vHcfa8tokXfFzoogUk2qVZ8b4Ioo=
X-Received: by 2002:a05:600c:474a:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-4801eb14b36mr110897765e9.35.1768761575423;
        Sun, 18 Jan 2026 10:39:35 -0800 (PST)
Received: from practice.local ([147.235.193.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4802dc90068sm74167365e9.7.2026.01.18.10.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:39:35 -0800 (PST)
From: Jay Benjamin Winston <jaybenjaminwinston@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: corbet@lwn.net,  brauner@kernel.org,  linux-doc@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: escape errant underscore in porting.rst
In-Reply-To: <20260118173518.GC3634291@ZenIV> (Al Viro's message of "Sun, 18
	Jan 2026 17:35:18 +0000")
References: <20260118131612.21948-1-jaybenjaminwinston@gmail.com>
	<20260118173518.GC3634291@ZenIV>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 18 Jan 2026 20:40:50 +0200
Message-ID: <873442bw7h.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sun, Jan 18, 2026 at 03:16:12PM +0200, Jay Winston wrote:
>> filename_...() seems to be literal text whereas Sphinx thinks filename_ is
>> a link. Wrap all with double backticks to quiet Sphinx warning and wrap
>> do_{...}() as well for consistency.
>> 
>> Signed-off-by: Jay Winston <jaybenjaminwinston@gmail.com>
>> ---
>>  Documentation/filesystems/porting.rst | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/filesystems/porting.rst
>> b/Documentation/filesystems/porting.rst
>> index 8bf09b2ea912..86d722ddd40e 100644
>> --- a/Documentation/filesystems/porting.rst
>> +++ b/Documentation/filesystems/porting.rst
>> @@ -1345,6 +1345,6 @@ implementation should set it to generic_setlease().
>>  
>>  **mandatory**
>>  
>> -do_{mkdir,mknod,link,symlink,renameat2,rmdir,unlink}() are gone;
>> filename_...()
>> -counterparts replace those.  The difference is that the former used to consume
>> -filename references; the latter do not.
>> +``do_{mkdir,mknod,link,symlink,renameat2,rmdir,unlink}()`` are gone;
>> +``filename_...()`` counterparts replace those.  The difference is that the
>> +former used to consume filename references; the latter do not.
>
> FWIW, check the current viro/vfs.git#work.filename; that fragment is now
>
> fs/namei.c primitives that consume filesystem references (do_renameat2(),
> do_linkat(), do_symlinkat(), do_mkdirat(), do_mknodat(), do_unlinkat()
> and do_rmdir()) are gone; they are replaced with non-consuming analogues
> (filename_renameat2(), etc.)
> Callers are adjusted - responsibility for dropping the filenames belongs
> to them now.

Got it, I see that now. Thanks!

