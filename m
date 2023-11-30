Return-Path: <linux-fsdevel+bounces-4413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7757FF25B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE328B20B99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD985100B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vS4LbRqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0761283
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:23:49 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d380a75a8so93425ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701354228; x=1701959028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lS0Bb664e7dDhqEK4tmnmL3WT5B1tiGpNiflIpYRIH0=;
        b=vS4LbRqbB4QkUCAvFNi1xWeopq+3tXKpLoNNUD/TKj0y7Tf4DEfI0j5PD1KJCuG7yI
         AbC20q8Ld4nCQfk6QcTbPIFHioX5QlriFroi5EvY95b/lg9k5GCugJSlvkUTRrN+38Se
         Ty0I9xAVrJypMnaooRPw1RYwFRzVBA30w8+hHUf8gfNb+c4ZUlEKSgolL1wmQWGyfrIr
         yw6OHdJbkwPYuA+LNyksU/N/wsPipKW4Zp0+n9PGoB9z8SGnhnzHXU9RO6o7jrStBYph
         R0wrZWeFZmd55B7uAW81IrNlyjxRxV6Z7QakMAXoF+/FY2ZPohrd3sopOKDGKhyV8etT
         hghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701354228; x=1701959028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lS0Bb664e7dDhqEK4tmnmL3WT5B1tiGpNiflIpYRIH0=;
        b=kFdfHE4lcZOlwzim8qKKsmrfL3cAF7odhsx1/Bjz+pJuAsbS6V/U/Ge1//By5siw30
         etgdOW8juxjSivbeEiKMaV658UJquDj0WLHpyhAKhoF3AiTQz0BJf7CEsDQaVYbAMvQR
         P85t0y2UWfrvlKOO0IjfhqiHY+45M2pPT/gGT5n20f5e2HMPoIA67Of+RiH1hc1yVKcU
         qmv2T+mtcGYXmSiKLFfr7288YulS3j0KE81kMj3UkN3b/Vn6HCIkQqNe5vb+b9GzOuc5
         +E6rNc0OSEAqtjIT8mKUyCGgCh/ZM92ScgFktOFkFZpJe3TZUVefQuZlVRnOAsPTxuD3
         YnRw==
X-Gm-Message-State: AOJu0YwQhXKZMjW8KDUnyyC3xmPlmrQJuDQvzZfrbKh/wk4c6BxU8MEB
	hVdoxHtzepGT5eCo6AGGx1Fumg==
X-Google-Smtp-Source: AGHT+IHq6NfdNGFhQH8bopaFcHEgx/sBmpoBoWekvn3o2jk7A4MxcMan5/onknXISzljLwsZOYjsiA==
X-Received: by 2002:a05:6602:2bd5:b0:792:6068:dcc8 with SMTP id s21-20020a0566022bd500b007926068dcc8mr2173115iov.2.1701354228365;
        Thu, 30 Nov 2023 06:23:48 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n26-20020a02cc1a000000b00463fb834b8csm308647jap.151.2023.11.30.06.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 06:23:47 -0800 (PST)
Message-ID: <c8ee9ca8-cd2b-445f-bda9-21529abe1c11@kernel.dk>
Date: Thu, 30 Nov 2023 07:23:47 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] file: minor fixes
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Carlos Llamas <cmllamas@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/23 5:49 AM, Christian Brauner wrote:
> * reduce number of helpers
> * rename close_fd_get_file() helprs to reflect the fact that they don't
>   take a refcount
> * rename rcu_head struct back to callback_head now that we only use it
>   for task work and not rcu anymore

Series looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



