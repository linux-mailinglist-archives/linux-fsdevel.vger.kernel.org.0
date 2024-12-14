Return-Path: <linux-fsdevel+bounces-37419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4F9F1E06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 11:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8813B188BCAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75A188CDB;
	Sat, 14 Dec 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJIa7Kh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB318AFC;
	Sat, 14 Dec 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734171385; cv=none; b=dIzGtbjhmCl9f6v1V0tsGL0/xGDsrdJFlgu5GS+MXtxMKc2EoukAG+4WrWAjI0iRyxu2NJhePfDv1oLzcMdjj1laJGaNbDbLtla0ec4rSsqoZDEY0DUoVlu32G1cPHTaYr6zRl6E5bRm/cfQZfakEXqwNxqT3UEBsZ3mGlxBK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734171385; c=relaxed/simple;
	bh=ppurqkLg5frVMfdj9t/MeoIOWop6fX3bDcl+dcNOFPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1ontV1GmSnfzkDmIwtjOt9bFznJV5BMj+Us9lc43QqIXSNxUFh/6ahptv89SOAfVo3zSHwYcOXkrRAQiMbw7+F/xlZdY1ino9zD/0pPydD9lilzuOJDhPOXWr23k1DKTp9l8lmbeWoYKsrkroBBqwPslXsjyOxGoeXvNI9YU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJIa7Kh9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb95317so23944505ad.1;
        Sat, 14 Dec 2024 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734171382; x=1734776182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WC99pq7hRHFrLDw7siiOrZ7FqbwdIbl7gLGxK8elhYI=;
        b=QJIa7Kh9MBaLvnHMx/XRt8EACl30f+H5iFPY7fZ/0cj17QAzO1c2hitEw9OT6SKmwu
         aIYBZDZ0YeIMKdgz/GmEqUdEuYyg0P3jEviRPtdGfje6mptXXKb5/eOWMD48g3pTyuBp
         yEB7PPNZQRyYqcbqrBRQej1kkKipquMiyAHc6NTq8s55f8FU8O/ynNrqiC4YGggGUyMz
         GM12FCbQCzpg8nLyahMvVUsrTJqDJDR3vwWh9vWAt+oIAMY6qvSj9RwS1Y3rgWNCasYS
         k+ef6xxXg9/qQsbZ0lkf/EoRMPTIiSx3G0NYs3FanYuzZHPqXZpjiBOLoTUO37E+dANc
         Vhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734171382; x=1734776182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC99pq7hRHFrLDw7siiOrZ7FqbwdIbl7gLGxK8elhYI=;
        b=foQVLgN8Ar29yDbyftDFusUieWK4lz1hvguOITG2uCv6bZcJ/s/ruzyL282RqK+mM2
         BloMScrZBNshruf+u0OLnA8b7WjkvsbdmUuXcPxeBt13EjSHzypvbbllxEPbwdGabCv5
         ftcDVyfhQLp2lPvl+WocrX/gUr1gjhSgSVzYZHxPEn5hVrm0S+9H/7jUrNpXQK7ceGRk
         +n1CXgzdDnnUW9TzH4IUmfn+546uAlveQFe2I5Kqz9LXcrg+x56vKd2+vKkPM2fvObfi
         xgnKeUmK+TzqxEhOjp4gYXWufBwFoVtI5TH3feGYi5YtWxQqAllcsjM6EM0sh7+Ka68D
         gYNg==
X-Forwarded-Encrypted: i=1; AJvYcCUZo5aomFYU5zmkPz9dbOkYct26KPgWFSTXRTNe1szqlWjSORij5AiQJcbPk3PowvGp6F8JYIir9T+RL7JX@vger.kernel.org, AJvYcCVOT9i35Fn1NhzVn8eId7b/T8sSvMr9TrAlP3Uxx1sEv2HCtRSB0zE+KxOySWsfIxGGeBkmRS6ZyIV1lw==@vger.kernel.org, AJvYcCWIC12R1zWKRvZCBs8lk5lWC06KgMcha4xEKX3txh2qOiijHu1lq04VBSNGZzmfHuEAX6HJQmsJOTZk@vger.kernel.org, AJvYcCWQ0jxZb/I2qVp37Wxs8EPjIkbf5rjhYhuJEsqPB8HF2ceHHFOIQf1WN5biWPkvAZG3DhrAsnfFC6IUX4S4Tg==@vger.kernel.org, AJvYcCWdiCnQHu8/AHpapBh66us6u6dLApHK5B4C8nlL/ZJdDCU4y5lmuoj4D08J4qvRy1ZKJVbQ0ns2o2BN@vger.kernel.org
X-Gm-Message-State: AOJu0YyVc9oy+K0f0C4gx+iJoYt4mvmG1ac9YXf799HCqFXONzz2GGpn
	EAd3Qpm3s/T/WFS2Wj6f5+adk9TRIFCSFPdraSqkChVYFj8gW6yR
X-Gm-Gg: ASbGncsZRLKQCbyeTL1zF8RSMArSpi9yIq2iztT1UpjSUjbYhSdmGo6tP/h2j/ZKHwJ
	MnkpXQcnHd5b/ISQ8Lz8YwlFJSMYRakkbnj+5wVveAUlOeYNQ7zSwFnhdXXmuv9siHCNJXI1Kkk
	RS4f4fNqOoGN7bxeUkaMYO7esRxTBmKgBBwhWD+y/kul0tMM2pKfB6EkZWXXIjoXfx4iHc7PhDP
	wPClcvSqzW+ioCacWxI5s6htyI+xRHfY+S4ZtUGhb6nTzy3hesD2M4koLtyKIYQorOlqV56j7Kp
	OPLZK+zSih8ZYlSkq4mMVCg=
X-Google-Smtp-Source: AGHT+IEZVE15/vEAohikUk6vjIGzOeFn+yVnxHcYlw+pZKWRHHAPNEYP1GeDSZ8W1ZJPAeFwPcezZw==
X-Received: by 2002:a17:902:f70b:b0:216:28c4:61c6 with SMTP id d9443c01a7336-218929fb17bmr82919535ad.34.1734171382443;
        Sat, 14 Dec 2024 02:16:22 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50455sm10069475ad.159.2024.12.14.02.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 02:16:22 -0800 (PST)
Message-ID: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com>
Date: Sat, 14 Dec 2024 19:16:18 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] netfs: Fix missing barriers by using
 clear_and_wake_up_bit()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Max Kellermann <max.kellermann@ionos.com>,
 Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>, Akira Yokosawa <akiyks@gmail.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
 <20241213135013.2964079-8-dhowells@redhat.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20241213135013.2964079-8-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

David Howells wrote:
> Use clear_and_wake_up_bit() rather than something like:
> 
> 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
> 
> as there needs to be a barrier inserted between which is present in
> clear_and_wake_up_bit().

If I am reading the kernel-doc comment of clear_bit_unlock() [1, 2]:

    This operation is atomic and provides release barrier semantics.

correctly, there already seems to be a barrier which should be
good enough.

[1]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.clear_bit_unlock
[2]: include/asm-generic/bitops/instrumented-lock.h

> 
> Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")

So I'm not sure this fixes anything.

What am I missing?

        Thanks, Akira

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Zilin Guan <zilin@seu.edu.cn>
> cc: Akira Yokosawa <akiyks@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/read_collect.c  | 3 +--
>  fs/netfs/write_collect.c | 9 +++------
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
[...]


