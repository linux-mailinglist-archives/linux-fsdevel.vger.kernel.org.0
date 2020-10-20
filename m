Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0626293EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408231AbgJTOoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbgJTOoj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:44:39 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB7C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 07:44:39 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id g7so2529020ilr.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7AWlp1+JqHhlAXGhKuSuDKy8EBCtpXcf655lDPbeE7s=;
        b=QLVVPRrfKSwIbDy/CCp3l3GwNKxXu6ZX0h/w7hIpVKruWOGghWYcw9LggfEtLCkhmU
         kyjXTaqyIrf2YapAySkApDm9kmGP2SkxrPn8DPTa1CrVtQWiO9RF0zsc1msGZ9Js2Jdx
         /wlAzZBNpRyngidahfn10FG2egEQ3OS/MUq5em5wQy1x15kdvoHTErbjk/G1M3ZceJFr
         Gizr+OhkAph/m36VqEEQoJ11cR9to4yj8D8S1dQxCLf0Jp/adePToayTyQFvtyFnjl5w
         2v1enP7aNDBK0yRiP7K2J5Y3hCk58voKKcJbv0TkWes1YqKMjD34mQepoXlYUeDe4SP8
         IDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7AWlp1+JqHhlAXGhKuSuDKy8EBCtpXcf655lDPbeE7s=;
        b=BLfNiu2uF8ereG9GdEYgQwAjfmwQ0fsdQJv/OEEctl/M1aSShzniVnZ1ihYqZMMw5T
         gG7LhBA6DhHIEr2bANPTIhtyv/RzcQ+sE70/sJVX510/hEqRZ5qsd+5LUA5op1U+/gSN
         63BM7OBi268FJAtsm6k98RtUIoSiDaf3zj0uceC+kETB4KcNtQDRuoo2gtkIF7RKspJK
         Gp+9AbcLt63xVfHOmtxvqvytsld4VKNYPKdalYw7RMpqPtqd9r7n7KuiJRgzLdh7aD/V
         2UK+IG/NxmqTbGrlBuD++m6FggETARN0PEJXED8gXn0Z9oI72DgM4c89/rCF2/ETEuOV
         RNlQ==
X-Gm-Message-State: AOAM531Ohg9iZlG+wP2h4mK63WKJl7xsoj1OI2DMeHJbKd8YGMWPqJcz
        atZWwMj2h8UQvFBCrKdbr1RBavAMvZRiFA==
X-Google-Smtp-Source: ABdhPJzo6BdapOkvXh9HJvVkukfqSw/0YcLiPezB+xgPXEho7r0w8fHMAlONd0nKyukgiHYpCETsbw==
X-Received: by 2002:a05:6e02:5c7:: with SMTP id l7mr2324032ils.43.1603205078861;
        Tue, 20 Oct 2020 07:44:38 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f1sm1978768ils.23.2020.10.20.07.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 07:44:38 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs: Break generic_file_buffered_read up into multiple
 functions
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     willy@infradead.org
References: <20201017201055.2216969-1-kent.overstreet@gmail.com>
 <20201017201055.2216969-2-kent.overstreet@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb8d37ae-823d-36fb-6b54-779492d562e1@kernel.dk>
Date:   Tue, 20 Oct 2020 08:44:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201017201055.2216969-2-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/17/20 2:10 PM, Kent Overstreet wrote:
> This is prep work for changing generic_file_buffered_read() to use
> find_get_pages_contig() to batch up all the pagecache lookups.
> 
> This patch should be functionally identical to the existing code and
> changes as little as of the flow control as possible. More refactoring
> could be done, this patch is intended to be relatively minimal.

This is a sorely needed cleanup.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

