Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B6527EDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 09:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbiEPHvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiEPHvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 03:51:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465CC27151
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 00:51:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a23so8983781ljd.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 00:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GRi7qYL5MFc9IxtC0M2IySOujCHuQhCkovUyzI0O1/M=;
        b=AYmqXQfiZvO+PSvh6p7ZagVdULQKEc55/HGpL8DVoU7zWasDNN7MRWr9s6eXJsas+k
         54SMOc2TjBqwR/vMiUGLXOVi5GuvpwPg+cRy+zO4jbOdXDEZQp3D+IoeDIkpi01sHfyd
         80EmsXgpetDsKENZc7lqGlbcGt7Fnwi9M+MaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GRi7qYL5MFc9IxtC0M2IySOujCHuQhCkovUyzI0O1/M=;
        b=eissWWns/EN3RbNN8FwP/gAJEw1p95Si2kJeT/pbBwmeDUp+DS6J5hTJ3WJnhm7t+p
         RU9V4RHgfik8lxG+9vU3wmOlgAN6zsLwzrmGYCogC5m4pkq7R/UIkrVymvKq//Gwybkb
         ZwqZoxBmQk/MKSI2YqwvdZmmLHRwdng/238jHIzxKbWu8YNKVplR81TuXwBsUUT8p43y
         iRZwWCvfD8bPC3kiYKRLzgOMGdlgndy3+lFUehSn771YbIxzGkWfHW+iUi75iKrOFxS4
         IwwSK5zDeEG5l7OIqR+Iu6YBvmLIb8zbnMzuaIwQKEdHN7HtrNccctu0RQFYx+DgmV9z
         Nhww==
X-Gm-Message-State: AOAM530qIe+8Yv1mrkb9wCabCe3OAL1ScQigIVnKMqH4+GcBYODmy/jo
        P2hIqDHVyP9nNlZ86iFlDtf6hw==
X-Google-Smtp-Source: ABdhPJxV5cvrNAbkftxXsfZ+nU4/40IBBNOdVATlavKOPi3ophjm2KcqQElJ4eiCj32YbcKhSsgp9g==
X-Received: by 2002:a2e:82cd:0:b0:24b:4a69:790b with SMTP id n13-20020a2e82cd000000b0024b4a69790bmr10416425ljh.326.1652687472586;
        Mon, 16 May 2022 00:51:12 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f4-20020a056512092400b0047255d211desm1226591lft.269.2022.05.16.00.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 00:51:12 -0700 (PDT)
Message-ID: <2ff479df-1f88-ecd0-8a0e-7d31ab02ca0d@rasmusvillemoes.dk>
Date:   Mon, 16 May 2022 09:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
 <CAOQ4uxjOOe0aouDYNdkVyk7Mu1jQ-eY-6XoW=FrVRtKyBd2KFg@mail.gmail.com>
 <Uc-5mYLV3EgTlSFyEEzmpLvNdXKVJSL9pOSCiNylGIONHoljlV9kKizN2bz6lHsTDPDR_4ugSxLYNCO7xjdSeF3daahq8_kvxWhpIvXcuHA=@emersion.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Uc-5mYLV3EgTlSFyEEzmpLvNdXKVJSL9pOSCiNylGIONHoljlV9kKizN2bz6lHsTDPDR_4ugSxLYNCO7xjdSeF3daahq8_kvxWhpIvXcuHA=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/05/2022 14.38, Simon Ser wrote:
> On Thursday, May 12th, 2022 at 14:30, Amir Goldstein <amir73il@gmail.com> wrote:
> 
>> Clients can also readlink("/proc/self/fd/<fd>") to get the path of the file
>> and open it from its path (if path is accessible in their mount namespace).
> 
> What the compositor does is:
> 
> - shm_open with O_RDWR
> - Write the kyeboard keymap
> - shm_open again the same file with O_RDONLY
> - shm_unlink
> - Send the O_RDONLY FD to clients
> 
> Thus, the file doesn't exist anymore when clients get the FD.

So, what happens if you do fchmod(fd, 0400) on the fd before passing it
to the client [1].

I assume the client is not running as the same uid as the compositor (so
it can't fchmod() the inode back); if it is, then it could just ptrace
you and all bets are off.

[1] or for that matter, simply specify 0400 as the mode argument when
creating the file - that's perfectly legal to do in conjunction with
O_RDWR | O_CREAT | O_EXCL, and should probably be done to prevent
anybody else from opening the same shm file with write permission before
it gets shm_unlinked.

Rasmus
