Return-Path: <linux-fsdevel+bounces-41620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C8AA332E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 23:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130A3165B85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 22:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF51207650;
	Wed, 12 Feb 2025 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WgYdRnKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9393204582
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400751; cv=none; b=Bf3AYBH4NpUfBiaJ2DT/OZfA11tux4aYsCan5C/pn1PB4zsm6OX96W27EBjARp/CvVIypSjHp6qfmegB7Fahqa/hiLuzprnhpMoQ9xUp79wlHcP+CIQ73OqJ66ozrxhc1ktAiDBsv4f8dxpPZSpm5q/KH9aZwL0eHQJXWdgEo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400751; c=relaxed/simple;
	bh=SWGL+qKoHjkKydonxxolqze9lweGFt9BYvi6cuMfK9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuxQKVqgkrIllptwt+UcYxaVeM8u34BJ5sYZg/KkNDFq++ZAjYoQCRQOGeBuAxR3GjlwYsbusyIce5bgACjVYKjPrNv3+CEr96IguGGzhGYbLO5rlKekkR6cualTRm6IC3/Po14FQnO3ak89+3N0OS/G36GkhNy+aU6D4cn+/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WgYdRnKK; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85522610e26so6979539f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739400748; x=1740005548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVfXGj8zpj+Qn/84lGpaV8DSwtFOmUf9lyjwLMDCFsU=;
        b=WgYdRnKKU98hxmfTj4NdEzrl/5kKHlov8hk52uJuTVaMAOoPavfhEo2KrcnNOCnG3h
         5M3W7znDzK87K7vkn3+tyk1wDHUU4gua25xJXJsOnfeI65o+sbFJHTc1LMvLyw7a1oj8
         7BsCStvN1QbJ4R8F/qRF1+1m5/lQf2Wa/NqOD+fxmeJvU1nVKj+b3B4UMPLMiLKquRxv
         +TYBaSZFbOg0fv9pTLutBHGot1RA1sLFS59Y29INwYs7aHoqSFaE6jLjRd4rA26k/Uuk
         zqsXjMXQaJXMQQ9tr8pugzsF+0RxHqi2w6I0hY/tf1+HDfPNMfFY9zQgKx9mx7gVOq1K
         W6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400748; x=1740005548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVfXGj8zpj+Qn/84lGpaV8DSwtFOmUf9lyjwLMDCFsU=;
        b=e4dX8gUd/6yvI9K2LDqsxBP2uvRlxEU9Inb7p0jVRJ9g6y8KZyYRx1pG6l3lcwM6s/
         pe9NGidjxbYj8elFUJdLWe1J8oCeANZVQq4c09UggKMuo+pGupcn+OIFe1+tWOam5Ek5
         5ljxTuBm1Jti+akzkqf3MPZYjvVIw7tvSCw31BJLy9mnjQ3W2KQ/HHkLe7kQYlwfQijS
         1v5loJXKi0RcmCSs9dfcNY6b3a+uYvYgUUjklGldWybk67FUXj5y0RFtVMQzE32k1cCA
         nALn09qgdKmen48KzvA5yZ1CiZhOlMVr9rbH03B6yUbU9mjRztgofHJdJPa+fuKP7Yi/
         iMbw==
X-Forwarded-Encrypted: i=1; AJvYcCW+Kt9A5W52x6+mf8ayXaEc4IT3Z7dD6Zf4j34Y7TgGJiGS9uBoNEi/5NQ+npUsenYhVVxHHFkO6CMpzQ0m@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8+vG082z+bhLR9OOCCwg2xIIYpg6Fg5moebcXcufmyrmijK+
	VJdpnGPYWTM+mv6O8mhA5nlfDXKrqcGO3W1NaRtTb/79c1bgv+MgxGmBHXWJHeE=
X-Gm-Gg: ASbGncvbyTwB/yWybhBpImJnnr5CSLB+f1UmPE3yby8ErGaKhbsqHYJ0zj2sv6oPRdJ
	tJ1qMoXpymHzHTR+1ltrdKkazPE0csfaC9Ic/vnlamCjzDWhInQ8BEsiU2h/YKbMZLhOKXXrkJq
	RcvbsPoX17CvRmxPdpL726xMuRRKyAXkmaP14gRCogK2r3s8QteUDWmndsSMhcV+Q0//hZ0JOF9
	Ae3v8pSda9yrF1nuWb2NTqmhmydw8v4pt0fZKAFssAHCphV4Zff7QluJorpf5pR84uhzbxgY3DI
	0hcpYOZIfmWx
X-Google-Smtp-Source: AGHT+IEVucKe+Bwn3kpsif8ddoHmG/lUq2XHVyUfI1HDjERU36c7zfxTH6zQqWZ1cuUoUSWMIsoTnQ==
X-Received: by 2002:a05:6e02:480a:b0:3d1:8a22:766a with SMTP id e9e14a558f8ab-3d18a2277f4mr14144385ab.22.1739400747944;
        Wed, 12 Feb 2025 14:52:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed282dd102sm22456173.118.2025.02.12.14.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 14:52:27 -0800 (PST)
Message-ID: <da1428dc-e117-45fe-82a3-26d56b414652@kernel.dk>
Date: Wed, 12 Feb 2025 15:52:25 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: use napi_id_valid helper
To: Stefano Jordhani <sjordhani@gmail.com>, netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Mina Almasry
 <almasrymina@google.com>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:IO_URING" <io-uring@vger.kernel.org>,
 "open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>
References: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 2:15 PM, Stefano Jordhani wrote:
> In commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present"),
> napi_id_valid function was added. Use the helper to refactor open-coded
> checks in the source.

For the io_uring side:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

