Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E100423CF24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgHETOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHETMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:12:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438D7C06138F
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2020 12:10:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so25938657plk.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2020 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/BPxTQP7JYvXtVQk0ki81teqlb2JaRXEp1ARBXZnsKo=;
        b=BZyj8tQZ0jh5Oos+bACAQdHzM8BctEVB1nm/RUpKxUQ6Pi6G9SvTFeD7fBZ/X6lfVI
         FkEJ/WjkqHZlKv6fs1JF+djzVBcU9No5gkz3vxU0yeAYZg6d4i9kwLBmPh3V4BN9RclB
         zTSxsjl5UmQZ3wGmv+ar3sNRei7z2zx0aTBPLAJrM8lq2oHQ27xaltidycvB+G9bYUaR
         iPPkoe5114KZNWhvTOaH3rhFgeMCltmUtlYFwAd/c5ctZi1gdsQ0E0v/X7k+i7g+xyTm
         JUxqfiNWjVM174YYeHWS7YFZ5kytejVTaFOyGZHdu4NYhmfkoZnYnf3xaO34Fv5Opblj
         Nqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/BPxTQP7JYvXtVQk0ki81teqlb2JaRXEp1ARBXZnsKo=;
        b=SGEn7E/7EMXKVYeLxZdIsCeqeLWJDlIEDv3rnEval7m3iJ4xBMhVJh1uq7Na7kKP4q
         U63icBUD+Oe7uNFtCNoZ8GBPQXqiKoAJ8bIKmFyJxBgmhdVADKYq2edJAWEZZ8iGTztS
         V6WzTPPWaM/8Ju+An5haMa4866t3dluKYTm1ZrjnLMJS25ZRPgr2Zqb+W86H5OxUlz9r
         kwtQs+ffCdwVR9iwq3Mow5vQGbu4MxrHoEvyhDnOrG9Br5oX5+GH8IhnidfhIl8Iinpq
         dHMT+8lq3voGXIPogZnMjSIBkDS9FGjnawTx7Mh75TTAdWRoO034yOU1nqqY6syuVcAO
         6sbA==
X-Gm-Message-State: AOAM530HYJRzWs8ZE8FSZVysWKtSO22sWMwlMBAOnNbk82lAr5YqD0nx
        vRyGI5qiYEcb/CDYlwjZES0hjEBes5k=
X-Google-Smtp-Source: ABdhPJxBxqd+46Ue4ysKapAHTBKv3UWlsAyzGfbE/liq0Ut6moG79tcjnHZxH6I+Zn1xfkVM57hEQA==
X-Received: by 2002:a17:90a:77ca:: with SMTP id e10mr4434931pjs.150.1596654655824;
        Wed, 05 Aug 2020 12:10:55 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s125sm5061242pfc.63.2020.08.05.12.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:10:55 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Fix use-after-free in io_sq_wq_submit_work()
To:     Guoyu Huang <hgy5945@gmail.com>, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200805034042.GA29805@ubuntu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4e1b9ee-1b13-9862-8df8-cdad62821715@kernel.dk>
Date:   Wed, 5 Aug 2020 13:10:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805034042.GA29805@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/4/20 9:40 PM, Guoyu Huang wrote:
> when ctx->sqo_mm is zero, io_sq_wq_submit_work() frees 'req'
> without deleting it from 'task_list'. After that, 'req' is
> accessed in io_ring_ctx_wait_and_kill() which lead to
> a use-after-free.

This looks like an old one, that affects 5.4 only. I've massaged
it to apply on top of another fix, will ask to get it queued up for
stable. Thanks!

-- 
Jens Axboe

