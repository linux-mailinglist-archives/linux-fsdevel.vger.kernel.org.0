Return-Path: <linux-fsdevel+bounces-61945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F059B7FFCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BF31C87BCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9796E2D8399;
	Wed, 17 Sep 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Qx3lqok8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BD2D7DE0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118738; cv=none; b=IjEEVxXJW+JcMMtWtIbY7yTYTsUNKwhC9X9v5locl1cH8CZn8TNikch1baT/oyi1g8mdDzrx44//emSL1eHiMBOQy4jRdBM4u1w+qh5ibhTq59qzBwcy1ezIipIb1eGIRrf6PZ+PBzwHRC4pTMqXEYYj7Fr9mSnMsMJu96mLSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118738; c=relaxed/simple;
	bh=qvPmqnT0GuwUtOmZwK9Z04OkVVWN3ZAbCb5Yyg9H46U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DuF8HOG/NRW62hkVHQM6Qo9G1+qKl6oETXtfTTNsxzNbLcizBRzp98IGJcyJxEzzXMOxBwbLEajQn+0VSi0FeQAu1kZ9SwylRyfRTMxvGn00iqW3spSfzffynKdpBHQaCKsgq6ASZDpKNUta5HIAdREpncsnPiAE7soZWLihr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Qx3lqok8; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-891292b8495so381367739f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758118735; x=1758723535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DA3VMHiGzzibDL6pUIUYW3tloC3K1AfAFuDtTzpA7b0=;
        b=Qx3lqok8daad6D7UmMoXWjGnWkEJe+mZgMbbvxDGdJVHHzrv372rY58P5XP3mZrp6M
         mNT4ruARxZsCJdCSHvf/Pz0jaQVnHf44AAaCrIvv9R+dRBIgpzKGePvZT+Ya5UJBJKDZ
         oyrvd+Iyfee+XEuXETjiRULFNiZzLvVoXekpGke9jYqjmxOi4sh9M5lnCp6GllDPw7nZ
         2iq1jg9W3tUPYz1XhLGIh4UDfWA0ENbgkwQnmCzElkNw4CBDEu7nRYTWP/0hAszi91AI
         9KNqv1XXSxdo1axzyfOFGr+CuetDBgnoL39Vv9uhDrfWe05AePHG1ziqSr9OCw1X/ZGl
         TOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118735; x=1758723535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DA3VMHiGzzibDL6pUIUYW3tloC3K1AfAFuDtTzpA7b0=;
        b=A+KxSCDklek+mInaW4mtzo8vkTeJF3cIsqm9CwqniRIA4YsHLBxhfNbMH/cTMniYe2
         PsKFxWBFsxO+LlYMUgOEgzLgKpGJq5XGRPYNQhoealudgWCJBZYnW3ioENLDmqf31mLp
         g+ICYKM5y/zfQElPbmPykiGALcDropKni/azwqSpe0h8TKoXvIFTHQ4VcK8AhcahO3y0
         bBPJqlFl5qK9LqZkI76t7dX5TYSS+NBaLDXjOKdOzzCtzXnSRVdLSFwVJRWthdx+rZnD
         GE+d/TYuURrlyefR16Tj+dU0a17PfwJh0farLvSMYf7yNrRpsOaU/p/B2z/WMudcy7G1
         4rYg==
X-Forwarded-Encrypted: i=1; AJvYcCWT6IudBsbQSBtQcXUxipz4F+tLKJuc54t7D7Np7b7d+LFAmGoym4iec1J0FGEk8PH/Uxhim1HV7tAKif4F@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+fwCiUDD5lq2c8rjcvwgKMuKWwWyypnf2ngUHW6Y+Xo7VCvK
	t3pB5IMR9iaPcyZqp/htsFKkmKrnpu+WS9b/4zH1txJqkmimbr7Ny6XjC3fmsu8H8Ug=
X-Gm-Gg: ASbGncsy9njv9KvBTV2soLpeupnUNVItdvIQg9u8Ltz02QvLHU5efpgA0uO7Mlrvft5
	iVzT1J4F7sD9dwbGjq9o98taGN7cFpYAXBRI4EeF3gVFMD8g790zgni/toFXTmMohMI8O5sTrG5
	TWhpS88Zo9oiId9Hazw8H8M9imzkDGLN4tKbfaXdzjpmXqi23C/tHKqzpV8rjFVIEDvqS6LeMoc
	tMOpDC4IPITd4q926Z4fRsMGMN6KQhtZega0VSPLv30PLr61KnaD8Dy64Nqgg1f90s2ktVpI2jN
	mFURH4ROpd7DLYOyqQ4r+r4xacgq8hM85E+nqRT3RRydbIL0g8tLoDHhgFCLpT4pwDb/ENY3iZW
	enOQjA+I2sCne70x+7Yk=
X-Google-Smtp-Source: AGHT+IETaw7JxR4yD/B5BU++ndtz6o4tEdapBtyWCAqX6xlI0Emapaz/9BDEIacwy+P0KtLmhs7TOw==
X-Received: by 2002:a05:6602:2b14:b0:887:1b58:4e69 with SMTP id ca18e2360f4ac-89d1d4b1c12mr380124439f.8.1758118734932;
        Wed, 17 Sep 2025 07:18:54 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfed6sm657283239f.2.2025.09.17.07.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:18:54 -0700 (PDT)
Message-ID: <c69b070f-2177-4b8d-80d0-721221fe0c49@kernel.dk>
Date: Wed, 17 Sep 2025 08:18:53 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] io_uring: add __io_open_prep() helper
To: Thomas Bertschinger <tahbertschinger@gmail.com>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, cem@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, amir73il@gmail.com
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
 <20250912152855.689917-9-tahbertschinger@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250912152855.689917-9-tahbertschinger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 9:28 AM, Thomas Bertschinger wrote:
> This adds a helper, __io_open_prep(), which does the part of preparing
> for an open that is shared between openat*() and open_by_handle_at().
> 
> It excludes reading in the user path or file handle--this will be done
> by functions specific to the kind of open().

Looks fine to me.

-- 
Jens Axboe

