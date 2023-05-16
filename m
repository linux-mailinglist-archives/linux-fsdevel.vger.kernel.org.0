Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5BB70474B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 10:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjEPIFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEPIFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 04:05:17 -0400
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C844B0;
        Tue, 16 May 2023 01:05:14 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 2A0B360AC5;
        Tue, 16 May 2023 11:05:12 +0300 (MSK)
Received: from [IPV6:2a02:6b8:8f:4:7a31:c1ff:fef2:bf07] (unknown [2a02:6b8:8f:4:7a31:c1ff:fef2:bf07])
        by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id A5WFgX1OmGk0-7LFYAc0J;
        Tue, 16 May 2023 11:05:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1684224311; bh=F5bRoS4xpTyVs5DFCkErH3y1wwSu6rDSU3Adh9JEHxc=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=aWj+cMyK7wLaA426sbgLxmJI/jn353ehUh0W4FX9Qt5m3TfTpQAarrBB3ryPNv0qX
         xjFvuwwj5GHQF2ERpKOU8lfeIiSyMIJVG8+C8CXYxng6XyjTtQsAApcicaGG3f0t/W
         SJlqOaXQwOF8rzWBTP+JXWoMGxbQvkNW+wHgOJqc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <fa295ea1-d7ee-3f85-98be-f6a547fa13ce@yandex-team.ru>
Date:   Tue, 16 May 2023 11:05:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of
 O_RDWR
To:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ptikhomirov@virtuozzo.com, Andrey Ryabinin <arbn@yandex-team.com>
References: <20230420120409.602576-1-vsementsov@yandex-team.ru>
 <14af0872-a7c2-0aab-b21d-189af055f528@yandex-team.ru>
 <20230515-bekochen-ertrinken-ce677c8d9e6e@brauner>
 <CAHk-=wiRmfEmUWTcVPexUk50Ejgy4NCBE6HP84eckraMRrL6gQ@mail.gmail.com>
 <CAHk-=wjex4GE-HXFNPzi+xE+w2hkZTQrACgAaScNdf-8hnMHKA@mail.gmail.com>
Content-Language: en-US
From:   Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAHk-=wjex4GE-HXFNPzi+xE+w2hkZTQrACgAaScNdf-8hnMHKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.05.23 22:13, Linus Torvalds wrote:
> On Mon, May 15, 2023 at 11:50 AM Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
>>
>> It's strange, because the "O_WRONLY" -> "2" change that changes to a
>> magic raw number is right next to changing "(unsigned short) 0x10" to
>> "KERNEL_DS", so we're getting *rid* of a magic raw number there.
> 
> Oh, no, never mind. I see what is going on.
> 
> Back then, "open_namei()" didn't actually take O_RDWR style flags AT ALL.
> 
> The O_RDONLY flags are broken, because you cannot say "open with no
> permissions", which we used internally. You have
> 
>   0 - read-only
>   1 - write-only
>   2 - read-write
> 
> but the internal code actually wants to match that up with the
> read-write permission bits (FMODE_READ etc).
> 
> And then we've long had a special value for "open for special
> accesses" (format etc), which (naturally) was 3.
> 
> So then the open code would do
> 
>          f->f_flags = flag = flags;
>          f->f_mode = (flag+1) & O_ACCMODE;
>          if (f->f_mode)
>                  flag++;
> 
> which means that "f_mode" now becomes that FMODE_READ | FMODE_WRITE
> mask, and "flag" ends up being a translation from that O_RDWR space
> (0/1/2/3) into the FMODE_READ/WRITE space (1/2/3/3, where "special"
> required read-write permissions, and 0 was only used for symlinks).
> 
> We still have that, although the code looks different.
> 
> So back then, "open_namei()" took that FMODE_READ/WRITE flag as an
> argument, and the  "O_WRONLY" -> "2" change is actually a bugfix and
> makes sense. The O_WRONLY thing was wrong, because it was 1, which
> actuall ymeant FMODE_READ.
> 
> And back then, we didn't *have* FMODE_READ and FMODE_WRITE.
> 
> So just writing it as "2" made sense, even if it was horrible. We
> added FMODE_WRITE later, but never fixed up those core file writers.
> 
> So that 0.99pl10 commit from 1993 is actually correct, and the bug
> happened *later*.
> 
> I think the real bug may have been in 2.2.4pre4 (February 16, 1999),
> when this happened:
> 
> -       dentry = open_namei(corefile,O_CREAT | 2 | O_TRUNC | O_NOFOLLOW, 0600);
> ...
> +       file = filp_open(corefile,O_CREAT | 2 | O_TRUNC | O_NOFOLLOW, 0600);
> 
> without realizing that the "2" in open_namei() should have become a
> O_WRONLY for filp_open().
> 
> So I think this explains it all.
> 
> Very understandable mistake after all.
> 
>                      Linus

Wow that's became a detective story, great thanks! [took note to check history myself next time]

-- 
Best regards,
Vladimir

