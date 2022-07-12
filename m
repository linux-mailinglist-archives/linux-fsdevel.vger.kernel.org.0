Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F575726F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 22:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiGLUIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiGLUIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:08:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5E03BB
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 13:08:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a15so9030746pjs.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Lqpato/f28eA3XrWVfglz0yLW5AQKseXQr9k0rsUFA=;
        b=AOS1c0MnsFBWYlHDV3+MxRFb4d7gp80FtjneMJJL/D2A2H8UNFY0SMd83YCafnLUpe
         et/ra3hUgxEdRTj4OKLEDcRGRBiWSGrcK+q/tDN5LX+bcUcyqeluuU6LHYdHr2wg76wQ
         qSC+xtb1eYsd4b4QeXbV9tEcluq35ki7YyHS710UlKz3xd+44bfreIC+dRnZkHrC2kIo
         7dHHaOMbWGfXwsICl1pqj5Ya7hUNrjMvJjZ74qw8ImFoPxsnJIJn3JnFoefsqif7fJgP
         ngEKrL0UROOhR6GHg9oAFJPlBTqBd0PvvO0vEYgRM2TV9q2jgZrxDlGICNnAT0zfysAN
         hpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Lqpato/f28eA3XrWVfglz0yLW5AQKseXQr9k0rsUFA=;
        b=KBowLthH8lSHEWXlXZBsf28UT+g26tDjiyr1u/aJqrSrdhtaDZuRl7oWQhW0YlvYOU
         Nh8ZWX/V1qvWJirbzBohLfjBtD/kpyHebT5Yv4eL8hbGIPBio2NzpZXlFVMPldfnnxcR
         Uq4UyrVQd2clLRF9RuZCZsTAQU7IL8xMbs3ML+mjqxGmg+1GltIau6+n6lBcIHQ8FMr6
         iEkUZOW9y5faIC0uwx24JDmmJat4hfefxY/oKSaRZhO3XicW64UYp11VkqtkvUmhfp8A
         XWEg1TjFVhmM4vTmppHOXLTb4KqdnWxfHLEG7pT0QEdUSX90ob05kyb6lYo+YMaqasW9
         zt4A==
X-Gm-Message-State: AJIora+56uNOwqwOmLcfi99LnY9fH70RXkOkyIS+0YSLjOCjwxc+Wc+P
        kI3KmBLnBxstNF2AGkZGie4fvdscGYt4Yw==
X-Google-Smtp-Source: AGRyM1tVNec+WUDrx8OTAhKe8cXaZzH+MyRRdelXOlWxsLuJI04HBOCf5joSuyHVSN+utVixIgIYlA==
X-Received: by 2002:a17:903:1c4:b0:16c:4e45:38a3 with SMTP id e4-20020a17090301c400b0016c4e4538a3mr10888515plh.41.1657656511314;
        Tue, 12 Jul 2022 13:08:31 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d124-20020a623682000000b00528d4f647f2sm7461362pfa.91.2022.07.12.13.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 13:08:30 -0700 (PDT)
Message-ID: <149a582d-500b-611f-ce64-7c697ba9c0a2@kernel.dk>
Date:   Tue, 12 Jul 2022 14:08:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCHv2 1/3] block: ensure iov_iter advances for added pages
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>
References: <20220712153256.2202024-1-kbusch@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220712153256.2202024-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/12/22 9:32 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There are cases where a bio may not accept additional pages, and the iov
> needs to advance to the last data length that was accepted. The zone
> append used to handle this correctly, but was inadvertently broken when
> the setup was made common with the normal r/w case.

Al, how do you want to handle this? I currently see you have that
block-fixes branch, but I don't see anything depending on it. I can do
one of the following with these three fixes:

1) Apply them on top of for-5.20/block
2) Apply them to a new branch off the tag I made for you

And that still leaves the question of what will happen with your
block-fixes branch. Did you want me to pull that in? Or?

-- 
Jens Axboe

