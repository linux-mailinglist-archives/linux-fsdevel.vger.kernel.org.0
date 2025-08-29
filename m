Return-Path: <linux-fsdevel+bounces-59644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5EB3B99C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 13:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38FB7A642C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CA131280B;
	Fri, 29 Aug 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fo8KVRxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77033081DA
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465441; cv=none; b=kiKd9vzcVMqFvKd5WreAVW5fmYSL/sy6T+P7DmxCUp9vy3tbK/f5LHipTr1Yc8NRW/5JSqQQm+Qd24yM/IC66PG6FJbV+ZSlk9POVWiFo+S/YwzIrK3VUN0RgndcsOoCK89RIGbMSWYsSMVBPReTuSk/Y+jXJZmQJiiUVnRoio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465441; c=relaxed/simple;
	bh=YuYDNgvmByukeEjHw0NdzkrN0QNksChG2e5fXtNTVOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFn5DkGkFL3NIcfImasCGr8QVmUYM7Qo/OPhCI/nE3FxS/iRqgL3vP+umlmNy+RC3LCOuP59xdCh3BNUCUKgSkn/f0SheVcIX/6c8ikonZsdjKmex6F+LUYkgmJND+NS4vlOhBFngoIrDCAaB+NpW9EWO3C1NmIk+7/I5mAhk+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Fo8KVRxS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-248c7f955a2so17896415ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756465438; x=1757070238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIaSrq6Dx+kKyeLRsgFivteR1euTnImW9J7nYHhbSJY=;
        b=Fo8KVRxScIwX+4IqOcKVSQHK1GhgE8u2mNSZg4G9BHU7ACOZqWvF8NBWtYa15l4mW5
         GH17rSSfyQ4f5ng1MU8iTh8sFBPWNC5errVy18VTnFoL7V283SRbuHEizeSji9nXXu5N
         mF45k8F4KgGYl5AaBugVTZv0C+/X9WkUCy8NR1aiDEGDAUZr8iEo5++XWT7dQoBKOGtq
         fjVKeKI9Z0SV3NmtU6bsDC0yal2pv3n71guX7emGh11zbIJCHM6RkPcIpBzQ226OHCiy
         lDs/SDCxlDviy3P892hOlrolmZg7J/lCmDWdZDEDgD//CEIJsOwlMqLyUDdvB4saV2Jh
         imfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756465438; x=1757070238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIaSrq6Dx+kKyeLRsgFivteR1euTnImW9J7nYHhbSJY=;
        b=XxmnhweB8tf75FtFZnk3NrC6ZYv4WyldiDLKOG8Qpw+rlMFw/ioUB0My447wNjtiz1
         I8kuYfuBkfsArDuTgXBNA6vVizgOmWlgMkYOeQalSS1u6fs2SmnOZeqdumyHVGyD6HLZ
         iptbyP2YKl9xLV5XpQ4dc2BeFC/DPi5tnvVHVMJ78YAKjKymF5UDWmVYMkkX+/TlzQ3w
         ElZHo57dMhJq4tqguCXJm6nr/CYweDNJW9bba3mVfMV2z/QoLsEsDM+8uVbnDqefDqsZ
         qv//Lio9FYzA08kzLtyzL+A9ahhnwI49rXUjHlm2zcWk9AvRoOx6t4BwAl2gF+8KH+x5
         2/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0fzgp6/FvN2kw2VbxXVRQwJy/3r73H1t6iAVneupA9GmfASR8lJFmVLszRoiwOcm1vqH0J1CscDymKex@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8pwvGio/Mnls1ILiix6e7Yhp69pACaBDQdzOjMXdW3AAffr9
	f+mtvzeMxyytrkoQ+8Pe69D/zwDpA+Xm67f0cCoBzyHyKi0KOmUdUKn51XmcZ1mR828=
X-Gm-Gg: ASbGncsWT9u1FwNhppLXUZ8kD+3XipBabEEmUZQBKGPD45Fj/HwckW2DqZkHIKW65mK
	VEcy+Zy0iUrjSS2Ltjj1Md4MFCtdYtlUvAbjPos38RTYgGeWSSuo9DaJ/fc35FlVGlEmv0c8v8r
	eUQRyN+dqQSDjsD5wKmrxGnQgSmKG3ZFF5RuWc3Kn0ybii57Uom8luY9efmxNosYnyeNgcVwkfP
	K57w1i5ri+rnvdLKg99W1DxgnN07Dk9jxjW9VjxSYYfkV28kAknJYclnyWxkWPZZfLDvCIRZyv/
	RcZ1yE41j+klgkwdgOWeEz9z38cfg0KXtsJsyAmpc/cqnUTPJU5tldJ6EIAJn0n7FG/gqlnhbFm
	EBKUD8aD0Yz6Gv6lnvDB7
X-Google-Smtp-Source: AGHT+IEzZ/p9as3nrF9ljeFhdkvVqD0Z2ro3p43Bl/n630t9nzydCZuiImxupdC2b+91pZmC3AWS0g==
X-Received: by 2002:a17:903:38cf:b0:248:aa0d:bb25 with SMTP id d9443c01a7336-248aa0dc43amr125044695ad.14.1756465437860;
        Fri, 29 Aug 2025 04:03:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f5925adsm7949756a91.10.2025.08.29.04.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 04:03:57 -0700 (PDT)
Message-ID: <6c85f96a-f012-48e9-a2fa-f1c7650d8533@kernel.dk>
Date: Fri, 29 Aug 2025 05:03:55 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add RWF_NOSIGNAL flag for pwritev2
To: Lauri Vasama <git@vasama.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Simon Horman <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250827133901.1820771-1-git@vasama.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250827133901.1820771-1-git@vasama.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 7:39 AM, Lauri Vasama wrote:
> For a user mode library to avoid generating SIGPIPE signals (e.g.
> because this behaviour is not portable across operating systems) is
> cumbersome. It is generally bad form to change the process-wide signal
> mask in a library, so a local solution is needed instead.
> 
> For I/O performed directly using system calls (synchronous or readiness
> based asynchronous) this currently involves applying a thread-specific
> signal mask before the operation and reverting it afterwards. This can be
> avoided when it is known that the file descriptor refers to neither a
> pipe nor a socket, but a conservative implementation must always apply
> the mask. This incurs the cost of two additional system calls. In the
> case of sockets, the existing MSG_NOSIGNAL flag can be used with send.
> 
> For asynchronous I/O performed using io_uring, currently the only option
> (apart from MSG_NOSIGNAL for sockets), is to mask SIGPIPE entirely in the
> call to io_uring_enter. Thankfully io_uring_enter takes a signal mask, so
> only a single syscall is needed. However, copying the signal mask on
> every call incurs a non-zero performance penalty. Furthermore, this mask
> applies to all completions, meaning that if the non-signaling behaviour
> is desired only for some subset of operations, the desired signals must
> be raised manually from user-mode depending on the completed operation.
> 
> Add RWF_NOSIGNAL flag for pwritev2. This flag prevents the SIGPIPE signal
> from being raised when writing on disconnected pipes or sockets. The flag
> is handled directly by the pipe filesystem and converted to the existing
> MSG_NOSIGNAL flag for sockets.

LGTM, only curiosity is why this hasn't been added before.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

