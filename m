Return-Path: <linux-fsdevel+bounces-61944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8950EB7FFBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AA76215B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1692D46B3;
	Wed, 17 Sep 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="USa1h2N6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC082D46B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118699; cv=none; b=QyhFmkV31IN5aCMOjAf3yZxDhhgrKWxVxjguo/snSlUsHmn1WSB4dZG6sL4vDuJbnx8E7/L1IlMSzX2rx8OvTN1FR265aBVijK+c+Uyts6h7oqEi4d/z/mY9iEr7MIAo+TvBRtmhVXRmNJYdii2X8eD2iQRhUflCjVR5202RNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118699; c=relaxed/simple;
	bh=bxAe6BE//0LRX/4RtjkCh0wtOvyWI3iZ+0dZGqCJ1Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nXm03FC/0dnOBOso8dSKivatPCVJPIe5ZvsvCRvHoosjx7Z5G0JFyNEsUr6Am3D+ws6akeeCA6lO35V0cGhMVpa9HwRp5iAc4rFJQ+vZRDVqRH/Gy8WrQfxUz6jcLcCYtJhO5I+nGfuH2NGB+OQcQpUF6vtt2vU0ywbJ0IKNOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=USa1h2N6; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42403c64164so42984825ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758118694; x=1758723494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4E5XWf2xRnBRZK5DaI+VLqxC4Ws8IPzvfWrkBqyKRmE=;
        b=USa1h2N6Hg+mgdMzlQluvxvKJA3yrT2Qrbs+amcIdNSx+sueSPn2XUSUor2liDZi/A
         6tuRjEub+smbCCnhXQNmaXLhOA4XFZazBKZmCUF+F5XP7W2Ioa6nx0g6SeCmFi7BG/Tk
         iPLqwPTs3ItBQtOcL3cNmbNrr2rfreBYONw1JKMLtUyx0chov9LpYm5Af0q8hHxYwx9F
         Kl6KITw8itT6gL9N5wwUx9Njy85KMvLS/wQ1WL9t9AQMUrdbMMPnI/lcxTf8WDxSyf+P
         8bk2RyNe8vQ+px4KE25t7gQ2PkWzQ8lAqGV4y/7up1+SalAaLfXZyrEM9QTrU+op3fpl
         jNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118694; x=1758723494;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E5XWf2xRnBRZK5DaI+VLqxC4Ws8IPzvfWrkBqyKRmE=;
        b=oymPW7Pm5iGocLB0g88LgPEW+WO6i1OUUeQh54zR8IYYZs9oS6t2LDVaI2vCJOEy7k
         0ze5uHXLnvOxGhp9Geb4CycR9TSfLLVV8d3ycvrdqNiBeZLoMqowYk+iTf1hzi/omeiz
         WAu6A7rdIessED0OApXjegMrVep+6N4opDxJ6RZ1wPE6Rskxbmh3HxWguxhvC+3EO+rc
         muIWFqvKqgSjOsX/kw4QbBmf6P4jkias3Npj5OkCXeCXgEG0vHjMZtrCimgriKk/WjwL
         Sk2IhdvqK4/5EnWIiSITc39RNlHNmkR3+UVxqMIIN8TDK0SU6OLke9OJ1dkfZrn29UCa
         Ba3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU3lo+ocZM1kevDy2/6Fi/0KC29B/8QXNhgHEgQJxmjVKxUFJSgTCshSjpsObq9hSNUFkLH8dwXHqe6a29@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0uf4TAeUUjC53LT+GLApkjVl57bS5ZC3LbQumuSeb04JMwNGS
	X+DKOUGJDcVxqtcbhBVc0fFKpmsPxswy6dhox9hzxkHkMkTYSDqrb9QsNPaKa/cNrG0=
X-Gm-Gg: ASbGncv4EvjJQBRjuU4xSx20EdzoZ6OOteuNMPQgWs7Hl1ogL8qw99lshtM1o+vg5ZR
	gpaCeEAFpxKeTVNnFFCCI9lI0xI5KEgbbM2c9o1f/rFPgNspH7M3Fm6+JhWGidcMKL6OxwCzuMH
	x1BzuUKpfR7lTQEWFhQlr9jx897zWU77zeNkCuKPN/3nLCmjpM4sxI2T0au/fnxpOE1zqBCEKe/
	40E25l9Li6DNYiRuRJEGbCOdJMU/ZuyM1nLMtLQLPQkiFlvHFMc1XaOrLMGlJgQP5IjsF76lY4K
	QSTdA4wKuWIanwRc+UvUFLLrHzUtKXAQGT9RjMN9nNhTZpE+z5H+X94UKvz484n1T1j5qxgtfEr
	j7qQD3VAhxSirJ+sTrc8=
X-Google-Smtp-Source: AGHT+IHw9aVHck555OAecVFFSQr5Ag7QufStlk7os7YR9GLVis+RAFxBlhN3ct6/EdoVC4QxpND5hQ==
X-Received: by 2002:a05:6e02:19c6:b0:3f0:d2df:633d with SMTP id e9e14a558f8ab-4241a4d1888mr27257675ab.8.1758118694333;
        Wed, 17 Sep 2025 07:18:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f2f32facsm7048825173.19.2025.09.17.07.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:18:14 -0700 (PDT)
Message-ID: <073453e4-c6af-49bf-b74c-5cc205143879@kernel.dk>
Date: Wed, 17 Sep 2025 08:18:13 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] io_uring: add support for
 IORING_OP_OPEN_BY_HANDLE_AT
To: Thomas Bertschinger <tahbertschinger@gmail.com>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, cem@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, amir73il@gmail.com
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
 <20250912152855.689917-10-tahbertschinger@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250912152855.689917-10-tahbertschinger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 9:28 AM, Thomas Bertschinger wrote:
> +int io_open_by_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{
> +	struct io_open *open = io_kiocb_to_cmd(req, struct io_open);
> +	struct io_open_handle_async *ah;
> +	u64 flags;
> +	int ret;
> +
> +	flags = READ_ONCE(sqe->open_flags);
> +	open->how = build_open_how(flags, 0);

Maybe kill 'flags' here as it's only used to pass into build_open_how()?

	open->how = build_open_how(READ_ONCE(sqe->open_flags), 0);

> +	ret = __io_open_prep(req, sqe);
> +	if (ret)
> +		return ret;
> +
> +	ah = io_uring_alloc_async_data(NULL, req);
> +	if (!ah)
> +		return -ENOMEM;
> +	memset(&ah->path, 0, sizeof(ah->path));
> +	ah->handle = get_user_handle(u64_to_user_ptr(READ_ONCE(sqe->addr)));
> +	if (IS_ERR(ah->handle))
> +		return PTR_ERR(ah->handle);
> +
> +	req->flags |= REQ_F_NEED_CLEANUP;
> +
> +	return 0;

Prudent to do something ala:

	if (IS_ERR(ah->handle)) {
		ret = PTR_ERR(ah->handle);
		ah->handle = NULL;
		return ret;
	}

> +void io_open_by_handle_cleanup(struct io_kiocb *req)
> +{
> +	struct io_open_handle_async *ah = req->async_data;
> +
> +	if (ah->path.dentry)
> +		path_put(&ah->path);
> +
> +	kfree(ah->handle);
> +}

	kfree(ah->handle);
	ah->hande = NULL;

Just a few minor nits, overall this looks fine.

-- 
Jens Axboe

