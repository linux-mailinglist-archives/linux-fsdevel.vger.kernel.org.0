Return-Path: <linux-fsdevel+bounces-43457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9286A56D6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 17:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA73D3B5869
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6723817D;
	Fri,  7 Mar 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YCg3Uw0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8825238173
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364317; cv=none; b=JF6TiZInObyJpI6C7SCthpmoA3EHZ7if8oc4LfxSG1q5vWGBs0hEbxIACIoRWVcTGu/Zz8zjduqYxq6S2AO88KMbF5v4f6FCir2a/VErlLUfs0vlkAvP3H+cN4TW8LMm2CjGM23GkPcgAReUIHdknl+lFnfZ4PzOpfDGwam3XVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364317; c=relaxed/simple;
	bh=Q7P4hSefpkC1UbSfbt+doLOOOpwGC3N9h0F6ojYSWWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThwWwFQVPn3xmehOqcqrPW7770KtvlHg9DEnhW34cHSApeCFokeMkQAnm/tUTzj3cIJUL2pJ77AZeQQfethrU9zPz3LLjJZpyINBjC2tJH/Tp10yLMHNIf2BFy9PLhrffnARVTeqcRanmRO+0z4YwRsa0YuKPKx2CL3jDyhv7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YCg3Uw0r; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d43bb5727fso5991645ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741364314; x=1741969114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=In9PPY40Mgr5yyZmxf6kZQr/QlJ7nuj8M0fwjZ4i/fs=;
        b=YCg3Uw0rWDiMXhs+4gxJ3CqU7x3VRb7hkgp2qae0pBtq+uEomJJNb/jkA270xjZ+aj
         5iMtwRJrkV6j3UwwVZA+xLSQ0UL2LcKyCA/Mg1QXXaLf96jTtj8EJI6Hoz+X33vcSuh8
         3C30N694aKe5AuQ1KeNdfW2Swuo/565rcvfuL6yg+wm8Ey3hbbUYxcazmXpMepsAYgsO
         wSKR3UNgCbKNKFMaeD33MS4pFwOCaYnbEqyabsG3tnWAllX7M97zaRH8FllLahhIyp9O
         VeBEHU+f4X4XumMkPD9CDn4R0EEhPop0Wv0S4B/docHIUOW6vPFevSmthMmU9GXaQ/Yf
         U8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364314; x=1741969114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=In9PPY40Mgr5yyZmxf6kZQr/QlJ7nuj8M0fwjZ4i/fs=;
        b=bV82AVjc2dVf/KLDlh7NSTzw+QdXh3MFG6KlLgvYWpcFJuT2dAtMWcV85BpLqDF3Uj
         r99PE9k8GDcAY1Hg7dmpjTsSLZ9RU5OMGHXio/k7uR6kwW7G9C3a6CFq0dbFbHcaH5tT
         RHQHwvoy3S56WgEo2kOKsrNuZBfRKZESogFv4SFY0j/MwWH76BYz6D10eX5T2Tqwgf2V
         9Bbw9di9Eip2am78O5zwhhNmTqMue6D4uN74Od+bB2yzaiDZjIajnainn1fGh1zyG7F9
         BmKjPx2ikIMHcpk56cbSfkghujv/XAESzXY/tlkIOCD5g5H6VAPfCSQ8XiGgacRX4/38
         erNg==
X-Forwarded-Encrypted: i=1; AJvYcCVzc5u5Gm7+5CLmgYLDS7CQuqsFsNhoaguMDp85NRK75/1QzWPB3zQSn85QHdr9ZVZ/kfB9ZJjdpCtl/t2H@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0XO+lAcYTf01QKwGXmX5sgP3gpWO8Qgw+f7Wyk7HuK/fWfqk
	A4PIK1QFVL5fxOo/qyDWcIrTHNHbTqrHjSNcXL3wssOKZBO4q2rg2h4NuHcmUvk=
X-Gm-Gg: ASbGnctOevI8YiqvbwpgHflRI2Bu533M7q/C/ejC8ys0sDHJ1op/823P507zn7loXdc
	5vQIf61JhUTYHruobqL+9rPFv2ALkzvCBGcCuvGbDylpGt9jATFGeCeSB+kdA6uEv+V2f8PVsy4
	kCexspODyu5Cu3Phw/VMQXZCPOBKbMvcT2sm2qeSwJNWd4aOMb1Uk/+LCKiqJJK/ZvioniNvGxZ
	tyKxL081HbRpRDsi2yVh1Ds7zOXj8fIXAs129Kd9xkPkjvicmb0I3CO/d2eGz8E84wKekPl3DPr
	AQ14RLpIYOZJ+N3ec939N3/7fswAxVnGbpsLKsKR
X-Google-Smtp-Source: AGHT+IEZIL6kjCDQac+J10FL30HMzY4rLD57DIbTTax5qwBe0pYmXJaCKIsBu5zSRoGSQEaVsikMCQ==
X-Received: by 2002:a05:6e02:1a05:b0:3d4:3ab3:daf5 with SMTP id e9e14a558f8ab-3d4418dcc7amr47772725ab.6.1741364313935;
        Fri, 07 Mar 2025 08:18:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06b059sm1005242173.136.2025.03.07.08.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:18:33 -0800 (PST)
Message-ID: <fa3bbf2c-8079-4bdf-b106-a0641069080b@kernel.dk>
Date: Fri, 7 Mar 2025 09:18:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: support filename refcount without atomics
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 audit@vger.kernel.org
References: <20250307161155.760949-1-mjguzik@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250307161155.760949-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> +static inline void makeatomicname(struct filename *name)
> +{
> +	VFS_BUG_ON(IS_ERR_OR_NULL(name));
> +	/*
> +	 * The name can legitimately already be atomic if it was cached by audit.
> +	 * If switching the refcount to atomic, we need not to know we are the
> +	 * only non-atomic user.
> +	 */
> +	VFS_BUG_ON(name->owner != current && !name->is_atomic);
> +	/*
> +	 * Don't bother branching, this is a store to an already dirtied cacheline.
> +	 */
> +	name->is_atomic = true;
> +}

Should this not depend on audit being enabled? io_uring without audit is
fine.

-- 
Jens Axboe

