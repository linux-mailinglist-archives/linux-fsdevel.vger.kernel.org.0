Return-Path: <linux-fsdevel+bounces-66929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F9C30C2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D36E14E5377
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440D2EA17D;
	Tue,  4 Nov 2025 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhbQY4KH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F962E88B6
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256184; cv=none; b=O6m4JpiJYudmVnv5YD6H6303MO1NH5wAz5ECVPHtyJGf4TjLmvNJGIcltcQQNQ8ZLAMiQRL/Z2FrbYp99/A2xzO9XxJ9YcEx+Uqem6zY8Lj5hDPrD7Gk++LzJuaoIzhYqkOubNX4AlAq5skC7IPcakEGXJYKnj9W7yLq2PnSNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256184; c=relaxed/simple;
	bh=4Wn7QoWN8xCjPbayQz8lhEGh7Deb0qobPKG4uApIIcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mo3FDPCuKvMaGrzUSzcE/91HbTKI5qh5/h5XuDVDElTIYXDOlBpe7b7Kw7rT/UBmAY/KV4wSlBo7Ch1K92hnbdpfMT3jJUnjoLwEn/rkc3rj2XFhzG8Qbsji5GXNCUMN7jhgmjn99v7q3CpXx4NDfdnA5XvvFDCN+Bv/InFjWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhbQY4KH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34188ba5801so306189a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 03:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762256182; x=1762860982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J90ejmNRDc/sJDDkigtmzgp7USpf0W7zUJJf8FzaScs=;
        b=XhbQY4KHrdoXsiTDoo1psvWT9ZSFeWVbB5xRe+5H+LV2bxXwLsW8utoG6FhN3O7pLS
         MyTifCLpcAzB2gdLFUOHbsmJdmA1iNd7y13djpmgOkb56IEJKWyJ8p9oukP3iKEc916s
         pI5Wy49vXr1h40zQQ8yPTcnjJSwLLHYpPENUy0WW4kyk1yZByFshEtau2Sqn7YjckQ+B
         409xSBuciVKOw1gE+zmOkxaBtr5NdTa4ozcH7bwdMbBbryv5CYF6vQiec4bdFlu5p5wm
         LDlKiTcJAv09hb3OqZ8UwRzV7F8psluJz/bxkp1m8GdGmAlsOtYQwqX/Dk/tAfaEp0Na
         XqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762256182; x=1762860982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J90ejmNRDc/sJDDkigtmzgp7USpf0W7zUJJf8FzaScs=;
        b=eQHqT4fUAmB6VKTEwzkL/hJlU9BB9EegNVO9gfIQNpoW5LquTxsP/NPWMS9h45uqK6
         Oh/k0Q7afy4AGUZQf1yFgFvyqM408yuOlV+BEqDQRBCxrikPRDFmwN0gF/f0DBmV6aFO
         heyBwWDrqZpdJj9NKwUSnPaNXN2rary6MKjgzNPtVcTO3tBDMNeF7iSQ58RKkYdNMVYQ
         jlMEth6qK3Wt0x/qU6ohnNxWvOTwCj62DLWeQoqONGHYRTtf9zFibKcx+mAc8rMLmYdz
         05+JTwVsDjVzZ7XlfC+RL56lV510Y+1d2NpP4Vgk85VltWsCQarh6HAegetRz7xmpwnl
         YEHg==
X-Forwarded-Encrypted: i=1; AJvYcCVhQuuICiUHtvxSbzb+RO3gptsd3wN/FiPJM0Ptb7QKGf3LspsqzX9neBWSuabR2MinvWRi4lOdMcRwGOAC@vger.kernel.org
X-Gm-Message-State: AOJu0YzkelVSbP/a7OJBfUd8lZSHv7gpG7wSjJFP9EHxTfLl9JtHfS0m
	K73E2xbjwvhdhu3L4SmQ+W1rvpzPz9P9WjuXRhI44vY5nAtBWrJBpOMP
X-Gm-Gg: ASbGncuE1nxFBvuSPVGX33L81oMGMroSp+sWE0AxOvIMStGwrAWvYZJWWj9YIjtiy6y
	oEyk5PZ3eX0NhbHLDZaaqA7GN1haNRqtEOTvoa59WewM6GZTGOUhdSWo9mF4mRyRTcqhUJpWc9Y
	cDYO7u4nCquMn4gOQKVYS9gsbEeXN2QG/tWaNiRA0LAhnQZ/RoYhj5kKAHym0hTXnix6jntyYqd
	eGG9mbzJPU0BjqpF41S0qw6sy8Vy+udq93m70BrATJf/ysWsJtV6f2zosTLSkjDl5vuHdIeQqTa
	yFAO4Xw+ZEnYjEGhxayjXPel36XactaqzP2MVI+IvjauflbKiOpZF9xxIYXdaHX2e2GfgI5rHqx
	/eNS4UPGKIbMAwKWkgfe8KFnblfS/4C7nIVnSH+IUkqfsk6VFYL/MvghiqcPAFpaAOfNojjyULV
	QLnp/R/5hmtGuOf2TZ79c=
X-Google-Smtp-Source: AGHT+IF5OrzuKARwkp1GVv+qC6PxEHYGj29XXgnA/RkKZqGw4wpxfHkO7e6iSIhsRiQeNJQp1sxCHw==
X-Received: by 2002:a17:90b:17ca:b0:340:d569:d295 with SMTP id 98e67ed59e1d1-340d569d470mr13962469a91.24.1762256182197;
        Tue, 04 Nov 2025 03:36:22 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c4aa89asm4228751a91.11.2025.11.04.03.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:36:21 -0800 (PST)
Message-ID: <1abbf495-58b0-4f04-8494-6339640253f1@gmail.com>
Date: Tue, 4 Nov 2025 19:36:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] vfat: fix missing sb_min_blocksize() return value
 checks
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Jan Kara <jack@suse.cz>,
 Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <871pmfoy1m.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <871pmfoy1m.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 00:56, OGAWA Hirofumi wrote:
> Yongpeng Yang <yangyongpeng.storage@gmail.com> writes:
> 
>> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
>> for sb_set_blocksize()")
> 
> Looks like inserted a strange '\n'? Otherwise looks good.

Thanks for the review. Sorry for the mistake. I copied the commit 
message from my text editor, and it got automatically line-wrapped.

Yongpeng,

