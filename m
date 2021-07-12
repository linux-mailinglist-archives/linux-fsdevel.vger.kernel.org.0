Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961823C4112
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 03:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhGLBqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 21:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhGLBqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 21:46:47 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93E5C0613E5
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jul 2021 18:43:59 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y6so16686362ilj.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jul 2021 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RTuDL6SVYCLI423vVccxizGVyS3rt2KIcAV15XDzGzI=;
        b=Iy8gHot3nMTszekx8HnQtH7Fk2icBirqlwxpvVx7UYeOpMxIEGYDRWAuD+2NaE3can
         rdmJFl6LPl96vBiUQExYVaha3L1/RTPQdJwRBOkVgwjac3v6ZHPLBzs0qHpZ0BT5F7Ja
         qCBobAy4u3jVyNYEln4WJ6fYBH7UGzkjZ6PpvJqe9scP7ZLVX5HXqD3h39W0zr6Z+m3B
         kjx4FetoDtwALrU4q5a9abnZduhJvXMDbPPyWkE7lkJuiCEWVOyFREdWJHKGmNNI/xiu
         T/ncI7Pk4UhCWzCe4kDFuJqcN2GzzztaF4WDBVd1v3QjUv8L/ophJzqlbCZxNlAhN8vs
         Qjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RTuDL6SVYCLI423vVccxizGVyS3rt2KIcAV15XDzGzI=;
        b=TivNOLkg+MFWADYGkDt0/edD45y+nfZxlzkfYa8C+JAc/ODTvjE2XQFBwska7Zi0pN
         rLuPfHG9w7NaqPPH4WWhvbVsXpUpSmcr+gsoO0XI72rMloC0hTmnZKjCTieGEv5+dbgb
         uYdpVlo0TJe+AtAVbGhnb37BMBik5Sokhagw4/NQwpXdYjgZmT6g5YTWvGOeFE4USG4J
         XWSpTbwXwfyLH8+TVqt0MDdfGTzfsmXyJIXetLpZ5YcYNTGe3n2afUtuZx5WSHV/ITun
         1D38Yrs3a7C33y1Q2T1RfrreVdHWBW5ngJD9Qse1ElqPHhTSpUK4nRmTBFQzxbD3yBPW
         ZpmA==
X-Gm-Message-State: AOAM530FRDvTp5eMDf4nFLb8Zb4vdcCMa/8nZ+fas2r3zwx8ROdUBjbe
        lO30ikkpbKthtUitL3cbaM0xZQ==
X-Google-Smtp-Source: ABdhPJxSo6fiS2R0gzDEECzHhrjn/3TAJv4OPfzafzxwq3RYA5hFlUIGf6ylmSyNjZdQKyu21ePNoQ==
X-Received: by 2002:a92:c8c3:: with SMTP id c3mr19234399ilq.153.1626054239327;
        Sun, 11 Jul 2021 18:43:59 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id z6sm1110473ilz.54.2021.07.11.18.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 18:43:58 -0700 (PDT)
Subject: Re: [PATCH 0/2] Close a hole where IOCB_NOWAIT reads could sleep
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
References: <20210711150927.3898403-1-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a3d0f8da-ffb4-25a3-07a1-79987ce788c5@kernel.dk>
Date:   Sun, 11 Jul 2021 19:44:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210711150927.3898403-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/11/21 9:09 AM, Matthew Wilcox (Oracle) wrote:
> I noticed a theoretical case where an IOCB_NOWAIT read could sleep:
> 
> filemap_get_pages
>   filemap_get_read_batch
>   page_cache_sync_readahead
>     page_cache_sync_ra
>       ondemand_readahead
>         do_page_cache_ra
>         page_cache_ra_unbounded
>           gfp_t gfp_mask = readahead_gfp_mask(mapping);
>           memalloc_nofs_save()
>           __page_cache_alloc(gfp_mask);
> 
> We're in a nofs context, so we're not going to start new IO, but we might
> wait for writeback to complete.  We generally don't want to sleep for IO,
> particularly not for IO that isn't related to us.
> 
> Jens, can you run this through your test rig and see if it makes any
> practical difference?

You bet, I'll see if I can trigger this condition and verify we're no
longer blocking on writeback. Thanks for hacking this up.

-- 
Jens Axboe

