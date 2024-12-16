Return-Path: <linux-fsdevel+bounces-37480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861409F2DF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 11:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD5B1652A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 10:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84951202F97;
	Mon, 16 Dec 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArWhBjJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D72AF03;
	Mon, 16 Dec 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344026; cv=none; b=KFvlKgOqE8enXyO8gpud4AJUQ9/uo7ht0xhWxQiBuTo0W/pq+RDPBazW8s7Grx4ihG5xsZv0/aUhlTb01wt5492el1JvIn8iiNiG2KuRyGi8D0l8Nmeq4iPihkL6a09dXvfcjCEFJyGtbjdddD2TGNNXJO0tDqwnAObg01WyfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344026; c=relaxed/simple;
	bh=6o4jofo5o0s4egvVbxhwmAn4YH9WdHGRsBXLWeO+DtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llWH7MRcpQy8dGn/jx8skZVadlDxoccd0lbpK7Y9ONTF97m5uy+cnN8V1Q5NUic78onqaRGtWZpJU+8uPwHSvo7bVxyg/xVU/ONFx3ST9VI8mpnN60w4AUgdKlbKlRbz6QEXsezNbuLCg2CyZkC3/dtVHoST2FM4Maa27ZfTI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArWhBjJl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728f1525565so4530416b3a.1;
        Mon, 16 Dec 2024 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344025; x=1734948825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9ZM1VYLJhmWw0JXWXrNZw/asAR3qnp4u24wAg0Zo6s=;
        b=ArWhBjJl3hPPOaKkIaY/r+yGPfLKSnkKdtF1TEpdvVhnWMOKURtfK/Wn5Ix/UNNpzX
         pZrrqBnJVHlbkENmVJLNlVaP0hTHxqSN8zJtu3np8YV3WQzU4ZnbFqSRJzhDjS+Yv+lh
         VZ+4KObdpdXeZOzP7J6NH3YfE4mb2gcewtTPjW0H/rFt7vFyAkkxqvA4RM2KWejpQv5x
         6C9dvGXjsA4SCWDSU4qzdHbdptEKkGlTwCjtDds/pUGtc3zBBUKhfTHLoEVXAT8LG+64
         3l1SCjyQChpZQ6AdjHNDjhLv+2L1bxmEamsQkDFoqb5Luj7Asd0eVlTi18xkAj0ava2e
         s6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344025; x=1734948825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9ZM1VYLJhmWw0JXWXrNZw/asAR3qnp4u24wAg0Zo6s=;
        b=BvT4pudPVPlb4iKaFCjVriJQTM2XQ1ovXhOWJJX9/XHZJLxM06tuvpcO53bImru50u
         eCvT4kl2Vxc88xpU8zz6iCJEs/jJ35KLYnZX4JPex7oJ9Xomf7DV7UlJ1D97Oyy/ZGqJ
         Rvw2LoZd+wf4aL+E3FBre6FRsndV44I9sGXMrnrPCZNuWNBT8r9f97h2CR9eSmG/3xx0
         wF3n2iXF7VMS9U00uHiJ/FXBBXDISvwlPGYBWkrNprxLDwISbqsOzBEuwmjDsds7evRa
         fovmE5gTJQioUfG7e4zELpVJBPn6fu0bPJmrlcDsFfTxlcTY1NeRO6ZTYAR93lG257QE
         3ghw==
X-Forwarded-Encrypted: i=1; AJvYcCUY8Pq35Ai8nboc5CMbQH0A9pYJBAiivv4BxokddKHnyu0ug4lvLY6bO2pJ9x7qC1iytiP1Vme733W8@vger.kernel.org, AJvYcCUgj+VAC9wZScEale4DvdNt6oaQkScbLqvU4dedr0S2X5GbGTg90AxvRBhi+bezyUJDTFJe6sYanOwG@vger.kernel.org, AJvYcCVFeBzHM9UQ22kV5ed0chN0KT+kFeFLr1umx5PCZWCynHEIE1ONeM2uAtRj803fgHYWvpH/6VBSSa24YeBM@vger.kernel.org, AJvYcCWDTIkjNr30p6AOumCmZ5VBQ8PY8TmJ4PwqmZR/c2nWTq8W9dgFXplTD2uaBQ4+Alk+Xj0a8Mbh709IN7nRCw==@vger.kernel.org, AJvYcCXFJ/hXevDkYzQJ1eERqLePiy2/yzSfCcywqxTxPgxv5+L7NwLTguvIDsJM0gt8uyAqfkCc+Q2lcMazrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTe67VOy4vncRMgAkQ0GdDriMtRUv8BENPHvOjbXrwBVJxkU46
	LSKkU9A+GbvtJf/9Eqrzilwlq3uynuXBk4nJCFbDKlKz3TrAfsJC
X-Gm-Gg: ASbGncus2+wAW8zO/M4IDWlchL4Qx8c/EiHaaynjcEUCZWuSykEdl6rQWcHcD9tqNoj
	XLiBaZUepirhuO+nFFomVyqJrHFdE+mh4SkrhMXgXzD4GAk/o6HfqWmU5Rqx8VcVN5iqlq99muG
	uhzK0hN/75NHl2Qgj6t34NkrblyL3tGs8ad63hFuu7mX0N0WkmJ9bvpIteW5oedQsnzsGQufQp5
	PUlDj6tLqSA0m3K+EootKncgwXHVIl23OhLDxjy4lNj5zYVX1XUmchop8N+mOYgIGTzUDUcW/kB
	SlYE+eMwkiwL5gTiQkpgAt0=
X-Google-Smtp-Source: AGHT+IFq3zJyvoXfAV7XVBdCiDQC4vaO/7xLrUwixiOvu21RBmLw5wfgxXzoYw8zU6Yia4k+KM7puQ==
X-Received: by 2002:a05:6a20:4304:b0:1e1:bdae:e045 with SMTP id adf61e73a8af0-1e1dfd91980mr18130458637.23.1734344023005;
        Mon, 16 Dec 2024 02:13:43 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bce39csm4517791b3a.189.2024.12.16.02.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:13:42 -0800 (PST)
Message-ID: <843f5270-d715-4c98-b191-1c271eb418c5@gmail.com>
Date: Mon, 16 Dec 2024 19:13:39 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] netfs: Remove redundant use of smp_rmb()
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
 <20241213135013.2964079-7-dhowells@redhat.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20241213135013.2964079-7-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

David Howells wrote:
> From: Zilin Guan <zilin@seu.edu.cn>
> 
> The function netfs_unbuffered_write_iter_locked() in
> fs/netfs/direct_write.c contains an unnecessary smp_rmb() call after
> wait_on_bit(). Since wait_on_bit() already incorporates a memory barrier
> that ensures the flag update is visible before the function returns, the
> smp_rmb() provides no additional benefit and incurs unnecessary overhead.
> 
> This patch removes the redundant barrier to simplify and optimize the code.
> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Akira Yokosawa <akiyks@gmail.com>

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/20241207021952.2978530-1-zilin@seu.edu.cn/
> ---
>  fs/netfs/direct_write.c | 1 -
>  1 file changed, 1 deletion(-)
> 


