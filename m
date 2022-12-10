Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5128964901F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 19:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLJSOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 13:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJSOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:14:52 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D6910FCF
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:14:50 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id g7so6031191qts.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VAo0x5xhqqcXYMWSZ9//NhlYxIojexYjst7kH6iIHEA=;
        b=N2ZduiZNI5BT5XE4Hac/IzHUbFcJyJjdq+4hupSQHWVebZW/BwBwJtDM3oLQUfwlAN
         UiqgQ6hurC/0Vf8TBlfxPNcuLhrJlusW6wY5jnPJgfUsfft8zFa55Ye2JRP2Q/9cIpLe
         RPlBpYYePUebb+L375o+f6C/R3oj5zrG54Mw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAo0x5xhqqcXYMWSZ9//NhlYxIojexYjst7kH6iIHEA=;
        b=590LwlXe44TbRr+vcOSQBl8AeLLceK2a2P1C6dPRWz79xDKUht9LrBur3Efav+eNga
         JOftOe5uj2L5+zNKhXPusgL33TsB/gLDIVcKXEiHgdPIO6rwkW/3yx9H2HYjOkMCIPpJ
         30/3sMVksyNSku44zcwfTBfOZn9P7ktTHsyC9faqebbtTjmXkPCXIYArA62qiejZICQ5
         ms5J2UmsxmAD0WjBzCQ44Dl6390gfvElMgH10G6vaGjFAt7YruiQU63xfm/8HMv563ri
         5T2rY84oEmR+lXKDrI7JhfRJ0Qx7AcQIXI6KFXRKkL/JxKhAfCq9jTxDfklrpVDGu3sv
         2XPA==
X-Gm-Message-State: ANoB5pm33s8JUV21XYZi7mlzc9PuvIOtbP4UPjG1sLd3tX5W54B3k81Y
        oZElyh5tWtREf5FLm1pXbNH9o8plK2zCqc+6
X-Google-Smtp-Source: AA0mqf7oDQWqjgwW9KTodP5LwCb6evPqJuPEu7ta/Wvy8cw4fGzqCW2UmHg1Bi1wkED/xY7ob+dwzQ==
X-Received: by 2002:ac8:53d5:0:b0:3a6:2197:5208 with SMTP id c21-20020ac853d5000000b003a621975208mr13534831qtq.17.1670696089637;
        Sat, 10 Dec 2022 10:14:49 -0800 (PST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b006fab416015csm2498317qkg.25.2022.12.10.10.14.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 10:14:48 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id pe2so1076469qkn.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:14:48 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10295204qkg.594.1670696087700; Sat, 10
 Dec 2022 10:14:47 -0800 (PST)
MIME-Version: 1.0
References: <9f6a8d1a-aa05-626d-6764-99c376722ed7@kernel.dk>
 <CAHk-=wgqkWVi3nm6HJvOOy+GUVmPt9Wun+_ZVp47wZU43FET9w@mail.gmail.com> <b2785384-dfc3-a073-523f-4cbf5610f005@kernel.dk>
In-Reply-To: <b2785384-dfc3-a073-523f-4cbf5610f005@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Dec 2022 10:14:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whi+0Kjd+QgUQwuWZaGmmc5x1Fdxi_VsobWkJnM+o7WSA@mail.gmail.com>
Message-ID: <CAHk-=whi+0Kjd+QgUQwuWZaGmmc5x1Fdxi_VsobWkJnM+o7WSA@mail.gmail.com>
Subject: Re: [GIT PULL] Writeback fix
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 10, 2022 at 10:11 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Just to be clear, this was deliberately held for the 6.2 merge window,
> but I can also see that I completely missed that in the pull request.
> Sorry about that, that should've been clear.

Oh, it looked very much like a "lastminute single fix for 6.1".

Your other pull requests are in my "for 6.2" queue.

                 Linus
