Return-Path: <linux-fsdevel+bounces-42075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D1AA3C407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DDE17A2F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E41FCCE1;
	Wed, 19 Feb 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoSGvJO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81821F9F7C
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979840; cv=none; b=Qz83rFERMnApBFWKB1UcLegQ4VTEwf17CGttv3g33qw5va3w/E9BVqhtax+QGfOitWusnz+CNKUvxBjPyM4Ykur/CVST0J6UndDHkBug49LCPh/ZLXTr6hgZr3+1i9YGMDVuZ+xDYGZLLgzxu7ABfDR+/5BZcCcbZkYDgD+M1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979840; c=relaxed/simple;
	bh=YNmYlTClH6f57hMX0irzBAGNNqToOG6S23UwEJ2SIOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmb/KGyEsxB0TT2a3tDM3cXCyomjCarv4dA9dzl0FuHY1afKCLUJLje6GIMDYlY5kz4YT5W7OwX4Y0bOny9mwLfoXstMVYCTLIB9jwLmXYPyBDgNbHyDRQ4LIcuHU6NA3k6rZB5NpCJ7ugK39y1H+calh9Jrjk4LPjTGUGYfkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoSGvJO8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso125848266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739979837; x=1740584637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztTcSqiM5jchwSh7zNDJUJXvpA9bZcVb5dRh9uYh8nc=;
        b=QoSGvJO83q8cWOJJ8KKjrnClpNxrJ0kdQZzcO3aB88o1NUKX5dQSIXXXqUJfs3YR/5
         6DVZQbJOqSLfag/Gm15Q6deG1TVw2E+Wj//os0FCD8Chr9/v1PH+UuEkEeTxrOutOl+2
         tzcms0G5JyMZ4dtMhx+aY4kO+ZNkMtJYder+9p2yRGK6oY7JuQX7FXEfufSApqVPYqBs
         CWMNn7ytav+OFZJv61mZNB24RzH97CIT6apKcohOToJj1YTkoNVAgGo8GNasIhWKqDbW
         AuYQQsh19to4MC1wDMKWyni3kDwygPJl5adZztkb6KTwBA9tUu7JMJ8JBDuqMgxeu7V/
         s0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979837; x=1740584637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztTcSqiM5jchwSh7zNDJUJXvpA9bZcVb5dRh9uYh8nc=;
        b=o/Fmc0dae0vvYC/lIiJyx6DdHU8/rm4hb5ZG3ZE4fT/w3ggHT2p1ANrVmlTNze4RMB
         85/aIGHELww4SPqToNSZ9DXh9KFbrd+DUNv0OPBJFrM/3FmZApOkoynn5zPVi9Et7YIy
         aaM4GpWJEQXClzK3AwuPgWpP6sDxFVRyrgS9ELyQ9tZ3HLJLoPT2FF1tQ9Elw7CTAIWH
         hK/NaAJY9u3y/5XE6eINSLct63Bnk1wvrLUQFcQrO3HvV4ZynRfRNirX+7qSkS7Y/aE8
         MTbXLRY2xPnxTEqf/+JricBZJaxiVS4hUWqM969SgXNkrUuGisw226fUqchcrYmgrnKJ
         u+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKgnJU8Bi3DSf+zoTL3Z97QSXLZVm0I+a3W/kYGPag66FX/wuRWFyqzVWcehiHSmcdeXR23qr9ZUau5oUG@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJpMmaohIivZA5/mpdvocYQ0U6hJPKKkC4uN4sQfxbVqMbK3q
	vOeHP0dZVnRXeMDDEd9EYrhBvgNgKxV+z4n1o/TXrL4Un0qgKxAXAN2IB6DojQg=
X-Gm-Gg: ASbGncsj+SiW9yXsNfoUznJWXVLoABvp3vDhYddhaL3mCohaoVYOyKzgdlSaHjiAhiS
	pHjKMeajmfjaTuxHxSGMyjd9sUTSSC39zMpc0lKVvP7OaiYI9vs5bFqVFAR793UC+RBcOcfQgug
	pb8MIvxX0xBRsdY24LaOJqkHuV2YwqC7wXUmDNvD5E9H/rOXBU7EKMl+qZIJIom3Zw5u6O10iNU
	bpdJl3hmzmS3LbokR9Pb/7kAepUP+/TUN2XYR6ftYw874InTJ/ilDcveVP2a/mxe6QyphZoisS1
	R4y72PZOthBPKdsmJKot
X-Google-Smtp-Source: AGHT+IEuAZ/31Yw+onuB6dX7P6MBrwUPKEqWPMc6/GLwGLwgBLIZWvMyIkebqkSIVitXPRtyLX0fJg==
X-Received: by 2002:a17:907:d307:b0:abb:aa8f:c9cd with SMTP id a640c23a62f3a-abbcc7f2ab3mr419789166b.28.1739979836924;
        Wed, 19 Feb 2025 07:43:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbaa56026fsm491684066b.113.2025.02.19.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:43:56 -0800 (PST)
Date: Wed, 19 Feb 2025 18:43:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
Message-ID: <b44dc8f6-7abf-4168-b96d-54f1562008e6@stanley.mountain>
References: <20250206155234.095034647@linuxfoundation.org>
 <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>
 <Z7Xj-zIe-Sa1syG7@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Xj-zIe-Sa1syG7@arm.com>

Hi Catalin and Yang Shi,

What's happening is that we backport the latest kselftests and run
them on the old kernels.  This is a supported thing so kselftests
are supposed to be able to handle that.

So we need to modify the testing/selftests/arm64/mte/check_hugetlb_options.c
to check if the feature is present and disable the test for older
kernels.

This is not an issue with the stable kernel it's an issue with the
new selftest.

regards,
dan carpenter


