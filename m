Return-Path: <linux-fsdevel+bounces-42311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083FFA401E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87C47A26A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8774253F21;
	Fri, 21 Feb 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DggnDjAl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A67253B73
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172463; cv=none; b=PnA6t94snvTK/9VYGGr39UIMlVphlU9Wzhjo3bYH1HedHgFq2rU3ZVnthCWWdO9tJ4IvfEc7wU6rG8zK8DoUYNPwt/4PAg1Iw4ALG+iEs4pjO4BWX2JrpspFeGuzzVjZXlJZ5GuKsIW1yfTJ1q1Z6zMlnBaVOU2vOzv6EckKXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172463; c=relaxed/simple;
	bh=LUST0WfY2YYH8MixRvQVt0HfCogiQFfD5LD4HDRjTGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMPbP0CBAk7KO8vpy6T8d4pfLrFRVhMqaskh5w/g9oN9Ngn+rzfylQEzO3TBc8pCqthTpldkafdSWJz3zwi9c/3bDKJF2c9g6Sv114zur+WtvToEtMbWDEc+ustM/LYrUIzK9xlNCyVdBk9tPkOjEKOT5b+XR+6Lip400S4wFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DggnDjAl; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso8252085ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740172460; x=1740777260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cl2P2JOYJNBx1mtaYBayROisqQOMPgvFm8FiItSAUM8=;
        b=DggnDjAl6GpDqoVT7yu5rvRJunyrlidW2SMS+sWDipW3UsaZSHTJ/VA+o82jx0dK3u
         gU4JLW2db0a5ooygz1bMYEJ7WKhEmi5PEOlRKNwLKp6j+nJa3+Pz0oGNV27FKH9AZOtP
         nXho8bWRQl8P8FG5iNYjLW77Vrp2LSWcw+Eria77FOmCCS02P7AxYAP9d87QNiFrGyR1
         AB3gIxiMB81VaXP7WbpAV8CNuipxbWupn9U6PcWVJUS1oPb4b3FYHl0YAT1NxssRkJy3
         cxa8AmfPxvKq2mVx4C8eo5oCV1u+WyCpnoDmFivCXMbfyeDqSPk1lyh7syNre35pubeo
         hnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740172460; x=1740777260;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cl2P2JOYJNBx1mtaYBayROisqQOMPgvFm8FiItSAUM8=;
        b=iXcsNhy8K/vNYWX5Cb3A0DBxyLWM3vCo2Dqe2HU1sfhsAY15vXja9tpepQEymFma4E
         cPOL1rVT+IHCtgeP6DZ7HHB6kLb38iKvxPLR6pCrLHqvc+cvNX0ZzE7SN6uxECgmnERK
         AT0AKmGygYZklnHARI61D1DmKMR66OnDb5yVXQJetrSm6y9cAn/j0cC7rXlHvB41mmLT
         uYT4/C83Tw90Rujmi5sTVBaeC9dipI7LUStfJ8Fc/0wpqES8eyr6BXaA6IEQsW9Sb9FK
         LmeDubiMjuNSgsZdLq04IHkBejEK7UkhgSYSYy2wxnA6w3lCZrz8e9XnKcOObLabhSKJ
         TLGw==
X-Forwarded-Encrypted: i=1; AJvYcCV+6TcUqd9K6F6k6Ca4h8W9MXYKABXx/hBE87I0LQNtzvWKscWlVZsiP2I7ub7UElgaJ9WsfFYUB44IkErg@vger.kernel.org
X-Gm-Message-State: AOJu0YyGkcZEy4F0LTCUsz4dzIZS39Kz1LkTW0n6gfAyTFHF9G85PGf7
	ROn3ttv/ai7A3f7aH4g675tN57b3K7Z2iOSUZQ+epkzI2dr17WHP9qFsJyhypDQ=
X-Gm-Gg: ASbGnctPVeYa6a6LwdQk0Qz88G2PEczIJelCMMUpm5rM4xkPs5UF/44nfksaRaa8AAM
	RAa0/KlMDJLTWypEy/vcrgwyckhXGqH2HInOZrvxhr3KREQNqo59c+fuzNL42m4KqxDA6UDaQNU
	qDxC9nNiFxhlGx4PRe2J5wIOiJ82MI6cM96D+F8v/8wvdiRcLot58aBz/K23vix1HcZAfQA+DdJ
	DDD8oxbSKsFmJB/fAhyUSBOoIYHmi2uq+ICUJy7vgYZvj3pIZTW8kyOrrbe0hzDf8F3k1r2AzoD
	uYOkCZ3fiK0td2LXpleC/xY=
X-Google-Smtp-Source: AGHT+IHGUx3T72p6QUiwnKjXxwo0LmjfmkSlf2+w+lCN8J9EyU2JybXz1K2UEwewJnnNAq4zeENvnA==
X-Received: by 2002:a05:6e02:156e:b0:3d0:4ba1:adf1 with SMTP id e9e14a558f8ab-3d2caf1a20emr50626825ab.22.1740172460685;
        Fri, 21 Feb 2025 13:14:20 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18f9c5a21sm40521905ab.21.2025.02.21.13.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 13:14:20 -0800 (PST)
Message-ID: <3a3644d2-1762-4504-938a-6776c137aab8@kernel.dk>
Date: Fri, 21 Feb 2025 14:14:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 0/3] rust: xarray: Add a minimal abstraction for
 XArray
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please have (at least) a 24h cool down between versions, spamming
versions within hours of the last one is not productive for (or
conducive to) review.

-- 
Jens Axboe

