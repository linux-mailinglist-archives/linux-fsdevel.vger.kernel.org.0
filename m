Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB40E4B91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504638AbfJYMy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 08:54:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45968 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504636AbfJYMy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:54:58 -0400
Received: by mail-io1-f67.google.com with SMTP id c25so2240926iot.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XqRZL3LD0cAYpu4i+Oz5gNumeaGbwkRBXuU0UymszRw=;
        b=FGzHDnk90eDcHEqQWBtHbS3AqS9XkVlgVqg8Fd/yZObK1UxjtNbnkzE5l1zepmuPRt
         cyes7m2M8EpWs9YBTaEhM3KTiF1PGqCHVc4Y1WdjrYQNQouiqoOWPD5QQEhHWWpgVZz/
         e856QHAOTtBAoIyYul0s8yv+7tN+FJp0X4oepfLB7PK7iDZL2UUgnbZ5tJoFy2ffytTo
         lezWPU0QbbjY0zNb46QXfJ3CReBKOH3x9+6QQL6wgMrGLESuaSMJty1UuYhYP/Pqtpn3
         O9gnBqnzoG6ynfXyoP3XcHbGsbbf6hE9kU9/tNabsHlTWiv5RxCN8icaVFOTafceI+cG
         ztSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XqRZL3LD0cAYpu4i+Oz5gNumeaGbwkRBXuU0UymszRw=;
        b=qOIDfvmmJKbhaByqTeLTMl2FfHvbKvVr28IO8Si8VYEmkolz7AgsOXZOtwoZaNPbDS
         9YxEaCRhQ2oYW+u97VsPFDTXvbOJUPcxHTiViRaTXlJ+2bERYm0fwpvUaVjGMkpnL4gJ
         qxtyYypDlM2RvErbmrD96+tCiPzQCLDYK4j0UwJhb1t5DxafvAYw9zl3W1V3qEXycail
         qNkgL80kDlA/0XO+iPB//c85wBJAKT8RKp6FCZfD7rcdHCGqseLXcnia2CAKJ1/HzNq6
         9g5Ilk4ucZtbX0XieV1j0M/YjIWiU+LedJRj+2GNkxgLniRd7pgF455f1RdgsLppDzEs
         eEFA==
X-Gm-Message-State: APjAAAWy0l+EVWanjwD+Hg6at1PVjSatNbCA7X97hqcEEtnpO/I0XRN5
        rHHiL4VGmGS6wGmOAh8v73YY3g==
X-Google-Smtp-Source: APXvYqyRv6QNh4wAE0Yq4PNSmeWazYkJpqCtu/Gt2kSofhSOTEiA6Gjj45It1k+vN2/LmYqGl4akaw==
X-Received: by 2002:a6b:f415:: with SMTP id i21mr3597034iog.109.1572008097263;
        Fri, 25 Oct 2019 05:54:57 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l64sm66767ilh.2.2019.10.25.05.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 05:54:56 -0700 (PDT)
Subject: Re: [PATCH][next] io-wq: fix unintentional integer overflow on left
 shift
To:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191025124315.21742-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fc23061e-31ec-8a66-2b62-771121d182de@kernel.dk>
Date:   Fri, 25 Oct 2019 06:54:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025124315.21742-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/25/19 6:43 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Shifting the integer value 1U is evaluated with type unsigned int
> using 32-bit arithmetic and then used in an expression that expects
> a 64-bit value, so there is potentially an integer overflow. Fix this
> by using the BIT_ULL macro to perform the shift and avoid the overflow.

Good catch, that should indeed have been 1ULL. I'll fold in your
fix, thanks!

-- 
Jens Axboe

