Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3071285A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 00:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLTXsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 18:48:51 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35946 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfLTXsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:48:50 -0500
Received: by mail-pg1-f176.google.com with SMTP id k3so5720373pgc.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zworJJwQ8dOshFr0Q172KPILlQ/18z3PgpXzpXjduD4=;
        b=Oo62xS5QTd9Pi9wuU/wp1XxKZ9YnnqNbj39mTJiDIM7+rBbqPQ0thBrf10zljuAgRo
         s2KpYnSXwNExRfb26lB/tm2E6E9temQCKSTelu1+9MZtKUBVDZuJCmKRAq8PJh4Vxnsk
         me2XFBzA4RJEDnXjtke9v4Tco8mFJqGBDqDYaipnWKYfo889PZJGIAk//570rTBpnxHS
         B4ziulXhui4VYDp1R4rhQFqZ8Zxd5N15hhjIvg8O2pSEofXKsrFr5pNlwZ1ubIzEqXEE
         P3WStyWCcdPCayW57YQhVPTCI9S7V0rSUN+PRICyCJs0dUQKYUf1r938QKU9NKWda0g9
         D7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zworJJwQ8dOshFr0Q172KPILlQ/18z3PgpXzpXjduD4=;
        b=DY1ypZYI1UL1KO6nn1EvJE/KzBL3NBew908lt4ou78HhSlq03gL8kH7tfuz190k0oq
         /Yy1G959u9HeNJdbR6kjpLL7w6drNAIORoiBlq77sNalHM8QdVzic/EdlM7iiie4EWZi
         vGTkWdumi/2udqLitgo9R90eBCCYWjmZFEMTxfOOZ7hO5Ea3xqRAU6F6c771GA62c0nq
         v2BGgxzcYcckqEftbDUvr1tYnb/DS7H22hHxZZuup8rWMe1fm7kZzRtjrgPioPpQUQ5A
         CQWtW4L95U62Ab5XS2MSil/g6Y6Zks84aInhoCFnbbh5vrbhHHc24TPfSeivhJEs5BQ4
         PMgw==
X-Gm-Message-State: APjAAAVV+rzOVoCMELI7fHymPrd//qA4oHJdrJSCrSkBsEuKm4X+WQPC
        IrS5uwhYa0/7EJMxt3B41nmfGpST/uYA/A==
X-Google-Smtp-Source: APXvYqz22Ej/ewFeEbkIC+4DB0DxQRk1L0hC5wwhrHpRJH3fc2VsKC/9Ng9yNeyTfu2IdxGyefEwcg==
X-Received: by 2002:a65:420d:: with SMTP id c13mr18172724pgq.101.1576885730034;
        Fri, 20 Dec 2019 15:48:50 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g6sm11405366pjl.25.2019.12.20.15.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 15:48:49 -0800 (PST)
Subject: Re: [PATCH][next] io_uring: fix missing error return when
 percpu_ref_init fails
To:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191220233322.13599-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <398f514a-e2ce-8b4f-16cf-4edeec5fa1e7@kernel.dk>
Date:   Fri, 20 Dec 2019 16:48:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220233322.13599-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/20/19 4:33 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to percpu_ref_init fails ctx->file_data is
> set to null and because there is a missing return statement the
> following statement dereferences this null pointer causing an oops.
> Fix this by adding the missing -ENOMEM return to avoid the oops.

Nice, thanks! I'm guessing I didn't have the necessary magic debug
options to allow failure injection for failing.


-- 
Jens Axboe

