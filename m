Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2FB24241E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 04:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHLCoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 22:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgHLCoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:44:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085AC061787
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 19:44:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 17so260350pfw.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0tE7MUBsHJE0Mpx1+XVH5JlNGfMN16YjoWq2ffNV8zc=;
        b=iGUfgGuLhp5glfj9+Q0pWAZxeqRc+45tVwKSXeadF0a/5VRBYSXZvzBjI/pIVeGlaY
         r1jI++wR9oMMv/M07yVeSZEOdZVtzqAOPdYlBpG5XGo6OH0muGHWFxAVKCthjOlNRJHX
         3gx3vhWjA71m9uwrn2dkm1NM+Kssj/QgzRu1no70ml1wAF88WA6TohQ6gN+CZQ2619nx
         WK6o/OxsEA9Jet9ONq433Sq3fD5uD9HhGAIWPWZr3HaPHODpZlQOH3Serg9yTtSECxIi
         0Kxvea5B+5SHfJigBC5SznJ5QKK7G5jER/Rnuwx6So2XCjXpv/u+vIHqJgVAOFFBsloU
         o7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0tE7MUBsHJE0Mpx1+XVH5JlNGfMN16YjoWq2ffNV8zc=;
        b=Hpj0Jp0HoLV/ErZaz/fk/CSwm6kW/0zVFjF+H6sL8IXEnHWUmdtRhcdDAvQyl+QZiv
         2HaLKXHuVGf03ybXguJXGd5D3BOMi4ceCIAvbeOWKtzrF+yNi5p8TOSvnxYeMdWzyiJY
         pvpe2op6IF1NpX6FNflAG8M6Al7MZ4ViiznT/fO+AxWd8meJn6T6mz56MpSJ350QC81N
         GN5prgEFw0zsOtm4NXliF+BweCYwoVbDtjH0XSrjBCeK5Y25IwsSOculf9CyMmItSRKv
         Vn+G26Bmts6GiAoos37l8JsxgnY11pI7jPDOH6qQ95m5lYN71OAFwK0BPOzFwo6dRrip
         pcIw==
X-Gm-Message-State: AOAM531+/6n/76UIsUPPu7YfURJKj0DZiXJvq1H+0l/NzcVZan/eR/AG
        uviAAbhHnGr3rQiBHnahgsfOrA==
X-Google-Smtp-Source: ABdhPJxIC7s/N3U1+eyQRUwRFQ1XN7DSLT80VYkwubWr1q+bYuMwnlIB4hpElOY20MAM3xaNdrea/w==
X-Received: by 2002:a65:63d4:: with SMTP id n20mr3349103pgv.213.1597200253567;
        Tue, 11 Aug 2020 19:44:13 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 196sm455852pfc.178.2020.08.11.19.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 19:44:13 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in __io_req_task_submit
To:     syzbot <syzbot+3c72ce3136524268d7af@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000e5b60405aca4c517@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e6759a68-4789-e2de-30b4-8be0d34a099d@kernel.dk>
Date:   Tue, 11 Aug 2020 20:44:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000e5b60405aca4c517@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup: KASAN: use-after-free Read in io_async_task_func

-- 
Jens Axboe

