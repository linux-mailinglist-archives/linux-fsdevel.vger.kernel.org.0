Return-Path: <linux-fsdevel+bounces-61943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6501EB7FFDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9229154536A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852022D9488;
	Wed, 17 Sep 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e/73JgnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6702D879F
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118492; cv=none; b=sqKN2/elERNjiCih0CjVpcelEP3QIwCVfT4VNSjx2bCVNedgwA47bak+NpXIOErZkKDUSlFj4f8lDZxB8iPVA28nXhBN9Ewp5q4y8Aoe0KAYd3JU+8upQOob3QWcrXneFn11Q9+cQU7L1U5ADArhY6suc41TPruBQYpUKOZ1HDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118492; c=relaxed/simple;
	bh=harHSZQvgtC/E59IHZNwu3Rm04386V4hmH8FCVWR3Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PdADzK2DepI+fXpIVqtXL6imIM7ZcK6K9qIY0t4l2sZ/+M651YYmIh3hrdZbFab63uZ9ZH22rHu5xj81SEJefkzmsVm1R2z4lxPShd/Yo28u3JfWi3A2yKSmFdjhz8yYzfaYOOnlpa3zqtPqQL1mjIdiUFj4HSflgKr6EdHRUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e/73JgnG; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4240111d446so40474075ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758118490; x=1758723290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVpavbXISEVtm5+aGDVVijQFcplhsQrG94O8tBhG3f8=;
        b=e/73JgnG7wi1No9isfCJRrLkeUMOzf19k9Qhx7mhgIiH2ws19oii/VU87LNDV8fbZu
         tBKqzAWaahxMBcyqP/vfwspCAMZ2WVnMItSKV2QzaWTNcLIH3OPsibFOYIq6CxeKJXnh
         TrIMArKR1/M3gwvMBzJeTqQtu4iGUyqQg0GFQfrP6+TsOzeIdcZ9jZTdjVYUmiOvsBOQ
         hW5LTtrWtyTM5Rt2a6Zls9f5I2kajM9v/cXW8uEcjBgi/LG+RB6rNPlQ6VAYAXbj4BWz
         j5O8ynXUbom3tJkGIiHSuf3XqMVuhJYDPnFHNUJwloZMvE89h8TsQYSknce7L5oOBBYu
         RP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118490; x=1758723290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVpavbXISEVtm5+aGDVVijQFcplhsQrG94O8tBhG3f8=;
        b=SyQnFXbxKglfUfEFRhlcm1M/GrvQI/cW7KY1YGPVc9PZPM/54wtmsjHp1CkrA8i7W2
         BznmwtZ/g60mrfB54wS9tPJxPMPVblWaf2ZW67EvhauqqhkJgwN1T+khKkYtadKjbpsj
         4T7pz7dxQ+WCgpkw+P76c8L36uAFpf7oHYHBgyyZJ3Zgpd7F1vedzRKFtDm4l5dsrpWE
         sewe9+0yF9qzN8gtMpy3fksKMW333FIokYS3kyGzNG7gCH7O618+SDef/Eq8Ubh5jkt7
         rR1TaZl/kfHE4TBvqIH1r8igD6D43auLXVih7Y/curRZzEdEXjjQJQwDdpyoOF7olp37
         6PHA==
X-Forwarded-Encrypted: i=1; AJvYcCXiSgvpHINoK2BHmPeCm4A2sO9t51vw8fpQy0JsIkECzVrHIfU2FR17A1D/lbeT35qK0XkF7gbRCnJ/ZTxE@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCn7/aVjF48cKPjsOFMBxy41FwYUbZ+dOg7ekixUic04C2rBg
	IECa6YUXyWk8+aLsMVBkk/N9mPYanSQ8FamfPDUTkLP+z0SnNFhAHMI0W97nr4RbOg0=
X-Gm-Gg: ASbGncsYuvm+1rKnVMWzm0VnfNCpvM21+JyM48HWyG4OzGxh8jxYV2+n41x183ZEJQR
	8T4p/2d/JTMh28sjlVfOHBRLBGvMcmMJ1c+Lg8V3M2v8JArnc9GmnYMAhWORMmfYRiLaY6Az88p
	A43KiMTygxpE21+6i7epKUn+P8EHd2SETOUjDdzGYsJyhQo0qQ3JE7Qbz1IvLNZO4qk6mopOk9H
	1LfK0eqEw9f3cCI3uKnRW4p0CkJbxScXOSQNZxgLHUTVmK3sjvgz2guZRUW9pBsMXlbQaw6eMJO
	q5x5okLO8qKc6SC512uPxtZfP20cVRpBZ05Qth22KX5JMYMEs+mG6/LO1/DVHNg6frgTbbprvbX
	uOI2XRj5Z41xnXrviM+M=
X-Google-Smtp-Source: AGHT+IG8yW/XVL3oFIv432faotyl5by5gpmLB7mgov/ka8Ly2XOQKV7hnuxEJv0X7nDEg/FPrFM5yw==
X-Received: by 2002:a05:6e02:230a:b0:424:a30:d64b with SMTP id e9e14a558f8ab-4241a5297f5mr25322155ab.19.1758118489895;
        Wed, 17 Sep 2025 07:14:49 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f30cd025sm7033209173.83.2025.09.17.07.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:14:49 -0700 (PDT)
Message-ID: <eed1186c-4213-4bc3-9529-42a213083019@kernel.dk>
Date: Wed, 17 Sep 2025 08:14:48 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] io_uring: add support for
 IORING_OP_NAME_TO_HANDLE_AT
To: Thomas Bertschinger <tahbertschinger@gmail.com>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, cem@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, amir73il@gmail.com
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
 <20250912152855.689917-3-tahbertschinger@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250912152855.689917-3-tahbertschinger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 9:28 AM, Thomas Bertschinger wrote:
> +#if defined(CONFIG_FHANDLE)
> +int io_name_to_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{
> +	struct io_name_to_handle *nh = io_kiocb_to_cmd(req, struct io_name_to_handle);
> +
> +	nh->dfd = READ_ONCE(sqe->fd);
> +	nh->flags = READ_ONCE(sqe->name_to_handle_flags);
> +	nh->path = u64_to_user_ptr(READ_ONCE(sqe->addr));
> +	nh->ufh = u64_to_user_ptr(READ_ONCE(sqe->addr2));
> +	nh->mount_id = u64_to_user_ptr(READ_ONCE(sqe->addr3));
> +
> +	return 0;
> +}

Should probably include a:

	if (sqe->len)
		return -EINVAL;

to allow for using that field in the future, should that become
necessary.

Outside of that, this patch looks fine to me.

-- 
Jens Axboe

